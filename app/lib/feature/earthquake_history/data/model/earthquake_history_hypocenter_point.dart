/// 地震履歴詳細の地図へ描く震源1件分の位置と番号。
///
/// `index` は震度データベースに複数の震源がある場合だけ持つ1始まりの番号で、
/// 詳細カードの「震源 2」以降と対応する。
typedef EarthquakeHistoryHypocenterPoint = ({
  double latitude,
  double longitude,
  int? index,
});
