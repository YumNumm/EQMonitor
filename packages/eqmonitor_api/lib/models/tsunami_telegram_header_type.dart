// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum TsunamiTelegramHeaderType {
  @JsonValue('VTSE41')
  vtse41('VTSE41'),
  @JsonValue('VTSE51')
  vtse51('VTSE51'),
  @JsonValue('VTSE52')
  vtse52('VTSE52');

  const TsunamiTelegramHeaderType(this.json);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
