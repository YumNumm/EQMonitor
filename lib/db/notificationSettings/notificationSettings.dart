class NotificationSettingsState {
  NotificationSettingsState({
    required this.notifAll,
    required this.notifFirstReport,
    required this.notifLastReport,
    required this.notifOnUpdate,
    required this.notifOnUpwardUpdate,
    required this.useTTS,
  });

  factory NotificationSettingsState.fromJson(Map<String, dynamic> j) =>
      NotificationSettingsState(
        notifAll: j['notifAll'].toString() == 'true',
        notifFirstReport: !(j['notifFirstReport'].toString() == 'false'),
        notifLastReport: !(j['notifLastReport'].toString() == 'false'),
        notifOnUpdate: j['notifOnUpdate'].toString() == 'true',
        notifOnUpwardUpdate: !(j['notifOnUpwardUpdate'].toString() == 'false'),
        useTTS: !(j['useTTS'].toString() == 'false'),
      );

  /// すべて通知するかどうか
  final bool notifAll;

  /// 第1報を通知するかどうか
  final bool notifFirstReport;

  /// 最終報を通知するかどうか;
  final bool notifLastReport;

  /// マグニチュードもしくは、震度が修正された際に通知
  final bool notifOnUpdate;

  /// マグニチュードもしくは、震度が上方修正された際に通知
  final bool notifOnUpwardUpdate;

  final bool useTTS;
}
