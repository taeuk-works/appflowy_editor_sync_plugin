// ignore_for_file: public_member_api_docs, sort_constructors_first
// document_sync_db.dart
import 'dart:async';
import 'dart:typed_data';

import 'package:appflowy_editor_sync_plugin/core/delay_remove_batcher.dart';
import 'package:appflowy_editor_sync_plugin/document_service_helpers/document_service_wrapper.dart';
import 'package:appflowy_editor_sync_plugin/types/sync_db_attributes.dart';
import 'package:appflowy_editor_sync_plugin/types/update_types.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import 'utils/debug_print_custom.dart';

class DocumentSyncDB {
  DocumentSyncDB({
    required this.docService,
    required this.syncAttributes,

    this.updatesBatcherDebounceDuration = const Duration(milliseconds: 500),
  }) {
    _initBatcher();
  }
  final DocumentServiceWrapper docService;
  final SyncAttributes syncAttributes;
  final Duration updatesBatcherDebounceDuration;

  late final syncId = Uuid().v4();

  //I need to keep track of already sended updates in order to avoid sending them again
  //Each update is identified by id

  late final updatesBatcher = DelayedRemoveBatcher<LocalUpdate>(
    debounceDuration: updatesBatcherDebounceDuration,
    removalDelay: const Duration(seconds: 5),
  );

  // Add this field to your class
  late final BehaviorSubject<(List<LocalUpdate>, List<DbUpdate>)>
  _updatesSubject;

  // Add this field to track the subscription
  StreamSubscription<(List<LocalUpdate>, List<DbUpdate>)>? _updatesSubscription;

  Future<void> dispose() async {
    try {
      // Cancel the subscription if it exists
      await _updatesSubscription?.cancel();

      // Save all unsaved updates to DB
      final allItems = updatesBatcher.getAllUnprocessedItems();
      if (allItems.isNotEmpty) {
        debugPrintCustom('Saving ${allItems.length} pending updates during disposal');
        final mergedUpdate = await docService.mergeUpdates(
          allItems.map((u) => u.update).toList(),
        );
        await _addUpdateToDB(mergedUpdate);
        debugPrintCustom('Successfully saved all pending updates');
      }
    } catch (e) {
      debugPrintCustom('Error saving updates during disposal: $e');
      // Consider additional error handling or recovery here
    } finally {
      updatesBatcher.dispose();
      _updatesSubject.close();
    }
  }

  // Initialize the batcher with callback in constructor
  void _initBatcher() {
    updatesBatcher.onBatchReady((updates) async {
      try {
        final mergedUpdate = await docService.mergeUpdates(
          updates.map((u) => u.update).toList(),
        );
        await _addUpdateToDB(mergedUpdate);
        return true;
      } catch (e) {
        debugPrintCustom('Error processing update batch: $e');
        return false;
      }
    });

    // Initialize the BehaviorSubject
    _updatesSubject = BehaviorSubject<(List<LocalUpdate>, List<DbUpdate>)>();

    // Connect the stream to the subject and store the subscription
    _updatesSubscription = _getAllUpdatesStream().listen(_updatesSubject.add);
  }

  //Get updates stream - that will combine updates from the DB with updates from the batcher
  Stream<(List<LocalUpdate>, List<DbUpdate>)> getAllUpdatesStream() {
    return _updatesSubject.stream;
  }

  //Get updates stream - that will combine updates from the DB with updates from the batcher
  Stream<(List<LocalUpdate>, List<DbUpdate>)> _getAllUpdatesStream() {
    final dbUpdatesStream = syncAttributes.getUpdatesStream;

    final batcherUpdatesStream = updatesBatcher.getAllItems();

    // Combine both streams using Rx.combineLatest2
    return Rx.combineLatest2(dbUpdatesStream, batcherUpdatesStream, (
      List<DbUpdate> dbUpdates,
      List<LocalUpdate> batcherUpdates,
    ) {
      return (batcherUpdates, dbUpdates);
    });
  }

  // Update your getLastUpdates method
  (List<LocalUpdate>, List<DbUpdate>)? getLastUpdates() {
    if (!_updatesSubject.hasValue) {
      // Return a default value or null
      return ([], []); // Empty default
    }
    return _updatesSubject.value;
  }

  Future<void> _addUpdateToDB(Uint8List update) async {
    syncAttributes.saveUpdate(update);
  }

  void addUpdate(LocalUpdate update) {
    updatesBatcher.addValue(update);
  }

  void addUpdates(List<LocalUpdate> updates) {
    updatesBatcher.addValues(updates);
  }

  Future<List<DbUpdate>> getInitialUpdates() async {
    return syncAttributes.getInitialUpdates();
  }

  String localUpdatesLastModificationId() {
    return updatesBatcher.lastModificationId;
  }
}
