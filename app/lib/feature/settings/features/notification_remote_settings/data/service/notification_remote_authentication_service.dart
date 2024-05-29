import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/model/v1/auth/fcm_token_request.dart';
import 'package:eqapi_types/model/v1/auth/fcm_token_response.dart';
import 'package:eqmonitor/core/api/api_authentication_service.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_saved_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_remote_authentication_service.g.dart';

@Riverpod(keepAlive: true)
NotificationRemoteAuthenticationService notificationRemoteAuthenticateService(
  NotificationRemoteAuthenticateServiceRef ref,
) =>
    NotificationRemoteAuthenticationService(
      api: ref.watch(eqApiProvider),
      apiAuthenticationService:
          ref.watch(apiAuthenticationServiceProvider.notifier),
      ref: ref,
    );

class NotificationRemoteAuthenticationService {
  NotificationRemoteAuthenticationService({
    required EqApi api,
    required ApiAuthenticationService apiAuthenticationService,
    required NotificationRemoteAuthenticateServiceRef ref,
  })  : _api = api,
        _apiAuthenticationService = apiAuthenticationService,
        _ref = ref;

  final EqApi _api;
  final ApiAuthenticationService _apiAuthenticationService;
  final NotificationRemoteAuthenticateServiceRef _ref;

  Future<void> authenticate({
    required String fcmToken,
  }) async {
    final result = await _api.auth.register(
      request: FcmTokenRequest(fcmToken: fcmToken),
    );
    final token = result.data.token;
    if (token == null) {
      throw Exception('Token is null');
    }

    await _apiAuthenticationService.save(token: token);
    return;
  }

  Future<FcmTokenUpdateResponse> updateToken({
    required String fcmToken,
  }) async {
    final authorization =
        await _ref.read(apiAuthenticationServiceProvider.future);
    if (authorization == null) {
      throw UnauthorizedException();
    }
    final result = await _api.auth.update(
      request: FcmTokenRequest(
        fcmToken: fcmToken,
      ),
      authorization: authorization,
    );
    return result.data;
  }
}
