import 'dart:async';
import 'dart:typed_data';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:flutter_test/flutter_test.dart';

const _initializeChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationHostApi.initialize';
const _locationUpdateChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationFlutterApi.onLocationUpdate';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMessageHandler(_initializeChannelName, (_) async {
      return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([null]);
    });
  });

  tearDown(() {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMessageHandler(_initializeChannelName, null);
    BackgroundLocationFlutterApi.setUp(null);
  });

  test('リスナー登録前に届いた最新の位置更新を再送する', () async {
    await BackgroundLocationTracker.initialize();

    await _sendLocationUpdate(
      LocationUpdateMessage(latitude: 35, longitude: 139, accuracy: 10),
    );
    await _sendLocationUpdate(
      LocationUpdateMessage(latitude: 36, longitude: 140, accuracy: 20),
    );

    final location = await BackgroundLocationTracker.locationStream.first
        .timeout(const Duration(seconds: 1));

    expect(location.latitude, 36);
    expect(location.longitude, 140);
    expect(location.accuracy, 20);
  });
}

Future<void> _sendLocationUpdate(LocationUpdateMessage location) async {
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
