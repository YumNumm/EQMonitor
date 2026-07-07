part of '../page/onboarding_page.dart';

class _OnboardingStepPage extends StatelessWidget {
  const _OnboardingStepPage({required this.step, required this.navigation});

  final _OnboardingStep step;
  final _OnboardingStepNavigation navigation;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      _OnboardingStep.welcome => _WelcomeStepPage(navigation: navigation),
      _OnboardingStep.permissions => _PermissionsStepPage(
        navigation: navigation,
      ),
      _OnboardingStep.notificationSettings => _NotificationSettingsStepPage(
        navigation: navigation,
      ),
      _OnboardingStep.complete => _CompleteStepPage(navigation: navigation),
    };
  }
}
