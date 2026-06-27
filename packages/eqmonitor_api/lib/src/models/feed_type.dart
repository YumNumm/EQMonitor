// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// const: "EARTHQUAKE_NOTICE" | const: "EARTHQUAKE_EXPLANATION" | const: "EARTHQUAKE_COUNTS" | const: "EARTHQUAKE_NANKAI" | const: "APP_UPDATE" | const: "INCIDENT" | const: "DEVELOPER_MESSAGE"
@JsonEnum()
enum FeedType {
  @JsonValue('EARTHQUAKE_NOTICE')
  earthquakeNotice('EARTHQUAKE_NOTICE'),
  @JsonValue('EARTHQUAKE_EXPLANATION')
  earthquakeExplanation('EARTHQUAKE_EXPLANATION'),
  @JsonValue('EARTHQUAKE_COUNTS')
  earthquakeCounts('EARTHQUAKE_COUNTS'),
  @JsonValue('EARTHQUAKE_NANKAI')
  earthquakeNankai('EARTHQUAKE_NANKAI'),
  @JsonValue('APP_UPDATE')
  appUpdate('APP_UPDATE'),
  @JsonValue('INCIDENT')
  incident('INCIDENT'),
  @JsonValue('DEVELOPER_MESSAGE')
  developerMessage('DEVELOPER_MESSAGE');

  const FeedType(this.json);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
