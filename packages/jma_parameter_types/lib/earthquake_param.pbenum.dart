// This is a generated file - do not edit.
//
// Generated from earthquake_param.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class StationStatus extends $pb.ProtobufEnum {
  /// 運用中
  static const StationStatus OPERATIONAL =
      StationStatus._(0, _omitEnumNames ? '' : 'OPERATIONAL');

  /// 変更
  static const StationStatus CHANGE =
      StationStatus._(1, _omitEnumNames ? '' : 'CHANGE');

  /// 新規
  static const StationStatus CREATED =
      StationStatus._(2, _omitEnumNames ? '' : 'CREATED');

  /// 廃止
  static const StationStatus DISCONTINUED =
      StationStatus._(3, _omitEnumNames ? '' : 'DISCONTINUED');

  static const $core.List<StationStatus> values = <StationStatus>[
    OPERATIONAL,
    CHANGE,
    CREATED,
    DISCONTINUED,
  ];

  static final $core.List<StationStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static StationStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const StationStatus._(super.value, super.name);
}

class StationOwner extends $pb.ProtobufEnum {
  /// 気象庁
  static const StationOwner JMA =
      StationOwner._(0, _omitEnumNames ? '' : 'JMA');

  /// 都道府県
  static const StationOwner PREFECTURE =
      StationOwner._(1, _omitEnumNames ? '' : 'PREFECTURE');

  /// 市町村
  static const StationOwner CITY =
      StationOwner._(2, _omitEnumNames ? '' : 'CITY');

  /// 防災科研
  static const StationOwner NIED =
      StationOwner._(3, _omitEnumNames ? '' : 'NIED');

  /// その他
  static const StationOwner OTHERS =
      StationOwner._(100, _omitEnumNames ? '' : 'OTHERS');

  static const $core.List<StationOwner> values = <StationOwner>[
    JMA,
    PREFECTURE,
    CITY,
    NIED,
    OTHERS,
  ];

  static final $core.Map<$core.int, StationOwner> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static StationOwner? valueOf($core.int value) => _byValue[value];

  const StationOwner._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
