import 'package:eqmonitor/feature/settings/children/config/debug/tsunami/components/tsunami_timeline_row.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/estimation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/first_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/kind_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/max_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/observation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/station_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_telegram_timeline_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 津波電文タイムライン デバッグ画面。
///
/// [tsunamiId] に対応する [TsunamiTimeline] を取得し、
/// 各地域・観測点・沖合観測局の追跡項目を横スクロールテーブルで表示する。
class TsunamiTelegramTimelineDebugPage extends HookConsumerWidget {
  const TsunamiTelegramTimelineDebugPage({
    required this.tsunamiId,
    super.key,
  });

  final String tsunamiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(
      tsunamiTelegramTimelineProvider(tsunamiId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Timeline: $tsunamiId'),
      ),
      body: switch (asyncValue) {
        AsyncLoading() => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        AsyncError(:final error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Error: $error'),
          ),
        ),
        AsyncData(:final value) => _TimelineBody(timeline: value),
      },
    );
  }
}

class _TimelineBody extends StatelessWidget {
  const _TimelineBody({required this.timeline});

  final TsunamiTimeline timeline;

  @override
  Widget build(BuildContext context) {
    final telegrams = timeline.telegrams;

    if (telegrams.isEmpty) {
      return const Center(child: Text('電文なし'));
    }

    return ListView(
      children: [
        _HeaderRow(telegrams: telegrams),
        const Divider(height: 1),
        for (final region in timeline.regions) ...[
          _SectionHeader(label: '【地域】${region.name} (${region.code})'),
          TsunamiTimelineRow(
            label: 'kind',
            telegrams: telegrams,
            cellBuilder: (id) => _kindCell(region.kind, id),
          ),
          TsunamiTimelineRow(
            label: 'lastKind',
            telegrams: telegrams,
            cellBuilder: (id) => _kindCell(region.lastKind, id),
          ),
          TsunamiTimelineRow(
            label: '予報 第1波',
            telegrams: telegrams,
            cellBuilder: (id) => _forecastFirstHeightCell(
              region.forecastFirstHeight,
              id,
            ),
          ),
          TsunamiTimelineRow(
            label: '予報 最大波高',
            telegrams: telegrams,
            cellBuilder: (id) => _forecastMaxHeightCell(
              region.forecastMaxHeight,
              id,
            ),
          ),
          TsunamiTimelineRow(
            label: '推定 第1波',
            telegrams: telegrams,
            cellBuilder: (id) => _estimationFirstHeightCell(
              region.estimationFirstHeight,
              id,
            ),
          ),
          TsunamiTimelineRow(
            label: '推定 最大波高',
            telegrams: telegrams,
            cellBuilder: (id) => _estimationMaxHeightCell(
              region.estimationMaxHeight,
              id,
            ),
          ),
          for (final station in region.stations) ...[
            _SectionHeader(
              label: '  [観測点] ${station.name} (${station.code})',
              indent: 16,
            ),
            TsunamiTimelineRow(
              label: '  観測 第1波',
              telegrams: telegrams,
              cellBuilder: (id) => _stationObservationCell(
                station.observation,
                id,
              ),
            ),
            TsunamiTimelineRow(
              label: '  観測点 予報',
              telegrams: telegrams,
              cellBuilder: (id) => _stationForecastCell(station.forecast, id),
            ),
          ],
        ],
        if (timeline.offshoreStations.isNotEmpty) ...[
          const Divider(height: 1),
          const _SectionHeader(label: '【沖合観測局】'),
          for (final os in timeline.offshoreStations) ...[
            _SectionHeader(
              label: '  ${os.name} (${os.code})',
              indent: 16,
            ),
            TsunamiTimelineRow(
              label: '  観測 第1波',
              telegrams: telegrams,
              cellBuilder: (id) => _offshoreFirstHeightCell(os.firstHeight, id),
            ),
            TsunamiTimelineRow(
              label: '  観測 最大波高',
              telegrams: telegrams,
              cellBuilder: (id) => _offshoreMaxHeightCell(os.maxHeight, id),
            ),
          ],
        ],
        const SizedBox(height: 24),
      ],
    );
  }

  // ── cell builders ────────────────────────────────────────────────────────

  String? _kindCell(KindTimeline entries, String id) {
    for (final e in entries) {
      if (e.telegramId == id) {
        return e.kind.name;
      }
    }
    return null;
  }

