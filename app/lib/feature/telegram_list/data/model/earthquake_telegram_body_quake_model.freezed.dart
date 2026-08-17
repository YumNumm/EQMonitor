// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_telegram_body_quake_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeTelegramBodyQuakeModel {

 String? get magnitude; num? get depth; String? get epicenterName; String? get originTime; JmaIntensity? get maxIntensity;
/// Create a copy of EarthquakeTelegramBodyQuakeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyQuakeModelCopyWith<EarthquakeTelegramBodyQuakeModel> get copyWith => _$EarthquakeTelegramBodyQuakeModelCopyWithImpl<EarthquakeTelegramBodyQuakeModel>(this as EarthquakeTelegramBodyQuakeModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeTelegramBodyQuakeModel&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}


@override
int get hashCode => Object.hash(runtimeType,magnitude,depth,epicenterName,originTime,maxIntensity);

@override
String toString() {
  return 'EarthquakeTelegramBodyQuakeModel(magnitude: $magnitude, depth: $depth, epicenterName: $epicenterName, originTime: $originTime, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class $EarthquakeTelegramBodyQuakeModelCopyWith<$Res>  {
  factory $EarthquakeTelegramBodyQuakeModelCopyWith(EarthquakeTelegramBodyQuakeModel value, $Res Function(EarthquakeTelegramBodyQuakeModel) _then) = _$EarthquakeTelegramBodyQuakeModelCopyWithImpl;
@useResult
$Res call({
 String? magnitude, num? depth, String? epicenterName, String? originTime, JmaIntensity? maxIntensity
});




}
/// @nodoc
class _$EarthquakeTelegramBodyQuakeModelCopyWithImpl<$Res>
    implements $EarthquakeTelegramBodyQuakeModelCopyWith<$Res> {
  _$EarthquakeTelegramBodyQuakeModelCopyWithImpl(this._self, this._then);

  final EarthquakeTelegramBodyQuakeModel _self;
  final $Res Function(EarthquakeTelegramBodyQuakeModel) _then;

/// Create a copy of EarthquakeTelegramBodyQuakeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? magnitude = freezed,Object? depth = freezed,Object? epicenterName = freezed,Object? originTime = freezed,Object? maxIntensity = freezed,}) {
  return _then(EarthquakeTelegramBodyQuakeModel(
magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as String?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as num?,epicenterName: freezed == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeTelegramBodyQuakeModel].
extension EarthquakeTelegramBodyQuakeModelPatterns on EarthquakeTelegramBodyQuakeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyQuakeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuakeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyQuakeModel value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuakeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeTelegramBodyQuakeModel value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuakeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? magnitude,  num? depth,  String? epicenterName,  String? originTime,  JmaIntensity? maxIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuakeModel() when $default != null:
return $default(_that.magnitude,_that.depth,_that.epicenterName,_that.originTime,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? magnitude,  num? depth,  String? epicenterName,  String? originTime,  JmaIntensity? maxIntensity)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuakeModel():
return $default(_that.magnitude,_that.depth,_that.epicenterName,_that.originTime,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? magnitude,  num? depth,  String? epicenterName,  String? originTime,  JmaIntensity? maxIntensity)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyQuakeModel() when $default != null:
return $default(_that.magnitude,_that.depth,_that.epicenterName,_that.originTime,_that.maxIntensity);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeTelegramBodyQuakeModel implements EarthquakeTelegramBodyQuakeModel {
  const _EarthquakeTelegramBodyQuakeModel({this.magnitude, this.depth, this.epicenterName, this.originTime, this.maxIntensity});
  

@override final  String? magnitude;
@override final  num? depth;
@override final  String? epicenterName;
@override final  String? originTime;
@override final  JmaIntensity? maxIntensity;

/// Create a copy of EarthquakeTelegramBodyQuakeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeTelegramBodyQuakeModelCopyWith<_EarthquakeTelegramBodyQuakeModel> get copyWith => __$EarthquakeTelegramBodyQuakeModelCopyWithImpl<_EarthquakeTelegramBodyQuakeModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeTelegramBodyQuakeModel&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}


@override
int get hashCode => Object.hash(runtimeType,magnitude,depth,epicenterName,originTime,maxIntensity);

@override
String toString() {
  return 'EarthquakeTelegramBodyQuakeModel(magnitude: $magnitude, depth: $depth, epicenterName: $epicenterName, originTime: $originTime, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeTelegramBodyQuakeModelCopyWith<$Res> implements $EarthquakeTelegramBodyQuakeModelCopyWith<$Res> {
  factory _$EarthquakeTelegramBodyQuakeModelCopyWith(_EarthquakeTelegramBodyQuakeModel value, $Res Function(_EarthquakeTelegramBodyQuakeModel) _then) = __$EarthquakeTelegramBodyQuakeModelCopyWithImpl;
@override @useResult
$Res call({
 String? magnitude, num? depth, String? epicenterName, String? originTime, JmaIntensity? maxIntensity
});




}
/// @nodoc
class __$EarthquakeTelegramBodyQuakeModelCopyWithImpl<$Res>
    implements _$EarthquakeTelegramBodyQuakeModelCopyWith<$Res> {
  __$EarthquakeTelegramBodyQuakeModelCopyWithImpl(this._self, this._then);

  final _EarthquakeTelegramBodyQuakeModel _self;
  final $Res Function(_EarthquakeTelegramBodyQuakeModel) _then;

/// Create a copy of EarthquakeTelegramBodyQuakeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? magnitude = freezed,Object? depth = freezed,Object? epicenterName = freezed,Object? originTime = freezed,Object? maxIntensity = freezed,}) {
  return _then(_EarthquakeTelegramBodyQuakeModel(
magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as String?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as num?,epicenterName: freezed == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}


}

// dart format on
