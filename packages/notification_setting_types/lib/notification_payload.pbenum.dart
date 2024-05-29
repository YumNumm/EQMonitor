//
//  Generated code. Do not modify.
//  source: notification_payload.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class JmaIntensity extends $pb.ProtobufEnum {
  static const JmaIntensity JMA_INTENSITY_UNSPECIFIED = JmaIntensity._(0, _omitEnumNames ? '' : 'JMA_INTENSITY_UNSPECIFIED');
  static const JmaIntensity JMA_INTENSITY_0 = JmaIntensity._(10, _omitEnumNames ? '' : 'JMA_INTENSITY_0');
  static const JmaIntensity JMA_INTENSITY_1 = JmaIntensity._(20, _omitEnumNames ? '' : 'JMA_INTENSITY_1');
  static const JmaIntensity JMA_INTENSITY_2 = JmaIntensity._(30, _omitEnumNames ? '' : 'JMA_INTENSITY_2');
  static const JmaIntensity JMA_INTENSITY_3 = JmaIntensity._(40, _omitEnumNames ? '' : 'JMA_INTENSITY_3');
  static const JmaIntensity JMA_INTENSITY_4 = JmaIntensity._(45, _omitEnumNames ? '' : 'JMA_INTENSITY_4');
  static const JmaIntensity JMA_INTENSITY_5_MINUS = JmaIntensity._(50, _omitEnumNames ? '' : 'JMA_INTENSITY_5_MINUS');
  static const JmaIntensity JMA_INTENSITY_5_PLUS = JmaIntensity._(55, _omitEnumNames ? '' : 'JMA_INTENSITY_5_PLUS');
  static const JmaIntensity JMA_INTENSITY_6_MINUS = JmaIntensity._(60, _omitEnumNames ? '' : 'JMA_INTENSITY_6_MINUS');
  static const JmaIntensity JMA_INTENSITY_6_PLUS = JmaIntensity._(65, _omitEnumNames ? '' : 'JMA_INTENSITY_6_PLUS');
  static const JmaIntensity JMA_INTENSITY_7 = JmaIntensity._(70, _omitEnumNames ? '' : 'JMA_INTENSITY_7');

  static const $core.List<JmaIntensity> values = <JmaIntensity> [
    JMA_INTENSITY_UNSPECIFIED,
    JMA_INTENSITY_0,
    JMA_INTENSITY_1,
    JMA_INTENSITY_2,
    JMA_INTENSITY_3,
    JMA_INTENSITY_4,
    JMA_INTENSITY_5_MINUS,
    JMA_INTENSITY_5_PLUS,
    JMA_INTENSITY_6_MINUS,
    JMA_INTENSITY_6_PLUS,
    JMA_INTENSITY_7,
  ];

  static final $core.Map<$core.int, JmaIntensity> _byValue = $pb.ProtobufEnum.initByValue(values);
  static JmaIntensity? valueOf($core.int value) => _byValue[value];

  const JmaIntensity._($core.int v, $core.String n) : super(v, n);
}

class NotificationPayload_Type extends $pb.ProtobufEnum {
  static const NotificationPayload_Type TYPE_UNSPECIFIED = NotificationPayload_Type._(0, _omitEnumNames ? '' : 'TYPE_UNSPECIFIED');
  static const NotificationPayload_Type TYPE_EARTHQUAKE = NotificationPayload_Type._(1, _omitEnumNames ? '' : 'TYPE_EARTHQUAKE');
  static const NotificationPayload_Type TYPE_EEW = NotificationPayload_Type._(2, _omitEnumNames ? '' : 'TYPE_EEW');

  static const $core.List<NotificationPayload_Type> values = <NotificationPayload_Type> [
    TYPE_UNSPECIFIED,
    TYPE_EARTHQUAKE,
    TYPE_EEW,
  ];

  static final $core.Map<$core.int, NotificationPayload_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NotificationPayload_Type? valueOf($core.int value) => _byValue[value];

  const NotificationPayload_Type._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
