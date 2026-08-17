import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hinet_credentials_provider.g.dart';

/// Hi-net(BOSAI)認証情報(ユーザーID + パスワード)。
///
/// **注意**: 値そのものをコード・ログ・fixtureへ書き出さないこと。
class HinetCredentials {
  const new({required this.userId, required this.password});

  final String userId;
  final String password;
}

/// SecureStorage から Hi-net 認証情報を読み書きするNotifier。
///
/// [KnetCredentialsNotifier](`app/lib/feature/knet_waveform/data/provider/knet_credentials_provider.dart`)
/// と同じ Mutation パターンに従う。
@Riverpod(keepAlive: true, name: 'hinetCredentialsNotifierProvider')
class HinetCredentialsNotifier extends _$HinetCredentialsNotifier {
  static final saveMutation = Mutation<void>();
  static final clearMutation = Mutation<void>();

  @override
  Future<HinetCredentials?> build() async {
    final ds = await ref.watch(securePreferencesDataSourceProvider.future);
    final userId = await ds.getString(key: SecureStorageKey.hinetBosaiUserId);
    final password = await ds.getString(
      key: SecureStorageKey.hinetBosaiPassword,
    );
    if (userId == null || password == null) {
      return null;
    }
    return HinetCredentials(userId: userId, password: password);
  }

  Future<void> save({required String userId, required String password}) async {
    final ds = await ref.read(securePreferencesDataSourceProvider.future);
    await ds.setString(key: SecureStorageKey.hinetBosaiUserId, value: userId);
    await ds.setString(
      key: SecureStorageKey.hinetBosaiPassword,
      value: password,
    );
    state = AsyncData(HinetCredentials(userId: userId, password: password));
  }

  Future<void> clear() async {
    final ds = await ref.read(securePreferencesDataSourceProvider.future);
    await ds.remove(key: SecureStorageKey.hinetBosaiUserId);
    await ds.remove(key: SecureStorageKey.hinetBosaiPassword);
    state = const AsyncData(null);
  }
}
