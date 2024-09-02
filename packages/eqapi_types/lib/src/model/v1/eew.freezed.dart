// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EewV1 _$EewV1FromJson(Map<String, dynamic> json) {
  return _EewV1.fromJson(json);
}

/// @nodoc
mixin _$EewV1 {
  int get id => throw _privateConstructorUsedError;
  int get eventId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get schemaType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get infoType => throw _privateConstructorUsedError;
  DateTime get reportTime => throw _privateConstructorUsedError;
  int? get serialNo => throw _privateConstructorUsedError;
  String? get headline => throw _privateConstructorUsedError;
  bool get isCanceled => throw _privateConstructorUsedError;
  bool? get isWarning => throw _privateConstructorUsedError;
  bool get isLastInfo => throw _privateConstructorUsedError;
  DateTime? get originTime => throw _privateConstructorUsedError;
  DateTime? get arrivalTime => throw _privateConstructorUsedError;
  String? get hypoName => throw _privateConstructorUsedError;
  int? get depth => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get magnitude => throw _privateConstructorUsedError;
  JmaForecastIntensity? get forecastMaxIntensity =>
      throw _privateConstructorUsedError;
  bool? get forecastMaxIntensityIsOver => throw _privateConstructorUsedError;
  JmaForecastLgIntensity? get forecastMaxLpgmIntensity =>
      throw _privateConstructorUsedError;
  bool? get forecastMaxLpgmIntensityIsOver =>
      throw _privateConstructorUsedError;
  List<EstimatedIntensityRegion>? get regions =>
      throw _privateConstructorUsedError;
  bool? get isPlum => throw _privateConstructorUsedError;
  EewAccuracy? get accuracy => throw _privateConstructorUsedError;

  /// Serializes this EewV1 to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EewV1
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EewV1CopyWith<EewV1> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewV1CopyWith<$Res> {
  factory $EewV1CopyWith(EewV1 value, $Res Function(EewV1) then) =
      _$EewV1CopyWithImpl<$Res, EewV1>;
  @useResult
  $Res call(
      {int id,
      int eventId,
      String type,
      String schemaType,
      String status,
      String infoType,
      DateTime reportTime,
      int? serialNo,
      String? headline,
      bool isCanceled,
      bool? isWarning,
      bool isLastInfo,
      DateTime? originTime,
      DateTime? arrivalTime,
      String? hypoName,
      int? depth,
      double? latitude,
      double? longitude,
      double? magnitude,
      JmaForecastIntensity? forecastMaxIntensity,
      bool? forecastMaxIntensityIsOver,
      JmaForecastLgIntensity? forecastMaxLpgmIntensity,
      bool? forecastMaxLpgmIntensityIsOver,
      List<EstimatedIntensityRegion>? regions,
      bool? isPlum,
      EewAccuracy? accuracy});

  $EewAccuracyCopyWith<$Res>? get accuracy;
}

/// @nodoc
class _$EewV1CopyWithImpl<$Res, $Val extends EewV1>
    implements $EewV1CopyWith<$Res> {
  _$EewV1CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EewV1
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? type = null,
    Object? schemaType = null,
    Object? status = null,
    Object? infoType = null,
    Object? reportTime = null,
    Object? serialNo = freezed,
    Object? headline = freezed,
    Object? isCanceled = null,
    Object? isWarning = freezed,
    Object? isLastInfo = null,
    Object? originTime = freezed,
    Object? arrivalTime = freezed,
    Object? hypoName = freezed,
    Object? depth = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? magnitude = freezed,
    Object? forecastMaxIntensity = freezed,
    Object? forecastMaxIntensityIsOver = freezed,
    Object? forecastMaxLpgmIntensity = freezed,
    Object? forecastMaxLpgmIntensityIsOver = freezed,
    Object? regions = freezed,
    Object? isPlum = freezed,
    Object? accuracy = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      schemaType: null == schemaType
          ? _value.schemaType
          : schemaType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      infoType: null == infoType
          ? _value.infoType
          : infoType // ignore: cast_nullable_to_non_nullable
              as String,
      reportTime: null == reportTime
          ? _value.reportTime
          : reportTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as int?,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
      isCanceled: null == isCanceled
          ? _value.isCanceled
          : isCanceled // ignore: cast_nullable_to_non_nullable
              as bool,
      isWarning: freezed == isWarning
          ? _value.isWarning
          : isWarning // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLastInfo: null == isLastInfo
          ? _value.isLastInfo
          : isLastInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hypoName: freezed == hypoName
          ? _value.hypoName
          : hypoName // ignore: cast_nullable_to_non_nullable
              as String?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      magnitude: freezed == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double?,
      forecastMaxIntensity: freezed == forecastMaxIntensity
          ? _value.forecastMaxIntensity
          : forecastMaxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      forecastMaxIntensityIsOver: freezed == forecastMaxIntensityIsOver
          ? _value.forecastMaxIntensityIsOver
          : forecastMaxIntensityIsOver // ignore: cast_nullable_to_non_nullable
              as bool?,
      forecastMaxLpgmIntensity: freezed == forecastMaxLpgmIntensity
          ? _value.forecastMaxLpgmIntensity
          : forecastMaxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastLgIntensity?,
      forecastMaxLpgmIntensityIsOver: freezed == forecastMaxLpgmIntensityIsOver
          ? _value.forecastMaxLpgmIntensityIsOver
          : forecastMaxLpgmIntensityIsOver // ignore: cast_nullable_to_non_nullable
              as bool?,
      regions: freezed == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<EstimatedIntensityRegion>?,
      isPlum: freezed == isPlum
          ? _value.isPlum
          : isPlum // ignore: cast_nullable_to_non_nullable
              as bool?,
      accuracy: freezed == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as EewAccuracy?,
    ) as $Val);
  }

  /// Create a copy of EewV1
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EewAccuracyCopyWith<$Res>? get accuracy {
    if (_value.accuracy == null) {
      return null;
    }

    return $EewAccuracyCopyWith<$Res>(_value.accuracy!, (value) {
      return _then(_value.copyWith(accuracy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EewV1ImplCopyWith<$Res> implements $EewV1CopyWith<$Res> {
  factory _$$EewV1ImplCopyWith(
          _$EewV1Impl value, $Res Function(_$EewV1Impl) then) =
      __$$EewV1ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int eventId,
      String type,
      String schemaType,
      String status,
      String infoType,
      DateTime reportTime,
      int? serialNo,
      String? headline,
      bool isCanceled,
      bool? isWarning,
      bool isLastInfo,
      DateTime? originTime,
      DateTime? arrivalTime,
      String? hypoName,
      int? depth,
      double? latitude,
      double? longitude,
      double? magnitude,
      JmaForecastIntensity? forecastMaxIntensity,
      bool? forecastMaxIntensityIsOver,
      JmaForecastLgIntensity? forecastMaxLpgmIntensity,
      bool? forecastMaxLpgmIntensityIsOver,
      List<EstimatedIntensityRegion>? regions,
      bool? isPlum,
      EewAccuracy? accuracy});

  @override
  $EewAccuracyCopyWith<$Res>? get accuracy;
}

/// @nodoc
class __$$EewV1ImplCopyWithImpl<$Res>
    extends _$EewV1CopyWithImpl<$Res, _$EewV1Impl>
    implements _$$EewV1ImplCopyWith<$Res> {
  __$$EewV1ImplCopyWithImpl(
      _$EewV1Impl _value, $Res Function(_$EewV1Impl) _then)
      : super(_value, _then);

  /// Create a copy of EewV1
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? type = null,
    Object? schemaType = null,
    Object? status = null,
    Object? infoType = null,
    Object? reportTime = null,
    Object? serialNo = freezed,
    Object? headline = freezed,
    Object? isCanceled = null,
    Object? isWarning = freezed,
    Object? isLastInfo = null,
    Object? originTime = freezed,
    Object? arrivalTime = freezed,
    Object? hypoName = freezed,
    Object? depth = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? magnitude = freezed,
    Object? forecastMaxIntensity = freezed,
    Object? forecastMaxIntensityIsOver = freezed,
    Object? forecastMaxLpgmIntensity = freezed,
    Object? forecastMaxLpgmIntensityIsOver = freezed,
    Object? regions = freezed,
    Object? isPlum = freezed,
    Object? accuracy = freezed,
  }) {
    return _then(_$EewV1Impl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      schemaType: null == schemaType
          ? _value.schemaType
          : schemaType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      infoType: null == infoType
          ? _value.infoType
          : infoType // ignore: cast_nullable_to_non_nullable
              as String,
      reportTime: null == reportTime
          ? _value.reportTime
          : reportTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as int?,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
      isCanceled: null == isCanceled
          ? _value.isCanceled
          : isCanceled // ignore: cast_nullable_to_non_nullable
              as bool,
      isWarning: freezed == isWarning
          ? _value.isWarning
          : isWarning // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLastInfo: null == isLastInfo
          ? _value.isLastInfo
          : isLastInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hypoName: freezed == hypoName
          ? _value.hypoName
          : hypoName // ignore: cast_nullable_to_non_nullable
              as String?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      magnitude: freezed == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double?,
      forecastMaxIntensity: freezed == forecastMaxIntensity
          ? _value.forecastMaxIntensity
          : forecastMaxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      forecastMaxIntensityIsOver: freezed == forecastMaxIntensityIsOver
          ? _value.forecastMaxIntensityIsOver
          : forecastMaxIntensityIsOver // ignore: cast_nullable_to_non_nullable
              as bool?,
      forecastMaxLpgmIntensity: freezed == forecastMaxLpgmIntensity
          ? _value.forecastMaxLpgmIntensity
          : forecastMaxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastLgIntensity?,
      forecastMaxLpgmIntensityIsOver: freezed == forecastMaxLpgmIntensityIsOver
          ? _value.forecastMaxLpgmIntensityIsOver
          : forecastMaxLpgmIntensityIsOver // ignore: cast_nullable_to_non_nullable
              as bool?,
      regions: freezed == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<EstimatedIntensityRegion>?,
      isPlum: freezed == isPlum
          ? _value.isPlum
          : isPlum // ignore: cast_nullable_to_non_nullable
              as bool?,
      accuracy: freezed == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as EewAccuracy?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EewV1Impl implements _EewV1 {
  const _$EewV1Impl(
      {required this.id,
      required this.eventId,
      required this.type,
      required this.schemaType,
      required this.status,
      required this.infoType,
      required this.reportTime,
      this.serialNo,
      this.headline,
      required this.isCanceled,
      this.isWarning,
      required this.isLastInfo,
      this.originTime,
      this.arrivalTime,
      this.hypoName,
      this.depth,
      this.latitude,
      this.longitude,
      this.magnitude,
      this.forecastMaxIntensity,
      this.forecastMaxIntensityIsOver,
      this.forecastMaxLpgmIntensity,
      this.forecastMaxLpgmIntensityIsOver,
      final List<EstimatedIntensityRegion>? regions,
      required this.isPlum,
      required this.accuracy})
      : _regions = regions;

  factory _$EewV1Impl.fromJson(Map<String, dynamic> json) =>
      _$$EewV1ImplFromJson(json);

  @override
  final int id;
  @override
  final int eventId;
  @override
  final String type;
  @override
  final String schemaType;
  @override
  final String status;
  @override
  final String infoType;
  @override
  final DateTime reportTime;
  @override
  final int? serialNo;
  @override
  final String? headline;
  @override
  final bool isCanceled;
  @override
  final bool? isWarning;
  @override
  final bool isLastInfo;
  @override
  final DateTime? originTime;
  @override
  final DateTime? arrivalTime;
  @override
  final String? hypoName;
  @override
  final int? depth;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? magnitude;
  @override
  final JmaForecastIntensity? forecastMaxIntensity;
  @override
  final bool? forecastMaxIntensityIsOver;
  @override
  final JmaForecastLgIntensity? forecastMaxLpgmIntensity;
  @override
  final bool? forecastMaxLpgmIntensityIsOver;
  final List<EstimatedIntensityRegion>? _regions;
  @override
  List<EstimatedIntensityRegion>? get regions {
    final value = _regions;
    if (value == null) return null;
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isPlum;
  @override
  final EewAccuracy? accuracy;

  @override
  String toString() {
    return 'EewV1(id: $id, eventId: $eventId, type: $type, schemaType: $schemaType, status: $status, infoType: $infoType, reportTime: $reportTime, serialNo: $serialNo, headline: $headline, isCanceled: $isCanceled, isWarning: $isWarning, isLastInfo: $isLastInfo, originTime: $originTime, arrivalTime: $arrivalTime, hypoName: $hypoName, depth: $depth, latitude: $latitude, longitude: $longitude, magnitude: $magnitude, forecastMaxIntensity: $forecastMaxIntensity, forecastMaxIntensityIsOver: $forecastMaxIntensityIsOver, forecastMaxLpgmIntensity: $forecastMaxLpgmIntensity, forecastMaxLpgmIntensityIsOver: $forecastMaxLpgmIntensityIsOver, regions: $regions, isPlum: $isPlum, accuracy: $accuracy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EewV1Impl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.schemaType, schemaType) ||
                other.schemaType == schemaType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.infoType, infoType) ||
                other.infoType == infoType) &&
            (identical(other.reportTime, reportTime) ||
                other.reportTime == reportTime) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.headline, headline) ||
                other.headline == headline) &&
            (identical(other.isCanceled, isCanceled) ||
                other.isCanceled == isCanceled) &&
            (identical(other.isWarning, isWarning) ||
                other.isWarning == isWarning) &&
            (identical(other.isLastInfo, isLastInfo) ||
                other.isLastInfo == isLastInfo) &&
            (identical(other.originTime, originTime) ||
                other.originTime == originTime) &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime) &&
            (identical(other.hypoName, hypoName) ||
                other.hypoName == hypoName) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.forecastMaxIntensity, forecastMaxIntensity) ||
                other.forecastMaxIntensity == forecastMaxIntensity) &&
            (identical(other.forecastMaxIntensityIsOver,
                    forecastMaxIntensityIsOver) ||
                other.forecastMaxIntensityIsOver ==
                    forecastMaxIntensityIsOver) &&
            (identical(
                    other.forecastMaxLpgmIntensity, forecastMaxLpgmIntensity) ||
                other.forecastMaxLpgmIntensity == forecastMaxLpgmIntensity) &&
            (identical(other.forecastMaxLpgmIntensityIsOver,
                    forecastMaxLpgmIntensityIsOver) ||
                other.forecastMaxLpgmIntensityIsOver ==
                    forecastMaxLpgmIntensityIsOver) &&
            const DeepCollectionEquality().equals(other._regions, _regions) &&
            (identical(other.isPlum, isPlum) || other.isPlum == isPlum) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        eventId,
        type,
        schemaType,
        status,
        infoType,
        reportTime,
        serialNo,
        headline,
        isCanceled,
        isWarning,
        isLastInfo,
        originTime,
        arrivalTime,
        hypoName,
        depth,
        latitude,
        longitude,
        magnitude,
        forecastMaxIntensity,
        forecastMaxIntensityIsOver,
        forecastMaxLpgmIntensity,
        forecastMaxLpgmIntensityIsOver,
        const DeepCollectionEquality().hash(_regions),
        isPlum,
        accuracy
      ]);

  /// Create a copy of EewV1
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EewV1ImplCopyWith<_$EewV1Impl> get copyWith =>
      __$$EewV1ImplCopyWithImpl<_$EewV1Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EewV1ImplToJson(
      this,
    );
  }
}

