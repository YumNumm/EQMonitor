part of '../page/onboarding_page.dart';

class _OnboardingStepPage extends StatelessWidget {
  const _OnboardingStepPage({
    required this.step,
  });

  final _OnboardingStep step;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      _OnboardingStep.welcome => const _WelcomeStepPage(),
      _OnboardingStep.permissions => const _PermissionsStepPage(),
      _OnboardingStep.notificationSettings =>
        const _NotificationSettingsStepPage(),
      _OnboardingStep.complete => const _CompleteStepPage(),
    };
  }
}
