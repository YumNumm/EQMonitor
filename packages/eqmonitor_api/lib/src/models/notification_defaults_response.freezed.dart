// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_defaults_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationDefaultsResponse {

@JsonKey(name: 'eew_enabled') bool get eewEnabled;@JsonKey(name: 'earthquake_enabled') bool get earthquakeEnabled;@JsonKey(name: 'eew_default_sound') String get eewDefaultSound;@JsonKey(name: 'eew_default_interruption_level') EewDefaultInterruptionLevel get eewDefaultInterruptionLevel;@JsonKey(name: 'earthquake_default_sound') String get earthquakeDefaultSound;@JsonKey(name: 'earthquake_default_interruption_level') EarthquakeDefaultInterruptionLevel get earthquakeDefaultInterruptionLevel;@JsonKey(name: 'start_live_activity') bool get startLiveActivity;@JsonKey(name: 'eew_one_point_enabled') bool get eewOnePointEnabled;@JsonKey(name: 'eew_collapse_notification') bool get eewCollapseNotification;@JsonKey(name: 'earthquake_estimated_intensity_enabled') bool get earthquakeEstimatedIntensityEnabled;@JsonKey(name: 'earthquake_collapse_notification') bool get earthquakeCollapseNotification;@JsonKey(name: 'is_pro') bool get isPro;
/// Create a copy of NotificationDefaultsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDefaultsResponseCopyWith<NotificationDefaultsResponse> get copyWith => _$NotificationDefaultsResponseCopyWithImpl<NotificationDefaultsResponse>(this as NotificationDefaultsResponse, _$identity);

  /// Serializes this NotificationDefaultsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationDefaultsResponse&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.eewDefaultSound, eewDefaultSound) || other.eewDefaultSound == eewDefaultSound)&&(identical(other.eewDefaultInterruptionLevel, eewDefaultInterruptionLevel) || other.eewDefaultInterruptionLevel == eewDefaultInterruptionLevel)&&(identical(other.earthquakeDefaultSound, earthquakeDefaultSound) || other.earthquakeDefaultSound == earthquakeDefaultSound)&&(identical(other.earthquakeDefaultInterruptionLevel, earthquakeDefaultInterruptionLevel) || other.earthquakeDefaultInterruptionLevel == earthquakeDefaultInterruptionLevel)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.eewOnePointEnabled, eewOnePointEnabled) || other.eewOnePointEnabled == eewOnePointEnabled)&&(identical(other.eewCollapseNotification, eewCollapseNotification) || other.eewCollapseNotification == eewCollapseNotification)&&(identical(other.earthquakeEstimatedIntensityEnabled, earthquakeEstimatedIntensityEnabled) || other.earthquakeEstimatedIntensityEnabled == earthquakeEstimatedIntensityEnabled)&&(identical(other.earthquakeCollapseNotification, earthquakeCollapseNotification) || other.earthquakeCollapseNotification == earthquakeCollapseNotification)&&(identical(other.isPro, isPro) || other.isPro == isPro));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eewEnabled,earthquakeEnabled,eewDefaultSound,eewDefaultInterruptionLevel,earthquakeDefaultSound,earthquakeDefaultInterruptionLevel,startLiveActivity,eewOnePointEnabled,eewCollapseNotification,earthquakeEstimatedIntensityEnabled,earthquakeCollapseNotification,isPro);

@override
String toString() {
  return 'NotificationDefaultsResponse(eewEnabled: $eewEnabled, earthquakeEnabled: $earthquakeEnabled, eewDefaultSound: $eewDefaultSound, eewDefaultInterruptionLevel: $eewDefaultInterruptionLevel, earthquakeDefaultSound: $earthquakeDefaultSound, earthquakeDefaultInterruptionLevel: $earthquakeDefaultInterruptionLevel, startLiveActivity: $startLiveActivity, eewOnePointEnabled: $eewOnePointEnabled, eewCollapseNotification: $eewCollapseNotification, earthquakeEstimatedIntensityEnabled: $earthquakeEstimatedIntensityEnabled, earthquakeCollapseNotification: $earthquakeCollapseNotification, isPro: $isPro)';
}


}

