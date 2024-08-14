import 'dart:convert';

import 'package:eqmonitor/core/provider/secure_storage.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_saved_state.dart';
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
    final payload = parseJwt(token);
    final map = payload;

    final id = map['id'] as String;
    final role = map['role'] as String;
    return (
      id: id,
      role: role,
    );
  }

  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw const FormatException('Invalid token.');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw const FormatException('Invalid payload.');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    var output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
      case 3:
        output += '=';
      default:
        throw Exception('Illegal base64 string.');
    }

    return utf8.decode(base64Url.decode(output));
  }
}

