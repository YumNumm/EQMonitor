// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_estimated_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EewEstimatedRegion {

 String get regionCode; String get regionName; double get intensity; JmaIntensity? get jmaIntensity; DateTime? get sWaveArrivalTime; bool get isArrived;
/// Create a copy of EewEstimatedRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewEstimatedRegionCopyWith<EewEstimatedRegion> get copyWith => _$EewEstimatedRegionCopyWithImpl<EewEstimatedRegion>(this as EewEstimatedRegion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewEstimatedRegion&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.jmaIntensity, jmaIntensity) || other.jmaIntensity == jmaIntensity)&&(identical(other.sWaveArrivalTime, sWaveArrivalTime) || other.sWaveArrivalTime == sWaveArrivalTime)&&(identical(other.isArrived, isArrived) || other.isArrived == isArrived));
}


@override
int get hashCode => Object.hash(runtimeType,regionCode,regionName,intensity,jmaIntensity,sWaveArrivalTime,isArrived);

@override
String toString() {
  return 'EewEstimatedRegion(regionCode: $regionCode, regionName: $regionName, intensity: $intensity, jmaIntensity: $jmaIntensity, sWaveArrivalTime: $sWaveArrivalTime, isArrived: $isArrived)';
}


}

/// @nodoc
abstract mixin class $EewEstimatedRegionCopyWith<$Res>  {
  factory $EewEstimatedRegionCopyWith(EewEstimatedRegion value, $Res Function(EewEstimatedRegion) _then) = _$EewEstimatedRegionCopyWithImpl;
@useResult
$Res call({
 String regionCode, String regionName, double intensity, JmaIntensity? jmaIntensity, DateTime? sWaveArrivalTime, bool isArrived
});




}
/// @nodoc
class _$EewEstimatedRegionCopyWithImpl<$Res>
    implements $EewEstimatedRegionCopyWith<$Res> {
  _$EewEstimatedRegionCopyWithImpl(this._self, this._then);

  final EewEstimatedRegion _self;
  final $Res Function(EewEstimatedRegion) _then;

/// Create a copy of EewEstimatedRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionCode = null,Object? regionName = null,Object? intensity = null,Object? jmaIntensity = freezed,Object? sWaveArrivalTime = freezed,Object? isArrived = null,}) {
  return _then(EewEstimatedRegion(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String,regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,jmaIntensity: freezed == jmaIntensity ? _self.jmaIntensity : jmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,sWaveArrivalTime: freezed == sWaveArrivalTime ? _self.sWaveArrivalTime : sWaveArrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isArrived: null == isArrived ? _self.isArrived : isArrived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewEstimatedRegion].
extension EewEstimatedRegionPatterns on EewEstimatedRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewEstimatedRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewEstimatedRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewEstimatedRegion value)  $default,){
final _that = this;
switch (_that) {
case _EewEstimatedRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewEstimatedRegion value)?  $default,){
final _that = this;
switch (_that) {
case _EewEstimatedRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String regionCode,  String regionName,  double intensity,  JmaIntensity? jmaIntensity,  DateTime? sWaveArrivalTime,  bool isArrived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewEstimatedRegion() when $default != null:
return $default(_that.regionCode,_that.regionName,_that.intensity,_that.jmaIntensity,_that.sWaveArrivalTime,_that.isArrived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String regionCode,  String regionName,  double intensity,  JmaIntensity? jmaIntensity,  DateTime? sWaveArrivalTime,  bool isArrived)  $default,) {final _that = this;
switch (_that) {
case _EewEstimatedRegion():
return $default(_that.regionCode,_that.regionName,_that.intensity,_that.jmaIntensity,_that.sWaveArrivalTime,_that.isArrived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String regionCode,  String regionName,  double intensity,  JmaIntensity? jmaIntensity,  DateTime? sWaveArrivalTime,  bool isArrived)?  $default,) {final _that = this;
switch (_that) {
case _EewEstimatedRegion() when $default != null:
return $default(_that.regionCode,_that.regionName,_that.intensity,_that.jmaIntensity,_that.sWaveArrivalTime,_that.isArrived);case _:
  return null;

}
}

}

/// @nodoc


class _EewEstimatedRegion implements EewEstimatedRegion {
  const _EewEstimatedRegion({required this.regionCode, required this.regionName, required this.intensity, this.jmaIntensity, this.sWaveArrivalTime, this.isArrived = false});
  

@override final  String regionCode;
@override final  String regionName;
@override final  double intensity;
@override final  JmaIntensity? jmaIntensity;
@override final  DateTime? sWaveArrivalTime;
@override@JsonKey() final  bool isArrived;

/// Create a copy of EewEstimatedRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewEstimatedRegionCopyWith<_EewEstimatedRegion> get copyWith => __$EewEstimatedRegionCopyWithImpl<_EewEstimatedRegion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewEstimatedRegion&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.jmaIntensity, jmaIntensity) || other.jmaIntensity == jmaIntensity)&&(identical(other.sWaveArrivalTime, sWaveArrivalTime) || other.sWaveArrivalTime == sWaveArrivalTime)&&(identical(other.isArrived, isArrived) || other.isArrived == isArrived));
}


@override
int get hashCode => Object.hash(runtimeType,regionCode,regionName,intensity,jmaIntensity,sWaveArrivalTime,isArrived);

@override
String toString() {
  return 'EewEstimatedRegion(regionCode: $regionCode, regionName: $regionName, intensity: $intensity, jmaIntensity: $jmaIntensity, sWaveArrivalTime: $sWaveArrivalTime, isArrived: $isArrived)';
}


}

/// @nodoc
abstract mixin class _$EewEstimatedRegionCopyWith<$Res> implements $EewEstimatedRegionCopyWith<$Res> {
  factory _$EewEstimatedRegionCopyWith(_EewEstimatedRegion value, $Res Function(_EewEstimatedRegion) _then) = __$EewEstimatedRegionCopyWithImpl;
@override @useResult
$Res call({
 String regionCode, String regionName, double intensity, JmaIntensity? jmaIntensity, DateTime? sWaveArrivalTime, bool isArrived
});




}
/// @nodoc
class __$EewEstimatedRegionCopyWithImpl<$Res>
    implements _$EewEstimatedRegionCopyWith<$Res> {
  __$EewEstimatedRegionCopyWithImpl(this._self, this._then);

  final _EewEstimatedRegion _self;
  final $Res Function(_EewEstimatedRegion) _then;

/// Create a copy of EewEstimatedRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionCode = null,Object? regionName = null,Object? intensity = null,Object? jmaIntensity = freezed,Object? sWaveArrivalTime = freezed,Object? isArrived = null,}) {
  return _then(_EewEstimatedRegion(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String,regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,jmaIntensity: freezed == jmaIntensity ? _self.jmaIntensity : jmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,sWaveArrivalTime: freezed == sWaveArrivalTime ? _self.sWaveArrivalTime : sWaveArrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isArrived: null == isArrived ? _self.isArrived : isArrived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
