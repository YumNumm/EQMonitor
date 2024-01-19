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

import 'package:jma_map/gen/jma_map.pbenum.dart';

export 'jma_map.pbenum.dart';

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
  factory JmaMap_JmaMapData_JmaMapDataItem_Property.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JmaMap_JmaMapData_JmaMapDataItem_Property.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap.JmaMapData.JmaMapDataItem.Property',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JmaMap_JmaMapData_JmaMapDataItem_Property clone() =>
      JmaMap_JmaMapData_JmaMapDataItem_Property()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JmaMap_JmaMapData_JmaMapDataItem_Property copyWith(
          void Function(JmaMap_JmaMapData_JmaMapDataItem_Property) updates) =>
      super.copyWith((message) =>
              updates(message as JmaMap_JmaMapData_JmaMapDataItem_Property))
          as JmaMap_JmaMapData_JmaMapDataItem_Property;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem_Property create() =>
      JmaMap_JmaMapData_JmaMapDataItem_Property._();
  JmaMap_JmaMapData_JmaMapDataItem_Property createEmptyInstance() => create();
  static $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem_Property>
      createRepeated() =>
          $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem_Property>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem_Property getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          JmaMap_JmaMapData_JmaMapDataItem_Property>(create);
  static JmaMap_JmaMapData_JmaMapDataItem_Property? _defaultInstance;

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
  $core.String get nameKana => $_getSZ(2);
  @$pb.TagNumber(3)
  set nameKana($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNameKana() => $_has(2);
  @$pb.TagNumber(3)
  void clearNameKana() => clearField(3);
}

