// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'knet_event_stations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// イベント時刻に対応するすべての観測点の CSV を取得し震度計算結果を返す

@ProviderFor(knetEventStations)
final knetEventStationsProvider = KnetEventStationsFamily._();

/// イベント時刻に対応するすべての観測点の CSV を取得し震度計算結果を返す

final class KnetEventStationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<KnetStationResult>>,
          List<KnetStationResult>,
          FutureOr<List<KnetStationResult>>
        >
    with
        $FutureModifier<List<KnetStationResult>>,
        $FutureProvider<List<KnetStationResult>> {
  /// イベント時刻に対応するすべての観測点の CSV を取得し震度計算結果を返す
  KnetEventStationsProvider._({
    required KnetEventStationsFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'knetEventStationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$knetEventStationsHash();

  @override
  String toString() {
    return r'knetEventStationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<KnetStationResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<KnetStationResult>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return knetEventStations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is KnetEventStationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$knetEventStationsHash() => r'dc0767c9f00021a49e453a7901e5241f7f129809';

/// イベント時刻に対応するすべての観測点の CSV を取得し震度計算結果を返す

final class KnetEventStationsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<KnetStationResult>>, DateTime> {
  KnetEventStationsFamily._()
    : super(
        retry: null,
        name: r'knetEventStationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// イベント時刻に対応するすべての観測点の CSV を取得し震度計算結果を返す

  KnetEventStationsProvider call(DateTime eventTime) =>
      KnetEventStationsProvider._(argument: eventTime, from: this);

  @override
  String toString() => r'knetEventStationsProvider';
}
