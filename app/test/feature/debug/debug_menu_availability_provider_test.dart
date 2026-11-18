import 'package:eqmonitor/feature/debug/data/logic/debug_access_level_resolver.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:flutter_test/flutter_test.dart';

DebugAccessLevel _resolve({
  required DeviceRole? role,
  required bool isDebugEnabled,
}) => const DebugAccessLevelResolver().resolve(
  isDebugEnabled: isDebugEnabled,
  role: role,
);

void main() {
  group('DebugAccessLevelResolver', () {
    test('デバッグモードONのAdminロールは制限なしで開ける', () {
      expect(
        _resolve(role: DeviceRole.admin, isDebugEnabled: true),
        DebugAccessLevel.full,
      );
    });

    test('デバッグモードOFFならAdminロールでも開けない', () {
      expect(
        _resolve(role: DeviceRole.admin, isDebugEnabled: false),
        DebugAccessLevel.none,
      );
    });

    test('デバッグモードONのAdmin以外は制限付きで開ける', () {
      expect(
        _resolve(role: DeviceRole.user, isDebugEnabled: true),
        DebugAccessLevel.restricted,
      );
    });

    test('ロールを取得できない場合は権限ありへフォールバックしない', () {
      expect(
        _resolve(role: null, isDebugEnabled: true),
        DebugAccessLevel.restricted,
      );
    });

    test('デバッグモードOFFならAdmin以外は開けない', () {
      expect(
        _resolve(role: DeviceRole.user, isDebugEnabled: false),
        DebugAccessLevel.none,
      );
    });
  });
}
