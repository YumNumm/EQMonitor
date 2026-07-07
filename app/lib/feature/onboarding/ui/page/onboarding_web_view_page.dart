import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class OnboardingWebViewPage extends StatelessWidget {
  const OnboardingWebViewPage({
    required this.title,
    required this.url,
    super.key,
  });

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    final uri = WebUri(url);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: InAppWebView(initialUrlRequest: URLRequest(url: uri)),
    );
  }
}
