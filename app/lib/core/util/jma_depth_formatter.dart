/// 0・700を特別な値として扱う気象庁電文の深さ表示。
class const JmaDepthFormatter() {
  String format({required num? depth, String unknownText = '不明'}) =>
      switch (depth) {
        null => unknownText,
        0 => 'ごく浅い',
        700 => '700km以上',
        final value => '${value}km',
      };
}
