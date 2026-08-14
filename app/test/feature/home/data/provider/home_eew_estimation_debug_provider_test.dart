import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/provider/device_role_provider.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_eew_estimation_debug_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/home_eew_estimation_debug_provider.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// `debugProvider` を固定するスタブ。
class _StubDebug extends Debug {
  _StubDebug({required this.isEnabled});

  final bool isEnabled;

  @override
  Future<bool> build() async => isEnabled;
}

/// `homeEewEstimationDebugProvider` を固定するスタブ。
class _StubHomeEewEstimationDebug extends HomeEewEstimationDebug {
  _StubHomeEewEstimationDebug({required this.isEnabled});

  final bool isEnabled;

  @override
  Future<bool> build() async => isEnabled;
}

ProviderContainer _container({
  required bool isDebugEnabled,
  required DeviceRole? role,
  required bool isSettingEnabled,
}) {
  final container = ProviderContainer(
    overrides: [
      debugProvider.overrideWith(() => _StubDebug(isEnabled: isDebugEnabled)),
      deviceRoleProvider.overrideWith((ref) async => role),
      homeEewEstimationDebugProvider.overrideWith(
        () => _StubHomeEewEstimationDebug(isEnabled: isSettingEnabled),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('isHomeEewEstimationDebugAvailableProvider', () {
    test('Admin ロール かつ デバッグモード有効なら変更できる', () async {
      final container = _container(
        isDebugEnabled: true,
        role: DeviceRole.admin,
        isSettingEnabled: false,
      );

      await expectLater(
        container.read(isHomeEewEstimationDebugAvailableProvider.future),
        completion(isTrue),
      );
    });

    test('デバッグモードが無効なら変更できない', () async {
      final container = _container(
        isDebugEnabled: false,
        role: DeviceRole.admin,
        isSettingEnabled: true,
      );

      await expectLater(
        container.read(isHomeEewEstimationDebugAvailableProvider.future),
        completion(isFalse),
      );
    });

    test('Admin 以外のロールでは変更できない', () async {
      final container = _container(
        isDebugEnabled: true,
        role: DeviceRole.user,
        isSettingEnabled: true,
      );

      await expectLater(
        container.read(isHomeEewEstimationDebugAvailableProvider.future),
        completion(isFalse),
      );
    });

    test('ロールを取得できない場合は変更できない', () async {
      final container = _container(
        isDebugEnabled: true,
        role: null,
        isSettingEnabled: true,
      );

      await expectLater(
        container.read(isHomeEewEstimationDebugAvailableProvider.future),
        completion(isFalse),
      );
    });
  });

  group('isHomeEewEstimationVisibleProvider', () {
    test('変更権限があり設定が有効なら表示する', () async {
      final container = _container(
        isDebugEnabled: true,
        role: DeviceRole.admin,
        isSettingEnabled: true,
      );

      await expectLater(
        container.read(isHomeEewEstimationVisibleProvider.future),
        completion(isTrue),
      );
    });

    test('変更権限があっても設定が無効なら表示しない', () async {
      final container = _container(
        isDebugEnabled: true,
        role: DeviceRole.admin,
        isSettingEnabled: false,
      );

      await expectLater(
        container.read(isHomeEewEstimationVisibleProvider.future),
        completion(isFalse),
      );
    });

    test('設定が有効でも変更権限を失っていれば表示しない', () async {
      final container = _container(
        isDebugEnabled: true,
        role: DeviceRole.user,
        isSettingEnabled: true,
      );

      await expectLater(
        container.read(isHomeEewEstimationVisibleProvider.future),
        completion(isFalse),
      );
    });
  });
}
