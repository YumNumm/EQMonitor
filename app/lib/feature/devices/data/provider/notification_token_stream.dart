import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/live_activity/data/provider/eqm_live_activity_util.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:live_activity_util/live_activity_util.dart';
import 'package:objective_c/objective_c.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_token_stream.g.dart';

final notificationTokenApnsSupportedProvider = Provider<bool>(
  (_) => !kIsWeb && (Platform.isIOS || Platform.isMacOS),
);

@Riverpod(keepAlive: true)
Stream<NotificationToken> notificationTokenStream(Ref ref) async* {
  final permission = await ref.watch(osNotificationPermissionProvider.future);
  if (!permission.canReceiveRemoteNotifications) {
    yield const NotificationToken();
    return;
  }
  final apnsSupported = ref.watch(notificationTokenApnsSupportedProvider);

  final fcmToken = ref.watch(firebaseMessagingTokenStreamProvider).value;
  final apnsToken = apnsSupported
      ? ref.watch(apnsTokenStreamProvider).value
      : null;
  final apnsPushToStartToken = apnsSupported
      ? ref.watch(apnsPushToStartTokenStreamProvider).value
      : null;

  yield NotificationToken(
    fcmToken: fcmToken,
    apnsToken: apnsToken,
    apnsPushToStartToken: apnsPushToStartToken,
  );
}

@riverpod
Stream<String> firebaseMessagingTokenStream(Ref ref) async* {
  final messaging = ref.watch(firebaseMessagingProvider);

  // iOSの場合は、APNs Tokenを取得してからFCM Tokenを取得する
  if (ref.watch(notificationTokenApnsSupportedProvider)) {
    await ref.read(apnsTokenStreamProvider.future);
  }

  final initialToken = await messaging.getToken();
  if (initialToken != null) {
    yield initialToken;
  }

  yield* messaging.onTokenRefresh;
}

@riverpod
Stream<String> apnsTokenStream(Ref ref) async* {
  final messaging = ref.watch(firebaseMessagingProvider);
  assert(
    kIsWeb || (Platform.isIOS || Platform.isMacOS),
    'APNs Token is only supported on iOS and macOS',
  );

  final initialToken = await messaging.getAPNSToken();
  if (initialToken != null) {
    yield initialToken;
  }

  await for (final _ in messaging.onTokenRefresh) {
    ref.invalidateSelf();
  }
}

@riverpod
Stream<String> apnsPushToStartTokenStream(Ref ref) async* {
  if (kIsWeb || !(Platform.isIOS || Platform.isMacOS)) {
    return;
  }
  final eqmLiveActivityUtil = ref.watch(eqmLiveActivityUtilProvider);

  final initialToken = eqmLiveActivityUtil.pushToStartToken()?.toDartString();
  if (initialToken != null) {
    yield initialToken;
  }

  final controller = StreamController<String>.broadcast();
  ref.onDispose(() {
    eqmLiveActivityUtil.stopObservingPushToStartTokenUpdates();
    controller.close().ignore();
  });

  eqmLiveActivityUtil.observePushToStartTokenUpdates(
    ObjCBlock_ffiVoid_NSString.listener((nsToken) {
      final token = nsToken.toDartString();
      if (!controller.isClosed) {
        controller.add(token);
      }
    }),
  );

  yield* controller.stream;
}
