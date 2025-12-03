//
//  Generated code. Do not modify.
//  source: tsunami_param.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TsunamiParameter extends $pb.GeneratedMessage {
  factory TsunamiParameter({
    TsunamiParameterHeader? header,
    $core.Iterable<TsunamiParameterItem>? items,
  }) {
    final $result = create();
    if (header != null) {
      $result.header = header;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  TsunamiParameter._() : super();
  factory TsunamiParameter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TsunamiParameter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TsunamiParameter', createEmptyInstance: create)
    ..aOM<TsunamiParameterHeader>(1, _omitFieldNames ? '' : 'header', subBuilder: TsunamiParameterHeader.create)
    ..pc<TsunamiParameterItem>(2, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: TsunamiParameterItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TsunamiParameter clone() => TsunamiParameter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TsunamiParameter copyWith(void Function(TsunamiParameter) updates) => super.copyWith((message) => updates(message as TsunamiParameter)) as TsunamiParameter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TsunamiParameter create() => TsunamiParameter._();
  TsunamiParameter createEmptyInstance() => create();
  static $pb.PbList<TsunamiParameter> createRepeated() => $pb.PbList<TsunamiParameter>();
  @$core.pragma('dart2js:noInline')
  static TsunamiParameter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TsunamiParameter>(create);
  static TsunamiParameter? _defaultInstance;

  @$pb.TagNumber(1)
  TsunamiParameterHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(TsunamiParameterHeader v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  TsunamiParameterHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<TsunamiParameterItem> get items => $_getList(1);
}

class TsunamiParameterHeader extends $pb.GeneratedMessage {
  factory TsunamiParameterHeader({
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
  TsunamiParameterHeader._() : super();
  factory TsunamiParameterHeader.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TsunamiParameterHeader.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TsunamiParameterHeader', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..aOS(2, _omitFieldNames ? '' : 'changeTime', protoName: 'changeTime')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TsunamiParameterHeader clone() => TsunamiParameterHeader()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TsunamiParameterHeader copyWith(void Function(TsunamiParameterHeader) updates) => super.copyWith((message) => updates(message as TsunamiParameterHeader)) as TsunamiParameterHeader;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TsunamiParameterHeader create() => TsunamiParameterHeader._();
  TsunamiParameterHeader createEmptyInstance() => create();
  static $pb.PbList<TsunamiParameterHeader> createRepeated() => $pb.PbList<TsunamiParameterHeader>();
  @$core.pragma('dart2js:noInline')
  static TsunamiParameterHeader getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TsunamiParameterHeader>(create);
  static TsunamiParameterHeader? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get changeTime => $_getSZ(1);
  @$pb.TagNumber(2)
  set changeTime($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChangeTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearChangeTime() => clearField(2);
}

class TsunamiParameterItem extends $pb.GeneratedMessage {
  factory TsunamiParameterItem({
    $core.String? area,
    $core.String? prefecture,
    $core.String? code,
    $core.String? name,
    $core.String? nameKana,
    $core.String? owner,
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final $result = create();
    if (area != null) {
      $result.area = area;
    }
    if (prefecture != null) {
      $result.prefecture = prefecture;
    }
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (nameKana != null) {
      $result.nameKana = nameKana;
    }
    if (owner != null) {
      $result.owner = owner;
    }
    if (latitude != null) {
      $result.latitude = latitude;
    }
    if (longitude != null) {
      $result.longitude = longitude;
    }
    return $result;
  }
  TsunamiParameterItem._() : super();
  factory TsunamiParameterItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TsunamiParameterItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TsunamiParameterItem', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'area')
    ..aOS(2, _omitFieldNames ? '' : 'prefecture')
    ..aOS(3, _omitFieldNames ? '' : 'code')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..aOS(6, _omitFieldNames ? '' : 'owner')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TsunamiParameterItem clone() => TsunamiParameterItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TsunamiParameterItem copyWith(void Function(TsunamiParameterItem) updates) => super.copyWith((message) => updates(message as TsunamiParameterItem)) as TsunamiParameterItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TsunamiParameterItem create() => TsunamiParameterItem._();
  TsunamiParameterItem createEmptyInstance() => create();
  static $pb.PbList<TsunamiParameterItem> createRepeated() => $pb.PbList<TsunamiParameterItem>();
  @$core.pragma('dart2js:noInline')
  static TsunamiParameterItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TsunamiParameterItem>(create);
  static TsunamiParameterItem? _defaultInstance;

  /// 津波予報区名
  @$pb.TagNumber(1)
  $core.String get area => $_getSZ(0);
  @$pb.TagNumber(1)
  set area($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasArea() => $_has(0);
  @$pb.TagNumber(1)
  void clearArea() => clearField(1);

  /// 都道府県
  @$pb.TagNumber(2)
  $core.String get prefecture => $_getSZ(1);
  @$pb.TagNumber(2)
  set prefecture($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPrefecture() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrefecture() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get nameKana => $_getSZ(4);
  @$pb.TagNumber(5)
  set nameKana($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNameKana() => $_has(4);
  @$pb.TagNumber(5)
  void clearNameKana() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get owner => $_getSZ(5);
  @$pb.TagNumber(6)
  set owner($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOwner() => $_has(5);
  @$pb.TagNumber(6)
  void clearOwner() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get latitude => $_getN(6);
  @$pb.TagNumber(7)
  set latitude($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLatitude() => $_has(6);
  @$pb.TagNumber(7)
  void clearLatitude() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get longitude => $_getN(7);
  @$pb.TagNumber(8)
  set longitude($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLongitude() => $_has(7);
  @$pb.TagNumber(8)
  void clearLongitude() => clearField(8);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
