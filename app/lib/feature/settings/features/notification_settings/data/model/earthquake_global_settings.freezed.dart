// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_global_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeGlobalSettings {

 bool get enabled; String get defaultSound; InterruptionLevel get defaultInterruptionLevel; bool get estimatedIntensityEnabled; bool get collapseNotification;
/// Create a copy of EarthquakeGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeGlobalSettingsCopyWith<EarthquakeGlobalSettings> get copyWith => _$EarthquakeGlobalSettingsCopyWithImpl<EarthquakeGlobalSettings>(this as EarthquakeGlobalSettings, _$identity);

  /// Serializes this EarthquakeGlobalSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeGlobalSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.defaultSound, defaultSound) || other.defaultSound == defaultSound)&&(identical(other.defaultInterruptionLevel, defaultInterruptionLevel) || other.defaultInterruptionLevel == defaultInterruptionLevel)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled)&&(identical(other.collapseNotification, collapseNotification) || other.collapseNotification == collapseNotification));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,defaultSound,defaultInterruptionLevel,estimatedIntensityEnabled,collapseNotification);

@override
String toString() {
  return 'EarthquakeGlobalSettings(enabled: $enabled, defaultSound: $defaultSound, defaultInterruptionLevel: $defaultInterruptionLevel, estimatedIntensityEnabled: $estimatedIntensityEnabled, collapseNotification: $collapseNotification)';
}


}

/// @nodoc
abstract mixin class $EarthquakeGlobalSettingsCopyWith<$Res>  {
  factory $EarthquakeGlobalSettingsCopyWith(EarthquakeGlobalSettings value, $Res Function(EarthquakeGlobalSettings) _then) = _$EarthquakeGlobalSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, String defaultSound, InterruptionLevel defaultInterruptionLevel, bool estimatedIntensityEnabled, bool collapseNotification
});




}
/// @nodoc
class _$EarthquakeGlobalSettingsCopyWithImpl<$Res>
    implements $EarthquakeGlobalSettingsCopyWith<$Res> {
  _$EarthquakeGlobalSettingsCopyWithImpl(this._self, this._then);

  final EarthquakeGlobalSettings _self;
  final $Res Function(EarthquakeGlobalSettings) _then;

/// Create a copy of EarthquakeGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? defaultSound = null,Object? defaultInterruptionLevel = null,Object? estimatedIntensityEnabled = null,Object? collapseNotification = null,}) {
  return _then(EarthquakeGlobalSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,defaultSound: null == defaultSound ? _self.defaultSound : defaultSound // ignore: cast_nullable_to_non_nullable
as String,defaultInterruptionLevel: null == defaultInterruptionLevel ? _self.defaultInterruptionLevel : defaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,collapseNotification: null == collapseNotification ? _self.collapseNotification : collapseNotification // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeGlobalSettings].
extension EarthquakeGlobalSettingsPatterns on EarthquakeGlobalSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeGlobalSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeGlobalSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeGlobalSettings value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeGlobalSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeGlobalSettings value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeGlobalSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  String defaultSound,  InterruptionLevel defaultInterruptionLevel,  bool estimatedIntensityEnabled,  bool collapseNotification)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeGlobalSettings() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  String defaultSound,  InterruptionLevel defaultInterruptionLevel,  bool estimatedIntensityEnabled,  bool collapseNotification)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeGlobalSettings():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  String defaultSound,  InterruptionLevel defaultInterruptionLevel,  bool estimatedIntensityEnabled,  bool collapseNotification)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeGlobalSettings() when $default != null:
return $default(_that.enabled,_that.defaultSound,_that.defaultInterruptionLevel,_that.estimatedIntensityEnabled,_that.collapseNotification);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeGlobalSettings implements EarthquakeGlobalSettings {
  const _EarthquakeGlobalSettings({required this.enabled, required this.defaultSound, required this.defaultInterruptionLevel, required this.estimatedIntensityEnabled, required this.collapseNotification});
  factory _EarthquakeGlobalSettings.fromJson(Map<String, dynamic> json) => _$EarthquakeGlobalSettingsFromJson(json);

@override final  bool enabled;
@override final  String defaultSound;
@override final  InterruptionLevel defaultInterruptionLevel;
@override final  bool estimatedIntensityEnabled;
@override final  bool collapseNotification;

/// Create a copy of EarthquakeGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeGlobalSettingsCopyWith<_EarthquakeGlobalSettings> get copyWith => __$EarthquakeGlobalSettingsCopyWithImpl<_EarthquakeGlobalSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeGlobalSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeGlobalSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.defaultSound, defaultSound) || other.defaultSound == defaultSound)&&(identical(other.defaultInterruptionLevel, defaultInterruptionLevel) || other.defaultInterruptionLevel == defaultInterruptionLevel)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled)&&(identical(other.collapseNotification, collapseNotification) || other.collapseNotification == collapseNotification));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,defaultSound,defaultInterruptionLevel,estimatedIntensityEnabled,collapseNotification);

@override
String toString() {
  return 'EarthquakeGlobalSettings(enabled: $enabled, defaultSound: $defaultSound, defaultInterruptionLevel: $defaultInterruptionLevel, estimatedIntensityEnabled: $estimatedIntensityEnabled, collapseNotification: $collapseNotification)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeGlobalSettingsCopyWith<$Res> implements $EarthquakeGlobalSettingsCopyWith<$Res> {
  factory _$EarthquakeGlobalSettingsCopyWith(_EarthquakeGlobalSettings value, $Res Function(_EarthquakeGlobalSettings) _then) = __$EarthquakeGlobalSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, String defaultSound, InterruptionLevel defaultInterruptionLevel, bool estimatedIntensityEnabled, bool collapseNotification
});




}
/// @nodoc
class __$EarthquakeGlobalSettingsCopyWithImpl<$Res>
    implements _$EarthquakeGlobalSettingsCopyWith<$Res> {
  __$EarthquakeGlobalSettingsCopyWithImpl(this._self, this._then);

  final _EarthquakeGlobalSettings _self;
  final $Res Function(_EarthquakeGlobalSettings) _then;

/// Create a copy of EarthquakeGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? defaultSound = null,Object? defaultInterruptionLevel = null,Object? estimatedIntensityEnabled = null,Object? collapseNotification = null,}) {
  return _then(_EarthquakeGlobalSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,defaultSound: null == defaultSound ? _self.defaultSound : defaultSound // ignore: cast_nullable_to_non_nullable
as String,defaultInterruptionLevel: null == defaultInterruptionLevel ? _self.defaultInterruptionLevel : defaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,collapseNotification: null == collapseNotification ? _self.collapseNotification : collapseNotification // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
