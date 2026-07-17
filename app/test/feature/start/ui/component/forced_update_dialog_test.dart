import 'package:eqmonitor/feature/start/ui/component/forced_update_dialog.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  final packageInfo = PackageInfo(
    appName: 'EQMonitor',
    packageName: 'net.yumnumm.eqmonitor',
    version: '3.0.0',
    buildNumber: '100',
  );
  final matcher = ForcedUpdateRequirementMatcher(packageInfo: packageInfo);

  group('ForcedUpdateRequirementMatcher', () {
    test('requires updates for build-number-only rules', () {
      const requiredVersion = api.RequiredVersion(buildNumber: 101);

      expect(matcher.isUpdateRequired(requiredVersion), isTrue);
    });

    test('does not require updates for satisfied build-number-only rules', () {
      const requiredVersion = api.RequiredVersion(buildNumber: 100);

      expect(matcher.isUpdateRequired(requiredVersion), isFalse);
    });

    test('keeps requiring updates for semantic version rules', () {
      const requiredVersion = api.RequiredVersion(version: '3.1.0');

      expect(matcher.isUpdateRequired(requiredVersion), isTrue);
    });
  });
}
