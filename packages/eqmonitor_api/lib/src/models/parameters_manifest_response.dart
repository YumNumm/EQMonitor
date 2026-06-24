// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'parameter_manifest_item.dart';

part 'parameters_manifest_response.freezed.dart';
part 'parameters_manifest_response.g.dart';

@Freezed()
abstract class ParametersManifestResponse with _$ParametersManifestResponse {
  const factory ParametersManifestResponse({
    required List<ParameterManifestItem> parameters,
  }) = _ParametersManifestResponse;
  
  factory ParametersManifestResponse.fromJson(Map<String, Object?> json) => _$ParametersManifestResponseFromJson(json);
}
