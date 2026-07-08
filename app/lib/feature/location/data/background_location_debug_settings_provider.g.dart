// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'background_location_debug_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// バックグラウンド位置更新のデバッグ通知設定。
/// デバッグ画面から ON/OFF できる。

@ProviderFor(BackgroundLocationDebugSettings)
final backgroundLocationDebugSettingsProvider =
    BackgroundLocationDebugSettingsProvider._();

/// バックグラウンド位置更新のデバッグ通知設定。
/// デバッグ画面から ON/OFF できる。
final class BackgroundLocationDebugSettingsProvider
    extends
        $AsyncNotifierProvider<
          BackgroundLocationDebugSettings,
          BackgroundLocationDebugSettingsState
        > {
  /// バックグラウンド位置更新のデバッグ通知設定。
  /// デバッグ画面から ON/OFF できる。
  BackgroundLocationDebugSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundLocationDebugSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundLocationDebugSettingsHash();

  @$internal
  @override
  BackgroundLocationDebugSettings create() => BackgroundLocationDebugSettings();
}

String _$backgroundLocationDebugSettingsHash() =>
    r'6c4a3f2f46147f2a001ee9bb10b7690caef2631a';

/// バックグラウンド位置更新のデバッグ通知設定。
/// デバッグ画面から ON/OFF できる。

abstract class _$BackgroundLocationDebugSettings
    extends $AsyncNotifier<BackgroundLocationDebugSettingsState> {
  FutureOr<BackgroundLocationDebugSettingsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<BackgroundLocationDebugSettingsState>,
              BackgroundLocationDebugSettingsState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<BackgroundLocationDebugSettingsState>,
                BackgroundLocationDebugSettingsState
              >,
              AsyncValue<BackgroundLocationDebugSettingsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
