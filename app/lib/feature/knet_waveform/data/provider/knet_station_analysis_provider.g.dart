// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'knet_station_analysis_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 観測点波形の重解析を非同期（Isolate）で実行するプロバイダー

@ProviderFor(knetStationAnalysis)
final knetStationAnalysisProvider = KnetStationAnalysisFamily._();

/// 観測点波形の重解析を非同期（Isolate）で実行するプロバイダー

final class KnetStationAnalysisProvider
    extends
        $FunctionalProvider<
          AsyncValue<KnetStationAnalysis>,
          KnetStationAnalysis,
          FutureOr<KnetStationAnalysis>
        >
    with
        $FutureModifier<KnetStationAnalysis>,
        $FutureProvider<KnetStationAnalysis> {
  /// 観測点波形の重解析を非同期（Isolate）で実行するプロバイダー
  KnetStationAnalysisProvider._({
    required KnetStationAnalysisFamily super.from,
    required KnetStationResult super.argument,
  }) : super(
         retry: null,
         name: r'knetStationAnalysisProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$knetStationAnalysisHash();

  @override
  String toString() {
    return r'knetStationAnalysisProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<KnetStationAnalysis> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<KnetStationAnalysis> create(Ref ref) {
    final argument = this.argument as KnetStationResult;
    return knetStationAnalysis(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is KnetStationAnalysisProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$knetStationAnalysisHash() =>
    r'136d4360f6badc68d34f5f2b140c5a312198edc3';

/// 観測点波形の重解析を非同期（Isolate）で実行するプロバイダー

final class KnetStationAnalysisFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<KnetStationAnalysis>,
          KnetStationResult
        > {
  KnetStationAnalysisFamily._()
    : super(
        retry: null,
        name: r'knetStationAnalysisProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 観測点波形の重解析を非同期（Isolate）で実行するプロバイダー

  KnetStationAnalysisProvider call(KnetStationResult result) =>
      KnetStationAnalysisProvider._(argument: result, from: this);

  @override
  String toString() => r'knetStationAnalysisProvider';
}
