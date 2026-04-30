// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_group_settings_writer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// apiServerUrl と debugMode を App Groups UserDefaults に書き込む。
/// telegramUrlProvider を watch するため、デバッグ画面での URL 変更も Widget に即時反映される。

@ProviderFor(appGroupSettingsWriter)
final appGroupSettingsWriterProvider = AppGroupSettingsWriterProvider._();

/// apiServerUrl と debugMode を App Groups UserDefaults に書き込む。
/// telegramUrlProvider を watch するため、デバッグ画面での URL 変更も Widget に即時反映される。

final class AppGroupSettingsWriterProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// apiServerUrl と debugMode を App Groups UserDefaults に書き込む。
  /// telegramUrlProvider を watch するため、デバッグ画面での URL 変更も Widget に即時反映される。
  AppGroupSettingsWriterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appGroupSettingsWriterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appGroupSettingsWriterHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return appGroupSettingsWriter(ref);
  }
}

String _$appGroupSettingsWriterHash() =>
    r'd08613148683519b69ceb4a4569504ccb94c10b8';
