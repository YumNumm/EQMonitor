// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_settings_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewSettingsRequest {

@JsonKey(includeIfNull: false) bool? get enabled;@JsonKey(includeIfNull: false, name: 'default_sound') String? get defaultSound;@JsonKey(includeIfNull: false, name: 'default_interruption_level') DefaultInterruptionLevel? get defaultInterruptionLevel;@JsonKey(includeIfNull: false, name: 'start_live_activity') bool? get startLiveActivity;@JsonKey(includeIfNull: false, name: 'collapse_notification') bool? get collapseNotification;@JsonKey(includeIfNull: false, name: 'warning_enabled') bool? get warningEnabled;
/// Create a copy of EewSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewSettingsRequestCopyWith<EewSettingsRequest> get copyWith => _$EewSettingsRequestCopyWithImpl<EewSettingsRequest>(this as EewSettingsRequest, _$identity);

  /// Serializes this EewSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.defaultSound, defaultSound) || other.defaultSound == defaultSound)&&(identical(other.defaultInterruptionLevel, defaultInterruptionLevel) || other.defaultInterruptionLevel == defaultInterruptionLevel)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.collapseNotification, collapseNotification) || other.collapseNotification == collapseNotification)&&(identical(other.warningEnabled, warningEnabled) || other.warningEnabled == warningEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,defaultSound,defaultInterruptionLevel,startLiveActivity,collapseNotification,warningEnabled);

@override
String toString() {
  return 'EewSettingsRequest(enabled: $enabled, defaultSound: $defaultSound, defaultInterruptionLevel: $defaultInterruptionLevel, startLiveActivity: $startLiveActivity, collapseNotification: $collapseNotification, warningEnabled: $warningEnabled)';
}


}

