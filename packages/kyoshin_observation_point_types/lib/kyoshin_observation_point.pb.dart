// This is a generated file - do not edit.
//
// Generated from kyoshin_observation_point.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class KyoshinObservationPoints extends $pb.GeneratedMessage {
  factory KyoshinObservationPoints({
    $core.Iterable<KyoshinObservationPoint>? points,
  }) {
    final result = create();
    if (points != null) result.points.addAll(points);
    return result;
  }

  KyoshinObservationPoints._();

  factory KyoshinObservationPoints.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory KyoshinObservationPoints.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KyoshinObservationPoints',
      createEmptyInstance: create)
    ..pPM<KyoshinObservationPoint>(1, _omitFieldNames ? '' : 'points',
        subBuilder: KyoshinObservationPoint.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KyoshinObservationPoints clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KyoshinObservationPoints copyWith(
          void Function(KyoshinObservationPoints) updates) =>
      super.copyWith((message) => updates(message as KyoshinObservationPoints))
          as KyoshinObservationPoints;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoints create() => KyoshinObservationPoints._();
  @$core.override
  KyoshinObservationPoints createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoints getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KyoshinObservationPoints>(create);
  static KyoshinObservationPoints? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<KyoshinObservationPoint> get points => $_getList(0);
}

class KyoshinObservationPoint_LatLng extends $pb.GeneratedMessage {
  factory KyoshinObservationPoint_LatLng({
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final result = create();
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    return result;
  }

  KyoshinObservationPoint_LatLng._();

  factory KyoshinObservationPoint_LatLng.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory KyoshinObservationPoint_LatLng.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KyoshinObservationPoint.LatLng',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'latitude')
    ..aD(2, _omitFieldNames ? '' : 'longitude')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KyoshinObservationPoint_LatLng clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KyoshinObservationPoint_LatLng copyWith(
          void Function(KyoshinObservationPoint_LatLng) updates) =>
      super.copyWith(
              (message) => updates(message as KyoshinObservationPoint_LatLng))
          as KyoshinObservationPoint_LatLng;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint_LatLng create() =>
      KyoshinObservationPoint_LatLng._();
  @$core.override
  KyoshinObservationPoint_LatLng createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint_LatLng getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KyoshinObservationPoint_LatLng>(create);
  static KyoshinObservationPoint_LatLng? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => $_clearField(2);
}

class KyoshinObservationPoint_Point extends $pb.GeneratedMessage {
  factory KyoshinObservationPoint_Point({
    $core.int? x,
    $core.int? y,
  }) {
    final result = create();
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    return result;
  }

  KyoshinObservationPoint_Point._();

  factory KyoshinObservationPoint_Point.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory KyoshinObservationPoint_Point.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KyoshinObservationPoint.Point',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'x')
    ..aI(2, _omitFieldNames ? '' : 'y')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KyoshinObservationPoint_Point clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KyoshinObservationPoint_Point copyWith(
          void Function(KyoshinObservationPoint_Point) updates) =>
      super.copyWith(
              (message) => updates(message as KyoshinObservationPoint_Point))
          as KyoshinObservationPoint_Point;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint_Point create() =>
      KyoshinObservationPoint_Point._();
  @$core.override
  KyoshinObservationPoint_Point createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint_Point getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KyoshinObservationPoint_Point>(create);
  static KyoshinObservationPoint_Point? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get x => $_getIZ(0);
  @$pb.TagNumber(1)
  set x($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get y => $_getIZ(1);
  @$pb.TagNumber(2)
  set y($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => $_clearField(2);
}

class KyoshinObservationPoint extends $pb.GeneratedMessage {
  factory KyoshinObservationPoint({
    $core.String? code,
    $core.String? name,
    $core.String? region,
    KyoshinObservationPoint_LatLng? location,
    KyoshinObservationPoint_Point? point,
    $core.double? arv400,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (region != null) result.region = region;
    if (location != null) result.location = location;
    if (point != null) result.point = point;
    if (arv400 != null) result.arv400 = arv400;
    return result;
  }

  KyoshinObservationPoint._();

  factory KyoshinObservationPoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory KyoshinObservationPoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KyoshinObservationPoint',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'region')
    ..aOM<KyoshinObservationPoint_LatLng>(4, _omitFieldNames ? '' : 'location',
        subBuilder: KyoshinObservationPoint_LatLng.create)
    ..aOM<KyoshinObservationPoint_Point>(5, _omitFieldNames ? '' : 'point',
        subBuilder: KyoshinObservationPoint_Point.create)
    ..aD(6, _omitFieldNames ? '' : 'arv400', protoName: 'arv_400')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KyoshinObservationPoint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KyoshinObservationPoint copyWith(
          void Function(KyoshinObservationPoint) updates) =>
      super.copyWith((message) => updates(message as KyoshinObservationPoint))
          as KyoshinObservationPoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint create() => KyoshinObservationPoint._();
  @$core.override
  KyoshinObservationPoint createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KyoshinObservationPoint>(create);
  static KyoshinObservationPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get region => $_getSZ(2);
  @$pb.TagNumber(3)
  set region($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRegion() => $_has(2);
  @$pb.TagNumber(3)
  void clearRegion() => $_clearField(3);

  @$pb.TagNumber(4)
  KyoshinObservationPoint_LatLng get location => $_getN(3);
  @$pb.TagNumber(4)
  set location(KyoshinObservationPoint_LatLng value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLocation() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocation() => $_clearField(4);
  @$pb.TagNumber(4)
  KyoshinObservationPoint_LatLng ensureLocation() => $_ensure(3);

  @$pb.TagNumber(5)
  KyoshinObservationPoint_Point get point => $_getN(4);
  @$pb.TagNumber(5)
  set point(KyoshinObservationPoint_Point value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPoint() => $_has(4);
  @$pb.TagNumber(5)
  void clearPoint() => $_clearField(5);
  @$pb.TagNumber(5)
  KyoshinObservationPoint_Point ensurePoint() => $_ensure(4);

  /// 工学的基盤（Vs=400m/s）から地表に至る最大速度の増幅率
  @$pb.TagNumber(6)
  $core.double get arv400 => $_getN(5);
  @$pb.TagNumber(6)
  set arv400($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasArv400() => $_has(5);
  @$pb.TagNumber(6)
  void clearArv400() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
