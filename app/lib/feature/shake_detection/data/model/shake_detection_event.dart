import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
// freezed の深い copyWith 生成が aliased import 越しの Freezed クラスを
// 解決できないため、揺れ検知レベルの enum のみ hide してエイリアス無しで import する。
import 'package:eqmonitor_api/eqmonitor_api.dart' hide ShakeDetectionLevel;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_event.freezed.dart';

@Freezed()
abstract class ShakeDetectionEvent with _$ShakeDetectionEvent {
  const factory({
    required String eventId,
    required int serialNo,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    required ShakeDetectionLevel level,
    required int pointCount,
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    required List<String> changeReasons,
    String? correlatedEewEventId,
    @Default([]) List<MergedEvents> mergedEvents,
    @Default([]) List<Points> points,
    CorrelatedEew? correlatedEew,
  }) = _ShakeDetectionEvent;
}
