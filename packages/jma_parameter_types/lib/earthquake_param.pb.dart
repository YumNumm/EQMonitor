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

import 'earthquake_param.pbenum.dart';

export 'earthquake_param.pbenum.dart';

class EarthquakeParameter extends $pb.GeneratedMessage {
  factory EarthquakeParameter({
    EarthquakeParameterHeader? header,
    $core.Iterable<EarthquakeParameterRegionItem>? regions,
  }) {
    final $result = create();
    if (header != null) {
      $result.header = header;
    }
    if (regions != null) {
      $result.regions.addAll(regions);
    }
    return $result;
  }
  EarthquakeParameter._() : super();
  factory EarthquakeParameter.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EarthquakeParameter.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarthquakeParameter',
      createEmptyInstance: create)
    ..aOM<EarthquakeParameterHeader>(1, _omitFieldNames ? '' : 'header',
        subBuilder: EarthquakeParameterHeader.create)
    ..pc<EarthquakeParameterRegionItem>(
        2, _omitFieldNames ? '' : 'regions', $pb.PbFieldType.PM,
        subBuilder: EarthquakeParameterRegionItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EarthquakeParameter clone() => EarthquakeParameter()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EarthquakeParameter copyWith(void Function(EarthquakeParameter) updates) =>
      super.copyWith((message) => updates(message as EarthquakeParameter))
          as EarthquakeParameter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameter create() => EarthquakeParameter._();
  EarthquakeParameter createEmptyInstance() => create();
  static $pb.PbList<EarthquakeParameter> createRepeated() =>
      $pb.PbList<EarthquakeParameter>();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarthquakeParameter>(create);
  static EarthquakeParameter? _defaultInstance;

  @$pb.TagNumber(1)
  EarthquakeParameterHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(EarthquakeParameterHeader v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  EarthquakeParameterHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<EarthquakeParameterRegionItem> get regions => $_getList(1);
}

class EarthquakeParameterHeader extends $pb.GeneratedMessage {
  factory EarthquakeParameterHeader({
    $core.String? version,
    $core.String? changeTime,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    if (changeTime != null) {
      $result.changeTime = changeTime;
    }
    return $result;
  }
  EarthquakeParameterHeader._() : super();
  factory EarthquakeParameterHeader.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EarthquakeParameterHeader.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarthquakeParameterHeader',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..aOS(2, _omitFieldNames ? '' : 'changeTime', protoName: 'changeTime')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EarthquakeParameterHeader clone() =>
      EarthquakeParameterHeader()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EarthquakeParameterHeader copyWith(
          void Function(EarthquakeParameterHeader) updates) =>
      super.copyWith((message) => updates(message as EarthquakeParameterHeader))
          as EarthquakeParameterHeader;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterHeader create() => EarthquakeParameterHeader._();
  EarthquakeParameterHeader createEmptyInstance() => create();
  static $pb.PbList<EarthquakeParameterHeader> createRepeated() =>
      $pb.PbList<EarthquakeParameterHeader>();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterHeader getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterHeader>(create);
  static EarthquakeParameterHeader? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get changeTime => $_getSZ(1);
  @$pb.TagNumber(2)
  set changeTime($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasChangeTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearChangeTime() => clearField(2);
}

class EarthquakeParameterRegionItem extends $pb.GeneratedMessage {
  factory EarthquakeParameterRegionItem({
    $core.String? code,
    $core.String? name,
    $core.String? nameKana,
    $core.Iterable<EarthquakeParameterCityItem>? cities,
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
    if (cities != null) {
      $result.cities.addAll(cities);
    }
    return $result;
  }
  EarthquakeParameterRegionItem._() : super();
  factory EarthquakeParameterRegionItem.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EarthquakeParameterRegionItem.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarthquakeParameterRegionItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..pc<EarthquakeParameterCityItem>(
        4, _omitFieldNames ? '' : 'cities', $pb.PbFieldType.PM,
        subBuilder: EarthquakeParameterCityItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EarthquakeParameterRegionItem clone() =>
      EarthquakeParameterRegionItem()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EarthquakeParameterRegionItem copyWith(
          void Function(EarthquakeParameterRegionItem) updates) =>
      super.copyWith(
              (message) => updates(message as EarthquakeParameterRegionItem))
          as EarthquakeParameterRegionItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterRegionItem create() =>
      EarthquakeParameterRegionItem._();
  EarthquakeParameterRegionItem createEmptyInstance() => create();
  static $pb.PbList<EarthquakeParameterRegionItem> createRepeated() =>
      $pb.PbList<EarthquakeParameterRegionItem>();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterRegionItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterRegionItem>(create);
  static EarthquakeParameterRegionItem? _defaultInstance;

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

  @$pb.TagNumber(4)
  $core.List<EarthquakeParameterCityItem> get cities => $_getList(3);
}

class EarthquakeParameterCityItem extends $pb.GeneratedMessage {
  factory EarthquakeParameterCityItem({
    $core.String? code,
    $core.String? name,
    $core.String? nameKana,
    $core.Iterable<EarthquakeParameterStationItem>? stations,
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
    if (stations != null) {
      $result.stations.addAll(stations);
    }
    return $result;
  }
  EarthquakeParameterCityItem._() : super();
  factory EarthquakeParameterCityItem.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EarthquakeParameterCityItem.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarthquakeParameterCityItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..pc<EarthquakeParameterStationItem>(
        4, _omitFieldNames ? '' : 'stations', $pb.PbFieldType.PM,
        subBuilder: EarthquakeParameterStationItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EarthquakeParameterCityItem clone() =>
      EarthquakeParameterCityItem()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EarthquakeParameterCityItem copyWith(
          void Function(EarthquakeParameterCityItem) updates) =>
      super.copyWith(
              (message) => updates(message as EarthquakeParameterCityItem))
          as EarthquakeParameterCityItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterCityItem create() =>
      EarthquakeParameterCityItem._();
  EarthquakeParameterCityItem createEmptyInstance() => create();
  static $pb.PbList<EarthquakeParameterCityItem> createRepeated() =>
      $pb.PbList<EarthquakeParameterCityItem>();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterCityItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterCityItem>(create);
  static EarthquakeParameterCityItem? _defaultInstance;

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

  @$pb.TagNumber(4)
  $core.List<EarthquakeParameterStationItem> get stations => $_getList(3);
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
    if (latitude != null) {
      $result.latitude = latitude;
    }
    if (longitude != null) {
      $result.longitude = longitude;
    }
    if (status != null) {
      $result.status = status;
    }
    if (owner != null) {
      $result.owner = owner;
    }
    if (arv400 != null) {
      $result.arv400 = arv400;
    }
    return $result;
  }
  EarthquakeParameterStationItem._() : super();
  factory EarthquakeParameterStationItem.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EarthquakeParameterStationItem.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarthquakeParameterStationItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OD)
    ..e<StationStatus>(6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: StationStatus.OPERATIONAL,
        valueOf: StationStatus.valueOf,
        enumValues: StationStatus.values)
    ..e<StationOwner>(7, _omitFieldNames ? '' : 'owner', $pb.PbFieldType.OE,
        defaultOrMaker: StationOwner.JMA,
        valueOf: StationOwner.valueOf,
        enumValues: StationOwner.values)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'arv400', $pb.PbFieldType.OD,
        protoName: 'arv_400')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EarthquakeParameterStationItem clone() =>
      EarthquakeParameterStationItem()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EarthquakeParameterStationItem copyWith(
          void Function(EarthquakeParameterStationItem) updates) =>
      super.copyWith(
              (message) => updates(message as EarthquakeParameterStationItem))
          as EarthquakeParameterStationItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterStationItem create() =>
      EarthquakeParameterStationItem._();
  EarthquakeParameterStationItem createEmptyInstance() => create();
  static $pb.PbList<EarthquakeParameterStationItem> createRepeated() =>
      $pb.PbList<EarthquakeParameterStationItem>();
  @$core.pragma('dart2js:noInline')
  static EarthquakeParameterStationItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarthquakeParameterStationItem>(create);
  static EarthquakeParameterStationItem? _defaultInstance;

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

  @$pb.TagNumber(4)
  $core.double get latitude => $_getN(3);
  @$pb.TagNumber(4)
  set latitude($core.double v) {
    $_setDouble(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasLatitude() => $_has(3);
  @$pb.TagNumber(4)
  void clearLatitude() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get longitude => $_getN(4);
  @$pb.TagNumber(5)
  set longitude($core.double v) {
    $_setDouble(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasLongitude() => $_has(4);
  @$pb.TagNumber(5)
  void clearLongitude() => clearField(5);

  @$pb.TagNumber(6)
  StationStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(StationStatus v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  StationOwner get owner => $_getN(6);
  @$pb.TagNumber(7)
  set owner(StationOwner v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasOwner() => $_has(6);
  @$pb.TagNumber(7)
  void clearOwner() => clearField(7);

  /// 工学的基盤（Vs=400m/s）から地表に至る最大速度の増幅率
  @$pb.TagNumber(8)
  $core.double get arv400 => $_getN(7);
  @$pb.TagNumber(8)
  set arv400($core.double v) {
    $_setDouble(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasArv400() => $_has(7);
  @$pb.TagNumber(8)
  void clearArv400() => clearField(8);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
