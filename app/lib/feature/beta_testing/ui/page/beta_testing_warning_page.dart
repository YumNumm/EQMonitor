import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/beta_testing/data/notifier/beta_testing_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _warnings = [
  'ベータテスト中のため、予期しないバグやクラッシュが発生する可能性があります。',
  'サーバーのアップデートや構成変更により、通知配信やデータ取得に失敗する期間が発生する可能性があります。',
  '実装の不具合等により、最新のデータが表示されない場合があります。',
  'Beta 版の更新がリリースされた場合、強制アップデートが行われる可能性があります。',
];

class BetaTestingWarningPage extends ConsumerWidget {
  const BetaTestingWarningPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;

    return Scaffold(
      backgroundColor: designSystem.colorTheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _WarningHeader(designSystem: designSystem),
                SizedBox(height: designSystem.spacing.lg),
                _WarningList(designSystem: designSystem),
                SizedBox(height: designSystem.spacing.xxxxl),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _AgreementBottom(designSystem: designSystem),
    );
  }
}

class _WarningHeader extends StatelessWidget {
  const _WarningHeader({required this.designSystem});

  final DesignSystemThemeExtension designSystem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        designSystem.spacing.lg,
        designSystem.spacing.xxxxl,
        designSystem.spacing.lg,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: designSystem.colorTheme.status.warning.withValues(
                alpha: 0.15,
              ),
              borderRadius: BorderRadius.circular(designSystem.shape.lg),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: designSystem.colorTheme.status.warning,
              size: 36,
            ),
          ),
          SizedBox(height: designSystem.spacing.lg),
          Text(
            'Beta 版をご利用の\n前に',
            style: designSystem.typography.headlineLarge.copyWith(
              color: designSystem.colorTheme.onSurface,
            ),
          ),
          SizedBox(height: designSystem.spacing.sm),
          Text(
            'このアプリは現在ベータテスト中です。以下の事項をご確認のうえ、同意いただける場合のみご利用ください。',
            style: designSystem.typography.bodyLarge.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _WarningList extends StatelessWidget {
  const _WarningList({required this.designSystem});

  final DesignSystemThemeExtension designSystem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: designSystem.spacing.lg),
      child: Column(
        children: [
          for (final (index, warning) in _warnings.indexed)
            Padding(
              padding: EdgeInsets.only(
                bottom: index < _warnings.length - 1
                    ? designSystem.spacing.md
                    : 0,
              ),
              child: _WarningCard(
                warning: warning,
                index: index,
                designSystem: designSystem,
              ),
            ),
        ],
      ),
    );
  }
}

class _WarningCard extends StatelessWidget {
  const _WarningCard({
    required this.warning,
    required this.index,
    required this.designSystem,
  });

  final String warning;
  final int index;
  final DesignSystemThemeExtension designSystem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: designSystem.colorTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(designSystem.shape.card),
        border: Border.all(color: designSystem.colorTheme.outlineVariant),
      ),
      padding: EdgeInsets.all(designSystem.spacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: designSystem.colorTheme.status.warning.withValues(
                alpha: 0.15,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: designSystem.typography.labelMedium.copyWith(
                  color: designSystem.colorTheme.status.warning,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: designSystem.spacing.md),
          Expanded(
            child: Text(
              warning,
              style: designSystem.typography.bodyMedium.copyWith(
                color: designSystem.colorTheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AgreementBottom extends ConsumerWidget {
  const _AgreementBottom({required this.designSystem});

  final DesignSystemThemeExtension designSystem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          designSystem.spacing.lg,
          designSystem.spacing.md,
          designSystem.spacing.lg,
          designSystem.spacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  await BetaTestingAgreed.agreeMutation.run(
                    ref,
                    (tsx) async =>
                        tsx.get(betaTestingAgreedProvider.notifier).agree(),
                  );
                  if (context.mounted) {
                    context.go('/');
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: designSystem.colorTheme.status.warning,
                  foregroundColor: const Color(0xFF0F141A),
                  padding: EdgeInsets.symmetric(
                    vertical: designSystem.spacing.lg,
                  ),
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(
                      designSystem.shape.button,
                    ),
                  ),
                ),
                child: Text(
                  '同意して利用する',
                  style: designSystem.typography.labelLarge.copyWith(
                    color: const Color(0xFF0F141A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: designSystem.spacing.md),
            Text(
              '同意しない場合は、アプリストアから最新の正式版アプリをダウンロードしてください。',
              style: designSystem.typography.bodySmall.copyWith(
                color: designSystem.colorTheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
