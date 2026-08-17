import 'package:eqmonitor/feature/tsunami/data/model/value/depth_type.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/magnitude_type.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_earthquake_hypocenter.freezed.dart';

/// 津波情報に付随する震源要素のドメインモデル
@freezed
abstract class TsunamiEarthquakeHypocenter with _$TsunamiEarthquakeHypocenter {
  const factory TsunamiEarthquakeHypocenter({
    required MagnitudeType magnitudeType,
    num? magnitudeValue,
    required DepthType depthType,
    num? depthValue,
    String? name,
    double? latitude,
    double? longitude,
  }) = _TsunamiEarthquakeHypocenter;
}

extension HypocenterTsunamiApiExt on api.Hypocenter {
  TsunamiEarthquakeHypocenter toTsunamiEarthquakeHypocenter() =>
      TsunamiEarthquakeHypocenter(
        magnitudeType: magnitude.type.toDomain(),
        magnitudeValue: magnitude.value,
        depthType: depth.type.toDomain(),
        depthValue: depth.value,
        name: name,
        latitude: coordinates?.latitude.toDouble(),
        longitude: coordinates?.longitude.toDouble(),
      );
}
