import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IntensityIconDebugPage extends HookConsumerWidget {
  const IntensityIconDebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = useState<double>(50);

    return Scaffold(
      appBar: AppBar(title: const Text('震度アイコン確認')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SizeSlider(size: size),
          const SizedBox(height: 16),
          _Section(
            title: '震度アイコン (JmaIntensity)',
            child: _JmaIntensityGrid(size: size.value),
          ),
          const SizedBox(height: 16),
          _Section(
            title: '長周期地震動アイコン (JmaLpgmIntensity)',
            child: _JmaLpgmIntensityGrid(size: size.value),
          ),
        ],
      ),
    );
  }
}

class _SizeSlider extends StatelessWidget {
  const _SizeSlider({required this.size});

  final ValueNotifier<double> size;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Text('サイズ:'),
            Expanded(
              child: Slider(
                value: size.value,
                min: 20,
                max: 120,
                divisions: 20,
                label: '${size.value.round()}',
                onChanged: (v) => size.value = v,
              ),
            ),
            Text(
              '${size.value.round()}px',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        child,
      ],
    );
  }
}

class _JmaIntensityGrid extends ConsumerWidget {
  const _JmaIntensityGrid({required this.size});

  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          children: const [
            _HeaderCell('震度'),
            _HeaderCell('filled'),
            _HeaderCell('small'),
            _HeaderCell('smallWithoutText'),
          ],
        ),
        for (final intensity in JmaIntensity.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  intensity.label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              _IconCell(
                child: JmaIntensityIcon(
                  intensity: intensity,
                  type: IntensityIconType.filled,
                  size: size,
                ),
              ),
              _IconCell(
                child: JmaIntensityIcon(
                  intensity: intensity,
                  type: IntensityIconType.small,
                  size: size,
                ),
              ),
              _IconCell(
                child: JmaIntensityIcon(
                  intensity: intensity,
                  type: IntensityIconType.smallWithoutText,
                  size: size,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _JmaLpgmIntensityGrid extends ConsumerWidget {
  const _JmaLpgmIntensityGrid({required this.size});

  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          children: const [
            _HeaderCell('階級'),
            _HeaderCell('filled'),
            _HeaderCell('small'),
            _HeaderCell('smallWithoutText'),
          ],
        ),
        for (final intensity in JmaLpgmIntensity.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  intensity.label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              _IconCell(
                child: JmaLpgmIntensityIcon(
                  intensity: intensity,
                  type: IntensityIconType.filled,
                  size: size,
                ),
              ),
              _IconCell(
                child: JmaLpgmIntensityIcon(
                  intensity: intensity,
                  type: IntensityIconType.small,
                  size: size,
                ),
              ),
              _IconCell(
                child: JmaLpgmIntensityIcon(
                  intensity: intensity,
                  type: IntensityIconType.smallWithoutText,
                  size: size,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

class _IconCell extends StatelessWidget {
  const _IconCell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Center(child: child),
    );
  }
}
