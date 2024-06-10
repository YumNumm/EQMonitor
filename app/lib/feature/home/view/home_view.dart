import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/model/components/eew_intensity.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/component/sheet/sheet_floating_action_buttons.dart';
import 'package:eqmonitor/core/hook/use_sheet_controller.dart';
import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:eqmonitor/core/provider/config/permission/permission_status_provider.dart';
import 'package:eqmonitor/core/provider/eew/eew_alive_telegram.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging_interaction.dart';
import 'package:eqmonitor/core/provider/kmoni/viewmodel/kmoni_settings.dart';
import 'package:eqmonitor/core/provider/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/core/provider/kmoni/widget/kmoni_maintenance_widget.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/notification_token.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/home/component/eew/eew_widget.dart';
import 'package:eqmonitor/feature/home/component/kmoni/kmoni_scale.dart';
import 'package:eqmonitor/feature/home/component/kmoni/kmoni_settings_dialog.dart';
import 'package:eqmonitor/feature/home/component/parameter/parameter_loader_widget.dart';
import 'package:eqmonitor/feature/home/component/render/map_components_renderer.dart';
import 'package:eqmonitor/feature/home/component/sheet/earthquake_history_widget.dart';
import 'package:eqmonitor/feature/home/component/sheet/status_widget.dart';
import 'package:eqmonitor/feature/home/component/sheet/update_widget.dart';
import 'package:eqmonitor/feature/home/features/map/view/main_map_view.dart';
import 'package:eqmonitor/feature/home/features/map/viewmodel/main_map_viewmodel.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/service/fcm_token_change_detector.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/service/notification_remote_authentication_service.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/service/notification_remote_settings_migrate_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/sheet.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 0.8),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: ColoredBox(
              color: colorScheme.surfaceContainer.withOpacity(0.8),
              child: AppBar(
                title: Text(
                  'EQMonitor',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                forceMaterialTransparency: true,
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: const _HomeBodyWidget(),
    );
  }
}

class _HomeBodyWidget extends HookConsumerWidget {
  const _HomeBodyWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(ntpProvider);
    // 参照元が定数なので notifier から取得
    final sheetController = useSheetController();
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          (
            ref.read(kmoniViewModelProvider.notifier).initialize(),
            ref.read(permissionProvider.notifier).initialize(),
            ref.read(ntpProvider.notifier).sync(),
            () async {
              final token = await ref.read(notificationTokenProvider.future);
              final fcmToken = token.fcmToken;
              if (fcmToken == null) {
                return;
              }
              await ref
                  .read(notificationRemoteAuthenticateServiceProvider)
                  .updateToken(fcmToken: fcmToken);
              await ref
                  .read(fcmTokenChangeDetectorProvider.notifier)
                  .save(fcmToken);
            }(),
            Future.doWhile(() async {
              try {
                final renderer = MapComponentsRenderer();
                final futures = <Future<void>>[
                  for (final type in [
                    IntensityIconType.small,
                    IntensityIconType.smallWithoutText,
                  ]) ...[
                    for (final intensity in JmaIntensity.values)
                      renderer
                          .renderIntensityIcon(
                            context,
                            intensity,
                            type,
                          )
                          .then(
                            (value) => switch (type) {
                              IntensityIconType.small => ref
                                  .read(intensityIconRenderProvider.notifier)
                                  .onRendered(
                                    value,
                                    intensity,
                                  ),
                              IntensityIconType.smallWithoutText => ref
                                  .read(
                                    intensityIconFillRenderProvider.notifier,
                                  )
                                  .onRendered(
                                    value,
                                    intensity,
                                  ),
                              _ => null,
                            },
                          ),
                    for (final intensity in JmaLgIntensity.values)
                      renderer
                          .renderLpgmIntensityIcon(
                            context,
                            intensity,
                            type,
                          )
                          .then(
                            (value) => switch (type) {
                              IntensityIconType.small => ref
                                  .read(
                                    lpgmIntensityIconRenderProvider.notifier,
                                  )
                                  .onRendered(
                                    value,
                                    intensity,
                                  ),
                              IntensityIconType.smallWithoutText => ref
                                  .read(
                                    lpgmIntensityIconFillRenderProvider
                                        .notifier,
                                  )
                                  .onRendered(
                                    value,
                                    intensity,
                                  ),
                              _ => null,
                            },
                          ),
                  ],
                  for (final type in HypocenterType.values)
                    renderer
                        .renderHypocenterIcon(
                          context,
                          type,
                        )
                        .then(
                          (value) => switch (type) {
                            HypocenterType.normal => ref
                                .read(hypocenterIconRenderProvider.notifier)
                                .onRendered(
                                  value,
                                ),
                            HypocenterType.lowPrecise => ref
                                .read(
                                  hypocenterLowPreciseIconRenderProvider
                                      .notifier,
                                )
                                .onRendered(
                                  value,
                                ),
                          },
                        ),
                ];
                await futures.wait;
                // 画像のキャッシュが終わったかどうかを確認
                final images = (
                  intenistyIcon: ref.read(intensityIconRenderProvider),
                  intensityIconFill: ref.read(intensityIconFillRenderProvider),
                  hypocenterIcon: ref.read(hypocenterIconRenderProvider),
                  hypocenterLowPreciseIcon:
                      ref.read(hypocenterLowPreciseIconRenderProvider),
                );
                if (images.hypocenterIcon != null &&
                    images.hypocenterLowPreciseIcon != null &&
                    images.intenistyIcon.isAllRendered() &&
                    images.intensityIconFill.isAllRendered()) {
                  unawaited(FirebaseCrashlytics.instance.log('画像のキャッシュ 成功'));
                  return false;
                }
                await Future<void>.delayed(const Duration(milliseconds: 1000));
                return true;
                // ignore: avoid_catches_without_on_clauses
              } catch (e) {
                await Future<void>.delayed(const Duration(milliseconds: 1000));
                return true;
              }
            }),
          ).wait;
        });
        return null;
      },
      [],
    );

    ref.listen(
      firebaseMessagingInteractionProvider,
      (_, next) async {
        if (next case AsyncData(:final value)) {
          await WidgetsBinding.instance.endOfFrame.then((_) async {
            ref.read(talkerProvider).log(
                  'Handle Firebase Message: '
                  "${const JsonEncoder.withIndent(' ').convert(value.toMap())}",
                );

            final route = value.data['route'];
            if (route is String) {
              unawaited(
                ref.read(goRouterProvider).push<void>(route),
              );
              return;
            }
            final url = value.data['url'];
            if (url is String) {
              final canLaunch = await canLaunchUrlString(url);
              if (canLaunch) {
                await launchUrlString(url);
              }
              return;
            }
          });
        }
      },
    );

    final child = Stack(
      children: [
        const MainMapView(),
        SafeArea(
          bottom: false,
          child: Stack(
            children: [
              // Sheet
              const Align(
                alignment: Alignment.topRight,
                child: IgnorePointer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _KmoniScale(),
                      _IntensityIcons(),
                    ],
                  ),
                ),
              ),
              _Sheet(sheetController: sheetController),
            ],
          ),
        ),
        SheetFloatingActionButtons(
          hasAppBar: false,
          controller: sheetController,
          fab: const [
            _Fabs(),
          ],
        ),
      ],
    );
    return child;
  }
}

