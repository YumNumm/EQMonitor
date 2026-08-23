// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:typed_data';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:flutter_test/flutter_test.dart';

const _initializeChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationHostApi.initialize';
const _peekPendingLocationChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationHostApi.peekPendingLocation';
const _acknowledgePendingLocationChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationHostApi.acknowledgePendingLocation';
const _locationUpdateChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationFlutterApi.onLocationUpdate';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakePendingLocationStore pendingStore;

  setUp(() {
    pendingStore = _FakePendingLocationStore();
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMessageHandler(_initializeChannelName, (_) async {
      return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([null]);
    });
    messenger.setMockMessageHandler(_peekPendingLocationChannelName, (
      message,
    ) async {
      final arguments =
          BackgroundLocationHostApi.pigeonChannelCodec.decodeMessage(message)
              as List<Object?>;
      final consumer = arguments.single as PendingLocationConsumer;
      return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([
        pendingStore.peek(consumer),
      ]);
    });
    messenger.setMockMessageHandler(_acknowledgePendingLocationChannelName, (
      message,
    ) async {
      final arguments =
          BackgroundLocationHostApi.pigeonChannelCodec.decodeMessage(message)
              as List<Object?>;
      return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([
        pendingStore.acknowledge(
          updateId: arguments[0] as String,
          consumer: arguments[1] as PendingLocationConsumer,
        ),
      ]);
    });
  });

  tearDown(() {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMessageHandler(_initializeChannelName, null);
    messenger.setMockMessageHandler(_peekPendingLocationChannelName, null);
    messenger.setMockMessageHandler(
      _acknowledgePendingLocationChannelName,
      null,
    );
    BackgroundLocationFlutterApi.setUp(null);
  });

  test('新旧のstreamがリスナー登録前の最新位置を別の型で再送する', () async {
    await BackgroundLocationTracker.initialize(
      callbackDispatcher: testBackgroundLocationCallbackDispatcher,
    );

    await _sendLocationUpdate(
      PendingLocationMessage(
        updateId: 'first-live-id',
        latitude: 35,
        longitude: 139,
        accuracy: 10,
        timestampMillis: 1000,
      ),
    );
    await _sendLocationUpdate(
      PendingLocationMessage(
        updateId: 'latest-live-id',
        latitude: 36,
        longitude: 140,
        accuracy: 20,
        timestampMillis: 2000,
      ),
    );

    final LocationUpdateMessage legacyLocation = await BackgroundLocationTracker
        .locationStream
        .first
        .timeout(
          const Duration(seconds: 1),
        );
    final pendingLocation = await BackgroundLocationTracker
        .pendingLocationStream
        .first
        .timeout(const Duration(seconds: 1));

    expect(legacyLocation.latitude, 36);
    expect(legacyLocation.longitude, 140);
    expect(legacyLocation.accuracy, 20);
    expect(pendingLocation.updateId, 'latest-live-id');
  });

  test('旧consume APIはappEffectsのack成功後だけ旧型を返す', () async {
    pendingStore.save(
      PendingLocationMessage(
        updateId: 'legacy-consume-id',
        latitude: 35,
        longitude: 139,
        accuracy: 10,
        timestampMillis: 1000,
      ),
    );

    final LocationUpdateMessage? consumed =
        await BackgroundLocationTracker.consumePendingLocation();

    expect(consumed?.latitude, 35);
    expect(
      await BackgroundLocationTracker.peekPendingLocation(
        consumer: PendingLocationConsumer.appEffects,
      ),
      isNull,
    );
    expect(
      (await BackgroundLocationTracker.peekPendingLocation(
        consumer: PendingLocationConsumer.deviceLocation,
      ))?.updateId,
      'legacy-consume-id',
    );
  });

  test('旧consume APIはack失敗時にnullを返しpendingを保持する', () async {
    pendingStore.save(
      PendingLocationMessage(
        updateId: 'retry-id',
        latitude: 35,
        longitude: 139,
        accuracy: 10,
        timestampMillis: 1000,
      ),
    );
    pendingStore.failAcknowledgements = true;

    final consumed = await BackgroundLocationTracker.consumePendingLocation();

    expect(consumed, isNull);
    expect(
      (await BackgroundLocationTracker.peekPendingLocation(
        consumer: PendingLocationConsumer.appEffects,
      ))?.updateId,
      'retry-id',
    );
  });

  test('古いupdateIdのacknowledgeでは新しいpendingを削除しない', () async {
    pendingStore.save(
      PendingLocationMessage(
        updateId: 'new-id',
        latitude: 35,
        longitude: 139,
        accuracy: 10,
        timestampMillis: 1000,
      ),
    );

    final first = await BackgroundLocationTracker.peekPendingLocation(
      consumer: PendingLocationConsumer.deviceLocation,
    );
    final acknowledged =
        await BackgroundLocationTracker.acknowledgePendingLocation(
          updateId: 'older-id',
          consumer: PendingLocationConsumer.deviceLocation,
        );

    expect(first?.updateId, 'new-id');
    expect(acknowledged, isFalse);
    expect(
      (await BackgroundLocationTracker.peekPendingLocation(
        consumer: PendingLocationConsumer.deviceLocation,
      ))?.updateId,
      'new-id',
    );
  });

  test('両方のconsumerがacknowledgeするまでpendingを保持する', () async {
    pendingStore.save(
      PendingLocationMessage(
        updateId: 'new-id',
        latitude: 35,
        longitude: 139,
        accuracy: 10,
        timestampMillis: 1000,
      ),
    );

    expect(
      await BackgroundLocationTracker.acknowledgePendingLocation(
        updateId: 'new-id',
        consumer: PendingLocationConsumer.deviceLocation,
      ),
      isTrue,
    );
    expect(
      await BackgroundLocationTracker.peekPendingLocation(
        consumer: PendingLocationConsumer.deviceLocation,
      ),
      isNull,
    );
    expect(
      (await BackgroundLocationTracker.peekPendingLocation(
        consumer: PendingLocationConsumer.appEffects,
      ))?.updateId,
      'new-id',
    );

    expect(
      await BackgroundLocationTracker.acknowledgePendingLocation(
        updateId: 'new-id',
        consumer: PendingLocationConsumer.appEffects,
      ),
      isTrue,
    );
    expect(
      await BackgroundLocationTracker.peekPendingLocation(
        consumer: PendingLocationConsumer.appEffects,
      ),
      isNull,
    );
  });
}

