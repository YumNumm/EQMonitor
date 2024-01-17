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
    $core.Iterable<TsunamiParameterItem>? items,
  }) {
    final $result = create();
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  TsunamiParameter._() : super();
  factory TsunamiParameter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TsunamiParameter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TsunamiParameter', createEmptyInstance: create)
    ..pc<TsunamiParameterItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: TsunamiParameterItem.create)
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
  $core.List<TsunamiParameterItem> get items => $_getList(0);
}

class TsunamiParameterItem extends $pb.GeneratedMessage {
  factory TsunamiParameterItem({
    $core.String? prefecture,
    $core.String? code,
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final $result = create();
    if (prefecture != null) {
      $result.prefecture = prefecture;
    }
    if (code != null) {
      $result.code = code;
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
    ..aOS(1, _omitFieldNames ? '' : 'prefecture')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OD)
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

  @$pb.TagNumber(1)
  $core.String get prefecture => $_getSZ(0);
  @$pb.TagNumber(1)
  set prefecture($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPrefecture() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrefecture() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

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
