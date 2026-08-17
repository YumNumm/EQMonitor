import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/estimation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/first_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/kind_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/max_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/observation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/station_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_telegram_timeline_notifier.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_timeline_overlay.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

/// 津波電文タイムライン デバッグ画面。
///
/// [tsunamiId] に対応する [TsunamiTimeline] を取得し、
/// 各地域・観測点・沖合観測局の追跡項目を 2 次元スクロールテーブルで表示する。
class TsunamiTelegramTimelineDebugPage extends HookConsumerWidget {
  const new({required this.tsunamiId, super.key});

  final String tsunamiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(tsunamiTelegramTimelineProvider(tsunamiId));

    return Scaffold(
      appBar: AppBar(title: Text('Timeline: $tsunamiId')),
      body: Stack(
        children: [
          switch (asyncValue) {
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: TsunamiTimelineOverlay(tsunamiId: tsunamiId),
          ),
        ],
      ),
    );
  }
}

class _TimelineBody extends StatelessWidget {
  const new({required this.timeline});

  final TsunamiTimeline timeline;

  // 列幅・行高さ定義。
  static const double _labelColumnWidth = 132;
  static const double _cellColumnWidth = 140;
  static const double _headerRowHeight = 56;
  static const double _sectionRowHeight = 36;
  static const double _dataRowHeight = 64;

  @override
  Widget build(BuildContext context) {
    final telegrams = timeline.telegrams;

    if (telegrams.isEmpty) {
      return const Center(child: Text('電文なし'));
    }

    final rows = _buildRows();

    // 行数 = ヘッダー行(1) + 各 row spec。
    // 列数 = ラベル列(1) + 電文数。
    final rowCount = rows.length + 1;
    final columnCount = telegrams.length + 1;

    return TableView.builder(
      pinnedRowCount: 1,
      pinnedColumnCount: 1,
      columnCount: columnCount,
      rowCount: rowCount,
      columnBuilder: (index) => TableSpan(
        extent: FixedTableSpanExtent(
          index == 0 ? _labelColumnWidth : _cellColumnWidth,
        ),
      ),
      rowBuilder: (index) {
        if (index == 0) {
          return TableSpan(
            extent: const FixedTableSpanExtent(_headerRowHeight),
            backgroundDecoration: TableSpanDecoration(
              color: context.designSystem.colorTheme.surfaceContainerHighest,
            ),
          );
        }
        final spec = rows[index - 1];
        return switch (spec) {
          _SectionRowSpec() => TableSpan(
            extent: const FixedTableSpanExtent(_sectionRowHeight),
            backgroundDecoration: TableSpanDecoration(
              color: context.designSystem.colorTheme.surfaceContainerLow,
            ),
          ),
          _DataRowSpec() => const TableSpan(
            extent: FixedTableSpanExtent(_dataRowHeight),
          ),
        };
      },
      cellBuilder: (context, vicinity) =>
          _buildCell(context, vicinity, rows: rows, telegrams: telegrams),
    );
  }

