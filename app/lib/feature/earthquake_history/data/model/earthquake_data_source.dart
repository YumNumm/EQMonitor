import 'package:eqmonitor_api/export.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum EarthquakeDataSource {
  jmaIntensityDatabase,
  jmaDisasterInformationXml,
}

extension EarthquakeDataSourceApiExtension on api.EarthquakeDatasource {
  EarthquakeDataSource get toEarthquakeDataSource => switch (this) {
    .jmaIntensityDatabase => .jmaIntensityDatabase,
    .jmaDisasterInformationXml => .jmaDisasterInformationXml,
  };
}

extension EarthquakeDataSourceToApiExtension on EarthquakeDataSource {
  api.EarthquakeDatasource get toApiEarthquakeDataSource => switch (this) {
    .jmaIntensityDatabase => .jmaIntensityDatabase,
    .jmaDisasterInformationXml => .jmaDisasterInformationXml,
  };
}
