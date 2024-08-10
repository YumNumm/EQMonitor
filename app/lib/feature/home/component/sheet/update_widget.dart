import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/app_information/app_information.dart';
import 'package:eqmonitor/core/provider/app_information/app_information_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateWidget extends HookConsumerWidget {
  const UpdateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          return ref.read(appInformationProvider.notifier).load();
        });
        return null;
      },
      [],
    );
    ref.listen(appInformationProvider, (_, next) {
      if (next is AsyncData<AppInformationModel>) {
        final value = next.value;
        // force update check
        if (value.hasForceUpdate) {
          showModalBottomSheet<void>(
            context: context,
            isDismissible: false,
            builder: (_) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        'アプリの更新が必要です: v${value.latestVersion}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(value.forceUpdateMessage ?? 'アップデートがあります'),
                    ),
                    OverflowBar(
                      children: [
                        TextButton(
                          onPressed: () {
                            launchUrl(
                              value.downloadUrl ??
                                  Uri.parse('https://eqmonitor.page.link/app'),
                            );
                          },
                          child: const Text(
                            '更新',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }
    });

    final state = ref.watch(appInformationProvider);
    return switch (state) {
      AsyncData(:final value) when value.hasUpdate => BorderedContainer(
          onPressed: () async => launchUrl(
            value.downloadUrl ?? Uri.parse('https://eqmonitor.app'),
            mode: LaunchMode.externalApplication,
          ),
          elevation: 1,
          margin: const EdgeInsets.symmetric(
                horizontal: 12,
              ) +
              const EdgeInsets.only(
                bottom: 8,
              ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: ListTile(
            tileColor: Colors.transparent,
            title: Text(
              'アプリの更新があります: v${value.latestVersion}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('利用可能なアップデートがあります'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