  TableViewCell _buildCell(
    BuildContext context,
    TableVicinity vicinity, {
    required List<_TimelineRowSpec> rows,
    required List<TsunamiTelegramMeta> telegrams,
  }) {
    final theme = Theme.of(context);

    // ── ヘッダー行 ─────────────────────────────────────────────────────────
    if (vicinity.row == 0) {
      if (vicinity.column == 0) {
        return TableViewCell(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              '項目',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
      final t = telegrams[vicinity.column - 1];
      return TableViewCell(
        child: Padding(
          padding: const EdgeInsets.all(6),
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
              Text(_fmtDt(t.publishedAt), style: theme.textTheme.labelSmall),
              if (t.serialNo != null)
                Text('#${t.serialNo}', style: theme.textTheme.labelSmall),
            ],
          ),
        ),
      );
    }

    final spec = rows[vicinity.row - 1];
    switch (spec) {
      case _SectionRowSpec(:final label, :final indent):
        // セクション見出しはラベル列にのみ表示（行全体は背景色で帯状に表現）。
        if (vicinity.column == 0) {
          return TableViewCell(
            child: Padding(
              padding: EdgeInsets.only(
                left: 8 + indent,
                right: 8,
                top: 8,
                bottom: 4,
              ),
              child: Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }
        return const TableViewCell(child: SizedBox.shrink());

      case _DataRowSpec(:final label, :final cellBuilder, :final indent):
        if (vicinity.column == 0) {
          return TableViewCell(
            child: Padding(
              padding: EdgeInsets.only(
                left: 4 + indent,
                right: 4,
                top: 4,
                bottom: 4,
              ),
              child: Text(
                label,
                style: theme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          );
        }
        final t = telegrams[vicinity.column - 1];
        return TableViewCell(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              cellBuilder(t.telegramId) ?? '—',
              style: theme.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        );
    }
  }

  /// ヘッダー行を除いた行スペックを順番に構築する。
  List<_TimelineRowSpec> _buildRows() {
    final rows = <_TimelineRowSpec>[];

    for (final region in timeline.regions) {
      rows.add(_SectionRowSpec('【地域】${region.name} (${region.code})'));
      rows.addAll([
        _DataRowSpec('kind', (id) => _kindCell(region.kind, id)),
        _DataRowSpec('lastKind', (id) => _kindCell(region.lastKind, id)),
        _DataRowSpec(
          '予報 第1波',
          (id) => _forecastFirstHeightCell(region.forecastFirstHeight, id),
        ),
        _DataRowSpec(
          '予報 最大波高',
          (id) => _forecastMaxHeightCell(region.forecastMaxHeight, id),
        ),
        _DataRowSpec(
          '推定 第1波',
          (id) => _estimationFirstHeightCell(region.estimationFirstHeight, id),
        ),
        _DataRowSpec(
          '推定 最大波高',
          (id) => _estimationMaxHeightCell(region.estimationMaxHeight, id),
        ),
      ]);
      for (final station in region.stations) {
        rows.add(
          _SectionRowSpec(
            '[観測点] ${station.name} (${station.code})',
            indent: 16,
          ),
        );
        rows.addAll([
          _DataRowSpec(
            '観測 第1波',
            (id) => _stationObservationCell(station.observation, id),
            indent: 16,
          ),
          _DataRowSpec(
            '観測点 予報',
            (id) => _stationForecastCell(station.forecast, id),
            indent: 16,
          ),
        ]);
      }
    }

    if (timeline.offshoreStations.isNotEmpty) {
      rows.add(const _SectionRowSpec('【沖合観測局】'));
      for (final os in timeline.offshoreStations) {
        rows.add(_SectionRowSpec('${os.name} (${os.code})', indent: 16));
        rows.addAll([
          _DataRowSpec(
            '観測 第1波',
            (id) => _offshoreFirstHeightCell(os.firstHeight, id),
            indent: 16,
          ),
          _DataRowSpec(
            '観測 最大波高',
            (id) => _offshoreMaxHeightCell(os.maxHeight, id),
            indent: 16,
          ),
        ]);
      }
    }

    return rows;
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

  String? _forecastFirstHeightCell(FirstHeightTimeline entries, String id) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        final arrivalTime = e.arrivalTime;
        if (arrivalTime != null) {
          parts.add(_fmtDt(arrivalTime));
        }
        final condition = e.condition;
        if (condition != null) {
          parts.add(condition.name);
        }
        final revise = e.revise;
        if (revise != null) {
          parts.add('[${revise.name}]');
        }
        return parts.isEmpty ? '(empty)' : parts.join('\n');
      }
    }
    return null;
  }

  String? _forecastMaxHeightCell(MaxHeightTimeline entries, String id) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        final qualitative = e.qualitative;
        if (qualitative != null) {
          parts.add(qualitative.name);
        }
        final value = e.value;
        if (value != null) {
          parts.add('${value}m${e.isOver == true ? '+' : ''}');
        }
        if (e.isImportant == true) {
          parts.add('重要');
        }
        final revise = e.revise;
        if (revise != null) {
          parts.add('[${revise.name}]');
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
        final arrivalTime = e.arrivalTime;
        if (arrivalTime != null) {
          parts.add(_fmtDt(arrivalTime));
        }
        if (e.isAlreadyArrived == true) {
          parts.add('到達済');
        }
        final revise = e.revise;
        if (revise != null) {
          parts.add('[${revise.name}]');
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
        final qualitative = e.qualitative;
        if (qualitative != null) {
          parts.add(qualitative.name);
        }
        final value = e.value;
        if (value != null) {
          parts.add('${value}m${e.isOver == true ? '+' : ''}');
        }
        if (e.isObserving == true) {
          parts.add('観測中');
        }
        final revise = e.revise;
        if (revise != null) {
          parts.add('[${revise.name}]');
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
        final firstHeightArrivalTime = e.firstHeightArrivalTime;
        if (firstHeightArrivalTime != null) {
          parts.add('第1波:${_fmtDt(firstHeightArrivalTime)}');
        }
        final firstHeightInitial = e.firstHeightInitial;
        if (firstHeightInitial != null) {
          parts.add(firstHeightInitial.name);
        }
        final maxHeightValue = e.maxHeightValue;
        if (maxHeightValue != null) {
          parts.add(
            '最大:${maxHeightValue}m${e.maxHeightIsOver == true ? '+' : ''}',
          );
        }
        final firstHeightRevise = e.firstHeightRevise;
        if (firstHeightRevise != null) {
          parts.add('[${firstHeightRevise.name}]');
        }
        return parts.isEmpty ? '(empty)' : parts.join('\n');
      }
    }
    return null;
  }

  String? _stationForecastCell(StationForecastTimeline entries, String id) {
    for (final e in entries) {
      if (e.telegramId == id) {
        final parts = <String>[];
        final firstHeightArrivalTime = e.firstHeightArrivalTime;
        if (firstHeightArrivalTime != null) {
          parts.add('第1波:${_fmtDt(firstHeightArrivalTime)}');
        }
        final highTideAt = e.highTideAt;
        if (highTideAt != null) {
          parts.add('満潮:${_fmtDt(highTideAt)}');
        }
        final firstHeightCondition = e.firstHeightCondition;
        if (firstHeightCondition != null) {
          parts.add(firstHeightCondition.name);
        }
        final firstHeightRevise = e.firstHeightRevise;
        if (firstHeightRevise != null) {
          parts.add('[${firstHeightRevise.name}]');
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
        final arrivalTime = e.arrivalTime;
        if (arrivalTime != null) {
          parts.add(_fmtDt(arrivalTime));
        }
        final initial = e.initial;
        if (initial != null) {
          parts.add(initial.name);
        }
        if (e.isUnidentifiable == true) {
          parts.add('不明');
        }
        if (e.isMissing == true) {
          parts.add('欠測');
        }
        final revise = e.revise;
        if (revise != null) {
          parts.add('[${revise.name}]');
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
        final value = e.value;
        if (value != null) {
          parts.add('${value}m${e.isOver == true ? '+' : ''}');
        }
        final condition = e.condition;
        if (condition != null) {
          parts.add(condition.name);
        }
        if (e.isRising == true) {
          parts.add('上昇中');
        }
        if (e.isMissing == true) {
          parts.add('欠測');
        }
        final revise = e.revise;
        if (revise != null) {
          parts.add('[${revise.name}]');
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

/// タイムラインの 1 行を表すスペック。
sealed class _TimelineRowSpec {
  const new();
}

/// セクション見出し行（地域・観測点・沖合観測局）。
class _SectionRowSpec extends _TimelineRowSpec {
  const new(this.label, {this.indent = 0});

  final String label;
  final double indent;
}

/// 値を表示するデータ行。
class _DataRowSpec extends _TimelineRowSpec {
  const new(this.label, this.cellBuilder, {this.indent = 0});

  final String label;

  /// telegramId に対するセル表示文字列を返すコールバック。
  /// 変化なし (値なし) の場合は null を返す → "—" を表示。
  final String? Function(String telegramId) cellBuilder;
  final double indent;
}
