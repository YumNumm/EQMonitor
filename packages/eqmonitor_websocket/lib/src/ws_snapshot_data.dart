import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:eqmonitor_websocket/src/ws_shake_payload.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_snapshot_data.freezed.dart';
part 'ws_snapshot_data.g.dart';

/// スナップショット内の揺れ検知エントリ。バックエンドの ShakeDetectedPayload に対応。
@freezed
abstract class WsSnapshotShakeEntry with _$WsSnapshotShakeEntry {
  const factory WsSnapshotShakeEntry({
    required String eventId,
    required DateTime createdAt,
    required String level,
    @Default([]) List<String> changeReasons,
    required bool isReplay,
    required int pointCount,
    required WsShakeRegionPayload region,
  }) = _WsSnapshotShakeEntry;

  factory WsSnapshotShakeEntry.fromJson(Map<String, dynamic> json) =>
      _$WsSnapshotShakeEntryFromJson(json);
}

@freezed
abstract class WsSnapshotData with _$WsSnapshotData {
  const factory WsSnapshotData({
    required int revision,
    required DateTime updatedAt,
    @Default([]) List<WsSnapshotShakeEntry> shakes,
    @Default([]) List<EewItemWithRelations> eews,
    @Default([]) List<EarthquakePartial> earthquakes,
  }) = _WsSnapshotData;

  factory WsSnapshotData.fromJson(Map<String, dynamic> json) =>
      _$WsSnapshotDataFromJson(json);
}
