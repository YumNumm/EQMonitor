import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_kind.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final liveActivityLocalControllerProvider =
    Provider<LiveActivityLocalController>((ref) {
      if (Platform.isIOS) {
        return const MethodChannelLiveActivityLocalController();
      }
      return const UnsupportedLiveActivityLocalController();
    });

/// アプリ内から ActivityKit を用いて Live Activity をローカル開始・更新・終了する。
///
/// Push-to-Start（サーバー経由）とは別経路で、開発時の表示検証に用いる。
abstract interface class LiveActivityLocalController {
  /// この端末で Live Activity のローカル開始がサポートされているか。
  Future<bool> isSupported();

  /// Live Activity を開始し、払い出された `activityId` を返す。
  Future<String> start({
    required DebugLiveActivityKind kind,
    required String eventId,
    required Map<String, dynamic> contentState,
  });

  /// 既存の Live Activity を更新する。
  Future<void> update({
    required DebugLiveActivityKind kind,
    required String activityId,
    required Map<String, dynamic> contentState,
  });

  /// Live Activity を終了する。
  Future<void> end({
    required DebugLiveActivityKind kind,
    required String activityId,
    Map<String, dynamic>? contentState,
  });
}

/// iOS 以外のプラットフォーム向けの no-op 実装。
class UnsupportedLiveActivityLocalController
    implements LiveActivityLocalController {
  const new();

  @override
  Future<bool> isSupported() async => false;

  @override
  Future<String> start({
    required DebugLiveActivityKind kind,
    required String eventId,
    required Map<String, dynamic> contentState,
  }) => throw const LiveActivityLocalException('この端末ではサポートされていません');

  @override
  Future<void> update({
    required DebugLiveActivityKind kind,
    required String activityId,
    required Map<String, dynamic> contentState,
  }) => throw const LiveActivityLocalException('この端末ではサポートされていません');

  @override
  Future<void> end({
    required DebugLiveActivityKind kind,
    required String activityId,
    Map<String, dynamic>? contentState,
  }) => throw const LiveActivityLocalException('この端末ではサポートされていません');
}

/// `net.yumnumm.eqmonitor/live_activity_debug` MethodChannel 経由の iOS 実装。
class MethodChannelLiveActivityLocalController
    implements LiveActivityLocalController {
  const new();

  static const MethodChannel _channel = MethodChannel(
    'net.yumnumm.eqmonitor/live_activity_debug',
  );

  @override
  Future<bool> isSupported() async {
    final result = await _invoke<bool>('isSupported');
    return result ?? false;
  }

  @override
  Future<String> start({
    required DebugLiveActivityKind kind,
    required String eventId,
    required Map<String, dynamic> contentState,
  }) async {
    final activityId = await _invoke<String>('start', <String, dynamic>{
      'kind': kind.wireName,
      'eventId': eventId,
      'contentState': jsonEncode(contentState),
    });
    if (activityId == null || activityId.isEmpty) {
      throw const LiveActivityLocalException('activityId を取得できませんでした');
    }
    return activityId;
  }

  @override
  Future<void> update({
    required DebugLiveActivityKind kind,
    required String activityId,
    required Map<String, dynamic> contentState,
  }) async {
    await _invoke<void>('update', <String, dynamic>{
      'kind': kind.wireName,
      'activityId': activityId,
      'contentState': jsonEncode(contentState),
    });
  }

  @override
  Future<void> end({
    required DebugLiveActivityKind kind,
    required String activityId,
    Map<String, dynamic>? contentState,
  }) async {
    await _invoke<void>('end', <String, dynamic>{
      'kind': kind.wireName,
      'activityId': activityId,
      'contentState': contentState == null ? null : jsonEncode(contentState),
    });
  }

  Future<T?> _invoke<T>(String method, [Map<String, dynamic>? arguments]) async {
    try {
      return await _channel.invokeMethod<T>(method, arguments);
    } on PlatformException catch (e) {
      throw LiveActivityLocalException(e.message ?? e.code, code: e.code);
    } on MissingPluginException catch (e) {
      throw LiveActivityLocalException(
        e.message ?? 'ネイティブ実装が見つかりません',
        code: 'missing_plugin',
      );
    }
  }
}

/// Live Activity のローカル操作で発生した例外。
class LiveActivityLocalException implements Exception {
  const new(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() =>
      code == null ? message : 'LiveActivityLocalException($code): $message';
}