  String? _forecastFirstHeightCell(
    FirstHeightTimeline entries,
    String id,
  ) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        if (e.arrivalTime != null) {
          parts.add(_fmtDt(e.arrivalTime!));
        }
        if (e.condition != null) {
          parts.add(e.condition!.name);
        }
        if (e.revise != null) {
          parts.add('[${e.revise!.name}]');
        }
        return parts.isEmpty ? '(empty)' : parts.join('\n');
      }
    }
    return null;
  }

  String? _forecastMaxHeightCell(
    MaxHeightTimeline entries,
    String id,
  ) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        if (e.qualitative != null) {
          parts.add(e.qualitative!.name);
        }
        if (e.value != null) {
          parts.add('${e.value}m${e.isOver == true ? '+' : ''}');
        }
        if (e.isImportant == true) {
          parts.add('重要');
        }
        if (e.revise != null) {
          parts.add('[${e.revise!.name}]');
        }
        return parts.isEmpty ? '(empty)' : parts.join('\n');
      }
    }
    return null;
  }

  String? _estimationFirstHeightCell(
    EstimationFirstHeightTimeline entries,
    String id,
  ) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        if (e.arrivalTime != null) {
          parts.add(_fmtDt(e.arrivalTime!));
        }
        if (e.isAlreadyArrived == true) {
          parts.add('到達済');
        }
        if (e.revise != null) {
          parts.add('[${e.revise!.name}]');
        }
        return parts.isEmpty ? '(empty)' : parts.join('\n');
      }
    }
    return null;
  }

  String? _estimationMaxHeightCell(
    EstimationMaxHeightTimeline entries,
    String id,
  ) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        if (e.qualitative != null) {
          parts.add(e.qualitative!.name);
        }
        if (e.value != null) {
          parts.add('${e.value}m${e.isOver == true ? '+' : ''}');
        }
        if (e.isObserving == true) {
          parts.add('観測中');
        }
        if (e.revise != null) {
          parts.add('[${e.revise!.name}]');
        }
        return parts.isEmpty ? '(empty)' : parts.join('\n');
      }
    }
    return null;
  }

  String? _stationObservationCell(
    StationObservationTimeline entries,
    String id,
  ) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        if (e.firstHeightArrivalTime != null) {
          parts.add('第1波:${_fmtDt(e.firstHeightArrivalTime!)}');
        }
        if (e.firstHeightInitial != null) {
          parts.add(e.firstHeightInitial!.name);
        }
        if (e.maxHeightValue != null) {
          parts.add(
            '最大:${e.maxHeightValue}m${e.maxHeightIsOver == true ? '+' : ''}',
          );
        }
        if (e.firstHeightRevise != null) {
          parts.add('[${e.firstHeightRevise!.name}]');
        }
        return parts.isEmpty ? '(empty)' : parts.join('\n');
      }
    }
    return null;
  }

  String? _stationForecastCell(
    StationForecastTimeline entries,
    String id,
  ) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        if (e.firstHeightArrivalTime != null) {
          parts.add('第1波:${_fmtDt(e.firstHeightArrivalTime!)}');
        }
        if (e.highTideAt != null) {
          parts.add('満潮:${_fmtDt(e.highTideAt!)}');
        }
        if (e.firstHeightCondition != null) {
          parts.add(e.firstHeightCondition!.name);
        }
        if (e.firstHeightRevise != null) {
          parts.add('[${e.firstHeightRevise!.name}]');
        }
        return parts.isEmpty ? '(empty)' : parts.join('\n');
      }
    }
    return null;
  }

  String? _offshoreFirstHeightCell(
    ObservationFirstHeightTimeline entries,
    String id,
  ) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        if (e.arrivalTime != null) {
          parts.add(_fmtDt(e.arrivalTime!));
        }
        if (e.initial != null) {
          parts.add(e.initial!.name);
        }
        if (e.isUnidentifiable == true) {
          parts.add('不明');
        }
        if (e.isMissing == true) {
          parts.add('欠測');
        }
        if (e.revise != null) {
          parts.add('[${e.revise!.name}]');
        }
        return parts.isEmpty ? '(empty)' : parts.join('\n');
      }
    }
    return null;
  }

  String? _offshoreMaxHeightCell(
    ObservationMaxHeightTimeline entries,
    String id,
  ) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        if (e.value != null) {
          parts.add('${e.value}m${e.isOver == true ? '+' : ''}');
        }
        if (e.condition != null) {
          parts.add(e.condition!.name);
        }
        if (e.isRising == true) {
          parts.add('上昇中');
        }
        if (e.isMissing == true) {
          parts.add('欠測');
        }
        if (e.revise != null) {
          parts.add('[${e.revise!.name}]');
        }
        return parts.isEmpty ? '(empty)' : parts.join('\n');
      }
    }
    return null;
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  String _fmtDt(DateTime dt) {
    final local = dt.toLocal();
    return '${local.month.toString().padLeft(2, '0')}/'
        '${local.day.toString().padLeft(2, '0')} '
        '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';
  }
}

/// ヘッダー行: 各電文のタイトル・発行日時を表示。
class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.telegrams});

  final List<TsunamiTelegramMeta> telegrams;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 120),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final t in telegrams)
                  Container(
                    width: 140,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.title,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          _fmtDt(t.publishedAt),
                          style: theme.textTheme.labelSmall,
                        ),
                        if (t.serialNo != null)
                          Text(
                            '#${t.serialNo}',
                            style: theme.textTheme.labelSmall,
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _fmtDt(DateTime dt) {
    final local = dt.toLocal();
    return '${local.month.toString().padLeft(2, '0')}/'
        '${local.day.toString().padLeft(2, '0')} '
        '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';
  }
}

/// セクション見出し行。
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, this.indent = 0});

  final String label;
  final double indent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
        left: 8 + indent,
        right: 8,
        top: 6,
        bottom: 2,
      ),
      color: theme.colorScheme.surfaceContainerLow,
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
