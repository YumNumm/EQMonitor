//
//  Generated code. Do not modify.
//  source: jma_map.proto
//
// @dart = 3.3

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
  '3': [JmaMap_JmaMapData$json, JmaMap_LatLngBounds$json, JmaMap_LatLng$json],
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
    {'1': 'bounds', '3': 1, '4': 1, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLngBounds', '10': 'bounds'},
    {'1': 'property', '3': 2, '4': 1, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData.JmaMapDataItem.Property', '10': 'property'},
    {'1': 'polylabel', '3': 3, '4': 1, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLng', '10': 'polylabel'},
    {'1': 'polygons', '3': 4, '4': 3, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData.JmaMapDataItem.Polygon', '10': 'polygons'},
  ],
  '3': [JmaMap_JmaMapData_JmaMapDataItem_Polygon$json, JmaMap_JmaMapData_JmaMapDataItem_Property$json],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_JmaMapData_JmaMapDataItem_Polygon$json = {
  '1': 'Polygon',
  '2': [
    {'1': 'latLngs', '3': 1, '4': 3, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLng', '10': 'latLngs'},
  ],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_JmaMapData_JmaMapDataItem_Property$json = {
  '1': 'Property',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'code', '17': true},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'name', '17': true},
    {'1': 'nameKana', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'nameKana', '17': true},
  ],
  '8': [
    {'1': '_code'},
    {'1': '_name'},
    {'1': '_nameKana'},
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

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_LatLngBounds$json = {
  '1': 'LatLngBounds',
  '2': [
    {'1': 'southWest', '3': 1, '4': 1, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLng', '10': 'southWest'},
    {'1': 'northEast', '3': 2, '4': 1, '5': 11, '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLng', '10': 'northEast'},
  ],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_LatLng$json = {
  '1': 'LatLng',
  '2': [
    {'1': 'lat', '3': 1, '4': 1, '5': 1, '10': 'lat'},
    {'1': 'lng', '3': 2, '4': 1, '5': 1, '10': 'lng'},
  ],
};

/// Descriptor for `JmaMap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jmaMapDescriptor = $convert.base64Decode(
    'CgZKbWFNYXASRAoEZGF0YRgBIAMoCzIwLm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLk'
    'ptYU1hcC5KbWFNYXBEYXRhUgRkYXRhGvIGCgpKbWFNYXBEYXRhElUKB21hcFR5cGUYASABKA4y'
    'Oy5uZXQueXVtbnVtbS5lcW1vbml0b3Iuam1hX21hcC5KbWFNYXAuSm1hTWFwRGF0YS5KbWFNYX'
    'BUeXBlUgdtYXBUeXBlElMKBGRhdGEYAiADKAsyPy5uZXQueXVtbnVtbS5lcW1vbml0b3Iuam1h'
    'X21hcC5KbWFNYXAuSm1hTWFwRGF0YS5KbWFNYXBEYXRhSXRlbVIEZGF0YRrEBAoOSm1hTWFwRG'
    'F0YUl0ZW0SSgoGYm91bmRzGAEgASgLMjIubmV0Lnl1bW51bW0uZXFtb25pdG9yLmptYV9tYXAu'
    'Sm1hTWFwLkxhdExuZ0JvdW5kc1IGYm91bmRzEmQKCHByb3BlcnR5GAIgASgLMkgubmV0Lnl1bW'
    '51bW0uZXFtb25pdG9yLmptYV9tYXAuSm1hTWFwLkptYU1hcERhdGEuSm1hTWFwRGF0YUl0ZW0u'
    'UHJvcGVydHlSCHByb3BlcnR5EkoKCXBvbHlsYWJlbBgDIAEoCzIsLm5ldC55dW1udW1tLmVxbW'
    '9uaXRvci5qbWFfbWFwLkptYU1hcC5MYXRMbmdSCXBvbHlsYWJlbBJjCghwb2x5Z29ucxgEIAMo'
    'CzJHLm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLkptYU1hcC5KbWFNYXBEYXRhLkptYU'
    '1hcERhdGFJdGVtLlBvbHlnb25SCHBvbHlnb25zGlEKB1BvbHlnb24SRgoHbGF0TG5ncxgBIAMo'
    'CzIsLm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLkptYU1hcC5MYXRMbmdSB2xhdExuZ3'
    'MafAoIUHJvcGVydHkSFwoEY29kZRgBIAEoCUgAUgRjb2RliAEBEhcKBG5hbWUYAiABKAlIAVIE'
    'bmFtZYgBARIfCghuYW1lS2FuYRgDIAEoCUgCUghuYW1lS2FuYYgBAUIHCgVfY29kZUIHCgVfbm'
    'FtZUILCglfbmFtZUthbmEicQoKSm1hTWFwVHlwZRIbChdBUkVBX0ZPUkVDQVNUX0xPQ0FMX0VF'
    'VxAAEhkKFUFSRUFfRk9SRUNBU1RfTE9DQUxfRRABEhkKFUFSRUFfSU5GT1JNQVRJT05fQ0lUWR'
    'ACEhAKDEFSRUFfVFNVTkFNSRADGqYBCgxMYXRMbmdCb3VuZHMSSgoJc291dGhXZXN0GAEgASgL'
    'MiwubmV0Lnl1bW51bW0uZXFtb25pdG9yLmptYV9tYXAuSm1hTWFwLkxhdExuZ1IJc291dGhXZX'
    'N0EkoKCW5vcnRoRWFzdBgCIAEoCzIsLm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLkpt'
    'YU1hcC5MYXRMbmdSCW5vcnRoRWFzdBosCgZMYXRMbmcSEAoDbGF0GAEgASgBUgNsYXQSEAoDbG'
    '5nGAIgASgBUgNsbmc=');

