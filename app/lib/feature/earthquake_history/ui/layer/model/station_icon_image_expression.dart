import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';

/// 観測点シンボルレイヤーの `icon-image` 式を表示モードから組み立てる
class StationIconImageExpressionBuilder {
  const new();

  /// GeoJSON feature は以下のプロパティを持つ前提:
  /// - `iconIdFull`: 数字入りアイコンの画像 ID
  /// - `iconIdPlain`: 色のみアイコンの画像 ID
  /// - `isMax`: その地震の最大震度観測点か
  Object build({
    required StationDisplayMode stationDisplayMode,
    required double stationTextZoom,
  }) {
    const full = ['get', 'iconIdFull'];
    const plain = ['get', 'iconIdPlain'];
    const maxOnly = [
      'case',
      ['get', 'isMax'],
      full,
      plain,
    ];
    return switch (stationDisplayMode) {
      StationDisplayMode.auto => [
        'step',
        ['zoom'],
        maxOnly,
        stationTextZoom,
        full,
      ],
      StationDisplayMode.maxFocused => maxOnly,
      StationDisplayMode.normal => full,
      StationDisplayMode.allMinimized => plain,
    };
  }
}
