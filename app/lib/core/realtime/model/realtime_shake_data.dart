import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_shake_data.freezed.dart';
part 'realtime_shake_data.g.dart';

@freezed
abstract class RealtimeShakeData with _$RealtimeShakeData {
  const factory RealtimeShakeData({
    required String eventId,
    required DateTime createdAt,
    required String level,
    required bool isReplay,
    required int pointCount,
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    @Default([]) List<String> changeReasons,
  }) = _RealtimeShakeData;

  factory RealtimeShakeData.fromJson(Map<String, dynamic> json) =>
      _$RealtimeShakeDataFromJson(json);
}
