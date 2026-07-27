// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_latest_earthquake_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveMonitorLatestEarthquake)
final liveMonitorLatestEarthquakeProvider =
    LiveMonitorLatestEarthquakeProvider._();

final class LiveMonitorLatestEarthquakeProvider
    extends
        $FunctionalProvider<
          AsyncValue<Earthquake?>,
          Earthquake?,
          FutureOr<Earthquake?>
        >
    with $FutureModifier<Earthquake?>, $FutureProvider<Earthquake?> {
  LiveMonitorLatestEarthquakeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorLatestEarthquakeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorLatestEarthquakeHash();

  @$internal
  @override
  $FutureProviderElement<Earthquake?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Earthquake?> create(Ref ref) {
    return liveMonitorLatestEarthquake(ref);
  }
}

String _$liveMonitorLatestEarthquakeHash() =>
    r'652c0fd525705df3ce1924561e9155e4ccbbc0f6';