class _IntensityIcons extends ConsumerWidget {
  const _IntensityIcons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aliveEews = ref.watch(eewAliveNormalTelegramProvider);
    final maxEstimatedIntensities = aliveEews
        .map(
          (e) => e.regions
              ?.map(
                (region) => region.forecastMaxInt.toDisplayMaxInt().maxInt,
              )
              .toList(),
        )
        .whereNotNull()
        .flattened
        .whereNotNull()
        .toList();
    final maxIntensity = maxEstimatedIntensities.isNotEmpty
        ? maxEstimatedIntensities.reduce((a, b) => a > b ? a : b)
        : null;
    final minIntensity = maxEstimatedIntensities.isNotEmpty
        ? maxEstimatedIntensities.reduce((a, b) => a < b ? a : b)
        : null;
    final intensities = maxIntensity != null && minIntensity != null
        ? [
            ...JmaForecastIntensity.values,
          ].where(
            (e) => e <= maxIntensity && e >= minIntensity,
          )
        : null;
    if (intensities == null || intensities.isEmpty) {
      return const SizedBox.shrink();
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: BorderedContainer(
        key: ValueKey(
          maxIntensity,
        ),
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        borderRadius: BorderRadius.circular((25 / 5) + 5),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (maxIntensity != null && minIntensity != null)
              for (final intensity in intensities)
                JmaForecastIntensityWidget(
                  intensity: intensity,
                  size: 25,
                ),
          ],
        ),
      ),
    );
  }
}

