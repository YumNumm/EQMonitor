// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_intensity_region_arrival_time_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewIntensityRegionArrivalTimeTime {

 dynamic get type; DateTime get value;
/// Create a copy of EewIntensityRegionArrivalTimeTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityRegionArrivalTimeTimeCopyWith<EewIntensityRegionArrivalTimeTime> get copyWith => _$EewIntensityRegionArrivalTimeTimeCopyWithImpl<EewIntensityRegionArrivalTimeTime>(this as EewIntensityRegionArrivalTimeTime, _$identity);

  /// Serializes this EewIntensityRegionArrivalTimeTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityRegionArrivalTimeTime&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),value);

@override
String toString() {
  return 'EewIntensityRegionArrivalTimeTime(type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class $EewIntensityRegionArrivalTimeTimeCopyWith<$Res>  {
  factory $EewIntensityRegionArrivalTimeTimeCopyWith(EewIntensityRegionArrivalTimeTime value, $Res Function(EewIntensityRegionArrivalTimeTime) _then) = _$EewIntensityRegionArrivalTimeTimeCopyWithImpl;
@useResult
$Res call({
 dynamic type, DateTime value
});




}
/// @nodoc
class _$EewIntensityRegionArrivalTimeTimeCopyWithImpl<$Res>
    implements $EewIntensityRegionArrivalTimeTimeCopyWith<$Res> {
  _$EewIntensityRegionArrivalTimeTimeCopyWithImpl(this._self, this._then);

  final EewIntensityRegionArrivalTimeTime _self;
  final $Res Function(EewIntensityRegionArrivalTimeTime) _then;

/// Create a copy of EewIntensityRegionArrivalTimeTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? value = null,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [EewIntensityRegionArrivalTimeTime].
extension EewIntensityRegionArrivalTimeTimePatterns on EewIntensityRegionArrivalTimeTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewIntensityRegionArrivalTimeTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewIntensityRegionArrivalTimeTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewIntensityRegionArrivalTimeTime value)  $default,){
final _that = this;
switch (_that) {
case _EewIntensityRegionArrivalTimeTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewIntensityRegionArrivalTimeTime value)?  $default,){
final _that = this;
switch (_that) {
case _EewIntensityRegionArrivalTimeTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic type,  DateTime value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewIntensityRegionArrivalTimeTime() when $default != null:
return $default(_that.type,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic type,  DateTime value)  $default,) {final _that = this;
switch (_that) {
case _EewIntensityRegionArrivalTimeTime():
return $default(_that.type,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic type,  DateTime value)?  $default,) {final _that = this;
switch (_that) {
case _EewIntensityRegionArrivalTimeTime() when $default != null:
return $default(_that.type,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewIntensityRegionArrivalTimeTime implements EewIntensityRegionArrivalTimeTime {
  const _EewIntensityRegionArrivalTimeTime({required this.type, required this.value});
  factory _EewIntensityRegionArrivalTimeTime.fromJson(Map<String, dynamic> json) => _$EewIntensityRegionArrivalTimeTimeFromJson(json);

@override final  dynamic type;
@override final  DateTime value;

/// Create a copy of EewIntensityRegionArrivalTimeTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewIntensityRegionArrivalTimeTimeCopyWith<_EewIntensityRegionArrivalTimeTime> get copyWith => __$EewIntensityRegionArrivalTimeTimeCopyWithImpl<_EewIntensityRegionArrivalTimeTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityRegionArrivalTimeTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewIntensityRegionArrivalTimeTime&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),value);

@override
String toString() {
  return 'EewIntensityRegionArrivalTimeTime(type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class _$EewIntensityRegionArrivalTimeTimeCopyWith<$Res> implements $EewIntensityRegionArrivalTimeTimeCopyWith<$Res> {
  factory _$EewIntensityRegionArrivalTimeTimeCopyWith(_EewIntensityRegionArrivalTimeTime value, $Res Function(_EewIntensityRegionArrivalTimeTime) _then) = __$EewIntensityRegionArrivalTimeTimeCopyWithImpl;
@override @useResult
$Res call({
 dynamic type, DateTime value
});




}
/// @nodoc
class __$EewIntensityRegionArrivalTimeTimeCopyWithImpl<$Res>
    implements _$EewIntensityRegionArrivalTimeTimeCopyWith<$Res> {
  __$EewIntensityRegionArrivalTimeTimeCopyWithImpl(this._self, this._then);

  final _EewIntensityRegionArrivalTimeTime _self;
  final $Res Function(_EewIntensityRegionArrivalTimeTime) _then;

/// Create a copy of EewIntensityRegionArrivalTimeTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? value = null,}) {
  return _then(_EewIntensityRegionArrivalTimeTime(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
