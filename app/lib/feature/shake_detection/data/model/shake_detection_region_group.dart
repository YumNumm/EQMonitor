/// 揺れを検知した都道府県と、その中の地域（緊急地震速報の予報区）。
final class const ShakeDetectionRegionGroup({
  required final String prefectureCode,
  required final String prefectureName,

  /// 都道府県名を除いた地域名。
  required final List<String> regionNames,

  /// 観測点のある地域のすべてで検知している場合は `true`。
  required final bool isWholePrefecture,
});
