// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'background_location_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// エンジン稼働中（フォアグラウンド/バックグラウンド）での位置更新と、
/// killed状態でheadless runnerが永続化した位置情報の両方をEEW設定に反映する。
///
/// 起動時に1度だけ pending 位置を取り出し、続けて live ストリームを listen する。
/// `keepAlive: true` のため、boot 時に `ref.read` で1度だけ起動する想定。

@ProviderFor(backgroundLocationService)
final backgroundLocationServiceProvider = BackgroundLocationServiceProvider._();

/// エンジン稼働中（フォアグラウンド/バックグラウンド）での位置更新と、
/// killed状態でheadless runnerが永続化した位置情報の両方をEEW設定に反映する。
///
/// 起動時に1度だけ pending 位置を取り出し、続けて live ストリームを listen する。
/// `keepAlive: true` のため、boot 時に `ref.read` で1度だけ起動する想定。

final class BackgroundLocationServiceProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  /// エンジン稼働中（フォアグラウンド/バックグラウンド）での位置更新と、
  /// killed状態でheadless runnerが永続化した位置情報の両方をEEW設定に反映する。
  ///
  /// 起動時に1度だけ pending 位置を取り出し、続けて live ストリームを listen する。
  /// `keepAlive: true` のため、boot 時に `ref.read` で1度だけ起動する想定。
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
    r'ac898481b27f0d2e7b5b939f9ea37d9591e5e92c';
