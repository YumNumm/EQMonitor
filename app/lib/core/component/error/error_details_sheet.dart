import 'dart:io';

import 'package:eqmonitor/core/component/error/error_diagnostics.dart';
import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/settings/data/contact/contact_action.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showErrorDetailsSheet(
  BuildContext context, {
  required Object error,
  StackTrace? stackTrace,
}) {
  final occurredAt = DateTime.now();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _ErrorDetailsSheet(
      error: error,
      stackTrace: stackTrace,
      occurredAt: occurredAt,
    ),
  );
}

class _ErrorDetailsSheet extends ConsumerWidget {
  const _ErrorDetailsSheet({
    required this.error,
    required this.stackTrace,
    required this.occurredAt,
  });

  final Object error;
  final StackTrace? stackTrace;
  final DateTime occurredAt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final summary = ref.read(errorMessageBuilderProvider).build(error: error);
    final deviceId = switch (ref.watch(deviceIdProvider)) {
      AsyncData(:final value) => value,
      _ => '(取得中)',
    };
    final packageInfo = ref.watch(packageInfoProvider);
    final os = _osString(ref);

    final diagnostics = buildErrorDiagnostics(
      error: error,
      stackTrace: stackTrace,
      deviceId: deviceId,
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      os: os,
      occurredAt: occurredAt,
      includeStackTrace: kDebugMode,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('エラー詳細', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(summary, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240),
              child: SingleChildScrollView(
                child: SelectableText(
                  diagnostics,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: diagnostics),
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('エラー詳細をコピーしました'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy_rounded, size: 18),
                    label: const Text('まとめてコピー'),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () async {
                    final open = ref.read(openContactProvider);
                    await open(ref, context);
                  },
                  icon: const Icon(Icons.mail_outline_rounded, size: 18),
                  label: const Text('問い合わせ'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _osString(WidgetRef ref) {
    if (Platform.isIOS) {
      return 'iOS ${ref.watch(iosDeviceInfoProvider).systemVersion}';
    }
    if (Platform.isAndroid) {
      return 'Android ${ref.watch(androidDeviceInfoProvider).version.release}';
    }
    return Platform.operatingSystem;
  }
}
