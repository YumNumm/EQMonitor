// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettings {

 bool get tsunamiEnabled; bool get trainingEnabled;
/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsCopyWith<NotificationSettings> get copyWith => _$NotificationSettingsCopyWithImpl<NotificationSettings>(this as NotificationSettings, _$identity);

  /// Serializes this NotificationSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettings&&(identical(other.tsunamiEnabled, tsunamiEnabled) || other.tsunamiEnabled == tsunamiEnabled)&&(identical(other.trainingEnabled, trainingEnabled) || other.trainingEnabled == trainingEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunamiEnabled,trainingEnabled);

@override
String toString() {
  return 'NotificationSettings(tsunamiEnabled: $tsunamiEnabled, trainingEnabled: $trainingEnabled)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsCopyWith<$Res>  {
  factory $NotificationSettingsCopyWith(NotificationSettings value, $Res Function(NotificationSettings) _then) = _$NotificationSettingsCopyWithImpl;
@useResult
$Res call({
 bool tsunamiEnabled, bool trainingEnabled
});




}
/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._self, this._then);

  final NotificationSettings _self;
  final $Res Function(NotificationSettings) _then;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tsunamiEnabled = null,Object? trainingEnabled = null,}) {
  return _then(_self.copyWith(
tsunamiEnabled: null == tsunamiEnabled ? _self.tsunamiEnabled : tsunamiEnabled // ignore: cast_nullable_to_non_nullable
as bool,trainingEnabled: null == trainingEnabled ? _self.trainingEnabled : trainingEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSettings].
extension NotificationSettingsPatterns on NotificationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSettings value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool tsunamiEnabled,  bool trainingEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
return $default(_that.tsunamiEnabled,_that.trainingEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool tsunamiEnabled,  bool trainingEnabled)  $default,) {final _that = this;
switch (_that) {
case _NotificationSettings():
return $default(_that.tsunamiEnabled,_that.trainingEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool tsunamiEnabled,  bool trainingEnabled)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
return $default(_that.tsunamiEnabled,_that.trainingEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSettings implements NotificationSettings {
  const _NotificationSettings({required this.tsunamiEnabled, required this.trainingEnabled});
  factory _NotificationSettings.fromJson(Map<String, dynamic> json) => _$NotificationSettingsFromJson(json);

@override final  bool tsunamiEnabled;
@override final  bool trainingEnabled;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsCopyWith<_NotificationSettings> get copyWith => __$NotificationSettingsCopyWithImpl<_NotificationSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettings&&(identical(other.tsunamiEnabled, tsunamiEnabled) || other.tsunamiEnabled == tsunamiEnabled)&&(identical(other.trainingEnabled, trainingEnabled) || other.trainingEnabled == trainingEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunamiEnabled,trainingEnabled);

@override
String toString() {
  return 'NotificationSettings(tsunamiEnabled: $tsunamiEnabled, trainingEnabled: $trainingEnabled)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsCopyWith<$Res> implements $NotificationSettingsCopyWith<$Res> {
  factory _$NotificationSettingsCopyWith(_NotificationSettings value, $Res Function(_NotificationSettings) _then) = __$NotificationSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool tsunamiEnabled, bool trainingEnabled
});




}
/// @nodoc
class __$NotificationSettingsCopyWithImpl<$Res>
    implements _$NotificationSettingsCopyWith<$Res> {
  __$NotificationSettingsCopyWithImpl(this._self, this._then);

  final _NotificationSettings _self;
  final $Res Function(_NotificationSettings) _then;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tsunamiEnabled = null,Object? trainingEnabled = null,}) {
  return _then(_NotificationSettings(
tsunamiEnabled: null == tsunamiEnabled ? _self.tsunamiEnabled : tsunamiEnabled // ignore: cast_nullable_to_non_nullable
as bool,trainingEnabled: null == trainingEnabled ? _self.trainingEnabled : trainingEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NotificationSettingsRequest {

 bool? get tsunamiEnabled; bool? get trainingEnabled;
/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsRequestCopyWith<NotificationSettingsRequest> get copyWith => _$NotificationSettingsRequestCopyWithImpl<NotificationSettingsRequest>(this as NotificationSettingsRequest, _$identity);

  /// Serializes this NotificationSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsRequest&&(identical(other.tsunamiEnabled, tsunamiEnabled) || other.tsunamiEnabled == tsunamiEnabled)&&(identical(other.trainingEnabled, trainingEnabled) || other.trainingEnabled == trainingEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunamiEnabled,trainingEnabled);

@override
String toString() {
  return 'NotificationSettingsRequest(tsunamiEnabled: $tsunamiEnabled, trainingEnabled: $trainingEnabled)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsRequestCopyWith<$Res>  {
  factory $NotificationSettingsRequestCopyWith(NotificationSettingsRequest value, $Res Function(NotificationSettingsRequest) _then) = _$NotificationSettingsRequestCopyWithImpl;
@useResult
$Res call({
 bool? tsunamiEnabled, bool? trainingEnabled
});




}
/// @nodoc
class _$NotificationSettingsRequestCopyWithImpl<$Res>
    implements $NotificationSettingsRequestCopyWith<$Res> {
  _$NotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final NotificationSettingsRequest _self;
  final $Res Function(NotificationSettingsRequest) _then;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tsunamiEnabled = freezed,Object? trainingEnabled = freezed,}) {
  return _then(_self.copyWith(
tsunamiEnabled: freezed == tsunamiEnabled ? _self.tsunamiEnabled : tsunamiEnabled // ignore: cast_nullable_to_non_nullable
as bool?,trainingEnabled: freezed == trainingEnabled ? _self.trainingEnabled : trainingEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSettingsRequest].
extension NotificationSettingsRequestPatterns on NotificationSettingsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSettingsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSettingsRequest value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSettingsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? tsunamiEnabled,  bool? trainingEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
return $default(_that.tsunamiEnabled,_that.trainingEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? tsunamiEnabled,  bool? trainingEnabled)  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsRequest():
return $default(_that.tsunamiEnabled,_that.trainingEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? tsunamiEnabled,  bool? trainingEnabled)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
return $default(_that.tsunamiEnabled,_that.trainingEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSettingsRequest implements NotificationSettingsRequest {
  const _NotificationSettingsRequest({this.tsunamiEnabled, this.trainingEnabled});
  factory _NotificationSettingsRequest.fromJson(Map<String, dynamic> json) => _$NotificationSettingsRequestFromJson(json);

@override final  bool? tsunamiEnabled;
@override final  bool? trainingEnabled;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsRequestCopyWith<_NotificationSettingsRequest> get copyWith => __$NotificationSettingsRequestCopyWithImpl<_NotificationSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsRequest&&(identical(other.tsunamiEnabled, tsunamiEnabled) || other.tsunamiEnabled == tsunamiEnabled)&&(identical(other.trainingEnabled, trainingEnabled) || other.trainingEnabled == trainingEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunamiEnabled,trainingEnabled);

@override
String toString() {
  return 'NotificationSettingsRequest(tsunamiEnabled: $tsunamiEnabled, trainingEnabled: $trainingEnabled)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsRequestCopyWith<$Res> implements $NotificationSettingsRequestCopyWith<$Res> {
  factory _$NotificationSettingsRequestCopyWith(_NotificationSettingsRequest value, $Res Function(_NotificationSettingsRequest) _then) = __$NotificationSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
 bool? tsunamiEnabled, bool? trainingEnabled
});




}
/// @nodoc
class __$NotificationSettingsRequestCopyWithImpl<$Res>
    implements _$NotificationSettingsRequestCopyWith<$Res> {
  __$NotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final _NotificationSettingsRequest _self;
  final $Res Function(_NotificationSettingsRequest) _then;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tsunamiEnabled = freezed,Object? trainingEnabled = freezed,}) {
  return _then(_NotificationSettingsRequest(
tsunamiEnabled: freezed == tsunamiEnabled ? _self.tsunamiEnabled : tsunamiEnabled // ignore: cast_nullable_to_non_nullable
as bool?,trainingEnabled: freezed == trainingEnabled ? _self.trainingEnabled : trainingEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$EarthquakeNotificationSettings {

 bool get enabled; SoundSettings get sound; bool get hypocenterUpdateEnabled; bool get estimatedIntensityEnabled;
/// Create a copy of EarthquakeNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeNotificationSettingsCopyWith<EarthquakeNotificationSettings> get copyWith => _$EarthquakeNotificationSettingsCopyWithImpl<EarthquakeNotificationSettings>(this as EarthquakeNotificationSettings, _$identity);

  /// Serializes this EarthquakeNotificationSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeNotificationSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.hypocenterUpdateEnabled, hypocenterUpdateEnabled) || other.hypocenterUpdateEnabled == hypocenterUpdateEnabled)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,sound,hypocenterUpdateEnabled,estimatedIntensityEnabled);

@override
String toString() {
  return 'EarthquakeNotificationSettings(enabled: $enabled, sound: $sound, hypocenterUpdateEnabled: $hypocenterUpdateEnabled, estimatedIntensityEnabled: $estimatedIntensityEnabled)';
}


}

/// @nodoc
abstract mixin class $EarthquakeNotificationSettingsCopyWith<$Res>  {
  factory $EarthquakeNotificationSettingsCopyWith(EarthquakeNotificationSettings value, $Res Function(EarthquakeNotificationSettings) _then) = _$EarthquakeNotificationSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, SoundSettings sound, bool hypocenterUpdateEnabled, bool estimatedIntensityEnabled
});


$SoundSettingsCopyWith<$Res> get sound;

}
/// @nodoc
class _$EarthquakeNotificationSettingsCopyWithImpl<$Res>
    implements $EarthquakeNotificationSettingsCopyWith<$Res> {
  _$EarthquakeNotificationSettingsCopyWithImpl(this._self, this._then);

  final EarthquakeNotificationSettings _self;
  final $Res Function(EarthquakeNotificationSettings) _then;

/// Create a copy of EarthquakeNotificationSettings
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
/// Create a copy of EarthquakeNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<$Res> get sound {
  
  return $SoundSettingsCopyWith<$Res>(_self.sound, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeNotificationSettings].
extension EarthquakeNotificationSettingsPatterns on EarthquakeNotificationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeNotificationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeNotificationSettings value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeNotificationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  SoundSettings sound,  bool hypocenterUpdateEnabled,  bool estimatedIntensityEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  SoundSettings sound,  bool hypocenterUpdateEnabled,  bool estimatedIntensityEnabled)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  SoundSettings sound,  bool hypocenterUpdateEnabled,  bool estimatedIntensityEnabled)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings() when $default != null:
return $default(_that.enabled,_that.sound,_that.hypocenterUpdateEnabled,_that.estimatedIntensityEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeNotificationSettings implements EarthquakeNotificationSettings {
  const _EarthquakeNotificationSettings({required this.enabled, required this.sound, required this.hypocenterUpdateEnabled, required this.estimatedIntensityEnabled});
  factory _EarthquakeNotificationSettings.fromJson(Map<String, dynamic> json) => _$EarthquakeNotificationSettingsFromJson(json);

@override final  bool enabled;
@override final  SoundSettings sound;
@override final  bool hypocenterUpdateEnabled;
@override final  bool estimatedIntensityEnabled;

/// Create a copy of EarthquakeNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeNotificationSettingsCopyWith<_EarthquakeNotificationSettings> get copyWith => __$EarthquakeNotificationSettingsCopyWithImpl<_EarthquakeNotificationSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeNotificationSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeNotificationSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.hypocenterUpdateEnabled, hypocenterUpdateEnabled) || other.hypocenterUpdateEnabled == hypocenterUpdateEnabled)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,sound,hypocenterUpdateEnabled,estimatedIntensityEnabled);

@override
String toString() {
  return 'EarthquakeNotificationSettings(enabled: $enabled, sound: $sound, hypocenterUpdateEnabled: $hypocenterUpdateEnabled, estimatedIntensityEnabled: $estimatedIntensityEnabled)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeNotificationSettingsCopyWith<$Res> implements $EarthquakeNotificationSettingsCopyWith<$Res> {
  factory _$EarthquakeNotificationSettingsCopyWith(_EarthquakeNotificationSettings value, $Res Function(_EarthquakeNotificationSettings) _then) = __$EarthquakeNotificationSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, SoundSettings sound, bool hypocenterUpdateEnabled, bool estimatedIntensityEnabled
});


@override $SoundSettingsCopyWith<$Res> get sound;

}
/// @nodoc
class __$EarthquakeNotificationSettingsCopyWithImpl<$Res>
    implements _$EarthquakeNotificationSettingsCopyWith<$Res> {
  __$EarthquakeNotificationSettingsCopyWithImpl(this._self, this._then);

  final _EarthquakeNotificationSettings _self;
  final $Res Function(_EarthquakeNotificationSettings) _then;

/// Create a copy of EarthquakeNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? sound = null,Object? hypocenterUpdateEnabled = null,Object? estimatedIntensityEnabled = null,}) {
  return _then(_EarthquakeNotificationSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettings,hypocenterUpdateEnabled: null == hypocenterUpdateEnabled ? _self.hypocenterUpdateEnabled : hypocenterUpdateEnabled // ignore: cast_nullable_to_non_nullable
as bool,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EarthquakeNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<$Res> get sound {
  
  return $SoundSettingsCopyWith<$Res>(_self.sound, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}


/// @nodoc
mixin _$EarthquakeNotificationSettingsRequest {

 bool? get enabled; SoundSettings? get sound; bool? get hypocenterUpdateEnabled; bool? get estimatedIntensityEnabled;
/// Create a copy of EarthquakeNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeNotificationSettingsRequestCopyWith<EarthquakeNotificationSettingsRequest> get copyWith => _$EarthquakeNotificationSettingsRequestCopyWithImpl<EarthquakeNotificationSettingsRequest>(this as EarthquakeNotificationSettingsRequest, _$identity);

  /// Serializes this EarthquakeNotificationSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeNotificationSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.hypocenterUpdateEnabled, hypocenterUpdateEnabled) || other.hypocenterUpdateEnabled == hypocenterUpdateEnabled)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,sound,hypocenterUpdateEnabled,estimatedIntensityEnabled);

@override
String toString() {
  return 'EarthquakeNotificationSettingsRequest(enabled: $enabled, sound: $sound, hypocenterUpdateEnabled: $hypocenterUpdateEnabled, estimatedIntensityEnabled: $estimatedIntensityEnabled)';
}


}

/// @nodoc
abstract mixin class $EarthquakeNotificationSettingsRequestCopyWith<$Res>  {
  factory $EarthquakeNotificationSettingsRequestCopyWith(EarthquakeNotificationSettingsRequest value, $Res Function(EarthquakeNotificationSettingsRequest) _then) = _$EarthquakeNotificationSettingsRequestCopyWithImpl;
@useResult
$Res call({
 bool? enabled, SoundSettings? sound, bool? hypocenterUpdateEnabled, bool? estimatedIntensityEnabled
});


$SoundSettingsCopyWith<$Res>? get sound;

}
/// @nodoc
class _$EarthquakeNotificationSettingsRequestCopyWithImpl<$Res>
    implements $EarthquakeNotificationSettingsRequestCopyWith<$Res> {
  _$EarthquakeNotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final EarthquakeNotificationSettingsRequest _self;
  final $Res Function(EarthquakeNotificationSettingsRequest) _then;

/// Create a copy of EarthquakeNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = freezed,Object? sound = freezed,Object? hypocenterUpdateEnabled = freezed,Object? estimatedIntensityEnabled = freezed,}) {
  return _then(_self.copyWith(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,sound: freezed == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettings?,hypocenterUpdateEnabled: freezed == hypocenterUpdateEnabled ? _self.hypocenterUpdateEnabled : hypocenterUpdateEnabled // ignore: cast_nullable_to_non_nullable
as bool?,estimatedIntensityEnabled: freezed == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of EarthquakeNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<$Res>? get sound {
    if (_self.sound == null) {
    return null;
  }

  return $SoundSettingsCopyWith<$Res>(_self.sound!, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeNotificationSettingsRequest].
extension EarthquakeNotificationSettingsRequestPatterns on EarthquakeNotificationSettingsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeNotificationSettingsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeNotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeNotificationSettingsRequest value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeNotificationSettingsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeNotificationSettingsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeNotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? enabled,  SoundSettings? sound,  bool? hypocenterUpdateEnabled,  bool? estimatedIntensityEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeNotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? enabled,  SoundSettings? sound,  bool? hypocenterUpdateEnabled,  bool? estimatedIntensityEnabled)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeNotificationSettingsRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? enabled,  SoundSettings? sound,  bool? hypocenterUpdateEnabled,  bool? estimatedIntensityEnabled)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeNotificationSettingsRequest() when $default != null:
return $default(_that.enabled,_that.sound,_that.hypocenterUpdateEnabled,_that.estimatedIntensityEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeNotificationSettingsRequest implements EarthquakeNotificationSettingsRequest {
  const _EarthquakeNotificationSettingsRequest({this.enabled, this.sound, this.hypocenterUpdateEnabled, this.estimatedIntensityEnabled});
  factory _EarthquakeNotificationSettingsRequest.fromJson(Map<String, dynamic> json) => _$EarthquakeNotificationSettingsRequestFromJson(json);

@override final  bool? enabled;
@override final  SoundSettings? sound;
@override final  bool? hypocenterUpdateEnabled;
@override final  bool? estimatedIntensityEnabled;

/// Create a copy of EarthquakeNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeNotificationSettingsRequestCopyWith<_EarthquakeNotificationSettingsRequest> get copyWith => __$EarthquakeNotificationSettingsRequestCopyWithImpl<_EarthquakeNotificationSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeNotificationSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeNotificationSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.hypocenterUpdateEnabled, hypocenterUpdateEnabled) || other.hypocenterUpdateEnabled == hypocenterUpdateEnabled)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,sound,hypocenterUpdateEnabled,estimatedIntensityEnabled);

@override
String toString() {
  return 'EarthquakeNotificationSettingsRequest(enabled: $enabled, sound: $sound, hypocenterUpdateEnabled: $hypocenterUpdateEnabled, estimatedIntensityEnabled: $estimatedIntensityEnabled)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeNotificationSettingsRequestCopyWith<$Res> implements $EarthquakeNotificationSettingsRequestCopyWith<$Res> {
  factory _$EarthquakeNotificationSettingsRequestCopyWith(_EarthquakeNotificationSettingsRequest value, $Res Function(_EarthquakeNotificationSettingsRequest) _then) = __$EarthquakeNotificationSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
 bool? enabled, SoundSettings? sound, bool? hypocenterUpdateEnabled, bool? estimatedIntensityEnabled
});


@override $SoundSettingsCopyWith<$Res>? get sound;

}
/// @nodoc
class __$EarthquakeNotificationSettingsRequestCopyWithImpl<$Res>
    implements _$EarthquakeNotificationSettingsRequestCopyWith<$Res> {
  __$EarthquakeNotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final _EarthquakeNotificationSettingsRequest _self;
  final $Res Function(_EarthquakeNotificationSettingsRequest) _then;

/// Create a copy of EarthquakeNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = freezed,Object? sound = freezed,Object? hypocenterUpdateEnabled = freezed,Object? estimatedIntensityEnabled = freezed,}) {
  return _then(_EarthquakeNotificationSettingsRequest(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,sound: freezed == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettings?,hypocenterUpdateEnabled: freezed == hypocenterUpdateEnabled ? _self.hypocenterUpdateEnabled : hypocenterUpdateEnabled // ignore: cast_nullable_to_non_nullable
as bool?,estimatedIntensityEnabled: freezed == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of EarthquakeNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<$Res>? get sound {
    if (_self.sound == null) {
    return null;
  }

  return $SoundSettingsCopyWith<$Res>(_self.sound!, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}


/// @nodoc
mixin _$EewNotificationSettings {

 bool get enabled; bool get overrideSilentMode; SoundSettings get sound; bool get startLiveActivity;
/// Create a copy of EewNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewNotificationSettingsCopyWith<EewNotificationSettings> get copyWith => _$EewNotificationSettingsCopyWithImpl<EewNotificationSettings>(this as EewNotificationSettings, _$identity);

  /// Serializes this EewNotificationSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewNotificationSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.overrideSilentMode, overrideSilentMode) || other.overrideSilentMode == overrideSilentMode)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,overrideSilentMode,sound,startLiveActivity);

@override
String toString() {
  return 'EewNotificationSettings(enabled: $enabled, overrideSilentMode: $overrideSilentMode, sound: $sound, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class $EewNotificationSettingsCopyWith<$Res>  {
  factory $EewNotificationSettingsCopyWith(EewNotificationSettings value, $Res Function(EewNotificationSettings) _then) = _$EewNotificationSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool overrideSilentMode, SoundSettings sound, bool startLiveActivity
});


$SoundSettingsCopyWith<$Res> get sound;

}
/// @nodoc
class _$EewNotificationSettingsCopyWithImpl<$Res>
    implements $EewNotificationSettingsCopyWith<$Res> {
  _$EewNotificationSettingsCopyWithImpl(this._self, this._then);

  final EewNotificationSettings _self;
  final $Res Function(EewNotificationSettings) _then;

/// Create a copy of EewNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? overrideSilentMode = null,Object? sound = null,Object? startLiveActivity = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,overrideSilentMode: null == overrideSilentMode ? _self.overrideSilentMode : overrideSilentMode // ignore: cast_nullable_to_non_nullable
as bool,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettings,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EewNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<$Res> get sound {
  
  return $SoundSettingsCopyWith<$Res>(_self.sound, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewNotificationSettings].
extension EewNotificationSettingsPatterns on EewNotificationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewNotificationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewNotificationSettings value)  $default,){
final _that = this;
switch (_that) {
case _EewNotificationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewNotificationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _EewNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  bool overrideSilentMode,  SoundSettings sound,  bool startLiveActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  bool overrideSilentMode,  SoundSettings sound,  bool startLiveActivity)  $default,) {final _that = this;
switch (_that) {
case _EewNotificationSettings():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  bool overrideSilentMode,  SoundSettings sound,  bool startLiveActivity)?  $default,) {final _that = this;
switch (_that) {
case _EewNotificationSettings() when $default != null:
return $default(_that.enabled,_that.overrideSilentMode,_that.sound,_that.startLiveActivity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewNotificationSettings implements EewNotificationSettings {
  const _EewNotificationSettings({required this.enabled, required this.overrideSilentMode, required this.sound, required this.startLiveActivity});
  factory _EewNotificationSettings.fromJson(Map<String, dynamic> json) => _$EewNotificationSettingsFromJson(json);

@override final  bool enabled;
@override final  bool overrideSilentMode;
@override final  SoundSettings sound;
@override final  bool startLiveActivity;

/// Create a copy of EewNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewNotificationSettingsCopyWith<_EewNotificationSettings> get copyWith => __$EewNotificationSettingsCopyWithImpl<_EewNotificationSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewNotificationSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewNotificationSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.overrideSilentMode, overrideSilentMode) || other.overrideSilentMode == overrideSilentMode)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,overrideSilentMode,sound,startLiveActivity);

@override
String toString() {
  return 'EewNotificationSettings(enabled: $enabled, overrideSilentMode: $overrideSilentMode, sound: $sound, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class _$EewNotificationSettingsCopyWith<$Res> implements $EewNotificationSettingsCopyWith<$Res> {
  factory _$EewNotificationSettingsCopyWith(_EewNotificationSettings value, $Res Function(_EewNotificationSettings) _then) = __$EewNotificationSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool overrideSilentMode, SoundSettings sound, bool startLiveActivity
});


@override $SoundSettingsCopyWith<$Res> get sound;

}
/// @nodoc
class __$EewNotificationSettingsCopyWithImpl<$Res>
    implements _$EewNotificationSettingsCopyWith<$Res> {
  __$EewNotificationSettingsCopyWithImpl(this._self, this._then);

  final _EewNotificationSettings _self;
  final $Res Function(_EewNotificationSettings) _then;

/// Create a copy of EewNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? overrideSilentMode = null,Object? sound = null,Object? startLiveActivity = null,}) {
  return _then(_EewNotificationSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,overrideSilentMode: null == overrideSilentMode ? _self.overrideSilentMode : overrideSilentMode // ignore: cast_nullable_to_non_nullable
as bool,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettings,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EewNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<$Res> get sound {
  
  return $SoundSettingsCopyWith<$Res>(_self.sound, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}


/// @nodoc
mixin _$EewNotificationSettingsRequest {

 bool? get enabled; bool? get overrideSilentMode; SoundSettings? get sound; bool? get startLiveActivity;
/// Create a copy of EewNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewNotificationSettingsRequestCopyWith<EewNotificationSettingsRequest> get copyWith => _$EewNotificationSettingsRequestCopyWithImpl<EewNotificationSettingsRequest>(this as EewNotificationSettingsRequest, _$identity);

  /// Serializes this EewNotificationSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewNotificationSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.overrideSilentMode, overrideSilentMode) || other.overrideSilentMode == overrideSilentMode)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,overrideSilentMode,sound,startLiveActivity);

@override
String toString() {
  return 'EewNotificationSettingsRequest(enabled: $enabled, overrideSilentMode: $overrideSilentMode, sound: $sound, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class $EewNotificationSettingsRequestCopyWith<$Res>  {
  factory $EewNotificationSettingsRequestCopyWith(EewNotificationSettingsRequest value, $Res Function(EewNotificationSettingsRequest) _then) = _$EewNotificationSettingsRequestCopyWithImpl;
@useResult
$Res call({
 bool? enabled, bool? overrideSilentMode, SoundSettings? sound, bool? startLiveActivity
});


$SoundSettingsCopyWith<$Res>? get sound;

}
/// @nodoc
class _$EewNotificationSettingsRequestCopyWithImpl<$Res>
    implements $EewNotificationSettingsRequestCopyWith<$Res> {
  _$EewNotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final EewNotificationSettingsRequest _self;
  final $Res Function(EewNotificationSettingsRequest) _then;

/// Create a copy of EewNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = freezed,Object? overrideSilentMode = freezed,Object? sound = freezed,Object? startLiveActivity = freezed,}) {
  return _then(_self.copyWith(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,overrideSilentMode: freezed == overrideSilentMode ? _self.overrideSilentMode : overrideSilentMode // ignore: cast_nullable_to_non_nullable
as bool?,sound: freezed == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettings?,startLiveActivity: freezed == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of EewNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<$Res>? get sound {
    if (_self.sound == null) {
    return null;
  }

  return $SoundSettingsCopyWith<$Res>(_self.sound!, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewNotificationSettingsRequest].
extension EewNotificationSettingsRequestPatterns on EewNotificationSettingsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewNotificationSettingsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewNotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewNotificationSettingsRequest value)  $default,){
final _that = this;
switch (_that) {
case _EewNotificationSettingsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewNotificationSettingsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EewNotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? enabled,  bool? overrideSilentMode,  SoundSettings? sound,  bool? startLiveActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewNotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? enabled,  bool? overrideSilentMode,  SoundSettings? sound,  bool? startLiveActivity)  $default,) {final _that = this;
switch (_that) {
case _EewNotificationSettingsRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? enabled,  bool? overrideSilentMode,  SoundSettings? sound,  bool? startLiveActivity)?  $default,) {final _that = this;
switch (_that) {
case _EewNotificationSettingsRequest() when $default != null:
return $default(_that.enabled,_that.overrideSilentMode,_that.sound,_that.startLiveActivity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewNotificationSettingsRequest implements EewNotificationSettingsRequest {
  const _EewNotificationSettingsRequest({this.enabled, this.overrideSilentMode, this.sound, this.startLiveActivity});
  factory _EewNotificationSettingsRequest.fromJson(Map<String, dynamic> json) => _$EewNotificationSettingsRequestFromJson(json);

@override final  bool? enabled;
@override final  bool? overrideSilentMode;
@override final  SoundSettings? sound;
@override final  bool? startLiveActivity;

/// Create a copy of EewNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewNotificationSettingsRequestCopyWith<_EewNotificationSettingsRequest> get copyWith => __$EewNotificationSettingsRequestCopyWithImpl<_EewNotificationSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewNotificationSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewNotificationSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.overrideSilentMode, overrideSilentMode) || other.overrideSilentMode == overrideSilentMode)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,overrideSilentMode,sound,startLiveActivity);

@override
String toString() {
  return 'EewNotificationSettingsRequest(enabled: $enabled, overrideSilentMode: $overrideSilentMode, sound: $sound, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class _$EewNotificationSettingsRequestCopyWith<$Res> implements $EewNotificationSettingsRequestCopyWith<$Res> {
  factory _$EewNotificationSettingsRequestCopyWith(_EewNotificationSettingsRequest value, $Res Function(_EewNotificationSettingsRequest) _then) = __$EewNotificationSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
 bool? enabled, bool? overrideSilentMode, SoundSettings? sound, bool? startLiveActivity
});


@override $SoundSettingsCopyWith<$Res>? get sound;

}
/// @nodoc
class __$EewNotificationSettingsRequestCopyWithImpl<$Res>
    implements _$EewNotificationSettingsRequestCopyWith<$Res> {
  __$EewNotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final _EewNotificationSettingsRequest _self;
  final $Res Function(_EewNotificationSettingsRequest) _then;

/// Create a copy of EewNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = freezed,Object? overrideSilentMode = freezed,Object? sound = freezed,Object? startLiveActivity = freezed,}) {
  return _then(_EewNotificationSettingsRequest(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,overrideSilentMode: freezed == overrideSilentMode ? _self.overrideSilentMode : overrideSilentMode // ignore: cast_nullable_to_non_nullable
as bool?,sound: freezed == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as SoundSettings?,startLiveActivity: freezed == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of EewNotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SoundSettingsCopyWith<$Res>? get sound {
    if (_self.sound == null) {
    return null;
  }

  return $SoundSettingsCopyWith<$Res>(_self.sound!, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}

// dart format on
