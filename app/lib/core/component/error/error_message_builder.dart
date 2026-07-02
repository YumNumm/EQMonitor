import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_message_builder.g.dart';

@riverpod
ErrorMessageBuilder errorMessageBuilder(Ref ref) => ErrorMessageBuilder();

class ErrorMessageBuilder {
  String build({
    required Object error,
    String? Function(int statusCode)? onDioExceptionStatusOverride,
  }) {
    if (error is DioException) {
      final response = error.response;
      if (response != null) {
        final advancedErrorMessage = switch (response.data) {
          {'error': final String errorMsg} => errorMsg,
          {'code': final String code, 'details': final String details} =>
            '$code: $details',
          _ =>
            '少し時間をおいて再度お試しください。\n'
                '解消されない場合は、この画面のスクリーンショットを開発者へ送信してください',
        };
        final statusCode = response.statusCode;
        if (statusCode != null) {
          final baseMessage =
              onDioExceptionStatusOverride?.call(statusCode) ??
              switch (statusCode) {
                400 => '不正なリクエストです',
                403 => 'アクセスが拒否されました',
                404 => 'リソースが見つかりません',
                500 => 'サーバーエラーが発生しました',
                503 => 'サービスが利用できません',
                _ => 'エラーが発生しました',
              };
          if (response.data is Map<String, dynamic>) {
            return '$baseMessage\n$advancedErrorMessage';
          }
          return '$baseMessage\n$advancedErrorMessage\n${response.data}';
        }
        return advancedErrorMessage;
      }
      return switch (error.type) {
        .badCertificate => 'SSL証明書が不正です',
        .badResponse => 'サーバーからのレスポンスが不正です',
        .connectionTimeout => 'サーバーとの接続がタイムアウトしました',
        .receiveTimeout => 'サーバーからのレスポンスがタイムアウトしました',
        .sendTimeout => 'サーバーへのリクエストがタイムアウトしました',
        .connectionError => 'サーバーとの接続に失敗しました。ネットワーク接続を確認してください',
        .unknown => '不明なエラーが発生しました',
        .cancel => 'キャンセルされました',
        .transformTimeout => '変換がタイムアウトしました',
      };
    }
    return 'エラーが発生しました\n'
        '少し時間をおいて再度お試しください。\n'
        '解消されない場合は、この画面のスクリーンショットを開発者へ送信してください'
        '\n($error)';
  }
}
