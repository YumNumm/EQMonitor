//
//  Generated code. Do not modify.
//  source: jma_map.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class JmaMap_JmaMapData_JmaMapType extends $pb.ProtobufEnum {
  static const JmaMap_JmaMapData_JmaMapType AREA_FORECAST_LOCAL_EEW = JmaMap_JmaMapData_JmaMapType._(0, _omitEnumNames ? '' : 'AREA_FORECAST_LOCAL_EEW');
  static const JmaMap_JmaMapData_JmaMapType AREA_FORECAST_LOCAL_E = JmaMap_JmaMapData_JmaMapType._(1, _omitEnumNames ? '' : 'AREA_FORECAST_LOCAL_E');
  static const JmaMap_JmaMapData_JmaMapType AREA_INFORMATION_CITY = JmaMap_JmaMapData_JmaMapType._(2, _omitEnumNames ? '' : 'AREA_INFORMATION_CITY');
  static const JmaMap_JmaMapData_JmaMapType AREA_TSUNAMI = JmaMap_JmaMapData_JmaMapType._(3, _omitEnumNames ? '' : 'AREA_TSUNAMI');

  static const $core.List<JmaMap_JmaMapData_JmaMapType> values = <JmaMap_JmaMapData_JmaMapType> [
    AREA_FORECAST_LOCAL_EEW,
    AREA_FORECAST_LOCAL_E,
    AREA_INFORMATION_CITY,
    AREA_TSUNAMI,
  ];

  static final $core.Map<$core.int, JmaMap_JmaMapData_JmaMapType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static JmaMap_JmaMapData_JmaMapType? valueOf($core.int value) => _byValue[value];

  const JmaMap_JmaMapData_JmaMapType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
