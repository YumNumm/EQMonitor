import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_view.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = context.designSystem.color;

    return Scaffold(
      backgroundColor: color.backgroundDefault,
      body: const Stack(
        children: [
          HomeMapView(),
          BasicModalSheet(
            child: _SheetBody(),
          ),
        ],
      ),
    );
  }
}

class _SheetBody extends ConsumerWidget {
  const _SheetBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eewAliveTelegramProvider) ?? [];
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    final eewCards = Column(
      children: state.reversed
          .mapIndexed(
            (index, element) => Padding(
              padding: EdgeInsets.only(bottom: spacing.md),
              child: EewCard(
                eew: element,
                index: (state.length > 1) ? '${index + 1}' : null,
              ),
            ),
          )
          .toList(),
    );

    final actionsCard = Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: color.surfaceCard,
      clipBehavior: Clip.antiAlias,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(designSystem.shape.card),
        side: BorderSide(color: color.outlineSoft),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text('設定', style: typography.titleSmall),
            subtitle: Text('表示設定や地図の動作を調整します', style: typography.bodySmall),
            onTap: () async => const SettingsRoute().push<void>(context),
          ),
          Divider(height: 1, indent: spacing.xl, endIndent: spacing.xl),
          ListTile(
            leading: const Icon(Icons.bug_report_outlined),
            title: Text('デバッグページ', style: typography.titleSmall),
            subtitle: Text('開発者向けの確認画面を開きます', style: typography.bodySmall),
            onTap: () async => const DebugRoute().push<void>(context),
          ),
        ],
      ),
    );

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                spacing.sm,
                spacing.sm,
                spacing.sm,
                spacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: spacing.xs),
                  if (state.isNotEmpty) eewCards,
                  const HomeEarthquakeHistorySheet(),
                  SizedBox(height: spacing.lg),
                  actionsCard,
                ],
              ),
            ),
            if (state.isEmpty)
              SizedBox(
                height: spacing.sm,
              ),
          ],
        ),
      ),
    );
  }
}
