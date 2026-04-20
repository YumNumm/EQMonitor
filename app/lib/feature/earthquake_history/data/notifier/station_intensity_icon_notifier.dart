import 'dart:typed_data';

import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_station_icon_preloader.dart'
    show EarthquakeHistoryStationIconPreloader;
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart'
    show EarthquakeHistoryStationIntensityLayer;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'station_intensity_icon_notifier.g.dart';

/// 地震履歴観測点震度アイコンの事前レンダリング済みバイト列キャッシュ。
///
/// アプリ起動時（ホーム画面表示時）に [EarthquakeHistoryStationIconPreloader]
/// が全アイコンを一括レンダリングし、このノーティファイアに格納する。
/// [EarthquakeHistoryStationIntensityLayer] はここから取得したバイト列を
/// `StyleController.addImage` で直接登録するため、マップ表示のたびに
/// ウィジェットをレンダリングするコストを省くことができる。
@Riverpod(keepAlive: true)
class StationIntensityIconBytes extends _$StationIntensityIconBytes {
  @override
  Map<String, Uint8List> build() => {};

  /// 生成済みアイコンをまとめて登録する。
  void storeAll(Map<String, Uint8List> icons) {
    state = {...state, ...icons};
  }
}
