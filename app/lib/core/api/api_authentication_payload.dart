import 'package:eqmonitor/core/api/api_authentication_service.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_saved_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_authentication_payload.g.dart';

@Riverpod(keepAlive: true)
Future<
    ({
      String id,
      String role,
    })> apiAuthenticationPayload(ApiAuthenticationPayloadRef ref) async {
  final state = await ref.watch(apiAuthenticationServiceProvider.future);
  if (state == null) {
    throw UnauthorizedException();
  }
  return ref.read(apiAuthenticationServiceProvider.notifier).extractPayload();
}