@pragma('vm:entry-point')
void testBackgroundLocationCallbackDispatcher() {}

Future<void> _sendLocationUpdate(PendingLocationMessage location) async {
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final completer = Completer<ByteData?>();
  await messenger.handlePlatformMessage(
    _locationUpdateChannelName,
    BackgroundLocationFlutterApi.pigeonChannelCodec.encodeMessage([location]),
    completer.complete,
  );
  await completer.future;
}

class _FakePendingLocationStore {
  PendingLocationMessage? _location;
  final _pendingConsumers = <PendingLocationConsumer>{};
  bool failAcknowledgements = false;

  void save(PendingLocationMessage location) {
    _location = location;
    _pendingConsumers
      ..clear()
      ..addAll(PendingLocationConsumer.values);
  }

  PendingLocationMessage? peek(PendingLocationConsumer consumer) =>
      _pendingConsumers.contains(consumer) ? _location : null;

  bool acknowledge({
    required String updateId,
    required PendingLocationConsumer consumer,
  }) {
    if (failAcknowledgements ||
        _location?.updateId != updateId ||
        !_pendingConsumers.contains(consumer)) {
      return false;
    }
    _pendingConsumers.remove(consumer);
    if (_pendingConsumers.isEmpty) {
      _location = null;
    }
    return true;
  }
}
