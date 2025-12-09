/// JMA Marine Forecast Region.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-55.
enum JmaMarineForecastRegion {
  seaOfJapanNorthOkhotsk(1000, '日本海北部及びオホーツク海南部'),
  sakhalinEast(1010, 'サハリン東方海上'),
  sakhalinWest(1020, 'サハリン西方海上'),
  abashiriOff(1030, '網走沖'),
  soyaStrait(1040, '宗谷海峡'),
  hokkaidoWest(1050, '北海道西方海上'),
  hokkaidoSouthEast(1100, '北海道南方及び東方海上'),
  hokkaidoEast(1110, '北海道東方海上'),
  kushiroOff(1120, '釧路沖'),
  hidakaOff(1130, '日高沖'),
  tsugaruStrait(1140, '津軽海峡'),
  hiyamaTsugaruOff(1150, '檜山津軽沖'),
  sanrikuOff(2000, '三陸沖'),
  sanrikuOffEast(2010, '三陸沖東部'),
  sanrikuOffWest(2020, '三陸沖西部'),
  kantoSea(3000, '関東海域'),
  kantoSeaNorth(3010, '関東海域北部'),
  kantoSeaSouth(3020, '関東海域南部'),
  seaOfJapanCentral(3100, '日本海中部'),
  primorskySouthOff(3110, '沿海州南部沖'),
  akitaOff(3120, '秋田沖'),
  sadoOff(3130, '佐渡沖'),
  notoOff(3140, '能登沖'),
  tokaiSea(3200, '東海海域'),
  tokaiSeaEast(3210, '東海海域東部'),
  tokaiSeaWest(3220, '東海海域西部'),
  tokaiSeaSouth(3230, '東海海域南部'),
  shikokuOffSetonaikai(4000, '四国沖及び瀬戸内海'),
  setonaikai(4010, '瀬戸内海'),
  shikokuOffNorth(4020, '四国沖北部'),
  shikokuOffSouth(4030, '四国沖南部'),
  seaOfJapanWest(4100, '日本海西部'),
  seaOfJapanNorthwest(4110, '日本海北西部'),
  saninOffEastWakasa(4120, '山陰沖東部及び若狭湾付近'),
  saninOffWest(4130, '山陰沖西部'),
  tsushimaStrait(5000, '対馬海峡'),
  kyushuWest(5100, '九州西方海上'),
  jejuWest(5110, '済州島西海上'),
  nagasakiWest(5120, '長崎西海上'),
  meshimaSouthwest(5130, '女島南西海上'),
  kyushuSouthHyuga(5200, '九州南方海上及び日向灘'),
  hyuganada(5210, '日向灘'),
  kagoshimaSea(5220, '鹿児島海域'),
  amamiSea(5230, '奄美海域'),
  okinawaSea(6000, '沖縄海域'),
  eastChinaSeaSouth(6010, '東シナ海南部'),
  okinawaEast(6020, '沖縄東方海上'),
  okinawaSouth(6030, '沖縄南方海上'),
  other(10000, 'その他の地方海上予報区')
  ;

  const JmaMarineForecastRegion(this.code, this.nameJa);

  final int code;
  final String nameJa;

  /// Returns the marine forecast region for the given code.
  ///
  /// Returns null if not found.
  static JmaMarineForecastRegion? fromCode(int code) =>
      JmaMarineForecastRegion.values.where((e) => e.code == code).firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '地方海上予報区(コード番号：$code)';
}
