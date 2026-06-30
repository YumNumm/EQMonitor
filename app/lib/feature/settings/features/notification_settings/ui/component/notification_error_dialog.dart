import 'package:dio/dio.dart';
import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> showNotificationSettingsErrorDialog({
  required BuildContext context,
  required Object error,
  required ErrorMessageBuilder errorMessageBuilder,
}) async {
  final message = errorMessageBuilder.build(error: error);
  final statusCode = error is DioException ? error.response?.statusCode : null;
  final title = statusCode != null
      ? 'エラーが発生しました ($statusCode)'
      : error is DioException &&
          error.type == DioExceptionType.connectionError
      ? 'ネットワークエラー'
      : 'エラーが発生しました';

  if (!context.mounted) {
    return;
  }

  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: message));
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('エラー内容をコピーしました')),
              );
            }
          },
          child: const Text('コピー'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
    ),
  );
}
