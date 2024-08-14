import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioExceptionText extends StatelessWidget {
  const DioExceptionText({required this.exception, super.key});
  final DioException exception;

  @override
  Widget build(BuildContext context) {
    final text = switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        '接続がタイムアウトしました',
      DioExceptionType.badResponse => '不正なレスポンスが返されました',
      DioExceptionType.cancel => 'リクエストがキャンセルされました',
      DioExceptionType.badCertificate => '証明書のエラーが発生しました',
      DioExceptionType.connectionError => '接続エラーが発生しました',
      DioExceptionType.unknown => 'その他のエラーが発生しました',
    };
    final errorCode = exception.type.index + 12000;
    final errorCodeText = ' (エラーコード: $errorCode)';
    return Text(
      text + errorCodeText,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
