import 'dart:io';

import 'package:flutter/foundation.dart';

class AdUnitId {
  const AdUnitId._();

  static String get banner {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }
    return Platform.isAndroid
        ? 'ca-app-pub-3081840463138357/3681223739'
        : 'ca-app-pub-3081840463138357/9735725108';
  }
}
