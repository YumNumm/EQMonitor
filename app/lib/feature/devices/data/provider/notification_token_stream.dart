import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/live_activity/data/provider/eqm_live_activity_util.dart';
import 'package:flutter/foundation.dart';
import 'package:live_activity_util/live_activity_util.dart';
import 'package:objective_c/objective_c.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_token_stream.g.dart';

@Riverpod(keepAlive: true)
Stream<NotificationToken> notificationTokenStream(Ref ref) async* {
  final messaging = ref.watch(firebaseMessagingProvider);
  await messaging.requestPermission(provisional: true);

  final fcmToken = ref.watch(_firebaseMessagingTokenStreamProvider).value;
  final apnsToken = ref.watch(_apnsTokenStreamProvider).value;
  final apnsPushToStartToken = ref
      .watch(_apnsPushToStartTokenStreamProvider)
      .value;

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
  if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
    await ref.read(_apnsTokenStreamProvider.future);
  }

  final initialToken = await messaging.getToken();
  if (initialToken != null) {
    yield initialToken;
  }

  yield* messaging.onTokenRefresh;
}

@Riverpod(keepAlive: true)
Stream<String> _apnsTokenStream(Ref ref) async* {
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

@Riverpod(keepAlive: true)
Stream<String> _apnsPushToStartTokenStream(Ref ref) async* {
  final eqmLiveActivityUtil = ref.watch(eqmLiveActivityUtilProvider);
  assert(
    kIsWeb || (Platform.isIOS || Platform.isMacOS),
    'APNs Token is only supported on iOS and macOS',
  );

  final initialToken = eqmLiveActivityUtil.pushToStartToken()?.toDartString();
  if (initialToken != null) {
    yield initialToken;
  }

  final controller = StreamController<String>.broadcast();
  ref.onDispose(controller.close);

  eqmLiveActivityUtil.observePushToStartTokenUpdates(
    ObjCBlock_ffiVoid_NSString.listener(
      (nsToken) {
        final token = nsToken.toDartString();
        controller.add(token);
      },
    ),
  );

  yield* controller.stream;
}
