import 'dart:async';
import 'dart:typed_data';

import 'package:appflowy_editor_sync_plugin/src/rust/doc/document_service.dart';
import 'package:appflowy_editor_sync_plugin/src/rust/doc/document_types.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mutex/mutex.dart'; // Import the mutex library

// Wrapper class to handle mutex synchronization on the Dart side using the mutex library
class DocumentServiceWrapper {
  // Use mutex library for thread-safe locking

  DocumentServiceWrapper._(this._rustService);
  final DocumentService _rustService;
  final Mutex _mutex = Mutex();

  // Factory constructor to create a new instance with mutex handling
  // This uses flutter_rust_bridge's generated method
  static Future<DocumentServiceWrapper> newInstance() async {
    final rustService = await DocumentService.newInstance();
    return DocumentServiceWrapper._(rustService);
  }

  //Return if the mutex is available now
  bool isMutexNotAvailable() {
    return _mutex.isLocked;
  }

  @override
  Future<Option<Uint8List>> applyAction({
    required List<BlockActionDoc> actions,
  }) async {
    try {
      // Acquire the mutex lock asynchronously
      await _mutex.acquire();
      final res = await _rustService.applyAction(actions: actions);
      return Option.of(res);
    } catch (e) {
      // Handle any errors from Rust, including ConcurrentAccessError

      print('Failed to apply action: $e');
      return const None();
    } finally {
      // Release the mutex lock
      _mutex.release();
    }
  }

  /// Setting a root node id in the root map
  Future<Option<Uint8List>> setRootNodeId({required String id}) async {
    try {
      // Acquire the mutex lock asynchronously
      await _mutex.acquire();
      final res = await _rustService.setRootNodeId(id: id);
      return Option.of(res);
    } catch (e) {
      // Handle any errors from Rust, including ConcurrentAccessError

      print('Failed to set root id: $e');
      return const None();
    } finally {
      // Release the mutex lock
      _mutex.release();
    }
  }

  @override
  Future<Either<Error, Unit>> applyUpdates({
    required List<Uint8List> update,
  }) async {
    try {
      await _mutex.acquire();
      await _rustService.applyUpdates(updates: update);
      return Either.right(unit);
    } catch (e) {
      print('Failed to apply updates: $e');
      return Either.left(Error());
    } finally {
      _mutex.release();
    }
  }

  @override
  Future<DocumentState> getDocumentJson() async {
    try {
      await _mutex.acquire();
      return await _rustService.getDocumentState();
    } catch (e) {
      throw Exception('Failed to get document JSON: $e');
    } finally {
      _mutex.release();
    }
  }

  @override
  Future<Uint8List> initEmptyDoc() async {
    try {
      await _mutex.acquire();
      return await _rustService.initEmptyDoc();
    } catch (e) {
      throw Exception('Failed to initialize empty document: $e');
    } finally {
      _mutex.release();
    }
  }

  /// 현재 문서의 전체 상태를 인코딩하여 반환
  Future<Uint8List> encodeFullState() async {
    try {
      await _mutex.acquire();
      return await _rustService.encodeFullState();
    } catch (e) {
      throw Exception('Failed to encode full state: $e');
    } finally {
      _mutex.release();
    }
  }

  //Write override for mergeUpdates
  Future<Uint8List> mergeUpdates(List<Uint8List> updates) async {
    //There is no need to acquire the mutex lock here. Because it doesn't use the editor at all.
    try {
      return await _rustService.mergeUpdates(updates: updates);
    } catch (e) {
      throw Exception('Failed to merge updates: $e');
    } finally {}
  }

  // ============================================
  // Meta API - YDoc 메타데이터 조작 메서드들
  // ============================================

  /// 모든 메타데이터를 JSON 문자열로 반환
  ///
  /// 반환: JSON 형식의 메타데이터 (예: {"title": "노트", "color": 123})
  Future<String> getAllMeta() async {
    try {
      await _mutex.acquire();
      return await _rustService.getAllMeta();
    } catch (e) {
      throw Exception('Failed to get all meta: $e');
    } finally {
      _mutex.release();
    }
  }

