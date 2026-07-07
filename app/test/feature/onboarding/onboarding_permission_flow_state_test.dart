import 'package:eqmonitor/feature/onboarding/ui/model/onboarding_permission_flow_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingPermissionFlowState', () {
    test('initial state cannot continue', () {
      const state = OnboardingPermissionFlowState(
        isCriticalAlertSupported: true,
      );

      expect(state.canContinue, isFalse);
      expect(state.canRequestCriticalAlert, isFalse);
      expect(state.canRequestBackgroundLocation, isFalse);
    });

    test('skipping notification also skips critical alert', () {
      final state = const OnboardingPermissionFlowState(
        isCriticalAlertSupported: true,
      ).skipNotification();

      expect(state.notification, OnboardingPermissionDecision.skipped);
      expect(state.criticalAlert, OnboardingPermissionDecision.skipped);
    });

    test('unsupported critical alert is not required to continue', () {
      final state = const OnboardingPermissionFlowState(
        isCriticalAlertSupported: false,
      ).grantNotification().grantForegroundLocation().grantBackgroundLocation();

      expect(state.isCriticalAlertVisible, isFalse);
      expect(state.canContinue, isTrue);
    });

    test('foreground location grants access to background request', () {
      final initial = const OnboardingPermissionFlowState(
        isCriticalAlertSupported: false,
      );
      final granted = initial.grantForegroundLocation();

      expect(initial.canRequestBackgroundLocation, isFalse);
      expect(granted.canRequestBackgroundLocation, isTrue);
    });

    test('skipping foreground location also skips background location', () {
      final state = const OnboardingPermissionFlowState(
        isCriticalAlertSupported: false,
      ).skipForegroundLocation();

      expect(state.foregroundLocation, OnboardingPermissionDecision.skipped);
      expect(state.backgroundLocation, OnboardingPermissionDecision.skipped);
    });

    test('all visible items must be complete to continue', () {
      final incomplete = const OnboardingPermissionFlowState(
        isCriticalAlertSupported: true,
      ).grantNotification().grantCriticalAlert().grantForegroundLocation();
      final complete = incomplete.skipBackgroundLocation();

      expect(incomplete.canContinue, isFalse);
      expect(complete.canContinue, isTrue);
    });
  });
}
