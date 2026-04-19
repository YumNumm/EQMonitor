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
        isAutoDispose: true,
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
    r'689b044b05f29bafbec54b8fcd38bc7e739f4281';

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
