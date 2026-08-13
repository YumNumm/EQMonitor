import 'package:dio/dio.dart';
import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  required Object error,
  String? title,
  StackTrace? stackTrace,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _ErrorDialogBody(
      error: error,
      title: title,
      stackTrace: stackTrace,
    ),
  );
}

String _defaultTitle(Object error) {
  if (error is DioException) {
    final statusCode = error.response?.statusCode;
    if (statusCode != null) {
      return 'エラーが発生しました ($statusCode)';
    }
    if (error.type == DioExceptionType.connectionError) {
      return 'ネットワークエラー';
    }
  }
  return 'エラーが発生しました';
}

class _ErrorDialogBody extends ConsumerWidget {
  const _ErrorDialogBody({
    required this.error,
    required this.title,
    required this.stackTrace,
  });

  final Object error;
  final String? title;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.read(errorMessageBuilderProvider).build(error: error);
    return AlertDialog(
      title: Text(title ?? _defaultTitle(error)),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => showErrorDetailsSheet(
            context,
            error: error,
            stackTrace: stackTrace,
          ),
          child: const Text('詳細'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}
