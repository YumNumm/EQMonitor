import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_sound_platform.g.dart';

@riverpod
bool customNotificationSoundsSupported(Ref ref) =>
    defaultTargetPlatform == TargetPlatform.iOS;
