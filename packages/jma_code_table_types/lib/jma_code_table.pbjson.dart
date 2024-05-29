//
//  Generated code. Do not modify.
//  source: jma_code_table.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use jmaCodeTableDescriptor instead')
const JmaCodeTable$json = {
  '1': 'JmaCodeTable',
  '2': [
    {'1': 'area_forecast_local_eew', '3': 22, '4': 1, '5': 11, '6': '.AreaForecastLocalEew', '10': 'areaForecastLocalEew'},
    {'1': 'area_information_prefecture_earthquake', '3': 23, '4': 1, '5': 11, '6': '.AreaInformationPrefectureEarthquake', '10': 'areaInformationPrefectureEarthquake'},
    {'1': 'area_epicenter', '3': 41, '4': 1, '5': 11, '6': '.AreaEpicenter', '10': 'areaEpicenter'},
    {'1': 'area_epicenter_abbreviation', '3': 42, '4': 1, '5': 11, '6': '.AreaEpicenterAbbreviation', '10': 'areaEpicenterAbbreviation'},
    {'1': 'area_epicenter_detail', '3': 43, '4': 1, '5': 11, '6': '.AreaEpicenterDetail', '10': 'areaEpicenterDetail'},
  ],
};

/// Descriptor for `JmaCodeTable`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jmaCodeTableDescriptor = $convert.base64Decode(
    'CgxKbWFDb2RlVGFibGUSTAoXYXJlYV9mb3JlY2FzdF9sb2NhbF9lZXcYFiABKAsyFS5BcmVhRm'
    '9yZWNhc3RMb2NhbEVld1IUYXJlYUZvcmVjYXN0TG9jYWxFZXcSeQomYXJlYV9pbmZvcm1hdGlv'
    'bl9wcmVmZWN0dXJlX2VhcnRocXVha2UYFyABKAsyJC5BcmVhSW5mb3JtYXRpb25QcmVmZWN0dX'
    'JlRWFydGhxdWFrZVIjYXJlYUluZm9ybWF0aW9uUHJlZmVjdHVyZUVhcnRocXVha2USNQoOYXJl'
    'YV9lcGljZW50ZXIYKSABKAsyDi5BcmVhRXBpY2VudGVyUg1hcmVhRXBpY2VudGVyEloKG2FyZW'
    'FfZXBpY2VudGVyX2FiYnJldmlhdGlvbhgqIAEoCzIaLkFyZWFFcGljZW50ZXJBYmJyZXZpYXRp'
    'b25SGWFyZWFFcGljZW50ZXJBYmJyZXZpYXRpb24SSAoVYXJlYV9lcGljZW50ZXJfZGV0YWlsGC'
    'sgASgLMhQuQXJlYUVwaWNlbnRlckRldGFpbFITYXJlYUVwaWNlbnRlckRldGFpbA==');

@$core.Deprecated('Use areaForecastLocalEewDescriptor instead')
const AreaForecastLocalEew$json = {
  '1': 'AreaForecastLocalEew',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.AreaForecastLocalEew.AreaForecastLocalEewItem', '10': 'items'},
  ],
  '3': [AreaForecastLocalEew_AreaForecastLocalEewItem$json],
};

@$core.Deprecated('Use areaForecastLocalEewDescriptor instead')
const AreaForecastLocalEew_AreaForecastLocalEewItem$json = {
  '1': 'AreaForecastLocalEewItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'name_kana', '3': 3, '4': 1, '5': 9, '10': 'nameKana'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `AreaForecastLocalEew`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List areaForecastLocalEewDescriptor = $convert.base64Decode(
    'ChRBcmVhRm9yZWNhc3RMb2NhbEVldxJECgVpdGVtcxgBIAMoCzIuLkFyZWFGb3JlY2FzdExvY2'
    'FsRWV3LkFyZWFGb3JlY2FzdExvY2FsRWV3SXRlbVIFaXRlbXMagQEKGEFyZWFGb3JlY2FzdExv'
    'Y2FsRWV3SXRlbRISCgRjb2RlGAEgASgJUgRjb2RlEhIKBG5hbWUYAiABKAlSBG5hbWUSGwoJbm'
    'FtZV9rYW5hGAMgASgJUghuYW1lS2FuYRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRp'
    'b24=');

@$core.Deprecated('Use areaInformationPrefectureEarthquakeDescriptor instead')
const AreaInformationPrefectureEarthquake$json = {
  '1': 'AreaInformationPrefectureEarthquake',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.AreaInformationPrefectureEarthquake.AreaInformationPrefectureEarthquakeItem', '10': 'items'},
  ],
  '3': [AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem$json],
};

