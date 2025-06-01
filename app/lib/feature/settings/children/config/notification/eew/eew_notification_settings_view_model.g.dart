// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'eew_notification_settings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EewNotificationsSettingsViewModel)
const eewNotificationsSettingsViewModelProvider =
    EewNotificationsSettingsViewModelProvider._();

final class EewNotificationsSettingsViewModelProvider
    extends $NotifierProvider<EewNotificationsSettingsViewModel, FcmEewTopic?> {
  const EewNotificationsSettingsViewModelProvider._()
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

  @$internal
  @override
  $NotifierProviderElement<EewNotificationsSettingsViewModel, FcmEewTopic?>
  $createElement($ProviderPointer pointer) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FcmEewTopic? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<FcmEewTopic?>(value),
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
    final created = build();
    final ref = this.ref as $Ref<FcmEewTopic?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FcmEewTopic?>,
              FcmEewTopic?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
