// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'screen_behavior_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScreenBehaviorSettingsNotifier)
final screenBehaviorSettingsProvider =
    ScreenBehaviorSettingsNotifierProvider._();

final class ScreenBehaviorSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          ScreenBehaviorSettingsNotifier,
          ScreenBehaviorSettings
        > {
  ScreenBehaviorSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenBehaviorSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenBehaviorSettingsNotifierHash();

  @$internal
  @override
  ScreenBehaviorSettingsNotifier create() => ScreenBehaviorSettingsNotifier();
}

String _$screenBehaviorSettingsNotifierHash() =>
    r'34ffdd7d96efd15047c3480d2f342c71dc02b8aa';

abstract class _$ScreenBehaviorSettingsNotifier
    extends $AsyncNotifier<ScreenBehaviorSettings> {
  FutureOr<ScreenBehaviorSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<ScreenBehaviorSettings>, ScreenBehaviorSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ScreenBehaviorSettings>,
                ScreenBehaviorSettings
              >,
              AsyncValue<ScreenBehaviorSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
