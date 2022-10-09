import 'package:eqmonitor/provider/logger.dart';
import 'package:eqmonitor/provider/package_info.dart';
import 'package:eqmonitor/provider/setting/change_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// アップデートがある場合はアイコンを表示
/// ない場合はからのWidgetを返す
class UpdaterButtonWidget extends HookConsumerWidget {
  const UpdaterButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(changeLogProvider).when<Widget>(
          loading: () => const SizedBox.shrink(),
          error: (err, stack) {
            ref.read(loggerProvider).e('error', err, stack);
            return const SizedBox.shrink();
          },
          data: (changeLog) => ref.watch(packageInfoProvider).when<Widget>(
                error: (err, stack) {
                  ref.read(loggerProvider).e('error', err, stack);
                  return const SizedBox.shrink();
                },
                loading: () => const SizedBox.shrink(),
                data: (packageInfo) {
                  if ((int.parse(packageInfo.buildNumber) <
                          changeLog.items.first.buildId) ||
                      kDebugMode) {
                    return TextButton.icon(
                      onPressed: () async {
                        final changeLog = ref.read(changeLogProvider);
                        await showDialog<void>(
                          context: context,
                          builder: (context) => changeLog.when<Widget>(
                            error: (error, stackTrace) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                            loading: () => const SizedBox.shrink(),
                            data: (data) => AlertDialog(
                              title: const Text('アップデート情報'),
                              content: SizedBox(
                                width: 0,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        data.items.first.version,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Divider(),
                                      Markdown(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        data: data.items.first.comment,
                                        shrinkWrap: true,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    launchUrlString(
                                      data.items.first.url,
                                      mode: LaunchMode
                                          .externalNonBrowserApplication,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('ダウンロード'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('OK'),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.security_update),
                      label: const Text(
                        'アップデートがあります',
                        overflow: TextOverflow.clip,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
        );
  }
}
