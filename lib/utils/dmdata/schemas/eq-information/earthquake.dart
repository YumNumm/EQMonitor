/// ## Earthquake component
/// 地震情報・津波情報における地震の発生位置、規模を記載。
class EarthQuakeInformationComponent {
  EarthQuakeInformationComponent({
    required this.originTime,
    required this.arrivalTime,
    required this.hypoCenter,
    required this.magnitude,
  });
  EarthQuakeInformationComponent.fromJson(Map<String, dynamic> j)
      : originTime = DateTime.parse(j['originTime'].toString()),
        arrivalTime = DateTime.parse(j['arrivalTime'].toString()),
        hypoCenter = EarthQuakeInformationHypoCenter.fromJson(
          j['hypocenter'] as Map<String, dynamic>,
        ),
        magnitude = Magnitude.fromJson(j['magnitude'] as Map<String, dynamic>);

  /// 地震発生時刻を分単位で、ISO8601の日本時間で記載する
  final DateTime originTime;

  /// 地震検知時刻を分単位で、ISO8601の日本時間で記載する
  final DateTime arrivalTime;

  /// 地震の震源要素
  /// [#3. hypocenter](https://dmdata.jp/doc/reference/conversion/json/component/#3-hypocenter)
  final EarthQuakeInformationHypoCenter hypoCenter;

  /// 地震の規模
  /// [#4. magnitude](https://dmdata.jp/doc/reference/conversion/json/component/#4-magnitude)
  final Magnitude magnitude;
}

class EarthQuakeInformationHypoCenter {
  EarthQuakeInformationHypoCenter({
    required this.name,
    required this.code,
    required this.coordinateComponent,
    required this.depth,
    required this.detailed,
    required this.auxiliary,
    required this.source,
  });
  EarthQuakeInformationHypoCenter.fromJson(Map<String, dynamic> j)
      : name = j['name'].toString(),
        code = int.parse(j['code'].toString()),
        depth = Depth.fromJson(j['depth'] as Map<String, dynamic>),
        coordinateComponent = CoordinateComponent.fromJson(
          j['coordinate'] as Map<String, dynamic>,
        ),
        detailed = (j['detailed'] == null)
            ? null
            : Detailed.fromJson(j['detailed'] as Map<String, dynamic>),
        auxiliary = (j['auxiliary'] == null)
            ? null
            : Auxiliary.fromJson(j['auxiliary'] as Map<String, dynamic>),
        source = (j['source'] == null)
            ? null
            : (j['source'].toString() == 'ＵＳＧＳ')
                ? HypoCenterSource.USGS
                : (j['source'].toString() == 'ＰＴＷＣ')
                    ? HypoCenterSource.PTWC
                    : HypoCenterSource.WCATWC;

  /// ## 震央地名
  final String name;

  /// ## 震央地名コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// ## 震源地の空間座標
  /// [#Coordinate component](https://dmdata.jp/doc/reference/conversion/json/component/#coordinate-component)を参照
  final CoordinateComponent coordinateComponent;

  /// ## 深さ情報
  /// [#3.4.depth](https://dmdata.jp/doc/reference/conversion/json/component/#3-4-depth)を参照
  final Depth depth;

  /// ##震源地の詳細
  /// [#3.5.detailed](https://dmdata.jp/doc/reference/conversion/json/component/#3-5-detailed)を参照
  final Detailed? detailed;

  /// 震源位置の補足情報 [#3.6.auxiliary](https://dmdata.jp/doc/reference/conversion/json/component/#3-6-auxiliary)を参照
  final Auxiliary? auxiliary;

  /// 震源・規模のデータソース。取りうる値は`ＵＳＧＳ`,`ＰＴＷＣ`,`ＷＣＡＴＷＣ`
  /// 遠地地震で、気象庁以外が震源決定した場合に出現
  final HypoCenterSource? source;
}

/// ## Coordinate component
/// 空間座標のある一点を表現する。
class CoordinateComponent {
  CoordinateComponent({
    required this.latitude,
    required this.longitude,
    required this.height,
    required this.geodeticSystem,
    required this.condition,
  });
  CoordinateComponent.fromJson(Map<String, dynamic> j)
      : latitude = (j['latitude'] == null)
            ? null
            : Latitude.fromJson(j['latitude'] as Map<String, dynamic>),
        longitude = (j['longitude'] == null)
            ? null
            : Longitude.fromJson(j['longitude'] as Map<String, dynamic>),
        height = (j['height'] == null)
            ? null
            : Height.fromJson(j['height'] as Map<String, dynamic>),
        geodeticSystem = (j['geodeticSystem'] == null)
            ? null
            : (j['geodeticSystem'].toString() == '世界測地系')
                ? GeodeticSystem.WorldGeodeticSystem
                : GeodeticSystem.JapaneseGeodeticSystem,
        condition = (j['condition'] == null) ? null : j['condition'].toString();

  /// 緯度を表現
  final Latitude? latitude;

  /// 経度を表現
  final Longitude? longitude;

  /// 高さを表現
  final Height? height;

  /// `世界測地系`または`日本測地系`が入る
  final GeodeticSystem? geodeticSystem;

  /// 緯度経度が不明な場合は`不明`が入る、その他電文定義により文字列が出現する
  final String? condition;
}

