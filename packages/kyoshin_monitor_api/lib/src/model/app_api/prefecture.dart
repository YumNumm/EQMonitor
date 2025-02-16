/// 都道府県
enum Prefecture {
  /// その他
  other(shortName: '他', longName: 'その他'),

  /// 北海道
  hokkaido(shortName: '北海道', longName: '北海道'),

  /// 青森県
  aomori(shortName: '青森', longName: '青森県'),

  /// 岩手県
  iwate(shortName: '岩手', longName: '岩手県'),

  /// 宮城県
  miyagi(shortName: '宮城', longName: '宮城県'),

  /// 秋田県
  akita(shortName: '秋田', longName: '秋田県'),

  /// 山形県
  yamagata(shortName: '山形', longName: '山形県'),

  /// 福島県
  fukushima(shortName: '福島', longName: '福島県'),

  /// 茨城県
  ibaraki(shortName: '茨城', longName: '茨城県'),

  /// 栃木県
  tochigi(shortName: '栃木', longName: '栃木県'),

  /// 群馬県
  gunma(shortName: '群馬', longName: '群馬県'),

  /// 埼玉県
  saitama(shortName: '埼玉', longName: '埼玉県'),

  /// 千葉県
  chiba(shortName: '千葉', longName: '千葉県'),

  /// 東京都
  tokyo(shortName: '東京', longName: '東京都'),

  /// 神奈川県
  kanagawa(shortName: '神奈川', longName: '神奈川県'),

  /// 新潟県
  niigata(shortName: '新潟', longName: '新潟県'),

  /// 富山県
  toyama(shortName: '富山', longName: '富山県'),

  /// 石川県
  ishikawa(shortName: '石川', longName: '石川県'),

  /// 福井県
  fukui(shortName: '福井', longName: '福井県'),

  /// 山梨県
  yamanashi(shortName: '山梨', longName: '山梨県'),

  /// 長野県
  nagano(shortName: '長野', longName: '長野県'),

  /// 岐阜県
  gifu(shortName: '岐阜', longName: '岐阜県'),

  /// 静岡県
  shizuoka(shortName: '静岡', longName: '静岡県'),

  /// 愛知県
  aichi(shortName: '愛知', longName: '愛知県'),

  /// 三重県
  mie(shortName: '三重', longName: '三重県'),

  /// 滋賀県
  shiga(shortName: '滋賀', longName: '滋賀県'),

  /// 京都府
  kyoto(shortName: '京都', longName: '京都府'),

  /// 大阪府
  osaka(shortName: '大阪', longName: '大阪府'),

  /// 兵庫県
  hyogo(shortName: '兵庫', longName: '兵庫県'),

  /// 奈良県
  nara(shortName: '奈良', longName: '奈良県'),

  /// 和歌山県
  wakayama(shortName: '和歌山', longName: '和歌山県'),

  /// 鳥取県
  tottori(shortName: '鳥取', longName: '鳥取県'),

  /// 島根県
  shimane(shortName: '島根', longName: '島根県'),

  /// 岡山県
  okayama(shortName: '岡山', longName: '岡山県'),

  /// 広島県
  hiroshima(shortName: '広島', longName: '広島県'),

  /// 山口県
  yamaguchi(shortName: '山口', longName: '山口県'),

  /// 徳島県
  tokushima(shortName: '徳島', longName: '徳島県'),

  /// 香川県
  kagawa(shortName: '香川', longName: '香川県'),

  /// 愛媛県
  ehime(shortName: '愛媛', longName: '愛媛県'),

  /// 高知県
  kochi(shortName: '高知', longName: '高知県'),

  /// 福岡県
  fukuoka(shortName: '福岡', longName: '福岡県'),

  /// 佐賀県
  saga(shortName: '佐賀', longName: '佐賀県'),

  /// 長崎県
  nagasaki(shortName: '長崎', longName: '長崎県'),

  /// 熊本県
  kumamoto(shortName: '熊本', longName: '熊本県'),

  /// 大分県
  oita(shortName: '大分', longName: '大分県'),

  /// 宮崎県
  miyazaki(shortName: '宮崎', longName: '宮崎県'),

  /// 鹿児島県
  kagoshima(shortName: '鹿児島', longName: '鹿児島県'),

  /// 沖縄県
  okinawa(shortName: '沖縄', longName: '沖縄県'),

  /// 不明
  unknown(shortName: '不明', longName: '不明');

  const Prefecture({
    required this.shortName,
    required this.longName,
  });

  /// 短縮名
  final String shortName;

  /// 正式名称
  final String longName;

  /// IDから都道府県を取得
  static Prefecture? fromId(int? id) {
    if (id == null) {
      return Prefecture.unknown;
    }
    if (id == 99) {
      return Prefecture.unknown;
    }
    if (id < 0 || id >= Prefecture.values.length - 1) {
      return Prefecture.unknown;
    }
    return Prefecture.values[id];
  }
}
