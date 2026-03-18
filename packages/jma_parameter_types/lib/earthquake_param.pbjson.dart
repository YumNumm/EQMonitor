// This is a generated file - do not edit.
//
// Generated from earthquake_param.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use stationStatusDescriptor instead')
const StationStatus$json = {
  '1': 'StationStatus',
  '2': [
    {'1': 'OPERATIONAL', '2': 0},
    {'1': 'CHANGE', '2': 1},
    {'1': 'CREATED', '2': 2},
    {'1': 'DISCONTINUED', '2': 3},
  ],
};

/// Descriptor for `StationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List stationStatusDescriptor = $convert.base64Decode(
    'Cg1TdGF0aW9uU3RhdHVzEg8KC09QRVJBVElPTkFMEAASCgoGQ0hBTkdFEAESCwoHQ1JFQVRFRB'
    'ACEhAKDERJU0NPTlRJTlVFRBAD');

@$core.Deprecated('Use stationOwnerDescriptor instead')
const StationOwner$json = {
  '1': 'StationOwner',
  '2': [
    {'1': 'JMA', '2': 0},
    {'1': 'PREFECTURE', '2': 1},
    {'1': 'CITY', '2': 2},
    {'1': 'NIED', '2': 3},
    {'1': 'OTHERS', '2': 100},
  ],
};

/// Descriptor for `StationOwner`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List stationOwnerDescriptor = $convert.base64Decode(
    'CgxTdGF0aW9uT3duZXISBwoDSk1BEAASDgoKUFJFRkVDVFVSRRABEggKBENJVFkQAhIICgROSU'
    'VEEAMSCgoGT1RIRVJTEGQ=');

@$core.Deprecated('Use earthquakeParameterDescriptor instead')
const EarthquakeParameter$json = {
  '1': 'EarthquakeParameter',
  '2': [
    {
      '1': 'header',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.EarthquakeParameterHeader',
      '10': 'header'
    },
    {
      '1': 'regions',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.EarthquakeParameterRegionItem',
      '10': 'regions'
    },
  ],
};

/// Descriptor for `EarthquakeParameter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earthquakeParameterDescriptor = $convert.base64Decode(
    'ChNFYXJ0aHF1YWtlUGFyYW1ldGVyEjIKBmhlYWRlchgBIAEoCzIaLkVhcnRocXVha2VQYXJhbW'
    'V0ZXJIZWFkZXJSBmhlYWRlchI4CgdyZWdpb25zGAIgAygLMh4uRWFydGhxdWFrZVBhcmFtZXRl'
    'clJlZ2lvbkl0ZW1SB3JlZ2lvbnM=');

@$core.Deprecated('Use earthquakeParameterHeaderDescriptor instead')
const EarthquakeParameterHeader$json = {
  '1': 'EarthquakeParameterHeader',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 9, '10': 'version'},
    {'1': 'changeTime', '3': 2, '4': 1, '5': 9, '10': 'changeTime'},
  ],
};

/// Descriptor for `EarthquakeParameterHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earthquakeParameterHeaderDescriptor =
    $convert.base64Decode(
        'ChlFYXJ0aHF1YWtlUGFyYW1ldGVySGVhZGVyEhgKB3ZlcnNpb24YASABKAlSB3ZlcnNpb24SHg'
        'oKY2hhbmdlVGltZRgCIAEoCVIKY2hhbmdlVGltZQ==');

@$core.Deprecated('Use earthquakeParameterRegionItemDescriptor instead')
const EarthquakeParameterRegionItem$json = {
  '1': 'EarthquakeParameterRegionItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'nameKana', '3': 3, '4': 1, '5': 9, '10': 'nameKana'},
    {
      '1': 'cities',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.EarthquakeParameterCityItem',
      '10': 'cities'
    },
  ],
};

/// Descriptor for `EarthquakeParameterRegionItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earthquakeParameterRegionItemDescriptor =
    $convert.base64Decode(
        'Ch1FYXJ0aHF1YWtlUGFyYW1ldGVyUmVnaW9uSXRlbRISCgRjb2RlGAEgASgJUgRjb2RlEhIKBG'
        '5hbWUYAiABKAlSBG5hbWUSGgoIbmFtZUthbmEYAyABKAlSCG5hbWVLYW5hEjQKBmNpdGllcxgE'
        'IAMoCzIcLkVhcnRocXVha2VQYXJhbWV0ZXJDaXR5SXRlbVIGY2l0aWVz');

@$core.Deprecated('Use earthquakeParameterCityItemDescriptor instead')
const EarthquakeParameterCityItem$json = {
  '1': 'EarthquakeParameterCityItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'nameKana', '3': 3, '4': 1, '5': 9, '10': 'nameKana'},
    {
      '1': 'stations',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.EarthquakeParameterStationItem',
      '10': 'stations'
    },
  ],
};

/// Descriptor for `EarthquakeParameterCityItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earthquakeParameterCityItemDescriptor =
    $convert.base64Decode(
        'ChtFYXJ0aHF1YWtlUGFyYW1ldGVyQ2l0eUl0ZW0SEgoEY29kZRgBIAEoCVIEY29kZRISCgRuYW'
        '1lGAIgASgJUgRuYW1lEhoKCG5hbWVLYW5hGAMgASgJUghuYW1lS2FuYRI7CghzdGF0aW9ucxgE'
        'IAMoCzIfLkVhcnRocXVha2VQYXJhbWV0ZXJTdGF0aW9uSXRlbVIIc3RhdGlvbnM=');

@$core.Deprecated('Use earthquakeParameterStationItemDescriptor instead')
const EarthquakeParameterStationItem$json = {
  '1': 'EarthquakeParameterStationItem',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'nameKana', '3': 3, '4': 1, '5': 9, '10': 'nameKana'},
    {'1': 'latitude', '3': 4, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 5, '4': 1, '5': 1, '10': 'longitude'},
    {
      '1': 'status',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.StationStatus',
      '10': 'status'
    },
    {
      '1': 'owner',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.StationOwner',
      '10': 'owner'
    },
    {'1': 'arv_400', '3': 8, '4': 1, '5': 1, '10': 'arv400'},
  ],
};

/// Descriptor for `EarthquakeParameterStationItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earthquakeParameterStationItemDescriptor = $convert.base64Decode(
    'Ch5FYXJ0aHF1YWtlUGFyYW1ldGVyU3RhdGlvbkl0ZW0SEgoEY29kZRgBIAEoCVIEY29kZRISCg'
    'RuYW1lGAIgASgJUgRuYW1lEhoKCG5hbWVLYW5hGAMgASgJUghuYW1lS2FuYRIaCghsYXRpdHVk'
    'ZRgEIAEoAVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAUgASgBUglsb25naXR1ZGUSJgoGc3RhdH'
    'VzGAYgASgOMg4uU3RhdGlvblN0YXR1c1IGc3RhdHVzEiMKBW93bmVyGAcgASgOMg0uU3RhdGlv'
    'bk93bmVyUgVvd25lchIXCgdhcnZfNDAwGAggASgBUgZhcnY0MDA=');
