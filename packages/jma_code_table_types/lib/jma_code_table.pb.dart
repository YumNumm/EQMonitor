//
//  Generated code. Do not modify.
//  source: jma_code_table.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// 気象庁地震関連コード表
class JmaCodeTable extends $pb.GeneratedMessage {
  factory JmaCodeTable({
    AreaEpicenter? areaEpicenter,
    AreaEpicenterAbbreviation? areaEpicenterAbbreviation,
    AreaEpicenterDetail? areaEpicenterDetail,
  }) {
    final $result = create();
    if (areaEpicenter != null) {
      $result.areaEpicenter = areaEpicenter;
    }
    if (areaEpicenterAbbreviation != null) {
      $result.areaEpicenterAbbreviation = areaEpicenterAbbreviation;
    }
    if (areaEpicenterDetail != null) {
      $result.areaEpicenterDetail = areaEpicenterDetail;
    }
    return $result;
  }
  JmaCodeTable._() : super();
  factory JmaCodeTable.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JmaCodeTable.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JmaCodeTable', createEmptyInstance: create)
    ..aOM<AreaEpicenter>(41, _omitFieldNames ? '' : 'areaEpicenter', protoName: 'areaEpicenter', subBuilder: AreaEpicenter.create)
    ..aOM<AreaEpicenterAbbreviation>(42, _omitFieldNames ? '' : 'areaEpicenterAbbreviation', protoName: 'areaEpicenterAbbreviation', subBuilder: AreaEpicenterAbbreviation.create)
    ..aOM<AreaEpicenterDetail>(43, _omitFieldNames ? '' : 'areaEpicenterDetail', protoName: 'areaEpicenterDetail', subBuilder: AreaEpicenterDetail.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JmaCodeTable clone() => JmaCodeTable()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JmaCodeTable copyWith(void Function(JmaCodeTable) updates) => super.copyWith((message) => updates(message as JmaCodeTable)) as JmaCodeTable;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaCodeTable create() => JmaCodeTable._();
  JmaCodeTable createEmptyInstance() => create();
  static $pb.PbList<JmaCodeTable> createRepeated() => $pb.PbList<JmaCodeTable>();
  @$core.pragma('dart2js:noInline')
  static JmaCodeTable getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JmaCodeTable>(create);
  static JmaCodeTable? _defaultInstance;

  @$pb.TagNumber(41)
  AreaEpicenter get areaEpicenter => $_getN(0);
  @$pb.TagNumber(41)
  set areaEpicenter(AreaEpicenter v) { setField(41, v); }
  @$pb.TagNumber(41)
  $core.bool hasAreaEpicenter() => $_has(0);
  @$pb.TagNumber(41)
  void clearAreaEpicenter() => clearField(41);
  @$pb.TagNumber(41)
  AreaEpicenter ensureAreaEpicenter() => $_ensure(0);

  @$pb.TagNumber(42)
  AreaEpicenterAbbreviation get areaEpicenterAbbreviation => $_getN(1);
  @$pb.TagNumber(42)
  set areaEpicenterAbbreviation(AreaEpicenterAbbreviation v) { setField(42, v); }
  @$pb.TagNumber(42)
  $core.bool hasAreaEpicenterAbbreviation() => $_has(1);
  @$pb.TagNumber(42)
  void clearAreaEpicenterAbbreviation() => clearField(42);
  @$pb.TagNumber(42)
  AreaEpicenterAbbreviation ensureAreaEpicenterAbbreviation() => $_ensure(1);

  @$pb.TagNumber(43)
  AreaEpicenterDetail get areaEpicenterDetail => $_getN(2);
  @$pb.TagNumber(43)
  set areaEpicenterDetail(AreaEpicenterDetail v) { setField(43, v); }
  @$pb.TagNumber(43)
  $core.bool hasAreaEpicenterDetail() => $_has(2);
  @$pb.TagNumber(43)
  void clearAreaEpicenterDetail() => clearField(43);
  @$pb.TagNumber(43)
  AreaEpicenterDetail ensureAreaEpicenterDetail() => $_ensure(2);
}

class AreaEpicenter_AreaEpicenterItem extends $pb.GeneratedMessage {
  factory AreaEpicenter_AreaEpicenterItem({
    $core.String? code,
    $core.String? name,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  AreaEpicenter_AreaEpicenterItem._() : super();
  factory AreaEpicenter_AreaEpicenterItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AreaEpicenter_AreaEpicenterItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AreaEpicenter.AreaEpicenterItem', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AreaEpicenter_AreaEpicenterItem clone() => AreaEpicenter_AreaEpicenterItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AreaEpicenter_AreaEpicenterItem copyWith(void Function(AreaEpicenter_AreaEpicenterItem) updates) => super.copyWith((message) => updates(message as AreaEpicenter_AreaEpicenterItem)) as AreaEpicenter_AreaEpicenterItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenter_AreaEpicenterItem create() => AreaEpicenter_AreaEpicenterItem._();
  AreaEpicenter_AreaEpicenterItem createEmptyInstance() => create();
  static $pb.PbList<AreaEpicenter_AreaEpicenterItem> createRepeated() => $pb.PbList<AreaEpicenter_AreaEpicenterItem>();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenter_AreaEpicenterItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AreaEpicenter_AreaEpicenterItem>(create);
  static AreaEpicenter_AreaEpicenterItem? _defaultInstance;

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
}

/// 41. 震央地名
/// (011, 北海道地方)
class AreaEpicenter extends $pb.GeneratedMessage {
  factory AreaEpicenter({
    $core.Iterable<AreaEpicenter_AreaEpicenterItem>? items,
  }) {
    final $result = create();
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  AreaEpicenter._() : super();
  factory AreaEpicenter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AreaEpicenter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AreaEpicenter', createEmptyInstance: create)
    ..pc<AreaEpicenter_AreaEpicenterItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: AreaEpicenter_AreaEpicenterItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AreaEpicenter clone() => AreaEpicenter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AreaEpicenter copyWith(void Function(AreaEpicenter) updates) => super.copyWith((message) => updates(message as AreaEpicenter)) as AreaEpicenter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenter create() => AreaEpicenter._();
  AreaEpicenter createEmptyInstance() => create();
  static $pb.PbList<AreaEpicenter> createRepeated() => $pb.PbList<AreaEpicenter>();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AreaEpicenter>(create);
  static AreaEpicenter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AreaEpicenter_AreaEpicenterItem> get items => $_getList(0);
}

class AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem extends $pb.GeneratedMessage {
  factory AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem({
    $core.String? code,
    $core.String? name,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem._() : super();
  factory AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AreaEpicenterAbbreviation.AreaEpicenterAbbreviationItem', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem clone() => AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem copyWith(void Function(AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem) updates) => super.copyWith((message) => updates(message as AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem)) as AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem create() => AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem._();
  AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem createEmptyInstance() => create();
  static $pb.PbList<AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem> createRepeated() => $pb.PbList<AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem>();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem>(create);
  static AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem? _defaultInstance;

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
}

/// 42. 短縮用震央地名
/// (9011, 北海道道央), ...
class AreaEpicenterAbbreviation extends $pb.GeneratedMessage {
  factory AreaEpicenterAbbreviation({
    $core.Iterable<AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem>? items,
  }) {
    final $result = create();
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  AreaEpicenterAbbreviation._() : super();
  factory AreaEpicenterAbbreviation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AreaEpicenterAbbreviation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AreaEpicenterAbbreviation', createEmptyInstance: create)
    ..pc<AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AreaEpicenterAbbreviation clone() => AreaEpicenterAbbreviation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AreaEpicenterAbbreviation copyWith(void Function(AreaEpicenterAbbreviation) updates) => super.copyWith((message) => updates(message as AreaEpicenterAbbreviation)) as AreaEpicenterAbbreviation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenterAbbreviation create() => AreaEpicenterAbbreviation._();
  AreaEpicenterAbbreviation createEmptyInstance() => create();
  static $pb.PbList<AreaEpicenterAbbreviation> createRepeated() => $pb.PbList<AreaEpicenterAbbreviation>();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenterAbbreviation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AreaEpicenterAbbreviation>(create);
  static AreaEpicenterAbbreviation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem> get items => $_getList(0);
}

class AreaEpicenterDetail_AreaEpicenterDetailItem extends $pb.GeneratedMessage {
  factory AreaEpicenterDetail_AreaEpicenterDetailItem({
    $core.String? code,
    $core.String? name,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  AreaEpicenterDetail_AreaEpicenterDetailItem._() : super();
  factory AreaEpicenterDetail_AreaEpicenterDetailItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AreaEpicenterDetail_AreaEpicenterDetailItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AreaEpicenterDetail.AreaEpicenterDetailItem', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AreaEpicenterDetail_AreaEpicenterDetailItem clone() => AreaEpicenterDetail_AreaEpicenterDetailItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AreaEpicenterDetail_AreaEpicenterDetailItem copyWith(void Function(AreaEpicenterDetail_AreaEpicenterDetailItem) updates) => super.copyWith((message) => updates(message as AreaEpicenterDetail_AreaEpicenterDetailItem)) as AreaEpicenterDetail_AreaEpicenterDetailItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenterDetail_AreaEpicenterDetailItem create() => AreaEpicenterDetail_AreaEpicenterDetailItem._();
  AreaEpicenterDetail_AreaEpicenterDetailItem createEmptyInstance() => create();
  static $pb.PbList<AreaEpicenterDetail_AreaEpicenterDetailItem> createRepeated() => $pb.PbList<AreaEpicenterDetail_AreaEpicenterDetailItem>();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenterDetail_AreaEpicenterDetailItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AreaEpicenterDetail_AreaEpicenterDetailItem>(create);
  static AreaEpicenterDetail_AreaEpicenterDetailItem? _defaultInstance;

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
}

/// 43. 詳細震央地名
/// (1001, 米国、アラスカ州中央部)
class AreaEpicenterDetail extends $pb.GeneratedMessage {
  factory AreaEpicenterDetail({
    $core.Iterable<AreaEpicenterDetail_AreaEpicenterDetailItem>? items,
  }) {
    final $result = create();
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  AreaEpicenterDetail._() : super();
  factory AreaEpicenterDetail.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AreaEpicenterDetail.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AreaEpicenterDetail', createEmptyInstance: create)
    ..pc<AreaEpicenterDetail_AreaEpicenterDetailItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: AreaEpicenterDetail_AreaEpicenterDetailItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AreaEpicenterDetail clone() => AreaEpicenterDetail()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AreaEpicenterDetail copyWith(void Function(AreaEpicenterDetail) updates) => super.copyWith((message) => updates(message as AreaEpicenterDetail)) as AreaEpicenterDetail;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenterDetail create() => AreaEpicenterDetail._();
  AreaEpicenterDetail createEmptyInstance() => create();
  static $pb.PbList<AreaEpicenterDetail> createRepeated() => $pb.PbList<AreaEpicenterDetail>();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenterDetail getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AreaEpicenterDetail>(create);
  static AreaEpicenterDetail? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AreaEpicenterDetail_AreaEpicenterDetailItem> get items => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
