part of '../page/onboarding_page.dart';

class const _OnboardingStepPage({
  required final _OnboardingStep step,
  required final _OnboardingStepNavigation navigation,
}) extends StatelessWidget {
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
