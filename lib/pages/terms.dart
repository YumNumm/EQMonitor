import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsScreen extends StatelessWidget {
  TermsScreen({super.key});
  final SharedPreferences prefs = Get.find<SharedPreferences>();
  Future<String> getTermString() async {
    final res = await http.get(
      Uri.parse(
        'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/docs/policy.md',
      ),
    );
    return res.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('利用規約同意'),
      ),
      body: Column(
        children: [
          Row(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: AutoSizeText(
              '利用規約に同意しますか?\n'
              '最後までお読みください。',
              maxLines: 2,
              style: context.textTheme.titleLarge,
            ),
          ),
          FutureBuilder(
            future: getTermString(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final sc = ScrollController();
                return Expanded(
                  child: SingleChildScrollView(
                    controller: sc,
                    child: Column(
                      children: [
                        MarkdownBody(
                          data: snapshot.data.toString(),
                          selectable: true,
                          onTapLink: (t1, t2, t3) => launch(t1),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatingActionButton.extended(
                                onPressed: () async {
                                  Get.showSnackbar(
                                    const GetSnackBar(
                                      duration: Duration(seconds: 1),
                                      title: '利用規約に同意してください ',
                                      message:
                                          '利用規約に同意していただけない場合は、アプリケーションを利用できません。',
                                    ),
                                  );
                                },
                                label: const Text('同意しない'),
                                icon: const Icon(Icons.exit_to_app),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                              ),
                              FloatingActionButton.extended(
                                onPressed: () async {
                                  await prefs.setBool('isAcceptTerm', true);
                                  await Get.offAllNamed<void>('/');
                                },
                                label: const Text('同意する'),
                                icon: const Icon(Icons.check),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
