import './city.dart';
import './region.dart';

class ParameterEarthquake {
  ParameterEarthquake({
    required this.responseId,
    required this.responseTime,
    required this.status,
    required this.changeTime,
    required this.version,
    required this.items,
  });

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

  factory ParameterEarthquakeItem.fromJson(Map<String, dynamic> j) =>
      ParameterEarthquakeItem(
        region: Region.fromJson(j['region']),
        city: City.fromJson(j['city']),
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
