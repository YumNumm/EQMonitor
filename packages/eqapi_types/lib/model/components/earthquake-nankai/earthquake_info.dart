import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_info.freezed.dart';
part 'earthquake_info.g.dart';

@freezed
class EarthquakeNankaiInfo with _$EarthquakeNankaiInfo {
  const factory EarthquakeNankaiInfo({
    required String text,
    required String? appendix,
    required EarthquakeNankaiKind? kind,
  }) = _EarthquakeNankaiInfo;

  factory EarthquakeNankaiInfo.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeNankaiInfoFromJson(json);
}

@freezed
class EarthquakeNankaiKind with _$EarthquakeNankaiKind {
  const factory EarthquakeNankaiKind({
    required String code,
    required String name,
  }) = _EarthquakeNankaiKind;

  factory EarthquakeNankaiKind.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeNankaiKindFromJson(json);
}
