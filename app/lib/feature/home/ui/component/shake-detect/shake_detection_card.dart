import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/notifier/intensity_color_notifier.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShakeDetectionCard extends ConsumerWidget {
  const ShakeDetectionCard({required this.event, super.key});

  final ShakeDetectionEvent event;

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
    final maxIntensity = event.maxIntensity;
    final now = ref.watch(timeTickerProvider()).value ?? DateTime.now();

    final intensityColorSchema = ref.watch(intensityColorProvider);
    final maxIntensityColor = intensityColorSchema.fromJmaForecastIntensity(
      maxIntensity,
    );

    final maxIntensityText = switch (maxIntensity) {
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

    final regions = event.regions.map((region) => region.name).join('、');
    final relativeTime = _formatRelativeTime(now, event.createdAt.toLocal());

    return Semantics(
      label: '$maxIntensityText。$regions で、$relativeTime',
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: maxIntensityColor.background.withValues(alpha: 0.2),
          ),
        ),
        color: Color.lerp(
          maxIntensityColor.background,
          theme.colorScheme.surface,
          0.9,
        ),
        elevation: 0,
        shadowColor: maxIntensityColor.background.withValues(alpha: 0.3),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: MergeSemantics(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.waves,
                            size: 18,
                            color: maxIntensityColor.background,
                            semanticLabel: '揺れ',
                          ),
                          const SizedBox(width: 8),
                          Text(
                            maxIntensityText,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: maxIntensityColor.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MergeSemantics(
                      child: Row(
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
                    ),
                    const SizedBox(height: 8),
                    MergeSemantics(
                      child: Row(
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
                    ),
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
