import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/feature/debug/data/logic/debug_menu_availability_resolver.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:flutter_test/flutter_test.dart';

BuildConfig _buildConfig({
  required bool isProduction,
  Flavor flavor = Flavor.prod,
}) => BuildConfig(
  restApiUrl: '',
  appIdSuffix: '',
  appName: '',
  commitInformation: '',
  flavor: flavor,
  wsApiUrl: '',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
  isProduction: isProduction,
);

bool _resolve({
  required DeviceRole? role,
  required bool isDebugEnabled,
  bool isProduction = false,
  Flavor flavor = Flavor.prod,
}) => const DebugMenuAvailabilityResolver().resolve(
  isDebugBuild: false,
  role: role,
  buildConfig: _buildConfig(isProduction: isProduction, flavor: flavor),
  isDebugEnabled: isDebugEnabled,
);

void main() {
  group('resolveDebugMenuAvailability', () {
    test('一般配布ビルド(production)でもAdminロールなら開ける', () {
      expect(
        _resolve(
          role: DeviceRole.admin,
          isDebugEnabled: false,
          isProduction: true,
        ),
        isTrue,
      );
    });

    test('デバッグモードOFFでもAdminロールなら開ける', () {
      expect(
        _resolve(role: DeviceRole.admin, isDebugEnabled: false),
        isTrue,
      );
    });

    test('一般配布ビルド(production)ではAdmin以外は開けない', () {
      expect(
        _resolve(
          role: DeviceRole.user,
          isDebugEnabled: true,
          isProduction: true,
        ),
        isFalse,
      );
    });

    test('ロールを取得できない場合は権限ありへフォールバックしない', () {
      expect(
        _resolve(role: null, isDebugEnabled: true, isProduction: true),
        isFalse,
      );
    });

    test('デバッグUI有効なビルドではデバッグモードONで開ける', () {
      expect(_resolve(role: DeviceRole.user, isDebugEnabled: true), isTrue);
    });

    test('デバッグUI有効なビルドでもデバッグモードOFFなら開けない', () {
      expect(_resolve(role: DeviceRole.user, isDebugEnabled: false), isFalse);
    });

    test('production の dev ビルドもデバッグモードOFFなら開けない', () {
      expect(
        _resolve(
          role: DeviceRole.user,
          isDebugEnabled: false,
          isProduction: true,
          flavor: Flavor.dev,
        ),
        isFalse,
      );
    });

    test('デバッグビルドならロールもデバッグモードも問わず開ける', () {
      expect(
        const DebugMenuAvailabilityResolver().resolve(
          isDebugBuild: true,
          role: null,
          buildConfig: _buildConfig(isProduction: true),
          isDebugEnabled: false,
        ),
        isTrue,
      );
    });
  });
}
