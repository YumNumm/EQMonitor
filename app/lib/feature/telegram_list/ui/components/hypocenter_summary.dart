// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_body_diff.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
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
    final magnitudeText = quake.magnitude != null ? ' M${quake.magnitude}' : '';
    final depthText = quake.depth != null ? ' 深さ${quake.depth}km' : '';

    final oldMagnitudeText = diff?.oldMagnitude ?? '不明';
    final newMagnitudeText = diff?.newMagnitude ?? '不明';
    final oldDepthText = diff?.oldDepth?.toString() ?? '不明';
    final newDepthText = diff?.newDepth?.toString() ?? '不明';
    final oldEpicenterNameText = diff?.oldEpicenterName ?? '不明';
    final newEpicenterNameText = diff?.newEpicenterName ?? '不明';

    // 差分チップを構築
    final diffChips = <Widget>[
      if (diff case final value? when value.hasMagnitudeChange())
        _DiffChip(text: 'M$oldMagnitudeText→M$newMagnitudeText'),
      if (diff case final value? when value.hasDepthChange())
        _DiffChip(
          text: '深さ${oldDepthText}km→${newDepthText}km',
        ),
      if (diff case final value? when value.hasEpicenterNameChange())
        _DiffChip(
          text: '$oldEpicenterNameText→$newEpicenterNameText',
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
    final colorTheme = context.designSystem.colorTheme;

    final dateTime = DateTime.tryParse(originTime)?.toLocal();
    if (dateTime == null) {
      return const SizedBox.shrink();
    }

    final formatted = DateFormat('yyyy/MM/dd HH:mm').format(dateTime);

    return Text(
      '$formattedごろ発生',
      style: theme.textTheme.bodySmall?.copyWith(
        color: colorTheme.onSurfaceVariant,
      ),
    );
  }
}

class _DiffChip extends StatelessWidget {
  const _DiffChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorTheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: colorTheme.onTertiaryContainer,
        ),
      ),
    );
  }
}
