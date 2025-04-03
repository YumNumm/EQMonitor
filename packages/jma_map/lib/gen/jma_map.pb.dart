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

import 'jma_map.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'jma_map.pbenum.dart';

class JmaMap_JmaMapData_JmaMapDataItem_Polygon extends $pb.GeneratedMessage {
  factory JmaMap_JmaMapData_JmaMapDataItem_Polygon({
    $core.Iterable<JmaMap_LatLng>? latLngs,
  }) {
    final $result = create();
    if (latLngs != null) {
      $result.latLngs.addAll(latLngs);
    }
    return $result;
  }
  JmaMap_JmaMapData_JmaMapDataItem_Polygon._() : super();
  factory JmaMap_JmaMapData_JmaMapDataItem_Polygon.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap_JmaMapData_JmaMapDataItem_Polygon.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap.JmaMapData.JmaMapDataItem.Polygon', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..pc<JmaMap_LatLng>(1, _omitFieldNames ? '' : 'latLngs', $pb.PbFieldType.PM, protoName: 'latLngs', subBuilder: JmaMap_LatLng.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap_JmaMapData_JmaMapDataItem_Polygon clone() => JmaMap_JmaMapData_JmaMapDataItem_Polygon()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap_JmaMapData_JmaMapDataItem_Polygon copyWith(void Function(JmaMap_JmaMapData_JmaMapDataItem_Polygon) updates) => super.copyWith((message) => updates(message as JmaMap_JmaMapData_JmaMapDataItem_Polygon)) as JmaMap_JmaMapData_JmaMapDataItem_Polygon;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem_Polygon create() => JmaMap_JmaMapData_JmaMapDataItem_Polygon._();
  JmaMap_JmaMapData_JmaMapDataItem_Polygon createEmptyInstance() => create();
  static $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem_Polygon> createRepeated() => $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem_Polygon>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem_Polygon getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap_JmaMapData_JmaMapDataItem_Polygon>(create);
  static JmaMap_JmaMapData_JmaMapDataItem_Polygon? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<JmaMap_LatLng> get latLngs => $_getList(0);
}

