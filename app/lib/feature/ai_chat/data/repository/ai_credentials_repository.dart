import 'dart:convert';

import 'package:eqmonitor/feature/ai_chat/data/model/ai_credentials.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_credentials_repository.g.dart';

@Riverpod(keepAlive: true)
AiCredentialsRepository aiCredentialsRepository(Ref ref) {
  const storage = FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
  return AiCredentialsRepository(storage: storage);
}

class AiCredentialsRepository {
  AiCredentialsRepository({required FlutterSecureStorage storage})
    : _storage = storage;

  static const _storageKey = 'eqmonitor.ai_chat.credentials_store.v1';

  final FlutterSecureStorage _storage;

  Future<AiCredentialsStore> load() async {
    final raw = await _storage.read(key: _storageKey);
    if (raw == null || raw.isEmpty) {
      return AiCredentialsStore.initial();
    }
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return AiCredentialsStore.fromJson(json);
    } on Exception {
      return AiCredentialsStore.initial();
    }
  }

  Future<void> save(AiCredentialsStore store) async {
    await _storage.write(
      key: _storageKey,
      value: jsonEncode(store.toJson()),
    );
  }

  Future<void> clear() async {
    await _storage.delete(key: _storageKey);
  }
}
