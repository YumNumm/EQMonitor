// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_activity_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeActivitySummary {

 int get beforeCount; int get afterCount; JmaIntensity? get maxIntensity; EarthquakeMagnitude? get maxMagnitude; DateTime? get latestOriginTime;
/// Create a copy of EarthquakeActivitySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeActivitySummaryCopyWith<EarthquakeActivitySummary> get copyWith => _$EarthquakeActivitySummaryCopyWithImpl<EarthquakeActivitySummary>(this as EarthquakeActivitySummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeActivitySummary&&(identical(other.beforeCount, beforeCount) || other.beforeCount == beforeCount)&&(identical(other.afterCount, afterCount) || other.afterCount == afterCount)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxMagnitude, maxMagnitude) || other.maxMagnitude == maxMagnitude)&&(identical(other.latestOriginTime, latestOriginTime) || other.latestOriginTime == latestOriginTime));
}


@override
int get hashCode => Object.hash(runtimeType,beforeCount,afterCount,maxIntensity,maxMagnitude,latestOriginTime);

@override
String toString() {
  return 'EarthquakeActivitySummary(beforeCount: $beforeCount, afterCount: $afterCount, maxIntensity: $maxIntensity, maxMagnitude: $maxMagnitude, latestOriginTime: $latestOriginTime)';
}


}

