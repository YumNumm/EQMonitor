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
    r'e12d6797267f136155fb407fe510b97948527fcf';

abstract class _$GeneralNotificationSettingsNotifier
    extends $AsyncNotifier<GeneralNotificationSettings> {
  FutureOr<GeneralNotificationSettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
