//
//  Generated code. Do not modify.
//  source: notification_settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'notification_payload.pbenum.dart' as $1;

class NotificationSettings_EewSettings_Region extends $pb.GeneratedMessage {
  factory NotificationSettings_EewSettings_Region({
    $core.String? code,
    $core.String? name,
    $1.JmaIntensity? emergencyIntensity,
    $1.JmaIntensity? silentIntensity,
    $core.bool? isMain,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (emergencyIntensity != null) {
      $result.emergencyIntensity = emergencyIntensity;
    }
    if (silentIntensity != null) {
      $result.silentIntensity = silentIntensity;
    }
    if (isMain != null) {
      $result.isMain = isMain;
    }
    return $result;
  }
  NotificationSettings_EewSettings_Region._() : super();
  factory NotificationSettings_EewSettings_Region.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationSettings_EewSettings_Region.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationSettings.EewSettings.Region',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..e<$1.JmaIntensity>(
        3, _omitFieldNames ? '' : 'emergencyIntensity', $pb.PbFieldType.OE,
        defaultOrMaker: $1.JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: $1.JmaIntensity.valueOf,
        enumValues: $1.JmaIntensity.values)
    ..e<$1.JmaIntensity>(
        4, _omitFieldNames ? '' : 'silentIntensity', $pb.PbFieldType.OE,
        defaultOrMaker: $1.JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: $1.JmaIntensity.valueOf,
        enumValues: $1.JmaIntensity.values)
    ..aOB(5, _omitFieldNames ? '' : 'isMain')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationSettings_EewSettings_Region clone() =>
      NotificationSettings_EewSettings_Region()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationSettings_EewSettings_Region copyWith(
          void Function(NotificationSettings_EewSettings_Region) updates) =>
      super.copyWith((message) =>
              updates(message as NotificationSettings_EewSettings_Region))
          as NotificationSettings_EewSettings_Region;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationSettings_EewSettings_Region create() =>
      NotificationSettings_EewSettings_Region._();
  NotificationSettings_EewSettings_Region createEmptyInstance() => create();
  static $pb.PbList<NotificationSettings_EewSettings_Region> createRepeated() =>
      $pb.PbList<NotificationSettings_EewSettings_Region>();
  @$core.pragma('dart2js:noInline')
  static NotificationSettings_EewSettings_Region getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          NotificationSettings_EewSettings_Region>(create);
  static NotificationSettings_EewSettings_Region? _defaultInstance;

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
  $1.JmaIntensity get emergencyIntensity => $_getN(2);
  @$pb.TagNumber(3)
  set emergencyIntensity($1.JmaIntensity v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEmergencyIntensity() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmergencyIntensity() => clearField(3);

  @$pb.TagNumber(4)
  $1.JmaIntensity get silentIntensity => $_getN(3);
  @$pb.TagNumber(4)
  set silentIntensity($1.JmaIntensity v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSilentIntensity() => $_has(3);
  @$pb.TagNumber(4)
  void clearSilentIntensity() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isMain => $_getBF(4);
  @$pb.TagNumber(5)
  set isMain($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasIsMain() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsMain() => clearField(5);
}

class NotificationSettings_EewSettings extends $pb.GeneratedMessage {
  factory NotificationSettings_EewSettings({
    $1.JmaIntensity? emergencyIntensity,
    $1.JmaIntensity? silentIntensity,
    $core.Iterable<NotificationSettings_EewSettings_Region>? regions,
  }) {
    final $result = create();
    if (emergencyIntensity != null) {
      $result.emergencyIntensity = emergencyIntensity;
    }
    if (silentIntensity != null) {
      $result.silentIntensity = silentIntensity;
    }
    if (regions != null) {
      $result.regions.addAll(regions);
    }
    return $result;
  }
  NotificationSettings_EewSettings._() : super();
  factory NotificationSettings_EewSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationSettings_EewSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationSettings.EewSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..e<$1.JmaIntensity>(
        1, _omitFieldNames ? '' : 'emergencyIntensity', $pb.PbFieldType.OE,
        defaultOrMaker: $1.JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: $1.JmaIntensity.valueOf,
        enumValues: $1.JmaIntensity.values)
    ..e<$1.JmaIntensity>(
        2, _omitFieldNames ? '' : 'silentIntensity', $pb.PbFieldType.OE,
        defaultOrMaker: $1.JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: $1.JmaIntensity.valueOf,
        enumValues: $1.JmaIntensity.values)
    ..pc<NotificationSettings_EewSettings_Region>(
        3, _omitFieldNames ? '' : 'regions', $pb.PbFieldType.PM,
        subBuilder: NotificationSettings_EewSettings_Region.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationSettings_EewSettings clone() =>
      NotificationSettings_EewSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationSettings_EewSettings copyWith(
          void Function(NotificationSettings_EewSettings) updates) =>
      super.copyWith(
              (message) => updates(message as NotificationSettings_EewSettings))
          as NotificationSettings_EewSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationSettings_EewSettings create() =>
      NotificationSettings_EewSettings._();
  NotificationSettings_EewSettings createEmptyInstance() => create();
  static $pb.PbList<NotificationSettings_EewSettings> createRepeated() =>
      $pb.PbList<NotificationSettings_EewSettings>();
  @$core.pragma('dart2js:noInline')
  static NotificationSettings_EewSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationSettings_EewSettings>(
          create);
  static NotificationSettings_EewSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $1.JmaIntensity get emergencyIntensity => $_getN(0);
  @$pb.TagNumber(1)
  set emergencyIntensity($1.JmaIntensity v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEmergencyIntensity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmergencyIntensity() => clearField(1);

  @$pb.TagNumber(2)
  $1.JmaIntensity get silentIntensity => $_getN(1);
  @$pb.TagNumber(2)
  set silentIntensity($1.JmaIntensity v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSilentIntensity() => $_has(1);
  @$pb.TagNumber(2)
  void clearSilentIntensity() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<NotificationSettings_EewSettings_Region> get regions =>
      $_getList(2);
}

class NotificationSettings_EarthquakeSettings_Region
    extends $pb.GeneratedMessage {
  factory NotificationSettings_EarthquakeSettings_Region({
    $core.String? code,
    $core.String? name,
    $1.JmaIntensity? emergencyIntensity,
    $1.JmaIntensity? silentIntensity,
    $core.bool? isMain,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (emergencyIntensity != null) {
      $result.emergencyIntensity = emergencyIntensity;
    }
    if (silentIntensity != null) {
      $result.silentIntensity = silentIntensity;
    }
    if (isMain != null) {
      $result.isMain = isMain;
    }
    return $result;
  }
  NotificationSettings_EarthquakeSettings_Region._() : super();
  factory NotificationSettings_EarthquakeSettings_Region.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationSettings_EarthquakeSettings_Region.fromJson(
          $core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationSettings.EarthquakeSettings.Region',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..e<$1.JmaIntensity>(
        3, _omitFieldNames ? '' : 'emergencyIntensity', $pb.PbFieldType.OE,
        defaultOrMaker: $1.JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: $1.JmaIntensity.valueOf,
        enumValues: $1.JmaIntensity.values)
    ..e<$1.JmaIntensity>(
        4, _omitFieldNames ? '' : 'silentIntensity', $pb.PbFieldType.OE,
        defaultOrMaker: $1.JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: $1.JmaIntensity.valueOf,
        enumValues: $1.JmaIntensity.values)
    ..aOB(5, _omitFieldNames ? '' : 'isMain')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationSettings_EarthquakeSettings_Region clone() =>
      NotificationSettings_EarthquakeSettings_Region()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationSettings_EarthquakeSettings_Region copyWith(
          void Function(NotificationSettings_EarthquakeSettings_Region)
              updates) =>
      super.copyWith((message) => updates(
              message as NotificationSettings_EarthquakeSettings_Region))
          as NotificationSettings_EarthquakeSettings_Region;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationSettings_EarthquakeSettings_Region create() =>
      NotificationSettings_EarthquakeSettings_Region._();
  NotificationSettings_EarthquakeSettings_Region createEmptyInstance() =>
      create();
  static $pb.PbList<NotificationSettings_EarthquakeSettings_Region>
      createRepeated() =>
          $pb.PbList<NotificationSettings_EarthquakeSettings_Region>();
  @$core.pragma('dart2js:noInline')
  static NotificationSettings_EarthquakeSettings_Region getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          NotificationSettings_EarthquakeSettings_Region>(create);
  static NotificationSettings_EarthquakeSettings_Region? _defaultInstance;

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
  $1.JmaIntensity get emergencyIntensity => $_getN(2);
  @$pb.TagNumber(3)
  set emergencyIntensity($1.JmaIntensity v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEmergencyIntensity() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmergencyIntensity() => clearField(3);

  @$pb.TagNumber(4)
  $1.JmaIntensity get silentIntensity => $_getN(3);
  @$pb.TagNumber(4)
  set silentIntensity($1.JmaIntensity v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSilentIntensity() => $_has(3);
  @$pb.TagNumber(4)
  void clearSilentIntensity() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isMain => $_getBF(4);
  @$pb.TagNumber(5)
  set isMain($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasIsMain() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsMain() => clearField(5);
}

class NotificationSettings_EarthquakeSettings extends $pb.GeneratedMessage {
  factory NotificationSettings_EarthquakeSettings({
    $1.JmaIntensity? emergencyIntensity,
    $1.JmaIntensity? silentIntensity,
    $core.Iterable<NotificationSettings_EarthquakeSettings_Region>? regions,
  }) {
    final $result = create();
    if (emergencyIntensity != null) {
      $result.emergencyIntensity = emergencyIntensity;
    }
    if (silentIntensity != null) {
      $result.silentIntensity = silentIntensity;
    }
    if (regions != null) {
      $result.regions.addAll(regions);
    }
    return $result;
  }
  NotificationSettings_EarthquakeSettings._() : super();
  factory NotificationSettings_EarthquakeSettings.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationSettings_EarthquakeSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationSettings.EarthquakeSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..e<$1.JmaIntensity>(
        1, _omitFieldNames ? '' : 'emergencyIntensity', $pb.PbFieldType.OE,
        defaultOrMaker: $1.JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: $1.JmaIntensity.valueOf,
        enumValues: $1.JmaIntensity.values)
    ..e<$1.JmaIntensity>(
        2, _omitFieldNames ? '' : 'silentIntensity', $pb.PbFieldType.OE,
        defaultOrMaker: $1.JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: $1.JmaIntensity.valueOf,
        enumValues: $1.JmaIntensity.values)
    ..pc<NotificationSettings_EarthquakeSettings_Region>(
        3, _omitFieldNames ? '' : 'regions', $pb.PbFieldType.PM,
        subBuilder: NotificationSettings_EarthquakeSettings_Region.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationSettings_EarthquakeSettings clone() =>
      NotificationSettings_EarthquakeSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationSettings_EarthquakeSettings copyWith(
          void Function(NotificationSettings_EarthquakeSettings) updates) =>
      super.copyWith((message) =>
              updates(message as NotificationSettings_EarthquakeSettings))
          as NotificationSettings_EarthquakeSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationSettings_EarthquakeSettings create() =>
      NotificationSettings_EarthquakeSettings._();
  NotificationSettings_EarthquakeSettings createEmptyInstance() => create();
  static $pb.PbList<NotificationSettings_EarthquakeSettings> createRepeated() =>
      $pb.PbList<NotificationSettings_EarthquakeSettings>();
  @$core.pragma('dart2js:noInline')
  static NotificationSettings_EarthquakeSettings getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          NotificationSettings_EarthquakeSettings>(create);
  static NotificationSettings_EarthquakeSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $1.JmaIntensity get emergencyIntensity => $_getN(0);
  @$pb.TagNumber(1)
  set emergencyIntensity($1.JmaIntensity v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEmergencyIntensity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmergencyIntensity() => clearField(1);

  @$pb.TagNumber(2)
  $1.JmaIntensity get silentIntensity => $_getN(1);
  @$pb.TagNumber(2)
  set silentIntensity($1.JmaIntensity v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSilentIntensity() => $_has(1);
  @$pb.TagNumber(2)
  void clearSilentIntensity() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<NotificationSettings_EarthquakeSettings_Region> get regions =>
      $_getList(2);
}

class NotificationSettings extends $pb.GeneratedMessage {
  factory NotificationSettings({
    NotificationSettings_EewSettings? eewSettings,
    NotificationSettings_EarthquakeSettings? earthquakeSettings,
  }) {
    final $result = create();
    if (eewSettings != null) {
      $result.eewSettings = eewSettings;
    }
    if (earthquakeSettings != null) {
      $result.earthquakeSettings = earthquakeSettings;
    }
    return $result;
  }
  NotificationSettings._() : super();
  factory NotificationSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..aOM<NotificationSettings_EewSettings>(
        1, _omitFieldNames ? '' : 'eewSettings',
        subBuilder: NotificationSettings_EewSettings.create)
    ..aOM<NotificationSettings_EarthquakeSettings>(
        2, _omitFieldNames ? '' : 'earthquakeSettings',
        subBuilder: NotificationSettings_EarthquakeSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationSettings clone() =>
      NotificationSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationSettings copyWith(void Function(NotificationSettings) updates) =>
      super.copyWith((message) => updates(message as NotificationSettings))
          as NotificationSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationSettings create() => NotificationSettings._();
  NotificationSettings createEmptyInstance() => create();
  static $pb.PbList<NotificationSettings> createRepeated() =>
      $pb.PbList<NotificationSettings>();
  @$core.pragma('dart2js:noInline')
  static NotificationSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationSettings>(create);
  static NotificationSettings? _defaultInstance;

  @$pb.TagNumber(1)
  NotificationSettings_EewSettings get eewSettings => $_getN(0);
  @$pb.TagNumber(1)
  set eewSettings(NotificationSettings_EewSettings v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEewSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearEewSettings() => clearField(1);
  @$pb.TagNumber(1)
  NotificationSettings_EewSettings ensureEewSettings() => $_ensure(0);

  @$pb.TagNumber(2)
  NotificationSettings_EarthquakeSettings get earthquakeSettings => $_getN(1);
  @$pb.TagNumber(2)
  set earthquakeSettings(NotificationSettings_EarthquakeSettings v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEarthquakeSettings() => $_has(1);
  @$pb.TagNumber(2)
  void clearEarthquakeSettings() => clearField(2);
  @$pb.TagNumber(2)
  NotificationSettings_EarthquakeSettings ensureEarthquakeSettings() =>
      $_ensure(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
