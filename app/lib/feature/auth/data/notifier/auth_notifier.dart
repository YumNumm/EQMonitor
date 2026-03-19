import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

/// 認証状態(セッショントークン)を管理する Notifier。
///
/// [build] ではセキュアストレージからトークンを読み込む。
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
    final dataSource = await ref.watch(
      securePreferencesDataSourceProvider.future,
    );
    return dataSource.getString(key: SecureStorageKey.sessionToken);
  }

  Future<void> saveToken(String token) async {
    final dataSource = await ref.read(
      securePreferencesDataSourceProvider.future,
    );
    await dataSource.setString(
      key: SecureStorageKey.sessionToken,
      value: token,
    );
    state = AsyncData(token);
  }
}
