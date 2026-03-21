import 'package:better_auth_api_client/export.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
Future<AuthRepository> authRepository(Ref ref) async {
  final api = ref.watch(authApiClientProvider);
  final secureStorage = await ref.watch(
    securePreferencesDataSourceProvider.future,
  );
  return AuthRepository(api: api, secureStorage: secureStorage);
}

/// Better Auth API への認証リクエストとトークン永続化を担当する。
class AuthRepository {
  AuthRepository({
    required ApiClient api,
    required SecurePreferencesDataSource secureStorage,
  })  : _api = api,
        _secureStorage = secureStorage;

  final ApiClient _api;
  final SecurePreferencesDataSource _secureStorage;

  Future<String?> loadToken() {
    return _secureStorage.getString(key: SecureStorageKey.sessionToken);
  }

  Future<String> signInAnonymously() async {
    final response = await _api.anonymous.postSignInAnonymous();
    final token = response.data.session.token;
    await _saveToken(token);
    return token;
  }

  Future<String> signInWithGoogle({required String idToken}) async {
    final response = await _api.auth.postSignInSocial(
      body: SignInSocialRequestBody(
        provider: 'google',
        idToken: IdToken(token: idToken),
      ),
    );
    final token = response.data.token;
    await _saveToken(token);
    return token;
  }

  Future<void> signOut() async {
    await _api.auth.postSignOut();
    await _clearToken();
  }

  Future<void> _saveToken(String token) async {
    await _secureStorage.setString(
      key: SecureStorageKey.sessionToken,
      value: token,
    );
  }

  Future<void> _clearToken() async {
    await _secureStorage.remove(key: SecureStorageKey.sessionToken);
  }
}
