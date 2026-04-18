// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 情報名称(Control/Title部)
@JsonEnum()
enum TelegramType {
  @JsonValue('VZSE40')
  vzse40('VZSE40'),
  @JsonValue('VXSE42')
  vxse42('VXSE42'),
  @JsonValue('VXSE43')
  vxse43('VXSE43'),
  @JsonValue('VXSE44')
  vxse44('VXSE44'),
  @JsonValue('VXSE45')
  vxse45('VXSE45'),
  @JsonValue('VXSE47')
  vxse47('VXSE47'),
  @JsonValue('VTSE41')
  vtse41('VTSE41'),
  @JsonValue('VTSE51')
  vtse51('VTSE51'),
  @JsonValue('VTSE52')
  vtse52('VTSE52'),
  @JsonValue('VXSE51')
  vxse51('VXSE51'),
  @JsonValue('VXSE52')
  vxse52('VXSE52'),
  @JsonValue('VXSE53')
  vxse53('VXSE53'),
  @JsonValue('VXSE56')
  vxse56('VXSE56'),
  @JsonValue('VXSE60')
  vxse60('VXSE60'),
  @JsonValue('VXSE61')
  vxse61('VXSE61'),
  @JsonValue('VXSE62')
  vxse62('VXSE62'),
  @JsonValue('NANKAI')
  nankai('NANKAI'),
  @JsonValue('VYSE60')
  vyse60('VYSE60'),
  @JsonValue('SHINDO_DB')
  shindoDb('SHINDO_DB')
  ;

  const TelegramType(this.json);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError(
        'Cannot convert enum value with null JSON representation to String. '
        'This usually happens for \$unknown or @JsonValue(null) entries.',
      );
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
