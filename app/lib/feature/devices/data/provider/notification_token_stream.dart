import 'dart:async';

import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/feature/devices/data/data_source/apns_token_callback_data_source.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/live_activity/data/provider/eqm_live_activity_util.dart';
import 'package:live_activity_util/live_activity_util.dart';
import 'package:objective_c/objective_c.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_token_stream.g.dart';

@Riverpod(keepAlive: true)
Stream<NotificationToken> notificationTokenStream(Ref ref) async* {
  final messaging = ref.watch(firebaseMessagingProvider);
  await messaging.requestPermission(provisional: true);
  final capabilities = ref.watch(pushTokenPlatformCapabilitiesProvider);

  final fcmToken = capabilities.supportsFcm
      ? ref.watch(_firebaseMessagingTokenStreamProvider).value
      : null;
  final apnsToken = capabilities.supportsApns
      ? ref.watch(apnsNotificationTokenStreamProvider).value
      : null;
  final apnsPushToStartToken = capabilities.supportsPushToStart
      ? ref.watch(apnsPushToStartTokenStreamProvider).value
      : null;

  yield NotificationToken(
    fcmToken: fcmToken,
    apnsToken: apnsToken,
    apnsPushToStartToken: apnsPushToStartToken,
  );
}

@Riverpod(keepAlive: true)
Stream<String> _firebaseMessagingTokenStream(Ref ref) async* {
  final messaging = ref.watch(firebaseMessagingProvider);

  // iOSの場合は、APNs Tokenを取得してからFCM Tokenを取得する
  if (ref.watch(pushTokenPlatformCapabilitiesProvider).supportsApns) {
    await ref.read(apnsNotificationTokenStreamProvider.future);
  }

  final initialToken = await messaging.getToken();
  if (initialToken != null) {
    yield initialToken;
  }

  yield* messaging.onTokenRefresh;
}

@Riverpod(keepAlive: true)
Stream<String> apnsNotificationTokenStream(Ref ref) async* {
  final messaging = ref.watch(firebaseMessagingProvider);
  assert(
    ref.watch(pushTokenPlatformCapabilitiesProvider).supportsApns,
    'APNs Token is only supported on iOS',
  );

  final initialToken = await messaging.getAPNSToken();
  var lastToken = initialToken;
  if (initialToken != null) {
    yield initialToken;
  }

  final callbackDataSource = ref.watch(apnsTokenCallbackDataSourceProvider);
  await for (final token in callbackDataSource.tokenUpdates) {
    if (token == lastToken) {
      continue;
    }
    lastToken = token;
    yield token;
  }
}

@Riverpod(keepAlive: true)
Stream<String> apnsPushToStartTokenStream(Ref ref) async* {
  if (!ref.watch(pushTokenPlatformCapabilitiesProvider).supportsPushToStart) {
    return;
  }
  final eqmLiveActivityUtil = ref.watch(eqmLiveActivityUtilProvider);

  final initialToken = eqmLiveActivityUtil.pushToStartToken()?.toDartString();
  if (initialToken != null) {
    yield initialToken;
  }

  final controller = StreamController<String>.broadcast();
  ref.onDispose(controller.close);

  eqmLiveActivityUtil.observePushToStartTokenUpdates(
    ObjCBlock_ffiVoid_NSString.listener((nsToken) {
      final token = nsToken.toDartString();
      controller.add(token);
    }),
  );

  yield* controller.stream;
}
