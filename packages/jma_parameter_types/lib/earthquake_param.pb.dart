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

class EarthquakeParameter extends $pb.GeneratedMessage {
  factory EarthquakeParameter({
    $core.Iterable<EarthquakeParameterRegionItem>? regions,
  }) {
    final $result = create();
    if (regions != null) {
      $result.regions.addAll(regions);
    }
    return $result;
  }
  EarthquakeParameter._() : super();
  factory EarthquakeParameter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EarthquakeParameter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EarthquakeParameter', createEmptyInstance: create)
    ..pc<EarthquakeParameterRegionItem>(1, _omitFieldNames ? '' : 'regions', $pb.PbFieldType.PM, subBuilder: EarthquakeParameterRegionItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EarthquakeParameter clone() => EarthquakeParameter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EarthquakeParameter copyWith(void Function(EarthquakeParameter) updates) => super.copyWith((message) => updates(message as EarthquakeParameter)) as EarthquakeParameter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameter create() => EarthquakeParameter._();
  EarthquakeParameter createEmptyInstance() => create();
  static $pb.PbList<EarthquakeParameter> createRepeated() => $pb.PbList<EarthquakeParameter>();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EarthquakeParameter>(create);
  static EarthquakeParameter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<EarthquakeParameterRegionItem> get regions => $_getList(0);
}

class EarthquakeParameterRegionItem extends $pb.GeneratedMessage {
  factory EarthquakeParameterRegionItem({
    $core.String? code,
    $core.String? name,
    $core.Iterable<EarthquakeParameterCityItem>? cities,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (cities != null) {
      $result.cities.addAll(cities);
    }
    return $result;
  }
  EarthquakeParameterRegionItem._() : super();
  factory EarthquakeParameterRegionItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EarthquakeParameterRegionItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EarthquakeParameterRegionItem', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pc<EarthquakeParameterCityItem>(3, _omitFieldNames ? '' : 'cities', $pb.PbFieldType.PM, subBuilder: EarthquakeParameterCityItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EarthquakeParameterRegionItem clone() => EarthquakeParameterRegionItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EarthquakeParameterRegionItem copyWith(void Function(EarthquakeParameterRegionItem) updates) => super.copyWith((message) => updates(message as EarthquakeParameterRegionItem)) as EarthquakeParameterRegionItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterRegionItem create() => EarthquakeParameterRegionItem._();
  EarthquakeParameterRegionItem createEmptyInstance() => create();
  static $pb.PbList<EarthquakeParameterRegionItem> createRepeated() => $pb.PbList<EarthquakeParameterRegionItem>();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterRegionItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterRegionItem>(create);
  static EarthquakeParameterRegionItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<EarthquakeParameterCityItem> get cities => $_getList(2);
}

class EarthquakeParameterCityItem extends $pb.GeneratedMessage {
  factory EarthquakeParameterCityItem({
    $core.String? code,
    $core.String? name,
    $core.Iterable<EarthquakeParameterStationItem>? stations,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (stations != null) {
      $result.stations.addAll(stations);
    }
    return $result;
  }
  EarthquakeParameterCityItem._() : super();
  factory EarthquakeParameterCityItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EarthquakeParameterCityItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EarthquakeParameterCityItem', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pc<EarthquakeParameterStationItem>(3, _omitFieldNames ? '' : 'stations', $pb.PbFieldType.PM, subBuilder: EarthquakeParameterStationItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EarthquakeParameterCityItem clone() => EarthquakeParameterCityItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EarthquakeParameterCityItem copyWith(void Function(EarthquakeParameterCityItem) updates) => super.copyWith((message) => updates(message as EarthquakeParameterCityItem)) as EarthquakeParameterCityItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterCityItem create() => EarthquakeParameterCityItem._();
  EarthquakeParameterCityItem createEmptyInstance() => create();
  static $pb.PbList<EarthquakeParameterCityItem> createRepeated() => $pb.PbList<EarthquakeParameterCityItem>();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterCityItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterCityItem>(create);
  static EarthquakeParameterCityItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<EarthquakeParameterStationItem> get stations => $_getList(2);
}

class EarthquakeParameterStationItem extends $pb.GeneratedMessage {
  factory EarthquakeParameterStationItem({
    $core.String? code,
    $core.String? name,
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (latitude != null) {
      $result.latitude = latitude;
    }
    if (longitude != null) {
      $result.longitude = longitude;
    }
    return $result;
  }
  EarthquakeParameterStationItem._() : super();
  factory EarthquakeParameterStationItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EarthquakeParameterStationItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EarthquakeParameterStationItem', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EarthquakeParameterStationItem clone() => EarthquakeParameterStationItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EarthquakeParameterStationItem copyWith(void Function(EarthquakeParameterStationItem) updates) => super.copyWith((message) => updates(message as EarthquakeParameterStationItem)) as EarthquakeParameterStationItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterStationItem create() => EarthquakeParameterStationItem._();
  EarthquakeParameterStationItem createEmptyInstance() => create();
  static $pb.PbList<EarthquakeParameterStationItem> createRepeated() => $pb.PbList<EarthquakeParameterStationItem>();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterStationItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterStationItem>(create);
  static EarthquakeParameterStationItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get latitude => $_getN(2);
  @$pb.TagNumber(3)
  set latitude($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLatitude() => $_has(2);
  @$pb.TagNumber(3)
  void clearLatitude() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get longitude => $_getN(3);
  @$pb.TagNumber(4)
  set longitude($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLongitude() => $_has(3);
  @$pb.TagNumber(4)
  void clearLongitude() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
