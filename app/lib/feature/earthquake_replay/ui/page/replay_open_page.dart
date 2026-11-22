import 'dart:async';

import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/action/replay_open_action.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_file_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_start_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class const ReplayOpenPage({required final String source, super.key})
    extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      unawaited(
        Future<void>.microtask(() async {
          if (!context.mounted) {
            return;
          }
          await ref
              .read(replayOpenActionProvider)
              .open(ref, context, source: Uri.parse(source));
        }),
      );
      return null;
    }, [source]);

    final mutation = ref.watch(ReplayNotifier.openMutation);

    return Scaffold(
      appBar: AppBar(title: const Text('過去の地震を再生')),
      body: SafeArea(
        child: Center(
          child: switch (mutation) {
            MutationError(:final error) => _ReplayOpenError(
              message: switch (error) {
                ReplayFileException(:final failure) => failure.message,
                ReplayStartException(:final failure) => failure.message,
                _ => ReplayFileFailure.invalidFormat.message,
              },
            ),
            _ => const _ReplayOpenProgress(),
          },
        ),
      ),
    );
  }
}

class const _ReplayOpenProgress() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    return Column(
      mainAxisSize: .min,
      children: [
        const AccessibleCircularProgressIndicator(),
        SizedBox(height: designSystem.spacing.md),
        Text(
          'リプレイファイルを読み込んでいます',
          style: designSystem.typography.bodyMedium,
        ),
      ],
    );
  }
}

class const _ReplayOpenError({required final String message})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    return Padding(
      padding: EdgeInsets.all(spacing.xl),
      child: Column(
        mainAxisSize: .min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: designSystem.colorTheme.error,
          ),
          SizedBox(height: spacing.md),
          Text(
            message,
            style: designSystem.typography.bodyMedium,
            textAlign: .center,
          ),
          SizedBox(height: spacing.xl),
          FilledButton.tonal(
            onPressed: () => context.canPop()
                ? context.pop()
                : const HomeRoute().go(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }
}
