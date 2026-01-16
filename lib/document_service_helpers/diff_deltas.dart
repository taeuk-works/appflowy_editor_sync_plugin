import 'dart:convert';

import 'package:dart_quill_delta/dart_quill_delta.dart';

import '../utils/debug_print_custom.dart';

String diffDeltas(String oldDelta, String newDelta) {
  try {
    final prevDelta = Delta.fromJson(jsonDecode(oldDelta) as List<dynamic>);
    final delta = Delta.fromJson(jsonDecode(newDelta) as List<dynamic>);

    final oldText = _extractTextFromDelta(prevDelta);

    // Compute the diff using character-based positions
    final diff = prevDelta.diff(delta);

    // Adjust for UTF-16 code units
    final adjustedDiff = _adjustForUtf16CodeUnits(diff, oldText);

    return jsonEncode(adjustedDiff.toJson());
  } catch (e) {
    debugPrintCustom('Error in diffDeltas: $e');
    return '[]'; // Fallback to empty delta
  }
}

// --- Helpers ---

String _extractTextFromDelta(Delta delta) {
  return delta.toList().where((op) => op.isInsert).map((op) => op.data).join();
}

Delta _adjustForUtf16CodeUnits(Delta diff, String sourceText) {
  final codePointToCodeUnit = buildCharToUtf8Map(sourceText);
  final operations = <Operation>[];
  var currentCodePoint = 0;

  for (final op in diff.toList()) {
    if (op.isRetain || op.isDelete) {
      final opLength = op.length ?? 0;
      final endCodePoint = currentCodePoint + opLength;

      // Validate bounds
      if (endCodePoint > codePointToCodeUnit.length - 1) {
        throw StateError('Operation exceeds text length');
      }

      // Convert code points to code units
      final startCodeUnit = codePointToCodeUnit[currentCodePoint];
      final endCodeUnit = codePointToCodeUnit[endCodePoint];
      final adjustedLength = endCodeUnit - startCodeUnit;
      // Add adjusted operation
      if (op.isRetain) {
        operations.add(Operation.retain(adjustedLength, op.attributes));
      } else {
        operations.add(Operation.delete(adjustedLength));
      }

      currentCodePoint += opLength;
    } else if (op.isInsert) {
      operations.add(op); // Insertions don't need adjustment
    }
  }

  return Delta.fromOperations(operations);
}

// Map character positions to their byte positions in UTF-8
List<int> buildCharToUtf8Map(String text) {
  final map = <int>[0]; // Start at byte index 0
  var bytePos = 0;

  for (var i = 0; i < text.length; i++) {
    final char = text[i];
    final charBytes = utf8.encode(char);
    bytePos += charBytes.length;
    map.add(bytePos);
  }

  return map;
}
