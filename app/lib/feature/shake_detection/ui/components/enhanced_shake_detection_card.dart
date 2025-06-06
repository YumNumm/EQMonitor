import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/shake_detection/provider/client_side_shake_detection_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 拡張された揺れ検知カード（サーバー・クライアント統合）
class EnhancedShakeDetectionCard extends ConsumerWidget {
  const EnhancedShakeDetectionCard({
    required this.event,
    super.key,
  });

  final IntegratedShakeDetectionEvent event;

  String _formatRelativeTime(DateTime now, DateTime target) {
    final difference = now.difference(target);
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分${difference.inSeconds % 60}秒前から検知';
    }
    return '${difference.inSeconds}秒前から検知';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final now = ref.watch(timeTickerProvider()).value ?? DateTime.now();
    final intensityColorSchema = ref.watch(intensityColorProvider);

    // イベントの詳細を取得
    final maxIntensity = _getMaxIntensity();
    final regions = _getRegions();
    final pointCount = _getPointCount();
    final isClientDetection = event.source == ShakeDetectionSource.client;

    final maxIntensityColor = intensityColorSchema.fromJmaForecastIntensity(
      maxIntensity,
    );

    final maxIntensityText = _getIntensityText(maxIntensity);
    final relativeTime = _formatRelativeTime(now, event.detectedAt);

    return Semantics(
      label: '$maxIntensityText。$regions で、$relativeTime',
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: maxIntensityColor.background.withValues(alpha: 0.2),
            width: isClientDetection ? 2.0 : 1.0,
          ),
        ),
        color: Color.lerp(
          maxIntensityColor.background,
          theme.colorScheme.surface,
          isClientDetection ? 0.85 : 0.9,
        ),
        elevation: isClientDetection ? 2 : 0,
        shadowColor: maxIntensityColor.background.withValues(alpha: 0.3),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ヘッダー部分
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isClientDetection ? Icons.sensors : Icons.waves,
                            size: 18,
                            color: maxIntensityColor.background,
                            semanticLabel: isClientDetection ? 'リアルタイム検知' : '揺れ',
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              maxIntensityText,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: maxIntensityColor.background,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 検知ソースバッジ
                  _buildSourceBadge(theme, isClientDetection),
                ],
              ),
              
              // 詳細情報
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 場所情報
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: theme.colorScheme.onSurfaceVariant,
                          semanticLabel: '場所',
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            regions,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // 時間情報
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: theme.colorScheme.onSurface,
                          semanticLabel: '時間',
                        ),
                        const SizedBox(width: 8),
                        Text(
                          relativeTime,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    
                    // クライアント検知の場合は追加情報を表示
                    if (isClientDetection) ...[
                      const SizedBox(height: 8),
                      _buildClientDetectionInfo(theme, pointCount),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 検知ソースバッジを構築
  Widget _buildSourceBadge(ThemeData theme, bool isClientDetection) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isClientDetection 
            ? theme.colorScheme.primary.withValues(alpha: 0.1)
            : theme.colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isClientDetection 
              ? theme.colorScheme.primary.withValues(alpha: 0.3)
              : theme.colorScheme.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        isClientDetection ? 'リアルタイム' : '公式',
        style: theme.textTheme.labelSmall?.copyWith(
          color: isClientDetection 
              ? theme.colorScheme.primary 
              : theme.colorScheme.secondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// クライアント検知の追加情報
  Widget _buildClientDetectionInfo(ThemeData theme, int pointCount) {
    final confidence = event.confidence;
    final confidencePercent = (confidence * 100).round();
    
    return Row(
      children: [
        Icon(
          Icons.analytics_outlined,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
          semanticLabel: '詳細',
        ),
        const SizedBox(width: 8),
        Text(
          '観測点数: $pointCount • 信頼度: $confidencePercent%',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// 最大震度を取得
  JmaForecastIntensity _getMaxIntensity() {
    if (event.serverEvent != null) {
      return event.serverEvent!.event.maxIntensity;
    }
    if (event.clientEvent != null) {
      return event.clientEvent!.maxIntensity;
    }
    return JmaForecastIntensity.unknown;
  }

  /// 地域名を取得
  String _getRegions() {
    if (event.serverEvent != null) {
      return event.serverEvent!.event.regions
          .map((region) => region.name)
          .join('、');
    }
    if (event.clientEvent != null) {
      return event.clientEvent!.regionNames.join('、');
    }
    return '不明';
  }

  /// 観測点数を取得
  int _getPointCount() {
    if (event.serverEvent != null) {
      return event.serverEvent!.event.pointCount;
    }
    if (event.clientEvent != null) {
      return event.clientEvent!.detectionPoints.length;
    }
    return 0;
  }

  /// 震度テキストを取得
  String _getIntensityText(JmaForecastIntensity intensity) => switch (intensity) {
    JmaForecastIntensity.zero => '微弱な反応を検知しました',
    JmaForecastIntensity.one => '弱い揺れを検知しました',
    JmaForecastIntensity.two => '揺れを検知しました',
    JmaForecastIntensity.three ||
    JmaForecastIntensity.four => 'やや強い揺れを検知しました',
    JmaForecastIntensity.fiveLower ||
    JmaForecastIntensity.fiveUpper => '強い揺れを検知しました',
    JmaForecastIntensity.sixLower ||
    JmaForecastIntensity.sixUpper => '非常に強い揺れを検知しました',
    JmaForecastIntensity.seven => '非常に強い揺れを検知しました',
    JmaForecastIntensity.unknown => '揺れを検知しました',
  };
}