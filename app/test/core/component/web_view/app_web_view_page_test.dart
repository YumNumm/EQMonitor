import 'package:eqmonitor/core/component/web_view/app_web_view_page.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _initialUrl = 'https://eqmonitor.app/term_of_service';
const _redirectedUrl = 'https://eqmonitor.app/term_of_service/latest';

void main() {
  testWidgets('main-frame network errorだけを全画面エラーにする', (tester) async {
    for (final frame in <bool?>[true, false, null]) {
      final platform = RecordingInAppWebViewPlatform();
      InAppWebViewPlatform.instance = platform;
      await tester.pumpWidget(_app(key: ValueKey('network-$frame')));
      final callbacks = platform.singleCreation;

      emitLoadStart(callbacks: callbacks, url: _initialUrl);
      emitNetworkError(
        callbacks: callbacks,
        url: _initialUrl,
        isForMainFrame: frame,
      );
      await tester.pump();

      expect(
        find.text('ページを読み込めませんでした'),
        frame == true ? findsOneWidget : findsNothing,
        reason: 'isForMainFrame=$frame',
      );
      expect(
        find.byType(CircularProgressIndicator),
        frame == true ? findsNothing : findsOneWidget,
        reason: 'isForMainFrame=$frame',
      );
    }
  });

  testWidgets('main-frame cancellationは全画面エラーにしない', (tester) async {
    final platform = RecordingInAppWebViewPlatform();
    InAppWebViewPlatform.instance = platform;
    await tester.pumpWidget(_app());
    final callbacks = platform.singleCreation;

    emitLoadStart(callbacks: callbacks, url: _initialUrl);
    emitNetworkError(
      callbacks: callbacks,
      url: _initialUrl,
      isForMainFrame: true,
      errorType: WebResourceErrorType.CANCELLED,
    );
    await tester.pump();

    expect(find.text('ページを読み込めませんでした'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HTTP 400以上のmain-frame応答だけを全画面エラーにする', (tester) async {
    final cases = <({bool? frame, int statusCode, bool showsError})>[
      (frame: true, statusCode: 399, showsError: false),
      (frame: true, statusCode: 400, showsError: true),
      (frame: false, statusCode: 500, showsError: false),
      (frame: null, statusCode: 500, showsError: false),
    ];

    for (final testCase in cases) {
      final platform = RecordingInAppWebViewPlatform();
      InAppWebViewPlatform.instance = platform;
      await tester.pumpWidget(
        _app(key: ValueKey('http-${testCase.frame}-${testCase.statusCode}')),
      );
      final callbacks = platform.singleCreation;

      emitLoadStart(callbacks: callbacks, url: _initialUrl);
      emitHttpError(
        callbacks: callbacks,
        url: _initialUrl,
        isForMainFrame: testCase.frame,
        statusCode: testCase.statusCode,
      );
      await tester.pump();

      expect(
        find.text('ページを読み込めませんでした'),
        testCase.showsError ? findsOneWidget : findsNothing,
        reason:
            'isForMainFrame=${testCase.frame}, status=${testCase.statusCode}',
      );
    }
  });

  testWidgets('同じ世代でsuperseded URLのterminal eventを無視する', (tester) async {
    final platform = RecordingInAppWebViewPlatform();
    InAppWebViewPlatform.instance = platform;
    await tester.pumpWidget(_app());
    final callbacks = platform.singleCreation;

    emitLoadStart(callbacks: callbacks, url: _initialUrl);
    emitLoadStart(callbacks: callbacks, url: _redirectedUrl);
    emitLoadStop(callbacks: callbacks, url: _initialUrl);
    emitNetworkError(
      callbacks: callbacks,
      url: _initialUrl,
      isForMainFrame: true,
    );
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('ページを読み込めませんでした'), findsNothing);
  });

  testWidgets('active URLのerror後にloadStopが来てもerrorを維持する', (tester) async {
    final platform = RecordingInAppWebViewPlatform();
    InAppWebViewPlatform.instance = platform;
    await tester.pumpWidget(_app());
    final callbacks = platform.singleCreation;

    emitLoadStart(callbacks: callbacks, url: _initialUrl);
    emitNetworkError(
      callbacks: callbacks,
      url: _initialUrl,
      isForMainFrame: true,
    );
    emitLoadStop(callbacks: callbacks, url: _initialUrl);
    await tester.pump();

    expect(find.text('ページを読み込めませんでした'), findsOneWidget);
  });

  testWidgets('retryはreloadではなく新しいWebView世代をloadingで構築する', (tester) async {
    final platform = RecordingInAppWebViewPlatform();
    InAppWebViewPlatform.instance = platform;
    await tester.pumpWidget(_app());
    final firstCallbacks = platform.singleCreation;

    emitLoadStart(callbacks: firstCallbacks, url: _initialUrl);
    emitNetworkError(
      callbacks: firstCallbacks,
      url: _initialUrl,
      isForMainFrame: true,
    );
    await tester.pump();
    await tester.tap(find.text('再読み込み'));
    await tester.pump();

    expect(platform.creations, hasLength(2));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    final webView = tester.widget<InAppWebView>(find.byType(InAppWebView));
    expect(webView.key, const ValueKey<int>(1));
    expect(
      platform.creations.last.initialUrlRequest?.url.toString(),
      _initialUrl,
    );
  });

  testWidgets('retry前の同一URL callbackは新しい世代を変更しない', (tester) async {
    final platform = RecordingInAppWebViewPlatform();
    InAppWebViewPlatform.instance = platform;
    await tester.pumpWidget(_app());
    final firstCallbacks = platform.singleCreation;

    emitLoadStart(callbacks: firstCallbacks, url: _initialUrl);
    emitNetworkError(
      callbacks: firstCallbacks,
      url: _initialUrl,
      isForMainFrame: true,
    );
    await tester.pump();
    await tester.tap(find.text('再読み込み'));
    await tester.pump();
    expect(platform.creations, hasLength(2));

    emitLoadStart(callbacks: platform.creations.last, url: _initialUrl);
    emitNetworkError(
      callbacks: firstCallbacks,
      url: _initialUrl,
      isForMainFrame: true,
    );
    emitLoadStop(callbacks: firstCallbacks, url: _initialUrl);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('ページを読み込めませんでした'), findsNothing);
  });
}

