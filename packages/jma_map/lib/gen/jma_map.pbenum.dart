//
//  Generated code. Do not modify.
//  source: jma_map.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class JmaMap_JmaMapData_JmaMapType extends $pb.ProtobufEnum {
  /// 緊急地震速報／府県予報区
  static const JmaMap_JmaMapData_JmaMapType AREA_FORECAST_LOCAL_EEW = JmaMap_JmaMapData_JmaMapType._(0, _omitEnumNames ? '' : 'AREA_FORECAST_LOCAL_EEW');
  /// 地震情報／細分区域
  static const JmaMap_JmaMapData_JmaMapType AREA_FORECAST_LOCAL_E = JmaMap_JmaMapData_JmaMapType._(1, _omitEnumNames ? '' : 'AREA_FORECAST_LOCAL_E');
  /// 市町村等（地震津波関係）
  static const JmaMap_JmaMapData_JmaMapType AREA_INFORMATION_CITY = JmaMap_JmaMapData_JmaMapType._(2, _omitEnumNames ? '' : 'AREA_INFORMATION_CITY');
  /// 津波予報区
  static const JmaMap_JmaMapData_JmaMapType AREA_TSUNAMI = JmaMap_JmaMapData_JmaMapType._(3, _omitEnumNames ? '' : 'AREA_TSUNAMI');

  static const $core.List<JmaMap_JmaMapData_JmaMapType> values = <JmaMap_JmaMapData_JmaMapType> [
    AREA_FORECAST_LOCAL_EEW,
    AREA_FORECAST_LOCAL_E,
    AREA_INFORMATION_CITY,
    AREA_TSUNAMI,
  ];

  static final $core.Map<$core.int, JmaMap_JmaMapData_JmaMapType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static JmaMap_JmaMapData_JmaMapType? valueOf($core.int value) => _byValue[value];

  const JmaMap_JmaMapData_JmaMapType._(super.v, super.n);
}

class JmaMap_JmaMapData_DataType extends $pb.ProtobufEnum {
  static const JmaMap_JmaMapData_DataType POLYGON = JmaMap_JmaMapData_DataType._(0, _omitEnumNames ? '' : 'POLYGON');
  static const JmaMap_JmaMapData_DataType MULTI_POLYGON = JmaMap_JmaMapData_DataType._(1, _omitEnumNames ? '' : 'MULTI_POLYGON');
  static const JmaMap_JmaMapData_DataType LINE_STRING = JmaMap_JmaMapData_DataType._(2, _omitEnumNames ? '' : 'LINE_STRING');
  static const JmaMap_JmaMapData_DataType MULTI_LINE_STRING = JmaMap_JmaMapData_DataType._(3, _omitEnumNames ? '' : 'MULTI_LINE_STRING');

  static const $core.List<JmaMap_JmaMapData_DataType> values = <JmaMap_JmaMapData_DataType> [
    POLYGON,
    MULTI_POLYGON,
    LINE_STRING,
    MULTI_LINE_STRING,
  ];

  static final $core.Map<$core.int, JmaMap_JmaMapData_DataType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static JmaMap_JmaMapData_DataType? valueOf($core.int value) => _byValue[value];

  const JmaMap_JmaMapData_DataType._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
