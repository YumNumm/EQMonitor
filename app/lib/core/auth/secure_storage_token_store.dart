import 'package:better_auth_client/better_auth_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Better Auth の Bearer トークンを [FlutterSecureStorage] に永続化する [TokenStore]。
class SecureStorageTokenStore extends TokenStore {
  SecureStorageTokenStore(this._storage);

  final FlutterSecureStorage _storage;

  static const _tokenKey = 'better_auth_bearer_token';
  static const _adminTokenKey = 'better_auth_admin_token';

  @override
  Future<String> getToken() =>
      _storage.read(key: _tokenKey).then((v) => v ?? '');

  @override
  Future<void> saveToken(String? token) {
    if (token == null || token.isEmpty) {
      return _storage.delete(key: _tokenKey);
    }
    return _storage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String> getAdminToken() =>
      _storage.read(key: _adminTokenKey).then((v) => v ?? '');

  @override
  Future<void> saveAdminToken(String? token) {
    if (token == null || token.isEmpty) {
      return _storage.delete(key: _adminTokenKey);
    }
    return _storage.write(key: _adminTokenKey, value: token);
  }
}
