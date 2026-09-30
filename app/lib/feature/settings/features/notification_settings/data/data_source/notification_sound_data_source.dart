import 'dart:convert';

import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_failure.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_sound_data_source.g.dart';

@Riverpod(keepAlive: true)
NotificationSoundDataSource notificationSoundDataSource(Ref ref) =>
    const NotificationSoundDataSource(
      MethodChannel('net.yumnumm.eqmonitor/notification_sounds'),
    );

class const NotificationSoundDataSource(final MethodChannel _channel) {
  Future<({String path, String displayName})?> pickSource() async {
    final file = await FilePicker.pickFile(type: FileType.audio);
    if (file == null) return null;
    final path = file.path;
    if (path == null || path.isEmpty) {
      throw const NotificationSoundException(.sourceUnavailable);
    }
    return (path: path, displayName: file.name);
  }

  Future<Map<String, dynamic>> read(
    String method, {
    Map<String, dynamic>? arguments,
  }) async {
    try {
      final response = await _channel.invokeMethod<String>(method, arguments);
      if (response == null)
        throw const NotificationSoundException(.storageFailure);
      return jsonDecode(response) as Map<String, dynamic>;
    } on PlatformException catch (error) {
      throw NotificationSoundException(
        NotificationSoundFailure.values.firstWhere(
          (failure) => failure.name == error.code,
          orElse: () => .storageFailure,
        ),
      );
    } on MissingPluginException {
      throw const NotificationSoundException(.storageFailure);
    }
  }

  Future<void> write(String method, {Map<String, dynamic>? arguments}) async {
    try {
      await _channel.invokeMethod<void>(method, arguments);
    } on PlatformException catch (error) {
      throw NotificationSoundException(
        NotificationSoundFailure.values.firstWhere(
          (failure) => failure.name == error.code,
          orElse: () => .storageFailure,
        ),
      );
    } on MissingPluginException {
      throw const NotificationSoundException(.storageFailure);
    }
  }
}
