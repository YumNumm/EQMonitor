import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_delay.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

part 'kyoshin_monitor_image_request.freezed.dart';
part 'kyoshin_monitor_image_request.g.dart';

/// 画像取得に使う、設定から解決済みの値。
@freezed
abstract class KyoshinMonitorImageRequest with _$KyoshinMonitorImageRequest {
  const factory({
    required RealtimeLayer layer,
    required KyoshinMonitorSource source,
    required KyoshinMonitorDelayProfile delayProfile,
    required bool canSelectRealtimeLayer,
  }) = _KyoshinMonitorImageRequest;

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorImageRequestFromJson(json);
}
