import 'dart:convert';

/// VXSEデバッグeditorのフォーム項目に付与するsemantic keyを組み立てる。
///
/// リスト項目の並び替え・削除後もWidgetの識別子（フォーカス・raw入力状態）を
/// 安定させるため、値をbase64url化したコンポーネントからprefixを構築する。
class EarthquakeVxseDebugEditorSemanticKey {
  const new();

  String component(String value) =>
      base64Url.encode(utf8.encode(value)).replaceAll('=', '');

  String prefix(String surface, List<String> components) =>
      [surface, ...components.map(component)].join('.');

  String prePeriodPrefix({
    required String stationPrefix,
    required String band,
    required String occurrence,
  }) => '$stationPrefix.${prefix('prePeriod', [band, occurrence])}';

  String withComponent({
    required String prefix,
    required int segmentIndex,
    required String value,
  }) {
    final components = prefix.split('.');
    components[segmentIndex] = component(value);
    return components.join('.');
  }
}
