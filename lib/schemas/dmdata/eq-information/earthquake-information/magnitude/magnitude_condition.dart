enum MagnitudeCondition {
  /// `Ｍ不明`
  unknown('不明'),

  /// `Ｍ８を超える巨大地震`
  hugeEarthquakeExceedingM8('M8を超える巨大地震');

  const MagnitudeCondition(this.description);
  final String description;
}
