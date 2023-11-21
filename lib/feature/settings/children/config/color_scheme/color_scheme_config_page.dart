import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ColorSchemeConfigPage extends ConsumerWidget {
  const ColorSchemeConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intensityColorProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('震度配色設定'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RadioListTile.adaptive(
              value: IntensityColorModel.eqmonitor(),
              groupValue: state,
              onChanged: (value) {
                ref
                    .read(intensityColorProvider.notifier)
                    .update(IntensityColorModel.eqmonitor());
              },
              title: const Text('EQMonitor'),
              subtitle: Padding(
                padding: const EdgeInsets.all(4),
                child: _IntensityWidgets(
                  colorModel: IntensityColorModel.eqmonitor(),
                ),
              ),
            ),
            RadioListTile.adaptive(
              value: IntensityColorModel.jma(),
              groupValue: state,
              onChanged: (value) {
                ref
                    .read(intensityColorProvider.notifier)
                    .update(IntensityColorModel.jma());
              },
              title: const Text('気象庁配色'),
              subtitle: Padding(
                padding: const EdgeInsets.all(4),
                child: _IntensityWidgets(colorModel: IntensityColorModel.jma()),
              ),
            ),
            RadioListTile.adaptive(
              value: IntensityColorModel.earthQuickly(),
              groupValue: state,
              onChanged: (value) {
                ref
                    .read(intensityColorProvider.notifier)
                    .update(IntensityColorModel.earthQuickly());
              },
              title: const Text('EarthQuickly'),
              subtitle: Padding(
                padding: const EdgeInsets.all(4),
                child: _IntensityWidgets(
                  colorModel: IntensityColorModel.earthQuickly(),
                ),
              ),
            ),
            const SizedBox(
              height: kFloatingActionButtonMargin * 4,
            ),
          ],
        ),
      ),
    );
  }
}

class _IntensityWidgets extends StatelessWidget {
  const _IntensityWidgets({
    required this.colorModel,
  });

  final IntensityColorModel colorModel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        ...JmaForecastIntensity.values.map(
          (e) => JmaForecastIntensityWidget(
            intensity: e,
            colorModel: colorModel,
            size: 40,
          ),
        ),
      ],
    );
  }
}
