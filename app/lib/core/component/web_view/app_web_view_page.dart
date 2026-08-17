import 'package:eqmonitor/core/component/web_view/app_web_view_body.dart';
import 'package:eqmonitor/core/component/web_view/app_web_view_navigation_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:material_ui/material_ui.dart';

class AppWebViewPage extends HookWidget {
  const AppWebViewPage({required this.title, required this.url, super.key});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    final navigation = useState(const AppWebViewNavigationState.initial());
    final generation = navigation.value.generation;
    final webView = useMemoized(
      () => InAppWebView(
        key: ValueKey<int>(generation),
        initialUrlRequest: URLRequest(url: WebUri(url)),
        onLoadStart: (_, value) {
          navigation.value = navigation.value.loadStarted(
            generation: generation,
            url: value,
          );
        },
        onLoadStop: (_, value) {
          navigation.value = navigation.value.loadStopped(
            generation: generation,
            url: value,
          );
        },
        onReceivedError: (_, request, error) {
          navigation.value = navigation.value.networkError(
            generation: generation,
            url: request.url,
            isForMainFrame: request.isForMainFrame,
            isCancellation: error.type == WebResourceErrorType.CANCELLED,
          );
        },
        onReceivedHttpError: (_, request, response) {
          navigation.value = navigation.value.httpError(
            generation: generation,
            url: request.url,
            isForMainFrame: request.isForMainFrame,
            statusCode: response.statusCode,
          );
        },
      ),
      [generation, url],
    );

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: AppWebViewBody(
        status: navigation.value.status,
        onRetry: () async {
          navigation.value = navigation.value.retry();
        },
        webView: webView,
      ),
    );
  }
}
