// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_config_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeHistoryConfigNotifier)
final earthquakeHistoryConfigProvider =
    EarthquakeHistoryConfigNotifierProvider._();

final class EarthquakeHistoryConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeHistoryConfigNotifier,
          EarthquakeHistoryConfig
        > {
  EarthquakeHistoryConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeHistoryConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryConfigNotifierHash();

  @$internal
  @override
  EarthquakeHistoryConfigNotifier create() => EarthquakeHistoryConfigNotifier();
}

String _$earthquakeHistoryConfigNotifierHash() =>
    r'8d04a779c027288dc89ce18f96d7c90d0ad0c6be';

abstract class _$EarthquakeHistoryConfigNotifier
    extends $AsyncNotifier<EarthquakeHistoryConfig> {
  FutureOr<EarthquakeHistoryConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EarthquakeHistoryConfig>,
              EarthquakeHistoryConfig
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeHistoryConfig>,
                EarthquakeHistoryConfig
              >,
              AsyncValue<EarthquakeHistoryConfig>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
