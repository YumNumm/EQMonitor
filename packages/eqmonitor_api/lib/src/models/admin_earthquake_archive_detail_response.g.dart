// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'admin_earthquake_archive_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminEarthquakeArchiveDetailResponse
_$AdminEarthquakeArchiveDetailResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AdminEarthquakeArchiveDetailResponse', json, (
      $checkedConvert,
    ) {
      final val = _AdminEarthquakeArchiveDetailResponse(
        item: $checkedConvert(
          'item',
          (v) => EarthquakeArchive.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AdminEarthquakeArchiveDetailResponseToJson(
  _AdminEarthquakeArchiveDetailResponse instance,
) => <String, dynamic>{'item': instance.item};
