// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_telegram_body_quake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeTelegramBodyQuake {

 String get eventId;@JsonKey(includeIfNull: false) TelegramStatus? get status;@JsonKey(includeIfNull: false) String? get magnitude;@JsonKey(includeIfNull: false) String? get magnitudeCondition;@JsonKey(includeIfNull: false) JmaIntensity? get maxIntensity;@JsonKey(includeIfNull: false) JmaLpgmIntensity? get maxLpgmIntensity;@JsonKey(includeIfNull: false) num? get depth;@JsonKey(includeIfNull: false) String? get latitude;@JsonKey(includeIfNull: false) String? get longitude;@JsonKey(includeIfNull: false) num? get epicenterCode;@JsonKey(includeIfNull: false) String? get epicenterName;@JsonKey(includeIfNull: false) num? get epicenterDetailCode;@JsonKey(includeIfNull: false) String? get epicenterDetailName;@JsonKey(includeIfNull: false) String? get arrivalTime;@JsonKey(includeIfNull: false) String? get originTime;@JsonKey(includeIfNull: false) String? get originTimePrecision;@JsonKey(includeIfNull: false) String? get estimatedIntensityKey;@JsonKey(includeIfNull: false) String? get datasource;
/// Create a copy of EarthquakeTelegramBodyQuake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyQuakeCopyWith<EarthquakeTelegramBodyQuake> get copyWith => _$EarthquakeTelegramBodyQuakeCopyWithImpl<EarthquakeTelegramBodyQuake>(this as EarthquakeTelegramBodyQuake, _$identity);

  /// Serializes this EarthquakeTelegramBodyQuake to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeTelegramBodyQuake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.magnitudeCondition, magnitudeCondition) || other.magnitudeCondition == magnitudeCondition)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.epicenterCode, epicenterCode) || other.epicenterCode == epicenterCode)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.epicenterDetailCode, epicenterDetailCode) || other.epicenterDetailCode == epicenterDetailCode)&&(identical(other.epicenterDetailName, epicenterDetailName) || other.epicenterDetailName == epicenterDetailName)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.estimatedIntensityKey, estimatedIntensityKey) || other.estimatedIntensityKey == estimatedIntensityKey)&&(identical(other.datasource, datasource) || other.datasource == datasource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,magnitude,magnitudeCondition,maxIntensity,maxLpgmIntensity,depth,latitude,longitude,epicenterCode,epicenterName,epicenterDetailCode,epicenterDetailName,arrivalTime,originTime,originTimePrecision,estimatedIntensityKey,datasource);

@override
String toString() {
  return 'EarthquakeTelegramBodyQuake(eventId: $eventId, status: $status, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, depth: $depth, latitude: $latitude, longitude: $longitude, epicenterCode: $epicenterCode, epicenterName: $epicenterName, epicenterDetailCode: $epicenterDetailCode, epicenterDetailName: $epicenterDetailName, arrivalTime: $arrivalTime, originTime: $originTime, originTimePrecision: $originTimePrecision, estimatedIntensityKey: $estimatedIntensityKey, datasource: $datasource)';
}


}