@$core.Deprecated('Use areaInformationPrefectureEarthquakeDescriptor instead')
const AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem$json = {
  '1': 'AreaInformationPrefectureEarthquakeItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AreaInformationPrefectureEarthquake`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List areaInformationPrefectureEarthquakeDescriptor = $convert.base64Decode(
    'CiNBcmVhSW5mb3JtYXRpb25QcmVmZWN0dXJlRWFydGhxdWFrZRJiCgVpdGVtcxgBIAMoCzJMLk'
    'FyZWFJbmZvcm1hdGlvblByZWZlY3R1cmVFYXJ0aHF1YWtlLkFyZWFJbmZvcm1hdGlvblByZWZl'
    'Y3R1cmVFYXJ0aHF1YWtlSXRlbVIFaXRlbXMaUQonQXJlYUluZm9ybWF0aW9uUHJlZmVjdHVyZU'
    'VhcnRocXVha2VJdGVtEhIKBGNvZGUYASABKAlSBGNvZGUSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use areaEpicenterDescriptor instead')
const AreaEpicenter$json = {
  '1': 'AreaEpicenter',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.AreaEpicenter.AreaEpicenterItem', '10': 'items'},
  ],
  '3': [AreaEpicenter_AreaEpicenterItem$json],
};

@$core.Deprecated('Use areaEpicenterDescriptor instead')
const AreaEpicenter_AreaEpicenterItem$json = {
  '1': 'AreaEpicenterItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AreaEpicenter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List areaEpicenterDescriptor = $convert.base64Decode(
    'Cg1BcmVhRXBpY2VudGVyEjYKBWl0ZW1zGAEgAygLMiAuQXJlYUVwaWNlbnRlci5BcmVhRXBpY2'
    'VudGVySXRlbVIFaXRlbXMaOwoRQXJlYUVwaWNlbnRlckl0ZW0SEgoEY29kZRgBIAEoCVIEY29k'
    'ZRISCgRuYW1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use areaEpicenterAbbreviationDescriptor instead')
const AreaEpicenterAbbreviation$json = {
  '1': 'AreaEpicenterAbbreviation',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.AreaEpicenterAbbreviation.AreaEpicenterAbbreviationItem', '10': 'items'},
  ],
  '3': [AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem$json],
};

@$core.Deprecated('Use areaEpicenterAbbreviationDescriptor instead')
const AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem$json = {
  '1': 'AreaEpicenterAbbreviationItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AreaEpicenterAbbreviation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List areaEpicenterAbbreviationDescriptor = $convert.base64Decode(
    'ChlBcmVhRXBpY2VudGVyQWJicmV2aWF0aW9uEk4KBWl0ZW1zGAEgAygLMjguQXJlYUVwaWNlbn'
    'RlckFiYnJldmlhdGlvbi5BcmVhRXBpY2VudGVyQWJicmV2aWF0aW9uSXRlbVIFaXRlbXMaRwod'
    'QXJlYUVwaWNlbnRlckFiYnJldmlhdGlvbkl0ZW0SEgoEY29kZRgBIAEoCVIEY29kZRISCgRuYW'
    '1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use areaEpicenterDetailDescriptor instead')
const AreaEpicenterDetail$json = {
  '1': 'AreaEpicenterDetail',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.AreaEpicenterDetail.AreaEpicenterDetailItem', '10': 'items'},
  ],
  '3': [AreaEpicenterDetail_AreaEpicenterDetailItem$json],
};

@$core.Deprecated('Use areaEpicenterDetailDescriptor instead')
const AreaEpicenterDetail_AreaEpicenterDetailItem$json = {
  '1': 'AreaEpicenterDetailItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AreaEpicenterDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List areaEpicenterDetailDescriptor = $convert.base64Decode(
    'ChNBcmVhRXBpY2VudGVyRGV0YWlsEkIKBWl0ZW1zGAEgAygLMiwuQXJlYUVwaWNlbnRlckRldG'
    'FpbC5BcmVhRXBpY2VudGVyRGV0YWlsSXRlbVIFaXRlbXMaQQoXQXJlYUVwaWNlbnRlckRldGFp'
    'bEl0ZW0SEgoEY29kZRgBIAEoCVIEY29kZRISCgRuYW1lGAIgASgJUgRuYW1l');

