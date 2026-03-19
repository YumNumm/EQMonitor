import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Better Auth の Bearer トークンを [FlutterSecureStorage] に永続化する。
class AuthTokenStore {
  AuthTokenStore(this._storage);

  final FlutterSecureStorage _storage;

  static const _tokenKey = 'better_auth_bearer_token';

  Future<String?> getToken() => _storage.read(key: _tokenKey);

  Future<void> saveToken(String token) =>
      _storage.write(key: _tokenKey, value: token);

  Future<void> deleteToken() => _storage.delete(key: _tokenKey);
}
