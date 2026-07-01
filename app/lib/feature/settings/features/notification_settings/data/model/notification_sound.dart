enum NotificationSound {
  defaultSound('default', 'デフォルト'),
  eewWarning('eew_warning', 'EEW警報音'),
  eewForecast('eew_forecast', 'EEW予報音'),
  earthquake('earthquake', '地震情報音');

  const NotificationSound(this.apiValue, this.displayName);
  final String apiValue;
  final String displayName;

  static NotificationSound fromApiValue(String value) =>
      NotificationSound.values.firstWhere(
        (e) => e.apiValue == value,
        orElse: () => NotificationSound.defaultSound,
      );
}
