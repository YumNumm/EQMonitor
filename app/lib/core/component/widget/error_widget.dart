import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_authentication_payload.dart';
import 'package:eqmonitor/core/component/widget/dio_exception_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorInfoWidget extends StatelessWidget {
  const ErrorInfoWidget({
    required this.error,
    this.onRefresh,
    super.key,
  });
  final Object error;
  final void Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.error,
                  size: 48,
                ),
              ),
              if (error is DioException)
                ...() {
                  final exception = error as DioException;
                  final data = exception.response?.data;
                  final response = exception.response;
                  return [
                    DioExceptionText(
                      exception: exception,
                    ),
                    SizedBox(height: 8),
                    Text(
                      (response != null
                              ? '${exception.response?.statusCode} ${exception.response?.statusMessage}'
                              : '') +
                          switch (data) {
                            {
                              'code': final String code,
                              'details': final String details,
                            } =>
                              '\nエラーコード $code: $details',
                            _ => '',
                          },
                      textAlign: TextAlign.center,
                    ),
                  ];
                }()
              else
                const Text('エラーが発生しました'),
              Text("少し時間をおいて再度お試しください。\n"
                  "解消されない場合は、この画面のスクリーンショットを開発者へ送信してください"),
              _DeviceIdText(),
              Text(
                "エラータイプ: " + error.runtimeType.toString(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (onRefresh != null)
                FilledButton.icon(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => onRefresh?.call(),
                  label: const Text('再読み込み'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeviceIdText extends ConsumerWidget {
  const _DeviceIdText();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(apiAuthenticationPayloadProvider).valueOrNull;
    return Text(
      'デバイスID: ${state?.id ?? "Unknown"}',
    );
  }
}
