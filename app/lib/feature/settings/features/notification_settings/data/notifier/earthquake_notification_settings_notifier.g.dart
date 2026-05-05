// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_notification_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeNotificationSettingsNotifier)
final earthquakeNotificationSettingsProvider =
    EarthquakeNotificationSettingsNotifierProvider._();

final class EarthquakeNotificationSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeNotificationSettingsNotifier,
          EarthquakeNotificationSettings
        > {
  EarthquakeNotificationSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeNotificationSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$earthquakeNotificationSettingsNotifierHash();

  @$internal
  @override
  EarthquakeNotificationSettingsNotifier create() =>
      EarthquakeNotificationSettingsNotifier();
}

String _$earthquakeNotificationSettingsNotifierHash() =>
    r'4287b958cc0e839fd2207f6c9a5425f245d1f668';

abstract class _$EarthquakeNotificationSettingsNotifier
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
