import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/start/data/notifier/update_banner_seen_version_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

// CompleteOnboardingFlow が呼ぶ副作用を単体で検証する。
// （flow は onboardingCompleted + seenVersion 初期化 + Home 遷移を行うが、
//  ここでは初回起動でバナーを出さないための seenVersion 初期化のみを対象とする）
final _packageInfo = PackageInfo(
  appName: 'EQMonitor',
  packageName: 'net.yumnumm.eqmonitor',
  version: '3.0.0',
  buildNumber: '1',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('完了時に seenVersion を現在版へ初期化するとバナーは非表示条件になる', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer(
      overrides: [packageInfoProvider.overrideWithValue(_packageInfo)],
    );
    addTearDown(container.dispose);
    await container.read(updateBannerSeenVersionProvider.future);

    // complete ステップの副作用と同等の処理
    final version = container.read(packageInfoProvider).version;
    await container
        .read(updateBannerSeenVersionProvider.notifier)
        .markSeen(version);

    expect(container.read(updateBannerSeenVersionProvider).value, '3.0.0');
  });
}
