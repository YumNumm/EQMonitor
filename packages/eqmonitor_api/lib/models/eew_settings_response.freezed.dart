// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewSettingsResponse {

 bool get enabled;@JsonKey(name: 'override_silent_mode') bool get overrideSilentMode; SoundSettingsResponse get sound;@JsonKey(name: 'start_live_activity') bool get startLiveActivity;
/// Create a copy of EewSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewSettingsResponseCopyWith<EewSettingsResponse> get copyWith => _$EewSettingsResponseCopyWithImpl<EewSettingsResponse>(this as EewSettingsResponse, _$identity);

  /// Serializes this EewSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewSettingsResponse&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.overrideSilentMode, overrideSilentMode) || other.overrideSilentMode == overrideSilentMode)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,overrideSilentMode,sound,startLiveActivity);

@override
String toString() {
  return 'EewSettingsResponse(enabled: $enabled, overrideSilentMode: $overrideSilentMode, sound: $sound, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class $EewSettingsResponseCopyWith<$Res>  {
  factory $EewSettingsResponseCopyWith(EewSettingsResponse value, $Res Function(EewSettingsResponse) _then) = _$EewSettingsResponseCopyWithImpl;
@useResult
$Res call({
 bool enabled,@JsonKey(name: 'override_silent_mode') bool overrideSilentMode, SoundSettingsResponse sound,@JsonKey(name: 'start_live_activity') bool startLiveActivity
});


$SoundSettingsResponseCopyWith<$Res> get sound;

}
/// @nodoc
class _$EewSettingsResponseCopyWithImpl<$Res>
    implements $EewSettingsResponseCopyWith<$Res> {
  _$EewSettingsResponseCopyWithImpl(this._self, this._then);

  final EewSettingsResponse _self;
  final $Res Function(EewSettingsResponse) _then;

/// Create a copy of EewSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? overrideSilentMode = null,Object? sound = null,Object? startLiveActivity = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,overrideSilentMode: null == overrideSilentMode ? _self.overrideSilentMode : overrideSilentMode // ignore: cast_nullable_to_non_nullable
as bool,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettingsResponse,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EewSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsResponseCopyWith<$Res> get sound {
  
  return $SoundSettingsResponseCopyWith<$Res>(_self.sound, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewSettingsResponse].
extension EewSettingsResponsePatterns on EewSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _EewSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EewSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'override_silent_mode')  bool overrideSilentMode,  SoundSettingsResponse sound, @JsonKey(name: 'start_live_activity')  bool startLiveActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewSettingsResponse() when $default != null:
return $default(_that.enabled,_that.overrideSilentMode,_that.sound,_that.startLiveActivity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'override_silent_mode')  bool overrideSilentMode,  SoundSettingsResponse sound, @JsonKey(name: 'start_live_activity')  bool startLiveActivity)  $default,) {final _that = this;
switch (_that) {
case _EewSettingsResponse():
return $default(_that.enabled,_that.overrideSilentMode,_that.sound,_that.startLiveActivity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled, @JsonKey(name: 'override_silent_mode')  bool overrideSilentMode,  SoundSettingsResponse sound, @JsonKey(name: 'start_live_activity')  bool startLiveActivity)?  $default,) {final _that = this;
switch (_that) {
case _EewSettingsResponse() when $default != null:
return $default(_that.enabled,_that.overrideSilentMode,_that.sound,_that.startLiveActivity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewSettingsResponse implements EewSettingsResponse {
  const _EewSettingsResponse({required this.enabled, @JsonKey(name: 'override_silent_mode') required this.overrideSilentMode, required this.sound, @JsonKey(name: 'start_live_activity') required this.startLiveActivity});
  factory _EewSettingsResponse.fromJson(Map<String, dynamic> json) => _$EewSettingsResponseFromJson(json);

@override final  bool enabled;
@override@JsonKey(name: 'override_silent_mode') final  bool overrideSilentMode;
@override final  SoundSettingsResponse sound;
@override@JsonKey(name: 'start_live_activity') final  bool startLiveActivity;

/// Create a copy of EewSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewSettingsResponseCopyWith<_EewSettingsResponse> get copyWith => __$EewSettingsResponseCopyWithImpl<_EewSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewSettingsResponse&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.overrideSilentMode, overrideSilentMode) || other.overrideSilentMode == overrideSilentMode)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,overrideSilentMode,sound,startLiveActivity);

@override
String toString() {
  return 'EewSettingsResponse(enabled: $enabled, overrideSilentMode: $overrideSilentMode, sound: $sound, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class _$EewSettingsResponseCopyWith<$Res> implements $EewSettingsResponseCopyWith<$Res> {
  factory _$EewSettingsResponseCopyWith(_EewSettingsResponse value, $Res Function(_EewSettingsResponse) _then) = __$EewSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool enabled,@JsonKey(name: 'override_silent_mode') bool overrideSilentMode, SoundSettingsResponse sound,@JsonKey(name: 'start_live_activity') bool startLiveActivity
});


@override $SoundSettingsResponseCopyWith<$Res> get sound;

}
/// @nodoc
class __$EewSettingsResponseCopyWithImpl<$Res>
    implements _$EewSettingsResponseCopyWith<$Res> {
  __$EewSettingsResponseCopyWithImpl(this._self, this._then);

  final _EewSettingsResponse _self;
  final $Res Function(_EewSettingsResponse) _then;

/// Create a copy of EewSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? overrideSilentMode = null,Object? sound = null,Object? startLiveActivity = null,}) {
  return _then(_EewSettingsResponse(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,overrideSilentMode: null == overrideSilentMode ? _self.overrideSilentMode : overrideSilentMode // ignore: cast_nullable_to_non_nullable
as bool,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettingsResponse,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EewSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsResponseCopyWith<$Res> get sound {
  
  return $SoundSettingsResponseCopyWith<$Res>(_self.sound, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}

// dart format on
