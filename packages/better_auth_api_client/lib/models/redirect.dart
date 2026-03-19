// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum Redirect {
  /// The name has been replaced because it contains a keyword. Original name: `false`.
  @JsonValue('false')
  valueFalse('false');

  const Redirect(this.json);

  final String json;
  String toJson() => json;

  @override
  String toString() => json.toString();
}
