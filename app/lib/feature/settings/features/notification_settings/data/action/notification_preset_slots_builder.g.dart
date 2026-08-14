// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_preset_slots_builder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationPresetSlotsBuilder)
final notificationPresetSlotsBuilderProvider =
    NotificationPresetSlotsBuilderProvider._();

final class NotificationPresetSlotsBuilderProvider
    extends
        $FunctionalProvider<
          NotificationPresetSlotsBuilder,
          NotificationPresetSlotsBuilder,
          NotificationPresetSlotsBuilder
        >
    with $Provider<NotificationPresetSlotsBuilder> {
  NotificationPresetSlotsBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPresetSlotsBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPresetSlotsBuilderHash();

  @$internal
  @override
  $ProviderElement<NotificationPresetSlotsBuilder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationPresetSlotsBuilder create(Ref ref) {
    return notificationPresetSlotsBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationPresetSlotsBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationPresetSlotsBuilder>(
        value,
      ),
    );
  }
}

String _$notificationPresetSlotsBuilderHash() =>
    r'ec05ebc8d3e41d59a610bf8f57487a4625d8add1';
