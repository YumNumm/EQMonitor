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

import 'earthquake_param.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'earthquake_param.pbenum.dart';

class EarthquakeParameter extends $pb.GeneratedMessage {
  factory EarthquakeParameter({
    EarthquakeParameterHeader? header,
    $core.Iterable<EarthquakeParameterRegionItem>? regions,
  }) {
    final result = create();
    if (header != null) result.header = header;
    if (regions != null) result.regions.addAll(regions);
    return result;
  }

  EarthquakeParameter._();

  factory EarthquakeParameter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EarthquakeParameter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarthquakeParameter',
      createEmptyInstance: create)
    ..aOM<EarthquakeParameterHeader>(1, _omitFieldNames ? '' : 'header',
        subBuilder: EarthquakeParameterHeader.create)
    ..pPM<EarthquakeParameterRegionItem>(2, _omitFieldNames ? '' : 'regions',
        subBuilder: EarthquakeParameterRegionItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarthquakeParameter clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarthquakeParameter copyWith(void Function(EarthquakeParameter) updates) =>
      super.copyWith((message) => updates(message as EarthquakeParameter))
          as EarthquakeParameter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameter create() => EarthquakeParameter._();
  @$core.override
  EarthquakeParameter createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarthquakeParameter>(create);
  static EarthquakeParameter? _defaultInstance;

  @$pb.TagNumber(1)
  EarthquakeParameterHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(EarthquakeParameterHeader value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => $_clearField(1);
  @$pb.TagNumber(1)
  EarthquakeParameterHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<EarthquakeParameterRegionItem> get regions => $_getList(1);
}

class EarthquakeParameterHeader extends $pb.GeneratedMessage {
  factory EarthquakeParameterHeader({
    $core.String? version,
    $core.String? changeTime,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (changeTime != null) result.changeTime = changeTime;
    return result;
  }

  EarthquakeParameterHeader._();

  factory EarthquakeParameterHeader.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EarthquakeParameterHeader.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarthquakeParameterHeader',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..aOS(2, _omitFieldNames ? '' : 'changeTime', protoName: 'changeTime')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarthquakeParameterHeader clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarthquakeParameterHeader copyWith(
          void Function(EarthquakeParameterHeader) updates) =>
      super.copyWith((message) => updates(message as EarthquakeParameterHeader))
          as EarthquakeParameterHeader;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterHeader create() => EarthquakeParameterHeader._();
  @$core.override
  EarthquakeParameterHeader createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterHeader getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterHeader>(create);
  static EarthquakeParameterHeader? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get changeTime => $_getSZ(1);
  @$pb.TagNumber(2)
  set changeTime($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChangeTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearChangeTime() => $_clearField(2);
}

class EarthquakeParameterRegionItem extends $pb.GeneratedMessage {
  factory EarthquakeParameterRegionItem({
    $core.String? code,
    $core.String? name,
    $core.String? nameKana,
    $core.Iterable<EarthquakeParameterCityItem>? cities,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (nameKana != null) result.nameKana = nameKana;
    if (cities != null) result.cities.addAll(cities);
    return result;
  }

  EarthquakeParameterRegionItem._();

  factory EarthquakeParameterRegionItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EarthquakeParameterRegionItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarthquakeParameterRegionItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..pPM<EarthquakeParameterCityItem>(4, _omitFieldNames ? '' : 'cities',
        subBuilder: EarthquakeParameterCityItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarthquakeParameterRegionItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarthquakeParameterRegionItem copyWith(
          void Function(EarthquakeParameterRegionItem) updates) =>
      super.copyWith(
              (message) => updates(message as EarthquakeParameterRegionItem))
          as EarthquakeParameterRegionItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterRegionItem create() =>
      EarthquakeParameterRegionItem._();
  @$core.override
  EarthquakeParameterRegionItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterRegionItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterRegionItem>(create);
  static EarthquakeParameterRegionItem? _defaultInstance;

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

  @$pb.TagNumber(4)
  $pb.PbList<EarthquakeParameterCityItem> get cities => $_getList(3);
}

class EarthquakeParameterCityItem extends $pb.GeneratedMessage {
  factory EarthquakeParameterCityItem({
    $core.String? code,
    $core.String? name,
    $core.String? nameKana,
    $core.Iterable<EarthquakeParameterStationItem>? stations,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (nameKana != null) result.nameKana = nameKana;
    if (stations != null) result.stations.addAll(stations);
    return result;
  }

  EarthquakeParameterCityItem._();

  factory EarthquakeParameterCityItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EarthquakeParameterCityItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarthquakeParameterCityItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..pPM<EarthquakeParameterStationItem>(4, _omitFieldNames ? '' : 'stations',
        subBuilder: EarthquakeParameterStationItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarthquakeParameterCityItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarthquakeParameterCityItem copyWith(
          void Function(EarthquakeParameterCityItem) updates) =>
      super.copyWith(
              (message) => updates(message as EarthquakeParameterCityItem))
          as EarthquakeParameterCityItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterCityItem create() =>
      EarthquakeParameterCityItem._();
  @$core.override
  EarthquakeParameterCityItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterCityItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterCityItem>(create);
  static EarthquakeParameterCityItem? _defaultInstance;

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

  @$pb.TagNumber(4)
  $pb.PbList<EarthquakeParameterStationItem> get stations => $_getList(3);
}

class EarthquakeParameterStationItem extends $pb.GeneratedMessage {
  factory EarthquakeParameterStationItem({
    $core.String? code,
    $core.String? name,
    $core.String? nameKana,
    $core.double? latitude,
    $core.double? longitude,
    StationStatus? status,
    StationOwner? owner,
    $core.double? arv400,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (nameKana != null) result.nameKana = nameKana;
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    if (status != null) result.status = status;
    if (owner != null) result.owner = owner;
    if (arv400 != null) result.arv400 = arv400;
    return result;
  }

  EarthquakeParameterStationItem._();

  factory EarthquakeParameterStationItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EarthquakeParameterStationItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarthquakeParameterStationItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..aD(4, _omitFieldNames ? '' : 'latitude')
    ..aD(5, _omitFieldNames ? '' : 'longitude')
    ..aE<StationStatus>(6, _omitFieldNames ? '' : 'status',
        enumValues: StationStatus.values)
    ..aE<StationOwner>(7, _omitFieldNames ? '' : 'owner',
        enumValues: StationOwner.values)
    ..aD(8, _omitFieldNames ? '' : 'arv400', protoName: 'arv_400')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarthquakeParameterStationItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarthquakeParameterStationItem copyWith(
          void Function(EarthquakeParameterStationItem) updates) =>
      super.copyWith(
              (message) => updates(message as EarthquakeParameterStationItem))
          as EarthquakeParameterStationItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterStationItem create() =>
      EarthquakeParameterStationItem._();
  @$core.override
  EarthquakeParameterStationItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterStationItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterStationItem>(create);
  static EarthquakeParameterStationItem? _defaultInstance;

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

  @$pb.TagNumber(4)
  $core.double get latitude => $_getN(3);
  @$pb.TagNumber(4)
  set latitude($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLatitude() => $_has(3);
  @$pb.TagNumber(4)
  void clearLatitude() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get longitude => $_getN(4);
  @$pb.TagNumber(5)
  set longitude($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLongitude() => $_has(4);
  @$pb.TagNumber(5)
  void clearLongitude() => $_clearField(5);

  @$pb.TagNumber(6)
  StationStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(StationStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  StationOwner get owner => $_getN(6);
  @$pb.TagNumber(7)
  set owner(StationOwner value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasOwner() => $_has(6);
  @$pb.TagNumber(7)
  void clearOwner() => $_clearField(7);

  /// 工学的基盤（Vs=400m/s）から地表に至る最大速度の増幅率
  @$pb.TagNumber(8)
  $core.double get arv400 => $_getN(7);
  @$pb.TagNumber(8)
  set arv400($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasArv400() => $_has(7);
  @$pb.TagNumber(8)
  void clearArv400() => $_clearField(8);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