  /// 메타데이터에 문자열 값 설정
  ///
  /// [key] 메타데이터 키
  /// [value] 설정할 문자열 값
  /// 반환: CRDT update (저장용)
  Future<Option<Uint8List>> setMetaString({
    required String key,
    required String value,
  }) async {
    try {
      await _mutex.acquire();
      final res = await _rustService.setMetaString(key: key, value: value);
      return Option.of(res);
    } catch (e) {
      print('Failed to set meta string: $e');
      return const None();
    } finally {
      _mutex.release();
    }
  }

  /// 메타데이터에 정수 값 설정
  ///
  /// [key] 메타데이터 키
  /// [value] 설정할 정수 값
  /// 반환: CRDT update (저장용)
  Future<Option<Uint8List>> setMetaInt({
    required String key,
    required int value,
  }) async {
    try {
      await _mutex.acquire();
      final res = await _rustService.setMetaInt(key: key, value: value);
      return Option.of(res);
    } catch (e) {
      print('Failed to set meta int: $e');
      return const None();
    } finally {
      _mutex.release();
    }
  }

  /// 메타데이터에 불리언 값 설정
  ///
  /// [key] 메타데이터 키
  /// [value] 설정할 불리언 값
  /// 반환: CRDT update (저장용)
  Future<Option<Uint8List>> setMetaBool({
    required String key,
    required bool value,
  }) async {
    try {
      await _mutex.acquire();
      final res = await _rustService.setMetaBool(key: key, value: value);
      return Option.of(res);
    } catch (e) {
      print('Failed to set meta bool: $e');
      return const None();
    } finally {
      _mutex.release();
    }
  }

  /// 메타데이터에 문자열 배열 설정 (기존 배열 전체 교체)
  ///
  /// [key] 메타데이터 키
  /// [values] 설정할 문자열 배열
  /// 반환: CRDT update (저장용)
  Future<Option<Uint8List>> setMetaStringArray({
    required String key,
    required List<String> values,
  }) async {
    try {
      await _mutex.acquire();
      final res =
          await _rustService.setMetaStringArray(key: key, values: values);
      return Option.of(res);
    } catch (e) {
      print('Failed to set meta string array: $e');
      return const None();
    } finally {
      _mutex.release();
    }
  }

  /// 메타데이터 배열에 문자열 항목 추가 (중복 체크)
  ///
  /// [key] 메타데이터 키
  /// [value] 추가할 문자열 값
  /// 반환: CRDT update (저장용)
  Future<Option<Uint8List>> pushMetaArrayItem({
    required String key,
    required String value,
  }) async {
    try {
      await _mutex.acquire();
      final res =
          await _rustService.pushMetaArrayItem(key: key, value: value);
      return Option.of(res);
    } catch (e) {
      print('Failed to push meta array item: $e');
      return const None();
    } finally {
      _mutex.release();
    }
  }

  /// 메타데이터 배열에서 문자열 항목 제거
  ///
  /// [key] 메타데이터 키
  /// [value] 제거할 문자열 값
  /// 반환: CRDT update (저장용)
  Future<Option<Uint8List>> removeMetaArrayItem({
    required String key,
    required String value,
  }) async {
    try {
      await _mutex.acquire();
      final res =
          await _rustService.removeMetaArrayItem(key: key, value: value);
      return Option.of(res);
    } catch (e) {
      print('Failed to remove meta array item: $e');
      return const None();
    } finally {
      _mutex.release();
    }
  }

  /// 메타데이터 키 제거
  ///
  /// [key] 제거할 메타데이터 키
  /// 반환: CRDT update (저장용)
  Future<Option<Uint8List>> removeMetaKey({required String key}) async {
    try {
      await _mutex.acquire();
      final res = await _rustService.removeMetaKey(key: key);
      return Option.of(res);
    } catch (e) {
      print('Failed to remove meta key: $e');
      return const None();
    } finally {
      _mutex.release();
    }
  }

  /// 여러 메타데이터 필드를 한 번에 설정 (JSON 입력)
  ///
  /// [jsonStr] 설정할 메타데이터 JSON (예: {"title": "노트", "status": "active"})
  /// 지원 타입: string, number (int/double), boolean, string array
  /// 반환: CRDT update (저장용)
  Future<Option<Uint8List>> setMetaFromJson({required String jsonStr}) async {
    try {
      await _mutex.acquire();
      final res = await _rustService.setMetaFromJson(jsonStr: jsonStr);
      return Option.of(res);
    } catch (e) {
      print('Failed to set meta from json: $e');
      return const None();
    } finally {
      _mutex.release();
    }
  }
}
