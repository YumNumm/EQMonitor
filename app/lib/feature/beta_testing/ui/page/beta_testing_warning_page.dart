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
    final ds = Theme.of(context).designSystemThemeExtension;

    return Scaffold(
      backgroundColor: ds.color.backgroundDefault,
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _WarningHeader(ds: ds),
                SizedBox(height: ds.spacing.lg),
                _WarningList(ds: ds),
                SizedBox(height: ds.spacing.xxxxl),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _AgreementBottom(ds: ds),
    );
  }
}

class _WarningHeader extends StatelessWidget {
  const _WarningHeader({required this.ds});

  final DesignSystemThemeExtension ds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ds.spacing.lg,
        ds.spacing.xxxxl,
        ds.spacing.lg,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: ds.palette.statusWarning.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(ds.shape.lg),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: ds.palette.statusWarning,
              size: 36,
            ),
          ),
          SizedBox(height: ds.spacing.lg),
          Text(
            'Beta 版をご利用の\n前に',
            style: ds.typography.headlineLarge.copyWith(
              color: ds.textColor.primary,
            ),
          ),
          SizedBox(height: ds.spacing.sm),
          Text(
            'このアプリは現在ベータテスト中です。以下の事項をご確認のうえ、同意いただける場合のみご利用ください。',
            style: ds.typography.bodyLarge.copyWith(
              color: ds.textColor.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _WarningList extends StatelessWidget {
  const _WarningList({required this.ds});

  final DesignSystemThemeExtension ds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ds.spacing.lg),
      child: Column(
        children: [
          for (final (index, warning) in _warnings.indexed)
            Padding(
              padding: EdgeInsets.only(
                bottom: index < _warnings.length - 1 ? ds.spacing.md : 0,
              ),
              child: _WarningCard(warning: warning, index: index, ds: ds),
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
    required this.ds,
  });

  final String warning;
  final int index;
  final DesignSystemThemeExtension ds;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ds.color.surfaceCard,
        borderRadius: BorderRadius.circular(ds.shape.card),
        border: Border.all(color: ds.color.outlineSoft),
      ),
      padding: EdgeInsets.all(ds.spacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: ds.palette.statusWarning.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: ds.typography.labelMedium.copyWith(
                  color: ds.palette.statusWarning,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: ds.spacing.md),
          Expanded(
            child: Text(
              warning,
              style: ds.typography.bodyMedium.copyWith(
                color: ds.textColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AgreementBottom extends ConsumerWidget {
  const _AgreementBottom({required this.ds});

  final DesignSystemThemeExtension ds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          ds.spacing.lg,
          ds.spacing.md,
          ds.spacing.lg,
          ds.spacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  await ref
                      .read(betaTestingAgreedProvider.notifier)
                      .agree();
                  if (context.mounted) {
                    context.go('/');
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: ds.palette.statusWarning,
                  foregroundColor: const Color(0xFF0F141A),
                  padding: EdgeInsets.symmetric(vertical: ds.spacing.lg),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ds.shape.button),
                  ),
                ),
                child: Text(
                  '同意して利用する',
                  style: ds.typography.labelLarge.copyWith(
                    color: const Color(0xFF0F141A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: ds.spacing.md),
            Text(
              '同意しない場合は、アプリストアから最新の正式版アプリをダウンロードしてください。',
              style: ds.typography.bodySmall.copyWith(
                color: ds.textColor.tertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
