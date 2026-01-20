// This is a generated file - do not edit.
//
// Generated from jma_code_table.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// コード表ヘッダー（バージョン管理用）
class JmaCodeTableHeader extends $pb.GeneratedMessage {
  factory JmaCodeTableHeader({
    $core.String? dateVersion,
    $core.String? fetchedAt,
    $core.String? sourceUrl,
    $core.String? sha384,
  }) {
    final result = create();
    if (dateVersion != null) result.dateVersion = dateVersion;
    if (fetchedAt != null) result.fetchedAt = fetchedAt;
    if (sourceUrl != null) result.sourceUrl = sourceUrl;
    if (sha384 != null) result.sha384 = sha384;
    return result;
  }

  JmaCodeTableHeader._();

  factory JmaCodeTableHeader.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JmaCodeTableHeader.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaCodeTableHeader',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dateVersion')
    ..aOS(2, _omitFieldNames ? '' : 'fetchedAt')
    ..aOS(3, _omitFieldNames ? '' : 'sourceUrl')
    ..aOS(4, _omitFieldNames ? '' : 'sha384')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaCodeTableHeader clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaCodeTableHeader copyWith(void Function(JmaCodeTableHeader) updates) =>
      super.copyWith((message) => updates(message as JmaCodeTableHeader))
          as JmaCodeTableHeader;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaCodeTableHeader create() => JmaCodeTableHeader._();
  @$core.override
  JmaCodeTableHeader createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JmaCodeTableHeader getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JmaCodeTableHeader>(create);
  static JmaCodeTableHeader? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dateVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set dateVersion($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDateVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearDateVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fetchedAt => $_getSZ(1);
  @$pb.TagNumber(2)
  set fetchedAt($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFetchedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearFetchedAt() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sourceUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sha384 => $_getSZ(3);
  @$pb.TagNumber(4)
  set sha384($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSha384() => $_has(3);
  @$pb.TagNumber(4)
  void clearSha384() => $_clearField(4);
}

/// 気象庁地震関連コード表
class JmaCodeTable extends $pb.GeneratedMessage {
  factory JmaCodeTable({
    JmaCodeTableHeader? header,
    AreaForecastLocalEew? areaForecastLocalEew,
    AreaInformationPrefectureEarthquake? areaInformationPrefectureEarthquake,
    AreaEpicenter? areaEpicenter,
    AreaEpicenterAbbreviation? areaEpicenterAbbreviation,
    AreaEpicenterDetail? areaEpicenterDetail,
  }) {
    final result = create();
    if (header != null) result.header = header;
    if (areaForecastLocalEew != null)
      result.areaForecastLocalEew = areaForecastLocalEew;
    if (areaInformationPrefectureEarthquake != null)
      result.areaInformationPrefectureEarthquake =
          areaInformationPrefectureEarthquake;
    if (areaEpicenter != null) result.areaEpicenter = areaEpicenter;
    if (areaEpicenterAbbreviation != null)
      result.areaEpicenterAbbreviation = areaEpicenterAbbreviation;
    if (areaEpicenterDetail != null)
      result.areaEpicenterDetail = areaEpicenterDetail;
    return result;
  }

  JmaCodeTable._();

  factory JmaCodeTable.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JmaCodeTable.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JmaCodeTable',
      createEmptyInstance: create)
    ..aOM<JmaCodeTableHeader>(1, _omitFieldNames ? '' : 'header',
        subBuilder: JmaCodeTableHeader.create)
    ..aOM<AreaForecastLocalEew>(
        22, _omitFieldNames ? '' : 'areaForecastLocalEew',
        subBuilder: AreaForecastLocalEew.create)
    ..aOM<AreaInformationPrefectureEarthquake>(
        23, _omitFieldNames ? '' : 'areaInformationPrefectureEarthquake',
        subBuilder: AreaInformationPrefectureEarthquake.create)
    ..aOM<AreaEpicenter>(41, _omitFieldNames ? '' : 'areaEpicenter',
        subBuilder: AreaEpicenter.create)
    ..aOM<AreaEpicenterAbbreviation>(
        42, _omitFieldNames ? '' : 'areaEpicenterAbbreviation',
        subBuilder: AreaEpicenterAbbreviation.create)
    ..aOM<AreaEpicenterDetail>(43, _omitFieldNames ? '' : 'areaEpicenterDetail',
        subBuilder: AreaEpicenterDetail.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaCodeTable clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JmaCodeTable copyWith(void Function(JmaCodeTable) updates) =>
      super.copyWith((message) => updates(message as JmaCodeTable))
          as JmaCodeTable;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JmaCodeTable create() => JmaCodeTable._();
  @$core.override
  JmaCodeTable createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JmaCodeTable getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JmaCodeTable>(create);
  static JmaCodeTable? _defaultInstance;

  @$pb.TagNumber(1)
  JmaCodeTableHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(JmaCodeTableHeader value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => $_clearField(1);
  @$pb.TagNumber(1)
  JmaCodeTableHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(22)
  AreaForecastLocalEew get areaForecastLocalEew => $_getN(1);
  @$pb.TagNumber(22)
  set areaForecastLocalEew(AreaForecastLocalEew value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasAreaForecastLocalEew() => $_has(1);
  @$pb.TagNumber(22)
  void clearAreaForecastLocalEew() => $_clearField(22);
  @$pb.TagNumber(22)
  AreaForecastLocalEew ensureAreaForecastLocalEew() => $_ensure(1);

  @$pb.TagNumber(23)
  AreaInformationPrefectureEarthquake get areaInformationPrefectureEarthquake =>
      $_getN(2);
  @$pb.TagNumber(23)
  set areaInformationPrefectureEarthquake(
          AreaInformationPrefectureEarthquake value) =>
      $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasAreaInformationPrefectureEarthquake() => $_has(2);
  @$pb.TagNumber(23)
  void clearAreaInformationPrefectureEarthquake() => $_clearField(23);
  @$pb.TagNumber(23)
  AreaInformationPrefectureEarthquake
      ensureAreaInformationPrefectureEarthquake() => $_ensure(2);

  @$pb.TagNumber(41)
  AreaEpicenter get areaEpicenter => $_getN(3);
  @$pb.TagNumber(41)
  set areaEpicenter(AreaEpicenter value) => $_setField(41, value);
  @$pb.TagNumber(41)
  $core.bool hasAreaEpicenter() => $_has(3);
  @$pb.TagNumber(41)
  void clearAreaEpicenter() => $_clearField(41);
  @$pb.TagNumber(41)
  AreaEpicenter ensureAreaEpicenter() => $_ensure(3);

  @$pb.TagNumber(42)
  AreaEpicenterAbbreviation get areaEpicenterAbbreviation => $_getN(4);
  @$pb.TagNumber(42)
  set areaEpicenterAbbreviation(AreaEpicenterAbbreviation value) =>
      $_setField(42, value);
  @$pb.TagNumber(42)
  $core.bool hasAreaEpicenterAbbreviation() => $_has(4);
  @$pb.TagNumber(42)
  void clearAreaEpicenterAbbreviation() => $_clearField(42);
  @$pb.TagNumber(42)
  AreaEpicenterAbbreviation ensureAreaEpicenterAbbreviation() => $_ensure(4);

  @$pb.TagNumber(43)
  AreaEpicenterDetail get areaEpicenterDetail => $_getN(5);
  @$pb.TagNumber(43)
  set areaEpicenterDetail(AreaEpicenterDetail value) => $_setField(43, value);
  @$pb.TagNumber(43)
  $core.bool hasAreaEpicenterDetail() => $_has(5);
  @$pb.TagNumber(43)
  void clearAreaEpicenterDetail() => $_clearField(43);
  @$pb.TagNumber(43)
  AreaEpicenterDetail ensureAreaEpicenterDetail() => $_ensure(5);
}

class AreaForecastLocalEew_AreaForecastLocalEewItem
    extends $pb.GeneratedMessage {
  factory AreaForecastLocalEew_AreaForecastLocalEewItem({
    $core.String? code,
    $core.String? name,
    $core.String? nameKana,
    $core.String? description,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (nameKana != null) result.nameKana = nameKana;
    if (description != null) result.description = description;
    return result;
  }

  AreaForecastLocalEew_AreaForecastLocalEewItem._();

  factory AreaForecastLocalEew_AreaForecastLocalEewItem.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AreaForecastLocalEew_AreaForecastLocalEewItem.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AreaForecastLocalEew.AreaForecastLocalEewItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'nameKana')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaForecastLocalEew_AreaForecastLocalEewItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaForecastLocalEew_AreaForecastLocalEewItem copyWith(
          void Function(AreaForecastLocalEew_AreaForecastLocalEewItem)
              updates) =>
      super.copyWith((message) =>
              updates(message as AreaForecastLocalEew_AreaForecastLocalEewItem))
          as AreaForecastLocalEew_AreaForecastLocalEewItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaForecastLocalEew_AreaForecastLocalEewItem create() =>
      AreaForecastLocalEew_AreaForecastLocalEewItem._();
  @$core.override
  AreaForecastLocalEew_AreaForecastLocalEewItem createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static AreaForecastLocalEew_AreaForecastLocalEewItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AreaForecastLocalEew_AreaForecastLocalEewItem>(create);
  static AreaForecastLocalEew_AreaForecastLocalEewItem? _defaultInstance;

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
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);
}

/// 22. 緊急地震速報／府県予報区
class AreaForecastLocalEew extends $pb.GeneratedMessage {
  factory AreaForecastLocalEew({
    $core.Iterable<AreaForecastLocalEew_AreaForecastLocalEewItem>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  AreaForecastLocalEew._();

  factory AreaForecastLocalEew.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AreaForecastLocalEew.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AreaForecastLocalEew',
      createEmptyInstance: create)
    ..pPM<AreaForecastLocalEew_AreaForecastLocalEewItem>(
        1, _omitFieldNames ? '' : 'items',
        subBuilder: AreaForecastLocalEew_AreaForecastLocalEewItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaForecastLocalEew clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaForecastLocalEew copyWith(void Function(AreaForecastLocalEew) updates) =>
      super.copyWith((message) => updates(message as AreaForecastLocalEew))
          as AreaForecastLocalEew;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaForecastLocalEew create() => AreaForecastLocalEew._();
  @$core.override
  AreaForecastLocalEew createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AreaForecastLocalEew getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AreaForecastLocalEew>(create);
  static AreaForecastLocalEew? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AreaForecastLocalEew_AreaForecastLocalEewItem> get items =>
      $_getList(0);
}

class AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem
    extends $pb.GeneratedMessage {
  factory AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem({
    $core.String? code,
    $core.String? name,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    return result;
  }

  AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem._();

  factory AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'AreaInformationPrefectureEarthquake.AreaInformationPrefectureEarthquakeItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem
      clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem copyWith(
          void Function(
                  AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem)
              updates) =>
      super.copyWith((message) => updates(message
              as AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem))
          as AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem
      create() =>
          AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem
              ._();
  @$core.override
  AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem
      createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem
      getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem>(
          create);
  static AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem?
      _defaultInstance;

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
}

/// 23. 地震情報／都道府県等
class AreaInformationPrefectureEarthquake extends $pb.GeneratedMessage {
  factory AreaInformationPrefectureEarthquake({
    $core.Iterable<
            AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem>?
        items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  AreaInformationPrefectureEarthquake._();

  factory AreaInformationPrefectureEarthquake.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AreaInformationPrefectureEarthquake.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AreaInformationPrefectureEarthquake',
      createEmptyInstance: create)
    ..pPM<AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem>(
        1, _omitFieldNames ? '' : 'items',
        subBuilder:
            AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem
                .create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaInformationPrefectureEarthquake clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaInformationPrefectureEarthquake copyWith(
          void Function(AreaInformationPrefectureEarthquake) updates) =>
      super.copyWith((message) =>
              updates(message as AreaInformationPrefectureEarthquake))
          as AreaInformationPrefectureEarthquake;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaInformationPrefectureEarthquake create() =>
      AreaInformationPrefectureEarthquake._();
  @$core.override
  AreaInformationPrefectureEarthquake createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AreaInformationPrefectureEarthquake getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AreaInformationPrefectureEarthquake>(create);
  static AreaInformationPrefectureEarthquake? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<
          AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem>
      get items => $_getList(0);
}

class AreaEpicenter_AreaEpicenterItem extends $pb.GeneratedMessage {
  factory AreaEpicenter_AreaEpicenterItem({
    $core.String? code,
    $core.String? name,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    return result;
  }

  AreaEpicenter_AreaEpicenterItem._();

  factory AreaEpicenter_AreaEpicenterItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AreaEpicenter_AreaEpicenterItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AreaEpicenter.AreaEpicenterItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenter_AreaEpicenterItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenter_AreaEpicenterItem copyWith(
          void Function(AreaEpicenter_AreaEpicenterItem) updates) =>
      super.copyWith(
              (message) => updates(message as AreaEpicenter_AreaEpicenterItem))
          as AreaEpicenter_AreaEpicenterItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenter_AreaEpicenterItem create() =>
      AreaEpicenter_AreaEpicenterItem._();
  @$core.override
  AreaEpicenter_AreaEpicenterItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenter_AreaEpicenterItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AreaEpicenter_AreaEpicenterItem>(
          create);
  static AreaEpicenter_AreaEpicenterItem? _defaultInstance;

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
}

/// 41. 震央地名
/// (011, 北海道地方)
class AreaEpicenter extends $pb.GeneratedMessage {
  factory AreaEpicenter({
    $core.Iterable<AreaEpicenter_AreaEpicenterItem>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  AreaEpicenter._();

  factory AreaEpicenter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AreaEpicenter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AreaEpicenter',
      createEmptyInstance: create)
    ..pPM<AreaEpicenter_AreaEpicenterItem>(1, _omitFieldNames ? '' : 'items',
        subBuilder: AreaEpicenter_AreaEpicenterItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenter clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenter copyWith(void Function(AreaEpicenter) updates) =>
      super.copyWith((message) => updates(message as AreaEpicenter))
          as AreaEpicenter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenter create() => AreaEpicenter._();
  @$core.override
  AreaEpicenter createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AreaEpicenter>(create);
  static AreaEpicenter? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AreaEpicenter_AreaEpicenterItem> get items => $_getList(0);
}

class AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem
    extends $pb.GeneratedMessage {
  factory AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem({
    $core.String? code,
    $core.String? name,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    return result;
  }

  AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem._();

  factory AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'AreaEpicenterAbbreviation.AreaEpicenterAbbreviationItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem copyWith(
          void Function(AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem)
              updates) =>
      super.copyWith((message) => updates(message
              as AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem))
          as AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem create() =>
      AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem._();
  @$core.override
  AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem
      createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem>(create);
  static AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem?
      _defaultInstance;

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
}

/// 42. 短縮用震央地名
/// (9011, 北海道道央), ...
class AreaEpicenterAbbreviation extends $pb.GeneratedMessage {
  factory AreaEpicenterAbbreviation({
    $core.Iterable<AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem>?
        items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  AreaEpicenterAbbreviation._();

  factory AreaEpicenterAbbreviation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AreaEpicenterAbbreviation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AreaEpicenterAbbreviation',
      createEmptyInstance: create)
    ..pPM<AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem>(
        1, _omitFieldNames ? '' : 'items',
        subBuilder:
            AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenterAbbreviation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenterAbbreviation copyWith(
          void Function(AreaEpicenterAbbreviation) updates) =>
      super.copyWith((message) => updates(message as AreaEpicenterAbbreviation))
          as AreaEpicenterAbbreviation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenterAbbreviation create() => AreaEpicenterAbbreviation._();
  @$core.override
  AreaEpicenterAbbreviation createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenterAbbreviation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AreaEpicenterAbbreviation>(create);
  static AreaEpicenterAbbreviation? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem>
      get items => $_getList(0);
}

class AreaEpicenterDetail_AreaEpicenterDetailItem extends $pb.GeneratedMessage {
  factory AreaEpicenterDetail_AreaEpicenterDetailItem({
    $core.String? code,
    $core.String? name,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    return result;
  }

  AreaEpicenterDetail_AreaEpicenterDetailItem._();

  factory AreaEpicenterDetail_AreaEpicenterDetailItem.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AreaEpicenterDetail_AreaEpicenterDetailItem.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AreaEpicenterDetail.AreaEpicenterDetailItem',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenterDetail_AreaEpicenterDetailItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenterDetail_AreaEpicenterDetailItem copyWith(
          void Function(AreaEpicenterDetail_AreaEpicenterDetailItem) updates) =>
      super.copyWith((message) =>
              updates(message as AreaEpicenterDetail_AreaEpicenterDetailItem))
          as AreaEpicenterDetail_AreaEpicenterDetailItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenterDetail_AreaEpicenterDetailItem create() =>
      AreaEpicenterDetail_AreaEpicenterDetailItem._();
  @$core.override
  AreaEpicenterDetail_AreaEpicenterDetailItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenterDetail_AreaEpicenterDetailItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AreaEpicenterDetail_AreaEpicenterDetailItem>(create);
  static AreaEpicenterDetail_AreaEpicenterDetailItem? _defaultInstance;

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
}

/// 43. 詳細震央地名
/// (1001, 米国、アラスカ州中央部)
class AreaEpicenterDetail extends $pb.GeneratedMessage {
  factory AreaEpicenterDetail({
    $core.Iterable<AreaEpicenterDetail_AreaEpicenterDetailItem>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  AreaEpicenterDetail._();

  factory AreaEpicenterDetail.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AreaEpicenterDetail.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AreaEpicenterDetail',
      createEmptyInstance: create)
    ..pPM<AreaEpicenterDetail_AreaEpicenterDetailItem>(
        1, _omitFieldNames ? '' : 'items',
        subBuilder: AreaEpicenterDetail_AreaEpicenterDetailItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenterDetail clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AreaEpicenterDetail copyWith(void Function(AreaEpicenterDetail) updates) =>
      super.copyWith((message) => updates(message as AreaEpicenterDetail))
          as AreaEpicenterDetail;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AreaEpicenterDetail create() => AreaEpicenterDetail._();
  @$core.override
  AreaEpicenterDetail createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AreaEpicenterDetail getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AreaEpicenterDetail>(create);
  static AreaEpicenterDetail? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AreaEpicenterDetail_AreaEpicenterDetailItem> get items =>
      $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
