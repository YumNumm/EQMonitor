import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/widget/intensity/intensity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IntensityColorSettingsPage extends HookConsumerWidget {
  const IntensityColorSettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColor = ref.watch(jmaIntensityColorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('震度配色設定'),
      ),
      body: Column(
        children: [
          // テーマ設定
          ListTile(
            title: const Text('震度0'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Int0,
              size: 42,
              color: intensityColor.int0,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度0'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.int0,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Int0, color);
                    },
                    paletteType: PaletteType.hsl,
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await ref.read(jmaIntensityColorProvider.notifier).saveAll();
          // 戻る
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          // SnackBarを表示
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('保存しました'),
              duration: Duration(milliseconds: 1500),
            ),
          );
        },
        label: const Text('保存'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
