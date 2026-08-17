import 'package:eqmonitor/core/component/web_view/app_web_view_page.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

void main() {
  test('利用規約ルートは指定URLのAppWebViewPageを構築する', () {
    final page = const TermOfServiceRoute().build(
      _FakeBuildContext(),
      _FakeGoRouterState(),
    );

    expect(page, isA<AppWebViewPage>());
    expect((page as AppWebViewPage).title, '利用規約');
    expect(page.url, 'https://eqmonitor.app/term_of_service');
  });

  test('プライバシーポリシールートは指定URLのAppWebViewPageを構築する', () {
    final page = const PrivacyPolicyRoute().build(
      _FakeBuildContext(),
      _FakeGoRouterState(),
    );

    expect(page, isA<AppWebViewPage>());
    expect((page as AppWebViewPage).title, 'プライバシーポリシー');
    expect(page.url, 'https://eqmonitor.app/privacy_policy');
  });
}

final class _FakeBuildContext extends Fake implements BuildContext {}

final class _FakeGoRouterState extends Fake implements GoRouterState {}