class JmaMap_JmaMapData_JmaMapDataItem extends $pb.GeneratedMessage {
  factory JmaMap_JmaMapData_JmaMapDataItem({
    LatLngBounds? bounds,
    JmaMap_JmaMapData_JmaMapDataItem_Property? property,
  }) {
    final $result = create();
    if (bounds != null) {
      $result.bounds = bounds;
    }
    if (property != null) {
      $result.property = property;
    }
    return $result;
  }
  JmaMap_JmaMapData_JmaMapDataItem._() : super();
  factory JmaMap_JmaMapData_JmaMapDataItem.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JmaMap_JmaMapData_JmaMapDataItem.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap.JmaMapData.JmaMapDataItem',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..aOM<LatLngBounds>(1, _omitFieldNames ? '' : 'bounds',
        subBuilder: LatLngBounds.create)
    ..aOM<JmaMap_JmaMapData_JmaMapDataItem_Property>(
        2, _omitFieldNames ? '' : 'property',
        subBuilder: JmaMap_JmaMapData_JmaMapDataItem_Property.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JmaMap_JmaMapData_JmaMapDataItem clone() =>
      JmaMap_JmaMapData_JmaMapDataItem()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JmaMap_JmaMapData_JmaMapDataItem copyWith(
          void Function(JmaMap_JmaMapData_JmaMapDataItem) updates) =>
      super.copyWith(
              (message) => updates(message as JmaMap_JmaMapData_JmaMapDataItem))
          as JmaMap_JmaMapData_JmaMapDataItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem create() =>
      JmaMap_JmaMapData_JmaMapDataItem._();
  JmaMap_JmaMapData_JmaMapDataItem createEmptyInstance() => create();
  static $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem> createRepeated() =>
      $pb.PbList<JmaMap_JmaMapData_JmaMapDataItem>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData_JmaMapDataItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JmaMap_JmaMapData_JmaMapDataItem>(
          create);
  static JmaMap_JmaMapData_JmaMapDataItem? _defaultInstance;

  @$pb.TagNumber(1)
  LatLngBounds get bounds => $_getN(0);
  @$pb.TagNumber(1)
  set bounds(LatLngBounds v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBounds() => $_has(0);
  @$pb.TagNumber(1)
  void clearBounds() => clearField(1);
  @$pb.TagNumber(1)
  LatLngBounds ensureBounds() => $_ensure(0);

  @$pb.TagNumber(2)
  JmaMap_JmaMapData_JmaMapDataItem_Property get property => $_getN(1);
  @$pb.TagNumber(2)
  set property(JmaMap_JmaMapData_JmaMapDataItem_Property v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProperty() => $_has(1);
  @$pb.TagNumber(2)
  void clearProperty() => clearField(2);
  @$pb.TagNumber(2)
  JmaMap_JmaMapData_JmaMapDataItem_Property ensureProperty() => $_ensure(1);
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
  factory JmaMap_JmaMapData.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JmaMap_JmaMapData.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap.JmaMapData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..e<JmaMap_JmaMapData_JmaMapType>(
        1, _omitFieldNames ? '' : 'mapType', $pb.PbFieldType.OE,
        protoName: 'mapType',
        defaultOrMaker: JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_EEW,
        valueOf: JmaMap_JmaMapData_JmaMapType.valueOf,
        enumValues: JmaMap_JmaMapData_JmaMapType.values)
    ..pc<JmaMap_JmaMapData_JmaMapDataItem>(
        2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PM,
        subBuilder: JmaMap_JmaMapData_JmaMapDataItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JmaMap_JmaMapData clone() => JmaMap_JmaMapData()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JmaMap_JmaMapData copyWith(void Function(JmaMap_JmaMapData) updates) =>
      super.copyWith((message) => updates(message as JmaMap_JmaMapData))
          as JmaMap_JmaMapData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData create() => JmaMap_JmaMapData._();
  JmaMap_JmaMapData createEmptyInstance() => create();
  static $pb.PbList<JmaMap_JmaMapData> createRepeated() =>
      $pb.PbList<JmaMap_JmaMapData>();
  @$core.pragma('dart2js:noInline')
  static JmaMap_JmaMapData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JmaMap_JmaMapData>(create);
  static JmaMap_JmaMapData? _defaultInstance;

  @$pb.TagNumber(1)
  JmaMap_JmaMapData_JmaMapType get mapType => $_getN(0);
  @$pb.TagNumber(1)
  set mapType(JmaMap_JmaMapData_JmaMapType v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMapType() => $_has(0);
  @$pb.TagNumber(1)
  void clearMapType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<JmaMap_JmaMapData_JmaMapDataItem> get data => $_getList(1);
}

class JmaMap extends $pb.GeneratedMessage {
  factory JmaMap({
    $core.Iterable<JmaMap_JmaMapData>? data,
  }) {
    final $result = create();
    if (data != null) {
      $result.data.addAll(data);
    }
    return $result;
  }
  JmaMap._() : super();
  factory JmaMap.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JmaMap.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaMap',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..pc<JmaMap_JmaMapData>(
        1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PM,
        subBuilder: JmaMap_JmaMapData.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JmaMap clone() => JmaMap()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JmaMap copyWith(void Function(JmaMap) updates) =>
      super.copyWith((message) => updates(message as JmaMap)) as JmaMap;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaMap create() => JmaMap._();
  JmaMap createEmptyInstance() => create();
  static $pb.PbList<JmaMap> createRepeated() => $pb.PbList<JmaMap>();
  @$core.pragma('dart2js:noInline')
  static JmaMap getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaMap>(create);
  static JmaMap? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<JmaMap_JmaMapData> get data => $_getList(0);
}

class LatLngBounds extends $pb.GeneratedMessage {
  factory LatLngBounds({
    LatLng? southWest,
    LatLng? northEast,
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
  LatLngBounds._() : super();
  factory LatLngBounds.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LatLngBounds.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LatLngBounds',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..aOM<LatLng>(1, _omitFieldNames ? '' : 'southWest',
        protoName: 'southWest', subBuilder: LatLng.create)
    ..aOM<LatLng>(2, _omitFieldNames ? '' : 'northEast',
        protoName: 'northEast', subBuilder: LatLng.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LatLngBounds clone() => LatLngBounds()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LatLngBounds copyWith(void Function(LatLngBounds) updates) =>
      super.copyWith((message) => updates(message as LatLngBounds))
          as LatLngBounds;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LatLngBounds create() => LatLngBounds._();
  LatLngBounds createEmptyInstance() => create();
  static $pb.PbList<LatLngBounds> createRepeated() =>
      $pb.PbList<LatLngBounds>();
  @$core.pragma('dart2js:noInline')
  static LatLngBounds getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LatLngBounds>(create);
  static LatLngBounds? _defaultInstance;

  @$pb.TagNumber(1)
  LatLng get southWest => $_getN(0);
  @$pb.TagNumber(1)
  set southWest(LatLng v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSouthWest() => $_has(0);
  @$pb.TagNumber(1)
  void clearSouthWest() => clearField(1);
  @$pb.TagNumber(1)
  LatLng ensureSouthWest() => $_ensure(0);

  @$pb.TagNumber(2)
  LatLng get northEast => $_getN(1);
  @$pb.TagNumber(2)
  set northEast(LatLng v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNorthEast() => $_has(1);
  @$pb.TagNumber(2)
  void clearNorthEast() => clearField(2);
  @$pb.TagNumber(2)
  LatLng ensureNorthEast() => $_ensure(1);
}

class LatLng extends $pb.GeneratedMessage {
  factory LatLng({
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
  LatLng._() : super();
  factory LatLng.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LatLng.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LatLng',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'net.yumnumm.eqmonitor.jma_map'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'lat', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'lng', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LatLng clone() => LatLng()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LatLng copyWith(void Function(LatLng) updates) =>
      super.copyWith((message) => updates(message as LatLng)) as LatLng;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LatLng create() => LatLng._();
  LatLng createEmptyInstance() => create();
  static $pb.PbList<LatLng> createRepeated() => $pb.PbList<LatLng>();
  @$core.pragma('dart2js:noInline')
  static LatLng getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LatLng>(create);
  static LatLng? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get lat => $_getN(0);
  @$pb.TagNumber(1)
  set lat($core.double v) {
    $_setDouble(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLat() => $_has(0);
  @$pb.TagNumber(1)
  void clearLat() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get lng => $_getN(1);
  @$pb.TagNumber(2)
  set lng($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLng() => $_has(1);
  @$pb.TagNumber(2)
  void clearLng() => clearField(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
