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

  test('リスナー登録前に届いた最新の位置更新を再送する', () async {
    await BackgroundLocationTracker.initialize();

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

    final location = await BackgroundLocationTracker.locationStream.first
        .timeout(const Duration(seconds: 1));

    expect(location.latitude, 36);
    expect(location.longitude, 140);
    expect(location.accuracy, 20);
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
    if (_location?.updateId != updateId ||
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
