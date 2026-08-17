import 'dart:async';

import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/feature/devices/data/data_source/apns_token_callback_data_source.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_platform_capabilities.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('APNs emits getAPNSToken result before callback updates', () async {
    final callbacks = StreamController<String>();
    addTearDown(callbacks.close);
    final harness = createHarness(
      initialApnsToken: 'initial-token',
      callbackTokens: callbacks.stream,
    );
    final emitted = <String>[];
    final initialEmitted = Completer<void>();
    final callbackEmitted = Completer<void>();
    final subscription = harness.container.listen(
      apnsNotificationTokenStreamProvider,
      (_, next) {
        if (next case AsyncData(:final value)) {
          emitted.add(value);
          if (value == 'initial-token' && !initialEmitted.isCompleted) {
            initialEmitted.complete();
          }
          if (value == 'callback-token' && !callbackEmitted.isCompleted) {
            callbackEmitted.complete();
          }
        }
      },
      fireImmediately: true,
    );
    addTearDown(subscription.close);

    await initialEmitted.future;
    expect(emitted, ['initial-token']);

    callbacks.add('callback-token');
    await callbackEmitted.future;
    expect(emitted, ['initial-token', 'callback-token']);
  });

  test('null initial APNs token is followed by callback updates', () async {
    final callbacks = StreamController<String>();
    addTearDown(callbacks.close);
    final harness = createHarness(callbackTokens: callbacks.stream);
    final emitted = <String>[];
    final callbackEmitted = Completer<void>();
    final subscription = harness.container.listen(
      apnsNotificationTokenStreamProvider,
      (_, next) {
        if (next case AsyncData(:final value)) {
          emitted.add(value);
          if (value == 'callback-token' && !callbackEmitted.isCompleted) {
            callbackEmitted.complete();
          }
        }
      },
      fireImmediately: true,
    );
    addTearDown(subscription.close);

    await harness.callbackDataSource.readStarted;
    expect(emitted, isEmpty);

    callbacks.add('callback-token');
    await callbackEmitted.future;
    expect(emitted, ['callback-token']);
  });

  test('duplicate initial and callback APNs tokens are suppressed', () async {
    final callbacks = StreamController<String>();
    addTearDown(callbacks.close);
    final harness = createHarness(
      initialApnsToken: 'same-token',
      callbackTokens: callbacks.stream,
    );
    final emitted = <String>[];
    final initialEmitted = Completer<void>();
    final newTokenEmitted = Completer<void>();
    final subscription = harness.container.listen(
      apnsNotificationTokenStreamProvider,
      (_, next) {
        if (next case AsyncData(:final value)) {
          emitted.add(value);
          if (value == 'same-token' && !initialEmitted.isCompleted) {
            initialEmitted.complete();
          }
          if (value == 'new-token' && !newTokenEmitted.isCompleted) {
            newTokenEmitted.complete();
          }
        }
      },
      fireImmediately: true,
    );
    addTearDown(subscription.close);

    await initialEmitted.future;
    await harness.callbackDataSource.readStarted;
    callbacks.add('same-token');
    callbacks.add('new-token');
    callbacks.add('new-token');
    await newTokenEmitted.future;

    expect(emitted, ['same-token', 'new-token']);
  });

  test(
    'callback during initial lookup replays only the latest cached token',
    () async {
      final initialToken = Completer<String?>();
      final callbacks = _ReplayingApnsTokenCallbackDataSource();
      addTearDown(callbacks.close);
      final harness = createHarness(
        initialApnsTokenFuture: initialToken.future,
        callbackDataSource: callbacks,
      );
      final emitted = <String>[];
      final latestCallbackEmitted = Completer<void>();
      final subscription = harness.container.listen(
        apnsNotificationTokenStreamProvider,
        (_, next) {
          if (next case AsyncData(:final value)) {
            emitted.add(value);
            if (value == 'latest-callback' &&
                !latestCallbackEmitted.isCompleted) {
              latestCallbackEmitted.complete();
            }
          }
        },
        fireImmediately: true,
      );
      addTearDown(subscription.close);

      await harness.messaging.apnsTokenReadStarted;
      callbacks.publish('stale-callback');
      callbacks.publish('latest-callback');
      expect(callbacks.readCount, 0);
      initialToken.complete('initial-token');

      await latestCallbackEmitted.future;
      expect(emitted, ['initial-token', 'latest-callback']);
    },
  );

  test('FCM refresh does not re-read APNs token', () async {
    final harness = createHarness(initialApnsToken: 'initial-token');
    final initialFcmEmitted = Completer<void>();
    final refreshedFcmEmitted = Completer<void>();
    final subscription = harness.container.listen(
      notificationTokenStreamProvider,
      (_, next) {
        if (next.value?.fcmToken == 'fcm-token' &&
            !initialFcmEmitted.isCompleted) {
          initialFcmEmitted.complete();
        }
        if (next.value?.fcmToken == 'new-fcm-token' &&
            !refreshedFcmEmitted.isCompleted) {
          refreshedFcmEmitted.complete();
        }
      },
      fireImmediately: true,
    );
    addTearDown(subscription.close);

    await harness.firstApnsToken;
    await initialFcmEmitted.future;
    harness.fcmRefreshes.add('new-fcm-token');
    await refreshedFcmEmitted.future;

    expect(harness.messaging.apnsTokenReadCount, 1);
  });

  test('Android does not read the APNs data source', () async {
    final fcmRefreshes = StreamController<String>.broadcast();
    final callbackDataSource = _FakeApnsTokenCallbackDataSource(
      const Stream.empty(),
    );
    final messaging = _FakeFirebaseMessaging(
      initialApnsToken: 'unused-apns-token',
      fcmRefreshes: fcmRefreshes,
    );
    final container = ProviderContainer(
      overrides: [
        firebaseMessagingProvider.overrideWithValue(messaging),
        apnsTokenCallbackDataSourceProvider.overrideWithValue(
          callbackDataSource,
        ),
        pushTokenPlatformCapabilitiesProvider.overrideWithValue(
          PushTokenPlatformCapabilities.forPlatform(platform: .android),
        ),
      ],
    );
    addTearDown(fcmRefreshes.close);
    addTearDown(container.dispose);
    final firstFcmTokenEmitted = Completer<void>();
    final subscription = container.listen(notificationTokenStreamProvider, (
      _,
      next,
    ) {
      if (next.value?.fcmToken == 'fcm-token' &&
          !firstFcmTokenEmitted.isCompleted) {
        firstFcmTokenEmitted.complete();
      }
    }, fireImmediately: true);
    addTearDown(subscription.close);

    await firstFcmTokenEmitted.future;

    expect(messaging.apnsTokenReadCount, 0);
    expect(callbackDataSource.readCount, 0);
  });
}

