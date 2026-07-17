// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_preset_applier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationPresetApplier)
final notificationPresetApplierProvider = NotificationPresetApplierProvider._();

final class NotificationPresetApplierProvider
    extends
        $FunctionalProvider<
          NotificationPresetApplier,
          NotificationPresetApplier,
          NotificationPresetApplier
        >
    with $Provider<NotificationPresetApplier> {
  NotificationPresetApplierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPresetApplierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPresetApplierHash();

  @$internal
  @override
  $ProviderElement<NotificationPresetApplier> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationPresetApplier create(Ref ref) {
    return notificationPresetApplier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationPresetApplier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationPresetApplier>(value),
    );
  }
}

String _$notificationPresetApplierHash() =>
    r'2a9aeab9bee09d103cc499c6408b6e54edd7d806';
