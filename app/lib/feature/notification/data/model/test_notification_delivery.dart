import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum TestNotificationKind {
  silent,
  normal,
  critical,
  shindoReport,
  shindoReportWithHypocenter,
  hypocenterAndIntensity,
  longPeriodGroundMotion,
  eewForecast,
  eewWarning,
}

extension TestNotificationKindDisplay on TestNotificationKind {
  String get displayLabel => switch (this) {
    .silent => 'サイレント',
    .normal => '通常',
    .critical => '重大な通知',
    .shindoReport => '震度速報',
    .shindoReportWithHypocenter => '震度速報＋震源に関する情報',
    .hypocenterAndIntensity => '震度・震源情報',
    .longPeriodGroundMotion => '長周期地震動に関する観測情報',
    .eewForecast => '緊急地震速報（予報）',
    .eewWarning => '緊急地震速報（警報）',
  };

  bool get isCritical => this == .critical || this == .eewWarning;
}

extension TestNotificationKindApiExtension on TestNotificationKind {
  api.TestNotificationRequest get toApiRequest => api.TestNotificationRequest(
    type: switch (this) {
      .silent => .silent,
      .normal => .normal,
      .critical => .critical,
      .shindoReport => .shindoReport,
      .shindoReportWithHypocenter => .shindoReportWithHypocenter,
      .hypocenterAndIntensity => .hypocenterAndIntensity,
      .longPeriodGroundMotion => .longPeriodGroundMotion,
      .eewForecast => .eewForecast,
      .eewWarning => .eewWarning,
    },
  );
}
