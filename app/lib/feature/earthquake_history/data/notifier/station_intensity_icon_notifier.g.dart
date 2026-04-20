// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'station_intensity_icon_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 地震履歴観測点震度アイコンの事前レンダリング済みバイト列キャッシュ。
///
/// アプリ起動時（ホーム画面表示時）に [EarthquakeHistoryStationIconPreloader]
/// が全アイコンを一括レンダリングし、このノーティファイアに格納する。
/// [EarthquakeHistoryStationIntensityLayer] はここから取得したバイト列を
/// `StyleController.addImage` で直接登録するため、マップ表示のたびに
/// ウィジェットをレンダリングするコストを省くことができる。

@ProviderFor(StationIntensityIconBytes)
final stationIntensityIconBytesProvider = StationIntensityIconBytesProvider._();

/// 地震履歴観測点震度アイコンの事前レンダリング済みバイト列キャッシュ。
///
/// アプリ起動時（ホーム画面表示時）に [EarthquakeHistoryStationIconPreloader]
/// が全アイコンを一括レンダリングし、このノーティファイアに格納する。
/// [EarthquakeHistoryStationIntensityLayer] はここから取得したバイト列を
/// `StyleController.addImage` で直接登録するため、マップ表示のたびに
/// ウィジェットをレンダリングするコストを省くことができる。
final class StationIntensityIconBytesProvider
    extends
        $NotifierProvider<StationIntensityIconBytes, Map<String, Uint8List>> {
  /// 地震履歴観測点震度アイコンの事前レンダリング済みバイト列キャッシュ。
  ///
  /// アプリ起動時（ホーム画面表示時）に [EarthquakeHistoryStationIconPreloader]
  /// が全アイコンを一括レンダリングし、このノーティファイアに格納する。
  /// [EarthquakeHistoryStationIntensityLayer] はここから取得したバイト列を
  /// `StyleController.addImage` で直接登録するため、マップ表示のたびに
  /// ウィジェットをレンダリングするコストを省くことができる。
  StationIntensityIconBytesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stationIntensityIconBytesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stationIntensityIconBytesHash();

  @$internal
  @override
  StationIntensityIconBytes create() => StationIntensityIconBytes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, Uint8List> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, Uint8List>>(value),
    );
  }
}

String _$stationIntensityIconBytesHash() =>
    r'c5fa154c852c7081386f6dd949c25d07331acf4b';

/// 地震履歴観測点震度アイコンの事前レンダリング済みバイト列キャッシュ。
///
/// アプリ起動時（ホーム画面表示時）に [EarthquakeHistoryStationIconPreloader]
/// が全アイコンを一括レンダリングし、このノーティファイアに格納する。
/// [EarthquakeHistoryStationIntensityLayer] はここから取得したバイト列を
/// `StyleController.addImage` で直接登録するため、マップ表示のたびに
/// ウィジェットをレンダリングするコストを省くことができる。

abstract class _$StationIntensityIconBytes
    extends $Notifier<Map<String, Uint8List>> {
  Map<String, Uint8List> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<Map<String, Uint8List>, Map<String, Uint8List>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, Uint8List>, Map<String, Uint8List>>,
              Map<String, Uint8List>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
