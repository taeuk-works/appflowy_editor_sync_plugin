import 'package:flutter/foundation.dart';

/// Sync plugin 로그 활성화 여부 (외부에서 설정 가능)
bool enableSyncPluginLogs = false;

/// 디버그 모드이고 enableSyncPluginLogs가 true일 때만 로그 출력
void debugPrintCustom(String text) {
  if (kDebugMode && enableSyncPluginLogs) {
    debugPrint(text);
  }
}
