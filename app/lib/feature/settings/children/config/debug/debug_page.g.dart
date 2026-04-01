// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// GoogleSignIn を初期化するプロバイダー（一度だけ実行される）

@ProviderFor(googleSignInInit)
final googleSignInInitProvider = GoogleSignInInitProvider._();

/// GoogleSignIn を初期化するプロバイダー（一度だけ実行される）

final class GoogleSignInInitProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// GoogleSignIn を初期化するプロバイダー（一度だけ実行される）
  GoogleSignInInitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleSignInInitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleSignInInitHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return googleSignInInit(ref);
  }
}

String _$googleSignInInitHash() => r'c6ec8be2daed54a6913404739bbeef7955745271';
