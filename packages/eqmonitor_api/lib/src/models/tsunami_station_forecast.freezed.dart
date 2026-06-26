// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_station_forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStationForecast {

@JsonKey(name: 'high_tide_at') DateTime get highTideAt;@JsonKey(includeIfNull: false, name: 'first_height') TsunamiStationForecastFirstHeight? get firstHeight;
/// Create a copy of TsunamiStationForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationForecastCopyWith<TsunamiStationForecast> get copyWith => _$TsunamiStationForecastCopyWithImpl<TsunamiStationForecast>(this as TsunamiStationForecast, _$identity);

  /// Serializes this TsunamiStationForecast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationForecast&&(identical(other.highTideAt, highTideAt) || other.highTideAt == highTideAt)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,highTideAt,firstHeight);

@override
String toString() {
  return 'TsunamiStationForecast(highTideAt: $highTideAt, firstHeight: $firstHeight)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationForecastCopyWith<$Res>  {
  factory $TsunamiStationForecastCopyWith(TsunamiStationForecast value, $Res Function(TsunamiStationForecast) _then) = _$TsunamiStationForecastCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'high_tide_at') DateTime highTideAt,@JsonKey(includeIfNull: false, name: 'first_height') TsunamiStationForecastFirstHeight? firstHeight
});


$TsunamiStationForecastFirstHeightCopyWith<$Res>? get firstHeight;

}
/// @nodoc
class _$TsunamiStationForecastCopyWithImpl<$Res>
    implements $TsunamiStationForecastCopyWith<$Res> {
  _$TsunamiStationForecastCopyWithImpl(this._self, this._then);

  final TsunamiStationForecast _self;
  final $Res Function(TsunamiStationForecast) _then;

/// Create a copy of TsunamiStationForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? highTideAt = null,Object? firstHeight = freezed,}) {
  return _then(_self.copyWith(
highTideAt: null == highTideAt ? _self.highTideAt : highTideAt // ignore: cast_nullable_to_non_nullable
as DateTime,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationForecastFirstHeight?,
  ));
}
/// Create a copy of TsunamiStationForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiStationForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiStationForecast].
extension TsunamiStationForecastPatterns on TsunamiStationForecast {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStationForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStationForecast() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStationForecast value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationForecast():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStationForecast value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationForecast() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'high_tide_at')  DateTime highTideAt, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiStationForecastFirstHeight? firstHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStationForecast() when $default != null:
return $default(_that.highTideAt,_that.firstHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'high_tide_at')  DateTime highTideAt, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiStationForecastFirstHeight? firstHeight)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationForecast():
return $default(_that.highTideAt,_that.firstHeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'high_tide_at')  DateTime highTideAt, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiStationForecastFirstHeight? firstHeight)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationForecast() when $default != null:
return $default(_that.highTideAt,_that.firstHeight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStationForecast implements TsunamiStationForecast {
  const _TsunamiStationForecast({@JsonKey(name: 'high_tide_at') required this.highTideAt, @JsonKey(includeIfNull: false, name: 'first_height') this.firstHeight});
  factory _TsunamiStationForecast.fromJson(Map<String, dynamic> json) => _$TsunamiStationForecastFromJson(json);

@override@JsonKey(name: 'high_tide_at') final  DateTime highTideAt;
@override@JsonKey(includeIfNull: false, name: 'first_height') final  TsunamiStationForecastFirstHeight? firstHeight;

/// Create a copy of TsunamiStationForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationForecastCopyWith<_TsunamiStationForecast> get copyWith => __$TsunamiStationForecastCopyWithImpl<_TsunamiStationForecast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStationForecastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationForecast&&(identical(other.highTideAt, highTideAt) || other.highTideAt == highTideAt)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,highTideAt,firstHeight);

@override
String toString() {
  return 'TsunamiStationForecast(highTideAt: $highTideAt, firstHeight: $firstHeight)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationForecastCopyWith<$Res> implements $TsunamiStationForecastCopyWith<$Res> {
  factory _$TsunamiStationForecastCopyWith(_TsunamiStationForecast value, $Res Function(_TsunamiStationForecast) _then) = __$TsunamiStationForecastCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'high_tide_at') DateTime highTideAt,@JsonKey(includeIfNull: false, name: 'first_height') TsunamiStationForecastFirstHeight? firstHeight
});


@override $TsunamiStationForecastFirstHeightCopyWith<$Res>? get firstHeight;

}
/// @nodoc
class __$TsunamiStationForecastCopyWithImpl<$Res>
    implements _$TsunamiStationForecastCopyWith<$Res> {
  __$TsunamiStationForecastCopyWithImpl(this._self, this._then);

  final _TsunamiStationForecast _self;
  final $Res Function(_TsunamiStationForecast) _then;

/// Create a copy of TsunamiStationForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? highTideAt = null,Object? firstHeight = freezed,}) {
  return _then(_TsunamiStationForecast(
highTideAt: null == highTideAt ? _self.highTideAt : highTideAt // ignore: cast_nullable_to_non_nullable
as DateTime,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationForecastFirstHeight?,
  ));
}

/// Create a copy of TsunamiStationForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiStationForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}
}

// dart format on