/// @nodoc
abstract mixin class $EarthquakeActivitySummaryCopyWith<$Res>  {
  factory $EarthquakeActivitySummaryCopyWith(EarthquakeActivitySummary value, $Res Function(EarthquakeActivitySummary) _then) = _$EarthquakeActivitySummaryCopyWithImpl;
@useResult
$Res call({
 int beforeCount, int afterCount, JmaIntensity? maxIntensity, EarthquakeMagnitude? maxMagnitude, DateTime? latestOriginTime
});


$EarthquakeMagnitudeCopyWith<$Res>? get maxMagnitude;

}
/// @nodoc
class _$EarthquakeActivitySummaryCopyWithImpl<$Res>
    implements $EarthquakeActivitySummaryCopyWith<$Res> {
  _$EarthquakeActivitySummaryCopyWithImpl(this._self, this._then);

  final EarthquakeActivitySummary _self;
  final $Res Function(EarthquakeActivitySummary) _then;

/// Create a copy of EarthquakeActivitySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? beforeCount = null,Object? afterCount = null,Object? maxIntensity = freezed,Object? maxMagnitude = freezed,Object? latestOriginTime = freezed,}) {
  return _then(_self.copyWith(
beforeCount: null == beforeCount ? _self.beforeCount : beforeCount // ignore: cast_nullable_to_non_nullable
as int,afterCount: null == afterCount ? _self.afterCount : afterCount // ignore: cast_nullable_to_non_nullable
as int,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxMagnitude: freezed == maxMagnitude ? _self.maxMagnitude : maxMagnitude // ignore: cast_nullable_to_non_nullable
as EarthquakeMagnitude?,latestOriginTime: freezed == latestOriginTime ? _self.latestOriginTime : latestOriginTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of EarthquakeActivitySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeMagnitudeCopyWith<$Res>? get maxMagnitude {
    if (_self.maxMagnitude == null) {
    return null;
  }

  return $EarthquakeMagnitudeCopyWith<$Res>(_self.maxMagnitude!, (value) {
    return _then(_self.copyWith(maxMagnitude: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeActivitySummary].
extension EarthquakeActivitySummaryPatterns on EarthquakeActivitySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeActivitySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeActivitySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeActivitySummary value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeActivitySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeActivitySummary value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeActivitySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int beforeCount,  int afterCount,  JmaIntensity? maxIntensity,  EarthquakeMagnitude? maxMagnitude,  DateTime? latestOriginTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeActivitySummary() when $default != null:
return $default(_that.beforeCount,_that.afterCount,_that.maxIntensity,_that.maxMagnitude,_that.latestOriginTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int beforeCount,  int afterCount,  JmaIntensity? maxIntensity,  EarthquakeMagnitude? maxMagnitude,  DateTime? latestOriginTime)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeActivitySummary():
return $default(_that.beforeCount,_that.afterCount,_that.maxIntensity,_that.maxMagnitude,_that.latestOriginTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int beforeCount,  int afterCount,  JmaIntensity? maxIntensity,  EarthquakeMagnitude? maxMagnitude,  DateTime? latestOriginTime)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeActivitySummary() when $default != null:
return $default(_that.beforeCount,_that.afterCount,_that.maxIntensity,_that.maxMagnitude,_that.latestOriginTime);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeActivitySummary implements EarthquakeActivitySummary {
  const _EarthquakeActivitySummary({required this.beforeCount, required this.afterCount, required this.maxIntensity, required this.maxMagnitude, required this.latestOriginTime});


@override final  int beforeCount;
@override final  int afterCount;
@override final  JmaIntensity? maxIntensity;
@override final  EarthquakeMagnitude? maxMagnitude;
@override final  DateTime? latestOriginTime;

/// Create a copy of EarthquakeActivitySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeActivitySummaryCopyWith<_EarthquakeActivitySummary> get copyWith => __$EarthquakeActivitySummaryCopyWithImpl<_EarthquakeActivitySummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeActivitySummary&&(identical(other.beforeCount, beforeCount) || other.beforeCount == beforeCount)&&(identical(other.afterCount, afterCount) || other.afterCount == afterCount)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxMagnitude, maxMagnitude) || other.maxMagnitude == maxMagnitude)&&(identical(other.latestOriginTime, latestOriginTime) || other.latestOriginTime == latestOriginTime));
}


@override
int get hashCode => Object.hash(runtimeType,beforeCount,afterCount,maxIntensity,maxMagnitude,latestOriginTime);

@override
String toString() {
  return 'EarthquakeActivitySummary(beforeCount: $beforeCount, afterCount: $afterCount, maxIntensity: $maxIntensity, maxMagnitude: $maxMagnitude, latestOriginTime: $latestOriginTime)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeActivitySummaryCopyWith<$Res> implements $EarthquakeActivitySummaryCopyWith<$Res> {
  factory _$EarthquakeActivitySummaryCopyWith(_EarthquakeActivitySummary value, $Res Function(_EarthquakeActivitySummary) _then) = __$EarthquakeActivitySummaryCopyWithImpl;
@override @useResult
$Res call({
 int beforeCount, int afterCount, JmaIntensity? maxIntensity, EarthquakeMagnitude? maxMagnitude, DateTime? latestOriginTime
});


@override $EarthquakeMagnitudeCopyWith<$Res>? get maxMagnitude;

}
/// @nodoc
class __$EarthquakeActivitySummaryCopyWithImpl<$Res>
    implements _$EarthquakeActivitySummaryCopyWith<$Res> {
  __$EarthquakeActivitySummaryCopyWithImpl(this._self, this._then);

  final _EarthquakeActivitySummary _self;
  final $Res Function(_EarthquakeActivitySummary) _then;

/// Create a copy of EarthquakeActivitySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? beforeCount = null,Object? afterCount = null,Object? maxIntensity = freezed,Object? maxMagnitude = freezed,Object? latestOriginTime = freezed,}) {
  return _then(_EarthquakeActivitySummary(
beforeCount: null == beforeCount ? _self.beforeCount : beforeCount // ignore: cast_nullable_to_non_nullable
as int,afterCount: null == afterCount ? _self.afterCount : afterCount // ignore: cast_nullable_to_non_nullable
as int,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxMagnitude: freezed == maxMagnitude ? _self.maxMagnitude : maxMagnitude // ignore: cast_nullable_to_non_nullable
as EarthquakeMagnitude?,latestOriginTime: freezed == latestOriginTime ? _self.latestOriginTime : latestOriginTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of EarthquakeActivitySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeMagnitudeCopyWith<$Res>? get maxMagnitude {
    if (_self.maxMagnitude == null) {
    return null;
  }

  return $EarthquakeMagnitudeCopyWith<$Res>(_self.maxMagnitude!, (value) {
    return _then(_self.copyWith(maxMagnitude: value));
  });
}
}

// dart format on
