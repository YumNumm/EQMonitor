// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewSettingsNotifier)
final eewSettingsProvider = EewSettingsNotifierProvider._();

final class EewSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<EewSettingsNotifier, EewNotificationSettings> {
  EewSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewSettingsNotifierHash();

  @$internal
  @override
  EewSettingsNotifier create() => EewSettingsNotifier();
}

String _$eewSettingsNotifierHash() =>
    r'5d48e190739027f6431076c502384fcdd415d872';

abstract class _$EewSettingsNotifier
    extends $AsyncNotifier<EewNotificationSettings> {
  FutureOr<EewNotificationSettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EewNotificationSettings>,
              EewNotificationSettings
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EewNotificationSettings>,
                EewNotificationSettings
              >,
              AsyncValue<EewNotificationSettings>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
