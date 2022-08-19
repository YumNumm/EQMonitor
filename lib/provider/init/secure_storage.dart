import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  throw UnimplementedError('SecureStorageが読み込まれていません');
});
