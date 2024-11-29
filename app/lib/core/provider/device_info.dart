import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info.g.dart';

@Riverpod(keepAlive: true)
AndroidDeviceInfo androidDeviceInfo(Ref ref) =>
    throw UnimplementedError();

@Riverpod(keepAlive: true)
IosDeviceInfo iosDeviceInfo(Ref ref) => throw UnimplementedError();
