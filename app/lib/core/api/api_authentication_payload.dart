import 'package:eqmonitor/core/api/api_authentication_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_saved_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_authentication_payload.g.dart';

@Riverpod(keepAlive: true)
Future<({String id, String role})> apiAuthenticationPayload(Ref ref) async {
  final state = await ref.watch(apiAuthenticationNotifierProvider.future);
  if (state == null) {
    throw UnauthorizedException();
  }
  return ref.read(apiAuthenticationNotifierProvider.notifier).extractPayload();
}
