enum DepthCondition {
  /// `ごく浅い`
  veryShallow('ごく浅い'),

  /// `７００ｋｍ以上`
  moreThan700km('700km以上'),

  /// `不明`
  unknown('不明');

  const DepthCondition(this.description);
  final String description;
}
