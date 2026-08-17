import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_map_label_parameter_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeMapLabelDebugModal extends ConsumerWidget {
  const HomeMapLabelDebugModal._();

  static Future<void> show({required BuildContext context}) =>
      showModalBottomSheet(
        context: context,
        clipBehavior: Clip.antiAlias,
        isScrollControlled: true,
        builder: (context) => const HomeMapLabelDebugModal._(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = ref.watch(homeMapLabelParameterProvider);
    final notifier = ref.read(homeMapLabelParameterProvider.notifier);

    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return switch (param) {
          AsyncLoading() => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          AsyncError(:final error) => Center(child: Text('Error: $error')),
          AsyncData(:final value) => ListView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: context.designSystem.colorTheme.onSurface.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'マップラベル (Debug)',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: notifier.reset,
                      child: const Text('リセット'),
                    ),
                  ],
                ),
              ),

              _header(context, theme, '表示切替'),
              SwitchListTile(
                title: const Text('地域ラベル (areaForecastLocalE)'),
                value: value.showRegionLabel,
                onChanged: (v) =>
                    notifier.save(value.copyWith(showRegionLabel: v)),
              ),
              SwitchListTile(
                title: const Text('市区町村ラベル (areaInformationCityQuake)'),
                value: value.showCityLabel,
                onChanged: (v) =>
                    notifier.save(value.copyWith(showCityLabel: v)),
              ),

              _header(context, theme, 'ズーム閾値 (表示開始)'),
              _slider(
                '地域ラベル',
                value.regionLabelMinZoom,
                1,
                15,
                (v) => notifier.save(value.copyWith(regionLabelMinZoom: v)),
              ),
              _slider(
                '市区町村ラベル',
                value.cityLabelMinZoom,
                1,
                15,
                (v) => notifier.save(value.copyWith(cityLabelMinZoom: v)),
              ),

              _header(context, theme, 'テキストサイズ'),
              _slider(
                '地域',
                value.regionTextSize,
                6,
                24,
                (v) => notifier.save(value.copyWith(regionTextSize: v)),
              ),
              _slider(
                '市区町村',
                value.cityTextSize,
                6,
                24,
                (v) => notifier.save(value.copyWith(cityTextSize: v)),
              ),

              _header(context, theme, 'テキストスタイル'),
              _slider(
                'Halo幅',
                value.textHaloWidth,
                0,
                3,
                (v) => notifier.save(value.copyWith(textHaloWidth: v)),
              ),

              SizedBox(height: MediaQuery.paddingOf(context).bottom),
            ],
          ),
        };
      },
    );
  }

  Widget _header(BuildContext context, ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: context.designSystem.colorTheme.primary,
        ),
      ),
    );
  }

  Widget _slider(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    final divisions = max <= 3 ? 30 : 36;
    final decimals = max <= 3 ? 1 : 1;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(fontSize: 12)),
          ),
          Expanded(
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: divisions,
              label: value.toStringAsFixed(decimals),
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              value.toStringAsFixed(decimals),
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
