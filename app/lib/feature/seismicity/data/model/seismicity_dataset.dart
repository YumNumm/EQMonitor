import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_dataset.freezed.dart';

/// 指定 span 1つ分の震源イベント一覧と鮮度情報。
@freezed
abstract class SeismicityDataset with _$SeismicityDataset {
  const factory({
    required List<SeismicityEvent> events,
    required DateTime generatedAt,

    /// 取得失敗によりローカルキャッシュへフォールバックした場合 true
    required bool isFromCache,
  }) = _SeismicityDataset;
}
