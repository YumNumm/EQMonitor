enum NotificationKind {
  eew,
  earthquake;

  String get label => switch (this) {
    .eew => '緊急地震速報(予報)',
    .earthquake => '地震情報',
  };
}
