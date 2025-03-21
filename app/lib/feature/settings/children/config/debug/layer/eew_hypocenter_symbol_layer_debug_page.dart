import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_hypocenter_symbol_layer.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/layer/base_layer_debug_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewHypocenterSymbolLayerDebugPage extends BaseLayerDebugPage {
  const EewHypocenterSymbolLayerDebugPage({super.key});

  @override
  String get title => 'EEW震源シンボルレイヤーデバッグ';

  @override
  String get description => 'EEW震源シンボルレイヤーは、緊急地震速報の震源位置を地図上に表示します。'
      '震源位置にはアイコンが表示され、精度の低い震源は異なるアイコンで表示されます。';

  @override
  Map<String, dynamic> get defaultLayerParams => {
        'iconSize': 1.0,
        'allowOverlap': true,
      };

  @override
  Widget buildLayer(
    BuildContext context,
    WidgetRef ref,
    MapController controller,
    ValueNotifier<Map<String, dynamic>> layerParams,
  ) {
    // 実際のEewHypocenterSymbolLayerを使用
    // デバッグ用のパラメータは反映されませんが、実際のデータを表示できます
    return const EewHypocenterSymbolLayer();
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
        // アイコンサイズ
        ListTile(
          title: const Text('アイコンサイズ'),
          subtitle: Text('${layerParams.value['iconSize']}x'),
        ),
        Slider(
          min: 0.1,
          max: 3.0,
          divisions: 29,
          value: layerParams.value['iconSize'] as double,
          label: '${layerParams.value['iconSize']}x',
          onChanged: (value) {
            layerParams.value = {
              ...layerParams.value,
              'iconSize': value,
            };
          },
        ),

        // アイコンの重なりを許可
        SwitchListTile(
          title: const Text('アイコンの重なりを許可'),
          subtitle: Text(layerParams.value['allowOverlap'] as bool ? 'ON' : 'OFF'),
          value: layerParams.value['allowOverlap'] as bool,
          onChanged: (value) {
            layerParams.value = {
              ...layerParams.value,
              'allowOverlap': value,
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
