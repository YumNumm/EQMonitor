import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_event.freezed.dart';
part 'seismicity_event.g.dart';

/// 公開版・デバッグ版(Hi-net)が共有する震源イベント。
///
/// データの出所(GeoJSON/Hi-netテキスト)を可視化層に露出しないための
/// アプリ固有の中間表現。
@freezed
abstract class SeismicityEvent with _$SeismicityEvent {
  const factory({
    /// イベントID(Hi-net由来は合成ID)
    required String eventId,

    /// 発生時刻
    required DateTime originTime,

    /// マグニチュード(不明な場合 null)
    required double? magnitude,

    /// 深さ(km、不明な場合 null)
    required double? depth,

    /// 緯度(度)
    required double latitude,

    /// 経度(度)
    required double longitude,

    /// 最大震度(Hi-net由来は null)
    required String? maxIntensity,
  }) = _SeismicityEvent;

  factory fromJson(Map<String, dynamic> json) =>
      _$SeismicityEventFromJson(json);
}