abstract class _EewV1 implements EewV1 {
  const factory _EewV1(
      {required final int id,
      required final int eventId,
      required final String type,
      required final String schemaType,
      required final String status,
      required final String infoType,
      required final DateTime reportTime,
      final int? serialNo,
      final String? headline,
      required final bool isCanceled,
      final bool? isWarning,
      required final bool isLastInfo,
      final DateTime? originTime,
      final DateTime? arrivalTime,
      final String? hypoName,
      final int? depth,
      final double? latitude,
      final double? longitude,
      final double? magnitude,
      final JmaForecastIntensity? forecastMaxIntensity,
      final bool? forecastMaxIntensityIsOver,
      final JmaForecastLgIntensity? forecastMaxLpgmIntensity,
      final bool? forecastMaxLpgmIntensityIsOver,
      final List<EstimatedIntensityRegion>? regions,
      required final bool? isPlum,
      required final EewAccuracy? accuracy}) = _$EewV1Impl;

  factory _EewV1.fromJson(Map<String, dynamic> json) = _$EewV1Impl.fromJson;

  @override
  int get id;
  @override
  int get eventId;
  @override
  String get type;
  @override
  String get schemaType;
  @override
  String get status;
  @override
  String get infoType;
  @override
  DateTime get reportTime;
  @override
  int? get serialNo;
  @override
  String? get headline;
  @override
  bool get isCanceled;
  @override
  bool? get isWarning;
  @override
  bool get isLastInfo;
  @override
  DateTime? get originTime;
  @override
  DateTime? get arrivalTime;
  @override
  String? get hypoName;
  @override
  int? get depth;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  double? get magnitude;
  @override
  JmaForecastIntensity? get forecastMaxIntensity;
  @override
  bool? get forecastMaxIntensityIsOver;
  @override
  JmaForecastLgIntensity? get forecastMaxLpgmIntensity;
  @override
  bool? get forecastMaxLpgmIntensityIsOver;
  @override
  List<EstimatedIntensityRegion>? get regions;
  @override
  bool? get isPlum;
  @override
  EewAccuracy? get accuracy;

