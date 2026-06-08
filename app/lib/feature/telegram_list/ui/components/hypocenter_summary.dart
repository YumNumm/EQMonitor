import 'package:eqmonitor/feature/telegram_list/domain/earthquake_body_diff.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 震源サマリ表示コンポーネント
///
/// VXSE52, VXSE53, VXSE61, VXSE62 タイルで使用。
/// 震源名・M・深さ・発生時刻を表示し、前報との差分があればチップで示す。
class HypocenterSummary extends StatelessWidget {
  const HypocenterSummary({
    required this.quake,
    this.diff,
    super.key,
  });

  final EarthquakeTelegramBodyQuake quake;
  final HypocenterDiff? diff;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final epicenterName = quake.epicenterName ?? '震源不明';
    final magnitudeText =
        quake.magnitude != null ? ' M${quake.magnitude}' : '';
    final depthText = quake.depth != null ? ' 深さ${quake.depth}km' : '';

    // 差分チップを構築
    final diffChips = <Widget>[
      if (diff != null && diff!.hasMagnitudeChange)
        _DiffChip(text: 'M${diff!.oldMagnitude}→M${diff!.newMagnitude}'),
      if (diff != null && diff!.hasDepthChange)
        _DiffChip(
          text: '深さ${diff!.oldDepth}km→${diff!.newDepth}km',
        ),
      if (diff != null && diff!.hasEpicenterNameChange)
        _DiffChip(
          text: '${diff!.oldEpicenterName}→${diff!.newEpicenterName}',
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: epicenterName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '$magnitudeText$depthText',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        if (quake.originTime != null) ...[
          const SizedBox(height: 2),
          _OriginTimeLine(originTime: quake.originTime!),
        ],
        if (diffChips.isNotEmpty) ...[
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: diffChips,
          ),
        ],
      ],
    );
  }
}

class _OriginTimeLine extends StatelessWidget {
  const _OriginTimeLine({required this.originTime});

  final String originTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final dateTime = DateTime.tryParse(originTime)?.toLocal();
    if (dateTime == null) {
      return const SizedBox.shrink();
    }

    final formatted = DateFormat('yyyy/MM/dd HH:mm').format(dateTime);

    return Text(
      '$formattedごろ発生',
      style: theme.textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _DiffChip extends StatelessWidget {
  const _DiffChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: colorScheme.onTertiaryContainer,
        ),
      ),
    );
  }
}
