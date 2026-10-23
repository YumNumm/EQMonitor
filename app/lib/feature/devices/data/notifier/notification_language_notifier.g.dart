// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_language_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationLanguageNotifier)
final notificationLanguageProvider = NotificationLanguageNotifierProvider._();

final class NotificationLanguageNotifierProvider
    extends $AsyncNotifierProvider<NotificationLanguageNotifier, DeviceLocale> {
  NotificationLanguageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationLanguageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationLanguageNotifierHash();

  @$internal
  @override
  NotificationLanguageNotifier create() => NotificationLanguageNotifier();
}

String _$notificationLanguageNotifierHash() =>
    r'e02730f94278d604a21a324afcdfabf385cb06a1';

abstract class _$NotificationLanguageNotifier
    extends $AsyncNotifier<DeviceLocale> {
  FutureOr<DeviceLocale> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DeviceLocale>, DeviceLocale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DeviceLocale>, DeviceLocale>,
              AsyncValue<DeviceLocale>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
