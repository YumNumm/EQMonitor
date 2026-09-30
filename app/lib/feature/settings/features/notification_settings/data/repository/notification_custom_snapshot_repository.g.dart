// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_custom_snapshot_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationCustomSnapshotRepository)
final notificationCustomSnapshotRepositoryProvider =
    NotificationCustomSnapshotRepositoryProvider._();

final class NotificationCustomSnapshotRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationCustomSnapshotRepository>,
          NotificationCustomSnapshotRepository,
          FutureOr<NotificationCustomSnapshotRepository>
        >
    with
        $FutureModifier<NotificationCustomSnapshotRepository>,
        $FutureProvider<NotificationCustomSnapshotRepository> {
  NotificationCustomSnapshotRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationCustomSnapshotRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationCustomSnapshotRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<NotificationCustomSnapshotRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationCustomSnapshotRepository> create(Ref ref) {
    return notificationCustomSnapshotRepository(ref);
  }
}

String _$notificationCustomSnapshotRepositoryHash() =>
    r'34e1ad0c76a3092a2bd733509c8e0fecf068ee84';
