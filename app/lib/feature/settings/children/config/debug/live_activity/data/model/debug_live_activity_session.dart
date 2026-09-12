// ignore_for_file: unnecessary_type_name_in_constructor

import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_live_activity_session.freezed.dart';

/// ActivityKit が保持している Live Activity の識別情報。
@freezed
abstract class DebugLiveActivitySession with _$DebugLiveActivitySession {
  const DebugLiveActivitySession._();

  const factory DebugLiveActivitySession({
    required String activityId,
    required String logicalId,
    required String? eventId,
  }) = _DebugLiveActivitySession;

  factory DebugLiveActivitySession.fromJson(Map<String, dynamic> json) {
    final reader = UnifiedLiveActivityJsonReader(json, label: 'session');
    return DebugLiveActivitySession(
      activityId: reader.requiredString('activityId', nonEmpty: true),
      logicalId: reader.requiredString('logicalId', nonEmpty: true),
      eventId: reader.optionalNonNullString('eventId'),
    );
  }
}
