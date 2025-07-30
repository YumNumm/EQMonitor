// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'earthquake_notification_settings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EarthquakeNotificationSettingsViewModel)
const earthquakeNotificationSettingsViewModelProvider =
    EarthquakeNotificationSettingsViewModelProvider._();

final class EarthquakeNotificationSettingsViewModelProvider
    extends
        $NotifierProvider<
          EarthquakeNotificationSettingsViewModel,
          FcmEarthquakeTopic?
        > {
  const EarthquakeNotificationSettingsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeNotificationSettingsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$earthquakeNotificationSettingsViewModelHash();

  @$internal
  @override
  EarthquakeNotificationSettingsViewModel create() =>
      EarthquakeNotificationSettingsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FcmEarthquakeTopic? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FcmEarthquakeTopic?>(value),
    );
  }
}

String _$earthquakeNotificationSettingsViewModelHash() =>
    r'5a362a2d083e95cf8afb1f35a5c913812cfc9073';

abstract class _$EarthquakeNotificationSettingsViewModel
    extends $Notifier<FcmEarthquakeTopic?> {
  FcmEarthquakeTopic? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FcmEarthquakeTopic?, FcmEarthquakeTopic?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FcmEarthquakeTopic?, FcmEarthquakeTopic?>,
              FcmEarthquakeTopic?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
