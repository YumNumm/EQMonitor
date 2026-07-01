part of '../page/onboarding_page.dart';

class _CompleteStepPage extends HookConsumerWidget {
  const _CompleteStepPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scope = _OnboardingScope.of(context);
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final completeMutation = ref.watch(OnboardingCompleted.completeMutation);
    final isProcessing = completeMutation is MutationPending;

    Future<void> completeOnboarding() async {
      await OnboardingCompleted.completeMutation.run(
        ref,
        (tsx) async => tsx.get(onboardingCompletedProvider.notifier).complete(),
      );
      if (context.mounted) {
        const HomeRoute().go(context);
      }
    }

    useEffect(() {
      scope.setStepNavigation(
        step: _OnboardingStep.complete,
        state: _StepNavigationState(
          buttonLabel: 'はじめる',
          isNextEnabled: !isProcessing,
          isProcessing: isProcessing,
          onNext: completeOnboarding,
        ),
      );
      return null;
    }, [scope, isProcessing]);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: designSystem.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: designSystem.spacing.xxxxl),
          Text(
            '準備完了',
            style: designSystem.typography.displayMedium,
          ),
          SizedBox(height: designSystem.spacing.sm),
          Text(
            'EQMonitor で日本の地震情報をリアルタイムに確認できます',
            style: designSystem.typography.bodyLarge.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Center(
            child: _OnboardingCompleteHero(
              color: designSystem.colorTheme.status.success,
              backgroundColor: designSystem.colorTheme.surfaceContainerLow,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