  /// Create a copy of EewV1
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EewV1ImplCopyWith<_$EewV1Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

EstimatedIntensityRegion _$EstimatedIntensityRegionFromJson(
    Map<String, dynamic> json) {
  return _EstimatedIntensityRegion.fromJson(json);
}

/// @nodoc
mixin _$EstimatedIntensityRegion {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'isPlum')
  bool get isPlum => throw _privateConstructorUsedError;
  @JsonKey(name: 'isWarning')
  bool get isWarning => throw _privateConstructorUsedError;
  @JsonKey(name: 'forecastMaxInt')
  ForecastMaxInt get forecastMaxInt => throw _privateConstructorUsedError;
  @JsonKey(name: 'forecastMaxLgInt')
  ForecastMaxLgInt? get forecastMaxLgInt => throw _privateConstructorUsedError;

  /// nullの場合 `既に主要動到達と推測`
  @JsonKey(name: 'arrivalTime')
  DateTime? get arrivalTime => throw _privateConstructorUsedError;

  /// Serializes this EstimatedIntensityRegion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EstimatedIntensityRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstimatedIntensityRegionCopyWith<EstimatedIntensityRegion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimatedIntensityRegionCopyWith<$Res> {
  factory $EstimatedIntensityRegionCopyWith(EstimatedIntensityRegion value,
          $Res Function(EstimatedIntensityRegion) then) =
      _$EstimatedIntensityRegionCopyWithImpl<$Res, EstimatedIntensityRegion>;
  @useResult
  $Res call(
      {String code,
      String name,
      @JsonKey(name: 'isPlum') bool isPlum,
      @JsonKey(name: 'isWarning') bool isWarning,
      @JsonKey(name: 'forecastMaxInt') ForecastMaxInt forecastMaxInt,
      @JsonKey(name: 'forecastMaxLgInt') ForecastMaxLgInt? forecastMaxLgInt,
      @JsonKey(name: 'arrivalTime') DateTime? arrivalTime});

