//
//  Generated code. Do not modify.
//  source: notification_payload.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $0;
import 'notification_payload.pbenum.dart';

export 'notification_payload.pbenum.dart';

class NotificationPayload_EewInformation extends $pb.GeneratedMessage {
  factory NotificationPayload_EewInformation({
    NotificationPayload_HypoInformation? hypoInformation,
    JmaIntensity? maxIntensity,
    $core.Iterable<NotificationPayload_EewRegionIntensity>? regionIntensities,
  }) {
    final $result = create();
    if (hypoInformation != null) {
      $result.hypoInformation = hypoInformation;
    }
    if (maxIntensity != null) {
      $result.maxIntensity = maxIntensity;
    }
    if (regionIntensities != null) {
      $result.regionIntensities.addAll(regionIntensities);
    }
    return $result;
  }
  NotificationPayload_EewInformation._() : super();
  factory NotificationPayload_EewInformation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationPayload_EewInformation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationPayload.EewInformation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..aOM<NotificationPayload_HypoInformation>(
        1, _omitFieldNames ? '' : 'hypoInformation',
        subBuilder: NotificationPayload_HypoInformation.create)
    ..e<JmaIntensity>(
        2, _omitFieldNames ? '' : 'maxIntensity', $pb.PbFieldType.OE,
        defaultOrMaker: JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: JmaIntensity.valueOf,
        enumValues: JmaIntensity.values)
    ..pc<NotificationPayload_EewRegionIntensity>(
        3, _omitFieldNames ? '' : 'regionIntensities', $pb.PbFieldType.PM,
        subBuilder: NotificationPayload_EewRegionIntensity.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationPayload_EewInformation clone() =>
      NotificationPayload_EewInformation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationPayload_EewInformation copyWith(
          void Function(NotificationPayload_EewInformation) updates) =>
      super.copyWith((message) =>
              updates(message as NotificationPayload_EewInformation))
          as NotificationPayload_EewInformation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPayload_EewInformation create() =>
      NotificationPayload_EewInformation._();
  NotificationPayload_EewInformation createEmptyInstance() => create();
  static $pb.PbList<NotificationPayload_EewInformation> createRepeated() =>
      $pb.PbList<NotificationPayload_EewInformation>();
  @$core.pragma('dart2js:noInline')
  static NotificationPayload_EewInformation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationPayload_EewInformation>(
          create);
  static NotificationPayload_EewInformation? _defaultInstance;

  @$pb.TagNumber(1)
  NotificationPayload_HypoInformation get hypoInformation => $_getN(0);
  @$pb.TagNumber(1)
  set hypoInformation(NotificationPayload_HypoInformation v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHypoInformation() => $_has(0);
  @$pb.TagNumber(1)
  void clearHypoInformation() => clearField(1);
  @$pb.TagNumber(1)
  NotificationPayload_HypoInformation ensureHypoInformation() => $_ensure(0);

  @$pb.TagNumber(2)
  JmaIntensity get maxIntensity => $_getN(1);
  @$pb.TagNumber(2)
  set maxIntensity(JmaIntensity v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMaxIntensity() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxIntensity() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<NotificationPayload_EewRegionIntensity> get regionIntensities =>
      $_getList(2);
}

class NotificationPayload_EarthquakeInformation extends $pb.GeneratedMessage {
  factory NotificationPayload_EarthquakeInformation({
    NotificationPayload_HypoInformation? hypoInformation,
    JmaIntensity? maxIntensity,
    $core.Iterable<NotificationPayload_RegionIntensity>? regionIntensities,
  }) {
    final $result = create();
    if (hypoInformation != null) {
      $result.hypoInformation = hypoInformation;
    }
    if (maxIntensity != null) {
      $result.maxIntensity = maxIntensity;
    }
    if (regionIntensities != null) {
      $result.regionIntensities.addAll(regionIntensities);
    }
    return $result;
  }
  NotificationPayload_EarthquakeInformation._() : super();
  factory NotificationPayload_EarthquakeInformation.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationPayload_EarthquakeInformation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationPayload.EarthquakeInformation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..aOM<NotificationPayload_HypoInformation>(
        1, _omitFieldNames ? '' : 'hypoInformation',
        subBuilder: NotificationPayload_HypoInformation.create)
    ..e<JmaIntensity>(
        2, _omitFieldNames ? '' : 'maxIntensity', $pb.PbFieldType.OE,
        defaultOrMaker: JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: JmaIntensity.valueOf,
        enumValues: JmaIntensity.values)
    ..pc<NotificationPayload_RegionIntensity>(
        3, _omitFieldNames ? '' : 'regionIntensities', $pb.PbFieldType.PM,
        subBuilder: NotificationPayload_RegionIntensity.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationPayload_EarthquakeInformation clone() =>
      NotificationPayload_EarthquakeInformation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationPayload_EarthquakeInformation copyWith(
          void Function(NotificationPayload_EarthquakeInformation) updates) =>
      super.copyWith((message) =>
              updates(message as NotificationPayload_EarthquakeInformation))
          as NotificationPayload_EarthquakeInformation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPayload_EarthquakeInformation create() =>
      NotificationPayload_EarthquakeInformation._();
  NotificationPayload_EarthquakeInformation createEmptyInstance() => create();
  static $pb.PbList<NotificationPayload_EarthquakeInformation>
      createRepeated() =>
          $pb.PbList<NotificationPayload_EarthquakeInformation>();
  @$core.pragma('dart2js:noInline')
  static NotificationPayload_EarthquakeInformation getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          NotificationPayload_EarthquakeInformation>(create);
  static NotificationPayload_EarthquakeInformation? _defaultInstance;

  @$pb.TagNumber(1)
  NotificationPayload_HypoInformation get hypoInformation => $_getN(0);
  @$pb.TagNumber(1)
  set hypoInformation(NotificationPayload_HypoInformation v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHypoInformation() => $_has(0);
  @$pb.TagNumber(1)
  void clearHypoInformation() => clearField(1);
  @$pb.TagNumber(1)
  NotificationPayload_HypoInformation ensureHypoInformation() => $_ensure(0);

  @$pb.TagNumber(2)
  JmaIntensity get maxIntensity => $_getN(1);
  @$pb.TagNumber(2)
  set maxIntensity(JmaIntensity v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMaxIntensity() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxIntensity() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<NotificationPayload_RegionIntensity> get regionIntensities =>
      $_getList(2);
}

class NotificationPayload_RegionIntensity extends $pb.GeneratedMessage {
  factory NotificationPayload_RegionIntensity({
    $core.String? code,
    JmaIntensity? intensity,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (intensity != null) {
      $result.intensity = intensity;
    }
    return $result;
  }
  NotificationPayload_RegionIntensity._() : super();
  factory NotificationPayload_RegionIntensity.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationPayload_RegionIntensity.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationPayload.RegionIntensity',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..e<JmaIntensity>(2, _omitFieldNames ? '' : 'intensity', $pb.PbFieldType.OE,
        defaultOrMaker: JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: JmaIntensity.valueOf,
        enumValues: JmaIntensity.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationPayload_RegionIntensity clone() =>
      NotificationPayload_RegionIntensity()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationPayload_RegionIntensity copyWith(
          void Function(NotificationPayload_RegionIntensity) updates) =>
      super.copyWith((message) =>
              updates(message as NotificationPayload_RegionIntensity))
          as NotificationPayload_RegionIntensity;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPayload_RegionIntensity create() =>
      NotificationPayload_RegionIntensity._();
  NotificationPayload_RegionIntensity createEmptyInstance() => create();
  static $pb.PbList<NotificationPayload_RegionIntensity> createRepeated() =>
      $pb.PbList<NotificationPayload_RegionIntensity>();
  @$core.pragma('dart2js:noInline')
  static NotificationPayload_RegionIntensity getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          NotificationPayload_RegionIntensity>(create);
  static NotificationPayload_RegionIntensity? _defaultInstance;

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
  JmaIntensity get intensity => $_getN(1);
  @$pb.TagNumber(2)
  set intensity(JmaIntensity v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIntensity() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntensity() => clearField(2);
}

class NotificationPayload_EewRegionIntensity extends $pb.GeneratedMessage {
  factory NotificationPayload_EewRegionIntensity({
    $core.String? code,
    JmaIntensity? intensity,
    $0.Timestamp? arrivalTime,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (intensity != null) {
      $result.intensity = intensity;
    }
    if (arrivalTime != null) {
      $result.arrivalTime = arrivalTime;
    }
    return $result;
  }
  NotificationPayload_EewRegionIntensity._() : super();
  factory NotificationPayload_EewRegionIntensity.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationPayload_EewRegionIntensity.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationPayload.EewRegionIntensity',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..e<JmaIntensity>(2, _omitFieldNames ? '' : 'intensity', $pb.PbFieldType.OE,
        defaultOrMaker: JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
        valueOf: JmaIntensity.valueOf,
        enumValues: JmaIntensity.values)
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'arrivalTime',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationPayload_EewRegionIntensity clone() =>
      NotificationPayload_EewRegionIntensity()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationPayload_EewRegionIntensity copyWith(
          void Function(NotificationPayload_EewRegionIntensity) updates) =>
      super.copyWith((message) =>
              updates(message as NotificationPayload_EewRegionIntensity))
          as NotificationPayload_EewRegionIntensity;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPayload_EewRegionIntensity create() =>
      NotificationPayload_EewRegionIntensity._();
  NotificationPayload_EewRegionIntensity createEmptyInstance() => create();
  static $pb.PbList<NotificationPayload_EewRegionIntensity> createRepeated() =>
      $pb.PbList<NotificationPayload_EewRegionIntensity>();
  @$core.pragma('dart2js:noInline')
  static NotificationPayload_EewRegionIntensity getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          NotificationPayload_EewRegionIntensity>(create);
  static NotificationPayload_EewRegionIntensity? _defaultInstance;

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
  JmaIntensity get intensity => $_getN(1);
  @$pb.TagNumber(2)
  set intensity(JmaIntensity v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIntensity() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntensity() => clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get arrivalTime => $_getN(2);
  @$pb.TagNumber(3)
  set arrivalTime($0.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasArrivalTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearArrivalTime() => clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureArrivalTime() => $_ensure(2);
}

class NotificationPayload_HypoInformation extends $pb.GeneratedMessage {
  factory NotificationPayload_HypoInformation({
    $core.int? code,
    $core.String? name,
    $core.double? latitude,
    $core.double? longitude,
    $core.int? depth,
    $core.double? magnitude,
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
    if (depth != null) {
      $result.depth = depth;
    }
    if (magnitude != null) {
      $result.magnitude = magnitude;
    }
    return $result;
  }
  NotificationPayload_HypoInformation._() : super();
  factory NotificationPayload_HypoInformation.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationPayload_HypoInformation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationPayload.HypoInformation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OF)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OF)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'depth', $pb.PbFieldType.O3)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'magnitude', $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationPayload_HypoInformation clone() =>
      NotificationPayload_HypoInformation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationPayload_HypoInformation copyWith(
          void Function(NotificationPayload_HypoInformation) updates) =>
      super.copyWith((message) =>
              updates(message as NotificationPayload_HypoInformation))
          as NotificationPayload_HypoInformation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPayload_HypoInformation create() =>
      NotificationPayload_HypoInformation._();
  NotificationPayload_HypoInformation createEmptyInstance() => create();
  static $pb.PbList<NotificationPayload_HypoInformation> createRepeated() =>
      $pb.PbList<NotificationPayload_HypoInformation>();
  @$core.pragma('dart2js:noInline')
  static NotificationPayload_HypoInformation getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          NotificationPayload_HypoInformation>(create);
  static NotificationPayload_HypoInformation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int v) {
    $_setSignedInt32(0, v);
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
  $core.double get latitude => $_getN(2);
  @$pb.TagNumber(3)
  set latitude($core.double v) {
    $_setFloat(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLatitude() => $_has(2);
  @$pb.TagNumber(3)
  void clearLatitude() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get longitude => $_getN(3);
  @$pb.TagNumber(4)
  set longitude($core.double v) {
    $_setFloat(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasLongitude() => $_has(3);
  @$pb.TagNumber(4)
  void clearLongitude() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get depth => $_getIZ(4);
  @$pb.TagNumber(5)
  set depth($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDepth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDepth() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get magnitude => $_getN(5);
  @$pb.TagNumber(6)
  set magnitude($core.double v) {
    $_setFloat(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasMagnitude() => $_has(5);
  @$pb.TagNumber(6)
  void clearMagnitude() => clearField(6);
}

enum NotificationPayload_Information {
  eewInformation,
  earthquakeInformation,
  notSet
}

class NotificationPayload extends $pb.GeneratedMessage {
  factory NotificationPayload({
    $core.String? eventId,
    NotificationPayload_Type? type,
    NotificationPayload_EewInformation? eewInformation,
    NotificationPayload_EarthquakeInformation? earthquakeInformation,
  }) {
    final $result = create();
    if (eventId != null) {
      $result.eventId = eventId;
    }
    if (type != null) {
      $result.type = type;
    }
    if (eewInformation != null) {
      $result.eewInformation = eewInformation;
    }
    if (earthquakeInformation != null) {
      $result.earthquakeInformation = earthquakeInformation;
    }
    return $result;
  }
  NotificationPayload._() : super();
  factory NotificationPayload.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NotificationPayload.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, NotificationPayload_Information>
      _NotificationPayload_InformationByTag = {
    3: NotificationPayload_Information.eewInformation,
    4: NotificationPayload_Information.earthquakeInformation,
    0: NotificationPayload_Information.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationPayload',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'eqmonitor'),
      createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..e<NotificationPayload_Type>(
        2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: NotificationPayload_Type.TYPE_UNSPECIFIED,
        valueOf: NotificationPayload_Type.valueOf,
        enumValues: NotificationPayload_Type.values)
    ..aOM<NotificationPayload_EewInformation>(
        3, _omitFieldNames ? '' : 'eewInformation',
        subBuilder: NotificationPayload_EewInformation.create)
    ..aOM<NotificationPayload_EarthquakeInformation>(
        4, _omitFieldNames ? '' : 'earthquakeInformation',
        subBuilder: NotificationPayload_EarthquakeInformation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NotificationPayload clone() => NotificationPayload()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NotificationPayload copyWith(void Function(NotificationPayload) updates) =>
      super.copyWith((message) => updates(message as NotificationPayload))
          as NotificationPayload;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPayload create() => NotificationPayload._();
  NotificationPayload createEmptyInstance() => create();
  static $pb.PbList<NotificationPayload> createRepeated() =>
      $pb.PbList<NotificationPayload>();
  @$core.pragma('dart2js:noInline')
  static NotificationPayload getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationPayload>(create);
  static NotificationPayload? _defaultInstance;

  NotificationPayload_Information whichInformation() =>
      _NotificationPayload_InformationByTag[$_whichOneof(0)]!;
  void clearInformation() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => clearField(1);

  @$pb.TagNumber(2)
  NotificationPayload_Type get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(NotificationPayload_Type v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  NotificationPayload_EewInformation get eewInformation => $_getN(2);
  @$pb.TagNumber(3)
  set eewInformation(NotificationPayload_EewInformation v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEewInformation() => $_has(2);
  @$pb.TagNumber(3)
  void clearEewInformation() => clearField(3);
  @$pb.TagNumber(3)
  NotificationPayload_EewInformation ensureEewInformation() => $_ensure(2);

  @$pb.TagNumber(4)
  NotificationPayload_EarthquakeInformation get earthquakeInformation =>
      $_getN(3);
  @$pb.TagNumber(4)
  set earthquakeInformation(NotificationPayload_EarthquakeInformation v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasEarthquakeInformation() => $_has(3);
  @$pb.TagNumber(4)
  void clearEarthquakeInformation() => clearField(4);
  @$pb.TagNumber(4)
  NotificationPayload_EarthquakeInformation ensureEarthquakeInformation() =>
      $_ensure(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
