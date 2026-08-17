import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'apns_token_callback_data_source.g.dart';

@Riverpod(keepAlive: true)
ApnsTokenCallbackDataSource apnsTokenCallbackDataSource(Ref ref) =>
    const EventChannelApnsTokenCallbackDataSource(
      EventChannel('net.yumnumm.eqmonitor/apns-token'),
    );

abstract interface class ApnsTokenCallbackDataSource {
  Stream<String> get tokenUpdates;
}

final class EventChannelApnsTokenCallbackDataSource
    implements ApnsTokenCallbackDataSource {
  const EventChannelApnsTokenCallbackDataSource(this._channel);

  final EventChannel _channel;

  @override
  Stream<String> get tokenUpdates async* {
    await for (final value in _channel.receiveBroadcastStream()) {
      if (value case final String token when token.isNotEmpty) {
        yield token;
      } else {
        throw const FormatException('Invalid APNs token callback payload');
      }
    }
  }
}
