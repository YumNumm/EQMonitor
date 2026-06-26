// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_earthquake_count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedEarthquakeCount {

 EarthquakeCountType get type; FeedEarthquakeCountTargetTime get targetTime; FeedEarthquakeCountValues get values;
/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEarthquakeCountCopyWith<FeedEarthquakeCount> get copyWith => _$FeedEarthquakeCountCopyWithImpl<FeedEarthquakeCount>(this as FeedEarthquakeCount, _$identity);

  /// Serializes this FeedEarthquakeCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEarthquakeCount&&(identical(other.type, type) || other.type == type)&&(identical(other.targetTime, targetTime) || other.targetTime == targetTime)&&(identical(other.values, values) || other.values == values));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,targetTime,values);

@override
String toString() {
  return 'FeedEarthquakeCount(type: $type, targetTime: $targetTime, values: $values)';
}


}

/// @nodoc
abstract mixin class $FeedEarthquakeCountCopyWith<$Res>  {
  factory $FeedEarthquakeCountCopyWith(FeedEarthquakeCount value, $Res Function(FeedEarthquakeCount) _then) = _$FeedEarthquakeCountCopyWithImpl;
@useResult
$Res call({
 EarthquakeCountType type, FeedEarthquakeCountTargetTime targetTime, FeedEarthquakeCountValues values
});


$FeedEarthquakeCountTargetTimeCopyWith<$Res> get targetTime;$FeedEarthquakeCountValuesCopyWith<$Res> get values;

}
/// @nodoc
class _$FeedEarthquakeCountCopyWithImpl<$Res>
    implements $FeedEarthquakeCountCopyWith<$Res> {
  _$FeedEarthquakeCountCopyWithImpl(this._self, this._then);

  final FeedEarthquakeCount _self;
  final $Res Function(FeedEarthquakeCount) _then;

/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? targetTime = null,Object? values = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeCountType,targetTime: null == targetTime ? _self.targetTime : targetTime // ignore: cast_nullable_to_non_nullable
as FeedEarthquakeCountTargetTime,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as FeedEarthquakeCountValues,
  ));
}
/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedEarthquakeCountTargetTimeCopyWith<$Res> get targetTime {
  
  return $FeedEarthquakeCountTargetTimeCopyWith<$Res>(_self.targetTime, (value) {
    return _then(_self.copyWith(targetTime: value));
  });
}/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedEarthquakeCountValuesCopyWith<$Res> get values {
  
  return $FeedEarthquakeCountValuesCopyWith<$Res>(_self.values, (value) {
    return _then(_self.copyWith(values: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedEarthquakeCount].
extension FeedEarthquakeCountPatterns on FeedEarthquakeCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEarthquakeCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEarthquakeCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEarthquakeCount value)  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEarthquakeCount value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeCountType type,  FeedEarthquakeCountTargetTime targetTime,  FeedEarthquakeCountValues values)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEarthquakeCount() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeCountType type,  FeedEarthquakeCountTargetTime targetTime,  FeedEarthquakeCountValues values)  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCount():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeCountType type,  FeedEarthquakeCountTargetTime targetTime,  FeedEarthquakeCountValues values)?  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCount() when $default != null:
return $default(_that.type,_that.targetTime,_that.values);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedEarthquakeCount implements FeedEarthquakeCount {
  const _FeedEarthquakeCount({required this.type, required this.targetTime, required this.values});
  factory _FeedEarthquakeCount.fromJson(Map<String, dynamic> json) => _$FeedEarthquakeCountFromJson(json);

@override final  EarthquakeCountType type;
@override final  FeedEarthquakeCountTargetTime targetTime;
@override final  FeedEarthquakeCountValues values;

/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEarthquakeCountCopyWith<_FeedEarthquakeCount> get copyWith => __$FeedEarthquakeCountCopyWithImpl<_FeedEarthquakeCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedEarthquakeCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEarthquakeCount&&(identical(other.type, type) || other.type == type)&&(identical(other.targetTime, targetTime) || other.targetTime == targetTime)&&(identical(other.values, values) || other.values == values));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,targetTime,values);

@override
String toString() {
  return 'FeedEarthquakeCount(type: $type, targetTime: $targetTime, values: $values)';
}


}

/// @nodoc
abstract mixin class _$FeedEarthquakeCountCopyWith<$Res> implements $FeedEarthquakeCountCopyWith<$Res> {
  factory _$FeedEarthquakeCountCopyWith(_FeedEarthquakeCount value, $Res Function(_FeedEarthquakeCount) _then) = __$FeedEarthquakeCountCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeCountType type, FeedEarthquakeCountTargetTime targetTime, FeedEarthquakeCountValues values
});


@override $FeedEarthquakeCountTargetTimeCopyWith<$Res> get targetTime;@override $FeedEarthquakeCountValuesCopyWith<$Res> get values;

}
/// @nodoc
class __$FeedEarthquakeCountCopyWithImpl<$Res>
    implements _$FeedEarthquakeCountCopyWith<$Res> {
  __$FeedEarthquakeCountCopyWithImpl(this._self, this._then);

  final _FeedEarthquakeCount _self;
  final $Res Function(_FeedEarthquakeCount) _then;

/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? targetTime = null,Object? values = null,}) {
  return _then(_FeedEarthquakeCount(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeCountType,targetTime: null == targetTime ? _self.targetTime : targetTime // ignore: cast_nullable_to_non_nullable
as FeedEarthquakeCountTargetTime,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as FeedEarthquakeCountValues,
  ));
}

/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedEarthquakeCountTargetTimeCopyWith<$Res> get targetTime {
  
  return $FeedEarthquakeCountTargetTimeCopyWith<$Res>(_self.targetTime, (value) {
    return _then(_self.copyWith(targetTime: value));
  });
}/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedEarthquakeCountValuesCopyWith<$Res> get values {
  
  return $FeedEarthquakeCountValuesCopyWith<$Res>(_self.values, (value) {
    return _then(_self.copyWith(values: value));
  });
}
}

// dart format on
