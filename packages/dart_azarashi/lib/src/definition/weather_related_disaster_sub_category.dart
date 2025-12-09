/// JMA Weather Related Disaster Sub Category.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-41.
enum JmaWeatherRelatedDisasterSubCategory {
  snowstormEmergencyWarning(1, '暴風雪特別警報'),
  heavyRainEmergencyWarning(2, '大雨特別警報'),
  stormEmergencyWarning(3, '暴風特別警報'),
  heavySnowEmergencyWarning(4, '大雪特別警報'),
  waveEmergencyWarning(5, '波浪特別警報'),
  stormSurgeEmergencyWarning(6, '高潮特別警報'),
  allWeatherEmergencyWarnings(7, '全ての気象特別警報'),
  recordHeavyRainInfo(21, '記録的短時間大雨情報'),
  tornadoWarningInfo(22, '竜巻注意情報'),
  sedimentDisasterWarningInfo(23, '土砂災害警戒情報'),
  other(31, 'その他の警報等情報要素')
  ;

  const JmaWeatherRelatedDisasterSubCategory(this.code, this.nameJa);

  final int code;
  final String nameJa;

  /// Returns the weather related disaster sub category for the given code.
  ///
  /// Returns null if not found.
  static JmaWeatherRelatedDisasterSubCategory? fromCode(int code) =>
      JmaWeatherRelatedDisasterSubCategory.values
          .where((e) => e.code == code)
          .firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '警報等情報要素(コード番号：$code)';
}
