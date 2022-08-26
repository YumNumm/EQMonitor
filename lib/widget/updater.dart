import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/logger.dart';
import '../provider/package_info.dart';
import '../provider/setting/change_log.dart';

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
                          changeLog.items.first.buildId) &&
                      changeLog.items.first.isBreakingChange) {
                    return TextButton.icon(
                      onPressed: () async {
                        final changeLog = ref.watch(changeLogProvider);
                        await showDialog<void>(
                          context: context,
                          builder: (context) => changeLog.when<Widget>(
                            error: (error, stackTrace) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                            loading: () => const SizedBox.shrink(),
                            data: (data) => AlertDialog(
                              title: const Text('アップデート情報'),
                              content: Markdown(
                                data: data.items.first.comment,
                                shrinkWrap: true,
                              ),
                              actions: [
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
