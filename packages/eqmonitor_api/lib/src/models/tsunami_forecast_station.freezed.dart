// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_forecast_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiForecastStation {

 String get code; String get name;@JsonKey(name: 'high_tide_date_time') DateTime get highTideDateTime;@JsonKey(includeIfNull: false, name: 'first_height') TsunamiForecastFirstHeight? get firstHeight;
/// Create a copy of TsunamiForecastStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiForecastStationCopyWith<TsunamiForecastStation> get copyWith => _$TsunamiForecastStationCopyWithImpl<TsunamiForecastStation>(this as TsunamiForecastStation, _$identity);

  /// Serializes this TsunamiForecastStation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiForecastStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.highTideDateTime, highTideDateTime) || other.highTideDateTime == highTideDateTime)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,highTideDateTime,firstHeight);

@override
String toString() {
  return 'TsunamiForecastStation(code: $code, name: $name, highTideDateTime: $highTideDateTime, firstHeight: $firstHeight)';
}


}

/// @nodoc
abstract mixin class $TsunamiForecastStationCopyWith<$Res>  {
  factory $TsunamiForecastStationCopyWith(TsunamiForecastStation value, $Res Function(TsunamiForecastStation) _then) = _$TsunamiForecastStationCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(name: 'high_tide_date_time') DateTime highTideDateTime,@JsonKey(includeIfNull: false, name: 'first_height') TsunamiForecastFirstHeight? firstHeight
});


$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;

}
/// @nodoc
class _$TsunamiForecastStationCopyWithImpl<$Res>
    implements $TsunamiForecastStationCopyWith<$Res> {
  _$TsunamiForecastStationCopyWithImpl(this._self, this._then);

  final TsunamiForecastStation _self;
  final $Res Function(TsunamiForecastStation) _then;

/// Create a copy of TsunamiForecastStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? highTideDateTime = null,Object? firstHeight = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,highTideDateTime: null == highTideDateTime ? _self.highTideDateTime : highTideDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeight?,
  ));
}
/// Create a copy of TsunamiForecastStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiForecastStation].
extension TsunamiForecastStationPatterns on TsunamiForecastStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiForecastStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiForecastStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiForecastStation value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiForecastStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiForecastStation value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiForecastStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(name: 'high_tide_date_time')  DateTime highTideDateTime, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiForecastFirstHeight? firstHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiForecastStation() when $default != null:
return $default(_that.code,_that.name,_that.highTideDateTime,_that.firstHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(name: 'high_tide_date_time')  DateTime highTideDateTime, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiForecastFirstHeight? firstHeight)  $default,) {final _that = this;
switch (_that) {
case _TsunamiForecastStation():
return $default(_that.code,_that.name,_that.highTideDateTime,_that.firstHeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name, @JsonKey(name: 'high_tide_date_time')  DateTime highTideDateTime, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiForecastFirstHeight? firstHeight)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiForecastStation() when $default != null:
return $default(_that.code,_that.name,_that.highTideDateTime,_that.firstHeight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiForecastStation implements TsunamiForecastStation {
  const _TsunamiForecastStation({required this.code, required this.name, @JsonKey(name: 'high_tide_date_time') required this.highTideDateTime, @JsonKey(includeIfNull: false, name: 'first_height') this.firstHeight});
  factory _TsunamiForecastStation.fromJson(Map<String, dynamic> json) => _$TsunamiForecastStationFromJson(json);

@override final  String code;
@override final  String name;
@override@JsonKey(name: 'high_tide_date_time') final  DateTime highTideDateTime;
@override@JsonKey(includeIfNull: false, name: 'first_height') final  TsunamiForecastFirstHeight? firstHeight;

/// Create a copy of TsunamiForecastStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiForecastStationCopyWith<_TsunamiForecastStation> get copyWith => __$TsunamiForecastStationCopyWithImpl<_TsunamiForecastStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiForecastStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiForecastStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.highTideDateTime, highTideDateTime) || other.highTideDateTime == highTideDateTime)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,highTideDateTime,firstHeight);

@override
String toString() {
  return 'TsunamiForecastStation(code: $code, name: $name, highTideDateTime: $highTideDateTime, firstHeight: $firstHeight)';
}


}

/// @nodoc
abstract mixin class _$TsunamiForecastStationCopyWith<$Res> implements $TsunamiForecastStationCopyWith<$Res> {
  factory _$TsunamiForecastStationCopyWith(_TsunamiForecastStation value, $Res Function(_TsunamiForecastStation) _then) = __$TsunamiForecastStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(name: 'high_tide_date_time') DateTime highTideDateTime,@JsonKey(includeIfNull: false, name: 'first_height') TsunamiForecastFirstHeight? firstHeight
});


@override $TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;

}
/// @nodoc
class __$TsunamiForecastStationCopyWithImpl<$Res>
    implements _$TsunamiForecastStationCopyWith<$Res> {
  __$TsunamiForecastStationCopyWithImpl(this._self, this._then);

  final _TsunamiForecastStation _self;
  final $Res Function(_TsunamiForecastStation) _then;

/// Create a copy of TsunamiForecastStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? highTideDateTime = null,Object? firstHeight = freezed,}) {
  return _then(_TsunamiForecastStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,highTideDateTime: null == highTideDateTime ? _self.highTideDateTime : highTideDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeight?,
  ));
}

/// Create a copy of TsunamiForecastStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}
}

// dart format on
