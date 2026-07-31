import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';

EarthquakePartialNormal testActivityEarthquake({
  required String eventId,
  required DateTime? originTime,
  double latitude = 35,
  double longitude = 139,
  EarthquakeDepth depth = const EarthquakeDepth.value(value: 40),
  EarthquakeMagnitude magnitude = const EarthquakeMagnitude.value(value: 4),
  JmaIntensity? maxIntensity,
  EarthquakeType earthquakeType = EarthquakeType.normal,
}) => EarthquakePartialNormal(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: originTime,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  hypocenter: EarthquakeHypocenter(
    code: '001',
    name: 'テスト震源',
    coordinates: Coordinate.latLng(latitude: latitude, longitude: longitude),
    magnitude: magnitude,
    depth: depth,
    detailedCode: null,
    detailedName: null,
  ),
  intensity: maxIntensity == null
      ? null
      : EarthquakeIntensityPartial(
          maxIntensity: maxIntensity,
          maxLpgmIntensity: null,
        ),
  earthquakeType: earthquakeType,
  telegramTypes: const [],
  estimatedIntensityTileUrl: null,
);
