/// JMA Information Serial Code for Nankai Trough Earthquake.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-19.
enum JmaInformationSerialCode {
  investigatingA(
    1,
    '調査中A',
    '監視領域内でマグニチュード6.8以上の地震が発生したことにより、'
        '臨時に「南海トラフ沿いの地震に関する評価検討会」を開催',
  ),
  investigatingB(
    2,
    '調査中B',
    '1カ所以上のひずみ計での有意な変化と共に、他の複数の観測点でもそれに関係すると思われる変化が観測され、'
        '想定震源域内のプレート境界で通常と異なるゆっくりすべりが発生している可能性がある場合など、'
        'ひずみ計で南海トラフ地震との関連性の検討が必要と認められる変化を観測したことにより、'
        '臨時に「南海トラフ沿いの地震に関する評価検討会」を開催',
  ),
  investigatingC(
    3,
    '調査中C',
    'その他、想定震源域内のプレート境界の固着状態の変化を示す可能性のある現象が観測される等、'
        '南海トラフ地震との関連性の検討が必要と認められる現象を観測したことにより、'
        '臨時に「南海トラフ沿いの地震に関する評価検討会」を開催',
  ),
  megaEarthquakeWarning(4, '巨大地震警戒', '巨大地震警戒'),
  megaEarthquakeCaution(5, '巨大地震注意', '巨大地震注意'),
  investigationEnded(6, '調査終了', '調査終了'),
  otherInformation(15, 'その他の情報', 'その他の情報');

  const JmaInformationSerialCode(this.code, this.name, this.description);

  final int code;
  final String name;
  final String description;

  /// Returns the information serial code for the given code.
  ///
  /// Returns null if not found.
  static JmaInformationSerialCode? fromCode(int code) =>
      JmaInformationSerialCode.values.where((e) => e.code == code).firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '地震関連情報(コード番号：$code)';
}
