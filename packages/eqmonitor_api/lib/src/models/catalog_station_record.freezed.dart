// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_station_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogStationRecord {

@JsonKey(name: 'station_code') String get stationCode; CatalogStationIntensity get intensity;@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? get observedAt;@JsonKey(includeIfNull: false, name: 'max_acceleration') CatalogStationMaxAcceleration? get maxAcceleration;/// 最大加速度（合成値）を観測した時刻
@JsonKey(includeIfNull: false, name: 'max_accel_time') DateTime? get maxAccelTime;@JsonKey(includeIfNull: false) CatalogStationPeriods? get periods;/// 観測回数。震源レコードのレコード種別フラグがM,H,Dの場合のみ記録される
@JsonKey(includeIfNull: false, name: 'observation_count') int? get observationCount;
/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogStationRecordCopyWith<CatalogStationRecord> get copyWith => _$CatalogStationRecordCopyWithImpl<CatalogStationRecord>(this as CatalogStationRecord, _$identity);

  /// Serializes this CatalogStationRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogStationRecord&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.maxAcceleration, maxAcceleration) || other.maxAcceleration == maxAcceleration)&&(identical(other.maxAccelTime, maxAccelTime) || other.maxAccelTime == maxAccelTime)&&(identical(other.periods, periods) || other.periods == periods)&&(identical(other.observationCount, observationCount) || other.observationCount == observationCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationCode,intensity,observedAt,maxAcceleration,maxAccelTime,periods,observationCount);

@override
String toString() {
  return 'CatalogStationRecord(stationCode: $stationCode, intensity: $intensity, observedAt: $observedAt, maxAcceleration: $maxAcceleration, maxAccelTime: $maxAccelTime, periods: $periods, observationCount: $observationCount)';
}


}

/// @nodoc
abstract mixin class $CatalogStationRecordCopyWith<$Res>  {
  factory $CatalogStationRecordCopyWith(CatalogStationRecord value, $Res Function(CatalogStationRecord) _then) = _$CatalogStationRecordCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'station_code') String stationCode, CatalogStationIntensity intensity,@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? observedAt,@JsonKey(includeIfNull: false, name: 'max_acceleration') CatalogStationMaxAcceleration? maxAcceleration,@JsonKey(includeIfNull: false, name: 'max_accel_time') DateTime? maxAccelTime,@JsonKey(includeIfNull: false) CatalogStationPeriods? periods,@JsonKey(includeIfNull: false, name: 'observation_count') int? observationCount
});


