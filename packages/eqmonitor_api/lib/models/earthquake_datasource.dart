// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 地震データのソース
@JsonEnum()
enum EarthquakeDatasource {
  @JsonValue('JMA_INTENSITY_DATABASE')
  jmaIntensityDatabase('JMA_INTENSITY_DATABASE'),
  @JsonValue('JMA_DISASTER_INFORMATION_XML')
  jmaDisasterInformationXml('JMA_DISASTER_INFORMATION_XML');

  const EarthquakeDatasource(this.json);

  final dynamic json;
  dynamic toJson() {
    final value = json;
    if (value == null) {
      throw StateError(
        'Cannot convert enum value with null JSON representation to dynamic. '
        'This usually happens for \$unknown or @JsonValue(null) entries.',
      );
    }
    return value as dynamic;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
