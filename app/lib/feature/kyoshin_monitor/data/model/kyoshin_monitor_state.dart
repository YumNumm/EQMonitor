import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:kyoshin_observation_point_types/kyoshin_observation_point.pb.dart';

part 'kyoshin_monitor_state.freezed.dart';
part 'kyoshin_monitor_state.g.dart';

@freezed
class KyoshinMonitorState with _$KyoshinMonitorState {
  const factory KyoshinMonitorState({
    RealtimeDataType? currentRealtimeDataType,
    RealtimeLayer? currentRealtimeLayer,
    @Default(KyoshinMonitorStatus.initializing)
    KyoshinMonitorStatus status,
    DateTime? lastUpdatedAt,
    DateTime? lastImageFetchTargetTime,
    Duration? lastImageFetchDuration,
    List<KyoshinMonitorImageParseObservationPoint>?
    analyzedPoints,
    List<int>? currentImageRaw,
  }) = _KyoshinMonitorState;

  factory KyoshinMonitorState.fromJson(
    Map<String, dynamic> json,
  ) => _$KyoshinMonitorStateFromJson(json);
}

enum KyoshinMonitorStatus {
  /// リアルタイム
  realtime,

  /// 遅延
  delayed,

  /// playback
  playback,

  /// 停止
  stopped,

  // 初期化中
  initializing,
}

@freezed
class KyoshinMonitorImageParseObservationPoint
    with _$KyoshinMonitorImageParseObservationPoint {
  const factory KyoshinMonitorImageParseObservationPoint({
    @JsonKey(
      fromJson: _kyoshinObservationPointFromJson,
      toJson: _kyoshinObservationPointToJson,
    )
    required KyoshinObservationPoint point,
    required KyoshinMonitorObservationAnalyzedPoint
    observation,
  }) = _KyoshinMonitorImageParseObservationPoint;

  factory KyoshinMonitorImageParseObservationPoint.fromJson(
    Map<String, dynamic> json,
  ) => _$KyoshinMonitorImageParseObservationPointFromJson(
    json,
  );
}

Map<String, dynamic> _kyoshinObservationPointToJson(
  KyoshinObservationPoint point,
) => point.writeToJsonMap();

KyoshinObservationPoint _kyoshinObservationPointFromJson(
  Map<String, dynamic> json,
) => KyoshinObservationPoint.fromJson(jsonEncode(json));
