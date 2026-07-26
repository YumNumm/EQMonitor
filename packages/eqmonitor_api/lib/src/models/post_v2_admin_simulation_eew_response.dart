// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_v2_admin_simulation_eew_response.freezed.dart';
part 'post_v2_admin_simulation_eew_response.g.dart';

@Freezed()
abstract class PostV2AdminSimulationEewResponse with _$PostV2AdminSimulationEewResponse {
  const factory PostV2AdminSimulationEewResponse({
    /// const: true
    required bool ok,
    required String eventId,
    required num totalReports,
    required String scenario,
    required String targetDeviceId,
    required num intervalMs,
    required num durationMs,
  }) = _PostV2AdminSimulationEewResponse;
  
  factory PostV2AdminSimulationEewResponse.fromJson(Map<String, Object?> json) => _$PostV2AdminSimulationEewResponseFromJson(json);
}
