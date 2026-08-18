/// 日本標準時 (JST) 関連の定数。
abstract final class Jst {
  /// UTC からのオフセット
  static const offset = Duration(hours: 9);
}

extension JstDateTimeX on DateTime {
  /// 端末のタイムゾーンに関係なく、JST の壁時計時刻を持つ [DateTime] に変換する。
  ///
  /// 強震モニタ / 長周期地震動モニタの Web API はパスに JST の
  /// `yyyyMMddHHmmss` を要求するため、URL を組み立てる直前にこれを通す。
  ///
  /// 返り値は `isUtc == true` だが、フィールド (`year`/`hour` など) は JST の
  /// 壁時計を指す。`DateFormat.format` はフィールドをそのまま読むため、
  /// 端末のタイムゾーンに依存せず JST の文字列が得られる。
  DateTime toJst() => toUtc().add(Jst.offset);
}
