import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_parameter.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/material.dart';

/// 震源近傍の地震探索パラメータを調整する BottomSheet
class NearbyEarthquakeParameterSheet extends StatefulWidget {
  const NearbyEarthquakeParameterSheet({
    required this.initial,
    required this.hasDepth,
    super.key,
  });

  final NearbyEarthquakeParameter initial;

  /// 深さが判明しているか（false の場合は深さオフセットを非表示）
  final bool hasDepth;

  @override
  State<NearbyEarthquakeParameterSheet> createState() =>
      _NearbyEarthquakeParameterSheetState();
}

class _NearbyEarthquakeParameterSheetState
    extends State<NearbyEarthquakeParameterSheet> {
  late double _latitudeOffset;
  late double _longitudeOffset;
  late int _depthOffset;

  @override
  void initState() {
    super.initState();
    _latitudeOffset = widget.initial.latitudeOffset;
    _longitudeOffset = widget.initial.longitudeOffset;
    _depthOffset = widget.initial.depthOffset;
  }

  @override
  Widget build(BuildContext context) {
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
                  color: context.designSystem.colorTheme.onSurfaceVariant.withValues(
                    alpha: 0.4,
                  ),
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
              value: _latitudeOffset,
              min: 0.1,
              max: 3,
              divisions: 29,
              displayText: '±${_latitudeOffset.toStringAsFixed(1)}°',
              onChanged: (v) => setState(() => _latitudeOffset = v),
            ),
            _SliderRow(
              label: '経度範囲',
              value: _longitudeOffset,
              min: 0.1,
              max: 3,
              divisions: 29,
              displayText: '±${_longitudeOffset.toStringAsFixed(1)}°',
              onChanged: (v) => setState(() => _longitudeOffset = v),
            ),
            if (widget.hasDepth)
              _SliderRow(
                label: '深さ範囲',
                value: _depthOffset.toDouble(),
                min: 10,
                max: 200,
                divisions: 19,
                displayText: '±${_depthOffset}km',
                onChanged: (v) => setState(() => _depthOffset = v.round()),
              ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(
                NearbyEarthquakeParameter(
                  latitudeOffset: _latitudeOffset,
                  longitudeOffset: _longitudeOffset,
                  depthOffset: _depthOffset,
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
            Expanded(
              child: Text(label, style: theme.textTheme.bodyMedium),
            ),
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
