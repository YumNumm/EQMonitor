import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor/core/component/sheet/app_sheet_route.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryDetailsMapLayerModal extends HookConsumerWidget {
  const EarthquakeHistoryDetailsMapLayerModal({super.key});

  static Future<void> show(BuildContext context) => Navigator.of(context).push(
    AppSheetRoute(
      builder: (context) => const ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        child: EarthquakeHistoryDetailsMapLayerModal(),
      ),
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final backgroundColor = designSystem.colorTheme.surfaceContainerLow;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: BackdropFilter(
              filter: ImageFilter.compose(
                outer: ImageFilter.blur(
                  sigmaX: 8,
                  sigmaY: 8,
                  tileMode: TileMode.mirror,
                ),
                inner: ColorFilter.mode(
                  designSystem.colorTheme.surfaceContainerLow.withValues(alpha: 0.7),
                  BlendMode.srcATop,
                ),
              ),
              child: const Text(
                'マップレイヤー',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton.filledTonal(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  await HapticFeedback.lightImpact();
                  navigator.pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: _LocationSettingCards()),
        ],
      ),
    );
  }
}

class _LocationSettingCards extends ConsumerWidget {
  const _LocationSettingCards();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final configAsync = ref.watch(homeConfigurationProvider);

    return configAsync.when(
      data: (config) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '現在位置マーカー',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _LocationCard(
                    title: '非表示',
                    icon: Icons.location_off_outlined,
                    isSelected: !config.common.showLocation,
                    onTap: () => lightHapticFunction(
                      () => HomeConfigurationNotifier.saveMutation.run(
                        ref,
                        (tsx) async => tsx
                            .get(homeConfigurationProvider.notifier)
                            .save(
                              config.copyWith(
                                common: config.common.copyWith(
                                  showLocation: false,
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _LocationCard(
                    title: '表示',
                    icon: Icons.location_on_outlined,
                    isSelected: config.common.showLocation,
                    onTap: () => lightHapticFunction(() async {
                      var p = await Geolocator.checkPermission();
                      if (p == LocationPermission.denied) {
                        p = await Geolocator.requestPermission();
                      } else if (p == LocationPermission.deniedForever) {
                        await Geolocator.openAppSettings();
                        return;
                      }
                      if (p == LocationPermission.denied ||
                          p == LocationPermission.deniedForever) {
                        return;
                      }
                      await HomeConfigurationNotifier.saveMutation.run(
                        ref,
                        (tsx) async => tsx
                            .get(homeConfigurationProvider.notifier)
                            .save(
                              config.copyWith(
                                common: config.common.copyWith(
                                  showLocation: true,
                                ),
                              ),
                            ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      error: (error, _) => Center(child: Text('$error')),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;

    return Card.outlined(
      elevation: 0,
      color: isSelected
          ? designSystem.colorTheme.primaryContainer
          : designSystem.colorTheme.surfaceContainer,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: isSelected
                        ? designSystem.colorTheme.onPrimaryContainer
                        : designSystem.colorTheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? designSystem.colorTheme.onPrimaryContainer
                          : designSystem.colorTheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
