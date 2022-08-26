import 'package:flutter/material.dart';
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
                    return IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.security_update),
                      color: Colors.redAccent,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
        );
  }
}
