// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'knet_waveform_download_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 指定した地震発生時刻の ZIP をダウンロード・解凍・パースし、
/// 観測点コードでグループ化した記録マップを返す @riverpod provider
///
/// [eventTimeMs] は DateTime.millisecondsSinceEpoch（URL パラメータとして使用）

@ProviderFor(knetWaveformDownload)
final knetWaveformDownloadProvider = KnetWaveformDownloadFamily._();

/// 指定した地震発生時刻の ZIP をダウンロード・解凍・パースし、
/// 観測点コードでグループ化した記録マップを返す @riverpod provider
///
/// [eventTimeMs] は DateTime.millisecondsSinceEpoch（URL パラメータとして使用）

final class KnetWaveformDownloadProvider
    extends
        $FunctionalProvider<
          AsyncValue<KnetStationRecords>,
          KnetStationRecords,
          FutureOr<KnetStationRecords>
        >
    with
        $FutureModifier<KnetStationRecords>,
        $FutureProvider<KnetStationRecords> {
  /// 指定した地震発生時刻の ZIP をダウンロード・解凍・パースし、
  /// 観測点コードでグループ化した記録マップを返す @riverpod provider
  ///
  /// [eventTimeMs] は DateTime.millisecondsSinceEpoch（URL パラメータとして使用）
  KnetWaveformDownloadProvider._({
    required KnetWaveformDownloadFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'knetWaveformDownloadProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$knetWaveformDownloadHash();

  @override
  String toString() {
    return r'knetWaveformDownloadProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<KnetStationRecords> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<KnetStationRecords> create(Ref ref) {
    final argument = this.argument as int;
    return knetWaveformDownload(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is KnetWaveformDownloadProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$knetWaveformDownloadHash() =>
    r'ceb3d7e987e3c9aa5e6c9aae2eff2a2747da49b9';

/// 指定した地震発生時刻の ZIP をダウンロード・解凍・パースし、
/// 観測点コードでグループ化した記録マップを返す @riverpod provider
///
/// [eventTimeMs] は DateTime.millisecondsSinceEpoch（URL パラメータとして使用）

final class KnetWaveformDownloadFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<KnetStationRecords>, int> {
  KnetWaveformDownloadFamily._()
    : super(
        retry: null,
        name: r'knetWaveformDownloadProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 指定した地震発生時刻の ZIP をダウンロード・解凍・パースし、
  /// 観測点コードでグループ化した記録マップを返す @riverpod provider
  ///
  /// [eventTimeMs] は DateTime.millisecondsSinceEpoch（URL パラメータとして使用）

  KnetWaveformDownloadProvider call(int eventTimeMs) =>
      KnetWaveformDownloadProvider._(argument: eventTimeMs, from: this);

  @override
  String toString() => r'knetWaveformDownloadProvider';
}