$CatalogStationIntensityCopyWith<$Res> get intensity;$CatalogStationMaxAccelerationCopyWith<$Res>? get maxAcceleration;$CatalogStationPeriodsCopyWith<$Res>? get periods;

}
/// @nodoc
class _$CatalogStationRecordCopyWithImpl<$Res>
    implements $CatalogStationRecordCopyWith<$Res> {
  _$CatalogStationRecordCopyWithImpl(this._self, this._then);

  final CatalogStationRecord _self;
  final $Res Function(CatalogStationRecord) _then;

/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stationCode = null,Object? intensity = null,Object? observedAt = freezed,Object? maxAcceleration = freezed,Object? maxAccelTime = freezed,Object? periods = freezed,Object? observationCount = freezed,}) {
  return _then(_self.copyWith(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as CatalogStationIntensity,observedAt: freezed == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxAcceleration: freezed == maxAcceleration ? _self.maxAcceleration : maxAcceleration // ignore: cast_nullable_to_non_nullable
as CatalogStationMaxAcceleration?,maxAccelTime: freezed == maxAccelTime ? _self.maxAccelTime : maxAccelTime // ignore: cast_nullable_to_non_nullable
as DateTime?,periods: freezed == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as CatalogStationPeriods?,observationCount: freezed == observationCount ? _self.observationCount : observationCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationIntensityCopyWith<$Res> get intensity {
  
  return $CatalogStationIntensityCopyWith<$Res>(_self.intensity, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationMaxAccelerationCopyWith<$Res>? get maxAcceleration {
    if (_self.maxAcceleration == null) {
    return null;
  }

  return $CatalogStationMaxAccelerationCopyWith<$Res>(_self.maxAcceleration!, (value) {
    return _then(_self.copyWith(maxAcceleration: value));
  });
}/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationPeriodsCopyWith<$Res>? get periods {
    if (_self.periods == null) {
    return null;
  }

  return $CatalogStationPeriodsCopyWith<$Res>(_self.periods!, (value) {
    return _then(_self.copyWith(periods: value));
  });
}
}


/// Adds pattern-matching-related methods to [CatalogStationRecord].
extension CatalogStationRecordPatterns on CatalogStationRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogStationRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogStationRecord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogStationRecord value)  $default,){
final _that = this;
switch (_that) {
case _CatalogStationRecord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogStationRecord value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogStationRecord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'station_code')  String stationCode,  CatalogStationIntensity intensity, @JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false, name: 'max_acceleration')  CatalogStationMaxAcceleration? maxAcceleration, @JsonKey(includeIfNull: false, name: 'max_accel_time')  DateTime? maxAccelTime, @JsonKey(includeIfNull: false)  CatalogStationPeriods? periods, @JsonKey(includeIfNull: false, name: 'observation_count')  int? observationCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogStationRecord() when $default != null:
return $default(_that.stationCode,_that.intensity,_that.observedAt,_that.maxAcceleration,_that.maxAccelTime,_that.periods,_that.observationCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'station_code')  String stationCode,  CatalogStationIntensity intensity, @JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false, name: 'max_acceleration')  CatalogStationMaxAcceleration? maxAcceleration, @JsonKey(includeIfNull: false, name: 'max_accel_time')  DateTime? maxAccelTime, @JsonKey(includeIfNull: false)  CatalogStationPeriods? periods, @JsonKey(includeIfNull: false, name: 'observation_count')  int? observationCount)  $default,) {final _that = this;
switch (_that) {
case _CatalogStationRecord():
return $default(_that.stationCode,_that.intensity,_that.observedAt,_that.maxAcceleration,_that.maxAccelTime,_that.periods,_that.observationCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'station_code')  String stationCode,  CatalogStationIntensity intensity, @JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false, name: 'max_acceleration')  CatalogStationMaxAcceleration? maxAcceleration, @JsonKey(includeIfNull: false, name: 'max_accel_time')  DateTime? maxAccelTime, @JsonKey(includeIfNull: false)  CatalogStationPeriods? periods, @JsonKey(includeIfNull: false, name: 'observation_count')  int? observationCount)?  $default,) {final _that = this;
switch (_that) {
case _CatalogStationRecord() when $default != null:
return $default(_that.stationCode,_that.intensity,_that.observedAt,_that.maxAcceleration,_that.maxAccelTime,_that.periods,_that.observationCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogStationRecord implements CatalogStationRecord {
  const _CatalogStationRecord({@JsonKey(name: 'station_code') required this.stationCode, required this.intensity, @JsonKey(includeIfNull: false, name: 'observed_at') this.observedAt, @JsonKey(includeIfNull: false, name: 'max_acceleration') this.maxAcceleration, @JsonKey(includeIfNull: false, name: 'max_accel_time') this.maxAccelTime, @JsonKey(includeIfNull: false) this.periods, @JsonKey(includeIfNull: false, name: 'observation_count') this.observationCount});
  factory _CatalogStationRecord.fromJson(Map<String, dynamic> json) => _$CatalogStationRecordFromJson(json);

@override@JsonKey(name: 'station_code') final  String stationCode;
@override final  CatalogStationIntensity intensity;
@override@JsonKey(includeIfNull: false, name: 'observed_at') final  DateTime? observedAt;
@override@JsonKey(includeIfNull: false, name: 'max_acceleration') final  CatalogStationMaxAcceleration? maxAcceleration;
/// 最大加速度（合成値）を観測した時刻
@override@JsonKey(includeIfNull: false, name: 'max_accel_time') final  DateTime? maxAccelTime;
@override@JsonKey(includeIfNull: false) final  CatalogStationPeriods? periods;
/// 観測回数。震源レコードのレコード種別フラグがM,H,Dの場合のみ記録される
@override@JsonKey(includeIfNull: false, name: 'observation_count') final  int? observationCount;

/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogStationRecordCopyWith<_CatalogStationRecord> get copyWith => __$CatalogStationRecordCopyWithImpl<_CatalogStationRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogStationRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogStationRecord&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.maxAcceleration, maxAcceleration) || other.maxAcceleration == maxAcceleration)&&(identical(other.maxAccelTime, maxAccelTime) || other.maxAccelTime == maxAccelTime)&&(identical(other.periods, periods) || other.periods == periods)&&(identical(other.observationCount, observationCount) || other.observationCount == observationCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationCode,intensity,observedAt,maxAcceleration,maxAccelTime,periods,observationCount);

@override
String toString() {
  return 'CatalogStationRecord(stationCode: $stationCode, intensity: $intensity, observedAt: $observedAt, maxAcceleration: $maxAcceleration, maxAccelTime: $maxAccelTime, periods: $periods, observationCount: $observationCount)';
}


}

/// @nodoc
abstract mixin class _$CatalogStationRecordCopyWith<$Res> implements $CatalogStationRecordCopyWith<$Res> {
  factory _$CatalogStationRecordCopyWith(_CatalogStationRecord value, $Res Function(_CatalogStationRecord) _then) = __$CatalogStationRecordCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'station_code') String stationCode, CatalogStationIntensity intensity,@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? observedAt,@JsonKey(includeIfNull: false, name: 'max_acceleration') CatalogStationMaxAcceleration? maxAcceleration,@JsonKey(includeIfNull: false, name: 'max_accel_time') DateTime? maxAccelTime,@JsonKey(includeIfNull: false) CatalogStationPeriods? periods,@JsonKey(includeIfNull: false, name: 'observation_count') int? observationCount
});


