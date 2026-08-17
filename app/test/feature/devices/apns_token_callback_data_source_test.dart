import 'dart:async';

import 'package:eqmonitor/feature/devices/data/data_source/apns_token_callback_data_source.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _channelName = 'net.yumnumm.eqmonitor/apns-token';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  const codec = StandardMethodCodec();

  setUp(() {
    messenger.setMockMessageHandler(
      _channelName,
      (_) async => codec.encodeSuccessEnvelope(null),
    );
  });

  tearDown(() {
    messenger.setMockMessageHandler(_channelName, null);
  });

  test('valid String callback emits the APNs token', () async {
    final dataSource = EventChannelApnsTokenCallbackDataSource(
      const EventChannel(_channelName),
    );
    final token = dataSource.tokenUpdates.first;
    await pumpEventQueue();

    await _sendEvent(codec.encodeSuccessEnvelope('callback-token'));

    await expectLater(token, completion('callback-token'));
  });

  test('non-String callback produces FormatException', () async {
    final dataSource = EventChannelApnsTokenCallbackDataSource(
      const EventChannel(_channelName),
    );
    final expectation = expectLater(
      dataSource.tokenUpdates,
      emitsError(isA<FormatException>()),
    );
    await pumpEventQueue();

    await _sendEvent(codec.encodeSuccessEnvelope(42));

    await expectation;
  });
}

Future<void> _sendEvent(ByteData event) async {
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final completer = Completer<ByteData?>();
  await messenger.handlePlatformMessage(
    _channelName,
    event,
    completer.complete,
  );
  await completer.future;
}
