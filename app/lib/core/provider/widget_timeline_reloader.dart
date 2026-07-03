import 'dart:io';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter/services.dart';

const _widgetChannel = MethodChannel('net.yumnumm.eqmonitor/widget');

/// iOS ホーム画面ウィジェットのタイムラインを再読み込みさせる。
///
/// App Group UserDefaults の内容を更新したあとに呼ぶと、ネイティブ側
/// (`WidgetCenter.shared.reloadAllTimelines()`) が新しい設定でウィジェットを
/// 再描画する。iOS 以外・チャネル未登録時は握りつぶす。
Future<void> reloadWidgetTimelines() async {
  if (!Platform.isIOS) {
    return;
  }
  try {
    await _widgetChannel.invokeMethod<void>('reloadTimelines');
  } on Object catch (e, st) {
    talker.error('[Widget] reloadTimelines failed', e, st);
  }
}
