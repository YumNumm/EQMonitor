import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 震源近傍の地震探索パラメータを調整する BottomSheet
class NearbyEarthquakeParameterSheet extends HookWidget {
  const NearbyEarthquakeParameterSheet({
    required this.initial,
    required this.hasDepth,
    super.key,
  });

  final NearbyEarthquakeParameter initial;

  /// 深さが判明しているか（false の場合は深さオフセットを非表示）
  final bool hasDepth;

  @override
  Widget build(BuildContext context) {
    final latitudeOffset = useState(initial.latitudeOffset);
    final longitudeOffset = useState(initial.longitudeOffset);
    final depthOffset = useState(initial.depthOffset);
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.designSystem.colorTheme.onSurfaceVariant
                      .withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '探索パラメータの設定',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _SliderRow(
              label: '緯度範囲',
              value: latitudeOffset.value,
              min: 0.1,
              max: 3,
              divisions: 29,
              displayText: '±${latitudeOffset.value.toStringAsFixed(1)}°',
              onChanged: (value) => latitudeOffset.value = value,
            ),
            _SliderRow(
              label: '経度範囲',
              value: longitudeOffset.value,
              min: 0.1,
              max: 3,
              divisions: 29,
              displayText: '±${longitudeOffset.value.toStringAsFixed(1)}°',
              onChanged: (value) => longitudeOffset.value = value,
            ),
            if (hasDepth)
              _SliderRow(
                label: '深さ範囲',
                value: depthOffset.value.toDouble(),
                min: 10,
                max: 200,
                divisions: 19,
                displayText: '±${depthOffset.value}km',
                onChanged: (value) => depthOffset.value = value.round(),
              ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(
                NearbyEarthquakeParameter(
                  latitudeOffset: latitudeOffset.value,
                  longitudeOffset: longitudeOffset.value,
                  depthOffset: depthOffset.value,
                ),
              ),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('適用'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.displayText,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String displayText;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
            Text(
              displayText,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.designSystem.colorTheme.primary,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
