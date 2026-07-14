// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeneralNotificationSettings {

 bool get notificationEnabled; bool get tsunamiEnabled; bool get trainingEnabled; bool get nankaiExtraordinaryEnabled; bool get nankaiRegularEnabled; bool get vyse60Enabled; bool get earthquakeNoticeEnabled;
/// Create a copy of GeneralNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneralNotificationSettingsCopyWith<GeneralNotificationSettings> get copyWith => _$GeneralNotificationSettingsCopyWithImpl<GeneralNotificationSettings>(this as GeneralNotificationSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneralNotificationSettings&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.tsunamiEnabled, tsunamiEnabled) || other.tsunamiEnabled == tsunamiEnabled)&&(identical(other.trainingEnabled, trainingEnabled) || other.trainingEnabled == trainingEnabled)&&(identical(other.nankaiExtraordinaryEnabled, nankaiExtraordinaryEnabled) || other.nankaiExtraordinaryEnabled == nankaiExtraordinaryEnabled)&&(identical(other.nankaiRegularEnabled, nankaiRegularEnabled) || other.nankaiRegularEnabled == nankaiRegularEnabled)&&(identical(other.vyse60Enabled, vyse60Enabled) || other.vyse60Enabled == vyse60Enabled)&&(identical(other.earthquakeNoticeEnabled, earthquakeNoticeEnabled) || other.earthquakeNoticeEnabled == earthquakeNoticeEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,notificationEnabled,tsunamiEnabled,trainingEnabled,nankaiExtraordinaryEnabled,nankaiRegularEnabled,vyse60Enabled,earthquakeNoticeEnabled);

@override
String toString() {
  return 'GeneralNotificationSettings(notificationEnabled: $notificationEnabled, tsunamiEnabled: $tsunamiEnabled, trainingEnabled: $trainingEnabled, nankaiExtraordinaryEnabled: $nankaiExtraordinaryEnabled, nankaiRegularEnabled: $nankaiRegularEnabled, vyse60Enabled: $vyse60Enabled, earthquakeNoticeEnabled: $earthquakeNoticeEnabled)';
}


}