/// @nodoc
abstract mixin class $NotificationDefaultsResponseCopyWith<$Res>  {
  factory $NotificationDefaultsResponseCopyWith(NotificationDefaultsResponse value, $Res Function(NotificationDefaultsResponse) _then) = _$NotificationDefaultsResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'eew_enabled') bool eewEnabled,@JsonKey(name: 'earthquake_enabled') bool earthquakeEnabled,@JsonKey(name: 'eew_default_sound') String eewDefaultSound,@JsonKey(name: 'eew_default_interruption_level') EewDefaultInterruptionLevel eewDefaultInterruptionLevel,@JsonKey(name: 'earthquake_default_sound') String earthquakeDefaultSound,@JsonKey(name: 'earthquake_default_interruption_level') EarthquakeDefaultInterruptionLevel earthquakeDefaultInterruptionLevel,@JsonKey(name: 'start_live_activity') bool startLiveActivity,@JsonKey(name: 'eew_one_point_enabled') bool eewOnePointEnabled,@JsonKey(name: 'eew_collapse_notification') bool eewCollapseNotification,@JsonKey(name: 'earthquake_estimated_intensity_enabled') bool earthquakeEstimatedIntensityEnabled,@JsonKey(name: 'earthquake_collapse_notification') bool earthquakeCollapseNotification,@JsonKey(name: 'is_pro') bool isPro
});




}
/// @nodoc
class _$NotificationDefaultsResponseCopyWithImpl<$Res>
    implements $NotificationDefaultsResponseCopyWith<$Res> {
  _$NotificationDefaultsResponseCopyWithImpl(this._self, this._then);

  final NotificationDefaultsResponse _self;
  final $Res Function(NotificationDefaultsResponse) _then;

/// Create a copy of NotificationDefaultsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eewEnabled = null,Object? earthquakeEnabled = null,Object? eewDefaultSound = null,Object? eewDefaultInterruptionLevel = null,Object? earthquakeDefaultSound = null,Object? earthquakeDefaultInterruptionLevel = null,Object? startLiveActivity = null,Object? eewOnePointEnabled = null,Object? eewCollapseNotification = null,Object? earthquakeEstimatedIntensityEnabled = null,Object? earthquakeCollapseNotification = null,Object? isPro = null,}) {
  return _then(_self.copyWith(
eewEnabled: null == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeEnabled: null == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool,eewDefaultSound: null == eewDefaultSound ? _self.eewDefaultSound : eewDefaultSound // ignore: cast_nullable_to_non_nullable
as String,eewDefaultInterruptionLevel: null == eewDefaultInterruptionLevel ? _self.eewDefaultInterruptionLevel : eewDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as EewDefaultInterruptionLevel,earthquakeDefaultSound: null == earthquakeDefaultSound ? _self.earthquakeDefaultSound : earthquakeDefaultSound // ignore: cast_nullable_to_non_nullable
as String,earthquakeDefaultInterruptionLevel: null == earthquakeDefaultInterruptionLevel ? _self.earthquakeDefaultInterruptionLevel : earthquakeDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as EarthquakeDefaultInterruptionLevel,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,eewOnePointEnabled: null == eewOnePointEnabled ? _self.eewOnePointEnabled : eewOnePointEnabled // ignore: cast_nullable_to_non_nullable
as bool,eewCollapseNotification: null == eewCollapseNotification ? _self.eewCollapseNotification : eewCollapseNotification // ignore: cast_nullable_to_non_nullable
as bool,earthquakeEstimatedIntensityEnabled: null == earthquakeEstimatedIntensityEnabled ? _self.earthquakeEstimatedIntensityEnabled : earthquakeEstimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeCollapseNotification: null == earthquakeCollapseNotification ? _self.earthquakeCollapseNotification : earthquakeCollapseNotification // ignore: cast_nullable_to_non_nullable
as bool,isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationDefaultsResponse].
extension NotificationDefaultsResponsePatterns on NotificationDefaultsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationDefaultsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationDefaultsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationDefaultsResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationDefaultsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationDefaultsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationDefaultsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'eew_enabled')  bool eewEnabled, @JsonKey(name: 'earthquake_enabled')  bool earthquakeEnabled, @JsonKey(name: 'eew_default_sound')  String eewDefaultSound, @JsonKey(name: 'eew_default_interruption_level')  EewDefaultInterruptionLevel eewDefaultInterruptionLevel, @JsonKey(name: 'earthquake_default_sound')  String earthquakeDefaultSound, @JsonKey(name: 'earthquake_default_interruption_level')  EarthquakeDefaultInterruptionLevel earthquakeDefaultInterruptionLevel, @JsonKey(name: 'start_live_activity')  bool startLiveActivity, @JsonKey(name: 'eew_one_point_enabled')  bool eewOnePointEnabled, @JsonKey(name: 'eew_collapse_notification')  bool eewCollapseNotification, @JsonKey(name: 'earthquake_estimated_intensity_enabled')  bool earthquakeEstimatedIntensityEnabled, @JsonKey(name: 'earthquake_collapse_notification')  bool earthquakeCollapseNotification, @JsonKey(name: 'is_pro')  bool isPro)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationDefaultsResponse() when $default != null:
return $default(_that.eewEnabled,_that.earthquakeEnabled,_that.eewDefaultSound,_that.eewDefaultInterruptionLevel,_that.earthquakeDefaultSound,_that.earthquakeDefaultInterruptionLevel,_that.startLiveActivity,_that.eewOnePointEnabled,_that.eewCollapseNotification,_that.earthquakeEstimatedIntensityEnabled,_that.earthquakeCollapseNotification,_that.isPro);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'eew_enabled')  bool eewEnabled, @JsonKey(name: 'earthquake_enabled')  bool earthquakeEnabled, @JsonKey(name: 'eew_default_sound')  String eewDefaultSound, @JsonKey(name: 'eew_default_interruption_level')  EewDefaultInterruptionLevel eewDefaultInterruptionLevel, @JsonKey(name: 'earthquake_default_sound')  String earthquakeDefaultSound, @JsonKey(name: 'earthquake_default_interruption_level')  EarthquakeDefaultInterruptionLevel earthquakeDefaultInterruptionLevel, @JsonKey(name: 'start_live_activity')  bool startLiveActivity, @JsonKey(name: 'eew_one_point_enabled')  bool eewOnePointEnabled, @JsonKey(name: 'eew_collapse_notification')  bool eewCollapseNotification, @JsonKey(name: 'earthquake_estimated_intensity_enabled')  bool earthquakeEstimatedIntensityEnabled, @JsonKey(name: 'earthquake_collapse_notification')  bool earthquakeCollapseNotification, @JsonKey(name: 'is_pro')  bool isPro)  $default,) {final _that = this;
switch (_that) {
case _NotificationDefaultsResponse():
return $default(_that.eewEnabled,_that.earthquakeEnabled,_that.eewDefaultSound,_that.eewDefaultInterruptionLevel,_that.earthquakeDefaultSound,_that.earthquakeDefaultInterruptionLevel,_that.startLiveActivity,_that.eewOnePointEnabled,_that.eewCollapseNotification,_that.earthquakeEstimatedIntensityEnabled,_that.earthquakeCollapseNotification,_that.isPro);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'eew_enabled')  bool eewEnabled, @JsonKey(name: 'earthquake_enabled')  bool earthquakeEnabled, @JsonKey(name: 'eew_default_sound')  String eewDefaultSound, @JsonKey(name: 'eew_default_interruption_level')  EewDefaultInterruptionLevel eewDefaultInterruptionLevel, @JsonKey(name: 'earthquake_default_sound')  String earthquakeDefaultSound, @JsonKey(name: 'earthquake_default_interruption_level')  EarthquakeDefaultInterruptionLevel earthquakeDefaultInterruptionLevel, @JsonKey(name: 'start_live_activity')  bool startLiveActivity, @JsonKey(name: 'eew_one_point_enabled')  bool eewOnePointEnabled, @JsonKey(name: 'eew_collapse_notification')  bool eewCollapseNotification, @JsonKey(name: 'earthquake_estimated_intensity_enabled')  bool earthquakeEstimatedIntensityEnabled, @JsonKey(name: 'earthquake_collapse_notification')  bool earthquakeCollapseNotification, @JsonKey(name: 'is_pro')  bool isPro)?  $default,) {final _that = this;
switch (_that) {
case _NotificationDefaultsResponse() when $default != null:
return $default(_that.eewEnabled,_that.earthquakeEnabled,_that.eewDefaultSound,_that.eewDefaultInterruptionLevel,_that.earthquakeDefaultSound,_that.earthquakeDefaultInterruptionLevel,_that.startLiveActivity,_that.eewOnePointEnabled,_that.eewCollapseNotification,_that.earthquakeEstimatedIntensityEnabled,_that.earthquakeCollapseNotification,_that.isPro);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationDefaultsResponse implements NotificationDefaultsResponse {
  const _NotificationDefaultsResponse({@JsonKey(name: 'eew_enabled') required this.eewEnabled, @JsonKey(name: 'earthquake_enabled') required this.earthquakeEnabled, @JsonKey(name: 'eew_default_sound') required this.eewDefaultSound, @JsonKey(name: 'eew_default_interruption_level') required this.eewDefaultInterruptionLevel, @JsonKey(name: 'earthquake_default_sound') required this.earthquakeDefaultSound, @JsonKey(name: 'earthquake_default_interruption_level') required this.earthquakeDefaultInterruptionLevel, @JsonKey(name: 'start_live_activity') required this.startLiveActivity, @JsonKey(name: 'eew_one_point_enabled') required this.eewOnePointEnabled, @JsonKey(name: 'eew_collapse_notification') required this.eewCollapseNotification, @JsonKey(name: 'earthquake_estimated_intensity_enabled') required this.earthquakeEstimatedIntensityEnabled, @JsonKey(name: 'earthquake_collapse_notification') required this.earthquakeCollapseNotification, @JsonKey(name: 'is_pro') required this.isPro});
  factory _NotificationDefaultsResponse.fromJson(Map<String, dynamic> json) => _$NotificationDefaultsResponseFromJson(json);

@override@JsonKey(name: 'eew_enabled') final  bool eewEnabled;
@override@JsonKey(name: 'earthquake_enabled') final  bool earthquakeEnabled;
@override@JsonKey(name: 'eew_default_sound') final  String eewDefaultSound;
@override@JsonKey(name: 'eew_default_interruption_level') final  EewDefaultInterruptionLevel eewDefaultInterruptionLevel;
@override@JsonKey(name: 'earthquake_default_sound') final  String earthquakeDefaultSound;
@override@JsonKey(name: 'earthquake_default_interruption_level') final  EarthquakeDefaultInterruptionLevel earthquakeDefaultInterruptionLevel;
@override@JsonKey(name: 'start_live_activity') final  bool startLiveActivity;
@override@JsonKey(name: 'eew_one_point_enabled') final  bool eewOnePointEnabled;
@override@JsonKey(name: 'eew_collapse_notification') final  bool eewCollapseNotification;
@override@JsonKey(name: 'earthquake_estimated_intensity_enabled') final  bool earthquakeEstimatedIntensityEnabled;
@override@JsonKey(name: 'earthquake_collapse_notification') final  bool earthquakeCollapseNotification;
@override@JsonKey(name: 'is_pro') final  bool isPro;

/// Create a copy of NotificationDefaultsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDefaultsResponseCopyWith<_NotificationDefaultsResponse> get copyWith => __$NotificationDefaultsResponseCopyWithImpl<_NotificationDefaultsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDefaultsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationDefaultsResponse&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.eewDefaultSound, eewDefaultSound) || other.eewDefaultSound == eewDefaultSound)&&(identical(other.eewDefaultInterruptionLevel, eewDefaultInterruptionLevel) || other.eewDefaultInterruptionLevel == eewDefaultInterruptionLevel)&&(identical(other.earthquakeDefaultSound, earthquakeDefaultSound) || other.earthquakeDefaultSound == earthquakeDefaultSound)&&(identical(other.earthquakeDefaultInterruptionLevel, earthquakeDefaultInterruptionLevel) || other.earthquakeDefaultInterruptionLevel == earthquakeDefaultInterruptionLevel)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.eewOnePointEnabled, eewOnePointEnabled) || other.eewOnePointEnabled == eewOnePointEnabled)&&(identical(other.eewCollapseNotification, eewCollapseNotification) || other.eewCollapseNotification == eewCollapseNotification)&&(identical(other.earthquakeEstimatedIntensityEnabled, earthquakeEstimatedIntensityEnabled) || other.earthquakeEstimatedIntensityEnabled == earthquakeEstimatedIntensityEnabled)&&(identical(other.earthquakeCollapseNotification, earthquakeCollapseNotification) || other.earthquakeCollapseNotification == earthquakeCollapseNotification)&&(identical(other.isPro, isPro) || other.isPro == isPro));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eewEnabled,earthquakeEnabled,eewDefaultSound,eewDefaultInterruptionLevel,earthquakeDefaultSound,earthquakeDefaultInterruptionLevel,startLiveActivity,eewOnePointEnabled,eewCollapseNotification,earthquakeEstimatedIntensityEnabled,earthquakeCollapseNotification,isPro);

@override
String toString() {
  return 'NotificationDefaultsResponse(eewEnabled: $eewEnabled, earthquakeEnabled: $earthquakeEnabled, eewDefaultSound: $eewDefaultSound, eewDefaultInterruptionLevel: $eewDefaultInterruptionLevel, earthquakeDefaultSound: $earthquakeDefaultSound, earthquakeDefaultInterruptionLevel: $earthquakeDefaultInterruptionLevel, startLiveActivity: $startLiveActivity, eewOnePointEnabled: $eewOnePointEnabled, eewCollapseNotification: $eewCollapseNotification, earthquakeEstimatedIntensityEnabled: $earthquakeEstimatedIntensityEnabled, earthquakeCollapseNotification: $earthquakeCollapseNotification, isPro: $isPro)';
}


}

/// @nodoc
abstract mixin class _$NotificationDefaultsResponseCopyWith<$Res> implements $NotificationDefaultsResponseCopyWith<$Res> {
  factory _$NotificationDefaultsResponseCopyWith(_NotificationDefaultsResponse value, $Res Function(_NotificationDefaultsResponse) _then) = __$NotificationDefaultsResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'eew_enabled') bool eewEnabled,@JsonKey(name: 'earthquake_enabled') bool earthquakeEnabled,@JsonKey(name: 'eew_default_sound') String eewDefaultSound,@JsonKey(name: 'eew_default_interruption_level') EewDefaultInterruptionLevel eewDefaultInterruptionLevel,@JsonKey(name: 'earthquake_default_sound') String earthquakeDefaultSound,@JsonKey(name: 'earthquake_default_interruption_level') EarthquakeDefaultInterruptionLevel earthquakeDefaultInterruptionLevel,@JsonKey(name: 'start_live_activity') bool startLiveActivity,@JsonKey(name: 'eew_one_point_enabled') bool eewOnePointEnabled,@JsonKey(name: 'eew_collapse_notification') bool eewCollapseNotification,@JsonKey(name: 'earthquake_estimated_intensity_enabled') bool earthquakeEstimatedIntensityEnabled,@JsonKey(name: 'earthquake_collapse_notification') bool earthquakeCollapseNotification,@JsonKey(name: 'is_pro') bool isPro
});




}
/// @nodoc
class __$NotificationDefaultsResponseCopyWithImpl<$Res>
    implements _$NotificationDefaultsResponseCopyWith<$Res> {
  __$NotificationDefaultsResponseCopyWithImpl(this._self, this._then);

  final _NotificationDefaultsResponse _self;
  final $Res Function(_NotificationDefaultsResponse) _then;

/// Create a copy of NotificationDefaultsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eewEnabled = null,Object? earthquakeEnabled = null,Object? eewDefaultSound = null,Object? eewDefaultInterruptionLevel = null,Object? earthquakeDefaultSound = null,Object? earthquakeDefaultInterruptionLevel = null,Object? startLiveActivity = null,Object? eewOnePointEnabled = null,Object? eewCollapseNotification = null,Object? earthquakeEstimatedIntensityEnabled = null,Object? earthquakeCollapseNotification = null,Object? isPro = null,}) {
  return _then(_NotificationDefaultsResponse(
eewEnabled: null == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeEnabled: null == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool,eewDefaultSound: null == eewDefaultSound ? _self.eewDefaultSound : eewDefaultSound // ignore: cast_nullable_to_non_nullable
as String,eewDefaultInterruptionLevel: null == eewDefaultInterruptionLevel ? _self.eewDefaultInterruptionLevel : eewDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as EewDefaultInterruptionLevel,earthquakeDefaultSound: null == earthquakeDefaultSound ? _self.earthquakeDefaultSound : earthquakeDefaultSound // ignore: cast_nullable_to_non_nullable
as String,earthquakeDefaultInterruptionLevel: null == earthquakeDefaultInterruptionLevel ? _self.earthquakeDefaultInterruptionLevel : earthquakeDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as EarthquakeDefaultInterruptionLevel,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,eewOnePointEnabled: null == eewOnePointEnabled ? _self.eewOnePointEnabled : eewOnePointEnabled // ignore: cast_nullable_to_non_nullable
as bool,eewCollapseNotification: null == eewCollapseNotification ? _self.eewCollapseNotification : eewCollapseNotification // ignore: cast_nullable_to_non_nullable
as bool,earthquakeEstimatedIntensityEnabled: null == earthquakeEstimatedIntensityEnabled ? _self.earthquakeEstimatedIntensityEnabled : earthquakeEstimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeCollapseNotification: null == earthquakeCollapseNotification ? _self.earthquakeCollapseNotification : earthquakeCollapseNotification // ignore: cast_nullable_to_non_nullable
as bool,isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
