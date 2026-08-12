// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracked_region_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackedRegionStation {

 String get code; String get name; Tracked<TsunamiStationForecast?> get forecast; Tracked<TsunamiStationObservation?> get observation;
/// Create a copy of TrackedRegionStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackedRegionStationCopyWith<TrackedRegionStation> get copyWith => _$TrackedRegionStationCopyWithImpl<TrackedRegionStation>(this as TrackedRegionStation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackedRegionStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.forecast, forecast)&&const DeepCollectionEquality().equals(other.observation, observation));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(forecast),const DeepCollectionEquality().hash(observation));

@override
String toString() {
  return 'TrackedRegionStation(code: $code, name: $name, forecast: $forecast, observation: $observation)';
}


}

/// @nodoc
abstract mixin class $TrackedRegionStationCopyWith<$Res>  {
  factory $TrackedRegionStationCopyWith(TrackedRegionStation value, $Res Function(TrackedRegionStation) _then) = _$TrackedRegionStationCopyWithImpl;
@useResult
$Res call({
 String code, String name, Tracked<TsunamiStationForecast?> forecast, Tracked<TsunamiStationObservation?> observation
});




}
/// @nodoc
class _$TrackedRegionStationCopyWithImpl<$Res>
    implements $TrackedRegionStationCopyWith<$Res> {
  _$TrackedRegionStationCopyWithImpl(this._self, this._then);

  final TrackedRegionStation _self;
  final $Res Function(TrackedRegionStation) _then;

/// Create a copy of TrackedRegionStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? forecast = null,Object? observation = null,}) {
  return _then(TrackedRegionStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,forecast: null == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiStationForecast?>,observation: null == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiStationObservation?>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackedRegionStation].
extension TrackedRegionStationPatterns on TrackedRegionStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackedRegionStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackedRegionStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackedRegionStation value)  $default,){
final _that = this;
switch (_that) {
case _TrackedRegionStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackedRegionStation value)?  $default,){
final _that = this;
switch (_that) {
case _TrackedRegionStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  Tracked<TsunamiStationForecast?> forecast,  Tracked<TsunamiStationObservation?> observation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackedRegionStation() when $default != null:
return $default(_that.code,_that.name,_that.forecast,_that.observation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  Tracked<TsunamiStationForecast?> forecast,  Tracked<TsunamiStationObservation?> observation)  $default,) {final _that = this;
switch (_that) {
case _TrackedRegionStation():
return $default(_that.code,_that.name,_that.forecast,_that.observation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  Tracked<TsunamiStationForecast?> forecast,  Tracked<TsunamiStationObservation?> observation)?  $default,) {final _that = this;
switch (_that) {
case _TrackedRegionStation() when $default != null:
return $default(_that.code,_that.name,_that.forecast,_that.observation);case _:
  return null;

}
}

}

/// @nodoc


class _TrackedRegionStation implements TrackedRegionStation {
  const _TrackedRegionStation({required this.code, required this.name, required  Tracked<TsunamiStationForecast?> forecast, required  Tracked<TsunamiStationObservation?> observation}): _forecast = forecast,_observation = observation;
  

@override final  String code;
@override final  String name;
 final  Tracked<TsunamiStationForecast?> _forecast;
@override Tracked<TsunamiStationForecast?> get forecast {
  if (_forecast is EqualUnmodifiableListView) return _forecast;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecast);
}

 final  Tracked<TsunamiStationObservation?> _observation;
@override Tracked<TsunamiStationObservation?> get observation {
  if (_observation is EqualUnmodifiableListView) return _observation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_observation);
}


/// Create a copy of TrackedRegionStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackedRegionStationCopyWith<_TrackedRegionStation> get copyWith => __$TrackedRegionStationCopyWithImpl<_TrackedRegionStation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackedRegionStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._forecast, _forecast)&&const DeepCollectionEquality().equals(other._observation, _observation));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_forecast),const DeepCollectionEquality().hash(_observation));

@override
String toString() {
  return 'TrackedRegionStation(code: $code, name: $name, forecast: $forecast, observation: $observation)';
}


}

/// @nodoc
abstract mixin class _$TrackedRegionStationCopyWith<$Res> implements $TrackedRegionStationCopyWith<$Res> {
  factory _$TrackedRegionStationCopyWith(_TrackedRegionStation value, $Res Function(_TrackedRegionStation) _then) = __$TrackedRegionStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, Tracked<TsunamiStationForecast?> forecast, Tracked<TsunamiStationObservation?> observation
});




}
/// @nodoc
class __$TrackedRegionStationCopyWithImpl<$Res>
    implements _$TrackedRegionStationCopyWith<$Res> {
  __$TrackedRegionStationCopyWithImpl(this._self, this._then);

  final _TrackedRegionStation _self;
  final $Res Function(_TrackedRegionStation) _then;

/// Create a copy of TrackedRegionStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? forecast = null,Object? observation = null,}) {
  return _then(_TrackedRegionStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,forecast: null == forecast ? _self._forecast : forecast // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiStationForecast?>,observation: null == observation ? _self._observation : observation // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiStationObservation?>,
  ));
}


}

// dart format on
