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
    {
      '1': 'data',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData',
      '10': 'data'
    },
    {
      '1': 'topoJsonData',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.TopoJSONMapData',
      '10': 'topoJsonData'
    },
  ],
  '3': [
    JmaMap_JmaMapData$json,
    JmaMap_LatLngBounds$json,
    JmaMap_LatLng$json,
    JmaMap_TopoJSONMapData$json,
    JmaMap_TopoJSONGeometry$json,
    JmaMap_TopoJSONArcIndices$json,
    JmaMap_TopoJSONArc$json
  ],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_JmaMapData$json = {
  '1': 'JmaMapData',
  '2': [
    {
      '1': 'mapType',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData.JmaMapType',
      '10': 'mapType'
    },
    {
      '1': 'data',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData.JmaMapDataItem',
      '10': 'data'
    },
  ],
  '3': [JmaMap_JmaMapData_JmaMapDataItem$json],
  '4': [JmaMap_JmaMapData_JmaMapType$json, JmaMap_JmaMapData_DataType$json],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_JmaMapData_JmaMapDataItem$json = {
  '1': 'JmaMapDataItem',
  '2': [
    {
      '1': 'bounds',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLngBounds',
      '10': 'bounds'
    },
    {
      '1': 'property',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData.JmaMapDataItem.Property',
      '10': 'property'
    },
    {
      '1': 'polylabel',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLng',
      '10': 'polylabel'
    },
    {'1': 'bytes', '3': 4, '4': 1, '5': 12, '10': 'bytes'},
  ],
  '3': [
    JmaMap_JmaMapData_JmaMapDataItem_Polygon$json,
    JmaMap_JmaMapData_JmaMapDataItem_Property$json
  ],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_JmaMapData_JmaMapDataItem_Polygon$json = {
  '1': 'Polygon',
  '2': [
    {
      '1': 'latLngs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLng',
      '10': 'latLngs'
    },
  ],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_JmaMapData_JmaMapDataItem_Property$json = {
  '1': 'Property',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'code', '17': true},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'name', '17': true},
    {
      '1': 'nameKana',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'nameKana',
      '17': true
    },
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
const JmaMap_JmaMapData_DataType$json = {
  '1': 'DataType',
  '2': [
    {'1': 'POLYGON', '2': 0},
    {'1': 'MULTI_POLYGON', '2': 1},
    {'1': 'LINE_STRING', '2': 2},
    {'1': 'MULTI_LINE_STRING', '2': 3},
  ],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_LatLngBounds$json = {
  '1': 'LatLngBounds',
  '2': [
    {
      '1': 'southWest',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLng',
      '10': 'southWest'
    },
    {
      '1': 'northEast',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLng',
      '10': 'northEast'
    },
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

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_TopoJSONMapData$json = {
  '1': 'TopoJSONMapData',
  '2': [
    {
      '1': 'mapType',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData.JmaMapType',
      '10': 'mapType'
    },
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'geometries',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.TopoJSONGeometry',
      '10': 'geometries'
    },
    {
      '1': 'arcs',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.TopoJSONArc',
      '10': 'arcs'
    },
    {
      '1': 'bounds',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLngBounds',
      '10': 'bounds'
    },
  ],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_TopoJSONGeometry$json = {
  '1': 'TopoJSONGeometry',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {
      '1': 'arcIndices',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.TopoJSONArcIndices',
      '10': 'arcIndices'
    },
    {
      '1': 'property',
      '3': 3,
      '4': 1,
      '5': 11,
      '6':
          '.net.yumnumm.eqmonitor.jma_map.JmaMap.JmaMapData.JmaMapDataItem.Property',
      '10': 'property'
    },
    {
      '1': 'bounds',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLngBounds',
      '10': 'bounds'
    },
  ],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_TopoJSONArcIndices$json = {
  '1': 'TopoJSONArcIndices',
  '2': [
    {'1': 'indices', '3': 1, '4': 3, '5': 5, '10': 'indices'},
  ],
};

@$core.Deprecated('Use jmaMapDescriptor instead')
const JmaMap_TopoJSONArc$json = {
  '1': 'TopoJSONArc',
  '2': [
    {
      '1': 'positions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLng',
      '10': 'positions'
    },
    {
      '1': 'bounds',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.net.yumnumm.eqmonitor.jma_map.JmaMap.LatLngBounds',
      '10': 'bounds'
    },
  ],
};

/// Descriptor for `JmaMap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jmaMapDescriptor = $convert.base64Decode(
    'CgZKbWFNYXASRAoEZGF0YRgBIAMoCzIwLm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLk'
    'ptYU1hcC5KbWFNYXBEYXRhUgRkYXRhElkKDHRvcG9Kc29uRGF0YRgCIAMoCzI1Lm5ldC55dW1u'
    'dW1tLmVxbW9uaXRvci5qbWFfbWFwLkptYU1hcC5Ub3BvSlNPTk1hcERhdGFSDHRvcG9Kc29uRG'
    'F0YRr3BgoKSm1hTWFwRGF0YRJVCgdtYXBUeXBlGAEgASgOMjsubmV0Lnl1bW51bW0uZXFtb25p'
    'dG9yLmptYV9tYXAuSm1hTWFwLkptYU1hcERhdGEuSm1hTWFwVHlwZVIHbWFwVHlwZRJTCgRkYX'
    'RhGAIgAygLMj8ubmV0Lnl1bW51bW0uZXFtb25pdG9yLmptYV9tYXAuSm1hTWFwLkptYU1hcERh'
    'dGEuSm1hTWFwRGF0YUl0ZW1SBGRhdGEa9QMKDkptYU1hcERhdGFJdGVtEkoKBmJvdW5kcxgBIA'
    'EoCzIyLm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLkptYU1hcC5MYXRMbmdCb3VuZHNS'
    'BmJvdW5kcxJkCghwcm9wZXJ0eRgCIAEoCzJILm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbW'
    'FwLkptYU1hcC5KbWFNYXBEYXRhLkptYU1hcERhdGFJdGVtLlByb3BlcnR5Ughwcm9wZXJ0eRJK'
    'Cglwb2x5bGFiZWwYAyABKAsyLC5uZXQueXVtbnVtbS5lcW1vbml0b3Iuam1hX21hcC5KbWFNYX'
    'AuTGF0TG5nUglwb2x5bGFiZWwSFAoFYnl0ZXMYBCABKAxSBWJ5dGVzGlEKB1BvbHlnb24SRgoH'
    'bGF0TG5ncxgBIAMoCzIsLm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLkptYU1hcC5MYX'
    'RMbmdSB2xhdExuZ3MafAoIUHJvcGVydHkSFwoEY29kZRgBIAEoCUgAUgRjb2RliAEBEhcKBG5h'
    'bWUYAiABKAlIAVIEbmFtZYgBARIfCghuYW1lS2FuYRgDIAEoCUgCUghuYW1lS2FuYYgBAUIHCg'
    'VfY29kZUIHCgVfbmFtZUILCglfbmFtZUthbmEicQoKSm1hTWFwVHlwZRIbChdBUkVBX0ZPUkVD'
    'QVNUX0xPQ0FMX0VFVxAAEhkKFUFSRUFfRk9SRUNBU1RfTE9DQUxfRRABEhkKFUFSRUFfSU5GT1'
    'JNQVRJT05fQ0lUWRACEhAKDEFSRUFfVFNVTkFNSRADIlIKCERhdGFUeXBlEgsKB1BPTFlHT04Q'
    'ABIRCg1NVUxUSV9QT0xZR09OEAESDwoLTElORV9TVFJJTkcQAhIVChFNVUxUSV9MSU5FX1NUUk'
    'lORxADGqYBCgxMYXRMbmdCb3VuZHMSSgoJc291dGhXZXN0GAEgASgLMiwubmV0Lnl1bW51bW0u'
    'ZXFtb25pdG9yLmptYV9tYXAuSm1hTWFwLkxhdExuZ1IJc291dGhXZXN0EkoKCW5vcnRoRWFzdB'
    'gCIAEoCzIsLm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLkptYU1hcC5MYXRMbmdSCW5v'
    'cnRoRWFzdBosCgZMYXRMbmcSEAoDbGF0GAEgASgBUgNsYXQSEAoDbG5nGAIgASgBUgNsbmca5w'
    'IKD1RvcG9KU09OTWFwRGF0YRJVCgdtYXBUeXBlGAEgASgOMjsubmV0Lnl1bW51bW0uZXFtb25p'
    'dG9yLmptYV9tYXAuSm1hTWFwLkptYU1hcERhdGEuSm1hTWFwVHlwZVIHbWFwVHlwZRISCgRuYW'
    '1lGAIgASgJUgRuYW1lElYKCmdlb21ldHJpZXMYAyADKAsyNi5uZXQueXVtbnVtbS5lcW1vbml0'
    'b3Iuam1hX21hcC5KbWFNYXAuVG9wb0pTT05HZW9tZXRyeVIKZ2VvbWV0cmllcxJFCgRhcmNzGA'
    'QgAygLMjEubmV0Lnl1bW51bW0uZXFtb25pdG9yLmptYV9tYXAuSm1hTWFwLlRvcG9KU09OQXJj'
    'UgRhcmNzEkoKBmJvdW5kcxgFIAEoCzIyLm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLk'
    'ptYU1hcC5MYXRMbmdCb3VuZHNSBmJvdW5kcxqyAgoQVG9wb0pTT05HZW9tZXRyeRISCgR0eXBl'
    'GAEgASgJUgR0eXBlElgKCmFyY0luZGljZXMYAiADKAsyOC5uZXQueXVtbnVtbS5lcW1vbml0b3'
    'Iuam1hX21hcC5KbWFNYXAuVG9wb0pTT05BcmNJbmRpY2VzUgphcmNJbmRpY2VzEmQKCHByb3Bl'
    'cnR5GAMgASgLMkgubmV0Lnl1bW51bW0uZXFtb25pdG9yLmptYV9tYXAuSm1hTWFwLkptYU1hcE'
    'RhdGEuSm1hTWFwRGF0YUl0ZW0uUHJvcGVydHlSCHByb3BlcnR5EkoKBmJvdW5kcxgEIAEoCzIy'
    'Lm5ldC55dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLkptYU1hcC5MYXRMbmdCb3VuZHNSBmJvdW'
    '5kcxouChJUb3BvSlNPTkFyY0luZGljZXMSGAoHaW5kaWNlcxgBIAMoBVIHaW5kaWNlcxqlAQoL'
    'VG9wb0pTT05BcmMSSgoJcG9zaXRpb25zGAEgAygLMiwubmV0Lnl1bW51bW0uZXFtb25pdG9yLm'
    'ptYV9tYXAuSm1hTWFwLkxhdExuZ1IJcG9zaXRpb25zEkoKBmJvdW5kcxgCIAEoCzIyLm5ldC55'
    'dW1udW1tLmVxbW9uaXRvci5qbWFfbWFwLkptYU1hcC5MYXRMbmdCb3VuZHNSBmJvdW5kcw==');
