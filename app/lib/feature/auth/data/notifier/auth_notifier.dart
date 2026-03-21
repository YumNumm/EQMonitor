import 'package:eqmonitor/feature/auth/data/repository/auth_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

/// 認証状態(セッショントークン)を管理する Notifier。
///
/// [build] ではセキュアストレージからトークンを読み込む。
/// 副作用は [signInAnonymouslyMutation] / [signInWithGoogleMutation] /
/// [signOutMutation] Mutation で実行する。
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  static final signInAnonymouslyMutation = Mutation<void>();
  static final signInWithGoogleMutation = Mutation<void>();
  static final signOutMutation = Mutation<void>();

  @override
  Future<String?> build() async {
    final repo = await ref.watch(authRepositoryProvider.future);
    return repo.loadToken();
  }

  Future<void> signInAnonymously() async {
    final repo = await ref.read(authRepositoryProvider.future);
    final token = await repo.signInAnonymously();
    state = AsyncData(token);
  }

  Future<void> signInWithGoogle({required String idToken}) async {
    final repo = await ref.read(authRepositoryProvider.future);
    final token = await repo.signInWithGoogle(idToken: idToken);
    state = AsyncData(token);
  }

  Future<void> signOut() async {
    final repo = await ref.read(authRepositoryProvider.future);
    await repo.signOut();
    state = const AsyncData(null);
  }
}
