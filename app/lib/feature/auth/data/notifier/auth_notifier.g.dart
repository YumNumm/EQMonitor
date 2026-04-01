// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 認証状態(セッショントークン)を管理する Notifier。
///
/// [build] ではセキュアストレージからトークンを読み込む。
/// 副作用は [signInAnonymouslyMutation] / [signInWithGoogleMutation] /
/// [signOutMutation] Mutation で実行する。

@ProviderFor(AuthNotifier)
final authProvider = AuthNotifierProvider._();

/// 認証状態(セッショントークン)を管理する Notifier。
///
/// [build] ではセキュアストレージからトークンを読み込む。
/// 副作用は [signInAnonymouslyMutation] / [signInWithGoogleMutation] /
/// [signOutMutation] Mutation で実行する。
final class AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, String?> {
  /// 認証状態(セッショントークン)を管理する Notifier。
  ///
  /// [build] ではセキュアストレージからトークンを読み込む。
  /// 副作用は [signInAnonymouslyMutation] / [signInWithGoogleMutation] /
  /// [signOutMutation] Mutation で実行する。
  AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();
}

String _$authNotifierHash() => r'a2d30e76b82640396a1a0cbaf0f288c55f3586e6';

/// 認証状態(セッショントークン)を管理する Notifier。
///
/// [build] ではセキュアストレージからトークンを読み込む。
/// 副作用は [signInAnonymouslyMutation] / [signInWithGoogleMutation] /
/// [signOutMutation] Mutation で実行する。

abstract class _$AuthNotifier extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
