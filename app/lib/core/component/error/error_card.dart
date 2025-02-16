import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_authentication_payload.dart';
import 'package:eqmonitor/core/util/fullscreen_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    required this.error,
    super.key,
    this.onDioExceptionStatusOverride,
    this.color,
    this.suffixMessage,
    this.title,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    this.onReload,
  });

  final Object error;
  final Color? color;
  final String? title;
  final String? suffixMessage;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  /// DioExceptionで、StatusCodeがある時に　エラーメッセージを上書きする
  final String? Function(int statusCode)?
  onDioExceptionStatusOverride;

  /// 再読み込み
  final Future<void> Function()? onReload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final message = _buildErrorMessage();

    final colorScheme = theme.colorScheme;

    return Center(
      child: Card(
        margin: margin,
        color: color ?? theme.colorScheme.errorContainer,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error,
                    size: 48,
                    color: colorScheme.error,
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Text(
                      title ?? 'ERROR!',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                colorScheme
                                    .onErrorContainer,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                  fontFamily:
                      GoogleFonts.jetBrainsMono()
                          .fontFamily,
                ),
              ),
              if (suffixMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  suffixMessage!,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(
                        color:
                            theme
                                .colorScheme
                                .onErrorContainer,
                        fontFamily:
                            GoogleFonts.jetBrainsMono()
                                .fontFamily,
                      ),
                ),
              ],
              const _DeviceIdText(),
              if (onReload != null) ...[
                const SizedBox(height: 8),
                FilledButton.tonalIcon(
                  onPressed:
                      () async =>
                          FullScreenCircularProgressIndicator.showUntil(
                            context,
                            onReload!,
                          ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('再読み込み'),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError,
                    iconColor: colorScheme.onError,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _buildErrorMessage() {
    if (error is DioException) {
      if (error case DioException(
        :final response,
      ) when response != null) {
        final advancedErrorMessage = switch (response
            .data) {
          {'error': final String errorMsg} => errorMsg,
          {
            'code': final String code,
            'details': final String details,
          } =>
            '$code: $details',
          _ =>
            'エラーが発生しました\n'
                '少し時間をおいて再度お試しください。\n'
                '解消されない場合は、この画面のスクリーンショットを開発者へ送信してください',
        };
        final statusCode = response.statusCode;
        if (statusCode != null) {
          final baseMessage =
              onDioExceptionStatusOverride?.call(
                statusCode,
              ) ??
              switch (statusCode) {
                400 => '不正なリクエストです',
                403 => 'アクセスが拒否されました',
                404 => 'リソースが見つかりません',
                500 => 'サーバーエラーが発生しました',
                503 => 'サービスが利用できません',
                _ => 'エラーが発生しました',
              };
          final data = response.data;
          if (data is Map<String, dynamic>) {
            return '$baseMessage\n'
                '$advancedErrorMessage';
          }
          return '$baseMessage\n'
              '$advancedErrorMessage\n'
              '${response.data}';
        }
        return advancedErrorMessage;
      } else {
        final message = switch (error) {
          DioException(:final type) => switch (type) {
            DioExceptionType.badCertificate =>
              'SSL証明書が不正です',
            DioExceptionType.badResponse =>
              'サーバーからのレスポンスが不正です',
            DioExceptionType.connectionTimeout =>
              'サーバーとの接続がタイムアウトしました',
            DioExceptionType.receiveTimeout =>
              'サーバーからのレスポンスがタイムアウトしました',
            DioExceptionType.sendTimeout =>
              'サーバーへのリクエストがタイムアウトしました',
            DioExceptionType.connectionError =>
              'サーバーとの接続に失敗しました。ネットワーク接続を確認してください',
            DioExceptionType.unknown => '不明なエラーが発生しました',
            DioExceptionType.cancel => 'キャンセルされました',
          },
          _ => 'エラーが発生しました',
        };
        return message;
      }
    }
    return 'エラーが発生しました\n'
        '少し時間をおいて再度お試しください。\n'
        '解消されない場合は、この画面のスクリーンショットを開発者へ送信してください'
        '\n($error)';
  }
}

class _DeviceIdText extends ConsumerWidget {
  const _DeviceIdText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final state =
        ref
            .watch(apiAuthenticationPayloadProvider)
            .valueOrNull;
    return Text(
      'デバイスID: ${state?.id ?? "Unknown"}',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
      ),
    );
  }
}
