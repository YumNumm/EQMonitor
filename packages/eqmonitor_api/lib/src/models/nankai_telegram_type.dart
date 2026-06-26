// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum NankaiTelegramType {
  /// Incorrect name has been replaced. Original name: `南海トラフ地震臨時情報`.
  @JsonValue('南海トラフ地震臨時情報')
  undefined0('南海トラフ地震臨時情報'),
  /// Incorrect name has been replaced. Original name: `南海トラフ地震関連解説情報`.
  @JsonValue('南海トラフ地震関連解説情報')
  undefined1('南海トラフ地震関連解説情報'),
  /// Incorrect name has been replaced. Original name: `北海道・三陸沖後発地震注意情報`.
  @JsonValue('北海道・三陸沖後発地震注意情報')
  undefined2('北海道・三陸沖後発地震注意情報');

  const NankaiTelegramType(this.json);

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
