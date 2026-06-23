// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum TsunamiWarningKind {
  /// 大津波警報 (code: 52, 53)
  @JsonValue('MAJOR_WARNING')
  majorWarning('MAJOR_WARNING'),
  /// 津波警報 (code: 51)
  @JsonValue('WARNING')
  warning('WARNING'),
  /// 大津波警報解除 または 津波警報解除 (code: 50)
  @JsonValue('WARNING_CANCEL')
  warningCancel('WARNING_CANCEL'),
  /// 津波注意報 (code: 62)
  @JsonValue('ADVISORY')
  advisory('ADVISORY'),
  /// 津波注意報解除 (code: 60)
  @JsonValue('ADVISORY_CANCEL')
  advisoryCancel('ADVISORY_CANCEL'),
  /// 津波予報（若干の海面変動） (code: 71, 72, 73)
  @JsonValue('FORECAST')
  forecast('FORECAST'),
  /// 津波なし (code: 00)
  @JsonValue('NONE')
  none('NONE');

  const TsunamiWarningKind(this.json);

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
