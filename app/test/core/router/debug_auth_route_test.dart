import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/auth/ui/page/debug_auth_page.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  test('Native認証デバッグルートはDebug配下の固定pathを使う', () {
    expect(const DebugAuthRoute().location, '/settings/debug/auth');
  });

  test('Native認証デバッグルートは専用ページを構築する', () {
    final page = const DebugAuthRoute().build(
      _FakeBuildContext(),
      _FakeGoRouterState(),
    );

    expect(page, isA<DebugAuthPage>());
  });

  test('Debugメニュー利用不可時はNative認証デバッグルートをHomeへ戻す', () {
    expect(
      DebugMenuRouteGuard.redirect(
        accessLevel: DebugAccessLevel.none,
        matchedLocation: '/settings/debug/auth',
        isOnboardingCompleted: true,
      ),
      '/',
    );
  });

  test('制限付きの利用時はNative認証デバッグルートをDebugメニューへ戻す', () {
    expect(
      DebugMenuRouteGuard.redirect(
        accessLevel: DebugAccessLevel.restricted,
        matchedLocation: '/settings/debug/auth',
        isOnboardingCompleted: true,
      ),
      '/settings/debug',
    );
  });

  test('Admin の利用時はNative認証デバッグルートを許可する', () {
    expect(
      DebugMenuRouteGuard.redirect(
        accessLevel: DebugAccessLevel.full,
        matchedLocation: '/settings/debug/auth',
        isOnboardingCompleted: true,
      ),
      isNull,
    );
  });
}

final class _FakeBuildContext extends Fake implements BuildContext;

final class _FakeGoRouterState extends Fake implements GoRouterState;
