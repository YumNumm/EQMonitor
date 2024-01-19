//
//  Generated code. Do not modify.
//  source: jma_map.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap$json = {
  '1': 'JmaMap',
  '2': [
    {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData', '10': 'data'},
  ],
  '3': [JmaMap_JmaMapData$json],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_JmaMapData$json = {
  '1': 'JmaMapData',
  '2': [
    {'1': 'mapType', '3': 1, '4': 1, '5': 14, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData.JmaMapType', '10': 'mapType'},
    {'1': 'data', '3': 2, '4': 3, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData.JmaMapDataItem', '10': 'data'},
  ],
  '3': [JmaMap_JmaMapData_JmaMapDataItem$json],
  '4': [JmaMap_JmaMapData_JmaMapType$json],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_JmaMapData_JmaMapDataItem$json = {
  '1': 'JmaMapDataItem',
  '2': [
    {'1': 'bounds', '3': 1, '4': 1, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.LatLngBounds', '10': 'bounds'},
    {'1': 'property', '3': 2, '4': 1, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData.JmaMapDataItem.Property', '10': 'property'},
  ],
  '3': [JmaMap_JmaMapData_JmaMapDataItem_Property$json],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_JmaMapData_JmaMapDataItem_Property$json = {
  '1': 'Property',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'nameKana', '3': 3, '4': 1, '5': 9, '10': 'nameKana'},
  ],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_JmaMapData_JmaMapType$json = {
  '1': 'JmaMapType',
  '2': [
    {'1': 'AREA_FORECAST_LOCAL_EEW', '2': 0},
    {'1': 'AREA_FORECAST_LOCAL_E', '2': 1},
    {'1': 'AREA_INFORMATION_CITY', '2': 2},
    {'1': 'AREA_TSUNAMI', '2': 3},
  ],
};

/// Descriptor for `JmaMap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jmaMapDescriptor = $convert.base64Decode(
    'CgZKbWFNYXASRAoEZGF0YRgBIAMoCzIwLm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLk'
    'ptYU1hcC5KbWFNYXBEYXRhUgRkYXRhGrkECgpKbWFNYXBEYXRhElUKB21hcFR5cGUYASABKA4y'
    'Oy5uZXQueXVtbnVtbS5lcW1vbml0b3Iuam1hX21hcC5KbWFNYXAuSm1hTWFwRGF0YS5KbWFNYX'
    'BUeXBlUgdtYXBUeXBlElMKBGRhdGEYAiADKAsyPy5uZXQueXVtbnVtbS5lcW1vbml0b3Iuam1h'
    'X21hcC5KbWFNYXAuSm1hTWFwRGF0YS5KbWFNYXBEYXRhSXRlbVIEZGF0YRqLAgoOSm1hTWFwRG'
    'F0YUl0ZW0SQwoGYm91bmRzGAEgASgLMisubmV0Lnl1bW51bW0uZXFtb25pdG9yLmptYV9tYXAu'
    'TGF0TG5nQm91bmRzUgZib3VuZHMSZAoIcHJvcGVydHkYAiABKAsySC5uZXQueXVtbnVtbS5lcW'
    '1vbml0b3Iuam1hX21hcC5KbWFNYXAuSm1hTWFwRGF0YS5KbWFNYXBEYXRhSXRlbS5Qcm9wZXJ0'
    'eVIIcHJvcGVydHkaTgoIUHJvcGVydHkSEgoEY29kZRgBIAEoCVIEY29kZRISCgRuYW1lGAIgAS'
    'gJUgRuYW1lEhoKCG5hbWVLYW5hGAMgASgJUghuYW1lS2FuYSJxCgpKbWFNYXBUeXBlEhsKF0FS'
    'RUFfRk9SRUNBU1RfTE9DQUxfRUVXEAASGQoVQVJFQV9GT1JFQ0FTVF9MT0NBTF9FEAESGQoVQV'
    'JFQV9JTkZPUk1BVElPTl9DSVRZEAISEAoMQVJFQV9UU1VOQU1JEAM=');

@$core.Deprecated('Use latLngBoundsDescriptor instead')
const LatLngBounds$json = {
  '1': 'LatLngBounds',
  '2': [
    {'1': 'southWest', '3': 1, '4': 1, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.LatLng', '10': 'southWest'},
    {'1': 'northEast', '3': 2, '4': 1, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.LatLng', '10': 'northEast'},
  ],
};

/// Descriptor for `LatLngBounds`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List latLngBoundsDescriptor = $convert.base64Decode(
    'CgxMYXRMbmdCb3VuZHMSQwoJc291dGhXZXN0GAEgASgLMiUubmV0Lnl1bW51bW0uZXFtb25pdG'
    '9yLmptYV9tYXAuTGF0TG5nUglzb3V0aFdlc3QSQwoJbm9ydGhFYXN0GAIgASgLMiUubmV0Lnl1'
    'bW51bW0uZXFtb25pdG9yLmptYV9tYXAuTGF0TG5nUglub3J0aEVhc3Q=');

@$core.Deprecated('Use latLngDescriptor instead')
const LatLng$json = {
  '1': 'LatLng',
  '2': [
    {'1': 'lat', '3': 1, '4': 1, '5': 1, '10': 'lat'},
    {'1': 'lng', '3': 2, '4': 1, '5': 1, '10': 'lng'},
  ],
};

/// Descriptor for `LatLng`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List latLngDescriptor = $convert.base64Decode(
    'CgZMYXRMbmcSEAoDbGF0GAEgASgBUgNsYXQSEAoDbG5nGAIgASgBUgNsbmc=');

