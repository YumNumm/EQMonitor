import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/layer/base_layer_debug_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewPsWaveLayerDebugPage extends BaseLayerDebugPage {
  const EewPsWaveLayerDebugPage({super.key});

  @override
  String get title => 'EEW P波・S波レイヤーデバッグ';

  @override
  String get description => 'EEW P波・S波レイヤーは、緊急地震速報の震源から伝播するP波とS波を地図上に表示します。'
      'P波は青色の円、S波は赤色の円で表示され、時間とともに拡大します。';

  @override
  Map<String, dynamic> get defaultLayerParams => {
        'pWaveColor': Colors.blue.value,
        'sWaveColor': Colors.red.value,
        'lineWidth': 2.0,
        'animationDuration': 1.0,
      };

  @override
  Widget buildLayer(
    BuildContext context,
    WidgetRef ref,
    MapController controller,
    ValueNotifier<Map<String, dynamic>> layerParams,
  ) {
    // 実際のEewPsWaveLayerを使用
    // デバッグ用のパラメータは反映されませんが、実際のデータを表示できます
    return const EewPsWaveLayer();
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
        // P波の色
        ListTile(
          title: const Text('P波の色'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(layerParams.value['pWaveColor'] as int),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('P波の色を選択'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: Color(layerParams.value['pWaveColor'] as int),
                    onColorChanged: (color) {
                      layerParams.value = {
                        ...layerParams.value,
                        'pWaveColor': color.value,
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

        // S波の色
        ListTile(
          title: const Text('S波の色'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(layerParams.value['sWaveColor'] as int),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('S波の色を選択'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: Color(layerParams.value['sWaveColor'] as int),
                    onColorChanged: (color) {
                      layerParams.value = {
                        ...layerParams.value,
                        'sWaveColor': color.value,
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

        // 線の幅
        ListTile(
          title: const Text('線の幅'),
          subtitle: Text('${layerParams.value['lineWidth']}px'),
        ),
        Slider(
          min: 0.5,
          max: 5.0,
          divisions: 9,
          value: layerParams.value['lineWidth'] as double,
          label: '${layerParams.value['lineWidth']}px',
          onChanged: (value) {
            layerParams.value = {
              ...layerParams.value,
              'lineWidth': value,
            };
          },
        ),

        // アニメーション速度
        ListTile(
          title: const Text('アニメーション速度'),
          subtitle: Text('${layerParams.value['animationDuration']}秒'),
        ),
        Slider(
          min: 0.1,
          max: 3.0,
          divisions: 29,
          value: layerParams.value['animationDuration'] as double,
          label: '${layerParams.value['animationDuration']}秒',
          onChanged: (value) {
            layerParams.value = {
              ...layerParams.value,
              'animationDuration': value,
            };
          },
        ),

        // 注意書き
        const SizedBox(height: 16),
        const Card(
          color: Colors.amber,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '注意: 現在の実装では、パラメータの変更は実際のレイヤーに反映されません。'
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
