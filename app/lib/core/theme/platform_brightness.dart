import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'platform_brightness.g.dart';

@riverpod
class PlatformBrightness extends _$PlatformBrightness {
  @override
  Brightness build() {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () async {
      Future<void>.delayed(
        const Duration(milliseconds: 250),
        ref.invalidateSelf,
      );
    };

    return PlatformDispatcher.instance.platformBrightness;
  }
}
