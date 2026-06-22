import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum TsunamiWarningKind {
  majorWarning,
  warning,
  warningCancel,
  advisory,
  advisoryCancel,
  forecast,
  none,
}

extension TsunamiWarningKindApiExt on api.TsunamiWarningKind {
  TsunamiWarningKind toDomain() => switch (this) {
    api.TsunamiWarningKind.majorWarning => TsunamiWarningKind.majorWarning,
    api.TsunamiWarningKind.warning => TsunamiWarningKind.warning,
    api.TsunamiWarningKind.warningCancel => TsunamiWarningKind.warningCancel,
    api.TsunamiWarningKind.advisory => TsunamiWarningKind.advisory,
    api.TsunamiWarningKind.advisoryCancel => TsunamiWarningKind.advisoryCancel,
    api.TsunamiWarningKind.forecast => TsunamiWarningKind.forecast,
    api.TsunamiWarningKind.none => TsunamiWarningKind.none,
  };
}
