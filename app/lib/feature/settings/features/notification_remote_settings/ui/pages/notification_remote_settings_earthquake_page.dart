import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/extension/jma_forecast_intensity.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/model/notification_remote_settings_state.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/ui/components/earthquake_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationRemoteSettingsEarthquakePage extends ConsumerWidget {
  const NotificationRemoteSettingsEarthquakePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref
        .watch(notificationRemoteSettingsNotifierProvider)
        .valueOrNull
        ?.earthquake;
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('地震情報の通知条件設定'),
      ),
      body: _Body(
        state: state,
      ),
      floatingActionButton: (state.global != JmaForecastIntensity.zero)
          ? _AddRegionFloatingActionButton(
              regions: state.regions,
            )
          : null,
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({
    required this.state,
  });

  final NotificationRemoteSettingsEarthquake state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusWidget = switch ((state.global, state.regions)) {
      (null, []) => BorderedContainer(
          accentColor: colorScheme.errorContainer,
          child: Row(
            children: [
              Icon(
                Icons.error,
                color: colorScheme.onErrorContainer,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '地震情報の通知は行いません',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      (_, _) => BorderedContainer(
          accentColor: colorScheme.secondaryContainer,
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: colorScheme.onSecondaryContainer,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: EarthquakeNotificationStatusText(
                  earthquake: state,
                ),
              ),
            ],
          ),
        ),
    };

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          statusWidget,
          const Divider(),
          _GlobalChoiceTile(global: state.global),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: (state.global != JmaForecastIntensity.zero)
                ? KeyedSubtree(
                    key: ValueKey(state.global == JmaForecastIntensity.zero),
                    child: _RegionsChoiceView(
                      regions: state.regions
                          .sorted((a, b) => a.regionId.compareTo(b.regionId))
                          .toList(),
                      global: state.global,
                    ),
                  )
                : const SizedBox.shrink(
                    key: ValueKey(true),
                  ),
          ),
          // FABと重ならないようにするため
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}

class _GlobalChoiceTile extends ConsumerWidget {
  const _GlobalChoiceTile({
    required this.global,
  });

  final JmaForecastIntensity? global;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text(
        '全国の地震情報',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text('いずれかの地域で指定した震度を観測した場合に通知します'),
      trailing: DropdownButton<JmaForecastIntensity>(
        borderRadius: BorderRadius.circular(16),
        elevation: 1,
        value: global,
        onChanged: (value) => ref
            .read(notificationRemoteSettingsNotifierProvider.notifier)
            .updateEarthquakeGlobal(value),
        items: JmaForecastIntensity.values
                .whereNot(
                  (e) => [
                    JmaForecastIntensity.unknown,
                  ].contains(e),
                )
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e == JmaForecastIntensity.zero
                          ? 'すべての地震情報'
                          : '震度${e.type.fromPlusMinus}'
                              "${e == JmaForecastIntensity.seven ? "" : " 以上"}",
                    ),
                  ),
                )
                .toList() +
            [
              const DropdownMenuItem(
                child: Text('通知しない'),
              ),
            ],
      ),
    );
  }
}

