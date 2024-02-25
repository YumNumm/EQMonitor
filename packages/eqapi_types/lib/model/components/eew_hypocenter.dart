import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'eew_hypocenter.freezed.dart';
part 'eew_hypocenter.g.dart';

@freezed
class EewHypocenter with _$EewHypocenter {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory EewHypocenter({
    required LatLng? coordinate,
    required String code,
    required String name,
  }) = _EewHypocenter;

  factory EewHypocenter.fromJson(Map<String, dynamic> json) =>
      _$EewHypocenterFromJson(json);
}
