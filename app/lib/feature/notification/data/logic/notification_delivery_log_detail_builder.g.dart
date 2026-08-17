// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_delivery_log_detail_builder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationDeliveryLogDetailBuilder)
final notificationDeliveryLogDetailBuilderProvider =
    NotificationDeliveryLogDetailBuilderProvider._();

final class NotificationDeliveryLogDetailBuilderProvider
    extends
        $FunctionalProvider<
          NotificationDeliveryLogDetailBuilder,
          NotificationDeliveryLogDetailBuilder,
          NotificationDeliveryLogDetailBuilder
        >
    with $Provider<NotificationDeliveryLogDetailBuilder> {
  NotificationDeliveryLogDetailBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationDeliveryLogDetailBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationDeliveryLogDetailBuilderHash();

  @$internal
  @override
  $ProviderElement<NotificationDeliveryLogDetailBuilder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationDeliveryLogDetailBuilder create(Ref ref) {
    return notificationDeliveryLogDetailBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationDeliveryLogDetailBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<NotificationDeliveryLogDetailBuilder>(value),
    );
  }
}

String _$notificationDeliveryLogDetailBuilderHash() =>
    r'5b22e3e79913eea5edee9ebce0a5208a74398d3d';