/// @nodoc
abstract mixin class $GeneralNotificationSettingsCopyWith<$Res>  {
  factory $GeneralNotificationSettingsCopyWith(GeneralNotificationSettings value, $Res Function(GeneralNotificationSettings) _then) = _$GeneralNotificationSettingsCopyWithImpl;
@useResult
$Res call({
 bool notificationEnabled, bool tsunamiEnabled, bool trainingEnabled, bool nankaiExtraordinaryEnabled, bool nankaiRegularEnabled, bool vyse60Enabled, bool earthquakeNoticeEnabled
});




}
/// @nodoc
class _$GeneralNotificationSettingsCopyWithImpl<$Res>
    implements $GeneralNotificationSettingsCopyWith<$Res> {
  _$GeneralNotificationSettingsCopyWithImpl(this._self, this._then);

  final GeneralNotificationSettings _self;
  final $Res Function(GeneralNotificationSettings) _then;

/// Create a copy of GeneralNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationEnabled = null,Object? tsunamiEnabled = null,Object? trainingEnabled = null,Object? nankaiExtraordinaryEnabled = null,Object? nankaiRegularEnabled = null,Object? vyse60Enabled = null,Object? earthquakeNoticeEnabled = null,}) {
  return _then(_self.copyWith(
notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,tsunamiEnabled: null == tsunamiEnabled ? _self.tsunamiEnabled : tsunamiEnabled // ignore: cast_nullable_to_non_nullable
as bool,trainingEnabled: null == trainingEnabled ? _self.trainingEnabled : trainingEnabled // ignore: cast_nullable_to_non_nullable
as bool,nankaiExtraordinaryEnabled: null == nankaiExtraordinaryEnabled ? _self.nankaiExtraordinaryEnabled : nankaiExtraordinaryEnabled // ignore: cast_nullable_to_non_nullable
as bool,nankaiRegularEnabled: null == nankaiRegularEnabled ? _self.nankaiRegularEnabled : nankaiRegularEnabled // ignore: cast_nullable_to_non_nullable
as bool,vyse60Enabled: null == vyse60Enabled ? _self.vyse60Enabled : vyse60Enabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeNoticeEnabled: null == earthquakeNoticeEnabled ? _self.earthquakeNoticeEnabled : earthquakeNoticeEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GeneralNotificationSettings].
extension GeneralNotificationSettingsPatterns on GeneralNotificationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneralNotificationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneralNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneralNotificationSettings value)  $default,){
final _that = this;
switch (_that) {
case _GeneralNotificationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneralNotificationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _GeneralNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool notificationEnabled,  bool tsunamiEnabled,  bool trainingEnabled,  bool nankaiExtraordinaryEnabled,  bool nankaiRegularEnabled,  bool vyse60Enabled,  bool earthquakeNoticeEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneralNotificationSettings() when $default != null:
return $default(_that.notificationEnabled,_that.tsunamiEnabled,_that.trainingEnabled,_that.nankaiExtraordinaryEnabled,_that.nankaiRegularEnabled,_that.vyse60Enabled,_that.earthquakeNoticeEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool notificationEnabled,  bool tsunamiEnabled,  bool trainingEnabled,  bool nankaiExtraordinaryEnabled,  bool nankaiRegularEnabled,  bool vyse60Enabled,  bool earthquakeNoticeEnabled)  $default,) {final _that = this;
switch (_that) {
case _GeneralNotificationSettings():
return $default(_that.notificationEnabled,_that.tsunamiEnabled,_that.trainingEnabled,_that.nankaiExtraordinaryEnabled,_that.nankaiRegularEnabled,_that.vyse60Enabled,_that.earthquakeNoticeEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool notificationEnabled,  bool tsunamiEnabled,  bool trainingEnabled,  bool nankaiExtraordinaryEnabled,  bool nankaiRegularEnabled,  bool vyse60Enabled,  bool earthquakeNoticeEnabled)?  $default,) {final _that = this;
switch (_that) {
case _GeneralNotificationSettings() when $default != null:
return $default(_that.notificationEnabled,_that.tsunamiEnabled,_that.trainingEnabled,_that.nankaiExtraordinaryEnabled,_that.nankaiRegularEnabled,_that.vyse60Enabled,_that.earthquakeNoticeEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _GeneralNotificationSettings implements GeneralNotificationSettings {
  const _GeneralNotificationSettings({required this.notificationEnabled, required this.tsunamiEnabled, required this.trainingEnabled, required this.nankaiExtraordinaryEnabled, required this.nankaiRegularEnabled, required this.vyse60Enabled, required this.earthquakeNoticeEnabled});
  

@override final  bool notificationEnabled;
@override final  bool tsunamiEnabled;
@override final  bool trainingEnabled;
@override final  bool nankaiExtraordinaryEnabled;
@override final  bool nankaiRegularEnabled;
@override final  bool vyse60Enabled;
@override final  bool earthquakeNoticeEnabled;

/// Create a copy of GeneralNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneralNotificationSettingsCopyWith<_GeneralNotificationSettings> get copyWith => __$GeneralNotificationSettingsCopyWithImpl<_GeneralNotificationSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneralNotificationSettings&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.tsunamiEnabled, tsunamiEnabled) || other.tsunamiEnabled == tsunamiEnabled)&&(identical(other.trainingEnabled, trainingEnabled) || other.trainingEnabled == trainingEnabled)&&(identical(other.nankaiExtraordinaryEnabled, nankaiExtraordinaryEnabled) || other.nankaiExtraordinaryEnabled == nankaiExtraordinaryEnabled)&&(identical(other.nankaiRegularEnabled, nankaiRegularEnabled) || other.nankaiRegularEnabled == nankaiRegularEnabled)&&(identical(other.vyse60Enabled, vyse60Enabled) || other.vyse60Enabled == vyse60Enabled)&&(identical(other.earthquakeNoticeEnabled, earthquakeNoticeEnabled) || other.earthquakeNoticeEnabled == earthquakeNoticeEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,notificationEnabled,tsunamiEnabled,trainingEnabled,nankaiExtraordinaryEnabled,nankaiRegularEnabled,vyse60Enabled,earthquakeNoticeEnabled);

@override
String toString() {
  return 'GeneralNotificationSettings(notificationEnabled: $notificationEnabled, tsunamiEnabled: $tsunamiEnabled, trainingEnabled: $trainingEnabled, nankaiExtraordinaryEnabled: $nankaiExtraordinaryEnabled, nankaiRegularEnabled: $nankaiRegularEnabled, vyse60Enabled: $vyse60Enabled, earthquakeNoticeEnabled: $earthquakeNoticeEnabled)';
}


}

/// @nodoc
abstract mixin class _$GeneralNotificationSettingsCopyWith<$Res> implements $GeneralNotificationSettingsCopyWith<$Res> {
  factory _$GeneralNotificationSettingsCopyWith(_GeneralNotificationSettings value, $Res Function(_GeneralNotificationSettings) _then) = __$GeneralNotificationSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool notificationEnabled, bool tsunamiEnabled, bool trainingEnabled, bool nankaiExtraordinaryEnabled, bool nankaiRegularEnabled, bool vyse60Enabled, bool earthquakeNoticeEnabled
});




}
/// @nodoc
class __$GeneralNotificationSettingsCopyWithImpl<$Res>
    implements _$GeneralNotificationSettingsCopyWith<$Res> {
  __$GeneralNotificationSettingsCopyWithImpl(this._self, this._then);

  final _GeneralNotificationSettings _self;
  final $Res Function(_GeneralNotificationSettings) _then;

/// Create a copy of GeneralNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationEnabled = null,Object? tsunamiEnabled = null,Object? trainingEnabled = null,Object? nankaiExtraordinaryEnabled = null,Object? nankaiRegularEnabled = null,Object? vyse60Enabled = null,Object? earthquakeNoticeEnabled = null,}) {
  return _then(_GeneralNotificationSettings(
notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,tsunamiEnabled: null == tsunamiEnabled ? _self.tsunamiEnabled : tsunamiEnabled // ignore: cast_nullable_to_non_nullable
as bool,trainingEnabled: null == trainingEnabled ? _self.trainingEnabled : trainingEnabled // ignore: cast_nullable_to_non_nullable
as bool,nankaiExtraordinaryEnabled: null == nankaiExtraordinaryEnabled ? _self.nankaiExtraordinaryEnabled : nankaiExtraordinaryEnabled // ignore: cast_nullable_to_non_nullable
as bool,nankaiRegularEnabled: null == nankaiRegularEnabled ? _self.nankaiRegularEnabled : nankaiRegularEnabled // ignore: cast_nullable_to_non_nullable
as bool,vyse60Enabled: null == vyse60Enabled ? _self.vyse60Enabled : vyse60Enabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeNoticeEnabled: null == earthquakeNoticeEnabled ? _self.earthquakeNoticeEnabled : earthquakeNoticeEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
