import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../provider/setting/intensity_color_provider.dart';
import '../../../theme/jma_intensity.dart';
import '../../../view/widget/intensity_widget.dart';

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
            subtitle: Text(intensityColor.int0.toString()),
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
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('震度1'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Int1,
              size: 42,
              color: intensityColor.int1,
            ),
            subtitle: Text(intensityColor.int1.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度1'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.int1,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Int1, color);
                    },
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('震度2'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Int2,
              size: 42,
              color: intensityColor.int2,
            ),
            subtitle: Text(intensityColor.int2.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度2'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.int2,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Int2, color);
                    },
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('震度3'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Int3,
              size: 42,
              color: intensityColor.int3,
            ),
            subtitle: Text(intensityColor.int3.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度3'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.int3,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Int3, color);
                    },
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('震度4'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Int4,
              size: 42,
              color: intensityColor.int4,
            ),
            subtitle: Text(intensityColor.int4.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度4'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.int4,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Int4, color);
                    },
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('震度5弱'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Int5Lower,
              size: 42,
              color: intensityColor.int5Lower,
            ),
            subtitle: Text(intensityColor.int5Lower.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度5弱'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.int5Lower,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Int5Lower, color);
                    },
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('震度5強'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Int5Upper,
              size: 42,
              color: intensityColor.int5Upper,
            ),
            subtitle: Text(intensityColor.int5Upper.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度5強'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.int5Upper,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Int5Upper, color);
                    },
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('震度6弱'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Int6Lower,
              size: 42,
              color: intensityColor.int6Lower,
            ),
            subtitle: Text(intensityColor.int6Lower.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度6弱'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.int6Lower,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Int6Lower, color);
                    },
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('震度6強'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Int6Upper,
              size: 42,
              color: intensityColor.int6Upper,
            ),
            subtitle: Text(intensityColor.int6Upper.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度6強'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.int6Upper,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Int6Upper, color);
                    },
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('震度7'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Int7,
              size: 42,
              color: intensityColor.int7,
            ),
            subtitle: Text(intensityColor.int7.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度7'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.int7,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Int7, color);
                    },
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('震度不明'),
            leading: IntensityWidget(
              intensity: JmaIntensity.Unknown,
              size: 42,
              color: intensityColor.unknown,
            ),
            subtitle: Text(intensityColor.unknown.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度不明'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: intensityColor.unknown,
                    onColorChanged: (color) {
                      ref
                          .read(jmaIntensityColorProvider.notifier)
                          .change(JmaIntensity.Unknown, color);
                    },
                    hexInputBar: true,
                  ),
                ),
              ),
            ),
          ),
          const Divider(),

          ListTile(
            title: const Text('デフォルトに戻す'),
            leading: const Icon(Icons.restore),
            onTap: () async =>
                ref.read(jmaIntensityColorProvider.notifier).reset(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await ref.read(jmaIntensityColorProvider.notifier).saveAll();
          // 戻る
          // ignore: use_build_context_synchronously
          GoRouter.of(context).pop();
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
