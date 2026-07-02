import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioExceptionText extends StatelessWidget {
  const DioExceptionText({required this.exception, super.key});

  final DioException exception;

  @override
  Widget build(BuildContext context) {
    final text = switch (exception.type) {
      .connectionTimeout ||
      .sendTimeout ||
      .receiveTimeout => '接続がタイムアウトしました',
      .badResponse => '不正なレスポンスが返されました',
      .cancel => 'リクエストがキャンセルされました',
      .badCertificate => '証明書のエラーが発生しました',
      .connectionError => '接続エラーが発生しました',
      .unknown => 'その他のエラーが発生しました',
      .transformTimeout => '変換がタイムアウトしました',
    };
    final errorCode = exception.type.index + 12000;
    final errorCodeText = ' (エラーコード: $errorCode)';
    return Text(
      text + errorCodeText,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
