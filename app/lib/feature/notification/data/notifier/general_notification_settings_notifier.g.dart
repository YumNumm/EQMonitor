// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'general_notification_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GeneralNotificationSettingsNotifier)
final generalNotificationSettingsProvider =
    GeneralNotificationSettingsNotifierProvider._();

final class GeneralNotificationSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          GeneralNotificationSettingsNotifier,
          GeneralNotificationSettings
        > {
  GeneralNotificationSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generalNotificationSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$generalNotificationSettingsNotifierHash();

  @$internal
  @override
  GeneralNotificationSettingsNotifier create() =>
      GeneralNotificationSettingsNotifier();
}

String _$generalNotificationSettingsNotifierHash() =>
    r'cd8059915d81281eac7daf639b38a5205044cc26';

abstract class _$GeneralNotificationSettingsNotifier
    extends $AsyncNotifier<GeneralNotificationSettings> {
  FutureOr<GeneralNotificationSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<GeneralNotificationSettings>,
              GeneralNotificationSettings
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<GeneralNotificationSettings>,
                GeneralNotificationSettings
              >,
              AsyncValue<GeneralNotificationSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
