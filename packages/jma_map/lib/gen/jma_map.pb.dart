// This is a generated file - do not edit.
//
// Generated from jma_map.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'jma_map.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'jma_map.pbenum.dart';

class JmaMap_JmaMapData_JmaMapDataItem_Polygon extends $pb.GeneratedMessage {
  factory JmaMap_JmaMapData_JmaMapDataItem_Polygon({
    $core.Iterable<JmaMap_LatLng>? latLngs,
  }) {
    final result = create();
    if (latLngs != null) result.latLngs.addAll(latLngs);
    return result;
  }

  JmaMap_JmaMapData_JmaMapDataItem_Polygon._();

  factory JmaMap_JmaMapData_JmaMapDataItem_Polygon.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JmaMap_JmaMapData_JmaMapDataItem_Polygon.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap.JmaMapData.JmaMapDataItem.Polygon',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..pPM<JmaMap_LatLng>(1, _omitFieldNames ? '' : 'latLngs',
        protoName: 'latLngs', subBuilder: JmaMap_LatLng.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_JmaMapData_JmaMapDataItem_Polygon clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_JmaMapData_JmaMapDataItem_Polygon copyWith(
          void Function(JmaMap_JmaMapData_JmaMapDataItem_Polygon) updates) =>
      super.copyWith((message) =>
              updates(message as JmaMap_JmaMapData_JmaMapDataItem_Polygon))
          as JmaMap_JmaMapData_JmaMapDataItem_Polygon;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem_Polygon create() =>
      JmaMap_JmaMapData_JmaMapDataItem_Polygon._();
  @$core.override
  JmaMap_JmaMapData_JmaMapDataItem_Polygon createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem_Polygon getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          JmaMap_JmaMapData_JmaMapDataItem_Polygon>(create);
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
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (nameKana != null) result.nameKana = nameKana;
    return result;
  }

  JmaMap_JmaMapData_JmaMapDataItem_Property._();

  factory JmaMap_JmaMapData_JmaMapDataItem_Property.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JmaMap_JmaMapData_JmaMapDataItem_Property.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap.JmaMapData.JmaMapDataItem.Property',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_JmaMapData_JmaMapDataItem_Property clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_JmaMapData_JmaMapDataItem_Property copyWith(
          void Function(JmaMap_JmaMapData_JmaMapDataItem_Property) updates) =>
      super.copyWith((message) =>
              updates(message as JmaMap_JmaMapData_JmaMapDataItem_Property))
          as JmaMap_JmaMapData_JmaMapDataItem_Property;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem_Property create() =>
      JmaMap_JmaMapData_JmaMapDataItem_Property._();
  @$core.override
  JmaMap_JmaMapData_JmaMapDataItem_Property createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem_Property getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          JmaMap_JmaMapData_JmaMapDataItem_Property>(create);
  static JmaMap_JmaMapData_JmaMapDataItem_Property? _defaultInstance;

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
  $core.String get nameKana => $_getSZ(2);
  @$pb.TagNumber(3)
  set nameKana($core.String value) => $_setString(2, value);
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
    JmaMap_JmaMapData_DataType? dataType,
  }) {
    final result = create();
    if (bounds != null) result.bounds = bounds;
    if (property != null) result.property = property;
    if (polylabel != null) result.polylabel = polylabel;
    if (bytes != null) result.bytes = bytes;
    if (dataType != null) result.dataType = dataType;
    return result;
  }

  JmaMap_JmaMapData_JmaMapDataItem._();

  factory JmaMap_JmaMapData_JmaMapDataItem.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JmaMap_JmaMapData_JmaMapDataItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap.JmaMapData.JmaMapDataItem',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..aOM<JmaMap_LatLngBounds>(1, _omitFieldNames ? '' : 'bounds',
        subBuilder: JmaMap_LatLngBounds.create)
    ..aOM<JmaMap_JmaMapData_JmaMapDataItem_Property>(
        2, _omitFieldNames ? '' : 'property',
        subBuilder: JmaMap_JmaMapData_JmaMapDataItem_Property.create)
    ..aOM<JmaMap_LatLng>(3, _omitFieldNames ? '' : 'polylabel',
        subBuilder: JmaMap_LatLng.create)
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'bytes', $pb.PbFieldType.OY)
    ..aE<JmaMap_JmaMapData_DataType>(5, _omitFieldNames ? '' : 'dataType',
        protoName: 'dataType', enumValues: JmaMap_JmaMapData_DataType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_JmaMapData_JmaMapDataItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_JmaMapData_JmaMapDataItem copyWith(
          void Function(JmaMap_JmaMapData_JmaMapDataItem) updates) =>
      super.copyWith(
              (message) => updates(message as JmaMap_JmaMapData_JmaMapDataItem))
          as JmaMap_JmaMapData_JmaMapDataItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem create() =>
      JmaMap_JmaMapData_JmaMapDataItem._();
  @$core.override
  JmaMap_JmaMapData_JmaMapDataItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JmaMap_JmaMapData_JmaMapDataItem>(
          create);
  static JmaMap_JmaMapData_JmaMapDataItem? _defaultInstance;

  @$pb.TagNumber(1)
  JmaMap_LatLngBounds get bounds => $_getN(0);
  @$pb.TagNumber(1)
  set bounds(JmaMap_LatLngBounds value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBounds() => $_has(0);
  @$pb.TagNumber(1)
  void clearBounds() => $_clearField(1);
  @$pb.TagNumber(1)
  JmaMap_LatLngBounds ensureBounds() => $_ensure(0);

  @$pb.TagNumber(2)
  JmaMap_JmaMapData_JmaMapDataItem_Property get property => $_getN(1);
  @$pb.TagNumber(2)
  set property(JmaMap_JmaMapData_JmaMapDataItem_Property value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasProperty() => $_has(1);
  @$pb.TagNumber(2)
  void clearProperty() => $_clearField(2);
  @$pb.TagNumber(2)
  JmaMap_JmaMapData_JmaMapDataItem_Property ensureProperty() => $_ensure(1);

  @$pb.TagNumber(3)
  JmaMap_LatLng get polylabel => $_getN(2);
  @$pb.TagNumber(3)
  set polylabel(JmaMap_LatLng value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPolylabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolylabel() => $_clearField(3);
  @$pb.TagNumber(3)
  JmaMap_LatLng ensurePolylabel() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$core.int> get bytes => $_getN(3);
  @$pb.TagNumber(4)
  set bytes($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBytes() => $_has(3);
  @$pb.TagNumber(4)
  void clearBytes() => $_clearField(4);

  @$pb.TagNumber(5)
  JmaMap_JmaMapData_DataType get dataType => $_getN(4);
  @$pb.TagNumber(5)
  set dataType(JmaMap_JmaMapData_DataType value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDataType() => $_has(4);
  @$pb.TagNumber(5)
  void clearDataType() => $_clearField(5);
}

class JmaMap_JmaMapData extends $pb.GeneratedMessage {
  factory JmaMap_JmaMapData({
    JmaMap_JmaMapData_JmaMapType? mapType,
    $core.Iterable<JmaMap_JmaMapData_JmaMapDataItem>? data,
  }) {
    final result = create();
    if (mapType != null) result.mapType = mapType;
    if (data != null) result.data.addAll(data);
    return result;
  }

  JmaMap_JmaMapData._();

  factory JmaMap_JmaMapData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JmaMap_JmaMapData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap.JmaMapData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..aE<JmaMap_JmaMapData_JmaMapType>(1, _omitFieldNames ? '' : 'mapType',
        protoName: 'mapType', enumValues: JmaMap_JmaMapData_JmaMapType.values)
    ..pPM<JmaMap_JmaMapData_JmaMapDataItem>(2, _omitFieldNames ? '' : 'data',
        subBuilder: JmaMap_JmaMapData_JmaMapDataItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_JmaMapData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_JmaMapData copyWith(void Function(JmaMap_JmaMapData) updates) =>
      super.copyWith((message) => updates(message as JmaMap_JmaMapData))
          as JmaMap_JmaMapData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData create() => JmaMap_JmaMapData._();
  @$core.override
  JmaMap_JmaMapData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JmaMap_JmaMapData>(create);
  static JmaMap_JmaMapData? _defaultInstance;

  @$pb.TagNumber(1)
  JmaMap_JmaMapData_JmaMapType get mapType => $_getN(0);
  @$pb.TagNumber(1)
  set mapType(JmaMap_JmaMapData_JmaMapType value) => $_setField(1, value);
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
    final result = create();
    if (southWest != null) result.southWest = southWest;
    if (northEast != null) result.northEast = northEast;
    return result;
  }

  JmaMap_LatLngBounds._();

  factory JmaMap_LatLngBounds.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JmaMap_LatLngBounds.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap.LatLngBounds',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..aOM<JmaMap_LatLng>(1, _omitFieldNames ? '' : 'southWest',
        protoName: 'southWest', subBuilder: JmaMap_LatLng.create)
    ..aOM<JmaMap_LatLng>(2, _omitFieldNames ? '' : 'northEast',
        protoName: 'northEast', subBuilder: JmaMap_LatLng.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_LatLngBounds clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_LatLngBounds copyWith(void Function(JmaMap_LatLngBounds) updates) =>
      super.copyWith((message) => updates(message as JmaMap_LatLngBounds))
          as JmaMap_LatLngBounds;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_LatLngBounds create() => JmaMap_LatLngBounds._();
  @$core.override
  JmaMap_LatLngBounds createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JmaMap_LatLngBounds getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JmaMap_LatLngBounds>(create);
  static JmaMap_LatLngBounds? _defaultInstance;

  @$pb.TagNumber(1)
  JmaMap_LatLng get southWest => $_getN(0);
  @$pb.TagNumber(1)
  set southWest(JmaMap_LatLng value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSouthWest() => $_has(0);
  @$pb.TagNumber(1)
  void clearSouthWest() => $_clearField(1);
  @$pb.TagNumber(1)
  JmaMap_LatLng ensureSouthWest() => $_ensure(0);

  @$pb.TagNumber(2)
  JmaMap_LatLng get northEast => $_getN(1);
  @$pb.TagNumber(2)
  set northEast(JmaMap_LatLng value) => $_setField(2, value);
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
    final result = create();
    if (lat != null) result.lat = lat;
    if (lng != null) result.lng = lng;
    return result;
  }

  JmaMap_LatLng._();

  factory JmaMap_LatLng.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JmaMap_LatLng.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap.LatLng',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'lat')
    ..aD(2, _omitFieldNames ? '' : 'lng')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_LatLng clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap_LatLng copyWith(void Function(JmaMap_LatLng) updates) =>
      super.copyWith((message) => updates(message as JmaMap_LatLng))
          as JmaMap_LatLng;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_LatLng create() => JmaMap_LatLng._();
  @$core.override
  JmaMap_LatLng createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JmaMap_LatLng getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JmaMap_LatLng>(create);
  static JmaMap_LatLng? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get lat => $_getN(0);
  @$pb.TagNumber(1)
  set lat($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLat() => $_has(0);
  @$pb.TagNumber(1)
  void clearLat() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get lng => $_getN(1);
  @$pb.TagNumber(2)
  set lng($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLng() => $_has(1);
  @$pb.TagNumber(2)
  void clearLng() => $_clearField(2);
}

class JmaMap extends $pb.GeneratedMessage {
  factory JmaMap({
    $core.Iterable<JmaMap_JmaMapData>? data,
  }) {
    final result = create();
    if (data != null) result.data.addAll(data);
    return result;
  }

  JmaMap._();

  factory JmaMap.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JmaMap.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..pPM<JmaMap_JmaMapData>(1, _omitFieldNames ? '' : 'data',
        subBuilder: JmaMap_JmaMapData.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaMap copyWith(void Function(JmaMap) updates) =>
      super.copyWith((message) => updates(message as JmaMap)) as JmaMap;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap create() => JmaMap._();
  @$core.override
  JmaMap createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JmaMap getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap>(create);
  static JmaMap? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<JmaMap_JmaMapData> get data => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
