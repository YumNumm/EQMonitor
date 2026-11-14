import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';

/// 震度データベースの震源を、代表震源を先頭にした表示順へ並べる。
///
/// 詳細カードの「震源 2」以降と地図上の番号は、この並び順を共有することで一致させる。
class const EarthquakeCatalogHypocenterOrder() {
  List<EarthquakeCatalogHypocenter> sort(
    List<EarthquakeCatalogHypocenter> hypocenters,
  ) {
    if (hypocenters.isEmpty) {
      return const [];
    }
    final primary = hypocenters.firstWhere(
      (hypocenter) => hypocenter.seq == 0,
      orElse: () => hypocenters.first,
    );
    return [
      primary,
      ...hypocenters.where((hypocenter) => hypocenter.seq != primary.seq),
    ];
  }
}
