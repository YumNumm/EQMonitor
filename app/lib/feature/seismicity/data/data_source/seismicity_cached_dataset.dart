import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';

/// ローカルキャッシュへ保存する単位(span 1つ分のイベント一覧と鮮度情報)。
class SeismicityCachedDataset {
  const new({
    required this.events,
    required this.generatedAt,
  });

  final List<SeismicityEvent> events;
  final DateTime generatedAt;

  Map<String, dynamic> toJson() => {
    'generated_at': generatedAt.toIso8601String(),
    'events': events.map((e) => e.toJson()).toList(),
  };

  static SeismicityCachedDataset fromJson(Map<String, dynamic> json) =>
      SeismicityCachedDataset(
        generatedAt: DateTime.parse(json['generated_at'] as String),
        events: (json['events'] as List<dynamic>)
            .map((e) => SeismicityEvent.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
