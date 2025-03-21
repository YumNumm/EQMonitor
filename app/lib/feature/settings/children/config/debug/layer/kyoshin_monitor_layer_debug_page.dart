import 'package:eqmonitor/core/extension/color_extension.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_layer.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/layer/base_layer_debug_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class KyoshinMonitorLayerDebugPage extends BaseLayerDebugPage {
  const KyoshinMonitorLayerDebugPage({super.key});

  @override
  String get title => '強震モニタレイヤーデバッグ';

  @override
  String get description =>
      '強震モニタレイヤーは、リアルタイムの地震観測データを地図上に表示します。'
      '各観測点は円で表示され、その色は観測された震度に応じて変化します。';

  @override
  Map<String, dynamic> get defaultLayerParams => {
    'showStroke': true,
    'circleRadius': 10.0,
    'strokeColor': Colors.grey.toHexStringRGB(),
    'strokeWidth': 1.0,
  };

  @override
  Widget buildLayer(
    BuildContext context,
    WidgetRef ref,
    MapController controller,
    ValueNotifier<Map<String, dynamic>> layerParams,
  ) {
    // 実際のKyoshinMonitorLayerを使用
    // デバッグ用のパラメータは反映されませんが、実際のデータを表示できます
    return const KyoshinMonitorLayer();
  }

  @override
  Widget buildControls(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<Map<String, dynamic>> layerParams,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 枠線の表示
        SwitchListTile(
          title: const Text('枠線を表示'),
          subtitle: Text(
            layerParams.value['showStroke'] as bool ? 'ON' : 'OFF',
          ),
          value: layerParams.value['showStroke'] as bool,
          onChanged: (value) {
            layerParams.value = {...layerParams.value, 'showStroke': value};
          },
        ),

        // 円の半径
        ListTile(
          title: const Text('円の半径'),
          subtitle: Text('${layerParams.value['circleRadius']}px'),
        ),
        Slider(
          min: 1,
          max: 20,
          divisions: 19,
          value: layerParams.value['circleRadius'] as double,
          label: '${layerParams.value['circleRadius']}px',
          onChanged: (value) {
            layerParams.value = {...layerParams.value, 'circleRadius': value};
          },
        ),

        // 枠線の色
        ListTile(
          title: const Text('枠線の色'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(layerParams.value['strokeColor'] as int),
              border: Border.all(),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onTap: () async {
            await showDialog<void>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('枠線の色を選択'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: Color(
                          layerParams.value['strokeColor'] as int,
                        ),
                        onColorChanged: (color) {
                          layerParams.value = {
                            ...layerParams.value,
                            'strokeColor': color.toHexStringRGB(),
                          };
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          },
        ),

        // 枠線の幅
        ListTile(
          title: const Text('枠線の幅'),
          subtitle: Text('${layerParams.value['strokeWidth']}px'),
        ),
        Slider(
          min: 0.1,
          max: 5,
          divisions: 49,
          value: layerParams.value['strokeWidth'] as double,
          label: '${layerParams.value['strokeWidth']}px',
          onChanged: (value) {
            layerParams.value = {...layerParams.value, 'strokeWidth': value};
          },
        ),

        // 注意書き
        const SizedBox(height: 16),
        const Card(
          color: Colors.amber,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '注意: 現在の実装では、パラメータの変更は実際のレイヤーに反映されません。 '
              'これは、実際のレイヤーの実装を直接使用しているためです。'
              '将来的には、パラメータを直接反映できるようにする予定です。',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
