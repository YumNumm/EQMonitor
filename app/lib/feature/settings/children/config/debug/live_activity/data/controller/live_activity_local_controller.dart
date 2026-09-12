import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_content_state.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final liveActivityLocalControllerProvider =
    Provider<LiveActivityLocalController>((ref) {
      if (Platform.isIOS) {
        return const MethodChannelLiveActivityLocalController();
      }
      return const UnsupportedLiveActivityLocalController();
    });

abstract interface class LiveActivityLocalController {
  Future<bool> isSupported();

  Future<DebugLiveActivitySession> start({
    required UnifiedLiveActivityContentState state,
  });

  Future<void> update({
    required String activityId,
    required UnifiedLiveActivityContentState state,
  });

  Future<void> end({
    required String activityId,
    UnifiedLiveActivityContentState? state,
  });

  Future<List<DebugLiveActivitySession>> list();
}

class UnsupportedLiveActivityLocalController
    implements LiveActivityLocalController {
  const new();

  @override
  Future<bool> isSupported() async => false;

  @override
  Future<DebugLiveActivitySession> start({
    required UnifiedLiveActivityContentState state,
  }) => throw const LiveActivityLocalException(
    'この端末ではサポートされていません',
    code: 'unsupported',
  );

  @override
  Future<void> update({
    required String activityId,
    required UnifiedLiveActivityContentState state,
  }) => throw const LiveActivityLocalException(
    'この端末ではサポートされていません',
    code: 'unsupported',
  );

  @override
  Future<void> end({
    required String activityId,
    UnifiedLiveActivityContentState? state,
  }) => throw const LiveActivityLocalException(
    'この端末ではサポートされていません',
    code: 'unsupported',
  );

  @override
  Future<List<DebugLiveActivitySession>> list() async => const [];
}

/// MethodChannel の値を JSON に正規化し、StandardMessageCodec の map 型差を隔離する。
class LiveActivityDebugChannel {
  const new();

  static const methodChannel = MethodChannel(
    'net.yumnumm.eqmonitor/live_activity_debug',
  );

  Future<bool> invokeBool({required String method}) async {
    try {
      final value = await methodChannel.invokeMethod<bool>(method);
      return value ?? false;
    } on PlatformException catch (error) {
      throw LiveActivityLocalException.fromPlatform(error);
    } on MissingPluginException {
      throw const LiveActivityLocalException(
        'ネイティブ実装が見つかりません',
        code: 'missing_plugin',
      );
    }
  }

  Future<String> invokeJson({
    required String method,
    Map<String, dynamic>? arguments,
  }) async {
    try {
      final value = await methodChannel.invokeMethod(method, arguments);
      return jsonEncode(value);
    } on PlatformException catch (error) {
      throw LiveActivityLocalException.fromPlatform(error);
    } on MissingPluginException {
      throw const LiveActivityLocalException(
        'ネイティブ実装が見つかりません',
        code: 'missing_plugin',
      );
    }
  }

  Future<void> invokeVoid({
    required String method,
    required Map<String, dynamic> arguments,
  }) async {
    try {
      await methodChannel.invokeMethod<void>(method, arguments);
    } on PlatformException catch (error) {
      throw LiveActivityLocalException.fromPlatform(error);
    } on MissingPluginException {
      throw const LiveActivityLocalException(
        'ネイティブ実装が見つかりません',
        code: 'missing_plugin',
      );
    }
  }
}

class MethodChannelLiveActivityLocalController
    implements LiveActivityLocalController {
  const new({this.channel = const LiveActivityDebugChannel()});

  final LiveActivityDebugChannel channel;

  @override
  Future<bool> isSupported() => channel.invokeBool(method: 'isSupported');

  @override
  Future<DebugLiveActivitySession> start({
    required UnifiedLiveActivityContentState state,
  }) async {
    final contentState = validatedJson(state);
    final response = await channel.invokeJson(
      method: 'start',
      arguments: <String, dynamic>{
        'attributes': <String, dynamic>{'id': state.id},
        'contentState': contentState,
      },
    );
    return decodeSession(response);
  }

  @override
  Future<void> update({
    required String activityId,
    required UnifiedLiveActivityContentState state,
  }) {
    if (activityId.isEmpty) {
      throw const LiveActivityLocalException(
        'activityId が未設定です',
        code: 'invalid_arguments',
      );
    }
    return channel.invokeVoid(
      method: 'update',
      arguments: <String, dynamic>{
        'activityId': activityId,
        'contentState': validatedJson(state),
      },
    );
  }

  @override
  Future<void> end({
    required String activityId,
    UnifiedLiveActivityContentState? state,
  }) {
    if (activityId.isEmpty) {
      throw const LiveActivityLocalException(
        'activityId が未設定です',
        code: 'invalid_arguments',
      );
    }
    return channel.invokeVoid(
      method: 'end',
      arguments: <String, dynamic>{
        'activityId': activityId,
        if (state != null) 'contentState': validatedJson(state),
      },
    );
  }

  @override
  Future<List<DebugLiveActivitySession>> list() async {
    final response = await channel.invokeJson(method: 'list');
    try {
      final decoded = jsonDecode(response);
      if (decoded is! List) {
        throw const FormatException('list response is not an array');
      }
      return decoded
          .map((item) {
            if (item is! Map<String, dynamic>) {
              throw const FormatException('session is not an object');
            }
            return DebugLiveActivitySession.fromJson(item);
          })
          .toList(growable: false);
    } on FormatException {
      throw const LiveActivityLocalException(
        'ネイティブ応答が不正です',
        code: 'invalid_response',
      );
    }
  }

  String validatedJson(UnifiedLiveActivityContentState state) {
    try {
      return jsonEncode(state.validated().toJson());
    } on FormatException {
      throw const LiveActivityLocalException(
        'ContentState が不正です',
        code: 'invalid_content_state',
      );
    }
  }

  DebugLiveActivitySession decodeSession(String response) {
    try {
      final decoded = jsonDecode(response);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('session response is not an object');
      }
      return DebugLiveActivitySession.fromJson(decoded);
    } on FormatException {
      throw const LiveActivityLocalException(
        'ネイティブ応答が不正です',
        code: 'invalid_response',
      );
    }
  }
}

class LiveActivityLocalException implements Exception {
  const new(this.message, {required this.code});

  // ignore: unnecessary_type_name_in_constructor
  factory LiveActivityLocalException.fromPlatform(PlatformException error) =>
      LiveActivityLocalException(
        switch (error.code) {
          'invalid_arguments' => '引数が不正です',
          'invalid_content_state' => 'ContentState が不正です',
          'logical_id_mismatch' => 'logical ID が一致しません',
          'activity_not_found' => 'Live Activity が見つかりません',
          'unsupported' => 'この端末ではサポートされていません',
          'live_activity_error' => 'Live Activity の操作に失敗しました',
          _ => 'Live Activity の操作に失敗しました',
        },
        code: error.code,
      );

  final String message;
  final String code;

  @override
  String toString() => 'LiveActivityLocalException($code): $message';
}
