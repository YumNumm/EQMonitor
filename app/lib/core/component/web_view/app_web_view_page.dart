import 'package:eqmonitor/core/component/web_view/app_web_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AppWebViewPage extends HookWidget {
  const AppWebViewPage({required this.title, required this.url, super.key});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    final controller = useRef<InAppWebViewController?>(null);
    final status = useState(AppWebViewLoadStatus.loading);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: AppWebViewBody(
        status: status.value,
        onRetry: () async {
          status.value = AppWebViewLoadStatus.loading;
          await controller.value?.reload();
        },
        webView: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(url)),
          onWebViewCreated: (value) => controller.value = value,
          onLoadStart: (_, _) => status.value = AppWebViewLoadStatus.loading,
          onLoadStop: (_, _) {
            if (status.value != AppWebViewLoadStatus.error) {
              status.value = AppWebViewLoadStatus.loaded;
            }
          },
          onReceivedError: (_, request, _) {
            if (request.isForMainFrame ?? true) {
              status.value = AppWebViewLoadStatus.error;
            }
          },
          onReceivedHttpError: (_, request, response) {
            final isFailure = (response.statusCode ?? 0) >= 400;
            if ((request.isForMainFrame ?? true) && isFailure) {
              status.value = AppWebViewLoadStatus.error;
            }
          },
        ),
      ),
    );
  }
}
