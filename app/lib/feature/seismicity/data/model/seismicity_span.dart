import 'package:json_annotation/json_annotation.dart';

/// GeoJSON層の対象期間(manifest の `span` フィールドと対応)
enum SeismicitySpan {
  @JsonValue('P1M')
  p1m,
  @JsonValue('P3M')
  p3m,
  @JsonValue('P12M')
  p12m,
}

/// manifest の `span` 文字列から [SeismicitySpan] を復元する。
///
/// json_serializable の `@JsonValue` はモデルの `fromJson` 内でのみ機能するため、
/// キャッシュファイル名の組み立て等モデル外で文字列を扱う箇所向けに
/// 明示的な変換関数を用意する。
SeismicitySpan seismicitySpanFromApiValue(String value) => switch (value) {
  'P1M' => SeismicitySpan.p1m,
  'P3M' => SeismicitySpan.p3m,
  'P12M' => SeismicitySpan.p12m,
  _ => throw FormatException('Unknown SeismicitySpan value: $value'),
};

extension SeismicitySpanApiValue on SeismicitySpan {
  String get apiValue => switch (this) {
    SeismicitySpan.p1m => 'P1M',
    SeismicitySpan.p3m => 'P3M',
    SeismicitySpan.p12m => 'P12M',
  };
}
