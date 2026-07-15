import 'package:eqmonitor/core/provider/chuck_build_mode_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChuckBuildModePolicy', () {
    test('Release相当では通信記録とInspectorを有効にし通知を無効にする', () {
      const policy = ChuckBuildModePolicy(isDebugMode: false);

      expect(policy.captureTraffic, isTrue);
      expect(policy.showInspector, isTrue);
      expect(policy.showNotification, isFalse);
    });

    test('Debug相当では通信記録とInspectorと通知を有効にする', () {
      const policy = ChuckBuildModePolicy(isDebugMode: true);

      expect(policy.captureTraffic, isTrue);
      expect(policy.showInspector, isTrue);
      expect(policy.showNotification, isTrue);
    });
  });
}
