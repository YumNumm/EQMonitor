// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 地震データのソース
@JsonEnum()
enum EarthquakeDatasourceEnum {
  @JsonValue('JMA_INTENSITY_DATABASE')
  jmaIntensityDatabase('JMA_INTENSITY_DATABASE'),
  @JsonValue('JMA_DISASTER_INFORMATION_XML')
  jmaDisasterInformationXml('JMA_DISASTER_INFORMATION_XML');

  const EarthquakeDatasourceEnum(this.json);

  final dynamic json;

  dynamic toJson() => json;

  @override
  String toString() => json?.toString() ?? super.toString();
}
