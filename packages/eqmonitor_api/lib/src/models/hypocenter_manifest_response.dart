// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data2.dart';
import 'hypocenter_meta.dart';

part 'hypocenter_manifest_response.freezed.dart';
part 'hypocenter_manifest_response.g.dart';

@Freezed()
abstract class HypocenterManifestResponse with _$HypocenterManifestResponse {
  const factory HypocenterManifestResponse({
    required Data2 data,
    required HypocenterMeta meta,
  }) = _HypocenterManifestResponse;

  factory HypocenterManifestResponse.fromJson(Map<String, Object?> json) => _$HypocenterManifestResponseFromJson(json);
}
