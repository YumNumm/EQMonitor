import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:flutter/material.dart';

/// 観測点タップ時のポップアップ
Future<void> showStationPopup(
  BuildContext context, {
  required String stationName,
  required JmaIntensity? intensity,
  required JmaLpgmIntensity? lpgmIntensity,
}) {
  return showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    builder: (context) => _StationPopupBody(
      stationName: stationName,
      intensity: intensity,
      lpgmIntensity: lpgmIntensity,
    ),
  );
}

/// 区域タップ時のポップアップ
Future<void> showAreaPopup(
  BuildContext context, {
  required String areaName,
  required JmaIntensity? maxIntensity,
}) {
  return showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    builder: (context) => _AreaPopupBody(
      areaName: areaName,
      maxIntensity: maxIntensity,
    ),
  );
}

class _StationPopupBody extends StatelessWidget {
  const _StationPopupBody({
    required this.stationName,
    required this.intensity,
    required this.lpgmIntensity,
  });

  final String stationName;
  final JmaIntensity? intensity;
  final JmaLpgmIntensity? lpgmIntensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              stationName,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (intensity != null) ...[
                  JmaIntensityIcon(
                    intensity: intensity!,
                    type: .filled,
                    size: 48,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '震度 ${intensity!.label}',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
                if (lpgmIntensity != null &&
                    lpgmIntensity != JmaLpgmIntensity.zero) ...[
                  const SizedBox(width: 16),
                  JmaLpgmIntensityIcon(
                    intensity: lpgmIntensity!,
                    type: .filled,
                    size: 48,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '長周期 ${lpgmIntensity!.label}',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AreaPopupBody extends StatelessWidget {
  const _AreaPopupBody({
    required this.areaName,
    required this.maxIntensity,
  });

  final String areaName;
  final JmaIntensity? maxIntensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(areaName, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            if (maxIntensity != null)
              Row(
                children: [
                  JmaIntensityIcon(
                    intensity: maxIntensity!,
                    type: .filled,
                    size: 48,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '最大震度 ${maxIntensity!.label}',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              )
            else
              Text(
                '観測なし',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
