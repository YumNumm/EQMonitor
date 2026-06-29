// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_slots_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationSlotsNotifier)
final notificationSlotsProvider = NotificationSlotsNotifierProvider._();

final class NotificationSlotsNotifierProvider
    extends
        $AsyncNotifierProvider<
          NotificationSlotsNotifier,
          List<NotificationSlot>
        > {
  NotificationSlotsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSlotsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSlotsNotifierHash();

  @$internal
  @override
  NotificationSlotsNotifier create() => NotificationSlotsNotifier();
}

String _$notificationSlotsNotifierHash() =>
    r'b685102634a5fd9c99f9a18390979e8a144c396e';

abstract class _$NotificationSlotsNotifier
    extends $AsyncNotifier<List<NotificationSlot>> {
  FutureOr<List<NotificationSlot>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<NotificationSlot>>, List<NotificationSlot>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<NotificationSlot>>,
                List<NotificationSlot>
              >,
              AsyncValue<List<NotificationSlot>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
