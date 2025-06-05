import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/model/intensity_color_configuration.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/model/intensity_color_scheme_type.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/notifier/intensity_color_notifier.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/color_scheme/components/intensity_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ColorSchemeConfigPage extends ConsumerWidget {
  const ColorSchemeConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configuration = ref.watch(intensityColorNotifierProvider);
    final colorModel = ref.watch(intensityColorNotifierProvider).colorModel;

    return Scaffold(
      appBar: AppBar(title: const Text('震度配色設定')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RadioListTile.adaptive(
              value: PredefinedScheme.eqmonitor,
              groupValue: configuration.schemeType,
              onChanged: (value) => ref
                  .read(intensityColorNotifierProvider.notifier)
                  .updatePredefinedScheme(PredefinedScheme.eqmonitor),
              title: const Text('EQMonitor'),
              subtitle: Padding(
                padding: const EdgeInsets.all(4),
                child: _IntensityWidgets(
                  colorModel: IntensityColorModel.eqmonitor(),
                ),
              ),
            ),
            RadioListTile.adaptive(
              value: PredefinedScheme.jma,
              groupValue: configuration.schemeType,
              onChanged: (value) => ref
                  .read(intensityColorNotifierProvider.notifier)
                  .updatePredefinedScheme(PredefinedScheme.jma),
              title: const Text('気象庁配色'),
              subtitle: Padding(
                padding: const EdgeInsets.all(4),
                child: _IntensityWidgets(colorModel: IntensityColorModel.jma()),
              ),
            ),
            RadioListTile.adaptive(
              value: PredefinedScheme.earthQuickly,
              groupValue: configuration.schemeType,
              onChanged: (value) => ref
                  .read(intensityColorNotifierProvider.notifier)
                  .updatePredefinedScheme(PredefinedScheme.earthQuickly),
              title: const Text('EarthQuickly'),
              subtitle: Padding(
                padding: const EdgeInsets.all(4),
                child: _IntensityWidgets(
                  colorModel: IntensityColorModel.earthQuickly(),
                ),
              ),
            ),
            RadioListTile.adaptive(
              value: PredefinedScheme.nhk,
              groupValue: configuration.schemeType,
              onChanged: (value) => ref
                  .read(intensityColorNotifierProvider.notifier)
                  .updatePredefinedScheme(PredefinedScheme.nhk),
              title: const Text('NHK配色'),
              subtitle: Padding(
                padding: const EdgeInsets.all(4),
                child: _IntensityWidgets(
                  colorModel: IntensityColorModel.nhk(),
                ),
              ),
            ),
            RadioListTile.adaptive(
              value: null,
              groupValue: configuration.schemeType,
              onChanged: (value) async {
                final customColors =
                    configuration.customColors ??
                    IntensityColorModel.eqmonitor();
                await ref
                    .read(intensityColorNotifierProvider.notifier)
                    .updateCustomColors(customColors);
              },
              title: const Text('カスタム配色'),
              subtitle: Padding(
                padding: const EdgeInsets.all(4),
                child: _IntensityWidgets(colorModel: colorModel),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: IntensityColorPicker(
                initialColors: colorModel,
                onChanged: (colors) => ref
                    .read(intensityColorNotifierProvider.notifier)
                    .updateCustomColors(colors),
              ),
            ),
            const SizedBox(height: kFloatingActionButtonMargin * 4),
          ],
        ),
      ),
    );
  }
}

class _IntensityWidgets extends StatelessWidget {
  const _IntensityWidgets({required this.colorModel});

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
