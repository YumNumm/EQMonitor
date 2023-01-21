import 'city.dart';
import 'region.dart';

class ParameterEarthquake {
  ParameterEarthquake({
    required this.responseId,
    required this.responseTime,
    required this.status,
    required this.changeTime,
    required this.version,
    required this.items,
  });

  factory ParameterEarthquake.fromTwoJson(
    Map<String, dynamic> param,
    Map<String, dynamic> paramArv,
  ) {
    final items = <ParameterEarthquakeItem>[];
    final paramItems = param['items'] as List<dynamic>;
    final paramArvItems = paramArv['items'] as List<dynamic>;
    for (final item in paramItems) {
      final arv = (paramArvItems.firstWhere(
        (e) =>
            (item as Map<String, dynamic>)['id'] ==
            (e as Map<String, dynamic>)['id'],
        orElse: () => <String, dynamic>{'arv': '0'},
      ) as Map<String, dynamic>)['arv'] as double;
      items.add(
        ParameterEarthquakeItem.fromJsonWithArv(
          item as Map<String, dynamic>,
          arv,
        ),
      );
    }
    return ParameterEarthquake(
      responseId: param['responseId'].toString(),
      responseTime: DateTime.parse(param['responseTime'].toString()),
      status: param['status'].toString(),
      changeTime: DateTime.parse(param['changeTime'].toString()),
      version: param['version'].toString(),
      items: items,
    );
  }

  factory ParameterEarthquake.fromJson(Map<String, dynamic> j) =>
      ParameterEarthquake(
        responseId: j['responseId'].toString(),
        responseTime: DateTime.parse(j['responseTime'].toString()),
        status: j['status'].toString(),
        changeTime: DateTime.parse(j['changeTime'].toString()),
        version: j['version'].toString(),
        items: List<ParameterEarthquakeItem>.generate(
          (j['items'] as List).length,
          (index) => ParameterEarthquakeItem.fromJson(
            (j['items'] as List)[index] as Map<String, dynamic>,
          ),
        ),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'responseId': responseId,
        'responseTime': responseTime.toIso8601String(),
        'status': status,
        'changeTime': changeTime.toIso8601String(),
        'version': version,
        'items': items.map((e) => e.toJson()).toList(),
      };

  final String responseId;
  final DateTime responseTime;
  final String status;
  final DateTime changeTime;
  final String version;
  final List<ParameterEarthquakeItem> items;
}

class ParameterEarthquakeItem {
  ParameterEarthquakeItem({
    required this.region,
    required this.city,
    required this.noCode,
    required this.code,
    required this.name,
    required this.kana,
    required this.status,
    required this.owner,
    required this.latitude,
    required this.longitude,
    required this.arv,
  });
  factory ParameterEarthquakeItem.fromJsonWithArv(
    Map<String, dynamic> param,
    double arv,
  ) {
    return ParameterEarthquakeItem(
      region: Region.fromJson(param['region'] as Map<String, dynamic>),
      city: City.fromJson(param['city'] as Map<String, dynamic>),
      noCode: int.parse(param['noCode'].toString()),
      code: int.parse(param['code'].toString()),
      name: param['name'].toString(),
      kana: param['kana'].toString(),
      status: param['status'].toString(),
      owner: param['owner'].toString(),
      latitude: double.parse(param['latitude'].toString()),
      longitude: double.parse(param['longitude'].toString()),
      arv: arv,
    );
  }

  factory ParameterEarthquakeItem.fromJson(Map<String, dynamic> j) =>
      ParameterEarthquakeItem(
        region: Region.fromJson(j['region'] as Map<String, dynamic>),
        city: City.fromJson(j['city'] as Map<String, dynamic>),
        noCode: int.parse(j['noCode'].toString()),
        code: int.parse(j['code'].toString()),
        name: j['name'].toString(),
        kana: j['kana'].toString(),
        status: j['status'].toString(),
        owner: j['owner'].toString(),
        latitude: double.parse(j['latitude'].toString()),
        longitude: double.parse(j['longitude'].toString()),
        arv: double.parse(j['arv'].toString()),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'region': region.toJson(),
        'city': city.toJson(),
        'noCode': noCode,
        'code': code,
        'name': name,
        'kana': kana,
        'status': status,
        'owner': owner,
        'latitude': latitude,
        'longitude': longitude,
        'arv': arv,
      };

  final Region region;
  final City city;
  final int noCode;
  final int code;
  final String name;
  final String kana;
  final String status;
  final String owner;
  final double latitude;
  final double longitude;
  final double arv;
}
