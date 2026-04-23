// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_group_settings_writer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// アプリ起動時に apiServerUrl と debugMode を App Groups UserDefaults に書き込む。
/// Widget Extension がこの値を読んで正しいエンドポイントへ接続する。

@ProviderFor(appGroupSettingsWriter)
final appGroupSettingsWriterProvider = AppGroupSettingsWriterProvider._();

/// アプリ起動時に apiServerUrl と debugMode を App Groups UserDefaults に書き込む。
/// Widget Extension がこの値を読んで正しいエンドポイントへ接続する。

final class AppGroupSettingsWriterProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// アプリ起動時に apiServerUrl と debugMode を App Groups UserDefaults に書き込む。
  /// Widget Extension がこの値を読んで正しいエンドポイントへ接続する。
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
    r'c2fb7589994e4eace5ac1d68113e9b57fe52e4e2';