class Latitude {
  Latitude({
    required this.text,
    required this.value,
  });
  Latitude.fromJson(Map<String, dynamic> j)
      : text = j['text'].toString(),
        value = double.parse(j['value'].toString());

  /// 緯度をテキスト文で表現する
  final String text;

  /// 緯度を10進数法、単位度で表現する
  final double value;
}

class Longitude {
  Longitude({
    required this.text,
    required this.value,
  });
  Longitude.fromJson(Map<String, dynamic> j)
      : text = j['text'].toString(),
        value = double.parse(j['value'].toString());

  /// 経度をテキスト文で表現する
  final String text;

  /// 経度を10進数法、単位度で表現する
  final double value;
}

class Height {
  Height({
    required this.type,
    required this.unit,
    required this.value,
  });
  Height.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        unit = j['unit'].toString(),
        value = double.parse(j['value'].toString());

  /// `高さ`で固定
  final String type;

  /// 高さ情報の単位`m`で固定
  final String unit;

  /// 高さの数値
  final double value;
}

enum GeodeticSystem {
  /// 世界測地系
  WorldGeodeticSystem,

  /// 日本測地系
  JapaneseGeodeticSystem,
}

/// ## 震源の深さ
class Depth {
  Depth({
    required this.type,
    required this.unit,
    required this.value,
    required this.condition,
  });
  Depth.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        unit = j['unit'].toString(),
        value = (j['value'] == null) ? null : int.parse(j['value'].toString()),
        condition = (j['condition'] == null)
            ? null
            : (j['condition'] == 'ごく浅い')
                ? DepthCondition.VeryShallow
                : (j['condition'] == '７００ｋｍ以上')
                    ? DepthCondition.MoreThan700km
                    : DepthCondition.Undefined;

  /// 深さ情報のタイプ。`深さ`で固定
  final String type;

  /// 深さ情報の単位。`km`で固定
  final String unit;

  /// 震源の深さ。不明時は`Null`とする
  final int? value;

  /// 深さの例外的表現。取りうる値は`ごく浅い`、`７００ｋｍ以上`,`不明`
  final DepthCondition? condition;
}

enum DepthCondition {
  /// `ごく浅い`
  VeryShallow('ごく浅い'),

  /// `７００ｋｍ以上`
  MoreThan700km('700km以上'),

  /// `不明`
  Undefined('不明');

  const DepthCondition(this.explain);
  final String explain;
}

/// ## 震央地名を補足する詳細震央地名。
/// 遠地地震情報で出現します。
class Detailed {
  Detailed({
    required this.code,
    required this.name,
  });
  Detailed.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString();
  final int code;
  final String name;
}

/// ## 震源位置の補足情報。
/// 対象の地震により津波注意報などが発表される状況下で、`VXSE53`または`VTSE41`,`VTSE51`,`VTSE52`のみに出現する。
class Auxiliary {
  Auxiliary({
    required this.text,
    required this.code,
    required this.name,
    required this.direction,
    required this.distance,
  });
  Auxiliary.fromJson(Map<String, dynamic> j)
      : text = j['text'].toString(),
        code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        direction = j['direction'].toString(),
        distance = Distance.fromJson(j['distance'] as Map<String, dynamic>);

  /// 震源位置の捕捉位置を記載
  final String text;

  /// 震源位置の捕捉位置を表現する代表地域コード
  /// コードは、気象庁防災情報XMLフォーマット
  /// コード表 地震火山関連コード表 による
  final int code;

  /// 震源位置の捕捉位置を表現する代表地域名
  final String name;

  /// 代表地域から震源への方角を16方位で表現
  final String direction;

  /// 代表地域と震源の距離情報
  final Distance distance;
}

/// ## 代表地域と震源の距離情報
class Distance {
  Distance({
    required this.unit,
    required this.value,
  });
  Distance.fromJson(Map<String, dynamic> j)
      : unit = j['unit'].toString(),
        value = int.parse(j['value'].toString());

  /// 距離情報の単位。`km`で固定
  final String unit;

  /// 代表地域と震源の距離
  final int value;
}

enum HypoCenterSource {
  USGS,
  PTWC,
  WCATWC,
}

// ## 地震の規模(マグニチュード)
class Magnitude {
  Magnitude({
    required this.type,
    required this.unit,
    required this.value,
    required this.condition,
  });
  Magnitude.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        unit = j['unit'].toString(),
        value =
            (j['value'] == null) ? null : double.parse(j['value'].toString()),
        condition = (j['condition'] == null)
            ? null
            : (j['condition'].toString() == 'Ｍ不明')
                ? MagnitudeCondition.Undefined
                : MagnitudeCondition.HugeEarthquakeExceedingM8;

  /// `マグニチュード`で固定
  final String type;

  /// マグニチュードの種別。`Mj`または`M`が入る
  final String unit;

  /// マグニチュードの数値。不明時またはM8以上の巨大地震と推測される場合は`Null`とする
  final double? value;

  /// マグニチュードの数値が求まらない事項を記載。`Ｍ不明`又は`Ｍ８を超える巨大地震`が入る
  final MagnitudeCondition? condition;
}

enum MagnitudeCondition {
  /// `Ｍ不明`
  Undefined('不明'),

  /// `Ｍ８を超える巨大地震`
  HugeEarthquakeExceedingM8('M8を超える巨大地震');

  const MagnitudeCondition(this.explain);
  final String explain;
}