class JmaMap_JmaMapData_JmaMapDataItem_Property extends $pb.GeneratedMessage {
  factory JmaMap_JmaMapData_JmaMapDataItem_Property({
    $core.String? code,
    $core.String? name,
    $core.String? nameKana,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (nameKana != null) {
      $result.nameKana = nameKana;
    }
    return $result;
  }
  JmaMap_JmaMapData_JmaMapDataItem_Property._() : super();
  factory JmaMap_JmaMapData_JmaMapDataItem_Property.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap_JmaMapData_JmaMapDataItem_Property.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap.JmaMapData.JmaMapDataItem.Property', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap_JmaMapData_JmaMapDataItem_Property clone() => JmaMap_JmaMapData_JmaMapDataItem_Property()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap_JmaMapData_JmaMapDataItem_Property copyWith(void Function(JmaMap_JmaMapData_JmaMapDataItem_Property) updates) => super.copyWith((message) => updates(message as JmaMap_JmaMapData_JmaMapDataItem_Property)) as JmaMap_JmaMapData_JmaMapDataItem_Property;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem_Property create() => JmaMap_JmaMapData_JmaMapDataItem_Property._();
  JmaMap_JmaMapData_JmaMapDataItem_Property createEmptyInstance() => create();
  static $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem_Property> createRepeated() => $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem_Property>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem_Property getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap_JmaMapData_JmaMapDataItem_Property>(create);
  static JmaMap_JmaMapData_JmaMapDataItem_Property? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get nameKana => $_getSZ(2);
  @$pb.TagNumber(3)
  set nameKana($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNameKana() => $_has(2);
  @$pb.TagNumber(3)
  void clearNameKana() => $_clearField(3);
}

class JmaMap_JmaMapData_JmaMapDataItem extends $pb.GeneratedMessage {
  factory JmaMap_JmaMapData_JmaMapDataItem({
    JmaMap_LatLngBounds? bounds,
    JmaMap_JmaMapData_JmaMapDataItem_Property? property,
    JmaMap_LatLng? polylabel,
    $core.List<$core.int>? bytes,
  }) {
    final $result = create();
    if (bounds != null) {
      $result.bounds = bounds;
    }
    if (property != null) {
      $result.property = property;
    }
    if (polylabel != null) {
      $result.polylabel = polylabel;
    }
    if (bytes != null) {
      $result.bytes = bytes;
    }
    return $result;
  }
  JmaMap_JmaMapData_JmaMapDataItem._() : super();
  factory JmaMap_JmaMapData_JmaMapDataItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap_JmaMapData_JmaMapDataItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap.JmaMapData.JmaMapDataItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..aOM<JmaMap_LatLngBounds>(1, _omitFieldNames ? '' : 'bounds', subBuilder: JmaMap_LatLngBounds.create)
    ..aOM<JmaMap_JmaMapData_JmaMapDataItem_Property>(2, _omitFieldNames ? '' : 'property', subBuilder: JmaMap_JmaMapData_JmaMapDataItem_Property.create)
    ..aOM<JmaMap_LatLng>(3, _omitFieldNames ? '' : 'polylabel', subBuilder: JmaMap_LatLng.create)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'bytes', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap_JmaMapData_JmaMapDataItem clone() => JmaMap_JmaMapData_JmaMapDataItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap_JmaMapData_JmaMapDataItem copyWith(void Function(JmaMap_JmaMapData_JmaMapDataItem) updates) => super.copyWith((message) => updates(message as JmaMap_JmaMapData_JmaMapDataItem)) as JmaMap_JmaMapData_JmaMapDataItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem create() => JmaMap_JmaMapData_JmaMapDataItem._();
  JmaMap_JmaMapData_JmaMapDataItem createEmptyInstance() => create();
  static $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem> createRepeated() => $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap_JmaMapData_JmaMapDataItem>(create);
  static JmaMap_JmaMapData_JmaMapDataItem? _defaultInstance;

  @$pb.TagNumber(1)
  JmaMap_LatLngBounds get bounds => $_getN(0);
  @$pb.TagNumber(1)
  set bounds(JmaMap_LatLngBounds v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBounds() => $_has(0);
  @$pb.TagNumber(1)
  void clearBounds() => $_clearField(1);
  @$pb.TagNumber(1)
  JmaMap_LatLngBounds ensureBounds() => $_ensure(0);

  @$pb.TagNumber(2)
  JmaMap_JmaMapData_JmaMapDataItem_Property get property => $_getN(1);
  @$pb.TagNumber(2)
  set property(JmaMap_JmaMapData_JmaMapDataItem_Property v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasProperty() => $_has(1);
  @$pb.TagNumber(2)
  void clearProperty() => $_clearField(2);
  @$pb.TagNumber(2)
  JmaMap_JmaMapData_JmaMapDataItem_Property ensureProperty() => $_ensure(1);

  @$pb.TagNumber(3)
  JmaMap_LatLng get polylabel => $_getN(2);
  @$pb.TagNumber(3)
  set polylabel(JmaMap_LatLng v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPolylabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolylabel() => $_clearField(3);
  @$pb.TagNumber(3)
  JmaMap_LatLng ensurePolylabel() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$core.int> get bytes => $_getN(3);
  @$pb.TagNumber(4)
  set bytes($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBytes() => $_has(3);
  @$pb.TagNumber(4)
  void clearBytes() => $_clearField(4);
}

class JmaMap_JmaMapData extends $pb.GeneratedMessage {
  factory JmaMap_JmaMapData({
    JmaMap_JmaMapData_JmaMapType? mapType,
    $core.Iterable<JmaMap_JmaMapData_JmaMapDataItem>? data,
  }) {
    final $result = create();
    if (mapType != null) {
      $result.mapType = mapType;
    }
    if (data != null) {
      $result.data.addAll(data);
    }
    return $result;
  }
  JmaMap_JmaMapData._() : super();
  factory JmaMap_JmaMapData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap_JmaMapData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap.JmaMapData', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..e<JmaMap_JmaMapData_JmaMapType>(1, _omitFieldNames ? '' : 'mapType', $pb.PbFieldType.OE, protoName: 'mapType', defaultOrMaker: JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_EEW, valueOf: JmaMap_JmaMapData_JmaMapType.valueOf, enumValues: JmaMap_JmaMapData_JmaMapType.values)
    ..pc<JmaMap_JmaMapData_JmaMapDataItem>(2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PM, subBuilder: JmaMap_JmaMapData_JmaMapDataItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap_JmaMapData clone() => JmaMap_JmaMapData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap_JmaMapData copyWith(void Function(JmaMap_JmaMapData) updates) => super.copyWith((message) => updates(message as JmaMap_JmaMapData)) as JmaMap_JmaMapData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData create() => JmaMap_JmaMapData._();
  JmaMap_JmaMapData createEmptyInstance() => create();
  static $pb.PbList<JmaMap_JmaMapData> createRepeated() => $pb.PbList<JmaMap_JmaMapData>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap_JmaMapData>(create);
  static JmaMap_JmaMapData? _defaultInstance;

  @$pb.TagNumber(1)
  JmaMap_JmaMapData_JmaMapType get mapType => $_getN(0);
  @$pb.TagNumber(1)
  set mapType(JmaMap_JmaMapData_JmaMapType v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMapType() => $_has(0);
  @$pb.TagNumber(1)
  void clearMapType() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem> get data => $_getList(1);
}

class JmaMap_LatLngBounds extends $pb.GeneratedMessage {
  factory JmaMap_LatLngBounds({
    JmaMap_LatLng? southWest,
    JmaMap_LatLng? northEast,
  }) {
    final $result = create();
    if (southWest != null) {
      $result.southWest = southWest;
    }
    if (northEast != null) {
      $result.northEast = northEast;
    }
    return $result;
  }
  JmaMap_LatLngBounds._() : super();
  factory JmaMap_LatLngBounds.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap_LatLngBounds.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap.LatLngBounds', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..aOM<JmaMap_LatLng>(1, _omitFieldNames ? '' : 'southWest', protoName: 'southWest', subBuilder: JmaMap_LatLng.create)
    ..aOM<JmaMap_LatLng>(2, _omitFieldNames ? '' : 'northEast', protoName: 'northEast', subBuilder: JmaMap_LatLng.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap_LatLngBounds clone() => JmaMap_LatLngBounds()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap_LatLngBounds copyWith(void Function(JmaMap_LatLngBounds) updates) => super.copyWith((message) => updates(message as JmaMap_LatLngBounds)) as JmaMap_LatLngBounds;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_LatLngBounds create() => JmaMap_LatLngBounds._();
  JmaMap_LatLngBounds createEmptyInstance() => create();
  static $pb.PbList<JmaMap_LatLngBounds> createRepeated() => $pb.PbList<JmaMap_LatLngBounds>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_LatLngBounds getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap_LatLngBounds>(create);
  static JmaMap_LatLngBounds? _defaultInstance;

  @$pb.TagNumber(1)
  JmaMap_LatLng get southWest => $_getN(0);
  @$pb.TagNumber(1)
  set southWest(JmaMap_LatLng v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSouthWest() => $_has(0);
  @$pb.TagNumber(1)
  void clearSouthWest() => $_clearField(1);
  @$pb.TagNumber(1)
  JmaMap_LatLng ensureSouthWest() => $_ensure(0);

  @$pb.TagNumber(2)
  JmaMap_LatLng get northEast => $_getN(1);
  @$pb.TagNumber(2)
  set northEast(JmaMap_LatLng v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNorthEast() => $_has(1);
  @$pb.TagNumber(2)
  void clearNorthEast() => $_clearField(2);
  @$pb.TagNumber(2)
  JmaMap_LatLng ensureNorthEast() => $_ensure(1);
}

class JmaMap_LatLng extends $pb.GeneratedMessage {
  factory JmaMap_LatLng({
    $core.double? lat,
    $core.double? lng,
  }) {
    final $result = create();
    if (lat != null) {
      $result.lat = lat;
    }
    if (lng != null) {
      $result.lng = lng;
    }
    return $result;
  }
  JmaMap_LatLng._() : super();
  factory JmaMap_LatLng.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap_LatLng.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap.LatLng', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'lat', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'lng', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap_LatLng clone() => JmaMap_LatLng()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap_LatLng copyWith(void Function(JmaMap_LatLng) updates) => super.copyWith((message) => updates(message as JmaMap_LatLng)) as JmaMap_LatLng;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_LatLng create() => JmaMap_LatLng._();
  JmaMap_LatLng createEmptyInstance() => create();
  static $pb.PbList<JmaMap_LatLng> createRepeated() => $pb.PbList<JmaMap_LatLng>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_LatLng getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap_LatLng>(create);
  static JmaMap_LatLng? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get lat => $_getN(0);
  @$pb.TagNumber(1)
  set lat($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLat() => $_has(0);
  @$pb.TagNumber(1)
  void clearLat() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get lng => $_getN(1);
  @$pb.TagNumber(2)
  set lng($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLng() => $_has(1);
  @$pb.TagNumber(2)
  void clearLng() => $_clearField(2);
}

/// TopoJSON関連のメッセージ定義
class JmaMap_TopoJSONMapData extends $pb.GeneratedMessage {
  factory JmaMap_TopoJSONMapData({
    JmaMap_JmaMapData_JmaMapType? mapType,
    $core.String? name,
    $core.Iterable<JmaMap_TopoJSONGeometry>? geometries,
    $core.Iterable<JmaMap_TopoJSONArc>? arcs,
    JmaMap_LatLngBounds? bounds,
  }) {
    final $result = create();
    if (mapType != null) {
      $result.mapType = mapType;
    }
    if (name != null) {
      $result.name = name;
    }
    if (geometries != null) {
      $result.geometries.addAll(geometries);
    }
    if (arcs != null) {
      $result.arcs.addAll(arcs);
    }
    if (bounds != null) {
      $result.bounds = bounds;
    }
    return $result;
  }
  JmaMap_TopoJSONMapData._() : super();
  factory JmaMap_TopoJSONMapData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap_TopoJSONMapData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap.TopoJSONMapData', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..e<JmaMap_JmaMapData_JmaMapType>(1, _omitFieldNames ? '' : 'mapType', $pb.PbFieldType.OE, protoName: 'mapType', defaultOrMaker: JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_EEW, valueOf: JmaMap_JmaMapData_JmaMapType.valueOf, enumValues: JmaMap_JmaMapData_JmaMapType.values)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pc<JmaMap_TopoJSONGeometry>(3, _omitFieldNames ? '' : 'geometries', $pb.PbFieldType.PM, subBuilder: JmaMap_TopoJSONGeometry.create)
    ..pc<JmaMap_TopoJSONArc>(4, _omitFieldNames ? '' : 'arcs', $pb.PbFieldType.PM, subBuilder: JmaMap_TopoJSONArc.create)
    ..aOM<JmaMap_LatLngBounds>(5, _omitFieldNames ? '' : 'bounds', subBuilder: JmaMap_LatLngBounds.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap_TopoJSONMapData clone() => JmaMap_TopoJSONMapData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap_TopoJSONMapData copyWith(void Function(JmaMap_TopoJSONMapData) updates) => super.copyWith((message) => updates(message as JmaMap_TopoJSONMapData)) as JmaMap_TopoJSONMapData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_TopoJSONMapData create() => JmaMap_TopoJSONMapData._();
  JmaMap_TopoJSONMapData createEmptyInstance() => create();
  static $pb.PbList<JmaMap_TopoJSONMapData> createRepeated() => $pb.PbList<JmaMap_TopoJSONMapData>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_TopoJSONMapData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap_TopoJSONMapData>(create);
  static JmaMap_TopoJSONMapData? _defaultInstance;

  @$pb.TagNumber(1)
  JmaMap_JmaMapData_JmaMapType get mapType => $_getN(0);
  @$pb.TagNumber(1)
  set mapType(JmaMap_JmaMapData_JmaMapType v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMapType() => $_has(0);
  @$pb.TagNumber(1)
  void clearMapType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<JmaMap_TopoJSONGeometry> get geometries => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<JmaMap_TopoJSONArc> get arcs => $_getList(3);

  @$pb.TagNumber(5)
  JmaMap_LatLngBounds get bounds => $_getN(4);
  @$pb.TagNumber(5)
  set bounds(JmaMap_LatLngBounds v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasBounds() => $_has(4);
  @$pb.TagNumber(5)
  void clearBounds() => $_clearField(5);
  @$pb.TagNumber(5)
  JmaMap_LatLngBounds ensureBounds() => $_ensure(4);
}

class JmaMap_TopoJSONGeometry extends $pb.GeneratedMessage {
  factory JmaMap_TopoJSONGeometry({
    $core.String? type,
    $core.Iterable<JmaMap_TopoJSONArcIndices>? arcIndices,
    JmaMap_JmaMapData_JmaMapDataItem_Property? property,
    JmaMap_LatLngBounds? bounds,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (arcIndices != null) {
      $result.arcIndices.addAll(arcIndices);
    }
    if (property != null) {
      $result.property = property;
    }
    if (bounds != null) {
      $result.bounds = bounds;
    }
    return $result;
  }
  JmaMap_TopoJSONGeometry._() : super();
  factory JmaMap_TopoJSONGeometry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap_TopoJSONGeometry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap.TopoJSONGeometry', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..pc<JmaMap_TopoJSONArcIndices>(2, _omitFieldNames ? '' : 'arcIndices', $pb.PbFieldType.PM, protoName: 'arcIndices', subBuilder: JmaMap_TopoJSONArcIndices.create)
    ..aOM<JmaMap_JmaMapData_JmaMapDataItem_Property>(3, _omitFieldNames ? '' : 'property', subBuilder: JmaMap_JmaMapData_JmaMapDataItem_Property.create)
    ..aOM<JmaMap_LatLngBounds>(4, _omitFieldNames ? '' : 'bounds', subBuilder: JmaMap_LatLngBounds.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap_TopoJSONGeometry clone() => JmaMap_TopoJSONGeometry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap_TopoJSONGeometry copyWith(void Function(JmaMap_TopoJSONGeometry) updates) => super.copyWith((message) => updates(message as JmaMap_TopoJSONGeometry)) as JmaMap_TopoJSONGeometry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_TopoJSONGeometry create() => JmaMap_TopoJSONGeometry._();
  JmaMap_TopoJSONGeometry createEmptyInstance() => create();
  static $pb.PbList<JmaMap_TopoJSONGeometry> createRepeated() => $pb.PbList<JmaMap_TopoJSONGeometry>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_TopoJSONGeometry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap_TopoJSONGeometry>(create);
  static JmaMap_TopoJSONGeometry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<JmaMap_TopoJSONArcIndices> get arcIndices => $_getList(1);

  @$pb.TagNumber(3)
  JmaMap_JmaMapData_JmaMapDataItem_Property get property => $_getN(2);
  @$pb.TagNumber(3)
  set property(JmaMap_JmaMapData_JmaMapDataItem_Property v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasProperty() => $_has(2);
  @$pb.TagNumber(3)
  void clearProperty() => $_clearField(3);
  @$pb.TagNumber(3)
  JmaMap_JmaMapData_JmaMapDataItem_Property ensureProperty() => $_ensure(2);

  @$pb.TagNumber(4)
  JmaMap_LatLngBounds get bounds => $_getN(3);
  @$pb.TagNumber(4)
  set bounds(JmaMap_LatLngBounds v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasBounds() => $_has(3);
  @$pb.TagNumber(4)
  void clearBounds() => $_clearField(4);
  @$pb.TagNumber(4)
  JmaMap_LatLngBounds ensureBounds() => $_ensure(3);
}

class JmaMap_TopoJSONArcIndices extends $pb.GeneratedMessage {
  factory JmaMap_TopoJSONArcIndices({
    $core.Iterable<$core.int>? indices,
  }) {
    final $result = create();
    if (indices != null) {
      $result.indices.addAll(indices);
    }
    return $result;
  }
  JmaMap_TopoJSONArcIndices._() : super();
  factory JmaMap_TopoJSONArcIndices.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap_TopoJSONArcIndices.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap.TopoJSONArcIndices', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'indices', $pb.PbFieldType.K3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap_TopoJSONArcIndices clone() => JmaMap_TopoJSONArcIndices()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap_TopoJSONArcIndices copyWith(void Function(JmaMap_TopoJSONArcIndices) updates) => super.copyWith((message) => updates(message as JmaMap_TopoJSONArcIndices)) as JmaMap_TopoJSONArcIndices;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_TopoJSONArcIndices create() => JmaMap_TopoJSONArcIndices._();
  JmaMap_TopoJSONArcIndices createEmptyInstance() => create();
  static $pb.PbList<JmaMap_TopoJSONArcIndices> createRepeated() => $pb.PbList<JmaMap_TopoJSONArcIndices>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_TopoJSONArcIndices getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap_TopoJSONArcIndices>(create);
  static JmaMap_TopoJSONArcIndices? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get indices => $_getList(0);
}

class JmaMap_TopoJSONArc extends $pb.GeneratedMessage {
  factory JmaMap_TopoJSONArc({
    $core.Iterable<JmaMap_LatLng>? positions,
    JmaMap_LatLngBounds? bounds,
  }) {
    final $result = create();
    if (positions != null) {
      $result.positions.addAll(positions);
    }
    if (bounds != null) {
      $result.bounds = bounds;
    }
    return $result;
  }
  JmaMap_TopoJSONArc._() : super();
  factory JmaMap_TopoJSONArc.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap_TopoJSONArc.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap.TopoJSONArc', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..pc<JmaMap_LatLng>(1, _omitFieldNames ? '' : 'positions', $pb.PbFieldType.PM, subBuilder: JmaMap_LatLng.create)
    ..aOM<JmaMap_LatLngBounds>(2, _omitFieldNames ? '' : 'bounds', subBuilder: JmaMap_LatLngBounds.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap_TopoJSONArc clone() => JmaMap_TopoJSONArc()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap_TopoJSONArc copyWith(void Function(JmaMap_TopoJSONArc) updates) => super.copyWith((message) => updates(message as JmaMap_TopoJSONArc)) as JmaMap_TopoJSONArc;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_TopoJSONArc create() => JmaMap_TopoJSONArc._();
  JmaMap_TopoJSONArc createEmptyInstance() => create();
  static $pb.PbList<JmaMap_TopoJSONArc> createRepeated() => $pb.PbList<JmaMap_TopoJSONArc>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_TopoJSONArc getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap_TopoJSONArc>(create);
  static JmaMap_TopoJSONArc? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<JmaMap_LatLng> get positions => $_getList(0);

  @$pb.TagNumber(2)
  JmaMap_LatLngBounds get bounds => $_getN(1);
  @$pb.TagNumber(2)
  set bounds(JmaMap_LatLngBounds v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBounds() => $_has(1);
  @$pb.TagNumber(2)
  void clearBounds() => $_clearField(2);
  @$pb.TagNumber(2)
  JmaMap_LatLngBounds ensureBounds() => $_ensure(1);
}

class JmaMap extends $pb.GeneratedMessage {
  factory JmaMap({
    $core.Iterable<JmaMap_JmaMapData>? data,
    $core.Iterable<JmaMap_TopoJSONMapData>? topoJsonData,
  }) {
    final $result = create();
    if (data != null) {
      $result.data.addAll(data);
    }
    if (topoJsonData != null) {
      $result.topoJsonData.addAll(topoJsonData);
    }
    return $result;
  }
  JmaMap._() : super();
  factory JmaMap.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaMap.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaMap', package: const $pb.PackageName(_omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'), createEmptyInstance: create)
    ..pc<JmaMap_JmaMapData>(1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PM, subBuilder: JmaMap_JmaMapData.create)
    ..pc<JmaMap_TopoJSONMapData>(2, _omitFieldNames ? '' : 'topoJsonData', $pb.PbFieldType.PM, protoName: 'topoJsonData', subBuilder: JmaMap_TopoJSONMapData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaMap clone() => JmaMap()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaMap copyWith(void Function(JmaMap) updates) => super.copyWith((message) => updates(message as JmaMap)) as JmaMap;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap create() => JmaMap._();
  JmaMap createEmptyInstance() => create();
  static $pb.PbList<JmaMap> createRepeated() => $pb.PbList<JmaMap>();
  @$core.pragma('dart2js:noInline')
  static JmaMap getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap>(create);
  static JmaMap? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<JmaMap_JmaMapData> get data => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<JmaMap_TopoJSONMapData> get topoJsonData => $_getList(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
