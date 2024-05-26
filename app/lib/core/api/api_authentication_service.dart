import 'dart:convert';

import 'package:eqmonitor/core/provider/secure_storage.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_authentication_service.g.dart';

@Riverpod(keepAlive: true)
class ApiAuthenticationService extends _$ApiAuthenticationService {
  @override
  Future<String?> build() async {
    final secureStorage = ref.watch(secureStorageProvider);
    final result = await secureStorage.read(key: _secureStorageKey);
    return result;
  }

  static const _secureStorageKey = 'api_token';

  Future<void> save({
    required String token,
  }) async {
    final secureStorage = ref.watch(secureStorageProvider);
    await secureStorage.write(key: _secureStorageKey, value: token);

    state = AsyncData(token);
  }

  Future<
      ({
        String id,
        String role,
      })> extractPayload() async {
    final token = state.valueOrNull;
    if (token == null) {
      throw UnauthorizedException();
    }

    final parts = token.split('.');
    if (parts.length != 3) {
      throw UnauthorizedException();
    }

    final payload = parts[1];
    final decoded = base64Decode(payload);
    final json = utf8.decode(decoded);
    final map = jsonDecode(json) as Map<String, dynamic>;
    final id = map['sub'] as String;
    final role = map['role'] as String;
    return (
      id: id,
      role: role,
    );
  }
}
