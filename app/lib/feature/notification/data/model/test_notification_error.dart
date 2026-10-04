import 'package:dio/dio.dart';

extension TestNotificationErrorDisplay on Exception {
  String get testNotificationMessage => switch (this) {
    DioException(response: Response(statusCode: 401)) =>
      '端末の認証を確認して、もう一度お試しください。',
    DioException(response: Response(statusCode: 404)) =>
      '通知先が登録されていません。端末の通知許可と登録状態を確認してください。',
    DioException(response: Response(statusCode: 429)) =>
      '送信間隔を空けて、もう一度お試しください。',
    DioException(response: Response(statusCode: 503)) =>
      '現在テスト通知を送信できません。しばらくしてからお試しください。',
    DioException(
      type: DioExceptionType.connectionError ||
          DioExceptionType.connectionTimeout ||
          DioExceptionType.sendTimeout ||
          DioExceptionType.receiveTimeout,
    ) =>
      '送信結果を確認できませんでした。通信状態と届いた通知を確認してください。',
    _ => '送信に失敗しました: $this',
  };
}
