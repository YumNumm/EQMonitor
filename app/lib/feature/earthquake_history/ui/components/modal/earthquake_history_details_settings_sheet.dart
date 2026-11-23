import 'dart:async';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/slider/accessible_slider.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_dem_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_layer_parameter_notifier.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class const EarthquakeHistoryDetailsSettingsSheet({
  required final bool showingDb,
  super.key,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(earthquakeHistoryConfigProvider);
    final mutation = ref.watch(
      EarthquakeHistoryConfigNotifier.saveDetailsMutation,
    );
    final busy = mutation is MutationPending;
    final details = config.value?.details;
    final parameter = ref
        .watch(earthquakeHistoryMapLayerParameterProvider)
        .value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('地震履歴詳細の設定'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: '閉じる',
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: details == null
            ? switch (config) {
                AsyncError(:final error) => ErrorCard(
                  error: error,
                  onReload: () => HapticUtil.light(
                    () => ref.refresh(earthquakeHistoryConfigProvider.future),
                  ),
                ),
                _ => const Center(child: AccessibleCircularProgressIndicator()),
              }
            : ListView(
                children: [
                  SwitchListTile.adaptive(
                    title: const Text('観測点を表示'),
                    subtitle: const Text('各地の震度・長周期地震動の地図に観測点を表示します'),
                    value: showingDb || details.showStations,
                    onChanged: busy || showingDb
                        ? null
                        : (value) async {
                            unawaited(HapticFeedback.selectionClick());
                            await EarthquakeHistoryConfigNotifier
                                .saveDetailsMutation
                                .run(
                                  ref,
                                  (tsx) => tsx
                                      .get(
                                        earthquakeHistoryConfigProvider
                                            .notifier,
                                      )
                                      .saveDetails(
                                        details.copyWith(showStations: value),
                                      ),
                                );
                          },
                  ),
                  SwitchListTile.adaptive(
                    title: const Text('地域の震度アイコンを表示'),
                    subtitle: const Text(
                      '塗りつぶした地域の中に震度を表示します。観測点を表示する縮尺では表示しません',
                    ),
                    value: details.showAreaIcons,
                    onChanged: busy || showingDb
                        ? null
                        : (value) async {
                            unawaited(HapticFeedback.selectionClick());
                            await EarthquakeHistoryConfigNotifier
                                .saveDetailsMutation
                                .run(
                                  ref,
                                  (tsx) => tsx
                                      .get(
                                        earthquakeHistoryConfigProvider
                                            .notifier,
                                      )
                                      .saveDetails(
                                        details.copyWith(showAreaIcons: value),
                                      ),
                                );
                          },
                  ),
                  _ZoomThresholdTile(
                    title: '市区町村に切り替える縮尺',
                    subtitle: 'これより拡大すると、細分区域ごとの表示から市区町村ごとの表示に切り替わります',
                    value: parameter?.regionToCity,
                    onSaved: showingDb || parameter == null
                        ? null
                        : (value) => ref
                              .read(
                                earthquakeHistoryMapLayerParameterProvider
                                    .notifier,
                              )
                              .save(parameter.copyWith(regionToCity: value)),
                  ),
                  _ZoomThresholdTile(
                    title: '観測点に切り替える縮尺',
                    subtitle: 'これより拡大すると、地域の震度アイコンの代わりに観測点を表示します',
                    value: parameter?.stationMinZoom,
                    onSaved:
                        showingDb || !details.showStations || parameter == null
                        ? null
                        : (value) => ref
                              .read(
                                earthquakeHistoryMapLayerParameterProvider
                                    .notifier,
                              )
                              .save(parameter.copyWith(stationMinZoom: value)),
                  ),
                  SwitchListTile.adaptive(
                    title: const Text('推計震度に観測点を重ねて表示'),
                    subtitle: const Text('推計震度の色分けの上に、観測点の震度を表示します'),
                    value: details.showStationsOnEstimatedIntensity,
                    onChanged: busy
                        ? null
                        : (value) async {
                            unawaited(HapticFeedback.selectionClick());
                            await EarthquakeHistoryConfigNotifier
                                .saveDetailsMutation
                                .run(
                                  ref,
                                  (tsx) => tsx
                                      .get(
                                        earthquakeHistoryConfigProvider
                                            .notifier,
                                      )
                                      .saveDetails(
                                        details.copyWith(
                                          showStationsOnEstimatedIntensity:
                                              value,
                                        ),
                                      ),
                                );
                          },
                  ),
                  SwitchListTile.adaptive(
                    title: const Text('推計震度を 0.1 単位で表示'),
                    subtitle: const Text('震度階級ごとの色分けの代わりに、計測震度を細かく色分けします'),
                    value:
                        details.estimatedIntensityDemDisplayMode ==
                        EstimatedIntensityDemDisplayMode.tenth,
                    onChanged: busy
                        ? null
                        : (value) async {
                            unawaited(HapticFeedback.selectionClick());
                            await EarthquakeHistoryConfigNotifier
                                .saveDetailsMutation
                                .run(
                                  ref,
                                  (tsx) => tsx
                                      .get(
                                        earthquakeHistoryConfigProvider
                                            .notifier,
                                      )
                                      .saveDetails(
                                        details.copyWith(
                                          estimatedIntensityDemDisplayMode:
                                              value
                                              ? EstimatedIntensityDemDisplayMode
                                                    .tenth
                                              : EstimatedIntensityDemDisplayMode
                                                    .intensityClass,
                                        ),
                                      ),
                                );
                          },
                  ),
                  SwitchListTile.adaptive(
                    title: const Text('震央アイコンを観測点の上に表示'),
                    subtitle: const Text('重なったときに震央アイコンを手前に表示します'),
                    value: details.hypocenterAboveStations,
                    onChanged:
                        busy ||
                            (!showingDb &&
                                !details.showStations &&
                                !details.showStationsOnEstimatedIntensity)
                        ? null
                        : (value) async {
                            unawaited(HapticFeedback.selectionClick());
                            await EarthquakeHistoryConfigNotifier
                                .saveDetailsMutation
                                .run(
                                  ref,
                                  (tsx) => tsx
                                      .get(
                                        earthquakeHistoryConfigProvider
                                            .notifier,
                                      )
                                      .saveDetails(
                                        details.copyWith(
                                          hypocenterAboveStations: value,
                                        ),
                                      ),
                                );
                          },
                  ),
                  if (mutation is MutationError)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('設定を保存できませんでした。もう一度お試しください。'),
                    ),
                ],
              ),
      ),
    );
  }
}

class const _ZoomThresholdTile({
  required final String title,
  required final String subtitle,
  required final double? value,
  required final Future<void> Function(double)? onSaved,
}) extends HookWidget {
  static const _min = 3.0;
  static const _max = 12.0;
  static const _divisions = 18;

  @override
  Widget build(BuildContext context) {
    final dragging = useState<double?>(null);
    final shown = (dragging.value ?? value ?? _min).clamp(_min, _max);
    final label = 'ズーム ${shown.toStringAsFixed(1)}';
    final onSaved = this.onSaved;

    return ListTile(
      enabled: onSaved != null,
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: .start,
        children: [
          Text(subtitle),
          AccessibleSlider(
            value: shown,
            min: _min,
            max: _max,
            divisions: _divisions,
            label: label,
            semanticFormatterCallback: (v) => 'ズーム ${v.toStringAsFixed(1)}',
            onChanged: onSaved == null ? null : (v) => dragging.value = v,
            onChangeEnd: onSaved == null
                ? null
                : (v) async {
                    await onSaved(v);
                    dragging.value = null;
                  },
          ),
        ],
      ),
      trailing: Text(label),
    );
  }
}
