// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_global_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EewGlobalSettings {

 bool get enabled; String get defaultSound; InterruptionLevel get defaultInterruptionLevel; bool get startLiveActivity; bool get collapseNotification; bool get warningEnabled;
/// Create a copy of EewGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewGlobalSettingsCopyWith<EewGlobalSettings> get copyWith => _$EewGlobalSettingsCopyWithImpl<EewGlobalSettings>(this as EewGlobalSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewGlobalSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.defaultSound, defaultSound) || other.defaultSound == defaultSound)&&(identical(other.defaultInterruptionLevel, defaultInterruptionLevel) || other.defaultInterruptionLevel == defaultInterruptionLevel)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.collapseNotification, collapseNotification) || other.collapseNotification == collapseNotification)&&(identical(other.warningEnabled, warningEnabled) || other.warningEnabled == warningEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,defaultSound,defaultInterruptionLevel,startLiveActivity,collapseNotification,warningEnabled);

@override
String toString() {
  return 'EewGlobalSettings(enabled: $enabled, defaultSound: $defaultSound, defaultInterruptionLevel: $defaultInterruptionLevel, startLiveActivity: $startLiveActivity, collapseNotification: $collapseNotification, warningEnabled: $warningEnabled)';
}


}

/// @nodoc
abstract mixin class $EewGlobalSettingsCopyWith<$Res>  {
  factory $EewGlobalSettingsCopyWith(EewGlobalSettings value, $Res Function(EewGlobalSettings) _then) = _$EewGlobalSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, String defaultSound, InterruptionLevel defaultInterruptionLevel, bool startLiveActivity, bool collapseNotification, bool warningEnabled
});




}
/// @nodoc
class _$EewGlobalSettingsCopyWithImpl<$Res>
    implements $EewGlobalSettingsCopyWith<$Res> {
  _$EewGlobalSettingsCopyWithImpl(this._self, this._then);

  final EewGlobalSettings _self;
  final $Res Function(EewGlobalSettings) _then;

/// Create a copy of EewGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? defaultSound = null,Object? defaultInterruptionLevel = null,Object? startLiveActivity = null,Object? collapseNotification = null,Object? warningEnabled = null,}) {
  return _then(EewGlobalSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,defaultSound: null == defaultSound ? _self.defaultSound : defaultSound // ignore: cast_nullable_to_non_nullable
as String,defaultInterruptionLevel: null == defaultInterruptionLevel ? _self.defaultInterruptionLevel : defaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,collapseNotification: null == collapseNotification ? _self.collapseNotification : collapseNotification // ignore: cast_nullable_to_non_nullable
as bool,warningEnabled: null == warningEnabled ? _self.warningEnabled : warningEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewGlobalSettings].
extension EewGlobalSettingsPatterns on EewGlobalSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewGlobalSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewGlobalSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewGlobalSettings value)  $default,){
final _that = this;
switch (_that) {
case _EewGlobalSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewGlobalSettings value)?  $default,){
final _that = this;
switch (_that) {
case _EewGlobalSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  String defaultSound,  InterruptionLevel defaultInterruptionLevel,  bool startLiveActivity,  bool collapseNotification,  bool warningEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewGlobalSettings() when $default != null:
return $default(_that.enabled,_that.defaultSound,_that.defaultInterruptionLevel,_that.startLiveActivity,_that.collapseNotification,_that.warningEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  String defaultSound,  InterruptionLevel defaultInterruptionLevel,  bool startLiveActivity,  bool collapseNotification,  bool warningEnabled)  $default,) {final _that = this;
switch (_that) {
case _EewGlobalSettings():
return $default(_that.enabled,_that.defaultSound,_that.defaultInterruptionLevel,_that.startLiveActivity,_that.collapseNotification,_that.warningEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  String defaultSound,  InterruptionLevel defaultInterruptionLevel,  bool startLiveActivity,  bool collapseNotification,  bool warningEnabled)?  $default,) {final _that = this;
switch (_that) {
case _EewGlobalSettings() when $default != null:
return $default(_that.enabled,_that.defaultSound,_that.defaultInterruptionLevel,_that.startLiveActivity,_that.collapseNotification,_that.warningEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _EewGlobalSettings implements EewGlobalSettings {
  const _EewGlobalSettings({required this.enabled, required this.defaultSound, required this.defaultInterruptionLevel, required this.startLiveActivity, required this.collapseNotification, required this.warningEnabled});
  

@override final  bool enabled;
@override final  String defaultSound;
@override final  InterruptionLevel defaultInterruptionLevel;
@override final  bool startLiveActivity;
@override final  bool collapseNotification;
@override final  bool warningEnabled;

/// Create a copy of EewGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewGlobalSettingsCopyWith<_EewGlobalSettings> get copyWith => __$EewGlobalSettingsCopyWithImpl<_EewGlobalSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewGlobalSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.defaultSound, defaultSound) || other.defaultSound == defaultSound)&&(identical(other.defaultInterruptionLevel, defaultInterruptionLevel) || other.defaultInterruptionLevel == defaultInterruptionLevel)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.collapseNotification, collapseNotification) || other.collapseNotification == collapseNotification)&&(identical(other.warningEnabled, warningEnabled) || other.warningEnabled == warningEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,defaultSound,defaultInterruptionLevel,startLiveActivity,collapseNotification,warningEnabled);

@override
String toString() {
  return 'EewGlobalSettings(enabled: $enabled, defaultSound: $defaultSound, defaultInterruptionLevel: $defaultInterruptionLevel, startLiveActivity: $startLiveActivity, collapseNotification: $collapseNotification, warningEnabled: $warningEnabled)';
}


}

/// @nodoc
abstract mixin class _$EewGlobalSettingsCopyWith<$Res> implements $EewGlobalSettingsCopyWith<$Res> {
  factory _$EewGlobalSettingsCopyWith(_EewGlobalSettings value, $Res Function(_EewGlobalSettings) _then) = __$EewGlobalSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, String defaultSound, InterruptionLevel defaultInterruptionLevel, bool startLiveActivity, bool collapseNotification, bool warningEnabled
});




}
/// @nodoc
class __$EewGlobalSettingsCopyWithImpl<$Res>
    implements _$EewGlobalSettingsCopyWith<$Res> {
  __$EewGlobalSettingsCopyWithImpl(this._self, this._then);

  final _EewGlobalSettings _self;
  final $Res Function(_EewGlobalSettings) _then;

/// Create a copy of EewGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? defaultSound = null,Object? defaultInterruptionLevel = null,Object? startLiveActivity = null,Object? collapseNotification = null,Object? warningEnabled = null,}) {
  return _then(_EewGlobalSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,defaultSound: null == defaultSound ? _self.defaultSound : defaultSound // ignore: cast_nullable_to_non_nullable
as String,defaultInterruptionLevel: null == defaultInterruptionLevel ? _self.defaultInterruptionLevel : defaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,collapseNotification: null == collapseNotification ? _self.collapseNotification : collapseNotification // ignore: cast_nullable_to_non_nullable
as bool,warningEnabled: null == warningEnabled ? _self.warningEnabled : warningEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
