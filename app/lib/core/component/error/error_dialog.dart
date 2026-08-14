import 'package:dio/dio.dart';
import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_dialog.g.dart';

@riverpod
ErrorDialogAction errorDialogAction(Ref ref) => const ErrorDialogAction();

class ErrorDialogAction {
  const ErrorDialogAction();

  Future<void> show(
    BuildContext context, {
    required Object error,
    String? title,
    StackTrace? stackTrace,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) =>
          _ErrorDialogBody(error: error, title: title, stackTrace: stackTrace),
    );
  }
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
    final resolvedTitle =
        title ??
        switch (error) {
          DioException(:final response?) when response.statusCode != null =>
            'エラーが発生しました (${response.statusCode})',
          DioException(type: DioExceptionType.connectionError) => 'ネットワークエラー',
          _ => 'エラーが発生しました',
        };
    return AlertDialog(
      title: Text(resolvedTitle),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => ref
              .read(errorDetailsSheetActionProvider)
              .show(context, error: error, stackTrace: stackTrace),
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
