// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'station_timeline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StationTimeline {

 String get code; String get name; StationForecastTimeline get forecast; StationObservationTimeline get observation;
/// Create a copy of StationTimeline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationTimelineCopyWith<StationTimeline> get copyWith => _$StationTimelineCopyWithImpl<StationTimeline>(this as StationTimeline, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationTimeline&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.forecast, forecast)&&const DeepCollectionEquality().equals(other.observation, observation));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(forecast),const DeepCollectionEquality().hash(observation));

@override
String toString() {
  return 'StationTimeline(code: $code, name: $name, forecast: $forecast, observation: $observation)';
}


}

/// @nodoc
abstract mixin class $StationTimelineCopyWith<$Res>  {
  factory $StationTimelineCopyWith(StationTimeline value, $Res Function(StationTimeline) _then) = _$StationTimelineCopyWithImpl;
@useResult
$Res call({
 String code, String name, StationForecastTimeline forecast, StationObservationTimeline observation
});




}
/// @nodoc
class _$StationTimelineCopyWithImpl<$Res>
    implements $StationTimelineCopyWith<$Res> {
  _$StationTimelineCopyWithImpl(this._self, this._then);

  final StationTimeline _self;
  final $Res Function(StationTimeline) _then;

/// Create a copy of StationTimeline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? forecast = null,Object? observation = null,}) {
  return _then(StationTimeline(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,forecast: null == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as StationForecastTimeline,observation: null == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as StationObservationTimeline,
  ));
}

}


/// Adds pattern-matching-related methods to [StationTimeline].
extension StationTimelinePatterns on StationTimeline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationTimeline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationTimeline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationTimeline value)  $default,){
final _that = this;
switch (_that) {
case _StationTimeline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationTimeline value)?  $default,){
final _that = this;
switch (_that) {
case _StationTimeline() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  StationForecastTimeline forecast,  StationObservationTimeline observation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationTimeline() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  StationForecastTimeline forecast,  StationObservationTimeline observation)  $default,) {final _that = this;
switch (_that) {
case _StationTimeline():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  StationForecastTimeline forecast,  StationObservationTimeline observation)?  $default,) {final _that = this;
switch (_that) {
case _StationTimeline() when $default != null:
return $default(_that.code,_that.name,_that.forecast,_that.observation);case _:
  return null;

}
}

}

/// @nodoc


class _StationTimeline implements StationTimeline {
  const _StationTimeline({required this.code, required this.name, required  StationForecastTimeline forecast, required  StationObservationTimeline observation}): _forecast = forecast,_observation = observation;
  

@override final  String code;
@override final  String name;
 final  StationForecastTimeline _forecast;
@override StationForecastTimeline get forecast {
  if (_forecast is EqualUnmodifiableListView) return _forecast;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecast);
}

 final  StationObservationTimeline _observation;
@override StationObservationTimeline get observation {
  if (_observation is EqualUnmodifiableListView) return _observation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_observation);
}


/// Create a copy of StationTimeline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationTimelineCopyWith<_StationTimeline> get copyWith => __$StationTimelineCopyWithImpl<_StationTimeline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationTimeline&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._forecast, _forecast)&&const DeepCollectionEquality().equals(other._observation, _observation));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_forecast),const DeepCollectionEquality().hash(_observation));

@override
String toString() {
  return 'StationTimeline(code: $code, name: $name, forecast: $forecast, observation: $observation)';
}


}

/// @nodoc
abstract mixin class _$StationTimelineCopyWith<$Res> implements $StationTimelineCopyWith<$Res> {
  factory _$StationTimelineCopyWith(_StationTimeline value, $Res Function(_StationTimeline) _then) = __$StationTimelineCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, StationForecastTimeline forecast, StationObservationTimeline observation
});




}
/// @nodoc
class __$StationTimelineCopyWithImpl<$Res>
    implements _$StationTimelineCopyWith<$Res> {
  __$StationTimelineCopyWithImpl(this._self, this._then);

  final _StationTimeline _self;
  final $Res Function(_StationTimeline) _then;

/// Create a copy of StationTimeline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? forecast = null,Object? observation = null,}) {
  return _then(_StationTimeline(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,forecast: null == forecast ? _self._forecast : forecast // ignore: cast_nullable_to_non_nullable
as StationForecastTimeline,observation: null == observation ? _self._observation : observation // ignore: cast_nullable_to_non_nullable
as StationObservationTimeline,
  ));
}


}

// dart format on
