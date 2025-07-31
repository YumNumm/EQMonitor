// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_config_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EarthquakeHistoryConfigNotifier)
const earthquakeHistoryConfigNotifierProvider =
    EarthquakeHistoryConfigNotifierProvider._();

final class EarthquakeHistoryConfigNotifierProvider
    extends
        $NotifierProvider<
          EarthquakeHistoryConfigNotifier,
          EarthquakeHistoryConfig
        > {
  const EarthquakeHistoryConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeHistoryConfigNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryConfigNotifierHash();

  @$internal
  @override
  EarthquakeHistoryConfigNotifier create() => EarthquakeHistoryConfigNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeHistoryConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeHistoryConfig>(value),
    );
  }
}

String _$earthquakeHistoryConfigNotifierHash() =>
    r'c133b5e0380ca6ba952eedc00a37ae65284751cd';

abstract class _$EarthquakeHistoryConfigNotifier
    extends $Notifier<EarthquakeHistoryConfig> {
  EarthquakeHistoryConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<EarthquakeHistoryConfig, EarthquakeHistoryConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EarthquakeHistoryConfig, EarthquakeHistoryConfig>,
              EarthquakeHistoryConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
