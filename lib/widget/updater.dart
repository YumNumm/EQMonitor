import 'package:eqmonitor/provider/package_info.dart';
import 'package:eqmonitor/provider/setting/change_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdaterWidget extends HookConsumerWidget {
  const UpdaterWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(ChangeLogProvider).when<Widget>(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (changeLog) => ref.watch(packageInfoProvider).when<Widget>(
                error: (_, __) => const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                data: (packageInfo) {
                  if ((int.parse(packageInfo.buildNumber) <
                          changeLog.items.first.buildId) &&
                      changeLog.items.first.isBreakingChange) {
                    return AlertDialog(
                      title: Text(
                        'アップデートがあります - ${changeLog.items.first.version}',
                      ),
                      content: SingleChildScrollView(
                        child: Markdown(
                          data: changeLog.items.first.comment,
                          shrinkWrap: true,
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          child: const Text('アップデート'),
                          onPressed: () async {
                            await launchUrlString(
                              changeLog.items.first.url,
                              mode: LaunchMode.externalNonBrowserApplication,
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
        );
  }
}
