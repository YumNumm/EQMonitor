// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_slot_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationSlotRepository)
final notificationSlotRepositoryProvider =
    NotificationSlotRepositoryProvider._();

final class NotificationSlotRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationSlotRepository>,
          NotificationSlotRepository,
          FutureOr<NotificationSlotRepository>
        >
    with
        $FutureModifier<NotificationSlotRepository>,
        $FutureProvider<NotificationSlotRepository> {
  NotificationSlotRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSlotRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSlotRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<NotificationSlotRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationSlotRepository> create(Ref ref) {
    return notificationSlotRepository(ref);
  }
}

String _$notificationSlotRepositoryHash() =>
    r'072869eb850ed1a35d6176fd4902c878ed3de4a0';