  $ForecastMaxIntCopyWith<$Res> get forecastMaxInt;
  $ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt;
}

/// @nodoc
class _$EstimatedIntensityRegionCopyWithImpl<$Res,
        $Val extends EstimatedIntensityRegion>
    implements $EstimatedIntensityRegionCopyWith<$Res> {
  _$EstimatedIntensityRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EstimatedIntensityRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? isPlum = null,
    Object? isWarning = null,
    Object? forecastMaxInt = null,
    Object? forecastMaxLgInt = freezed,
    Object? arrivalTime = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isPlum: null == isPlum
          ? _value.isPlum
          : isPlum // ignore: cast_nullable_to_non_nullable
              as bool,
      isWarning: null == isWarning
          ? _value.isWarning
          : isWarning // ignore: cast_nullable_to_non_nullable
              as bool,
      forecastMaxInt: null == forecastMaxInt
          ? _value.forecastMaxInt
          : forecastMaxInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxInt,
      forecastMaxLgInt: freezed == forecastMaxLgInt
          ? _value.forecastMaxLgInt
          : forecastMaxLgInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxLgInt?,
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of EstimatedIntensityRegion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ForecastMaxIntCopyWith<$Res> get forecastMaxInt {
    return $ForecastMaxIntCopyWith<$Res>(_value.forecastMaxInt, (value) {
      return _then(_value.copyWith(forecastMaxInt: value) as $Val);
    });
  }

  /// Create a copy of EstimatedIntensityRegion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt {
    if (_value.forecastMaxLgInt == null) {
      return null;
    }

    return $ForecastMaxLgIntCopyWith<$Res>(_value.forecastMaxLgInt!, (value) {
      return _then(_value.copyWith(forecastMaxLgInt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EstimatedIntensityRegionImplCopyWith<$Res>
    implements $EstimatedIntensityRegionCopyWith<$Res> {
  factory _$$EstimatedIntensityRegionImplCopyWith(
          _$EstimatedIntensityRegionImpl value,
          $Res Function(_$EstimatedIntensityRegionImpl) then) =
      __$$EstimatedIntensityRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String name,
      @JsonKey(name: 'isPlum') bool isPlum,
      @JsonKey(name: 'isWarning') bool isWarning,
      @JsonKey(name: 'forecastMaxInt') ForecastMaxInt forecastMaxInt,
      @JsonKey(name: 'forecastMaxLgInt') ForecastMaxLgInt? forecastMaxLgInt,
      @JsonKey(name: 'arrivalTime') DateTime? arrivalTime});

  @override
  $ForecastMaxIntCopyWith<$Res> get forecastMaxInt;
  @override
  $ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt;
}

/// @nodoc
class __$$EstimatedIntensityRegionImplCopyWithImpl<$Res>
    extends _$EstimatedIntensityRegionCopyWithImpl<$Res,
        _$EstimatedIntensityRegionImpl>
    implements _$$EstimatedIntensityRegionImplCopyWith<$Res> {
  __$$EstimatedIntensityRegionImplCopyWithImpl(
      _$EstimatedIntensityRegionImpl _value,
      $Res Function(_$EstimatedIntensityRegionImpl) _then)
      : super(_value, _then);

  /// Create a copy of EstimatedIntensityRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? isPlum = null,
    Object? isWarning = null,
    Object? forecastMaxInt = null,
    Object? forecastMaxLgInt = freezed,
    Object? arrivalTime = freezed,
  }) {
    return _then(_$EstimatedIntensityRegionImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isPlum: null == isPlum
          ? _value.isPlum
          : isPlum // ignore: cast_nullable_to_non_nullable
              as bool,
      isWarning: null == isWarning
          ? _value.isWarning
          : isWarning // ignore: cast_nullable_to_non_nullable
              as bool,
      forecastMaxInt: null == forecastMaxInt
          ? _value.forecastMaxInt
          : forecastMaxInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxInt,
      forecastMaxLgInt: freezed == forecastMaxLgInt
          ? _value.forecastMaxLgInt
          : forecastMaxLgInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxLgInt?,
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EstimatedIntensityRegionImpl implements _EstimatedIntensityRegion {
  const _$EstimatedIntensityRegionImpl(
      {required this.code,
      required this.name,
      @JsonKey(name: 'isPlum') required this.isPlum,
      @JsonKey(name: 'isWarning') required this.isWarning,
      @JsonKey(name: 'forecastMaxInt') required this.forecastMaxInt,
      @JsonKey(name: 'forecastMaxLgInt') required this.forecastMaxLgInt,
      @JsonKey(name: 'arrivalTime') required this.arrivalTime});

  factory _$EstimatedIntensityRegionImpl.fromJson(Map<String, dynamic> json) =>
      _$$EstimatedIntensityRegionImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  @JsonKey(name: 'isPlum')
  final bool isPlum;
  @override
  @JsonKey(name: 'isWarning')
  final bool isWarning;
  @override
  @JsonKey(name: 'forecastMaxInt')
  final ForecastMaxInt forecastMaxInt;
  @override
  @JsonKey(name: 'forecastMaxLgInt')
  final ForecastMaxLgInt? forecastMaxLgInt;

  /// nullの場合 `既に主要動到達と推測`
  @override
  @JsonKey(name: 'arrivalTime')
  final DateTime? arrivalTime;

  @override
  String toString() {
    return 'EstimatedIntensityRegion(code: $code, name: $name, isPlum: $isPlum, isWarning: $isWarning, forecastMaxInt: $forecastMaxInt, forecastMaxLgInt: $forecastMaxLgInt, arrivalTime: $arrivalTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimatedIntensityRegionImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isPlum, isPlum) || other.isPlum == isPlum) &&
            (identical(other.isWarning, isWarning) ||
                other.isWarning == isWarning) &&
            (identical(other.forecastMaxInt, forecastMaxInt) ||
                other.forecastMaxInt == forecastMaxInt) &&
            (identical(other.forecastMaxLgInt, forecastMaxLgInt) ||
                other.forecastMaxLgInt == forecastMaxLgInt) &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, isPlum, isWarning,
      forecastMaxInt, forecastMaxLgInt, arrivalTime);

  /// Create a copy of EstimatedIntensityRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstimatedIntensityRegionImplCopyWith<_$EstimatedIntensityRegionImpl>
      get copyWith => __$$EstimatedIntensityRegionImplCopyWithImpl<
          _$EstimatedIntensityRegionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EstimatedIntensityRegionImplToJson(
      this,
    );
  }
}

abstract class _EstimatedIntensityRegion implements EstimatedIntensityRegion {
  const factory _EstimatedIntensityRegion(
          {required final String code,
          required final String name,
          @JsonKey(name: 'isPlum') required final bool isPlum,
          @JsonKey(name: 'isWarning') required final bool isWarning,
          @JsonKey(name: 'forecastMaxInt')
          required final ForecastMaxInt forecastMaxInt,
          @JsonKey(name: 'forecastMaxLgInt')
          required final ForecastMaxLgInt? forecastMaxLgInt,
          @JsonKey(name: 'arrivalTime') required final DateTime? arrivalTime}) =
      _$EstimatedIntensityRegionImpl;

  factory _EstimatedIntensityRegion.fromJson(Map<String, dynamic> json) =
      _$EstimatedIntensityRegionImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  @JsonKey(name: 'isPlum')
  bool get isPlum;
  @override
  @JsonKey(name: 'isWarning')
  bool get isWarning;
  @override
  @JsonKey(name: 'forecastMaxInt')
  ForecastMaxInt get forecastMaxInt;
  @override
  @JsonKey(name: 'forecastMaxLgInt')
  ForecastMaxLgInt? get forecastMaxLgInt;

  /// nullの場合 `既に主要動到達と推測`
  @override
  @JsonKey(name: 'arrivalTime')
  DateTime? get arrivalTime;

  /// Create a copy of EstimatedIntensityRegion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimatedIntensityRegionImplCopyWith<_$EstimatedIntensityRegionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EewAccuracy _$EewAccuracyFromJson(Map<String, dynamic> json) {
  return _EewAccuracy.fromJson(json);
}

/// @nodoc
mixin _$EewAccuracy {
  /// ['0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8',
  /// '0' | '1' | '2' | '3' | '4' | '9']
  @JsonKey(fromJson: stringListToIntList, toJson: intListToStringList)
  List<int> get epicenters => throw _privateConstructorUsedError;
  @JsonKey(fromJson: int.parse, toJson: intToString)
  int get depth => throw _privateConstructorUsedError;
  @JsonKey(fromJson: int.parse, toJson: intToString)
  int get magnitudeCalculation => throw _privateConstructorUsedError;
  @JsonKey(fromJson: int.parse, toJson: intToString)
  int get numberOfMagnitudeCalculation => throw _privateConstructorUsedError;

  /// Serializes this EewAccuracy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EewAccuracy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EewAccuracyCopyWith<EewAccuracy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewAccuracyCopyWith<$Res> {
  factory $EewAccuracyCopyWith(
          EewAccuracy value, $Res Function(EewAccuracy) then) =
      _$EewAccuracyCopyWithImpl<$Res, EewAccuracy>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: stringListToIntList, toJson: intListToStringList)
      List<int> epicenters,
      @JsonKey(fromJson: int.parse, toJson: intToString) int depth,
      @JsonKey(fromJson: int.parse, toJson: intToString)
      int magnitudeCalculation,
      @JsonKey(fromJson: int.parse, toJson: intToString)
      int numberOfMagnitudeCalculation});
}

