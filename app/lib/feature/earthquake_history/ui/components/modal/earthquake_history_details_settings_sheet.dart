import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class EarthquakeHistoryDetailsSettingsSheet extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(earthquakeHistoryConfigProvider);
    final mutation = ref.watch(
      EarthquakeHistoryConfigNotifier.saveDetailsMutation,
    );
    final busy = mutation is MutationPending;
    final details = config.value?.details;

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
                  onReload: () =>
                      ref.refresh(earthquakeHistoryConfigProvider.future),
                ),
                _ => const Center(child: AccessibleCircularProgressIndicator()),
              }
            : ListView(
                children: [
                  SwitchListTile.adaptive(
                    title: const Text('観測点を表示'),
                    subtitle: const Text('地図上に観測点の震度・長周期地震動階級を表示します'),
                    value: details.showStations,
                    onChanged: busy
                        ? null
                        : (value) async {
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
                    title: const Text('震央アイコンを観測点の上に表示'),
                    subtitle: const Text('重なったときに震央アイコンを手前に表示します'),
                    value: details.hypocenterAboveStations,
                    onChanged: busy || !details.showStations
                        ? null
                        : (value) async {
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
