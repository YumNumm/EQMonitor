import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// 震度データベースの震度階級コード
/// https://www.data.jma.go.jp/eqev/data/bulletin/data/shindo/format_j.txt
enum ShindoDbIntensityClass {
  one,
  two,
  three,
  four,

  /// 1996年9月以前の細分化されていない震度5
  five,
  fiveLower,
  fiveUpper,

  /// 1996年9月以前の細分化されていない震度6
  six,
  sixLower,
  sixUpper,
  seven,

  /// 有感だが震度不明 (9)
  unknownFelt,

  /// 顕著地震: 最大有感距離300km以上 (R)
  conspicuous,

  /// やや顕著地震: 最大有感距離200km以上300km未満 (M)
  semiConspicuous,

  /// 小局発地震: 最大有感距離100km以上200km未満 (S)
  semiLocal,

  /// 局発地震: 最大有感距離100km未満 (L)
  local,

  /// 有感地震 (F, 1984年まで)
  felt,

  /// 付近有感 (X, 1996年9月まで)
  nearbyFelt;

  String get label => switch (this) {
    .one => '1',
    .two => '2',
    .three => '3',
    .four => '4',
    .five => '5',
    .fiveLower => '5弱',
    .fiveUpper => '5強',
    .six => '6',
    .sixLower => '6弱',
    .sixUpper => '6強',
    .seven => '7',
    .unknownFelt => '震度不明',
    .conspicuous => '顕著',
    .semiConspicuous => 'やや顕著',
    .semiLocal => '小局発',
    .local => '局発',
    .felt => '有感',
    .nearbyFelt => '付近有感',
  };

  String get sectionTitle => switch (this) {
    .unknownFelt => '震度不明(有感)',
    .conspicuous => '顕著地震',
    .semiConspicuous => 'やや顕著地震',
    .semiLocal => '小局発地震',
    .local => '局発地震',
    .felt => '有感',
    .nearbyFelt => '付近有感',
    _ => '震度$label',
  };

  /// 歴史的階級の説明。数値階級は null
  String? get historicalDescription => switch (this) {
    .unknownFelt => '有感であったが震度は不明',
    .conspicuous => '最大有感距離300km以上の地震 (歴史的分類)',
    .semiConspicuous => '最大有感距離200km以上300km未満の地震 (歴史的分類)',
    .semiLocal => '最大有感距離100km以上200km未満の地震 (歴史的分類)',
    .local => '最大有感距離100km未満の地震 (歴史的分類)',
    .felt => '有感地震 (1984年までの分類)',
    .nearbyFelt => '付近有感 (1996年9月までの分類)',
    _ => null,
  };

  /// アイコンをそのまま流用できる JMA 震度。5/6 (旧階級) と歴史的階級は null
  JmaIntensity? get exactJmaIntensity => switch (this) {
    .one => .one,
    .two => .two,
    .three => .three,
    .four => .four,
    .fiveLower => .fiveLower,
    .fiveUpper => .fiveUpper,
    .sixLower => .sixLower,
    .sixUpper => .sixUpper,
    .seven => .seven,
    _ => null,
  };

  /// 塗り分け・チップの配色に使う JMA 震度。旧階級 5/6 は弱側の色で代替。
  /// 歴史的階級は null (グレー表現)
  JmaIntensity? get colorJmaIntensity => switch (this) {
    .five => .fiveLower,
    .six => .sixLower,
    _ => exactJmaIntensity,
  };

  bool get isNumeric => colorJmaIntensity != null;

  /// 表示順 (大きいほど上に表示)
  int get orderIndex => switch (this) {
    .seven => 17,
    .sixUpper => 16,
    .sixLower => 15,
    .six => 14,
    .fiveUpper => 13,
    .fiveLower => 12,
    .five => 11,
    .four => 10,
    .three => 9,
    .two => 8,
    .one => 7,
    .unknownFelt => 6,
    .conspicuous => 5,
    .semiConspicuous => 4,
    .semiLocal => 3,
    .local => 2,
    .felt => 1,
    .nearbyFelt => 0,
  };
}

extension ApiCatalogIntensityClassConverter on api.CatalogIntensityClass {
  ShindoDbIntensityClass get toShindoDbIntensityClass => switch (this) {
    .value1 => .one,
    .value2 => .two,
    .value3 => .three,
    .value4 => .four,
    .value5 => .five,
    .value6 => .six,
    .value7 => .seven,
    .value9 => .unknownFelt,
    .a => .fiveLower,
    .b => .fiveUpper,
    .c => .sixLower,
    .d => .sixUpper,
    .l => .local,
    .s => .semiLocal,
    .m => .semiConspicuous,
    .r => .conspicuous,
    .f => .felt,
    .x => .nearbyFelt,
  };
}
