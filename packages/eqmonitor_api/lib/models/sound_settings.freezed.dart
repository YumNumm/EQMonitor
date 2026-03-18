// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sound_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SoundSettings {

 IntensitySoundMode get mode;@JsonKey(includeIfNull: false) Map<String, String>? get map;
/// Create a copy of SoundSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<SoundSettings> get copyWith => _$SoundSettingsCopyWithImpl<SoundSettings>(this as SoundSettings, _$identity);

  /// Serializes this SoundSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SoundSettings&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.map, map));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,const DeepCollectionEquality().hash(map));

@override
String toString() {
  return 'SoundSettings(mode: $mode, map: $map)';
}


}

/// @nodoc
abstract mixin class $SoundSettingsCopyWith<$Res>  {
  factory $SoundSettingsCopyWith(SoundSettings value, $Res Function(SoundSettings) _then) = _$SoundSettingsCopyWithImpl;
@useResult
$Res call({
 IntensitySoundMode mode,@JsonKey(includeIfNull: false) Map<String, String>? map
});




}
/// @nodoc
class _$SoundSettingsCopyWithImpl<$Res>
    implements $SoundSettingsCopyWith<$Res> {
  _$SoundSettingsCopyWithImpl(this._self, this._then);

  final SoundSettings _self;
  final $Res Function(SoundSettings) _then;

/// Create a copy of SoundSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? map = freezed,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as IntensitySoundMode,map: freezed == map ? _self.map : map // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SoundSettings].
extension SoundSettingsPatterns on SoundSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SoundSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SoundSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SoundSettings value)  $default,){
final _that = this;
switch (_that) {
case _SoundSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SoundSettings value)?  $default,){
final _that = this;
switch (_that) {
case _SoundSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IntensitySoundMode mode, @JsonKey(includeIfNull: false)  Map<String, String>? map)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SoundSettings() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IntensitySoundMode mode, @JsonKey(includeIfNull: false)  Map<String, String>? map)  $default,) {final _that = this;
switch (_that) {
case _SoundSettings():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IntensitySoundMode mode, @JsonKey(includeIfNull: false)  Map<String, String>? map)?  $default,) {final _that = this;
switch (_that) {
case _SoundSettings() when $default != null:
return $default(_that.mode,_that.map);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SoundSettings implements SoundSettings {
  const _SoundSettings({required this.mode, @JsonKey(includeIfNull: false) final  Map<String, String>? map}): _map = map;
  factory _SoundSettings.fromJson(Map<String, dynamic> json) => _$SoundSettingsFromJson(json);

@override final  IntensitySoundMode mode;
 final  Map<String, String>? _map;
@override@JsonKey(includeIfNull: false) Map<String, String>? get map {
  final value = _map;
  if (value == null) return null;
  if (_map is EqualUnmodifiableMapView) return _map;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of SoundSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SoundSettingsCopyWith<_SoundSettings> get copyWith => __$SoundSettingsCopyWithImpl<_SoundSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SoundSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SoundSettings&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._map, _map));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,const DeepCollectionEquality().hash(_map));

@override
String toString() {
  return 'SoundSettings(mode: $mode, map: $map)';
}


}

/// @nodoc
abstract mixin class _$SoundSettingsCopyWith<$Res> implements $SoundSettingsCopyWith<$Res> {
  factory _$SoundSettingsCopyWith(_SoundSettings value, $Res Function(_SoundSettings) _then) = __$SoundSettingsCopyWithImpl;
@override @useResult
$Res call({
 IntensitySoundMode mode,@JsonKey(includeIfNull: false) Map<String, String>? map
});




}
/// @nodoc
class __$SoundSettingsCopyWithImpl<$Res>
    implements _$SoundSettingsCopyWith<$Res> {
  __$SoundSettingsCopyWithImpl(this._self, this._then);

  final _SoundSettings _self;
  final $Res Function(_SoundSettings) _then;

/// Create a copy of SoundSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? map = freezed,}) {
  return _then(_SoundSettings(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as IntensitySoundMode,map: freezed == map ? _self._map : map // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

// dart format on