class _RegionsChoiceView extends ConsumerWidget {
  const _RegionsChoiceView({
    required this.regions,
    required this.global,
  });
  final List<NotificationRemoteSettingsEarthquakeRegion> regions;
  final JmaForecastIntensity? global;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const ListTile(
          visualDensity: VisualDensity.compact,
          title: Text(
            '地域ごとの地震情報',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('各地域で指定した震度を観測した場合に通知します'),
        ),
        for (final region in regions)
          () {
            void update(JmaForecastIntensity intensity) => ref
                .read(notificationRemoteSettingsNotifierProvider.notifier)
                .updateEarthquakeRegions(
                  regions
                      .map(
                        (e) => e.regionId == region.regionId
                            ? e.copyWith(minJmaIntensity: intensity)
                            : e,
                      )
                      .toList(),
                );
            void delete() => ref
                .read(notificationRemoteSettingsNotifierProvider.notifier)
                .updateEarthquakeRegions(
                  regions.where((e) => e.regionId != region.regionId).toList(),
                );
            final isNotificationEnabled =
                (global == null) || region.minJmaIntensity < (global!);
            final child = Dismissible(
              key: ValueKey(region.regionId),
              onDismissed: (direction) {
                HapticFeedback.mediumImpact();
                ref
                    .read(notificationRemoteSettingsNotifierProvider.notifier)
                    .updateEarthquakeRegions(
                      regions
                          .where((e) => e.regionId != region.regionId)
                          .toList(),
                    );
              },
              background: ColoredBox(
                color: Theme.of(context).colorScheme.errorContainer,
                child: const Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(Icons.delete),
                    SizedBox(width: 16),
                    Text('削除'),
                    SizedBox(width: 16),
                  ],
                ),
              ),
              child: ListTile(
                visualDensity: VisualDensity.compact,
                title: Text(region.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: delete,
                    ),
                    DropdownButton<JmaForecastIntensity>(
                      value: region.minJmaIntensity,
                      onChanged: (value) =>
                          value != null ? update(value) : null,
                      items: JmaForecastIntensity.values
                          .whereNot(
                            (e) => [
                              JmaForecastIntensity.zero,
                              JmaForecastIntensity.unknown,
                            ].contains(e),
                          )
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                '震度${e.type.fromPlusMinus}'
                                "${e == JmaForecastIntensity.seven ? "" : " 以上"}",
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                subtitle: isNotificationEnabled
                    ? null
                    : const Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              ' (この震度は全国の地震情報に含まれています)',
                            ),
                          ),
                        ],
                      ),
                onTap: () async {
                  await showDialog<JmaForecastIntensity>(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text(region.name),
                        children: JmaForecastIntensity.values
                                .whereNot(
                                  (e) => [
                                    JmaForecastIntensity.zero,
                                    JmaForecastIntensity.unknown,
                                  ].contains(e),
                                )
                                .map(
                                  (e) => SimpleDialogOption(
                                    onPressed: () {
                                      update(e);
                                      Navigator.pop(context, e);
                                    },
                                    child: Text(
                                      '震度${e.type.fromPlusMinus}'
                                      "${e == JmaForecastIntensity.seven ? "" : " 以上"}",
                                      style: const TextStyle(),
                                    ),
                                  ),
                                )
                                .toList() +
                            [
                              SimpleDialogOption(
                                onPressed: () {
                                  delete();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  '削除する',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                      );
                    },
                  );
                },
              ),
            );
            return child;
          }(),
      ],
    );
  }
}

class _AddRegionFloatingActionButton extends StatelessWidget {
  const _AddRegionFloatingActionButton({
    required this.regions,
  });

  final List<NotificationRemoteSettingsEarthquakeRegion> regions;

  @override
  Widget build(BuildContext context) {
    final canAddRegion = regions.length <= 10;
    return FloatingActionButton.extended(
      heroTag: 'add_region',
      label: const Text('地域を追加'),
      icon: const Icon(Icons.add),
      onPressed: canAddRegion
          ? () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return _AddRegionChoiceDialog(
                    alreadySelectedRegions: regions,
                  );
                },
              );
            }
          : () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return DefaultTextStyle(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    child: AlertDialog(
                      backgroundColor:
                          Theme.of(context).colorScheme.errorContainer,
                      title: const Text('地域を追加'),
                      content: const Text('地域は10個以上選択できません'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
    );
  }
}

class _AddRegionChoiceDialog extends ConsumerWidget {
  const _AddRegionChoiceDialog({
    required this.alreadySelectedRegions,
  });

  final List<NotificationRemoteSettingsEarthquakeRegion> alreadySelectedRegions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableRegions = ref
        .watch(jmaCodeTableProvider)
        .areaInformationPrefectureEarthquake
        .items;
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('キャンセル'),
        ),
      ],
      title: const Text('地域を追加'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: tableRegions.map(
            (region) {
              final isSelected = alreadySelectedRegions
                  .any((e) => e.regionId == int.parse(region.code));
              return SimpleDialogOption(
                onPressed: isSelected
                    ? null
                    : () async {
                        final intensity =
                            await showDialog<JmaForecastIntensity>(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: Text(region.name),
                              children: JmaForecastIntensity.values
                                  .whereNot(
                                    (e) => [
                                      JmaForecastIntensity.zero,
                                      JmaForecastIntensity.unknown,
                                    ].contains(e),
                                  )
                                  .map(
                                    (e) => SimpleDialogOption(
                                      onPressed: () =>
                                          Navigator.pop(context, e),
                                      child: Text(
                                        '震度${e.type.fromPlusMinus}'
                                        "${e == JmaForecastIntensity.seven ? "" : " 以上"}",
                                        style: const TextStyle(),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        );
                        if (intensity == null) {
                          return;
                        }
                        ref
                            .read(
                          notificationRemoteSettingsNotifierProvider.notifier,
                        )
                            .updateEarthquakeRegions([
                          ...alreadySelectedRegions,
                          NotificationRemoteSettingsEarthquakeRegion(
                            regionId: int.parse(region.code),
                            minJmaIntensity: intensity,
                            name: region.name,
                          ),
                        ]);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                child: isSelected
                    ? Text(
                        '${region.name} (選択済み)',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                        ),
                      )
                    : Text(region.name),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
