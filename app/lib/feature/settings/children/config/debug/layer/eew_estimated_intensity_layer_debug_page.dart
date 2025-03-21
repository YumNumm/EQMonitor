import 'package:eqmonitor/core/extension/color_extension.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/layer/base_layer_debug_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewEstimatedIntensityLayerDebugPage extends BaseLayerDebugPage {
  const EewEstimatedIntensityLayerDebugPage({super.key});

  @override
  String get title => 'EEW予想震度レイヤーデバッグ';

  @override
  String get description =>
      'EEW予想震度レイヤーは、緊急地震速報の予想震度を地図上に表示します。'
      '各地域は予想される最大震度に応じた色で塗りつぶされます。';

  @override
  Map<String, dynamic> get defaultLayerParams => {
    'fillOpacity': 0.5,
    'showBorder': true,
    'borderWidth': 1.0,
    'borderColor': Colors.black.toHexStringRGB(),
  };

  @override
  Widget buildLayer(
    BuildContext context,
    WidgetRef ref,
    MapController controller,
    ValueNotifier<Map<String, dynamic>> layerParams,
  ) {
    // 実際のEewEstimatedIntensityLayerを使用
    // デバッグ用のパラメータは反映されませんが、実際のデータを表示できます
    return const EewEstimatedIntensityLayer();
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
        // 塗りつぶしの透明度
        ListTile(
          title: const Text('塗りつぶしの透明度'),
          subtitle: Text(
            '${((layerParams.value['fillOpacity'] as double) * 100).round()}%',
          ),
        ),
        Slider(
          min: 0.1,
          divisions: 9,
          value: layerParams.value['fillOpacity'] as double,
          label:
              '${((layerParams.value['fillOpacity'] as double) * 100).round()}%',
          onChanged: (value) {
            layerParams.value = {...layerParams.value, 'fillOpacity': value};
          },
        ),

        // 境界線の表示
        SwitchListTile(
          title: const Text('境界線を表示'),
          subtitle: Text(
            layerParams.value['showBorder'] as bool ? 'ON' : 'OFF',
          ),
          value: layerParams.value['showBorder'] as bool,
          onChanged: (value) {
            layerParams.value = {...layerParams.value, 'showBorder': value};
          },
        ),

        // 境界線の幅
        ListTile(
          title: const Text('境界線の幅'),
          subtitle: Text('${layerParams.value['borderWidth']}px'),
        ),
        Slider(
          min: 0.5,
          max: 3,
          divisions: 5,
          value: layerParams.value['borderWidth'] as double,
          label: '${layerParams.value['borderWidth']}px',
          onChanged: (value) {
            layerParams.value = {...layerParams.value, 'borderWidth': value};
          },
        ),

        // 境界線の色
        ListTile(
          title: const Text('境界線の色'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(layerParams.value['borderColor'] as int),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onTap: () async {
            await showDialog<void>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('境界線の色を選択'),
                    content: SingleChildScrollView(
                      child: _ColorPickerSimple(
                        colors: const [
                          Colors.black,
                          Colors.white,
                          Colors.grey,
                          Colors.red,
                          Colors.blue,
                        ],
                        selectedColor: Color(
                          layerParams.value['borderColor'] as int,
                        ),
                        onColorSelected: (color) {
                          layerParams.value = {
                            ...layerParams.value,
                            'borderColor': color..toHexStringRGB(),
                          };
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
            );
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

/// シンプルな色選択ウィジェット
class _ColorPickerSimple extends StatelessWidget {
  const _ColorPickerSimple({
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  final List<Color> colors;
  final Color selectedColor;
  final void Function(Color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          colors.map((color) {
            final isSelected = color.toHexStringRGB() == selectedColor.toHexStringRGB();
            return GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey,
                    width: isSelected ? 3 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          }).toList(),
    );
  }
}