/// @nodoc
class _$EewAccuracyCopyWithImpl<$Res, $Val extends EewAccuracy>
    implements $EewAccuracyCopyWith<$Res> {
  _$EewAccuracyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EewAccuracy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? epicenters = null,
    Object? depth = null,
    Object? magnitudeCalculation = null,
    Object? numberOfMagnitudeCalculation = null,
  }) {
    return _then(_value.copyWith(
      epicenters: null == epicenters
          ? _value.epicenters
          : epicenters // ignore: cast_nullable_to_non_nullable
              as List<int>,
      depth: null == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int,
      magnitudeCalculation: null == magnitudeCalculation
          ? _value.magnitudeCalculation
          : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation
          ? _value.numberOfMagnitudeCalculation
          : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EewAccuracyImplCopyWith<$Res>
    implements $EewAccuracyCopyWith<$Res> {
  factory _$$EewAccuracyImplCopyWith(
          _$EewAccuracyImpl value, $Res Function(_$EewAccuracyImpl) then) =
      __$$EewAccuracyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: stringListToIntList, toJson: intListToStringList)
      List<int> epicenters,
      @JsonKey(fromJson: int.parse, toJson: intToString) int depth,
      @JsonKey(fromJson: int.parse, toJson: intToString)
      int magnitudeCalculation,
      @JsonKey(fromJson: int.parse, toJson: intToString)
      int numberOfMagnitudeCalculation});
}

