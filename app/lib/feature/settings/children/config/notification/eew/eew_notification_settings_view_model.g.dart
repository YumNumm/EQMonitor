// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_notification_settings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewNotificationsSettingsViewModel)
final eewNotificationsSettingsViewModelProvider =
    EewNotificationsSettingsViewModelProvider._();

final class EewNotificationsSettingsViewModelProvider
    extends $NotifierProvider<EewNotificationsSettingsViewModel, FcmEewTopic?> {
  EewNotificationsSettingsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewNotificationsSettingsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$eewNotificationsSettingsViewModelHash();

  @$internal
  @override
  EewNotificationsSettingsViewModel create() =>
      EewNotificationsSettingsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FcmEewTopic? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FcmEewTopic?>(value),
    );
  }
}

String _$eewNotificationsSettingsViewModelHash() =>
    r'2610a9afe740d8c373a5302e56b34eecaccd65ca';

abstract class _$EewNotificationsSettingsViewModel
    extends $Notifier<FcmEewTopic?> {
  FcmEewTopic? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FcmEewTopic?, FcmEewTopic?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FcmEewTopic?, FcmEewTopic?>,
              FcmEewTopic?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
