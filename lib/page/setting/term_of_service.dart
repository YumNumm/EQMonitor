import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// ## 利用規約のページ
/// ページの末尾にライセンス同意ボタンを表示するかは[showAcceptButton]で指定
class TermOfServicePage extends StatefulHookConsumerWidget {
  const TermOfServicePage({super.key, required this.showAcceptButton});
  final bool showAcceptButton;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TermOfServicePageState();
}

class _TermOfServicePageState extends ConsumerState<TermOfServicePage> {
  late bool showAcceptButton;

  @override
  void initState() {
    super.initState();
    showAcceptButton = widget.showAcceptButton;

    // 利用規約を読み込む
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('利用規約'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: rootBundle.loadString('assets/docs/term_of_service.md'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final markdownSource = snapshot.data!.toString();
              return Column(
                children: [
                  // Markdown 本文
                  Markdown(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    data: markdownSource,
                    onTapLink: (text, href, title) =>
                        launchUrlString(href.toString()),
                  ),
                  const Divider(),
                  if (showAcceptButton)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: FloatingActionButton.extended(
                              onPressed: () {},
                              label: const Text('同意する'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FloatingActionButton.extended(
                              onPressed: () {},
                              label: const Text('同意する'),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        ),
      ),
    );
  }
}
