import 'package:eqmonitor/model/setting/kmoni_setting_model.dart';
import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:eqmonitor/ui/view/main/kmoni_map.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showKmoniLayerSelectorAlert(BuildContext context) => showDialog<void>(
      context: context,
      builder: (context) => const KmoniLayerSelectorAlertDialog(),
    );

class KmoniLayerSelectorAlertDialog extends ConsumerWidget {
  const KmoniLayerSelectorAlertDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(kmoniSettingProvider);
    return AlertDialog(
      title: const Text('レイヤー選択'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (final layer in KmoniLayer.values)
              if ([KmoniLayer.baseMap, KmoniLayer.distanceDecayIntensity]
                      .contains(layer) &&
                  !ref.watch(developerModeProvider).isDeveloper)
                const SizedBox.shrink()
              else
                CheckboxListTile(
                  title: Text(layer.name),
                  value: vm.layers.contains(layer),
                  onChanged: (value) {
                    if (value == true) {
                      ref.read(kmoniSettingProvider.notifier).change(
                        layers: {...vm.layers, layer},
                      );
                    } else {
                      ref.read(kmoniSettingProvider.notifier).change(
                            layers: {...vm.layers}..remove(layer),
                          );
                    }
                  },
                ),
          ],
        ),
      ),
      actions: <Widget>[
        // 保存
        TextButton(
          child: const Text('保存'),
          onPressed: () {
            ref.read(kmoniSettingProvider.notifier).save();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
