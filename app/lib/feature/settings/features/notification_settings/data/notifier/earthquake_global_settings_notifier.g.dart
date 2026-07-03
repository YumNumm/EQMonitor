// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_global_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeGlobalSettingsNotifier)
final earthquakeGlobalSettingsProvider =
    EarthquakeGlobalSettingsNotifierProvider._();

final class EarthquakeGlobalSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeGlobalSettingsNotifier,
          EarthquakeGlobalSettings
        > {
  EarthquakeGlobalSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeGlobalSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeGlobalSettingsNotifierHash();

  @$internal
  @override
  EarthquakeGlobalSettingsNotifier create() =>
      EarthquakeGlobalSettingsNotifier();
}

String _$earthquakeGlobalSettingsNotifierHash() =>
    r'08b1682a7b3c91453ce16a4b6c2e4faef2baaf29';

abstract class _$EarthquakeGlobalSettingsNotifier
    extends $AsyncNotifier<EarthquakeGlobalSettings> {
  FutureOr<EarthquakeGlobalSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EarthquakeGlobalSettings>,
              EarthquakeGlobalSettings
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeGlobalSettings>,
                EarthquakeGlobalSettings
              >,
              AsyncValue<EarthquakeGlobalSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
