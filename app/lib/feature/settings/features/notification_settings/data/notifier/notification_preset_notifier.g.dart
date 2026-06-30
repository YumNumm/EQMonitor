// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_preset_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationPresetNotifier)
final notificationPresetProvider = NotificationPresetNotifierProvider._();

final class NotificationPresetNotifierProvider
    extends $NotifierProvider<NotificationPresetNotifier, NotificationPreset> {
  NotificationPresetNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPresetProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPresetNotifierHash();

  @$internal
  @override
  NotificationPresetNotifier create() => NotificationPresetNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationPreset value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationPreset>(value),
    );
  }
}

String _$notificationPresetNotifierHash() =>
    r'14576500bcf5e44676c8d81b0904d3d71dfa4086';

abstract class _$NotificationPresetNotifier
    extends $Notifier<NotificationPreset> {
  NotificationPreset build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<NotificationPreset, NotificationPreset>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NotificationPreset, NotificationPreset>,
              NotificationPreset,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
