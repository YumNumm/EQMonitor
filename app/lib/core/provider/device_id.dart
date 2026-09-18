import 'package:eqmonitor/feature/devices/data/logic/device_id_decoder.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_id.g.dart';

/// サーバー発行 JWT の sub claim からデバイス ID を提供する。
@Riverpod(keepAlive: true)
Future<String> deviceId(Ref ref) async {
  final repository = await ref.watch(deviceAuthRepositoryProvider.future);
  final token = await repository.readToken();
  if (token == null || token.isEmpty) {
    throw StateError('Device JWT is not available');
  }
  return ref.watch(deviceIdDecoderProvider).decode(token: token);
}
