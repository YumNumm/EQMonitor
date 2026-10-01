import 'package:dio/dio.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_failure.dart';

/// エラー詳細シートの「まとめてコピー」で共有する診断テキストを組み立てる。
class ErrorDiagnosticsBuilder {
  const new _();

  /// widget/platform に依存させないため、値はすべて呼び出し側が解決して渡す。
  static String build({
    required Object error,
    required String deviceId,
    required String appVersion,
    required String buildNumber,
    required String os,
    required DateTime occurredAt,
    required bool includeStackTrace,
    StackTrace? stackTrace,
  }) {
    final buffer = StringBuffer()
      ..writeln(
        '発生時刻: ${occurredAt.formatWithTz(.yearMonthDayHourMinuteSecondMillisecond)} JST',
      )
      ..writeln('アプリバージョン: $appVersion ($buildNumber)')
      ..writeln('OS: $os')
      ..writeln('deviceId: $deviceId')
      ..writeln('例外型: ${error.runtimeType}');

    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        buffer.writeln('HTTPステータス: $statusCode');
      }
      buffer.writeln('DioExceptionType: ${error.type.name}');
      final data = error.response?.data;
      if (data != null) {
        buffer.writeln('レスポンス: $data');
      }
    }

    buffer.writeln('メッセージ: $error');

    if (error case NotificationSoundException(
      :final failure,
      :final operation,
      :final cause,
    )) {
      buffer.writeln('通知音エラー: ${failure.name}');
      if (operation != null) buffer.writeln('処理: $operation');
      if (cause != null) {
        buffer.writeln('プラットフォームコード: ${cause.code}');
        if (cause.details case {'stage': final String stage}) {
          buffer.writeln('失敗箇所: $stage');
        }
        if (cause.details case {'nativeDomain': final String domain}) {
          buffer.writeln('OSエラードメイン: $domain');
        }
        if (cause.details case {'nativeCode': final int code}) {
          buffer.writeln('OSエラーコード: $code');
        }
      }
    }

    if (includeStackTrace && stackTrace != null) {
      buffer
        ..writeln('--- StackTrace ---')
        ..writeln(stackTrace.toString());
    }

    return buffer.toString().trimRight();
  }
}
