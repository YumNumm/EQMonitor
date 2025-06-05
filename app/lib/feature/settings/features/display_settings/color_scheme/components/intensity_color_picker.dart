import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class IntensityColorPicker extends StatefulWidget {
  const IntensityColorPicker({
    required this.initialColors,
    required this.onChanged,
    super.key,
  });

  final IntensityColorModel initialColors;
  final ValueChanged<IntensityColorModel> onChanged;

  @override
  State<IntensityColorPicker> createState() => _IntensityColorPickerState();
}

class _IntensityColorPickerState extends State<IntensityColorPicker> {
  late IntensityColorModel _currentColors;

  @override
  void initState() {
    super.initState();
    _currentColors = widget.initialColors;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'カスタム配色',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '各震度の色をタップして変更できます',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...JmaForecastIntensity.values.map(
                      (intensity) => _IntensityColorTile(
                        intensity: intensity,
                        colorModel: _currentColors,
                        onColorChanged: (color) =>
                            _updateIntensityColor(intensity, color),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _updateIntensityColor(JmaForecastIntensity intensity, Color color) {
    final textColor = TextColorModel.fromBackground(color);

    final updatedColors = switch (intensity) {
      JmaForecastIntensity.zero => _currentColors.copyWith(zero: textColor),
      JmaForecastIntensity.one => _currentColors.copyWith(one: textColor),
      JmaForecastIntensity.two => _currentColors.copyWith(two: textColor),
      JmaForecastIntensity.three => _currentColors.copyWith(three: textColor),
      JmaForecastIntensity.four => _currentColors.copyWith(four: textColor),
      JmaForecastIntensity.fiveLower => _currentColors.copyWith(
        fiveLower: textColor,
      ),
      JmaForecastIntensity.fiveUpper => _currentColors.copyWith(
        fiveUpper: textColor,
      ),
      JmaForecastIntensity.sixLower => _currentColors.copyWith(
        sixLower: textColor,
      ),
      JmaForecastIntensity.sixUpper => _currentColors.copyWith(
        sixUpper: textColor,
      ),
      JmaForecastIntensity.seven => _currentColors.copyWith(seven: textColor),
      JmaForecastIntensity.unknown => _currentColors.copyWith(
        unknown: textColor,
      ),
    };

    setState(() {
      _currentColors = updatedColors;
    });
    widget.onChanged(updatedColors);
  }
}

class _IntensityColorTile extends StatelessWidget {
  const _IntensityColorTile({
    required this.intensity,
    required this.colorModel,
    required this.onColorChanged,
  });

  final JmaForecastIntensity intensity;
  final IntensityColorModel colorModel;
  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showColorPicker(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            JmaForecastIntensityWidget(
              intensity: intensity,
              colorModel: colorModel,
              size: 48,
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                _getIntensityLabel(intensity),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getIntensityLabel(JmaForecastIntensity intensity) =>
      switch (intensity) {
        JmaForecastIntensity.zero => '震度0',
        JmaForecastIntensity.one => '震度1',
        JmaForecastIntensity.two => '震度2',
        JmaForecastIntensity.three => '震度3',
        JmaForecastIntensity.four => '震度4',
        JmaForecastIntensity.fiveLower => '震度5弱',
        JmaForecastIntensity.fiveUpper => '震度5強',
        JmaForecastIntensity.sixLower => '震度6弱',
        JmaForecastIntensity.sixUpper => '震度6強',
        JmaForecastIntensity.seven => '震度7',
        JmaForecastIntensity.unknown => '不明',
      };

  Future<void> _showColorPicker(BuildContext context) async {
    final currentColor = colorModel
        .fromJmaForecastIntensity(intensity)
        .background;

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${_getIntensityLabel(intensity)}の色を選択'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: onColorChanged,
            pickerAreaHeightPercent: 0.7,
            enableAlpha: false,
            displayThumbColor: true,
            portraitOnly: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('完了'),
          ),
        ],
      ),
    );
  }
}
