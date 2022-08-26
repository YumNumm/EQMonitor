import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../introduction.dart';

/// ## 利用規約のページ
/// ページの末尾にライセンス同意ボタンを表示するかは[showAcceptButton]で指定
class TermOfServicePage extends HookConsumerWidget {
  const TermOfServicePage({required this.showAcceptButton, super.key});
  final bool showAcceptButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('利用規約'),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString('assets/docs/term_of_service.md'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final markdownSource = snapshot.data!.toString();
            return SingleChildScrollView(
              child: Markdown(
                shrinkWrap: true,
                selectable: true,
                physics: const NeverScrollableScrollPhysics(),
                data: markdownSource,
                onTapLink: (text, href, title) => launchUrlString(
                  href.toString(),
                  mode: LaunchMode.externalNonBrowserApplication,
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
      bottomNavigationBar: showAcceptButton
          ? BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                          } else if (Platform.isIOS) {
                            exit(0);
                          }
                        },
                        label: const Text('同意しない'),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          ref.watch(introductionController).animateToPage(
                                1,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.bounceOut,
                              );
                        },
                        label: const Text('同意する'),
                        icon: const Icon(Icons.check),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
