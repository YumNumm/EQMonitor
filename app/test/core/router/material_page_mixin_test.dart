import 'dart:io';

import 'package:cupertino_ui/cupertino_ui.dart' show CupertinoPageTransition;
import 'package:eqmonitor/core/router/material_page_mixin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class _PlainRoute extends GoRouteData {
  const _PlainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Scaffold(body: Text('detail'));
}

class _MaterialPageRoute extends GoRouteData with MaterialPageMixin {
  const _MaterialPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Scaffold(body: Text('detail'));
}

/// go_router_builder が生成する `GoRouteData.$route` と同じ形で
/// `builder` / `pageBuilder` の双方を [GoRouteData] に委譲する。
List<RouteBase> _routes(GoRouteData detail) => [
  GoRoute(
    path: '/',
    builder: (_, _) => const Scaffold(body: Text('home')),
  ),
  GoRoute(
    path: '/detail',
    builder: detail.build,
    pageBuilder: detail.buildPage,
  ),
];

Future<ModalRoute<void>?> _pushDetail(
  WidgetTester tester,
  GoRouteData detail,
) async {
  final router = GoRouter(initialLocation: '/', routes: _routes(detail));
  addTearDown(router.dispose);
  await tester.pumpWidget(
    MaterialApp.router(
      theme: ThemeData(platform: TargetPlatform.iOS),
      routerConfig: router,
    ),
  );
  await tester.pumpAndSettle();

  router.push<void>('/detail').ignore();
  await tester.pumpAndSettle();

  return ModalRoute.of(tester.element(find.text('detail')));
}

void main() {
  group('MaterialPageMixin', () {
    testWidgets('mixin なしでは遷移アニメーションを持たないページになる', (tester) async {
      // go_router は Flutter SDK の `MaterialApp` を祖先から探して既定の Page を
      // 決めるため、`material_ui` の `MaterialApp` では検出できず
      // `NoTransitionPage` にフォールバックする。この mixin が必要な理由。
      final route = await _pushDetail(tester, const _PlainRoute());

      expect(route?.transitionDuration, Duration.zero);
      expect(find.byType(CupertinoPageTransition), findsNothing);
    });

    testWidgets('mixin ありでは iOS の遷移アニメーションを持つ', (tester) async {
      final route = await _pushDetail(tester, const _MaterialPageRoute());

      expect(route?.settings, isA<MaterialPage<void>>());
      expect(route?.transitionDuration, greaterThan(Duration.zero));
      expect(find.byType(CupertinoPageTransition), findsWidgets);
    });

    testWidgets('mixin ありでは左端スワイプで前の画面に戻れる', (tester) async {
      await _pushDetail(tester, const _MaterialPageRoute());

      await tester.dragFrom(const Offset(2, 300), const Offset(600, 0));
      await tester.pumpAndSettle();

      expect(find.text('detail'), findsNothing);
      expect(find.text('home'), findsOneWidget);
    });

    testWidgets('mixin なしでは左端スワイプでは戻れない', (tester) async {
      await _pushDetail(tester, const _PlainRoute());

      await tester.dragFrom(const Offset(2, 300), const Offset(600, 0));
      await tester.pumpAndSettle();

      expect(find.text('detail'), findsOneWidget);
    });

    testWidgets('遷移ログ・状態復元に使うページ情報を引き継ぐ', (tester) async {
      final route = await _pushDetail(tester, const _MaterialPageRoute());

      // `_NavigatorObserver` / Firebase Analytics が画面名として参照する。
      expect(route?.settings.name, '/detail');
      expect(
        route?.settings,
        isA<MaterialPage<void>>().having(
          (page) => page.restorationId,
          'restorationId',
          isNotNull,
        ),
      );
    });
  });

  // go_router の Page 生成はルートごとの opt-in であり、mixin を付け忘れても
  // コンパイルエラーにならず遷移アニメーションだけが静かに失われる。
  // ルート定義の追加時に取りこぼしを検知するため、宣言を静的に検査する。
  test('router.dart の全ルートが Page の生成方法を明示している', () {
    /// 独自に [Page] を組み立てるため [MaterialPageMixin] を適用しないルート。
    const routesWithOwnPage = {'HomeRoute'};

    final source = File('lib/core/router/router.dart').readAsStringSync();
    final declarations = RegExp(
      r'class (\w+) extends GoRouteData\s+with ([^{]+)\{',
    ).allMatches(source).toList();

    // 正規表現の取りこぼしがないことを確認する。
    expect(
      declarations.length,
      RegExp('extends GoRouteData').allMatches(source).length,
    );

    for (final declaration in declarations) {
      final name = declaration.group(1);
      if (routesWithOwnPage.contains(name)) {
        continue;
      }
      expect(
        declaration.group(2),
        contains('MaterialPageMixin'),
        reason:
            '$name に MaterialPageMixin が適用されていません。'
            'go_router の既定では遷移アニメーションと iOS のスワイプバックが失われます。',
      );
    }
  });
}
