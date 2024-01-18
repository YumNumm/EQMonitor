//
//  Generated code. Do not modify.
//  source: earthquake_param.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use earthquakeParameterDescriptor instead')
const EarthquakeParameter$json = {
  '1': 'EarthquakeParameter',
  '2': [
    {'1': 'regions', '3': 1, '4': 3, '5': 11, '6': '.EarthquakeParameterRegionItem', '10': 'regions'},
  ],
};

/// Descriptor for `EarthquakeParameter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earthquakeParameterDescriptor = $convert.base64Decode(
    'ChNFYXJ0aHF1YWtlUGFyYW1ldGVyEjgKB3JlZ2lvbnMYASADKAsyHi5FYXJ0aHF1YWtlUGFyYW'
    '1ldGVyUmVnaW9uSXRlbVIHcmVnaW9ucw==');

@$core.Deprecated('Use earthquakeParameterRegionItemDescriptor instead')
const EarthquakeParameterRegionItem$json = {
  '1': 'EarthquakeParameterRegionItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'cities', '3': 3, '4': 3, '5': 11, '6': '.EarthquakeParameterCityItem', '10': 'cities'},
  ],
};

/// Descriptor for `EarthquakeParameterRegionItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earthquakeParameterRegionItemDescriptor = $convert.base64Decode(
    'Ch1FYXJ0aHF1YWtlUGFyYW1ldGVyUmVnaW9uSXRlbRISCgRjb2RlGAEgASgJUgRjb2RlEhIKBG'
    '5hbWUYAiABKAlSBG5hbWUSNAoGY2l0aWVzGAMgAygLMhwuRWFydGhxdWFrZVBhcmFtZXRlckNp'
    'dHlJdGVtUgZjaXRpZXM=');

@$core.Deprecated('Use earthquakeParameterCityItemDescriptor instead')
const EarthquakeParameterCityItem$json = {
  '1': 'EarthquakeParameterCityItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'stations', '3': 3, '4': 3, '5': 11, '6': '.EarthquakeParameterStationItem', '10': 'stations'},
  ],
};

/// Descriptor for `EarthquakeParameterCityItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earthquakeParameterCityItemDescriptor = $convert.base64Decode(
    'ChtFYXJ0aHF1YWtlUGFyYW1ldGVyQ2l0eUl0ZW0SEgoEY29kZRgBIAEoCVIEY29kZRISCgRuYW'
    '1lGAIgASgJUgRuYW1lEjsKCHN0YXRpb25zGAMgAygLMh8uRWFydGhxdWFrZVBhcmFtZXRlclN0'
    'YXRpb25JdGVtUghzdGF0aW9ucw==');

@$core.Deprecated('Use earthquakeParameterStationItemDescriptor instead')
const EarthquakeParameterStationItem$json = {
  '1': 'EarthquakeParameterStationItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'latitude', '3': 3, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 4, '4': 1, '5': 1, '10': 'longitude'},
  ],
};

/// Descriptor for `EarthquakeParameterStationItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earthquakeParameterStationItemDescriptor = $convert.base64Decode(
    'Ch5FYXJ0aHF1YWtlUGFyYW1ldGVyU3RhdGlvbkl0ZW0SEgoEY29kZRgBIAEoCVIEY29kZRISCg'
    'RuYW1lGAIgASgJUgRuYW1lEhoKCGxhdGl0dWRlGAMgASgBUghsYXRpdHVkZRIcCglsb25naXR1'
    'ZGUYBCABKAFSCWxvbmdpdHVkZQ==');

