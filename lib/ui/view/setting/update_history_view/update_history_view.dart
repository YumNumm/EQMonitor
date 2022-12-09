import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../provider/setting/change_log.dart';

class UpdateHistoryView extends HookConsumerWidget {
  const UpdateHistoryView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changeLogProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('更新履歴')),
      body: state.when<Widget>(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
        data: (data) => ListView.builder(
          itemCount: data.items.length,
          itemBuilder: (context, index) {
            final item = data.items[index];
            return ExpansionTile(
              initiallyExpanded: index == 0,
              title: ListTile(
                title: Text(
                  item.version,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(item.date),
                ),
              ),
              children: [
                Markdown(
                  data: '${item.comment}\n---\nBuild ${item.buildId}',
                  shrinkWrap: true,
                  selectable: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      final url = item.url;
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('URLを開けませんでした: $url'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('ブラウザで開く'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