/// @nodoc
abstract mixin class $EarthquakeTelegramBodyQuakeCopyWith<$Res>  {
  factory $EarthquakeTelegramBodyQuakeCopyWith(EarthquakeTelegramBodyQuake value, $Res Function(EarthquakeTelegramBodyQuake) _then) = _$EarthquakeTelegramBodyQuakeCopyWithImpl;
@useResult
$Res call({
 String eventId,@JsonKey(includeIfNull: false) TelegramStatus? status,@JsonKey(includeIfNull: false) String? magnitude,@JsonKey(includeIfNull: false) String? magnitudeCondition,@JsonKey(includeIfNull: false) JmaIntensity? maxIntensity,@JsonKey(includeIfNull: false) JmaLpgmIntensity? maxLpgmIntensity,@JsonKey(includeIfNull: false) num? depth,@JsonKey(includeIfNull: false) String? latitude,@JsonKey(includeIfNull: false) String? longitude,@JsonKey(includeIfNull: false) num? epicenterCode,@JsonKey(includeIfNull: false) String? epicenterName,@JsonKey(includeIfNull: false) num? epicenterDetailCode,@JsonKey(includeIfNull: false) String? epicenterDetailName,@JsonKey(includeIfNull: false) String? arrivalTime,@JsonKey(includeIfNull: false) String? originTime,@JsonKey(includeIfNull: false) String? originTimePrecision,@JsonKey(includeIfNull: false) String? estimatedIntensityKey,@JsonKey(includeIfNull: false) String? datasource
});




}
/// @nodoc
class _$EarthquakeTelegramBodyQuakeCopyWithImpl<$Res>
    implements $EarthquakeTelegramBodyQuakeCopyWith<$Res> {
  _$EarthquakeTelegramBodyQuakeCopyWithImpl(this._self, this._then);

  final EarthquakeTelegramBodyQuake _self;
  final $Res Function(EarthquakeTelegramBodyQuake) _then;

/// Create a copy of EarthquakeTelegramBodyQuake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = freezed,Object? magnitude = freezed,Object? magnitudeCondition = freezed,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,Object? depth = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? epicenterCode = freezed,Object? epicenterName = freezed,Object? epicenterDetailCode = freezed,Object? epicenterDetailName = freezed,Object? arrivalTime = freezed,Object? originTime = freezed,Object? originTimePrecision = freezed,Object? estimatedIntensityKey = freezed,Object? datasource = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as String?,magnitudeCondition: freezed == magnitudeCondition ? _self.magnitudeCondition : magnitudeCondition // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as num?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as String?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as String?,epicenterCode: freezed == epicenterCode ? _self.epicenterCode : epicenterCode // ignore: cast_nullable_to_non_nullable
as num?,epicenterName: freezed == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String?,epicenterDetailCode: freezed == epicenterDetailCode ? _self.epicenterDetailCode : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
as num?,epicenterDetailName: freezed == epicenterDetailName ? _self.epicenterDetailName : epicenterDetailName // ignore: cast_nullable_to_non_nullable
as String?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as String?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String?,originTimePrecision: freezed == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as String?,estimatedIntensityKey: freezed == estimatedIntensityKey ? _self.estimatedIntensityKey : estimatedIntensityKey // ignore: cast_nullable_to_non_nullable
as String?,datasource: freezed == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeTelegramBodyQuake].
extension EarthquakeTelegramBodyQuakePatterns on EarthquakeTelegramBodyQuake {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyQuake value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuake() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyQuake value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuake():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeTelegramBodyQuake value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuake() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId, @JsonKey(includeIfNull: false)  TelegramStatus? status, @JsonKey(includeIfNull: false)  String? magnitude, @JsonKey(includeIfNull: false)  String? magnitudeCondition, @JsonKey(includeIfNull: false)  JmaIntensity? maxIntensity, @JsonKey(includeIfNull: false)  JmaLpgmIntensity? maxLpgmIntensity, @JsonKey(includeIfNull: false)  num? depth, @JsonKey(includeIfNull: false)  String? latitude, @JsonKey(includeIfNull: false)  String? longitude, @JsonKey(includeIfNull: false)  num? epicenterCode, @JsonKey(includeIfNull: false)  String? epicenterName, @JsonKey(includeIfNull: false)  num? epicenterDetailCode, @JsonKey(includeIfNull: false)  String? epicenterDetailName, @JsonKey(includeIfNull: false)  String? arrivalTime, @JsonKey(includeIfNull: false)  String? originTime, @JsonKey(includeIfNull: false)  String? originTimePrecision, @JsonKey(includeIfNull: false)  String? estimatedIntensityKey, @JsonKey(includeIfNull: false)  String? datasource)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuake() when $default != null:
return $default(_that.eventId,_that.status,_that.magnitude,_that.magnitudeCondition,_that.maxIntensity,_that.maxLpgmIntensity,_that.depth,_that.latitude,_that.longitude,_that.epicenterCode,_that.epicenterName,_that.epicenterDetailCode,_that.epicenterDetailName,_that.arrivalTime,_that.originTime,_that.originTimePrecision,_that.estimatedIntensityKey,_that.datasource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId, @JsonKey(includeIfNull: false)  TelegramStatus? status, @JsonKey(includeIfNull: false)  String? magnitude, @JsonKey(includeIfNull: false)  String? magnitudeCondition, @JsonKey(includeIfNull: false)  JmaIntensity? maxIntensity, @JsonKey(includeIfNull: false)  JmaLpgmIntensity? maxLpgmIntensity, @JsonKey(includeIfNull: false)  num? depth, @JsonKey(includeIfNull: false)  String? latitude, @JsonKey(includeIfNull: false)  String? longitude, @JsonKey(includeIfNull: false)  num? epicenterCode, @JsonKey(includeIfNull: false)  String? epicenterName, @JsonKey(includeIfNull: false)  num? epicenterDetailCode, @JsonKey(includeIfNull: false)  String? epicenterDetailName, @JsonKey(includeIfNull: false)  String? arrivalTime, @JsonKey(includeIfNull: false)  String? originTime, @JsonKey(includeIfNull: false)  String? originTimePrecision, @JsonKey(includeIfNull: false)  String? estimatedIntensityKey, @JsonKey(includeIfNull: false)  String? datasource)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuake():
return $default(_that.eventId,_that.status,_that.magnitude,_that.magnitudeCondition,_that.maxIntensity,_that.maxLpgmIntensity,_that.depth,_that.latitude,_that.longitude,_that.epicenterCode,_that.epicenterName,_that.epicenterDetailCode,_that.epicenterDetailName,_that.arrivalTime,_that.originTime,_that.originTimePrecision,_that.estimatedIntensityKey,_that.datasource);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId, @JsonKey(includeIfNull: false)  TelegramStatus? status, @JsonKey(includeIfNull: false)  String? magnitude, @JsonKey(includeIfNull: false)  String? magnitudeCondition, @JsonKey(includeIfNull: false)  JmaIntensity? maxIntensity, @JsonKey(includeIfNull: false)  JmaLpgmIntensity? maxLpgmIntensity, @JsonKey(includeIfNull: false)  num? depth, @JsonKey(includeIfNull: false)  String? latitude, @JsonKey(includeIfNull: false)  String? longitude, @JsonKey(includeIfNull: false)  num? epicenterCode, @JsonKey(includeIfNull: false)  String? epicenterName, @JsonKey(includeIfNull: false)  num? epicenterDetailCode, @JsonKey(includeIfNull: false)  String? epicenterDetailName, @JsonKey(includeIfNull: false)  String? arrivalTime, @JsonKey(includeIfNull: false)  String? originTime, @JsonKey(includeIfNull: false)  String? originTimePrecision, @JsonKey(includeIfNull: false)  String? estimatedIntensityKey, @JsonKey(includeIfNull: false)  String? datasource)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuake() when $default != null:
return $default(_that.eventId,_that.status,_that.magnitude,_that.magnitudeCondition,_that.maxIntensity,_that.maxLpgmIntensity,_that.depth,_that.latitude,_that.longitude,_that.epicenterCode,_that.epicenterName,_that.epicenterDetailCode,_that.epicenterDetailName,_that.arrivalTime,_that.originTime,_that.originTimePrecision,_that.estimatedIntensityKey,_that.datasource);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeTelegramBodyQuake implements EarthquakeTelegramBodyQuake {
  const _EarthquakeTelegramBodyQuake({required this.eventId, @JsonKey(includeIfNull: false) this.status, @JsonKey(includeIfNull: false) this.magnitude, @JsonKey(includeIfNull: false) this.magnitudeCondition, @JsonKey(includeIfNull: false) this.maxIntensity, @JsonKey(includeIfNull: false) this.maxLpgmIntensity, @JsonKey(includeIfNull: false) this.depth, @JsonKey(includeIfNull: false) this.latitude, @JsonKey(includeIfNull: false) this.longitude, @JsonKey(includeIfNull: false) this.epicenterCode, @JsonKey(includeIfNull: false) this.epicenterName, @JsonKey(includeIfNull: false) this.epicenterDetailCode, @JsonKey(includeIfNull: false) this.epicenterDetailName, @JsonKey(includeIfNull: false) this.arrivalTime, @JsonKey(includeIfNull: false) this.originTime, @JsonKey(includeIfNull: false) this.originTimePrecision, @JsonKey(includeIfNull: false) this.estimatedIntensityKey, @JsonKey(includeIfNull: false) this.datasource});
  factory _EarthquakeTelegramBodyQuake.fromJson(Map<String, dynamic> json) => _$EarthquakeTelegramBodyQuakeFromJson(json);

@override final  String eventId;
@override@JsonKey(includeIfNull: false) final  TelegramStatus? status;
@override@JsonKey(includeIfNull: false) final  String? magnitude;
@override@JsonKey(includeIfNull: false) final  String? magnitudeCondition;
@override@JsonKey(includeIfNull: false) final  JmaIntensity? maxIntensity;
@override@JsonKey(includeIfNull: false) final  JmaLpgmIntensity? maxLpgmIntensity;
@override@JsonKey(includeIfNull: false) final  num? depth;
@override@JsonKey(includeIfNull: false) final  String? latitude;
@override@JsonKey(includeIfNull: false) final  String? longitude;
@override@JsonKey(includeIfNull: false) final  num? epicenterCode;
@override@JsonKey(includeIfNull: false) final  String? epicenterName;
@override@JsonKey(includeIfNull: false) final  num? epicenterDetailCode;
@override@JsonKey(includeIfNull: false) final  String? epicenterDetailName;
@override@JsonKey(includeIfNull: false) final  String? arrivalTime;
@override@JsonKey(includeIfNull: false) final  String? originTime;
@override@JsonKey(includeIfNull: false) final  String? originTimePrecision;
@override@JsonKey(includeIfNull: false) final  String? estimatedIntensityKey;
@override@JsonKey(includeIfNull: false) final  String? datasource;

/// Create a copy of EarthquakeTelegramBodyQuake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeTelegramBodyQuakeCopyWith<_EarthquakeTelegramBodyQuake> get copyWith => __$EarthquakeTelegramBodyQuakeCopyWithImpl<_EarthquakeTelegramBodyQuake>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeTelegramBodyQuakeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeTelegramBodyQuake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.magnitudeCondition, magnitudeCondition) || other.magnitudeCondition == magnitudeCondition)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.epicenterCode, epicenterCode) || other.epicenterCode == epicenterCode)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.epicenterDetailCode, epicenterDetailCode) || other.epicenterDetailCode == epicenterDetailCode)&&(identical(other.epicenterDetailName, epicenterDetailName) || other.epicenterDetailName == epicenterDetailName)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.estimatedIntensityKey, estimatedIntensityKey) || other.estimatedIntensityKey == estimatedIntensityKey)&&(identical(other.datasource, datasource) || other.datasource == datasource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,magnitude,magnitudeCondition,maxIntensity,maxLpgmIntensity,depth,latitude,longitude,epicenterCode,epicenterName,epicenterDetailCode,epicenterDetailName,arrivalTime,originTime,originTimePrecision,estimatedIntensityKey,datasource);

@override
String toString() {
  return 'EarthquakeTelegramBodyQuake(eventId: $eventId, status: $status, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, depth: $depth, latitude: $latitude, longitude: $longitude, epicenterCode: $epicenterCode, epicenterName: $epicenterName, epicenterDetailCode: $epicenterDetailCode, epicenterDetailName: $epicenterDetailName, arrivalTime: $arrivalTime, originTime: $originTime, originTimePrecision: $originTimePrecision, estimatedIntensityKey: $estimatedIntensityKey, datasource: $datasource)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeTelegramBodyQuakeCopyWith<$Res> implements $EarthquakeTelegramBodyQuakeCopyWith<$Res> {
  factory _$EarthquakeTelegramBodyQuakeCopyWith(_EarthquakeTelegramBodyQuake value, $Res Function(_EarthquakeTelegramBodyQuake) _then) = __$EarthquakeTelegramBodyQuakeCopyWithImpl;
@override @useResult
$Res call({
 String eventId,@JsonKey(includeIfNull: false) TelegramStatus? status,@JsonKey(includeIfNull: false) String? magnitude,@JsonKey(includeIfNull: false) String? magnitudeCondition,@JsonKey(includeIfNull: false) JmaIntensity? maxIntensity,@JsonKey(includeIfNull: false) JmaLpgmIntensity? maxLpgmIntensity,@JsonKey(includeIfNull: false) num? depth,@JsonKey(includeIfNull: false) String? latitude,@JsonKey(includeIfNull: false) String? longitude,@JsonKey(includeIfNull: false) num? epicenterCode,@JsonKey(includeIfNull: false) String? epicenterName,@JsonKey(includeIfNull: false) num? epicenterDetailCode,@JsonKey(includeIfNull: false) String? epicenterDetailName,@JsonKey(includeIfNull: false) String? arrivalTime,@JsonKey(includeIfNull: false) String? originTime,@JsonKey(includeIfNull: false) String? originTimePrecision,@JsonKey(includeIfNull: false) String? estimatedIntensityKey,@JsonKey(includeIfNull: false) String? datasource
});




}
/// @nodoc
class __$EarthquakeTelegramBodyQuakeCopyWithImpl<$Res>
    implements _$EarthquakeTelegramBodyQuakeCopyWith<$Res> {
  __$EarthquakeTelegramBodyQuakeCopyWithImpl(this._self, this._then);

  final _EarthquakeTelegramBodyQuake _self;
  final $Res Function(_EarthquakeTelegramBodyQuake) _then;

/// Create a copy of EarthquakeTelegramBodyQuake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = freezed,Object? magnitude = freezed,Object? magnitudeCondition = freezed,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,Object? depth = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? epicenterCode = freezed,Object? epicenterName = freezed,Object? epicenterDetailCode = freezed,Object? epicenterDetailName = freezed,Object? arrivalTime = freezed,Object? originTime = freezed,Object? originTimePrecision = freezed,Object? estimatedIntensityKey = freezed,Object? datasource = freezed,}) {
  return _then(_EarthquakeTelegramBodyQuake(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as String?,magnitudeCondition: freezed == magnitudeCondition ? _self.magnitudeCondition : magnitudeCondition // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as num?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as String?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as String?,epicenterCode: freezed == epicenterCode ? _self.epicenterCode : epicenterCode // ignore: cast_nullable_to_non_nullable
as num?,epicenterName: freezed == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String?,epicenterDetailCode: freezed == epicenterDetailCode ? _self.epicenterDetailCode : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
as num?,epicenterDetailName: freezed == epicenterDetailName ? _self.epicenterDetailName : epicenterDetailName // ignore: cast_nullable_to_non_nullable
as String?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as String?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String?,originTimePrecision: freezed == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as String?,estimatedIntensityKey: freezed == estimatedIntensityKey ? _self.estimatedIntensityKey : estimatedIntensityKey // ignore: cast_nullable_to_non_nullable
as String?,datasource: freezed == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
