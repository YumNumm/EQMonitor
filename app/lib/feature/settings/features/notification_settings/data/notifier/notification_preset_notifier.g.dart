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
    extends
        $AsyncNotifierProvider<NotificationPresetNotifier, NotificationPreset> {
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
}

String _$notificationPresetNotifierHash() =>
    r'0a975d92f5c8bf5629e1140cf813081ad4bed805';

abstract class _$NotificationPresetNotifier
    extends $AsyncNotifier<NotificationPreset> {
  FutureOr<NotificationPreset> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<NotificationPreset>, NotificationPreset>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NotificationPreset>, NotificationPreset>,
              AsyncValue<NotificationPreset>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
