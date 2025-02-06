import 'dart:async';

import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/route.dart';
import 'package:sheet/sheet.dart';

class HomeMapLayerModal extends HookConsumerWidget {
  const HomeMapLayerModal({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      SheetRoute(
        fit: SheetFit.loose,
        initialExtent: 0.6,
        stops: [0.6, 1],
        decorationBuilder: (context, child) {
          return SafeArea(
            bottom: false,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: child,
            ),
          );
        },
        animationCurve: Curves.easeOutExpo,
        duration: const Duration(milliseconds: 250),
        builder: (context) => const HomeMapLayerModal(),
      ),
    );
  }

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
            title: const Text('レイヤー設定'),
            automaticallyImplyLeading: false,
            centerTitle: false,
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
              description: '説明',
              isEnabled: ref.watch(kyoshinMonitorSettingsProvider).useKmoni,
              onEnabledChanged: (value) async =>
                  ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                        ref.read(kyoshinMonitorSettingsProvider).copyWith(
                              useKmoni: value,
                            ),
                      ),
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
  });

  final String title;
  final String description;
  final bool isEnabled;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onEnabledChanged;

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
        onTap: () => onEnabledChanged?.call(!isEnabled),
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
              Switch.adaptive(
                value: isEnabled,
                onChanged: onEnabledChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
