import 'package:eqapi_types/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'region.freezed.dart';
part 'region.g.dart';

/// `/v1/earthquake/region` の `$.[*]`
@freezed
class RegionItem with _$RegionItem {
  const factory RegionItem({
    required int id,
    required int eventId,
    required String areaCode,
    required JmaIntensity maxIntensity,
    required JmaLgIntensity? maxLpgmIntensity,
    required EarthquakeV1Base earthquake,
  }) = _RegionItem;

  factory RegionItem.fromJson(Map<String, dynamic> json) =>
      _$RegionItemFromJson(json);
}
