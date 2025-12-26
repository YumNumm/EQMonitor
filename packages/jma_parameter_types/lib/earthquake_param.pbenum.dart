//
//  Generated code. Do not modify.
//  source: earthquake_param.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class StationStatus extends $pb.ProtobufEnum {
  static const StationStatus OPERATIONAL = StationStatus._(0, _omitEnumNames ? '' : 'OPERATIONAL');
  static const StationStatus CHANGE = StationStatus._(1, _omitEnumNames ? '' : 'CHANGE');
  static const StationStatus CREATED = StationStatus._(2, _omitEnumNames ? '' : 'CREATED');
  static const StationStatus DISCONTINUED = StationStatus._(3, _omitEnumNames ? '' : 'DISCONTINUED');

  static const $core.List<StationStatus> values = <StationStatus> [
    OPERATIONAL,
    CHANGE,
    CREATED,
    DISCONTINUED,
  ];

  static final $core.Map<$core.int, StationStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StationStatus? valueOf($core.int value) => _byValue[value];

  const StationStatus._($core.int v, $core.String n) : super(v, n);
}

class StationOwner extends $pb.ProtobufEnum {
  static const StationOwner JMA = StationOwner._(0, _omitEnumNames ? '' : 'JMA');
  static const StationOwner PREFECTURE = StationOwner._(1, _omitEnumNames ? '' : 'PREFECTURE');
  static const StationOwner CITY = StationOwner._(2, _omitEnumNames ? '' : 'CITY');
  static const StationOwner NIED = StationOwner._(3, _omitEnumNames ? '' : 'NIED');
  static const StationOwner OTHERS = StationOwner._(100, _omitEnumNames ? '' : 'OTHERS');

  static const $core.List<StationOwner> values = <StationOwner> [
    JMA,
    PREFECTURE,
    CITY,
    NIED,
    OTHERS,
  ];

  static final $core.Map<$core.int, StationOwner> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StationOwner? valueOf($core.int value) => _byValue[value];

  const StationOwner._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
