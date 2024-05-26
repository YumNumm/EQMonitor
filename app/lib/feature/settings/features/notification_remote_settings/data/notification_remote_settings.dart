import 'package:eqapi_types/model/v1/auth/notification_settings_request.dart';
import 'package:eqapi_types/model/v1/auth/notification_settings_response.dart';
import 'package:eqmonitor/core/api/api_authentication_service.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_remote_settings.g.dart';

@Riverpod(keepAlive: true)
class NotificationRemoteSettingsNotifier
    extends _$NotificationRemoteSettingsNotifier {
  @override
  Future<NotificationSettingsResponse> build() async {
    final api = ref.read(eqApiProvider);
    final String? token;
    try {
      token = await ref.read(apiAuthenticationServiceProvider.future);
    } on Exception catch (e) {
      throw UnauthorizedException(
        innerException: e,
      );
    }
    if (token == null) {
      throw UnauthorizedException();
    }
    final response = await api.auth.getNotificationSettings(
      authorization: 'Bearer $token',
    );
    return response.data;
  }

  Future<void> updateEarthquake({
    required NotificationSettingsRequest request,
  }) async {
    final token = await ref.read(apiAuthenticationServiceProvider.future);
    if (token == null) {
      throw UnauthorizedException();
    }

    final api = ref.read(eqApiProvider);
    await api.auth.updateEarthquakeSettings(
      request: request,
      authorization: 'Bearer $token',
    );
  }

  Future<void> updateEew({
    required NotificationSettingsRequest request,
  }) async {
    final token = await ref.read(apiAuthenticationServiceProvider.future);
    if (token == null) {
      throw UnauthorizedException();
    }

    final api = ref.read(eqApiProvider);
    await api.auth.updateEewSettings(
      request: request,
      authorization: 'Bearer $token',
    );
  }
}

class UnauthorizedException implements Exception {
  UnauthorizedException({
    this.innerException,
  });

  final Exception? innerException;
}
