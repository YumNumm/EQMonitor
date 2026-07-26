// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'scenario.dart';

part 'v2_admin_simulation_eew_request_body.freezed.dart';
part 'v2_admin_simulation_eew_request_body.g.dart';

@Freezed()
abstract class V2AdminSimulationEewRequestBody with _$V2AdminSimulationEewRequestBody {
  const factory V2AdminSimulationEewRequestBody({
    required Scenario scenario,
    required String targetDeviceId,
    @JsonKey(includeIfNull: true)
    @Default(60)
    int? totalReports,
    @JsonKey(includeIfNull: true)
    @Default(100)
    int? intervalMs,
  }) = _V2AdminSimulationEewRequestBody;
  
  factory V2AdminSimulationEewRequestBody.fromJson(Map<String, Object?> json) => _$V2AdminSimulationEewRequestBodyFromJson(json);
}
