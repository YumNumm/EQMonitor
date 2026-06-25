// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_counts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeCounts {

 String get type; TargetTime get targetTime; Values get values;
/// Create a copy of EarthquakeCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCountsCopyWith<EarthquakeCounts> get copyWith => _$EarthquakeCountsCopyWithImpl<EarthquakeCounts>(this as EarthquakeCounts, _$identity);

  /// Serializes this EarthquakeCounts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeCounts&&(identical(other.type, type) || other.type == type)&&(identical(other.targetTime, targetTime) || other.targetTime == targetTime)&&(identical(other.values, values) || other.values == values));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,targetTime,values);

@override
String toString() {
  return 'EarthquakeCounts(type: $type, targetTime: $targetTime, values: $values)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCountsCopyWith<$Res>  {
  factory $EarthquakeCountsCopyWith(EarthquakeCounts value, $Res Function(EarthquakeCounts) _then) = _$EarthquakeCountsCopyWithImpl;
@useResult
$Res call({
 String type, TargetTime targetTime, Values values
});


$TargetTimeCopyWith<$Res> get targetTime;$ValuesCopyWith<$Res> get values;

}
/// @nodoc
class _$EarthquakeCountsCopyWithImpl<$Res>
    implements $EarthquakeCountsCopyWith<$Res> {
  _$EarthquakeCountsCopyWithImpl(this._self, this._then);

  final EarthquakeCounts _self;
  final $Res Function(EarthquakeCounts) _then;

/// Create a copy of EarthquakeCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? targetTime = null,Object? values = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,targetTime: null == targetTime ? _self.targetTime : targetTime // ignore: cast_nullable_to_non_nullable
as TargetTime,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as Values,
  ));
}
/// Create a copy of EarthquakeCounts
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetTimeCopyWith<$Res> get targetTime {
  
  return $TargetTimeCopyWith<$Res>(_self.targetTime, (value) {
    return _then(_self.copyWith(targetTime: value));
  });
}/// Create a copy of EarthquakeCounts
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ValuesCopyWith<$Res> get values {
  
  return $ValuesCopyWith<$Res>(_self.values, (value) {
    return _then(_self.copyWith(values: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeCounts].
extension EarthquakeCountsPatterns on EarthquakeCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeCounts value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeCounts value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  TargetTime targetTime,  Values values)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeCounts() when $default != null:
return $default(_that.type,_that.targetTime,_that.values);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  TargetTime targetTime,  Values values)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCounts():
return $default(_that.type,_that.targetTime,_that.values);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  TargetTime targetTime,  Values values)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCounts() when $default != null:
return $default(_that.type,_that.targetTime,_that.values);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeCounts implements EarthquakeCounts {
  const _EarthquakeCounts({required this.type, required this.targetTime, required this.values});
  factory _EarthquakeCounts.fromJson(Map<String, dynamic> json) => _$EarthquakeCountsFromJson(json);

@override final  String type;
@override final  TargetTime targetTime;
@override final  Values values;

/// Create a copy of EarthquakeCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCountsCopyWith<_EarthquakeCounts> get copyWith => __$EarthquakeCountsCopyWithImpl<_EarthquakeCounts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeCountsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeCounts&&(identical(other.type, type) || other.type == type)&&(identical(other.targetTime, targetTime) || other.targetTime == targetTime)&&(identical(other.values, values) || other.values == values));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,targetTime,values);

@override
String toString() {
  return 'EarthquakeCounts(type: $type, targetTime: $targetTime, values: $values)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCountsCopyWith<$Res> implements $EarthquakeCountsCopyWith<$Res> {
  factory _$EarthquakeCountsCopyWith(_EarthquakeCounts value, $Res Function(_EarthquakeCounts) _then) = __$EarthquakeCountsCopyWithImpl;
@override @useResult
$Res call({
 String type, TargetTime targetTime, Values values
});


@override $TargetTimeCopyWith<$Res> get targetTime;@override $ValuesCopyWith<$Res> get values;

}
/// @nodoc
class __$EarthquakeCountsCopyWithImpl<$Res>
    implements _$EarthquakeCountsCopyWith<$Res> {
  __$EarthquakeCountsCopyWithImpl(this._self, this._then);

  final _EarthquakeCounts _self;
  final $Res Function(_EarthquakeCounts) _then;

/// Create a copy of EarthquakeCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? targetTime = null,Object? values = null,}) {
  return _then(_EarthquakeCounts(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,targetTime: null == targetTime ? _self.targetTime : targetTime // ignore: cast_nullable_to_non_nullable
as TargetTime,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as Values,
  ));
}

/// Create a copy of EarthquakeCounts
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetTimeCopyWith<$Res> get targetTime {
  
  return $TargetTimeCopyWith<$Res>(_self.targetTime, (value) {
    return _then(_self.copyWith(targetTime: value));
  });
}/// Create a copy of EarthquakeCounts
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ValuesCopyWith<$Res> get values {
  
  return $ValuesCopyWith<$Res>(_self.values, (value) {
    return _then(_self.copyWith(values: value));
  });
}
}

// dart format on
