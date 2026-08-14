// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeSettingsResponse {

 bool get enabled;@JsonKey(name: 'default_sound') String get defaultSound;@JsonKey(name: 'default_interruption_level') DefaultInterruptionLevel get defaultInterruptionLevel;@JsonKey(name: 'estimated_intensity_enabled') bool get estimatedIntensityEnabled;@JsonKey(name: 'collapse_notification') bool get collapseNotification;
/// Create a copy of EarthquakeSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSettingsResponseCopyWith<EarthquakeSettingsResponse> get copyWith => _$EarthquakeSettingsResponseCopyWithImpl<EarthquakeSettingsResponse>(this as EarthquakeSettingsResponse, _$identity);

  /// Serializes this EarthquakeSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSettingsResponse&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.defaultSound, defaultSound) || other.defaultSound == defaultSound)&&(identical(other.defaultInterruptionLevel, defaultInterruptionLevel) || other.defaultInterruptionLevel == defaultInterruptionLevel)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled)&&(identical(other.collapseNotification, collapseNotification) || other.collapseNotification == collapseNotification));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,defaultSound,defaultInterruptionLevel,estimatedIntensityEnabled,collapseNotification);

@override
String toString() {
  return 'EarthquakeSettingsResponse(enabled: $enabled, defaultSound: $defaultSound, defaultInterruptionLevel: $defaultInterruptionLevel, estimatedIntensityEnabled: $estimatedIntensityEnabled, collapseNotification: $collapseNotification)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSettingsResponseCopyWith<$Res>  {
  factory $EarthquakeSettingsResponseCopyWith(EarthquakeSettingsResponse value, $Res Function(EarthquakeSettingsResponse) _then) = _$EarthquakeSettingsResponseCopyWithImpl;
@useResult
$Res call({
 bool enabled,@JsonKey(name: 'default_sound') String defaultSound,@JsonKey(name: 'default_interruption_level') DefaultInterruptionLevel defaultInterruptionLevel,@JsonKey(name: 'estimated_intensity_enabled') bool estimatedIntensityEnabled,@JsonKey(name: 'collapse_notification') bool collapseNotification
});




}
/// @nodoc
class _$EarthquakeSettingsResponseCopyWithImpl<$Res>
    implements $EarthquakeSettingsResponseCopyWith<$Res> {
  _$EarthquakeSettingsResponseCopyWithImpl(this._self, this._then);

  final EarthquakeSettingsResponse _self;
  final $Res Function(EarthquakeSettingsResponse) _then;

/// Create a copy of EarthquakeSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? defaultSound = null,Object? defaultInterruptionLevel = null,Object? estimatedIntensityEnabled = null,Object? collapseNotification = null,}) {
  return _then(EarthquakeSettingsResponse(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,defaultSound: null == defaultSound ? _self.defaultSound : defaultSound // ignore: cast_nullable_to_non_nullable
as String,defaultInterruptionLevel: null == defaultInterruptionLevel ? _self.defaultInterruptionLevel : defaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as DefaultInterruptionLevel,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,collapseNotification: null == collapseNotification ? _self.collapseNotification : collapseNotification // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeSettingsResponse].
extension EarthquakeSettingsResponsePatterns on EarthquakeSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'default_sound')  String defaultSound, @JsonKey(name: 'default_interruption_level')  DefaultInterruptionLevel defaultInterruptionLevel, @JsonKey(name: 'estimated_intensity_enabled')  bool estimatedIntensityEnabled, @JsonKey(name: 'collapse_notification')  bool collapseNotification)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeSettingsResponse() when $default != null:
return $default(_that.enabled,_that.defaultSound,_that.defaultInterruptionLevel,_that.estimatedIntensityEnabled,_that.collapseNotification);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'default_sound')  String defaultSound, @JsonKey(name: 'default_interruption_level')  DefaultInterruptionLevel defaultInterruptionLevel, @JsonKey(name: 'estimated_intensity_enabled')  bool estimatedIntensityEnabled, @JsonKey(name: 'collapse_notification')  bool collapseNotification)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSettingsResponse():
return $default(_that.enabled,_that.defaultSound,_that.defaultInterruptionLevel,_that.estimatedIntensityEnabled,_that.collapseNotification);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled, @JsonKey(name: 'default_sound')  String defaultSound, @JsonKey(name: 'default_interruption_level')  DefaultInterruptionLevel defaultInterruptionLevel, @JsonKey(name: 'estimated_intensity_enabled')  bool estimatedIntensityEnabled, @JsonKey(name: 'collapse_notification')  bool collapseNotification)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSettingsResponse() when $default != null:
return $default(_that.enabled,_that.defaultSound,_that.defaultInterruptionLevel,_that.estimatedIntensityEnabled,_that.collapseNotification);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeSettingsResponse implements EarthquakeSettingsResponse {
  const _EarthquakeSettingsResponse({required this.enabled, @JsonKey(name: 'default_sound') required this.defaultSound, @JsonKey(name: 'default_interruption_level') required this.defaultInterruptionLevel, @JsonKey(name: 'estimated_intensity_enabled') required this.estimatedIntensityEnabled, @JsonKey(name: 'collapse_notification') required this.collapseNotification});
  factory _EarthquakeSettingsResponse.fromJson(Map<String, dynamic> json) => _$EarthquakeSettingsResponseFromJson(json);

@override final  bool enabled;
@override@JsonKey(name: 'default_sound') final  String defaultSound;
@override@JsonKey(name: 'default_interruption_level') final  DefaultInterruptionLevel defaultInterruptionLevel;
@override@JsonKey(name: 'estimated_intensity_enabled') final  bool estimatedIntensityEnabled;
@override@JsonKey(name: 'collapse_notification') final  bool collapseNotification;

/// Create a copy of EarthquakeSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeSettingsResponseCopyWith<_EarthquakeSettingsResponse> get copyWith => __$EarthquakeSettingsResponseCopyWithImpl<_EarthquakeSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeSettingsResponse&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.defaultSound, defaultSound) || other.defaultSound == defaultSound)&&(identical(other.defaultInterruptionLevel, defaultInterruptionLevel) || other.defaultInterruptionLevel == defaultInterruptionLevel)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled)&&(identical(other.collapseNotification, collapseNotification) || other.collapseNotification == collapseNotification));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,defaultSound,defaultInterruptionLevel,estimatedIntensityEnabled,collapseNotification);

@override
String toString() {
  return 'EarthquakeSettingsResponse(enabled: $enabled, defaultSound: $defaultSound, defaultInterruptionLevel: $defaultInterruptionLevel, estimatedIntensityEnabled: $estimatedIntensityEnabled, collapseNotification: $collapseNotification)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeSettingsResponseCopyWith<$Res> implements $EarthquakeSettingsResponseCopyWith<$Res> {
  factory _$EarthquakeSettingsResponseCopyWith(_EarthquakeSettingsResponse value, $Res Function(_EarthquakeSettingsResponse) _then) = __$EarthquakeSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool enabled,@JsonKey(name: 'default_sound') String defaultSound,@JsonKey(name: 'default_interruption_level') DefaultInterruptionLevel defaultInterruptionLevel,@JsonKey(name: 'estimated_intensity_enabled') bool estimatedIntensityEnabled,@JsonKey(name: 'collapse_notification') bool collapseNotification
});




}
/// @nodoc
class __$EarthquakeSettingsResponseCopyWithImpl<$Res>
    implements _$EarthquakeSettingsResponseCopyWith<$Res> {
  __$EarthquakeSettingsResponseCopyWithImpl(this._self, this._then);

  final _EarthquakeSettingsResponse _self;
  final $Res Function(_EarthquakeSettingsResponse) _then;

/// Create a copy of EarthquakeSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? defaultSound = null,Object? defaultInterruptionLevel = null,Object? estimatedIntensityEnabled = null,Object? collapseNotification = null,}) {
  return _then(_EarthquakeSettingsResponse(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,defaultSound: null == defaultSound ? _self.defaultSound : defaultSound // ignore: cast_nullable_to_non_nullable
as String,defaultInterruptionLevel: null == defaultInterruptionLevel ? _self.defaultInterruptionLevel : defaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as DefaultInterruptionLevel,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,collapseNotification: null == collapseNotification ? _self.collapseNotification : collapseNotification // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
