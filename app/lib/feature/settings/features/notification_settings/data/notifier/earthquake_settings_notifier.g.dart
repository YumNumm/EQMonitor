// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeSettingsNotifier)
final earthquakeSettingsProvider = EarthquakeSettingsNotifierProvider._();

final class EarthquakeSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeSettingsNotifier,
          EarthquakeNotificationSettings
        > {
  EarthquakeSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeSettingsNotifierHash();

  @$internal
  @override
  EarthquakeSettingsNotifier create() => EarthquakeSettingsNotifier();
}

String _$earthquakeSettingsNotifierHash() =>
    r'92c53e493b44dcd8d92c8a39a8f43cbcf5d0e024';

abstract class _$EarthquakeSettingsNotifier
    extends $AsyncNotifier<EarthquakeNotificationSettings> {
  FutureOr<EarthquakeNotificationSettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EarthquakeNotificationSettings>,
              EarthquakeNotificationSettings
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeNotificationSettings>,
                EarthquakeNotificationSettings
              >,
              AsyncValue<EarthquakeNotificationSettings>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
