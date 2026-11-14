import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_catalog_hypocenter_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_hypocenter_point.dart';

/// 地震履歴詳細の地図へ描く震源を、表示中のデータソースに合わせて決める。
///
/// マーカー・初期カメラ・全体表示が同じ震源を指すよう、すべてこの結果を使う。
class const EarthquakeHistoryHypocenterPointsResolver() {
  List<EarthquakeHistoryHypocenterPoint> resolve({
    required Earthquake earthquake,
    required bool showingDb,
  }) {
    if (!showingDb) {
      return switch (earthquake.hypocenter?.coordinates) {
        CoordinateLatLng(:final latitude, :final longitude) => [
          (latitude: latitude, longitude: longitude, index: null),
        ],
        _ => const [],
      };
    }

    final hypocenters = const EarthquakeCatalogHypocenterOrder().sort(
      earthquake.catalog?.hypocenters ?? const [],
    );
    final hasMultiple = hypocenters.length > 1;
    return [
      // 番号は座標のない震源も数えてから振り、詳細カードの番号とずれないようにする。
      for (final (position, hypocenter) in hypocenters.indexed)
        if ((hypocenter.latitude, hypocenter.longitude) case (
          final latitude?,
          final longitude?,
        ))
          (
            latitude: latitude,
            longitude: longitude,
            index: hasMultiple ? position + 1 : null,
          ),
    ];
  }
}
