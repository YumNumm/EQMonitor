//
//  Generated code. Do not modify.
//  source: kyoshin_observation_point.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class KyoshinObservationPoints extends $pb.GeneratedMessage {
  factory KyoshinObservationPoints({
    $core.Iterable<KyoshinObservationPoint>? points,
  }) {
    final $result = create();
    if (points != null) {
      $result.points.addAll(points);
    }
    return $result;
  }
  KyoshinObservationPoints._() : super();
  factory KyoshinObservationPoints.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory KyoshinObservationPoints.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KyoshinObservationPoints',
      createEmptyInstance: create)
    ..pc<KyoshinObservationPoint>(
        1, _omitFieldNames ? '' : 'points', $pb.PbFieldType.PM,
        subBuilder: KyoshinObservationPoint.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  KyoshinObservationPoints clone() =>
      KyoshinObservationPoints()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  KyoshinObservationPoints copyWith(
          void Function(KyoshinObservationPoints) updates) =>
      super.copyWith((message) => updates(message as KyoshinObservationPoints))
          as KyoshinObservationPoints;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoints create() => KyoshinObservationPoints._();
  KyoshinObservationPoints createEmptyInstance() => create();
  static $pb.PbList<KyoshinObservationPoints> createRepeated() =>
      $pb.PbList<KyoshinObservationPoints>();
  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoints getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KyoshinObservationPoints>(create);
  static KyoshinObservationPoints? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<KyoshinObservationPoint> get points => $_getList(0);
}

class KyoshinObservationPoint_LatLng extends $pb.GeneratedMessage {
  factory KyoshinObservationPoint_LatLng({
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final $result = create();
    if (latitude != null) {
      $result.latitude = latitude;
    }
    if (longitude != null) {
      $result.longitude = longitude;
    }
    return $result;
  }
  KyoshinObservationPoint_LatLng._() : super();
  factory KyoshinObservationPoint_LatLng.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory KyoshinObservationPoint_LatLng.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KyoshinObservationPoint.LatLng',
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  KyoshinObservationPoint_LatLng clone() =>
      KyoshinObservationPoint_LatLng()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  KyoshinObservationPoint_LatLng copyWith(
          void Function(KyoshinObservationPoint_LatLng) updates) =>
      super.copyWith(
              (message) => updates(message as KyoshinObservationPoint_LatLng))
          as KyoshinObservationPoint_LatLng;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint_LatLng create() =>
      KyoshinObservationPoint_LatLng._();
  KyoshinObservationPoint_LatLng createEmptyInstance() => create();
  static $pb.PbList<KyoshinObservationPoint_LatLng> createRepeated() =>
      $pb.PbList<KyoshinObservationPoint_LatLng>();
  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint_LatLng getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KyoshinObservationPoint_LatLng>(create);
  static KyoshinObservationPoint_LatLng? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double v) {
    $_setDouble(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => clearField(2);
}

class KyoshinObservationPoint_Point extends $pb.GeneratedMessage {
  factory KyoshinObservationPoint_Point({
    $core.int? x,
    $core.int? y,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    return $result;
  }
  KyoshinObservationPoint_Point._() : super();
  factory KyoshinObservationPoint_Point.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory KyoshinObservationPoint_Point.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KyoshinObservationPoint.Point',
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  KyoshinObservationPoint_Point clone() =>
      KyoshinObservationPoint_Point()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  KyoshinObservationPoint_Point copyWith(
          void Function(KyoshinObservationPoint_Point) updates) =>
      super.copyWith(
              (message) => updates(message as KyoshinObservationPoint_Point))
          as KyoshinObservationPoint_Point;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint_Point create() =>
      KyoshinObservationPoint_Point._();
  KyoshinObservationPoint_Point createEmptyInstance() => create();
  static $pb.PbList<KyoshinObservationPoint_Point> createRepeated() =>
      $pb.PbList<KyoshinObservationPoint_Point>();
  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint_Point getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KyoshinObservationPoint_Point>(create);
  static KyoshinObservationPoint_Point? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get x => $_getIZ(0);
  @$pb.TagNumber(1)
  set x($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get y => $_getIZ(1);
  @$pb.TagNumber(2)
  set y($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);
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
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (region != null) {
      $result.region = region;
    }
    if (location != null) {
      $result.location = location;
    }
    if (point != null) {
      $result.point = point;
    }
    if (arv400 != null) {
      $result.arv400 = arv400;
    }
    return $result;
  }
  KyoshinObservationPoint._() : super();
  factory KyoshinObservationPoint.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory KyoshinObservationPoint.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

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
    ..a<$core.double>(6, _omitFieldNames ? '' : 'arv400', $pb.PbFieldType.OD,
        protoName: 'arv_400')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  KyoshinObservationPoint clone() =>
      KyoshinObservationPoint()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  KyoshinObservationPoint copyWith(
          void Function(KyoshinObservationPoint) updates) =>
      super.copyWith((message) => updates(message as KyoshinObservationPoint))
          as KyoshinObservationPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint create() => KyoshinObservationPoint._();
  KyoshinObservationPoint createEmptyInstance() => create();
  static $pb.PbList<KyoshinObservationPoint> createRepeated() =>
      $pb.PbList<KyoshinObservationPoint>();
  @$core.pragma('dart2js:noInline')
  static KyoshinObservationPoint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KyoshinObservationPoint>(create);
  static KyoshinObservationPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get region => $_getSZ(2);
  @$pb.TagNumber(3)
  set region($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRegion() => $_has(2);
  @$pb.TagNumber(3)
  void clearRegion() => clearField(3);

  @$pb.TagNumber(4)
  KyoshinObservationPoint_LatLng get location => $_getN(3);
  @$pb.TagNumber(4)
  set location(KyoshinObservationPoint_LatLng v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasLocation() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocation() => clearField(4);
  @$pb.TagNumber(4)
  KyoshinObservationPoint_LatLng ensureLocation() => $_ensure(3);

  @$pb.TagNumber(5)
  KyoshinObservationPoint_Point get point => $_getN(4);
  @$pb.TagNumber(5)
  set point(KyoshinObservationPoint_Point v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPoint() => $_has(4);
  @$pb.TagNumber(5)
  void clearPoint() => clearField(5);
  @$pb.TagNumber(5)
  KyoshinObservationPoint_Point ensurePoint() => $_ensure(4);

  /// 工学的基盤（Vs=400m/s）から地表に至る最大速度の増幅率
  @$pb.TagNumber(6)
  $core.double get arv400 => $_getN(5);
  @$pb.TagNumber(6)
  set arv400($core.double v) {
    $_setDouble(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasArv400() => $_has(5);
  @$pb.TagNumber(6)
  void clearArv400() => clearField(6);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