/// @nodoc
class __$$EewAccuracyImplCopyWithImpl<$Res>
    extends _$EewAccuracyCopyWithImpl<$Res, _$EewAccuracyImpl>
    implements _$$EewAccuracyImplCopyWith<$Res> {
  __$$EewAccuracyImplCopyWithImpl(
      _$EewAccuracyImpl _value, $Res Function(_$EewAccuracyImpl) _then)
      : super(_value, _then);

  /// Create a copy of EewAccuracy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? epicenters = null,
    Object? depth = null,
    Object? magnitudeCalculation = null,
    Object? numberOfMagnitudeCalculation = null,
  }) {
    return _then(_$EewAccuracyImpl(
      epicenters: null == epicenters
          ? _value._epicenters
          : epicenters // ignore: cast_nullable_to_non_nullable
              as List<int>,
      depth: null == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int,
      magnitudeCalculation: null == magnitudeCalculation
          ? _value.magnitudeCalculation
          : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation
          ? _value.numberOfMagnitudeCalculation
          : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$EewAccuracyImpl implements _EewAccuracy {
  const _$EewAccuracyImpl(
      {@JsonKey(fromJson: stringListToIntList, toJson: intListToStringList)
      required final List<int> epicenters,
      @JsonKey(fromJson: int.parse, toJson: intToString) required this.depth,
      @JsonKey(fromJson: int.parse, toJson: intToString)
      required this.magnitudeCalculation,
      @JsonKey(fromJson: int.parse, toJson: intToString)
      required this.numberOfMagnitudeCalculation})
      : _epicenters = epicenters;

  factory _$EewAccuracyImpl.fromJson(Map<String, dynamic> json) =>
      _$$EewAccuracyImplFromJson(json);

  /// ['0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8',
  /// '0' | '1' | '2' | '3' | '4' | '9']
  final List<int> _epicenters;

  /// ['0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8',
  /// '0' | '1' | '2' | '3' | '4' | '9']
  @override
  @JsonKey(fromJson: stringListToIntList, toJson: intListToStringList)
  List<int> get epicenters {
    if (_epicenters is EqualUnmodifiableListView) return _epicenters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_epicenters);
  }

  @override
  @JsonKey(fromJson: int.parse, toJson: intToString)
  final int depth;
  @override
  @JsonKey(fromJson: int.parse, toJson: intToString)
  final int magnitudeCalculation;
  @override
  @JsonKey(fromJson: int.parse, toJson: intToString)
  final int numberOfMagnitudeCalculation;

  @override
  String toString() {
    return 'EewAccuracy(epicenters: $epicenters, depth: $depth, magnitudeCalculation: $magnitudeCalculation, numberOfMagnitudeCalculation: $numberOfMagnitudeCalculation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EewAccuracyImpl &&
            const DeepCollectionEquality()
                .equals(other._epicenters, _epicenters) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.magnitudeCalculation, magnitudeCalculation) ||
                other.magnitudeCalculation == magnitudeCalculation) &&
            (identical(other.numberOfMagnitudeCalculation,
                    numberOfMagnitudeCalculation) ||
                other.numberOfMagnitudeCalculation ==
                    numberOfMagnitudeCalculation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_epicenters),
      depth,
      magnitudeCalculation,
      numberOfMagnitudeCalculation);

  /// Create a copy of EewAccuracy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EewAccuracyImplCopyWith<_$EewAccuracyImpl> get copyWith =>
      __$$EewAccuracyImplCopyWithImpl<_$EewAccuracyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EewAccuracyImplToJson(
      this,
    );
  }
}

