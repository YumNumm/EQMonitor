import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/widget/intensity/intensity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IntensityColorSettingsPage extends HookConsumerWidget {
  const IntensityColorSettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColor = ref.watch(jmaIntensityColorProvider);

    final unknown = useState(intensityColor.unknown);
    final int0 = useState(intensityColor.int0);
    final int1 = useState(intensityColor.int1);
    final int2 = useState(intensityColor.int2);
    final int3 = useState(intensityColor.int3);
    final int4 = useState(intensityColor.int4);
    final int5Lower = useState(intensityColor.int5Lower);
    final int5Upper = useState(intensityColor.int5Upper);
    final int6Lower = useState(intensityColor.int6Lower);
    final int6Upper = useState(intensityColor.int6Upper);
    final int7 = useState(intensityColor.int7);
    final over = useState(intensityColor.over);
    final error = useState(intensityColor.error);

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
              color: int0.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度0'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: int0.value,
                    onColorChanged: (color) {
                      int0.value = color;
                    },
                    paletteType: PaletteType.hsl,
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
              color: int1.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度1'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: int1.value,
                    onColorChanged: (color) {
                      int1.value = color;
                    },
                    paletteType: PaletteType.hsl,
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
              color: int2.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度2'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: int2.value,
                    onColorChanged: (color) {
                      int2.value = color;
                    },
                    paletteType: PaletteType.hsl,
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
              color: int3.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度3'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: int3.value,
                    onColorChanged: (color) {
                      int1.value = color;
                    },
                    paletteType: PaletteType.hsl,
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
              color: int4.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度4'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: int4.value,
                    onColorChanged: (color) {
                      int4.value = color;
                    },
                    paletteType: PaletteType.hsl,
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
              color: int5Lower.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度5弱'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: int5Lower.value,
                    onColorChanged: (color) {
                      int5Lower.value = color;
                    },
                    paletteType: PaletteType.hsl,
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
              color: int5Upper.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度5強'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: int5Upper.value,
                    onColorChanged: (color) {
                      int5Upper.value = color;
                    },
                    paletteType: PaletteType.hsl,
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
              color: int6Lower.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度6弱'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: int5Lower.value,
                    onColorChanged: (color) {
                      int6Lower.value = color;
                    },
                    paletteType: PaletteType.hsl,
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
              color: int6Upper.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度6強'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: int6Upper.value,
                    onColorChanged: (color) {
                      int6Upper.value = color;
                    },
                    paletteType: PaletteType.hsl,
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
              color: int7.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度7'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: int7.value,
                    onColorChanged: (color) {
                      int7.value = color;
                    },
                    paletteType: PaletteType.hsl,
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
              color: unknown.value,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('震度不明'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: unknown.value,
                    onColorChanged: (color) {
                      unknown.value = color;
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
        },
        label: const Text('保存'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
