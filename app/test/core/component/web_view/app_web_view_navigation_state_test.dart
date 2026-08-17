import 'package:eqmonitor/core/component/web_view/app_web_view_body.dart';
import 'package:eqmonitor/core/component/web_view/app_web_view_navigation_state.dart';
import 'package:flutter_test/flutter_test.dart';

final _initialUri = Uri.parse('https://eqmonitor.app/term_of_service');
final _redirectedUri = Uri.parse(
  'https://eqmonitor.app/term_of_service/latest',
);

void main() {
  test('retryは世代を進めactive URLを破棄してloadingに戻す', () {
    final loaded = const AppWebViewNavigationState.initial()
        .loadStarted(generation: 0, url: _initialUri)
        .loadStopped(generation: 0, url: _initialUri);

    final retried = loaded.retry();

    expect(retried.generation, 1);
    expect(retried.activeMainFrameUrl, isNull);
    expect(retried.status, AppWebViewLoadStatus.loading);
  });

  test('network errorはactive世代・URLかつmain-frame trueだけをerrorにする', () {
    final loading = const AppWebViewNavigationState.initial().loadStarted(
      generation: 0,
      url: _initialUri,
    );

    for (final frame in <bool?>[true, false, null]) {
      final result = loading.networkError(
        generation: 0,
        url: _initialUri,
        isForMainFrame: frame,
        isCancellation: false,
      );

      expect(
        result.status,
        frame == true
            ? AppWebViewLoadStatus.error
            : AppWebViewLoadStatus.loading,
        reason: 'isForMainFrame=$frame',
      );
    }
  });

  test('cancellation errorはactive main-frameでも無視する', () {
    final loading = const AppWebViewNavigationState.initial().loadStarted(
      generation: 0,
      url: _initialUri,
    );

    final result = loading.networkError(
      generation: 0,
      url: _initialUri,
      isForMainFrame: true,
      isCancellation: true,
    );

    expect(result.status, AppWebViewLoadStatus.loading);
  });

  test('HTTP errorはactive main-frameの400以上だけをerrorにする', () {
    final loading = const AppWebViewNavigationState.initial().loadStarted(
      generation: 0,
      url: _initialUri,
    );
    final cases = <({bool? frame, int? statusCode, AppWebViewLoadStatus want})>[
      (frame: true, statusCode: 399, want: AppWebViewLoadStatus.loading),
      (frame: true, statusCode: 400, want: AppWebViewLoadStatus.error),
      (frame: false, statusCode: 500, want: AppWebViewLoadStatus.loading),
      (frame: null, statusCode: 500, want: AppWebViewLoadStatus.loading),
      (frame: true, statusCode: null, want: AppWebViewLoadStatus.loading),
    ];

    for (final testCase in cases) {
      final result = loading.httpError(
        generation: 0,
        url: _initialUri,
        isForMainFrame: testCase.frame,
        statusCode: testCase.statusCode,
      );

      expect(
        result.status,
        testCase.want,
        reason:
            'isForMainFrame=${testCase.frame}, status=${testCase.statusCode}',
      );
    }
  });

  test('retry前の同一URL terminal eventは世代不一致として無視する', () {
    final retried = const AppWebViewNavigationState.initial()
        .loadStarted(generation: 0, url: _initialUri)
        .retry()
        .loadStarted(generation: 1, url: _initialUri);

    final oldError = retried.networkError(
      generation: 0,
      url: _initialUri,
      isForMainFrame: true,
      isCancellation: false,
    );
    final oldStop = oldError.loadStopped(generation: 0, url: _initialUri);

    expect(oldStop.status, AppWebViewLoadStatus.loading);
  });

  test('同じ世代で新しいstartにsupersedeされたURLのterminal eventを無視する', () {
    final redirected = const AppWebViewNavigationState.initial()
        .loadStarted(generation: 0, url: _initialUri)
        .loadStarted(generation: 0, url: _redirectedUri);

    final oldError = redirected.networkError(
      generation: 0,
      url: _initialUri,
      isForMainFrame: true,
      isCancellation: false,
    );
    final oldStop = oldError.loadStopped(generation: 0, url: _initialUri);

    expect(oldStop.status, AppWebViewLoadStatus.loading);
    expect(oldStop.activeMainFrameUrl, _redirectedUri.toString());
  });

  test('active error後のloadStopはerrorを上書きしない', () {
    final error = const AppWebViewNavigationState.initial()
        .loadStarted(generation: 0, url: _initialUri)
        .networkError(
          generation: 0,
          url: _initialUri,
          isForMainFrame: true,
          isCancellation: false,
        );

    final stopped = error.loadStopped(generation: 0, url: _initialUri);

    expect(stopped.status, AppWebViewLoadStatus.error);
  });

  test('active loadStop後に同じnavigationのerrorが来たらerrorを表示する', () {
    final loaded = const AppWebViewNavigationState.initial()
        .loadStarted(generation: 0, url: _initialUri)
        .loadStopped(generation: 0, url: _initialUri);

    final error = loaded.networkError(
      generation: 0,
      url: _initialUri,
      isForMainFrame: true,
      isCancellation: false,
    );

    expect(error.status, AppWebViewLoadStatus.error);
  });
}
