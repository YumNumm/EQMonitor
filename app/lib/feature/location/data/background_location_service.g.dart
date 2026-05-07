// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'background_location_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Path A: エンジン稼働中（フォアグラウンド/バックグラウンド）での
/// バックグラウンド位置更新をEEW設定に反映するサービス。

@ProviderFor(backgroundLocationService)
final backgroundLocationServiceProvider = BackgroundLocationServiceProvider._();

/// Path A: エンジン稼働中（フォアグラウンド/バックグラウンド）での
/// バックグラウンド位置更新をEEW設定に反映するサービス。

final class BackgroundLocationServiceProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  /// Path A: エンジン稼働中（フォアグラウンド/バックグラウンド）での
  /// バックグラウンド位置更新をEEW設定に反映するサービス。
  BackgroundLocationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundLocationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundLocationServiceHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return backgroundLocationService(ref);
  }
}

String _$backgroundLocationServiceHash() =>
    r'679d5fa368420a8ae3d3147f73b22ed6ddaa5a23';
