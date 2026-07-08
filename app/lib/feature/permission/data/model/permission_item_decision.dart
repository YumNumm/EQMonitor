enum PermissionItemDecision { notRequested, granted, skipped }

extension PermissionItemDecisionX on PermissionItemDecision {
  bool get isComplete => switch (this) {
    PermissionItemDecision.granted || PermissionItemDecision.skipped => true,
    PermissionItemDecision.notRequested => false,
  };

  bool get isGranted => this == PermissionItemDecision.granted;
}
