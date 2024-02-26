import 'package:device_info_plus/device_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info.g.dart';

@Riverpod(keepAlive: true)
AndroidDeviceInfo androidDeviceInfo(AndroidDeviceInfoRef ref) =>
    throw UnimplementedError();

@Riverpod(keepAlive: true)
IosDeviceInfo iosDeviceInfo(IosDeviceInfoRef ref) => throw UnimplementedError();
