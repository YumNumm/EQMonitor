import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/devices/data/logic/device_id_decoder.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:eqmonitor/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart';
import 'package:eqmonitor/feature/subscription/data/repository/revenue_cat_configurator.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:synchronized/synchronized.dart';

part 'revenue_cat_session.g.dart';

@Riverpod(keepAlive: true)
Future<RevenueCatSession> revenueCatSession(Ref ref) async {
  final registration = await ref.watch(deviceProvisioningProvider.future);
  if (registration != DeviceProvisioningStatus.notRequired) {
    throw const RevenueCatUnavailableException(
      reason: RevenueCatUnavailableReason.registrationRequired,
    );
  }
  final deviceId = await ref.watch(deviceIdProvider.future);
  final auth = await ref.watch(deviceAuthRepositoryProvider.future);
  final token = await auth.readToken();
  if (token == null ||
      const DeviceIdDecoder().decode(token: token) != deviceId) {
    throw const RevenueCatUnavailableException(
      reason: RevenueCatUnavailableReason.identityChanged,
    );
  }
  return RevenueCatSession(
    deviceId: deviceId,
    token: token,
    apiKey: ref.watch(buildConfigProvider).revenueCatApiKey,
    readToken: auth.readToken,
  );
}

/// The native SDK has one process-wide identity, including across providers.
class const RevenueCatSession({
  required final String deviceId,
  required final String token,
  required final String? apiKey,
  required final Future<String?> Function() readToken,
}) {
  static final _lock = Lock();

  Future<void> validateCredentials() async {
    if (await readToken() != token) {
      throw const RevenueCatUnavailableException(
        reason: RevenueCatUnavailableReason.identityChanged,
      );
    }
  }

  Future<T> run<T>({required Future<T> Function() operation}) =>
      _lock.synchronized(() async {
        await validateCredentials();
        await const RevenueCatConfigurator().ensureConfigured(apiKey: apiKey);
        if (await rc.Purchases.appUserID != deviceId) {
          await rc.Purchases.logIn(deviceId);
        }
        await validateCredentials();
        if (await rc.Purchases.appUserID != deviceId) {
          throw const RevenueCatUnavailableException(
            reason: RevenueCatUnavailableReason.identityChanged,
          );
        }
        final result = await operation();
        await validateCredentials();
        return result;
      });
}
