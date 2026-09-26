import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;

class const RevenueCatConfigurator() {
  Future<void> ensureConfigured({required String? apiKey}) async {
    if (kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.iOS &&
            defaultTargetPlatform != TargetPlatform.android)) {
      throw const RevenueCatUnavailableException(
        reason: RevenueCatUnavailableReason.unsupportedPlatform,
      );
    }

    if (apiKey == null || apiKey.isEmpty) {
      throw const RevenueCatUnavailableException(
        reason: RevenueCatUnavailableReason.apiKeyNotConfigured,
      );
    }

    if (await rc.Purchases.isConfigured) {
      return;
    }

    try {
      await rc.Purchases.setLogLevel(rc.LogLevel.info);
      await rc.Purchases.configure(rc.PurchasesConfiguration(apiKey));
    } catch (error, stackTrace) {
      talker.handle(error, stackTrace, 'Failed to configure RevenueCat');
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
