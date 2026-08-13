import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_layer_parameter_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryDebugModal extends ConsumerWidget {
  const EarthquakeHistoryDebugModal({super.key});

  static Future<void> show({required BuildContext context}) =>
      showModalBottomSheet(
        context: context,
        clipBehavior: Clip.antiAlias,
        isScrollControlled: true,
        builder: (context) => const EarthquakeHistoryDebugModal(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = ref.watch(earthquakeHistoryMapLayerParameterProvider);
    final notifier = ref.read(
      earthquakeHistoryMapLayerParameterProvider.notifier,
    );

    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return switch (param) {
          AsyncLoading() => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          AsyncError() => const Center(child: Text('レイヤー設定を読み込めませんでした')),
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final usesStackedHeader =
                        constraints.maxWidth < 480 ||
                        MediaQuery.textScalerOf(context).scale(1) > 1;
                    final title = Text(
                      'レイヤーパラメータ (Debug)',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                    final resetButton = TextButton(
                      onPressed: notifier.reset,
                      child: const Text('レイヤー設定をリセット'),
                    );
                    if (usesStackedHeader) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          title,
                          Align(
                            alignment: Alignment.centerRight,
                            child: resetButton,
                          ),
                        ],
                      );
                    }
                    return Row(
                      children: [Expanded(child: title), resetButton],
                    );
                  },
                ),
              ),

              _header(context, 'ズーム閾値'),
              _slider(
                '地域→市区町村',
                value.regionToCity,
                3,
                15,
                (v) => notifier.save(value.copyWith(regionToCity: v)),
              ),
              _slider(
                '観測点 表示開始',
                value.stationMinZoom,
                3,
                15,
                (v) => notifier.save(value.copyWith(stationMinZoom: v)),
              ),
              _slider(
                '観測点名 表示開始',
                value.stationLabelMinZoom,
                3,
                15,
                (v) => notifier.save(value.copyWith(stationLabelMinZoom: v)),
              ),
              _slider(
                '観測点 数字表示 (自動)',
                value.stationTextZoom,
                3,
                15,
                (v) => notifier.save(value.copyWith(stationTextZoom: v)),
              ),
              _slider(
                '震央 半透明化',
                value.hypocenterFadeZoom,
                3,
                15,
                (v) => notifier.save(value.copyWith(hypocenterFadeZoom: v)),
              ),
              _slider(
                '誤差矩形 表示開始',
                value.hypocenterErrorMinZoom,
                3,
                15,
                (v) => notifier.save(value.copyWith(hypocenterErrorMinZoom: v)),
              ),

              _header(context, '塗りつぶし透明度'),
              _slider(
                '地域 Fill',
                value.regionFillOpacity,
                0,
                1,
                (v) => notifier.save(value.copyWith(regionFillOpacity: v)),
              ),
              _slider(
                '地域 Line',
                value.regionLineOpacity,
                0,
                1,
                (v) => notifier.save(value.copyWith(regionLineOpacity: v)),
              ),
              _slider(
                '市区町村 Fill',
                value.cityFillOpacity,
                0,
                1,
                (v) => notifier.save(value.copyWith(cityFillOpacity: v)),
              ),

              _header(context, '観測点サイズ (circle-radius)'),
              _slider(
                '最小 (z4)',
                value.stationCircleRadiusMin,
                0,
                20,
                (v) => notifier.save(value.copyWith(stationCircleRadiusMin: v)),
              ),
              _slider(
                '最大 (z10)',
                value.stationCircleRadiusMax,
                0,
                20,
                (v) => notifier.save(value.copyWith(stationCircleRadiusMax: v)),
              ),

              _header(context, '観測点アイコンサイズ'),
              _slider(
                '最小 (z3)',
                value.stationIconSizeMin,
                0,
                0.2,
                (v) => notifier.save(value.copyWith(stationIconSizeMin: v)),
              ),
              _slider(
                '中間 (z7)',
                value.stationIconSizeMid,
                0,
                0.5,
                (v) => notifier.save(value.copyWith(stationIconSizeMid: v)),
              ),
              _slider(
                '最大 (z20)',
                value.stationIconSizeMax,
                0,
                1.5,
                (v) => notifier.save(value.copyWith(stationIconSizeMax: v)),
              ),

              _header(context, '震央マーカー'),
              _slider(
                'アイコン最小 (z3)',
                value.hypocenterIconSizeMin,
                0,
                0.5,
                (v) => notifier.save(value.copyWith(hypocenterIconSizeMin: v)),
              ),
              _slider(
                'アイコン最大 (z20)',
                value.hypocenterIconSizeMax,
                0,
                1,
                (v) => notifier.save(value.copyWith(hypocenterIconSizeMax: v)),
              ),
              _slider(
                'フェード透明度',
                value.hypocenterFadeOpacity,
                0,
                1,
                (v) => notifier.save(value.copyWith(hypocenterFadeOpacity: v)),
              ),

              SizedBox(height: MediaQuery.paddingOf(context).bottom),
            ],
          ),
        };
      },
    );
  }

  Widget _header(BuildContext context, String title) {
    final theme = Theme.of(context);
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
    final divisions = max <= 1 ? 20 : 24;
    final decimals = max <= 1 ? 2 : 1;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 120,
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
