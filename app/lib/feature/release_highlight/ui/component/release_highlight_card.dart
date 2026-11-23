import 'package:eqmonitor/core/component/banner/app_banner.dart';
import 'package:eqmonitor/core/component/chip/beta_chip.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/release_highlight/data/flow/release_highlight_flow.dart';
import 'package:eqmonitor/feature/release_highlight/data/model/release_highlight.dart';
import 'package:eqmonitor/feature/release_highlight/data/provider/visible_release_highlight_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// アップデート後のホームに表示する新機能の案内。
///
/// 緊急地震速報や揺れ検知の表示中は [isCompact] を true にして 1 行に畳み、
/// 地震の情報を画面外へ押し出さない。
class const ReleaseHighlightCard({required final bool isCompact, super.key})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(visibleReleaseHighlightProvider);
    if (visible == null) {
      return const SizedBox.shrink();
    }
    return isCompact
        ? _CompactCard(highlight: visible.highlight)
        : _ExpandedCard(
            highlight: visible.highlight,
            primaryAction: visible.primaryAction,
          );
  }
}

class const _CompactCard({required final ReleaseHighlight highlight})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = context.designSystem.colorTheme;

    return AppBanner(
      icon: Icons.new_releases_outlined,
      title: '新機能: ${highlight.title}',
      backgroundColor: colorTheme.primaryContainer,
      foregroundColor: colorTheme.onPrimaryContainer,
      onTap: () async => const ReleaseHighlightFlow().openDetail(
        context: context,
        highlight: highlight,
      ),
      trailing: highlight.isBeta ? const BetaChip() : null,
      onDismiss: () => HapticUtil.light(
        () => const ReleaseHighlightFlow().dismiss(ref: ref),
      ),
    );
  }
}

class const _ExpandedCard({
  required final ReleaseHighlight highlight,
  required final ReleaseHighlightAction primaryAction,
}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final foreground = colorTheme.onPrimaryContainer;

    final detailRecognizer = useMemoized(TapGestureRecognizer.new);
    useEffect(() => detailRecognizer.dispose, [detailRecognizer]);
    detailRecognizer.onTap = () async => const ReleaseHighlightFlow()
        .openDetail(context: context, highlight: highlight);

    final header = Row(
      spacing: spacing.sm,
      children: [
        Icon(Icons.new_releases_outlined, color: foreground, size: 18),
        Expanded(
          child: Text(
            'v${highlight.version} の新機能',
            style: typography.labelMedium.copyWith(
              color: foreground,
              fontWeight: .w600,
            ),
          ),
        ),
        IconButton(
          onPressed: () => HapticUtil.light(
            () => const ReleaseHighlightFlow().dismiss(ref: ref),
          ),
          icon: Icon(Icons.close_rounded, color: foreground, size: 20),
          visualDensity: VisualDensity.compact,
          tooltip: '閉じる',
        ),
      ],
    );
    final title = Wrap(
      spacing: spacing.sm,
      runSpacing: spacing.xs,
      crossAxisAlignment: .center,
      children: [
        Text(
          highlight.title,
          style: typography.titleMedium.copyWith(
            color: foreground,
            fontWeight: .bold,
          ),
        ),
        if (highlight.isProFeature) const _ProChip(),
        if (highlight.isBeta) const BetaChip(),
      ],
    );
    final description = Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '${highlight.description} '),
          TextSpan(
            text: '詳しく',
            style: TextStyle(
              color: colorTheme.primary,
              decoration: .underline,
              decorationColor: colorTheme.primary,
              fontWeight: .w600,
            ),
            recognizer: detailRecognizer,
          ),
        ],
      ),
      style: typography.bodySmall.copyWith(color: foreground),
    );
    final actions = SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: .spaceBetween,
        crossAxisAlignment: .center,
        spacing: spacing.sm,
        children: [
          FilledButton(
            onPressed: () async =>
                const ReleaseHighlightFlow().openPrimaryAction(
                  ref: ref,
                  context: context,
                  action: primaryAction,
                ),
            style: FilledButton.styleFrom(
              visualDensity: VisualDensity.compact,
              textStyle: typography.labelLarge.copyWith(fontWeight: .bold),
            ),
            child: Text(primaryAction.label),
          ),
          TextButton(
            onPressed: () async => const ReleaseHighlightFlow().openChangelog(
              ref: ref,
              context: context,
            ),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              foregroundColor: foreground,
              textStyle: typography.labelLarge,
            ),
            child: const Row(
              mainAxisSize: .min,
              children: [
                Text('変更履歴'),
                Icon(Icons.chevron_right_rounded, size: 18),
              ],
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: spacing.md),
      child: Material(
        color: colorTheme.primaryContainer,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(designSystem.shape.card),
          side: BorderSide(color: colorTheme.outlineVariant),
        ),
        clipBehavior: .antiAlias,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            spacing.lg,
            spacing.sm,
            spacing.sm,
            spacing.md,
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              header,
              Padding(
                padding: EdgeInsets.only(right: spacing.md),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    title,
                    SizedBox(height: spacing.xs),
                    description,
                    SizedBox(height: spacing.md),
                    actions,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [BetaChip] と形をそろえた、このカード専用の「Pro」チップ。
class const _ProChip() extends StatelessWidget {
  static const _height = 18.0;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;

    return Container(
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: _height * 0.3),
      decoration: ShapeDecoration(
        color: colorTheme.primary,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(_height * 0.34),
        ),
      ),
      child: Center(
        widthFactor: 1,
        child: Text(
          'Pro',
          textScaler: TextScaler.noScaling,
          style: TextStyle(
            fontFamily: FontFamily.googleSansFlex,
            fontSize: _height * 0.72,
            height: 1,
            color: colorTheme.onPrimary,
            fontWeight: .w800,
            fontVariations: const [FontVariation.weight(800)],
            leadingDistribution: .even,
          ),
        ),
      ),
    );
  }
}