({
  ProviderContainer container,
  _FakeFirebaseMessaging messaging,
  StreamController<String> fcmRefreshes,
  Future<String> firstApnsToken,
  _FakeApnsTokenCallbackDataSource callbackDataSource,
})
createHarness({
  String? initialApnsToken,
  Future<String?>? initialApnsTokenFuture,
  Stream<String>? callbackTokens,
  _FakeApnsTokenCallbackDataSource? callbackDataSource,
}) {
  final fcmRefreshes = StreamController<String>.broadcast();
  final messaging = _FakeFirebaseMessaging(
    initialApnsToken: initialApnsToken,
    initialApnsTokenFuture: initialApnsTokenFuture,
    fcmRefreshes: fcmRefreshes,
  );
  final resolvedCallbackDataSource =
      callbackDataSource ??
      _FakeApnsTokenCallbackDataSource(callbackTokens ?? const Stream.empty());
  final container = ProviderContainer(
    overrides: [
      firebaseMessagingProvider.overrideWithValue(messaging),
      apnsTokenCallbackDataSourceProvider.overrideWithValue(
        resolvedCallbackDataSource,
      ),
      pushTokenPlatformCapabilitiesProvider.overrideWithValue(
        PushTokenPlatformCapabilities.forPlatform(
          platform: .ios,
          iosMajorVersion: 17,
        ),
      ),
    ],
  );
  addTearDown(fcmRefreshes.close);
  addTearDown(container.dispose);
  return (
    container: container,
    messaging: messaging,
    fcmRefreshes: fcmRefreshes,
    firstApnsToken: container.read(apnsNotificationTokenStreamProvider.future),
    callbackDataSource: resolvedCallbackDataSource,
  );
}

