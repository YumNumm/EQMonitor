// This is a generated file - do not edit.
//
// Generated from tsunami_param.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class TsunamiParameter extends $pb.GeneratedMessage {
  factory TsunamiParameter({
    TsunamiParameterHeader? header,
    $core.Iterable<TsunamiParameterItem>? items,
  }) {
    final result = create();
    if (header != null) result.header = header;
    if (items != null) result.items.addAll(items);
    return result;
  }

  TsunamiParameter._();

  factory TsunamiParameter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TsunamiParameter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TsunamiParameter',
      createEmptyInstance: create)
    ..aOM<TsunamiParameterHeader>(1, _omitFieldNames ? '' : 'header',
        subBuilder: TsunamiParameterHeader.create)
    ..pPM<TsunamiParameterItem>(2, _omitFieldNames ? '' : 'items',
        subBuilder: TsunamiParameterItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TsunamiParameter clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TsunamiParameter copyWith(void Function(TsunamiParameter) updates) =>
      super.copyWith((message) => updates(message as TsunamiParameter))
          as TsunamiParameter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TsunamiParameter create() => TsunamiParameter._();
  @$core.override
  TsunamiParameter createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TsunamiParameter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TsunamiParameter>(create);
  static TsunamiParameter? _defaultInstance;

  @$pb.TagNumber(1)
  TsunamiParameterHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(TsunamiParameterHeader value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => $_clearField(1);
  @$pb.TagNumber(1)
  TsunamiParameterHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<TsunamiParameterItem> get items => $_getList(1);
}

class TsunamiParameterHeader extends $pb.GeneratedMessage {
  factory TsunamiParameterHeader({
    $core.String? version,
    $core.String? changeTime,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (changeTime != null) result.changeTime = changeTime;
    return result;
  }

  TsunamiParameterHeader._();

  factory TsunamiParameterHeader.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TsunamiParameterHeader.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TsunamiParameterHeader',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..aOS(2, _omitFieldNames ? '' : 'changeTime', protoName: 'changeTime')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TsunamiParameterHeader clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TsunamiParameterHeader copyWith(
          void Function(TsunamiParameterHeader) updates) =>
      super.copyWith((message) => updates(message as TsunamiParameterHeader))
          as TsunamiParameterHeader;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TsunamiParameterHeader create() => TsunamiParameterHeader._();
  @$core.override
  TsunamiParameterHeader createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TsunamiParameterHeader getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TsunamiParameterHeader>(create);
  static TsunamiParameterHeader? _defaultInstance;

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
    final result = create();
    if (area != null) result.area = area;
    if (prefecture != null) result.prefecture = prefecture;
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (nameKana != null) result.nameKana = nameKana;
    if (owner != null) result.owner = owner;
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    return result;
  }

  TsunamiParameterItem._();

  factory TsunamiParameterItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TsunamiParameterItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TsunamiParameterItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'area')
    ..aOS(2, _omitFieldNames ? '' : 'prefecture')
    ..aOS(3, _omitFieldNames ? '' : 'code')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'nameKana', protoName: 'nameKana')
    ..aOS(6, _omitFieldNames ? '' : 'owner')
    ..aD(7, _omitFieldNames ? '' : 'latitude')
    ..aD(8, _omitFieldNames ? '' : 'longitude')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TsunamiParameterItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TsunamiParameterItem copyWith(void Function(TsunamiParameterItem) updates) =>
      super.copyWith((message) => updates(message as TsunamiParameterItem))
          as TsunamiParameterItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TsunamiParameterItem create() => TsunamiParameterItem._();
  @$core.override
  TsunamiParameterItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TsunamiParameterItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TsunamiParameterItem>(create);
  static TsunamiParameterItem? _defaultInstance;

  /// 津波予報区名
  @$pb.TagNumber(1)
  $core.String get area => $_getSZ(0);
  @$pb.TagNumber(1)
  set area($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasArea() => $_has(0);
  @$pb.TagNumber(1)
  void clearArea() => $_clearField(1);

  /// 都道府県
  @$pb.TagNumber(2)
  $core.String get prefecture => $_getSZ(1);
  @$pb.TagNumber(2)
  set prefecture($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPrefecture() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrefecture() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get nameKana => $_getSZ(4);
  @$pb.TagNumber(5)
  set nameKana($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNameKana() => $_has(4);
  @$pb.TagNumber(5)
  void clearNameKana() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get owner => $_getSZ(5);
  @$pb.TagNumber(6)
  set owner($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOwner() => $_has(5);
  @$pb.TagNumber(6)
  void clearOwner() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get latitude => $_getN(6);
  @$pb.TagNumber(7)
  set latitude($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLatitude() => $_has(6);
  @$pb.TagNumber(7)
  void clearLatitude() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get longitude => $_getN(7);
  @$pb.TagNumber(8)
  set longitude($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLongitude() => $_has(7);
  @$pb.TagNumber(8)
  void clearLongitude() => $_clearField(8);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
