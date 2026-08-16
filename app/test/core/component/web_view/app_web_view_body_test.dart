import 'package:eqmonitor/core/component/web_view/app_web_view_body.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('loadingは進捗表示を重ねる', (tester) async {
    await tester.pumpWidget(_app(status: AppWebViewLoadStatus.loading));

    expect(find.byKey(const Key('web-view-content')), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('loadedはWebViewだけを表示する', (tester) async {
    await tester.pumpWidget(_app(status: AppWebViewLoadStatus.loaded));

    expect(find.byKey(const Key('web-view-content')), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('ページを読み込めませんでした'), findsNothing);
  });

  testWidgets('errorは安全な文言と再読み込み操作を表示する', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      _app(
        status: AppWebViewLoadStatus.error,
        onRetry: () async => retried = true,
      ),
    );

    expect(find.text('ページを読み込めませんでした'), findsOneWidget);
    expect(find.textContaining('Exception'), findsNothing);
    await tester.tap(find.text('再読み込み'));
    expect(retried, true);
  });
}

Widget _app({
  required AppWebViewLoadStatus status,
  Future<void> Function()? onRetry,
}) {
  final colorSet = AppTheme.eqmonitorDefault().light;
  if (colorSet == null) {
    throw StateError('Light theme is missing');
  }

  return MaterialApp(
    theme: buildTheme(colorSet: colorSet, brightness: Brightness.light),
    home: AppWebViewBody(
      webView: const SizedBox(key: Key('web-view-content')),
      status: status,
      onRetry: onRetry ?? () async {},
    ),
  );
}
