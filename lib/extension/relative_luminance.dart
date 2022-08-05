import 'package:flutter/material.dart';

/// 背景色が明るい色であれば、黒を、暗い色であれば白を返す
/// ref: https://zenn.dev/pressedkonbu/books/flutter-reverse-lookup-dictionary/viewer/019-compute-luminance
extension OnPrimary on Color {
  /// 輝度が高ければ黒, 低ければ白を返す
  Color get onPrimary {
    // 輝度により黒か白かを決定する
    if (computeLuminance() < 0.5) {
      return Colors.white;
    }
    return Colors.black;
  }
}
