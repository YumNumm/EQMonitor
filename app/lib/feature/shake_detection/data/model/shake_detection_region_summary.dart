/// 揺れ検知カードに表示する、揺れを検知した範囲の要約。
final class const ShakeDetectionRegionSummary({
  required final List<ShakeDetectionRegionEntry> entries,

  /// 検知した都道府県が多く、地方単位にまとめた場合は `true`。
  /// この場合、各項目は名前だけを持つ。
  required final bool isGrouped,
});

final class const ShakeDetectionRegionEntry({
  /// 都道府県名、または地方名。
  required final String name,

  /// 都道府県内の地域の内訳。「全域」や地域名の列挙。内訳を出さない場合は `null`。
  required final String? detail,
});