class _FakeApnsTokenCallbackDataSource implements ApnsTokenCallbackDataSource {
  _FakeApnsTokenCallbackDataSource(this._tokens);

  final Stream<String> _tokens;
  var readCount = 0;
  final _readStarted = Completer<void>();
  Future<void> get readStarted => _readStarted.future;

  @override
  Stream<String> get tokenUpdates {
    readCount++;
    if (!_readStarted.isCompleted) {
      _readStarted.complete();
    }
    return _tokens;
  }
}

final class _ReplayingApnsTokenCallbackDataSource
    extends _FakeApnsTokenCallbackDataSource {
  _ReplayingApnsTokenCallbackDataSource() : super(const Stream.empty());

  final _updates = StreamController<String>.broadcast();
  String? _latestToken;

  void publish(String token) {
    _latestToken = token;
    _updates.add(token);
  }

  @override
  Stream<String> get tokenUpdates async* {
    readCount++;
    if (!_readStarted.isCompleted) {
      _readStarted.complete();
    }
    final latestToken = _latestToken;
    if (latestToken != null) {
      yield latestToken;
    }
    yield* _updates.stream;
  }

  Future<void> close() => _updates.close();
}

final class _FakeFirebaseMessaging extends Fake implements FirebaseMessaging {
  _FakeFirebaseMessaging({
    required this.initialApnsToken,
    this.initialApnsTokenFuture,
    required this.fcmRefreshes,
  });

  final String? initialApnsToken;
  final Future<String?>? initialApnsTokenFuture;
  final StreamController<String> fcmRefreshes;
  var apnsTokenReadCount = 0;
  final _apnsTokenReadStarted = Completer<void>();
  Future<void> get apnsTokenReadStarted => _apnsTokenReadStarted.future;

  @override
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
    bool providesAppNotificationSettings = false,
  }) async => _notificationSettings;

  @override
  Future<String?> getAPNSToken() async {
    apnsTokenReadCount++;
    if (!_apnsTokenReadStarted.isCompleted) {
      _apnsTokenReadStarted.complete();
    }
    return initialApnsTokenFuture ?? initialApnsToken;
  }

  @override
  Future<String?> getToken({
    String? vapidKey,
    String? serviceWorkerScriptPath,
  }) async => 'fcm-token';

  @override
  Stream<String> get onTokenRefresh => fcmRefreshes.stream;
}

final _notificationSettings = NotificationSettings(
  alert: AppleNotificationSetting.notSupported,
  announcement: AppleNotificationSetting.notSupported,
  authorizationStatus: AuthorizationStatus.provisional,
  badge: AppleNotificationSetting.notSupported,
  carPlay: AppleNotificationSetting.notSupported,
  lockScreen: AppleNotificationSetting.notSupported,
  notificationCenter: AppleNotificationSetting.notSupported,
  showPreviews: AppleShowPreviewSetting.notSupported,
  timeSensitive: AppleNotificationSetting.notSupported,
  criticalAlert: AppleNotificationSetting.notSupported,
  sound: AppleNotificationSetting.notSupported,
  providesAppNotificationSettings: AppleNotificationSetting.notSupported,
);
