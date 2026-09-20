import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/start/data/notifier/update_banner_seen_version_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'complete_onboarding_flow.g.dart';

@Riverpod(keepAlive: true)
CompleteOnboardingFlow completeOnboardingFlow(Ref ref) =>
    const CompleteOnboardingFlow();

/// オンボーディング完了時の一連の処理
class const CompleteOnboardingFlow() {
  Future<void> complete({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    await OnboardingCompleted.completeMutation.run(
      ref,
      (tsx) async => tsx.get(onboardingCompletedProvider.notifier).complete(),
    );
    try {
      final version = ref.read(packageInfoProvider).version;
      await ref
          .read(updateBannerSeenVersionProvider.notifier)
          .markSeen(version);
    } catch (error, stackTrace) {
      talker.handle(
        error,
        stackTrace,
        'Failed to initialize whats-new seen version on onboarding complete',
      );
    }
    if (context.mounted) {
      const HomeRoute().go(context);
    }
  }
}
