import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/permission/ui/component/notification_permission_banner.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/shake_detection_settings_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_regions_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class ShakeDetectionSettingsPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(shakeDetectionSettingsProvider);
    final regions = ref.watch(shakeDetectionRegionsProvider);
    final permission = ref.watch(backgroundLocationPermissionProvider);
    final mutation = ref.watch(ShakeDetectionSettingsNotifier.saveMutation);
    final busy = settings.isLoading || mutation is MutationPending;
    const action = ShakeDetectionSettingsAction();
    ref.listen(ShakeDetectionSettingsNotifier.saveMutation, (_, next) {
      if (next is MutationError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('設定を保存できませんでした。もう一度お試しください。')),
        );
      }
    });
    final state = settings.value;
    return Scaffold(
      appBar: AppBar(title: const Text('揺れ検知の通知')),
      body: state == null
          ? Center(
              child: settings.hasError
                  ? M3EFilledButton(
                      onPressed: () =>
                          ref.invalidate(shakeDetectionSettingsProvider),
                      child: const Text('設定の読み込みを再試行'),
                    )
                  : const AccessibleCircularProgressIndicator(),
            )
          : ListView(
              children: [
                const NotificationPermissionBanner(),
                if (busy) const AccessibleLinearProgressIndicator(),
                if (state.requiresReconfiguration)
                  const ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('通知地域を設定し直してください'),
                    subtitle: Text(
                      '以前の観測点・市区町村・都道府県の条件は停止しています。細分化地域を選んで保存してください。',
                    ),
                  ),
                const ListTile(
                  title: Text('通知する揺れのレベル'),
                  subtitle: Text('地域ごとに最小レベルを設定できます。現在地は移動先の細分化地域を使用します。'),
                ),
                if (state.entries.any(
                  (e) => e.isCurrentLocation && e.enabled,
                )) ...[
                  const ListTile(
                    leading: Icon(Icons.my_location),
                    title: Text('現在地の細分化地域で通知'),
                    subtitle: Text('現在地が未取得、または地域を判定できない間は通知されません。'),
                  ),
                  if (permission.value != LocationPermission.always)
                    ListTile(
                      title: const Text('位置情報の「常に許可」が必要です'),
                      subtitle: const Text(
                        'バックグラウンドでも現在地を更新できるよう、位置情報の権限を確認してください。',
                      ),
                      onTap: () => action.requestLocationPermission(ref),
                    ),
                ],
                for (final entry in state.entries)
                  _ShakeEntryCard(
                    entry: entry,
                    name: switch (entry.targetType) {
                      .currentLocation => '現在地',
                      .nationwide => '全国',
                      .region =>
                        regions.value
                                ?.expand((p) => p.regions)
                                .where((r) => r.code == entry.regionCode)
                                .firstOrNull
                                ?.name
                                .ja ??
                            '地域 ${entry.regionCode}',
                    },
                    busy: busy,
                    onEnabled: (value) => action.save(ref, [
                      for (final e in state.entries)
                        e.id == entry.id ? e.copyWith(enabled: value) : e,
                    ]),
                    onLevel: (value) => action.save(ref, [
                      for (final e in state.entries)
                        e.id == entry.id ? e.copyWith(minLevel: value) : e,
                    ]),
                    onDelete: () => action.save(
                      ref,
                      state.entries.where((e) => e.id != entry.id).toList(),
                    ),
                  ),
                for (final target in [
                  ShakeDetectionTargetType.currentLocation,
                  ShakeDetectionTargetType.nationwide,
                ])
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: M3EFilledButton.tonal(
                      onPressed:
                          busy ||
                              state.entries.any((e) => e.targetType == target)
                          ? null
                          : () => action.save(ref, [
                              ...state.entries,
                              ShakeDetectionEntry(
                                id: '',
                                targetType: target,
                                regionCode: null,
                                enabled: true,
                                minLevel: ShakeDetectionLevel.medium,
                              ),
                            ]),
                      child: Text(
                        target == ShakeDetectionTargetType.currentLocation
                            ? '現在地を追加'
                            : '全国を追加',
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: M3EFilledButton.tonal(
                    onPressed: busy || !regions.hasValue
                        ? null
                        : () async {
                            final selected =
                                await showModalBottomSheet<
                                  EarthquakeParameterRegionItem
                                >(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => FractionallySizedBox(
                                    heightFactor: 0.8,
                                    child: _ShakeRegionPicker(
                                      prefectures: regions.requireValue,
                                      selectedCodes: state.entries
                                          .map((e) => e.regionCode)
                                          .nonNulls
                                          .toSet(),
                                    ),
                                  ),
                                );
                            if (selected == null || !context.mounted) return;
                            await action.save(ref, [
                              ...state.entries,
                              ShakeDetectionEntry(
                                id: '',
                                targetType: ShakeDetectionTargetType.region,
                                regionCode: selected.code,
                                enabled: true,
                                minLevel: ShakeDetectionLevel.medium,
                              ),
                            ]);
                          },
                    child: const Text('都道府県から細分化地域を追加'),
                  ),
                ),
                if (regions.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('地域一覧を読み込んでいます…'),
                  ),
                if (regions.hasError)
                  ListTile(
                    title: const Text('地域一覧を読み込めませんでした'),
                    trailing: M3ETextButton(
                      onPressed: () =>
                          ref.invalidate(shakeDetectionRegionsProvider),
                      child: const Text('再試行'),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _ShakeEntryCard extends StatelessWidget {
  const new({
    required this.entry,
    required this.name,
    required this.busy,
    required this.onEnabled,
    required this.onLevel,
    required this.onDelete,
  });
  final ShakeDetectionEntry entry;
  final String name;
  final bool busy;
  final ValueChanged<bool> onEnabled;
  final ValueChanged<ShakeDetectionLevel> onLevel;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      children: [
        SwitchListTile(
          title: Text(name),
          value: entry.enabled,
          onChanged: busy ? null : onEnabled,
        ),
        ListTile(
          title: ControlledDropdown<ShakeDetectionLevel>(
            enabled: !busy,
            items: ShakeDetectionLevel.values
                .map(
                  (level) => M3EDropdownItem(
                    value: level,
                    label: switch (level) {
                      .weaker => '微弱な揺れ以上',
                      .weak => '弱い揺れ以上',
                      .medium => 'やや強い揺れ以上',
                      .strong => '強い揺れ以上',
                      .stronger => '非常に強い揺れ',
                    },
                    selected: level == entry.minLevel,
                  ),
                )
                .toList(),
            onSelectionChanged: (items) {
              final selected = items.firstOrNull;
              if (selected != null) onLevel(selected.value);
            },
          ),
          trailing: IconButton(
            tooltip: '削除',
            onPressed: busy ? null : onDelete,
            icon: const Icon(Icons.delete_outline),
          ),
        ),
      ],
    ),
  );
}

class _ShakeRegionPicker extends StatelessWidget {
  const new({required this.prefectures, required this.selectedCodes});
  final List<EarthquakeParameterPrefectureItem> prefectures;
  final Set<String> selectedCodes;
  @override
  Widget build(BuildContext context) => SafeArea(
    child: ListView(
      children: [
        const ListTile(title: Text('通知する細分化地域を選択')),
        for (final prefecture in prefectures)
          ExpansionTile(
            title: Text(prefecture.name.ja),
            children: [
              for (final region in prefecture.regions)
                ListTile(
                  title: Text(region.name.ja),
                  enabled: !selectedCodes.contains(region.code),
                  trailing: selectedCodes.contains(region.code)
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () => Navigator.of(context).pop(region),
                ),
            ],
          ),
      ],
    ),
  );
}
