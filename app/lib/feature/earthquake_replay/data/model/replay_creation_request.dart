import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

part 'replay_creation_request.freezed.dart';

enum ReplayCreationImageKind(
  final String label,
  final RealtimeDataType dataType,
  final ImageType imageType,
) {
  shindo('震度', .shindo, .shindo),
  pga('最大加速度', .pga, .pga),
  pgv('最大速度', .pgv, .pgv),
}

@freezed
abstract class const ReplayCreationRequest._() with _$ReplayCreationRequest {
  const factory({
    required DateTime startTime,
    required Duration duration,
    required Set<ReplayCreationImageKind> imageKinds,
    required bool includeEew,
    required bool includePreRoll,
    @Default('') String name,
    @Default('') String directory,
  }) = _ReplayCreationRequest;

  DateTime get endTime => startTime.add(duration);
}

@freezed
abstract class ReplayCreationProgress with _$ReplayCreationProgress {
  const factory({required int completed, required int total}) =
      _ReplayCreationProgress;
}
