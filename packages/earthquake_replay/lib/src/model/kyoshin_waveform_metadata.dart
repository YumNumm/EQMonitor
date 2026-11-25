import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_waveform_metadata.freezed.dart';
part 'kyoshin_waveform_metadata.g.dart';

// バックエンドの地震アーカイブが Union 1005 に入れる JSON。キーは camelCase。
@freezed
abstract class KyoshinWaveformMetadata with _$KyoshinWaveformMetadata {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory({
    required String network,
    required String component,
    required String stationCode,
    required double stationLatitude,
    required double stationLongitude,
    required double stationHeightMeters,
    required DateTime recordTime,
    required DateTime startTime,
    required int samplingHz,
    required String direction,
    required double scaleNumeratorGal,
    required double scaleDenominator,
    required double maxAccelerationGal,
  }) = _KyoshinWaveformMetadata;

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinWaveformMetadataFromJson(json);
}
