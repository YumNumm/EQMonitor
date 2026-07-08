import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// SWR (cache-first) 対象 provider の状態を明示する上部バナー。
///
/// - いずれかが再検証失敗で stale 維持中 (`hasValue && hasError`) → 失敗表示
/// - いずれかがキャッシュ由来の値を表示中 (`isFromCache`) → 更新中表示
/// - それ以外 (fresh / 初回ロード) → 高さゼロ
class CachedDataBanner extends StatelessWidget {
  const CachedDataBanner({required this.values, super.key});

  /// 画面が表示している SWR 対象 provider の状態。値の中身は参照しない。
  final List<AsyncValue<Object?>> values;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasStaleError = values.any((v) => v.hasValue && v.hasError);
    final isRevalidating = values.any((v) => v.isFromCache);

    final Widget content;
    if (hasStaleError) {
      content = _BannerContent(
        key: const ValueKey('cached-data-banner-error'),
        leading: Icon(
          Icons.cloud_off,
          size: 14,
          color: colorScheme.onErrorContainer,
        ),
        message: '最新情報の取得に失敗しました（キャッシュ表示中）',
        backgroundColor: colorScheme.errorContainer,
        foregroundColor: colorScheme.onErrorContainer,
      );
    } else if (isRevalidating) {
      content = _BannerContent(
        key: const ValueKey('cached-data-banner-revalidating'),
        leading: SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        message: 'キャッシュ表示中・更新を確認しています…',
        backgroundColor: colorScheme.surfaceContainerHighest,
        foregroundColor: colorScheme.onSurfaceVariant,
      );
    } else {
      content = const SizedBox.shrink();
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.topCenter,
      child: content,
    );
  }
}

/// DataSource の `isRevalidating` (`ValueListenable<bool>`) を購読し、
/// true の間だけ `CachedDataBanner` の更新中表示と同等のバナーを出す。
/// 一覧ページのリスト上部に `SliverToBoxAdapter` で挿入する用途を想定。
class RevalidatingBanner extends StatelessWidget {
  const RevalidatingBanner({required this.isRevalidating, super.key});

  final ValueListenable<bool> isRevalidating;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isRevalidating,
      builder: (context, revalidating, _) {
        final colorScheme = Theme.of(context).colorScheme;
        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: revalidating
              ? _BannerContent(
                  key: const ValueKey('revalidating-banner'),
                  leading: SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  message: 'キャッシュ表示中・更新を確認しています…',
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  foregroundColor: colorScheme.onSurfaceVariant,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}

class _BannerContent extends StatelessWidget {
  const _BannerContent({
    required this.leading,
    required this.message,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
  });

  final Widget leading;
  final String message;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: foregroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
