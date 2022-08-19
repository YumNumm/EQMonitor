import 'coordinate_component/geodetic_system.dart';
import 'coordinate_component/height.dart';
import 'coordinate_component/latitude.dart';
import 'coordinate_component/longitude.dart';

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
            : GeodeticSystem.values.firstWhere(
                (element) =>
                    element.description == j['geodeticSystem'].toString(),
              ),
        condition = j['condition']?.toString();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'latitude': latitude?.toJson(),
        'longitude': longitude?.toJson(),
        'height': height?.toJson(),
        'geodeticSystem': geodeticSystem?.description,
        'condition': condition,
      };

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
