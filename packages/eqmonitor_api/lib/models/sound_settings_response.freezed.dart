// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sound_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SoundSettingsResponse {

 IntensitySoundMode get mode;@JsonKey(includeIfNull: true) Map<String, String>? get map;
/// Create a copy of SoundSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SoundSettingsResponseCopyWith<SoundSettingsResponse> get copyWith => _$SoundSettingsResponseCopyWithImpl<SoundSettingsResponse>(this as SoundSettingsResponse, _$identity);

  /// Serializes this SoundSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SoundSettingsResponse&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.map, map));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,const DeepCollectionEquality().hash(map));

@override
String toString() {
  return 'SoundSettingsResponse(mode: $mode, map: $map)';
}


}

/// @nodoc
abstract mixin class $SoundSettingsResponseCopyWith<$Res>  {
  factory $SoundSettingsResponseCopyWith(SoundSettingsResponse value, $Res Function(SoundSettingsResponse) _then) = _$SoundSettingsResponseCopyWithImpl;
@useResult
$Res call({
 IntensitySoundMode mode,@JsonKey(includeIfNull: true) Map<String, String>? map
});




}
/// @nodoc
class _$SoundSettingsResponseCopyWithImpl<$Res>
    implements $SoundSettingsResponseCopyWith<$Res> {
  _$SoundSettingsResponseCopyWithImpl(this._self, this._then);

  final SoundSettingsResponse _self;
  final $Res Function(SoundSettingsResponse) _then;

/// Create a copy of SoundSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? map = freezed,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as IntensitySoundMode,map: freezed == map ? _self.map : map // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SoundSettingsResponse].
extension SoundSettingsResponsePatterns on SoundSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SoundSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SoundSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SoundSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _SoundSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SoundSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SoundSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IntensitySoundMode mode, @JsonKey(includeIfNull: true)  Map<String, String>? map)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SoundSettingsResponse() when $default != null:
return $default(_that.mode,_that.map);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IntensitySoundMode mode, @JsonKey(includeIfNull: true)  Map<String, String>? map)  $default,) {final _that = this;
switch (_that) {
case _SoundSettingsResponse():
return $default(_that.mode,_that.map);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IntensitySoundMode mode, @JsonKey(includeIfNull: true)  Map<String, String>? map)?  $default,) {final _that = this;
switch (_that) {
case _SoundSettingsResponse() when $default != null:
return $default(_that.mode,_that.map);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SoundSettingsResponse implements SoundSettingsResponse {
  const _SoundSettingsResponse({required this.mode, @JsonKey(includeIfNull: true) required final  Map<String, String>? map}): _map = map;
  factory _SoundSettingsResponse.fromJson(Map<String, dynamic> json) => _$SoundSettingsResponseFromJson(json);

@override final  IntensitySoundMode mode;
 final  Map<String, String>? _map;
@override@JsonKey(includeIfNull: true) Map<String, String>? get map {
  final value = _map;
  if (value == null) return null;
  if (_map is EqualUnmodifiableMapView) return _map;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of SoundSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SoundSettingsResponseCopyWith<_SoundSettingsResponse> get copyWith => __$SoundSettingsResponseCopyWithImpl<_SoundSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SoundSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SoundSettingsResponse&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._map, _map));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,const DeepCollectionEquality().hash(_map));

@override
String toString() {
  return 'SoundSettingsResponse(mode: $mode, map: $map)';
}


}

/// @nodoc
abstract mixin class _$SoundSettingsResponseCopyWith<$Res> implements $SoundSettingsResponseCopyWith<$Res> {
  factory _$SoundSettingsResponseCopyWith(_SoundSettingsResponse value, $Res Function(_SoundSettingsResponse) _then) = __$SoundSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
 IntensitySoundMode mode,@JsonKey(includeIfNull: true) Map<String, String>? map
});




}
/// @nodoc
class __$SoundSettingsResponseCopyWithImpl<$Res>
    implements _$SoundSettingsResponseCopyWith<$Res> {
  __$SoundSettingsResponseCopyWithImpl(this._self, this._then);

  final _SoundSettingsResponse _self;
  final $Res Function(_SoundSettingsResponse) _then;

/// Create a copy of SoundSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? map = freezed,}) {
  return _then(_SoundSettingsResponse(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as IntensitySoundMode,map: freezed == map ? _self._map : map // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

// dart format on
