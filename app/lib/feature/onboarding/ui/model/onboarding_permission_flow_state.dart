enum OnboardingPermissionDecision { notRequested, granted, skipped }

extension OnboardingPermissionDecisionX on OnboardingPermissionDecision {
  bool get isComplete => switch (this) {
    OnboardingPermissionDecision.granted ||
    OnboardingPermissionDecision.skipped => true,
    OnboardingPermissionDecision.notRequested => false,
  };

  bool get isGranted => this == OnboardingPermissionDecision.granted;
}

class OnboardingPermissionFlowState {
  const OnboardingPermissionFlowState({
    required this.isCriticalAlertSupported,
    this.notification = OnboardingPermissionDecision.notRequested,
    this.criticalAlert = OnboardingPermissionDecision.notRequested,
    this.foregroundLocation = OnboardingPermissionDecision.notRequested,
    this.backgroundLocation = OnboardingPermissionDecision.notRequested,
  });

  final bool isCriticalAlertSupported;
  final OnboardingPermissionDecision notification;
  final OnboardingPermissionDecision criticalAlert;
  final OnboardingPermissionDecision foregroundLocation;
  final OnboardingPermissionDecision backgroundLocation;

  bool get isCriticalAlertVisible => isCriticalAlertSupported;

  bool get canRequestCriticalAlert =>
      isCriticalAlertVisible && notification.isGranted;

  bool get canRequestBackgroundLocation => foregroundLocation.isGranted;

  bool get canContinue =>
      notification.isComplete &&
      (!isCriticalAlertVisible || criticalAlert.isComplete) &&
      foregroundLocation.isComplete &&
      backgroundLocation.isComplete;

  OnboardingPermissionFlowState grantNotification() =>
      copyWith(notification: OnboardingPermissionDecision.granted);

  OnboardingPermissionFlowState skipNotification() => copyWith(
    notification: OnboardingPermissionDecision.skipped,
    criticalAlert: OnboardingPermissionDecision.skipped,
  );

  OnboardingPermissionFlowState grantCriticalAlert() =>
      copyWith(criticalAlert: OnboardingPermissionDecision.granted);

  OnboardingPermissionFlowState skipCriticalAlert() =>
      copyWith(criticalAlert: OnboardingPermissionDecision.skipped);

  OnboardingPermissionFlowState grantForegroundLocation() =>
      copyWith(foregroundLocation: OnboardingPermissionDecision.granted);

  OnboardingPermissionFlowState skipForegroundLocation() => copyWith(
    foregroundLocation: OnboardingPermissionDecision.skipped,
    backgroundLocation: OnboardingPermissionDecision.skipped,
  );

  OnboardingPermissionFlowState grantBackgroundLocation() =>
      copyWith(backgroundLocation: OnboardingPermissionDecision.granted);

  OnboardingPermissionFlowState skipBackgroundLocation() =>
      copyWith(backgroundLocation: OnboardingPermissionDecision.skipped);

  OnboardingPermissionFlowState copyWith({
    bool? isCriticalAlertSupported,
    OnboardingPermissionDecision? notification,
    OnboardingPermissionDecision? criticalAlert,
    OnboardingPermissionDecision? foregroundLocation,
    OnboardingPermissionDecision? backgroundLocation,
  }) => OnboardingPermissionFlowState(
    isCriticalAlertSupported:
        isCriticalAlertSupported ?? this.isCriticalAlertSupported,
    notification: notification ?? this.notification,
    criticalAlert: criticalAlert ?? this.criticalAlert,
    foregroundLocation: foregroundLocation ?? this.foregroundLocation,
    backgroundLocation: backgroundLocation ?? this.backgroundLocation,
  );
}
