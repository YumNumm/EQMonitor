import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_token_sync_state_repository.g.dart';

@Riverpod(keepAlive: true)
Future<PushTokenSyncStateRepository> pushTokenSyncStateRepository(
  Ref ref,
) async => PushTokenSyncStateRepository(
  dataSource: await ref.watch(sharedPreferencesDataSourceProvider.future),
);

class PushTokenSyncStateRepository {
  new({required SharedPreferencesDataSource dataSource})
    : _dataSource = dataSource;

  final SharedPreferencesDataSource _dataSource;
  var _credentialGeneration = 0;
  int get credentialGeneration => _credentialGeneration;

  SharedPreferencesKey keyFor({required PushTokenKind kind}) => switch (kind) {
    .fcm => .fcmTokenLastSent,
    .apnsNotification => .apnsNotificationTokenLastSent,
    .apnsPushToStart => .apnsPushToStartTokenLastSent,
  };

  Future<bool> shouldSync({
    required PushTokenKind kind,
    required String token,
  }) async {
    final source = await _dataSource.getString(key: keyFor(kind: kind));
    if (source == null) {
      return true;
    }
    try {
      if (jsonDecode(source) case {
        'sha256': final String hash,
        'sent_at': final int sentAt,
      }) {
        return hash != sha256.convert(utf8.encode(token)).toString() ||
            clock.now().millisecondsSinceEpoch - sentAt >=
                const Duration(days: 1).inMilliseconds;
      }
    } on FormatException {
      return true;
    }
    return true;
  }

  Future<void> recordSuccess({
    required PushTokenKind kind,
    required String token,
    required int credentialGeneration,
  }) async {
    if (credentialGeneration != _credentialGeneration) {
      return;
    }
    await _dataSource.setString(
      key: keyFor(kind: kind),
      value: jsonEncode({
        'sha256': sha256.convert(utf8.encode(token)).toString(),
        'sent_at': clock.now().millisecondsSinceEpoch,
      }),
    );
  }

  Future<void> clear({required PushTokenKind kind}) =>
      _dataSource.remove(key: keyFor(kind: kind));

  Future<void> clearAll() async {
    _credentialGeneration++;
    for (final kind in PushTokenKind.values) {
      await clear(kind: kind);
    }
  }
}