abstract class _EewAccuracy implements EewAccuracy {
  const factory _EewAccuracy(
      {@JsonKey(fromJson: stringListToIntList, toJson: intListToStringList)
      required final List<int> epicenters,
      @JsonKey(fromJson: int.parse, toJson: intToString)
      required final int depth,
      @JsonKey(fromJson: int.parse, toJson: intToString)
      required final int magnitudeCalculation,
      @JsonKey(fromJson: int.parse, toJson: intToString)
      required final int numberOfMagnitudeCalculation}) = _$EewAccuracyImpl;

  factory _EewAccuracy.fromJson(Map<String, dynamic> json) =
      _$EewAccuracyImpl.fromJson;

  /// ['0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8',
  /// '0' | '1' | '2' | '3' | '4' | '9']
  @override
  @JsonKey(fromJson: stringListToIntList, toJson: intListToStringList)
  List<int> get epicenters;
  @override
  @JsonKey(fromJson: int.parse, toJson: intToString)
  int get depth;
  @override
  @JsonKey(fromJson: int.parse, toJson: intToString)
  int get magnitudeCalculation;
  @override
  @JsonKey(fromJson: int.parse, toJson: intToString)
  int get numberOfMagnitudeCalculation;

  /// Create a copy of EewAccuracy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EewAccuracyImplCopyWith<_$EewAccuracyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForecastMaxInt _$ForecastMaxIntFromJson(Map<String, dynamic> json) {
  return _ForecastMaxInt.fromJson(json);
}

/// @nodoc
mixin _$ForecastMaxInt {
  JmaForecastIntensity get from => throw _privateConstructorUsedError;
  JmaForecastIntensityOver get to => throw _privateConstructorUsedError;

  /// Serializes this ForecastMaxInt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForecastMaxInt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForecastMaxIntCopyWith<ForecastMaxInt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForecastMaxIntCopyWith<$Res> {
  factory $ForecastMaxIntCopyWith(
          ForecastMaxInt value, $Res Function(ForecastMaxInt) then) =
      _$ForecastMaxIntCopyWithImpl<$Res, ForecastMaxInt>;
  @useResult
  $Res call({JmaForecastIntensity from, JmaForecastIntensityOver to});
}

