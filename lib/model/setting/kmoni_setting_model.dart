import 'package:freezed_annotation/freezed_annotation.dart';

part 'kmoni_setting_model.freezed.dart';
part 'kmoni_setting_model.g.dart';

/// 強震モニタ画面の表示設定
@freezed
class KmoniSettingModel with _$KmoniSettingModel {
  const factory KmoniSettingModel({
    @Default(<KmoniLayer>{
      KmoniLayer.baseMap,
      KmoniLayer.psWaveArrivalCircle,
      KmoniLayer.psWaveArrivalCircleStroke,
      KmoniLayer.kmoniPoints,
      KmoniLayer.realtimeIntensityIcon,
    })
        Set<KmoniLayer> layers,

    /// EEWUI
    @Default(false)
        bool showHypocenterAccuracy,
    @Default(false)
        bool showEventId,
  }) = _KmoniSettingModel;

  factory KmoniSettingModel.fromJson(Map<String, dynamic> json) =>
      _$KmoniSettingModelFromJson(json);
}

enum KmoniLayer {
  /// ベースマップ
  baseMap('ベースマップ', ''),

  /// P/S波到達予想円塗りつぶし
  psWaveArrivalCircle('P/S波到達予想円塗りつぶし', ''),

  /// 距離減衰式による予想震度
  distanceDecayIntensity('距離減衰式による予想震度', ''),

  /// 気象庁による予想震度(震度4以上)
  jmaIntensity('気象庁による予想震度(震度4以上)', ''),

  /// 強震観測点
  kmoniPoints('強震観測点', ''),

  /// リアルタイム震度アイコン
  realtimeIntensityIcon('リアルタイム震度アイコン', ''),

  /// P/S波到達予想円 枠
  psWaveArrivalCircleStroke('P/S波到達予想円 枠', '');

  const KmoniLayer(
    this.name,
    this.description,
  );

  final String name;
  final String description;
}
