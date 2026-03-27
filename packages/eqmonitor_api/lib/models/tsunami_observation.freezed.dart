// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiObservation {

 List<TsunamiObservationStation> get stations;@JsonKey(includeIfNull: false) String? get code;@JsonKey(includeIfNull: false) String? get name;
/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiObservationCopyWith<TsunamiObservation> get copyWith => _$TsunamiObservationCopyWithImpl<TsunamiObservation>(this as TsunamiObservation, _$identity);

  /// Serializes this TsunamiObservation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiObservation&&const DeepCollectionEquality().equals(other.stations, stations)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(stations),code,name);

@override
String toString() {
  return 'TsunamiObservation(stations: $stations, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $TsunamiObservationCopyWith<$Res>  {
  factory $TsunamiObservationCopyWith(TsunamiObservation value, $Res Function(TsunamiObservation) _then) = _$TsunamiObservationCopyWithImpl;
@useResult
$Res call({
 List<TsunamiObservationStation> stations,@JsonKey(includeIfNull: false) String? code,@JsonKey(includeIfNull: false) String? name
});




}
/// @nodoc
class _$TsunamiObservationCopyWithImpl<$Res>
    implements $TsunamiObservationCopyWith<$Res> {
  _$TsunamiObservationCopyWithImpl(this._self, this._then);

  final TsunamiObservation _self;
  final $Res Function(TsunamiObservation) _then;

/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stations = null,Object? code = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservationStation>,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiObservation].
extension TsunamiObservationPatterns on TsunamiObservation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiObservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiObservation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiObservation value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiObservation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiObservation value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiObservation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TsunamiObservationStation> stations, @JsonKey(includeIfNull: false)  String? code, @JsonKey(includeIfNull: false)  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiObservation() when $default != null:
return $default(_that.stations,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TsunamiObservationStation> stations, @JsonKey(includeIfNull: false)  String? code, @JsonKey(includeIfNull: false)  String? name)  $default,) {final _that = this;
switch (_that) {
case _TsunamiObservation():
return $default(_that.stations,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TsunamiObservationStation> stations, @JsonKey(includeIfNull: false)  String? code, @JsonKey(includeIfNull: false)  String? name)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiObservation() when $default != null:
return $default(_that.stations,_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiObservation implements TsunamiObservation {
  const _TsunamiObservation({required final  List<TsunamiObservationStation> stations, @JsonKey(includeIfNull: false) this.code, @JsonKey(includeIfNull: false) this.name}): _stations = stations;
  factory _TsunamiObservation.fromJson(Map<String, dynamic> json) => _$TsunamiObservationFromJson(json);

 final  List<TsunamiObservationStation> _stations;
@override List<TsunamiObservationStation> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}

@override@JsonKey(includeIfNull: false) final  String? code;
@override@JsonKey(includeIfNull: false) final  String? name;

/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiObservationCopyWith<_TsunamiObservation> get copyWith => __$TsunamiObservationCopyWithImpl<_TsunamiObservation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiObservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiObservation&&const DeepCollectionEquality().equals(other._stations, _stations)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stations),code,name);

@override
String toString() {
  return 'TsunamiObservation(stations: $stations, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$TsunamiObservationCopyWith<$Res> implements $TsunamiObservationCopyWith<$Res> {
  factory _$TsunamiObservationCopyWith(_TsunamiObservation value, $Res Function(_TsunamiObservation) _then) = __$TsunamiObservationCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiObservationStation> stations,@JsonKey(includeIfNull: false) String? code,@JsonKey(includeIfNull: false) String? name
});




}
/// @nodoc
class __$TsunamiObservationCopyWithImpl<$Res>
    implements _$TsunamiObservationCopyWith<$Res> {
  __$TsunamiObservationCopyWithImpl(this._self, this._then);

  final _TsunamiObservation _self;
  final $Res Function(_TsunamiObservation) _then;

/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stations = null,Object? code = freezed,Object? name = freezed,}) {
  return _then(_TsunamiObservation(
stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservationStation>,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
