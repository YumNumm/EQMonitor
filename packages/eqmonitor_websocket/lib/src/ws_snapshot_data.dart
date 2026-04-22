import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_snapshot_data.freezed.dart';
part 'ws_snapshot_data.g.dart';

@freezed
abstract class WsSnapshotData with _$WsSnapshotData {
  const factory WsSnapshotData({
    required int revision,
    required DateTime updatedAt,
    @Default([]) List<EewItemWithRelations> eews,
    @Default([]) List<EarthquakePartial> earthquakes,
  }) = _WsSnapshotData;

  factory WsSnapshotData.fromJson(Map<String, dynamic> json) =>
      _$WsSnapshotDataFromJson(json);
}
