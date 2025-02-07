import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor/core/component/sheet/app_sheet_route.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_settings_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeMapLayerModal extends HookConsumerWidget {
  const HomeMapLayerModal({super.key});

  static Future<void> show(BuildContext context) => Navigator.of(context).push(
        AppSheetRoute(
          builder: (context) => const HomeMapLayerModal(),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = colorScheme.surfaceContainerLow;

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
                  colorScheme.surfaceContainerLow.withValues(alpha: 0.8),
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
                onPressed: () {
                  unawaited(HapticFeedback.lightImpact());
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: _Card(
              title: '強震モニタ',
              description: '強震モニタのリアルタイムデータを表示します',
              isEnabled: ref.watch(kyoshinMonitorSettingsProvider).useKmoni,
              onEnabledChanged: (value) async => lightHapticFunction(
                () => ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                      ref.read(kyoshinMonitorSettingsProvider).copyWith(
                            useKmoni: value,
                          ),
                    ),
              ),
              onTap: ref.watch(kyoshinMonitorSettingsProvider).useKmoni
                  ? () async => selectionHapticFunction(
                        () async => KyoshinMonitorSettingsModal.show(context),
                      )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.description,
    required this.isEnabled,
    this.onEnabledChanged,
    this.onTap,
  });

  final String title;
  final String description;
  final bool isEnabled;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onEnabledChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: colorScheme.surfaceContainerHighest,
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap ?? () => onEnabledChanged?.call(!isEnabled),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (onEnabledChanged != null)
                Switch.adaptive(
                  value: isEnabled,
                  onChanged: onEnabledChanged,
                ),
              if (onTap != null && isEnabled) const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
