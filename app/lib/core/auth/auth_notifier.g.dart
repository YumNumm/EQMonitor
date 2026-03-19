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
/// [build] ではストレージからトークンの有無を確認するのみ。
/// 副作用(匿名認証)は [signInAnonymously] Mutation で実行する。

@ProviderFor(AuthNotifier)
final authProvider = AuthNotifierProvider._();

/// 認証状態(セッショントークン)を管理する Notifier。
///
/// [build] ではストレージからトークンの有無を確認するのみ。
/// 副作用(匿名認証)は [signInAnonymously] Mutation で実行する。
final class AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, String?> {
  /// 認証状態(セッショントークン)を管理する Notifier。
  ///
  /// [build] ではストレージからトークンの有無を確認するのみ。
  /// 副作用(匿名認証)は [signInAnonymously] Mutation で実行する。
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

String _$authNotifierHash() => r'e9c3f30b9dd25d8fb957ad8d4c6845ce59925133';

/// 認証状態(セッショントークン)を管理する Notifier。
///
/// [build] ではストレージからトークンの有無を確認するのみ。
/// 副作用(匿名認証)は [signInAnonymously] Mutation で実行する。

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