@override $CatalogStationIntensityCopyWith<$Res> get intensity;@override $CatalogStationMaxAccelerationCopyWith<$Res>? get maxAcceleration;@override $CatalogStationPeriodsCopyWith<$Res>? get periods;

}
/// @nodoc
class __$CatalogStationRecordCopyWithImpl<$Res>
    implements _$CatalogStationRecordCopyWith<$Res> {
  __$CatalogStationRecordCopyWithImpl(this._self, this._then);

  final _CatalogStationRecord _self;
  final $Res Function(_CatalogStationRecord) _then;

/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stationCode = null,Object? intensity = null,Object? observedAt = freezed,Object? maxAcceleration = freezed,Object? maxAccelTime = freezed,Object? periods = freezed,Object? observationCount = freezed,}) {
  return _then(_CatalogStationRecord(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as CatalogStationIntensity,observedAt: freezed == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxAcceleration: freezed == maxAcceleration ? _self.maxAcceleration : maxAcceleration // ignore: cast_nullable_to_non_nullable
as CatalogStationMaxAcceleration?,maxAccelTime: freezed == maxAccelTime ? _self.maxAccelTime : maxAccelTime // ignore: cast_nullable_to_non_nullable
as DateTime?,periods: freezed == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as CatalogStationPeriods?,observationCount: freezed == observationCount ? _self.observationCount : observationCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationIntensityCopyWith<$Res> get intensity {
  
  return $CatalogStationIntensityCopyWith<$Res>(_self.intensity, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationMaxAccelerationCopyWith<$Res>? get maxAcceleration {
    if (_self.maxAcceleration == null) {
    return null;
  }

  return $CatalogStationMaxAccelerationCopyWith<$Res>(_self.maxAcceleration!, (value) {
    return _then(_self.copyWith(maxAcceleration: value));
  });
}/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationPeriodsCopyWith<$Res>? get periods {
    if (_self.periods == null) {
    return null;
  }

  return $CatalogStationPeriodsCopyWith<$Res>(_self.periods!, (value) {
    return _then(_self.copyWith(periods: value));
  });
}
}

// dart format on
