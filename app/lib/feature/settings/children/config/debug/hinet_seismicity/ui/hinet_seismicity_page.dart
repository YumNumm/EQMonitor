import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_bounds_filter.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_selection_overlay.dart';
import 'package:eqmonitor/feature/seismicity/ui/layer/seismicity_epicenter_layer.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_analysis_panel.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/repository/hinet_seismicity_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:nied_api_client/nied_api_client.dart';

/// Hi-net 気象庁一元化処理 震源リストのデバッグビューア。
///
/// **一般ユーザーからは到達不可能なデバッグメニュー配下限定**。
/// NIED は震源情報の二次配布を禁止しているため、本画面の内容を
/// 一般公開画面へ転用しないこと。
class HinetSeismicityPage extends HookConsumerWidget {
  const HinetSeismicityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credentialsAsync = ref.watch(hinetCredentialsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Hi-net 一元化震源ビューア')),
      body: switch (credentialsAsync) {
        AsyncData(value: final credentials?) => _FetchBody(
          credentials: credentials,
        ),
        AsyncError(:final error) => Center(child: ErrorCard(error: error)),
        AsyncData() => const _CredentialsForm(),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      },
    );
  }
}

class _CredentialsForm extends HookConsumerWidget {
  const _CredentialsForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIdController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isSaving = useState(false);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('NIED(BOSAI)アカウントのID/パスワードを入力してください。'),
          const SizedBox(height: 8),
          TextField(
            controller: userIdController,
            decoration: const InputDecoration(labelText: 'ユーザーID'),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'パスワード'),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: isSaving.value
                ? null
                : () async {
                    isSaving.value = true;
                    try {
                      await HinetCredentialsNotifier.saveMutation.run(
                        ref,
                        (tsx) async => tsx
                            .get(hinetCredentialsNotifierProvider.notifier)
                            .save(
                              userId: userIdController.text,
                              password: passwordController.text,
                            ),
                      );
                    } finally {
                      isSaving.value = false;
                    }
                  },
            child: isSaving.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('保存'),
          ),
        ],
      ),
    );
  }
}

class _FetchBody extends HookConsumerWidget {
  const _FetchBody({required this.credentials});

  final HinetCredentials credentials;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final from = useState(DateTime.now().subtract(const Duration(days: 7)));
    final to = useState(DateTime.now());
    final minMagnitude = useState(0.0);
    final colorMode = useState(SeismicityColorMode.magnitude);
    final isSelecting = useState(false);
    final selectedBounds = useState<SeismicityBounds?>(null);

    final isFetching = useState(false);
    final progress = useState<HinetJmalistFetchProgress?>(null);
    final fetchError = useState<Object?>(null);
    final fetchedEvents = useState<List<SeismicityEvent>>(const []);
    final skippedLineCount = useState(0);

    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final filteredEvents = fetchedEvents.value
        .where(
          (e) => (e.magnitude ?? double.negativeInfinity) >= minMagnitude.value,
        )
        .toList();

    Future<void> handleFetch() async {
      isFetching.value = true;
      fetchError.value = null;
      progress.value = null;
      try {
        final repository = ref.read(hinetSeismicityRepositoryProvider);
        final result = await repository.fetch(
          credentials: credentials,
          from: from.value,
          to: to.value,
          onProgress: (p) => progress.value = p,
        );
        fetchedEvents.value = result.events;
        skippedLineCount.value = result.skippedLineCount;
      } on HinetSeismicityPartialFetchException catch (e) {
        // 途中失敗でも、それまでに取得できたイベントは破棄せず表示する。
        fetchedEvents.value = e.partialResult.events;
        skippedLineCount.value = e.partialResult.skippedLineCount;
        fetchError.value = e;
      } on Object catch (e) {
        fetchError.value = e;
      } finally {
        isFetching.value = false;
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _DatePickerButton(
                label: '開始',
                value: from.value,
                onChanged: (v) => from.value = v,
              ),
              _DatePickerButton(
                label: '終了',
                value: to.value,
                onChanged: (v) => to.value = v,
              ),
              SizedBox(
                width: 220,
                child: Row(
                  children: [
                    const Text('M ≥'),
                    Expanded(
                      child: Slider(
                        value: minMagnitude.value,
                        min: -2,
                        max: 7,
                        divisions: 90,
                        label: minMagnitude.value.toStringAsFixed(1),
                        onChanged: (v) => minMagnitude.value = v,
                      ),
                    ),
                    Text(minMagnitude.value.toStringAsFixed(1)),
                  ],
                ),
              ),
              FilledButton.icon(
                onPressed: isFetching.value ? null : handleFetch,
                icon: isFetching.value
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download),
                label: Text(isFetching.value ? '取得中...' : '取得'),
              ),
              IconButton(
                icon: Icon(
                  isSelecting.value
                      ? Icons.crop_free
                      : Icons.crop_free_outlined,
                ),
                tooltip: '矩形選択',
                onPressed: () {
                  isSelecting.value = !isSelecting.value;
                  if (!isSelecting.value) {
                    selectedBounds.value = null;
                  }
                },
              ),
            ],
          ),
        ),
        if (progress.value case final p?)
          LinearProgressIndicator(value: p.completedRequests / p.totalRequests),
        if (fetchError.value case final error?)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    error is HinetSeismicityPartialFetchException
                        ? '一部のみ取得: ${fetchedEvents.value.length}件取得後に'
                              '中断しました ($error)'
                        : '取得エラー: $error',
                    style: TextStyle(
                      color: error is HinetSeismicityPartialFetchException
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
                if (error is HinetLoginException)
                  TextButton(
                    onPressed: () async {
                      await HinetCredentialsNotifier.clearMutation.run(
                        ref,
                        (tsx) async => tsx
                            .get(hinetCredentialsNotifierProvider.notifier)
                            .clear(),
                      );
                    },
                    child: const Text('認証情報を再設定'),
                  ),
              ],
            ),
          ),
        if (skippedLineCount.value > 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('スキップした行: ${skippedLineCount.value}件'),
          ),
        Expanded(
          child: switch (mapConfiguration) {
            AsyncData(:final value) when value.styleString != null => Stack(
              children: [
                MapLibreMap(
                  options: MapOptions(
                    initStyle: value.styleString!,
                    initCenter: const Geographic(lon: 137.0, lat: 36.5),
                    initZoom: 4.5,
                  ),
                  children: [
                    SeismicityEpicenterLayer(
                      events: filteredEvents,
                      colorMode: colorMode.value,
                    ),
                  ],
                ),
                SeismicitySelectionOverlay(
                  enabled: isSelecting.value,
                  onSelectionEnd: (bounds) => selectedBounds.value = bounds,
                ),
              ],
            ),
            AsyncError(:final error) => Center(child: ErrorCard(error: error)),
            _ => const Center(child: CircularProgressIndicator.adaptive()),
          },
        ),
        if (selectedBounds.value case final bounds?)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SeismicityAnalysisPanel(
              events: const SeismicityBoundsFilter().filter(
                events: filteredEvents,
                minLatitude: bounds.minLatitude,
                maxLatitude: bounds.maxLatitude,
                minLongitude: bounds.minLongitude,
                maxLongitude: bounds.maxLongitude,
              ),
            ),
          ),
      ],
    );
  }
}

class _DatePickerButton extends StatelessWidget {
  const _DatePickerButton({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: DateTime(2002, 6, 3),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
      child: Text(
        '$label: ${value.year}/${value.month.toString().padLeft(2, '0')}/'
        '${value.day.toString().padLeft(2, '0')}',
      ),
    );
  }
}
