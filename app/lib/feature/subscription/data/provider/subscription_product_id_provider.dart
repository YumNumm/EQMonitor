import 'dart:io';

import 'package:eqmonitor/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_product_id_provider.g.dart';

const _iosMonthlyProductId = 'net.yumnumm.eqmonitor.pro.monthly';
const _androidMonthlyProductId = 'eqmonitor.pro.monthly:eqmonitor-pro-monthly';

@riverpod
String monthlySubscriptionProductId(Ref ref) {
  if (kIsWeb) {
    throw const RevenueCatUnavailableException(
      reason: RevenueCatUnavailableReason.unsupportedPlatform,
    );
  }
  if (Platform.isIOS) {
    return _iosMonthlyProductId;
  }
  if (Platform.isAndroid) {
    return _androidMonthlyProductId;
  }
  throw const RevenueCatUnavailableException(
    reason: RevenueCatUnavailableReason.unsupportedPlatform,
  );
}
