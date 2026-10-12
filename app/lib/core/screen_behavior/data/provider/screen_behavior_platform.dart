import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_behavior_platform.g.dart';

@riverpod
bool supportsLockScreenDisplay(Ref ref) => Platform.isAndroid;
