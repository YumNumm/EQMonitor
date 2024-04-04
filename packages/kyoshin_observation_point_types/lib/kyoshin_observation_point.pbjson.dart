//
//  Generated code. Do not modify.
//  source: kyoshin_observation_point.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use kyoshinObservationPointsDescriptor instead')
const KyoshinObservationPoints$json = {
  '1': 'KyoshinObservationPoints',
  '2': [
    {
      '1': 'points',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.KyoshinObservationPoint',
      '10': 'points'
    },
  ],
};

/// Descriptor for `KyoshinObservationPoints`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kyoshinObservationPointsDescriptor =
    $convert.base64Decode(
        'ChhLeW9zaGluT2JzZXJ2YXRpb25Qb2ludHMSMAoGcG9pbnRzGAEgAygLMhguS3lvc2hpbk9ic2'
        'VydmF0aW9uUG9pbnRSBnBvaW50cw==');

@$core.Deprecated('Use kyoshinObservationPointDescriptor instead')
const KyoshinObservationPoint$json = {
  '1': 'KyoshinObservationPoint',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'region', '3': 3, '4': 1, '5': 9, '10': 'region'},
    {
      '1': 'location',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.KyoshinObservationPoint.LatLng',
      '10': 'location'
    },
    {
      '1': 'point',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.KyoshinObservationPoint.Point',
      '10': 'point'
    },
    {'1': 'arv_400', '3': 6, '4': 1, '5': 1, '10': 'arv400'},
  ],
  '3': [
    KyoshinObservationPoint_LatLng$json,
    KyoshinObservationPoint_Point$json
  ],
};

@$core.Deprecated('Use kyoshinObservationPointDescriptor instead')
const KyoshinObservationPoint_LatLng$json = {
  '1': 'LatLng',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
  ],
};

@$core.Deprecated('Use kyoshinObservationPointDescriptor instead')
const KyoshinObservationPoint_Point$json = {
  '1': 'Point',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 5, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 5, '10': 'y'},
  ],
};

/// Descriptor for `KyoshinObservationPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kyoshinObservationPointDescriptor = $convert.base64Decode(
    'ChdLeW9zaGluT2JzZXJ2YXRpb25Qb2ludBISCgRjb2RlGAEgASgJUgRjb2RlEhIKBG5hbWUYAi'
    'ABKAlSBG5hbWUSFgoGcmVnaW9uGAMgASgJUgZyZWdpb24SOwoIbG9jYXRpb24YBCABKAsyHy5L'
    'eW9zaGluT2JzZXJ2YXRpb25Qb2ludC5MYXRMbmdSCGxvY2F0aW9uEjQKBXBvaW50GAUgASgLMh'
    '4uS3lvc2hpbk9ic2VydmF0aW9uUG9pbnQuUG9pbnRSBXBvaW50EhcKB2Fydl80MDAYBiABKAFS'
    'BmFydjQwMBpCCgZMYXRMbmcSGgoIbGF0aXR1ZGUYASABKAFSCGxhdGl0dWRlEhwKCWxvbmdpdH'
    'VkZRgCIAEoAVIJbG9uZ2l0dWRlGiMKBVBvaW50EgwKAXgYASABKAVSAXgSDAoBeRgCIAEoBVIB'
    'eQ==');
