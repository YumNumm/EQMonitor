/// JMA Prefecture definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-17.
enum JmaPrefecture {
  hokkaido(1, '北海道'),
  aomori(2, '青森県'),
  iwate(3, '岩手県'),
  miyagi(4, '宮城県'),
  akita(5, '秋田県'),
  yamagata(6, '山形県'),
  fukushima(7, '福島県'),
  ibaraki(8, '茨城県'),
  tochigi(9, '栃木県'),
  gunma(10, '群馬県'),
  saitama(11, '埼玉県'),
  chiba(12, '千葉県'),
  tokyo(13, '東京都'),
  kanagawa(14, '神奈川県'),
  niigata(15, '新潟県'),
  toyama(16, '富山県'),
  ishikawa(17, '石川県'),
  fukui(18, '福井県'),
  yamanashi(19, '山梨県'),
  nagano(20, '長野県'),
  gifu(21, '岐阜県'),
  shizuoka(22, '静岡県'),
  aichi(23, '愛知県'),
  mie(24, '三重県'),
  shiga(25, '滋賀県'),
  kyoto(26, '京都府'),
  osaka(27, '大阪府'),
  hyogo(28, '兵庫県'),
  nara(29, '奈良県'),
  wakayama(30, '和歌山県'),
  tottori(31, '鳥取県'),
  shimane(32, '島根県'),
  okayama(33, '岡山県'),
  hiroshima(34, '広島県'),
  yamaguchi(35, '山口県'),
  tokushima(36, '徳島県'),
  kagawa(37, '香川県'),
  ehime(38, '愛媛県'),
  kochi(39, '高知県'),
  fukuoka(40, '福岡県'),
  saga(41, '佐賀県'),
  nagasaki(42, '長崎県'),
  kumamoto(43, '熊本県'),
  oita(44, '大分県'),
  miyazaki(45, '宮崎県'),
  kagoshima(46, '鹿児島県'),
  okinawa(47, '沖縄県')
  ;

  const JmaPrefecture(this.code, this.name);

  final int code;
  final String name;

  static JmaPrefecture fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}
