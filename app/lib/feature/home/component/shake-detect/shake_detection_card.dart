import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ShakeDetectionCard extends ConsumerWidget {
  const ShakeDetectionCard({
    required this.event,
    super.key,
  });

  final ShakeDetectionEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final maxIntensity = event.maxIntensity;

    final intensityColorSchema = ref.watch(intensityColorProvider);
    final maxIntensityColor =
        intensityColorSchema.fromJmaForecastIntensity(maxIntensity);

    final maxIntensityText = switch (maxIntensity) {
      JmaForecastIntensity.zero => '微弱な反応を検知',
      JmaForecastIntensity.one => '弱い揺れを検知',
      JmaForecastIntensity.two => '揺れを検知',
      JmaForecastIntensity.three || JmaForecastIntensity.four => 'やや強い揺れを検知',
      JmaForecastIntensity.fiveLower ||
      JmaForecastIntensity.fiveUpper =>
        '強い揺れを検知',
      JmaForecastIntensity.sixLower ||
      JmaForecastIntensity.sixUpper =>
        '非常に強い揺れを検知',
      JmaForecastIntensity.seven => '非常に強い揺れを検知',
      JmaForecastIntensity.unknown => '揺れを検知'
    };

    return BorderedContainer(
      accentColor: Color.lerp(
        maxIntensityColor.background,
        theme.colorScheme.surface,
        0.8,
      ),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(),
          Text(
            maxIntensityText,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '地域: ',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: event.regions.map((region) => region.name).join(', '),
                ),
              ],
            ),
          ),
          Text(
            "検知時刻: ${DateFormat('yyyy/MM/dd HH:mm').format(event.createdAt.toLocal())}頃",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
