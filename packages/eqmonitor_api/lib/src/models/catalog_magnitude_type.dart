// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// マグニチュード種別。J:旧観測網による坪井変位マグニチュード、D:坪井変位マグニチュードに準拠した変位マグニチュード、d:Dに同じで観測点数が少ないもの、V:Dに準拠した速度マグニチュード、v:Vに同じで観測点数が少ないもの、W:気象庁CMTまたはUSGS等によるモーメントマグニチュード、B:USGS等による実体波マグニチュード、S:USGS等による表面波マグニチュード
@JsonEnum()
enum CatalogMagnitudeType {
  @JsonValue('J')
  j('J'),
  @JsonValue('D')
  upperD('D'),
  @JsonValue('d')
  lowerD('d'),
  @JsonValue('V')
  upperV('V'),
  @JsonValue('v')
  lowerV('v'),
  @JsonValue('W')
  w('W'),
  @JsonValue('B')
  b('B'),
  @JsonValue('S')
  s('S');

  const CatalogMagnitudeType(this.json);

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
