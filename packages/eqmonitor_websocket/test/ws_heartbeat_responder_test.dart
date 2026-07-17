import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:test/test.dart';

void main() {
  group('WsHeartbeatResponder', () {
    const responder = WsHeartbeatResponder();

    test('application-level ping に pong JSON を返すこと', () {
      expect(responder.buildResponse('{"type":"ping"}'), '{"type":"pong"}');
    });

    test('ping 以外のメッセージには応答しないこと', () {
      expect(responder.buildResponse('{"type":"ready"}'), isNull);
    });

    test('不正な JSON には応答しないこと', () {
      expect(responder.buildResponse('not-json'), isNull);
    });
  });
}