Widget _app({Key? key}) {
  final colorSet = AppTheme.eqmonitorDefault().light;
  if (colorSet == null) {
    throw StateError('Light theme is missing');
  }

  return MaterialApp(
    theme: AppThemeDataBuilder.build(
      colorSet: colorSet,
      brightness: Brightness.light,
    ),
    home: AppWebViewPage(key: key, title: '利用規約', url: _initialUrl),
  );
}

final class RecordingInAppWebViewPlatform extends InAppWebViewPlatform {
  final creations = <PlatformInAppWebViewWidgetCreationParams>[];

  PlatformInAppWebViewWidgetCreationParams get singleCreation {
    if (creations.length != 1) {
      throw StateError(
        'Expected one WebView creation, got ${creations.length}',
      );
    }
    return creations.single;
  }

  @override
  PlatformInAppWebViewWidget createPlatformInAppWebViewWidget(
    PlatformInAppWebViewWidgetCreationParams params,
  ) {
    creations.add(params);
    return RecordingPlatformInAppWebViewWidget(params);
  }
}

final class RecordingPlatformInAppWebViewWidget
    extends PlatformInAppWebViewWidget {
  RecordingPlatformInAppWebViewWidget(super.params) : super.implementation();

  @override
  T controllerFromPlatform<T>(PlatformInAppWebViewController controller) =>
      controller as T;

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}

final class RecordingPlatformInAppWebViewController
    extends PlatformInAppWebViewController {
  RecordingPlatformInAppWebViewController()
    : super.implementation(
        const PlatformInAppWebViewControllerCreationParams(id: 'test'),
      );

  @override
  void dispose({bool isKeepAlive = false}) {}
}

void emitLoadStart({
  required PlatformInAppWebViewWidgetCreationParams callbacks,
  required String url,
}) {
  final callback = callbacks.onLoadStart;
  if (callback == null) {
    throw StateError('onLoadStart callback is missing');
  }
  callback(controllerFor(callbacks), WebUri(url));
}

void emitLoadStop({
  required PlatformInAppWebViewWidgetCreationParams callbacks,
  required String url,
}) {
  final callback = callbacks.onLoadStop;
  if (callback == null) {
    throw StateError('onLoadStop callback is missing');
  }
  callback(controllerFor(callbacks), WebUri(url));
}

void emitNetworkError({
  required PlatformInAppWebViewWidgetCreationParams callbacks,
  required String url,
  required bool? isForMainFrame,
  WebResourceErrorType? errorType,
}) {
  final callback = callbacks.onReceivedError;
  if (callback == null) {
    throw StateError('onReceivedError callback is missing');
  }
  callback(
    controllerFor(callbacks),
    WebResourceRequest(url: WebUri(url), isForMainFrame: isForMainFrame),
    WebResourceError(
      description: 'test failure',
      type: errorType ?? WebResourceErrorType.HOST_LOOKUP,
    ),
  );
}

void emitHttpError({
  required PlatformInAppWebViewWidgetCreationParams callbacks,
  required String url,
  required bool? isForMainFrame,
  required int statusCode,
}) {
  final callback = callbacks.onReceivedHttpError;
  if (callback == null) {
    throw StateError('onReceivedHttpError callback is missing');
  }
  callback(
    controllerFor(callbacks),
    WebResourceRequest(url: WebUri(url), isForMainFrame: isForMainFrame),
    WebResourceResponse(statusCode: statusCode),
  );
}

InAppWebViewController controllerFor(
  PlatformInAppWebViewWidgetCreationParams callbacks,
) {
  final platform = InAppWebViewPlatform.instance;
  final converter = callbacks.controllerFromPlatform;
  if (platform is! RecordingInAppWebViewPlatform || converter == null) {
    throw StateError('Recording WebView platform is missing');
  }
  return converter(RecordingPlatformInAppWebViewController())
      as InAppWebViewController;
}
