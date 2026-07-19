import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_json_parser.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_live_activity_action.g.dart';

@riverpod
DebugLiveActivityAction debugLiveActivityAction(Ref ref) =>
    DebugLiveActivityAction();

class DebugLiveActivityAction {
  Future<DebugLiveActivitySession?> start(
    WidgetRef ref,
    BuildContext context, {
    required api.LiveActivityStartTrigger startTrigger,
    required String contentStateJson,
    required String alertJson,
  }) async {
    const snackBar = DebugLiveActivitySnackBar();
    final parser = ref.read(debugLiveActivityJsonParserProvider);
    final contentStateResult = parser.parseOptionalObjectJson(
      raw: contentStateJson,
    );
    final contentState = switch (contentStateResult) {
      Success(:final value) => value,
      Failure(:final exception) => snackBar.showJsonError(context, exception),
    };
    if (contentStateResult is Failure) {
      return null;
    }

    final alertResult = parser.parseOptionalAlertJson(raw: alertJson);
    final alert = switch (alertResult) {
      Success(:final value) => value,
      Failure(:final exception) => snackBar.showJsonError(context, exception),
    };
    if (alertResult is Failure) {
      return null;
    }

    final repository = await ref.read(
      debugLiveActivityRepositoryProvider.future,
    );
    final result = await repository.start(
      startTrigger: startTrigger,
      contentState: contentState,
      alert: alert,
    );
    return switch (result) {
      Success(:final value) => snackBar.showStartSuccess(context, value),
      Failure(:final exception) => snackBar.showApiError(context, exception),
    };
  }

  Future<bool> update(
    WidgetRef ref,
    BuildContext context, {
    required String liveActivityId,
    required String contentStateJson,
  }) async {
    const snackBar = DebugLiveActivitySnackBar();
    final trimmedId = liveActivityId.trim();
    if (trimmedId.isEmpty) {
      snackBar.show(context, 'live_activity_id を入力してください');
      return false;
    }
    if (contentStateJson.trim().isEmpty) {
      snackBar.show(context, '更新には ContentState JSON が必要です');
      return false;
    }

    final parser = ref.read(debugLiveActivityJsonParserProvider);
    final contentStateResult = parser.parseOptionalObjectJson(
      raw: contentStateJson,
    );
    final contentState = switch (contentStateResult) {
      Success(value: final api.LiveActivityContentState value?) => value,
      Success(value: null) => null,
      Failure(:final exception) => snackBar.showJsonError(context, exception),
    };
    if (contentState == null) {
      return false;
    }

    final repository = await ref.read(
      debugLiveActivityRepositoryProvider.future,
    );
    final result = await repository.update(
      liveActivityId: trimmedId,
      contentState: contentState,
    );
    return switch (result) {
      Success() => snackBar.showSuccess(context, 'Live Activity を更新しました'),
      Failure(:final exception) =>
        snackBar.showApiError(context, exception) != null,
    };
  }

  Future<bool> end(
    WidgetRef ref,
    BuildContext context, {
    required String liveActivityId,
    required String contentStateJson,
  }) async {
    const snackBar = DebugLiveActivitySnackBar();
    final trimmedId = liveActivityId.trim();
    if (trimmedId.isEmpty) {
      snackBar.show(context, 'live_activity_id を入力してください');
      return false;
    }

    final parser = ref.read(debugLiveActivityJsonParserProvider);
    final contentStateResult = parser.parseOptionalObjectJson(
      raw: contentStateJson,
    );
    final contentState = switch (contentStateResult) {
      Success(:final value) => value,
      Failure(:final exception) => snackBar.showJsonError(context, exception),
    };
    if (contentStateResult is Failure) {
      return false;
    }

    final repository = await ref.read(
      debugLiveActivityRepositoryProvider.future,
    );
    final result = await repository.end(
      liveActivityId: trimmedId,
      contentState: contentState,
    );
    return switch (result) {
      Success() => snackBar.showSuccess(context, 'Live Activity を終了しました'),
      Failure(:final exception) =>
        snackBar.showApiError(context, exception) != null,
    };
  }
}

class DebugLiveActivitySnackBar {
  const DebugLiveActivitySnackBar();

  Null showJsonError(BuildContext context, FormatException exception) {
    show(context, 'JSON が不正です: ${exception.message}');
    return null;
  }

  DebugLiveActivitySession showStartSuccess(
    BuildContext context,
    DebugLiveActivitySession session,
  ) {
    show(context, 'Live Activity を開始しました');
    return session;
  }

  bool showSuccess(BuildContext context, String message) {
    show(context, message);
    return true;
  }

  Null showApiError(BuildContext context, Exception exception) {
    final message = switch (exception) {
      DioException(response: final response) when response?.statusCode == 409 =>
        'API エラー: updateToken 未登録の可能性があります',
      _ => 'API エラー: $exception',
    };
    show(context, message);
    return null;
  }

  void show(BuildContext context, String message) {
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
