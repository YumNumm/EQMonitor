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
        $NotifierProvider<
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackgroundLocationDebugSettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<BackgroundLocationDebugSettingsState>(value),
    );
  }
}

String _$backgroundLocationDebugSettingsHash() =>
    r'793e5d0fe78bfab48d0e6fc393fd8b68a7bd9013';

/// バックグラウンド位置更新のデバッグ通知設定。
/// デバッグ画面から ON/OFF できる。

abstract class _$BackgroundLocationDebugSettings
    extends $Notifier<BackgroundLocationDebugSettingsState> {
  BackgroundLocationDebugSettingsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              BackgroundLocationDebugSettingsState,
              BackgroundLocationDebugSettingsState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                BackgroundLocationDebugSettingsState,
                BackgroundLocationDebugSettingsState
              >,
              BackgroundLocationDebugSettingsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
