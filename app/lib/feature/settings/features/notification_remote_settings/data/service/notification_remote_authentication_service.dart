import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/api_authentication_notifier.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_saved_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_remote_authentication_service.g.dart';

@Riverpod(keepAlive: true)
NotificationRemoteAuthenticationService notificationRemoteAuthenticateService(
  Ref ref,
) => NotificationRemoteAuthenticationService(
  api: ref.watch(eqApiProvider),
  apiAuthenticationService: ref.watch(
    apiAuthenticationNotifierProvider.notifier,
  ),
  ref: ref,
);

class NotificationRemoteAuthenticationService {
  NotificationRemoteAuthenticationService({
    required EqApi api,
    required ApiAuthenticationNotifier apiAuthenticationService,
    required Ref ref,
  }) : _api = api,
       _apiAuthenticationService = apiAuthenticationService,
       _ref = ref;

  final EqApi _api;
  final ApiAuthenticationNotifier _apiAuthenticationService;
  final Ref _ref;

  Future<void> authenticate({required String fcmToken}) async {
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

  Future<FcmTokenUpdateResponse> updateToken({required String fcmToken}) async {
    final authorization = await _ref.read(
      apiAuthenticationNotifierProvider.future,
    );
    if (authorization == null) {
      throw UnauthorizedException();
    }
    final result = await _api.auth.update(
      request: FcmTokenRequest(fcmToken: fcmToken),
      authorization: authorization,
    );
    return result.data;
  }
}
