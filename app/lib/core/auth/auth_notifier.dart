import 'package:eqmonitor/core/auth/auth_client_provider.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

/// 認証状態(セッショントークン)を管理する Notifier。
///
/// [build] ではストレージからトークンの有無を確認するのみ。
/// 副作用(匿名認証)は [signInAnonymously] Mutation で実行する。
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  /// 匿名サインインを行う [Mutation]。
  ///
  /// スプラッシュ画面から呼び出し、
  /// 既存のセッションが無い場合に Better Auth `/sign-in/anonymous` を実行する。
  static final signInAnonymously = Mutation<void>();

  @override
  Future<String?> build() async {
    final tokenStore = ref.watch(authTokenStoreProvider);
    return tokenStore.getToken();
  }
}
