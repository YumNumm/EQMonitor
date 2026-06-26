import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similarity_grade.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/similar_earthquake_gauge.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 類似地震の1件を表示するタイル。
///
/// 既存の[EarthquakeHistoryListTile]を再利用し、`grade`が指定されていれば
/// 類似度ゲージを併記する。タップでその地震の詳細画面に遷移する。
class SimilarEarthquakeTile extends ConsumerWidget {
  const SimilarEarthquakeTile({
    required this.earthquake,
    this.grade,
    this.dense = false,
    super.key,
  });

  final EarthquakePartial earthquake;
  final SimilarityGrade? grade;
  final bool dense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColor = ref.watch(intensityColorProvider);
    final grade = this.grade;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EarthquakeHistoryListTile(
          item: earthquake,
          intensityColor: intensityColor,
          dense: dense,
          onTap: () => EarthquakeHistoryDetailsRoute(
            eventId: earthquake.eventId,
          ).push<void>(context),
        ),
        if (grade != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: SimilarEarthquakeGauge(grade: grade),
          ),
      ],
    );
  }
}
