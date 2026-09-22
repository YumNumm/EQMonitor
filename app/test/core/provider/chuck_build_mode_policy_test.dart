import 'package:eqmonitor/core/provider/chuck_build_mode_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChuckBuildModePolicy', () {
    test('ビルドモードによらず通信記録とInspectorを有効にする', () {
      const policy = ChuckBuildModePolicy();

      expect(policy.captureTraffic, isTrue);
      expect(policy.showInspector, isTrue);
    });
  });
}
