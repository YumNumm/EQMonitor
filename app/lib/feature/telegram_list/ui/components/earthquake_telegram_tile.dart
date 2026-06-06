import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/telegram_item.dart';
import 'package:eqmonitor/feature/telegram_list/domain/earthquake_body_diff.dart';
import 'package:eqmonitor/feature/telegram_list/ui/components/hypocenter_summary.dart';
import 'package:eqmonitor/feature/telegram_list/ui/components/intensity_region_list.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 電文タイプ別地震情報リッチタイル
///
/// VXSE51〜53, VXSE61, VXSE62 の電文タイプに応じて
/// 震源サマリや震度地域リストの表示を切り替える。
class EarthquakeTelegramTile extends StatelessWidget {
  const EarthquakeTelegramTile({
    required this.telegram,
    required this.body,
    required this.sequenceNumber,
    this.previousBody,
    super.key,
  });

  /// 電文メタ情報
  final TelegramItem telegram;

  /// 地震情報本文（EARTHQUAKE 型）
  final api.TelegramBodyUnionEarthquakeTelegramBody body;

  /// 報番号（1-based、1 = 初報）
  final int sequenceNumber;

  /// 前報の本文（差分表示用、初報の場合は null）
  final api.TelegramBodyUnionEarthquakeTelegramBody? previousBody;

  // ---------------------------------------------------------------------------
  // 震度地域リスト用ヘルパー
  // ---------------------------------------------------------------------------

  /// 現報の震度地域リスト（タイプ別に参照先を切り替え）
  List<api.EarthquakeTelegramBodyIntensityRegion>? get _currentRegions =>
      switch (telegram.type) {
        TelegramType.vxse51 => body.intensityRegions,
        TelegramType.vxse53 => body.intensityCities ?? body.intensityRegions,
        TelegramType.vxse62 => body.intensityRegions,
        _ => null,
      };

  /// 前報の震度地域リスト
  List<api.EarthquakeTelegramBodyIntensityRegion>? get _previousRegions =>
      switch (telegram.type) {
        TelegramType.vxse51 => previousBody?.intensityRegions,
        TelegramType.vxse53 =>
          previousBody?.intensityCities ?? previousBody?.intensityRegions,
        TelegramType.vxse62 => previousBody?.intensityRegions,
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');

    // 差分計算
    final regions = _currentRegions;
    final regionDiff = regions == null
        ? null
        : computeIntensityRegionDiff(
            current: regions,
            previous: _previousRegions,
          );

    final hypocenterDiff = computeHypocenterDiff(
      current: body.earthquake,
      previous: previousBody?.earthquake,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header row ──────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Text(
                    telegram.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (sequenceNumber > 1) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '第$sequenceNumber報',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            // ── Timestamp ───────────────────────────────────────────────
            const SizedBox(height: 4),
            Text(
              dateFormat.format(telegram.pressAt.toLocal()),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            // ── Content（タイプ別）───────────────────────────────────────
            const SizedBox(height: 8),
            _buildContent(regionDiff, hypocenterDiff),
          ],
        ),
      ),
    );
  }

  /// 電文タイプに応じたコンテンツ部分を構築する
  Widget _buildContent(
    List<IntensityRegionDiffEntry>? regionDiff,
    HypocenterDiff? hypocenterDiff,
  ) {
    return switch (telegram.type) {
      // VXSE51: 震度速報（震度のみ）
      TelegramType.vxse51 => regionDiff != null
          ? IntensityRegionList(entries: regionDiff)
          : const SizedBox.shrink(),

      // VXSE52: 震源速報（震源のみ）
      TelegramType.vxse52 => body.earthquake != null
          ? HypocenterSummary(
              quake: body.earthquake!,
              diff: hypocenterDiff,
            )
          : const SizedBox.shrink(),

      // VXSE53: 震源・震度情報（両方）
      TelegramType.vxse53 => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (body.earthquake != null)
              HypocenterSummary(
                quake: body.earthquake!,
                diff: hypocenterDiff,
              ),
            if (body.earthquake != null && regionDiff != null)
              const SizedBox(height: 8),
            if (regionDiff != null) IntensityRegionList(entries: regionDiff),
          ],
        ),

      // VXSE61: 地震解説報（震源のみ）
      TelegramType.vxse61 => body.earthquake != null
          ? HypocenterSummary(
              quake: body.earthquake!,
              diff: hypocenterDiff,
            )
          : const SizedBox.shrink(),

      // VXSE62: 長周期地震動（震源 + 震度地域）
      TelegramType.vxse62 => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (body.earthquake != null)
              HypocenterSummary(
                quake: body.earthquake!,
                diff: hypocenterDiff,
              ),
            if (body.earthquake != null && regionDiff != null)
              const SizedBox(height: 8),
            if (regionDiff != null) IntensityRegionList(entries: regionDiff),
          ],
        ),

      // その他のタイプは空
      _ => const SizedBox.shrink(),
    };
  }
}
