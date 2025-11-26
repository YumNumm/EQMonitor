/// JMA Tsunamigenic Potential for Northwest Pacific Tsunami.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-25.
enum JmaTsunamigenicPotential {
  noPossibility(0, 'There is No Possibility of a Tsunami'),
  destructiveOceanWide(
    1,
    'There is a Possibility of a Destructive Ocean-Wide Tsunami',
  ),
  destructiveRegional(
    2,
    'There is a Possibility of a Destructive Regional Tsunami',
  ),
  destructiveLocalNearEpicenter(
    3,
    'There is a Possibility of a Destructive Local Tsunami Near the Epicenter',
  ),
  verySmallPossibilityDestructiveLocal(
    4,
    'There is a Very Small Possibility of a destructive Local Tsunami',
  ),
  possibilityOfTsunami(7, 'There is Possibility of a Tsunami');

  const JmaTsunamigenicPotential(this.code, this.descriptionEn);

  final int code;
  final String descriptionEn;

  /// Returns the tsunamigenic potential for the given code.
  ///
  /// Returns null if not found.
  static JmaTsunamigenicPotential? fromCode(int code) =>
      JmaTsunamigenicPotential.values.where((e) => e.code == code).firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) =>
      'Undefined Tsunamigenic Potential (Code: $code)';
}
