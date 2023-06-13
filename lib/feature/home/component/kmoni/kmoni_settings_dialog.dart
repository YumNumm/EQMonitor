import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/kmoni/viewmodel/kmoni_view_settings.dart';

class KmoniSettingsDialogWidget extends ConsumerWidget {
  const KmoniSettingsDialogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kmoniSettingsProvider);
    return AlertDialog(
      title: const Text('強震モニタの設定'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile.adaptive(
            title: const Text('震度0以上のみ表示'),
            subtitle: const Text('震度0(観測震度0.5)以上の観測点のみ表示します'),
            value: state.isUpper0Only,
            onChanged: (value) {
              ref.read(kmoniSettingsProvider.notifier).toggleIsUpper0Only();
            },
          ),
          SwitchListTile.adaptive(
            title: const Text('震度アイコンを表示'),
            value: state.isShowIntensityIcon,
            onChanged: (value) {
              ref
                  .read(kmoniSettingsProvider.notifier)
                  .toggleIsShowIntensityIcon();
            },
          ),
        ],
      ),
    );
  }
}
