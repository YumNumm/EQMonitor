// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_link_match_method.dart';

part 'catalog_link.freezed.dart';
part 'catalog_link.g.dart';

@Freezed()
abstract class CatalogLink with _$CatalogLink {
  const factory CatalogLink({
    @JsonKey(name: 'match_confidence')
    required num matchConfidence,
    @JsonKey(name: 'match_method')
    required CatalogLinkMatchMethod matchMethod,
    @JsonKey(name: 'time_diff_seconds')
    required num timeDiffSeconds,
    @JsonKey(includeIfNull: true,name: 'distance_km')
    required num? distanceKm,
  }) = _CatalogLink;

  factory CatalogLink.fromJson(Map<String, Object?> json) => _$CatalogLinkFromJson(json);
}
