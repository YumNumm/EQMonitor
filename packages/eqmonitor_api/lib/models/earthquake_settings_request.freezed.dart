// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_settings_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeSettingsRequest {

 bool get enabled; SoundSettings get sound;@JsonKey(name: 'hypocenter_update_enabled') bool get hypocenterUpdateEnabled;@JsonKey(name: 'estimated_intensity_enabled') bool get estimatedIntensityEnabled;
/// Create a copy of EarthquakeSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSettingsRequestCopyWith<EarthquakeSettingsRequest> get copyWith => _$EarthquakeSettingsRequestCopyWithImpl<EarthquakeSettingsRequest>(this as EarthquakeSettingsRequest, _$identity);

  /// Serializes this EarthquakeSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.hypocenterUpdateEnabled, hypocenterUpdateEnabled) || other.hypocenterUpdateEnabled == hypocenterUpdateEnabled)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,sound,hypocenterUpdateEnabled,estimatedIntensityEnabled);

@override
String toString() {
  return 'EarthquakeSettingsRequest(enabled: $enabled, sound: $sound, hypocenterUpdateEnabled: $hypocenterUpdateEnabled, estimatedIntensityEnabled: $estimatedIntensityEnabled)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSettingsRequestCopyWith<$Res>  {
  factory $EarthquakeSettingsRequestCopyWith(EarthquakeSettingsRequest value, $Res Function(EarthquakeSettingsRequest) _then) = _$EarthquakeSettingsRequestCopyWithImpl;
@useResult
$Res call({
 bool enabled, SoundSettings sound,@JsonKey(name: 'hypocenter_update_enabled') bool hypocenterUpdateEnabled,@JsonKey(name: 'estimated_intensity_enabled') bool estimatedIntensityEnabled
});


$SoundSettingsCopyWith<$Res> get sound;

}
/// @nodoc
class _$EarthquakeSettingsRequestCopyWithImpl<$Res>
    implements $EarthquakeSettingsRequestCopyWith<$Res> {
  _$EarthquakeSettingsRequestCopyWithImpl(this._self, this._then);

  final EarthquakeSettingsRequest _self;
  final $Res Function(EarthquakeSettingsRequest) _then;

/// Create a copy of EarthquakeSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? sound = null,Object? hypocenterUpdateEnabled = null,Object? estimatedIntensityEnabled = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettings,hypocenterUpdateEnabled: null == hypocenterUpdateEnabled ? _self.hypocenterUpdateEnabled : hypocenterUpdateEnabled // ignore: cast_nullable_to_non_nullable
as bool,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EarthquakeSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<$Res> get sound {
  
  return $SoundSettingsCopyWith<$Res>(_self.sound, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeSettingsRequest].
extension EarthquakeSettingsRequestPatterns on EarthquakeSettingsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeSettingsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeSettingsRequest value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeSettingsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeSettingsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  SoundSettings sound, @JsonKey(name: 'hypocenter_update_enabled')  bool hypocenterUpdateEnabled, @JsonKey(name: 'estimated_intensity_enabled')  bool estimatedIntensityEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeSettingsRequest() when $default != null:
return $default(_that.enabled,_that.sound,_that.hypocenterUpdateEnabled,_that.estimatedIntensityEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  SoundSettings sound, @JsonKey(name: 'hypocenter_update_enabled')  bool hypocenterUpdateEnabled, @JsonKey(name: 'estimated_intensity_enabled')  bool estimatedIntensityEnabled)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSettingsRequest():
return $default(_that.enabled,_that.sound,_that.hypocenterUpdateEnabled,_that.estimatedIntensityEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  SoundSettings sound, @JsonKey(name: 'hypocenter_update_enabled')  bool hypocenterUpdateEnabled, @JsonKey(name: 'estimated_intensity_enabled')  bool estimatedIntensityEnabled)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSettingsRequest() when $default != null:
return $default(_that.enabled,_that.sound,_that.hypocenterUpdateEnabled,_that.estimatedIntensityEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeSettingsRequest implements EarthquakeSettingsRequest {
  const _EarthquakeSettingsRequest({required this.enabled, required this.sound, @JsonKey(name: 'hypocenter_update_enabled') required this.hypocenterUpdateEnabled, @JsonKey(name: 'estimated_intensity_enabled') required this.estimatedIntensityEnabled});
  factory _EarthquakeSettingsRequest.fromJson(Map<String, dynamic> json) => _$EarthquakeSettingsRequestFromJson(json);

@override final  bool enabled;
@override final  SoundSettings sound;
@override@JsonKey(name: 'hypocenter_update_enabled') final  bool hypocenterUpdateEnabled;
@override@JsonKey(name: 'estimated_intensity_enabled') final  bool estimatedIntensityEnabled;

/// Create a copy of EarthquakeSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeSettingsRequestCopyWith<_EarthquakeSettingsRequest> get copyWith => __$EarthquakeSettingsRequestCopyWithImpl<_EarthquakeSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.hypocenterUpdateEnabled, hypocenterUpdateEnabled) || other.hypocenterUpdateEnabled == hypocenterUpdateEnabled)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,sound,hypocenterUpdateEnabled,estimatedIntensityEnabled);

@override
String toString() {
  return 'EarthquakeSettingsRequest(enabled: $enabled, sound: $sound, hypocenterUpdateEnabled: $hypocenterUpdateEnabled, estimatedIntensityEnabled: $estimatedIntensityEnabled)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeSettingsRequestCopyWith<$Res> implements $EarthquakeSettingsRequestCopyWith<$Res> {
  factory _$EarthquakeSettingsRequestCopyWith(_EarthquakeSettingsRequest value, $Res Function(_EarthquakeSettingsRequest) _then) = __$EarthquakeSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, SoundSettings sound,@JsonKey(name: 'hypocenter_update_enabled') bool hypocenterUpdateEnabled,@JsonKey(name: 'estimated_intensity_enabled') bool estimatedIntensityEnabled
});


@override $SoundSettingsCopyWith<$Res> get sound;

}
/// @nodoc
class __$EarthquakeSettingsRequestCopyWithImpl<$Res>
    implements _$EarthquakeSettingsRequestCopyWith<$Res> {
  __$EarthquakeSettingsRequestCopyWithImpl(this._self, this._then);

  final _EarthquakeSettingsRequest _self;
  final $Res Function(_EarthquakeSettingsRequest) _then;

/// Create a copy of EarthquakeSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? sound = null,Object? hypocenterUpdateEnabled = null,Object? estimatedIntensityEnabled = null,}) {
  return _then(_EarthquakeSettingsRequest(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettings,hypocenterUpdateEnabled: null == hypocenterUpdateEnabled ? _self.hypocenterUpdateEnabled : hypocenterUpdateEnabled // ignore: cast_nullable_to_non_nullable
as bool,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EarthquakeSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<$Res> get sound {
  
  return $SoundSettingsCopyWith<$Res>(_self.sound, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}

// dart format on
