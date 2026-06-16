// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Observation {

 List<TsunamiObservationStation> get stations;
/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationCopyWith<Observation> get copyWith => _$ObservationCopyWithImpl<Observation>(this as Observation, _$identity);

  /// Serializes this Observation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Observation&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'Observation(stations: $stations)';
}


}

/// @nodoc
abstract mixin class $ObservationCopyWith<$Res>  {
  factory $ObservationCopyWith(Observation value, $Res Function(Observation) _then) = _$ObservationCopyWithImpl;
@useResult
$Res call({
 List<TsunamiObservationStation> stations
});




}
/// @nodoc
class _$ObservationCopyWithImpl<$Res>
    implements $ObservationCopyWith<$Res> {
  _$ObservationCopyWithImpl(this._self, this._then);

  final Observation _self;
  final $Res Function(Observation) _then;

/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stations = null,}) {
  return _then(_self.copyWith(
stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservationStation>,
  ));
}

}


/// Adds pattern-matching-related methods to [Observation].
extension ObservationPatterns on Observation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Observation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Observation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Observation value)  $default,){
final _that = this;
switch (_that) {
case _Observation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Observation value)?  $default,){
final _that = this;
switch (_that) {
case _Observation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TsunamiObservationStation> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Observation() when $default != null:
return $default(_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TsunamiObservationStation> stations)  $default,) {final _that = this;
switch (_that) {
case _Observation():
return $default(_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TsunamiObservationStation> stations)?  $default,) {final _that = this;
switch (_that) {
case _Observation() when $default != null:
return $default(_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Observation implements Observation {
  const _Observation({required final  List<TsunamiObservationStation> stations}): _stations = stations;
  factory _Observation.fromJson(Map<String, dynamic> json) => _$ObservationFromJson(json);

 final  List<TsunamiObservationStation> _stations;
@override List<TsunamiObservationStation> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservationCopyWith<_Observation> get copyWith => __$ObservationCopyWithImpl<_Observation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ObservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Observation&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'Observation(stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$ObservationCopyWith<$Res> implements $ObservationCopyWith<$Res> {
  factory _$ObservationCopyWith(_Observation value, $Res Function(_Observation) _then) = __$ObservationCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiObservationStation> stations
});




}
/// @nodoc
class __$ObservationCopyWithImpl<$Res>
    implements _$ObservationCopyWith<$Res> {
  __$ObservationCopyWithImpl(this._self, this._then);

  final _Observation _self;
  final $Res Function(_Observation) _then;

/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stations = null,}) {
  return _then(_Observation(
stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservationStation>,
  ));
}


}

// dart format on
