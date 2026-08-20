import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_menu_availability_provider.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:flutter_test/flutter_test.dart';

BuildConfig _buildConfig({
  required bool isBetaTesting,
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
  isBetaTesting: isBetaTesting,
);

bool _resolve({
  required DeviceRole? role,
  required bool isDebugEnabled,
  bool isBetaTesting = false,
  Flavor flavor = Flavor.prod,
}) => resolveDebugMenuAvailability(
  isDebugBuild: false,
  role: role,
  buildConfig: _buildConfig(isBetaTesting: isBetaTesting, flavor: flavor),
  isDebugEnabled: isDebugEnabled,
);

void main() {
  group('resolveDebugMenuAvailability', () {
    test('一般配布ビルド(BETA/prod)でもAdminロールなら開ける', () {
      expect(
        _resolve(
          role: DeviceRole.admin,
          isDebugEnabled: false,
          isBetaTesting: true,
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

    test('一般配布ビルド(BETA/prod)ではAdmin以外は開けない', () {
      expect(
        _resolve(
          role: DeviceRole.user,
          isDebugEnabled: true,
          isBetaTesting: true,
        ),
        isFalse,
      );
    });

    test('ロールを取得できない場合は権限ありへフォールバックしない', () {
      expect(
        _resolve(role: null, isDebugEnabled: true, isBetaTesting: true),
        isFalse,
      );
    });

    test('デバッグUI有効なビルドではデバッグモードONで開ける', () {
      expect(_resolve(role: DeviceRole.user, isDebugEnabled: true), isTrue);
    });

    test('デバッグUI有効なビルドでもデバッグモードOFFなら開けない', () {
      expect(_resolve(role: DeviceRole.user, isDebugEnabled: false), isFalse);
    });

    test('BETA配布のdevビルドはデバッグモードOFFでも開ける', () {
      expect(
        _resolve(
          role: DeviceRole.user,
          isDebugEnabled: false,
          isBetaTesting: true,
          flavor: Flavor.dev,
        ),
        isTrue,
      );
    });

    test('デバッグビルドならロールもデバッグモードも問わず開ける', () {
      expect(
        resolveDebugMenuAvailability(
          isDebugBuild: true,
          role: null,
          buildConfig: _buildConfig(isBetaTesting: true),
          isDebugEnabled: false,
        ),
        isTrue,
      );
    });
  });
}
