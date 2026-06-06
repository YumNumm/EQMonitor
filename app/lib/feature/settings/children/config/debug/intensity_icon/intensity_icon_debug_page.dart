import 'dart:typed_data';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/map/features/icon/data/provider/intensity_icon_provider.dart';
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
            providerName: 'intensityIconProvider',
            onInvalidate: () => ref.invalidate(intensityIconProvider, asReload: true),
            child: _JmaIntensityGrid(size: size.value),
          ),
          const SizedBox(height: 16),
          _Section(
            title: '長周期地震動アイコン (JmaLpgmIntensity)',
            providerName: 'intensityIconProvider',
            onInvalidate: () => ref.invalidate(intensityIconProvider, asReload: true),
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
  const _Section({
    required this.title,
    required this.providerName,
    required this.onInvalidate,
    required this.child,
  });

  final String title;
  final String providerName;
  final VoidCallback onInvalidate;
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
        Row(
          children: [
            Expanded(
              child: Text(
                '参照Provider: $providerName',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: onInvalidate,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('再レンダリング'),
              style: OutlinedButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
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
    final asyncData = ref.watch(intensityIconProvider);

    return asyncData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) =>
          Text('エラー: $e', style: const TextStyle(color: Colors.red)),
      data: (data) => Table(
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
                  child: _RenderedImage(
                    bytes: data.jmaIntensity.filled[intensity],
                    size: size,
                  ),
                ),
                _IconCell(
                  child: _RenderedImage(
                    bytes: data.jmaIntensity.small[intensity],
                    size: size,
                  ),
                ),
                _IconCell(
                  child: _RenderedImage(
                    bytes: data.jmaIntensity.smallWithoutText[intensity],
                    size: size,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _JmaLpgmIntensityGrid extends ConsumerWidget {
  const _JmaLpgmIntensityGrid({required this.size});

  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(intensityIconProvider);

    return asyncData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) =>
          Text('エラー: $e', style: const TextStyle(color: Colors.red)),
      data: (data) => Table(
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
                  child: _RenderedImage(
                    bytes: data.lpgmIntensity.filled[intensity],
                    size: size,
                  ),
                ),
                _IconCell(
                  child: _RenderedImage(
                    bytes: data.lpgmIntensity.small[intensity],
                    size: size,
                  ),
                ),
                _IconCell(
                  child: _RenderedImage(
                    bytes: data.lpgmIntensity.smallWithoutText[intensity],
                    size: size,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _RenderedImage extends StatelessWidget {
  const _RenderedImage({required this.bytes, required this.size});

  final Uint8List? bytes;
  final double size;

  @override
  Widget build(BuildContext context) {
    final b = bytes;
    if (b == null) {
      return SizedBox(
        width: size,
        height: size,
        child: const Icon(Icons.error_outline, size: 16),
      );
    }
    return Image.memory(b, width: size, height: size, fit: BoxFit.contain);
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