/// @nodoc
abstract mixin class $EewSettingsRequestCopyWith<$Res>  {
  factory $EewSettingsRequestCopyWith(EewSettingsRequest value, $Res Function(EewSettingsRequest) _then) = _$EewSettingsRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) bool? enabled,@JsonKey(includeIfNull: false, name: 'default_sound') String? defaultSound,@JsonKey(includeIfNull: false, name: 'default_interruption_level') DefaultInterruptionLevel? defaultInterruptionLevel,@JsonKey(includeIfNull: false, name: 'start_live_activity') bool? startLiveActivity,@JsonKey(includeIfNull: false, name: 'collapse_notification') bool? collapseNotification,@JsonKey(includeIfNull: false, name: 'warning_enabled') bool? warningEnabled
});




}
/// @nodoc
class _$EewSettingsRequestCopyWithImpl<$Res>
    implements $EewSettingsRequestCopyWith<$Res> {
  _$EewSettingsRequestCopyWithImpl(this._self, this._then);

  final EewSettingsRequest _self;
  final $Res Function(EewSettingsRequest) _then;

/// Create a copy of EewSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = freezed,Object? defaultSound = freezed,Object? defaultInterruptionLevel = freezed,Object? startLiveActivity = freezed,Object? collapseNotification = freezed,Object? warningEnabled = freezed,}) {
  return _then(EewSettingsRequest(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,defaultSound: freezed == defaultSound ? _self.defaultSound : defaultSound // ignore: cast_nullable_to_non_nullable
as String?,defaultInterruptionLevel: freezed == defaultInterruptionLevel ? _self.defaultInterruptionLevel : defaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as DefaultInterruptionLevel?,startLiveActivity: freezed == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool?,collapseNotification: freezed == collapseNotification ? _self.collapseNotification : collapseNotification // ignore: cast_nullable_to_non_nullable
as bool?,warningEnabled: freezed == warningEnabled ? _self.warningEnabled : warningEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [EewSettingsRequest].
extension EewSettingsRequestPatterns on EewSettingsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewSettingsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewSettingsRequest value)  $default,){
final _that = this;
switch (_that) {
case _EewSettingsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewSettingsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EewSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  bool? enabled, @JsonKey(includeIfNull: false, name: 'default_sound')  String? defaultSound, @JsonKey(includeIfNull: false, name: 'default_interruption_level')  DefaultInterruptionLevel? defaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'start_live_activity')  bool? startLiveActivity, @JsonKey(includeIfNull: false, name: 'collapse_notification')  bool? collapseNotification, @JsonKey(includeIfNull: false, name: 'warning_enabled')  bool? warningEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  bool? enabled, @JsonKey(includeIfNull: false, name: 'default_sound')  String? defaultSound, @JsonKey(includeIfNull: false, name: 'default_interruption_level')  DefaultInterruptionLevel? defaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'start_live_activity')  bool? startLiveActivity, @JsonKey(includeIfNull: false, name: 'collapse_notification')  bool? collapseNotification, @JsonKey(includeIfNull: false, name: 'warning_enabled')  bool? warningEnabled)  $default,) {final _that = this;
switch (_that) {
case _EewSettingsRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  bool? enabled, @JsonKey(includeIfNull: false, name: 'default_sound')  String? defaultSound, @JsonKey(includeIfNull: false, name: 'default_interruption_level')  DefaultInterruptionLevel? defaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'start_live_activity')  bool? startLiveActivity, @JsonKey(includeIfNull: false, name: 'collapse_notification')  bool? collapseNotification, @JsonKey(includeIfNull: false, name: 'warning_enabled')  bool? warningEnabled)?  $default,) {final _that = this;
switch (_that) {
case _EewSettingsRequest() when $default != null:
return $default(_that.enabled,_that.defaultSound,_that.defaultInterruptionLevel,_that.startLiveActivity,_that.collapseNotification,_that.warningEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewSettingsRequest implements EewSettingsRequest {
  const _EewSettingsRequest({@JsonKey(includeIfNull: false) this.enabled, @JsonKey(includeIfNull: false, name: 'default_sound') this.defaultSound, @JsonKey(includeIfNull: false, name: 'default_interruption_level') this.defaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'start_live_activity') this.startLiveActivity, @JsonKey(includeIfNull: false, name: 'collapse_notification') this.collapseNotification, @JsonKey(includeIfNull: false, name: 'warning_enabled') this.warningEnabled});
  factory _EewSettingsRequest.fromJson(Map<String, dynamic> json) => _$EewSettingsRequestFromJson(json);

@override@JsonKey(includeIfNull: false) final  bool? enabled;
@override@JsonKey(includeIfNull: false, name: 'default_sound') final  String? defaultSound;
@override@JsonKey(includeIfNull: false, name: 'default_interruption_level') final  DefaultInterruptionLevel? defaultInterruptionLevel;
@override@JsonKey(includeIfNull: false, name: 'start_live_activity') final  bool? startLiveActivity;
@override@JsonKey(includeIfNull: false, name: 'collapse_notification') final  bool? collapseNotification;
@override@JsonKey(includeIfNull: false, name: 'warning_enabled') final  bool? warningEnabled;

/// Create a copy of EewSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewSettingsRequestCopyWith<_EewSettingsRequest> get copyWith => __$EewSettingsRequestCopyWithImpl<_EewSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.defaultSound, defaultSound) || other.defaultSound == defaultSound)&&(identical(other.defaultInterruptionLevel, defaultInterruptionLevel) || other.defaultInterruptionLevel == defaultInterruptionLevel)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.collapseNotification, collapseNotification) || other.collapseNotification == collapseNotification)&&(identical(other.warningEnabled, warningEnabled) || other.warningEnabled == warningEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,defaultSound,defaultInterruptionLevel,startLiveActivity,collapseNotification,warningEnabled);

@override
String toString() {
  return 'EewSettingsRequest(enabled: $enabled, defaultSound: $defaultSound, defaultInterruptionLevel: $defaultInterruptionLevel, startLiveActivity: $startLiveActivity, collapseNotification: $collapseNotification, warningEnabled: $warningEnabled)';
}


}

/// @nodoc
abstract mixin class _$EewSettingsRequestCopyWith<$Res> implements $EewSettingsRequestCopyWith<$Res> {
  factory _$EewSettingsRequestCopyWith(_EewSettingsRequest value, $Res Function(_EewSettingsRequest) _then) = __$EewSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) bool? enabled,@JsonKey(includeIfNull: false, name: 'default_sound') String? defaultSound,@JsonKey(includeIfNull: false, name: 'default_interruption_level') DefaultInterruptionLevel? defaultInterruptionLevel,@JsonKey(includeIfNull: false, name: 'start_live_activity') bool? startLiveActivity,@JsonKey(includeIfNull: false, name: 'collapse_notification') bool? collapseNotification,@JsonKey(includeIfNull: false, name: 'warning_enabled') bool? warningEnabled
});




}
/// @nodoc
class __$EewSettingsRequestCopyWithImpl<$Res>
    implements _$EewSettingsRequestCopyWith<$Res> {
  __$EewSettingsRequestCopyWithImpl(this._self, this._then);

  final _EewSettingsRequest _self;
  final $Res Function(_EewSettingsRequest) _then;

/// Create a copy of EewSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = freezed,Object? defaultSound = freezed,Object? defaultInterruptionLevel = freezed,Object? startLiveActivity = freezed,Object? collapseNotification = freezed,Object? warningEnabled = freezed,}) {
  return _then(_EewSettingsRequest(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,defaultSound: freezed == defaultSound ? _self.defaultSound : defaultSound // ignore: cast_nullable_to_non_nullable
as String?,defaultInterruptionLevel: freezed == defaultInterruptionLevel ? _self.defaultInterruptionLevel : defaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as DefaultInterruptionLevel?,startLiveActivity: freezed == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool?,collapseNotification: freezed == collapseNotification ? _self.collapseNotification : collapseNotification // ignore: cast_nullable_to_non_nullable
as bool?,warningEnabled: freezed == warningEnabled ? _self.warningEnabled : warningEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