class _Fabs extends ConsumerWidget {
  const _Fabs();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final sheetWidth = BasicModalSheet.width(size);
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: sheetWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const KmoniStatusWidget(),
            Column(
              children: [
                FloatingActionButton.small(
                  heroTag: 'sheet',
                  tooltip: '強震モニタの設定',
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    builder: (context) => const KmoniSettingsModal(),
                  ),
                  elevation: 4,
                  child: const Icon(Icons.settings),
                ),
                FloatingActionButton.small(
                  heroTag: 'home',
                  tooltip: '表示領域領域を戻す',
                  onPressed: () async {
                    final notifier =
                        ref.read(mainMapViewModelProvider.notifier);
                    if (!notifier.isMapControllerRegistered()) {
                      return;
                    }
                    await notifier.animateToHomeBoundary();
                  },
                  elevation: 4,
                  child: const Icon(Icons.home),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({
    required this.sheetController,
  });

  final SheetController sheetController;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: BasicModalSheet(
        controller: sheetController,
        children: [
          const EewWidgets(),
          const KmoniMaintenanceWidget(),
          const ParameterLoaderWidget(),
          const UpdateWidget(),
          const _NotificationPermission(),
          const EarthquakeHistorySheetWidget(),
          const _NotificationMigrationWidget(),
          ListTile(
            title: const Text('地震・津波に関するお知らせ'),
            leading: const Icon(Icons.info),
            onTap: () => const InformationHistoryRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('設定'),
            leading: const Icon(Icons.settings),
            onTap: () => const SettingsRoute().push<void>(context),
          ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}

class _NotificationPermission extends ConsumerWidget {
  const _NotificationPermission();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(permissionProvider);
    if (!state.notification) {
      return BorderedContainer(
        accentColor: Colors.redAccent.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: ListTile(
          title: const Text('通知権限の許可がされていません'),
          subtitle: Column(
            children: [
              const Text('通知を受け取るためには、通知の許可が必要です。'),
              TextButton.icon(
                onPressed: () => ref
                    .read(permissionProvider.notifier)
                    .requestNotificationPermission(),
                icon: const Icon(Icons.notifications),
                label: const Text('通知権限を許可する'),
              ),
            ],
          ),
          leading: const Icon(Icons.error),
        ),
      );
    }
    return Container();
  }
}

class _KmoniScale extends ConsumerWidget {
  const _KmoniScale();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kmoniSettingsProvider);
    final body = Padding(
      padding: const EdgeInsets.all(4),
      child: Tooltip(
        message: '強震モニタ リアルタイム震度のスケール',
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: InkWell(
            child: KmoniScaleWidget(
              markers: [
                if (state.minRealtimeShindo != null &&
                    state.minRealtimeShindo != -3.0)
                  state.minRealtimeShindo!,
              ],
            ),
            onTap: () {},
          ),
        ),
      ),
    );
    final Widget child;

    if (!state.showRealtimeShindoScale || !state.useKmoni) {
      child = const KeyedSubtree(
        key: ValueKey('kmoni_scale_none'),
        child: SizedBox.shrink(),
      );
    } else {
      child = KeyedSubtree(
        key: const ValueKey('kmoni_scale'),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 横幅は 画面2/3 もしくは 300px 以下
            final width = min(constraints.maxWidth * 2 / 3, 300);
            return Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: width.toDouble(),
                height: 40,
                child: body,
              ),
            );
          },
        ),
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: child,
    );
  }
}

class _NotificationMigrationWidget extends ConsumerWidget {
  const _NotificationMigrationWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(notificationRemoteSettingsInitialSetupNotifierProvider);
    return switch (state) {
      AsyncLoading() => const ListTile(
          title: Text('通知設定の移行中'),
          leading: CircularProgressIndicator.adaptive(),
        ),
      AsyncError(:final error) => BorderedContainer(
          elevation: 1,
          child: ListTile(
            title: const Text('通知設定の初期化に失敗しました。アプリケーションを再起動することで 再度初期化を試みます。'),
            subtitle: Text(error.runtimeType.toString()),
            leading: const Icon(Icons.error),
          ),
        ),
      AsyncData(:final value) => switch (value) {
          NotificationRemoteSettingsSetupState.initial ||
          NotificationRemoteSettingsSetupState.completed =>
            const SizedBox.shrink(),
          _ => BorderedContainer(
              elevation: 1,
              child: switch (value) {
                NotificationRemoteSettingsSetupState.waitingForFcmToken =>
                  const ListTile(
                    title: Text('通知配信用トークンの取得中...'),
                    leading: CircularProgressIndicator.adaptive(),
                  ),
                NotificationRemoteSettingsSetupState.registering =>
                  const ListTile(
                    title: Text('通知配信用トークンの登録中...'),
                    leading: CircularProgressIndicator.adaptive(),
                  ),
                NotificationRemoteSettingsSetupState.migrating =>
                  const ListTile(
                    title: Text('通知設定の初期化中...'),
                    leading: CircularProgressIndicator.adaptive(),
                  ),
                NotificationRemoteSettingsSetupState.unsubscribingOldTopics =>
                  const ListTile(
                    title: Text('旧通知設定の解除中'),
                    leading: CircularProgressIndicator.adaptive(),
                  ),
                NotificationRemoteSettingsSetupState.completing =>
                  const ListTile(
                    title: Text('通知設定のセットアップが完了しました'),
                    leading: Icon(Icons.check),
                  ),
                _ => const SizedBox.shrink(),
              },
            ),
        },
    };
  }
}
