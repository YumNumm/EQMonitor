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
    r'ff0ab9ca6e4dfb5d53b98f4562c1267e5c5d7bf8';