/// @nodoc
class _$ForecastMaxIntCopyWithImpl<$Res, $Val extends ForecastMaxInt>
    implements $ForecastMaxIntCopyWith<$Res> {
  _$ForecastMaxIntCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForecastMaxInt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_value.copyWith(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensityOver,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForecastMaxIntImplCopyWith<$Res>
    implements $ForecastMaxIntCopyWith<$Res> {
  factory _$$ForecastMaxIntImplCopyWith(_$ForecastMaxIntImpl value,
          $Res Function(_$ForecastMaxIntImpl) then) =
      __$$ForecastMaxIntImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({JmaForecastIntensity from, JmaForecastIntensityOver to});
}

/// @nodoc
class __$$ForecastMaxIntImplCopyWithImpl<$Res>
    extends _$ForecastMaxIntCopyWithImpl<$Res, _$ForecastMaxIntImpl>
    implements _$$ForecastMaxIntImplCopyWith<$Res> {
  __$$ForecastMaxIntImplCopyWithImpl(
      _$ForecastMaxIntImpl _value, $Res Function(_$ForecastMaxIntImpl) _then)
      : super(_value, _then);

  /// Create a copy of ForecastMaxInt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_$ForecastMaxIntImpl(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensityOver,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$ForecastMaxIntImpl implements _ForecastMaxInt {
  const _$ForecastMaxIntImpl({required this.from, required this.to});

  factory _$ForecastMaxIntImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForecastMaxIntImplFromJson(json);

  @override
  final JmaForecastIntensity from;
  @override
  final JmaForecastIntensityOver to;

  @override
  String toString() {
    return 'ForecastMaxInt(from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForecastMaxIntImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, from, to);

  /// Create a copy of ForecastMaxInt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForecastMaxIntImplCopyWith<_$ForecastMaxIntImpl> get copyWith =>
      __$$ForecastMaxIntImplCopyWithImpl<_$ForecastMaxIntImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForecastMaxIntImplToJson(
      this,
    );
  }
}

abstract class _ForecastMaxInt implements ForecastMaxInt {
  const factory _ForecastMaxInt(
      {required final JmaForecastIntensity from,
      required final JmaForecastIntensityOver to}) = _$ForecastMaxIntImpl;

  factory _ForecastMaxInt.fromJson(Map<String, dynamic> json) =
      _$ForecastMaxIntImpl.fromJson;

  @override
  JmaForecastIntensity get from;
  @override
  JmaForecastIntensityOver get to;

  /// Create a copy of ForecastMaxInt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForecastMaxIntImplCopyWith<_$ForecastMaxIntImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForecastMaxLgInt _$ForecastMaxLgIntFromJson(Map<String, dynamic> json) {
  return _ForecastMaxLgInt.fromJson(json);
}

/// @nodoc
mixin _$ForecastMaxLgInt {
  JmaForecastLgIntensity get from => throw _privateConstructorUsedError;
  JmaForecastLgIntensityOver get to => throw _privateConstructorUsedError;

  /// Serializes this ForecastMaxLgInt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForecastMaxLgInt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForecastMaxLgIntCopyWith<ForecastMaxLgInt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForecastMaxLgIntCopyWith<$Res> {
  factory $ForecastMaxLgIntCopyWith(
          ForecastMaxLgInt value, $Res Function(ForecastMaxLgInt) then) =
      _$ForecastMaxLgIntCopyWithImpl<$Res, ForecastMaxLgInt>;
  @useResult
  $Res call({JmaForecastLgIntensity from, JmaForecastLgIntensityOver to});
}

/// @nodoc
class _$ForecastMaxLgIntCopyWithImpl<$Res, $Val extends ForecastMaxLgInt>
    implements $ForecastMaxLgIntCopyWith<$Res> {
  _$ForecastMaxLgIntCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForecastMaxLgInt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_value.copyWith(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as JmaForecastLgIntensity,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as JmaForecastLgIntensityOver,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForecastMaxLgIntImplCopyWith<$Res>
    implements $ForecastMaxLgIntCopyWith<$Res> {
  factory _$$ForecastMaxLgIntImplCopyWith(_$ForecastMaxLgIntImpl value,
          $Res Function(_$ForecastMaxLgIntImpl) then) =
      __$$ForecastMaxLgIntImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({JmaForecastLgIntensity from, JmaForecastLgIntensityOver to});
}

/// @nodoc
class __$$ForecastMaxLgIntImplCopyWithImpl<$Res>
    extends _$ForecastMaxLgIntCopyWithImpl<$Res, _$ForecastMaxLgIntImpl>
    implements _$$ForecastMaxLgIntImplCopyWith<$Res> {
  __$$ForecastMaxLgIntImplCopyWithImpl(_$ForecastMaxLgIntImpl _value,
      $Res Function(_$ForecastMaxLgIntImpl) _then)
      : super(_value, _then);

  /// Create a copy of ForecastMaxLgInt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_$ForecastMaxLgIntImpl(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as JmaForecastLgIntensity,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as JmaForecastLgIntensityOver,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$ForecastMaxLgIntImpl implements _ForecastMaxLgInt {
  const _$ForecastMaxLgIntImpl({required this.from, required this.to});

  factory _$ForecastMaxLgIntImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForecastMaxLgIntImplFromJson(json);

  @override
  final JmaForecastLgIntensity from;
  @override
  final JmaForecastLgIntensityOver to;

  @override
  String toString() {
    return 'ForecastMaxLgInt(from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForecastMaxLgIntImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, from, to);

  /// Create a copy of ForecastMaxLgInt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForecastMaxLgIntImplCopyWith<_$ForecastMaxLgIntImpl> get copyWith =>
      __$$ForecastMaxLgIntImplCopyWithImpl<_$ForecastMaxLgIntImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForecastMaxLgIntImplToJson(
      this,
    );
  }
}

abstract class _ForecastMaxLgInt implements ForecastMaxLgInt {
  const factory _ForecastMaxLgInt(
      {required final JmaForecastLgIntensity from,
      required final JmaForecastLgIntensityOver to}) = _$ForecastMaxLgIntImpl;

  factory _ForecastMaxLgInt.fromJson(Map<String, dynamic> json) =
      _$ForecastMaxLgIntImpl.fromJson;

  @override
  JmaForecastLgIntensity get from;
  @override
  JmaForecastLgIntensityOver get to;

  /// Create a copy of ForecastMaxLgInt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForecastMaxLgIntImplCopyWith<_$ForecastMaxLgIntImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
