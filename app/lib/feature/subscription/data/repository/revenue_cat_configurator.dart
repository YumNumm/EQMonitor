import 'dart:developer';
import 'dart:io';

import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;

class RevenueCatConfigurator {
  const new();

  Future<void> ensureConfigured() async {
    if (kIsWeb || (!Platform.isIOS && !Platform.isAndroid)) {
      throw const RevenueCatUnavailableException(
        reason: RevenueCatUnavailableReason.unsupportedPlatform,
      );
    }

    final apiKey = BuildConfig.fromEnvironment().revenueCatApiKey;
    if (apiKey == null || apiKey.isEmpty) {
      log('RevenueCat API key is not configured; skipping configure.');
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
    } on Object catch (error, stackTrace) {
      talker.handle(error, stackTrace, 'Failed to configure RevenueCat');
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
