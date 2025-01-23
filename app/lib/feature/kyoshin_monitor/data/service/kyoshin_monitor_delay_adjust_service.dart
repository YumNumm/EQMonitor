enum KyoshinMonitorDelayAdjustType {
  /// latest.jsonの値をそのまま使う
  latestJson,

  /// latest.jsonを複数回取得し、変化した時にその値を使う
  latestJsonMultiple,

  /// 画像取得APIで404が返ってきたら、内部の遅延カウンタを増やす (DateTime.now())
  imageFetch404DeviceTime,

  /// 画像取得APIで404が返ってきたら、内部の遅延カウンタを増やす (NTPサーバーを基準にしている)
  imageFetch404Ntp,
  ;
}

abstract class KyoshinMonitorDelayAdjustService {
  
}
