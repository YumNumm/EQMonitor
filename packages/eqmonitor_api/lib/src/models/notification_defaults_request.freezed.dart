// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_defaults_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationDefaultsRequest {

@JsonKey(includeIfNull: false, name: 'eew_default_sound') String? get eewDefaultSound;@JsonKey(includeIfNull: false, name: 'eew_default_interruption_level') EewDefaultInterruptionLevel? get eewDefaultInterruptionLevel;@JsonKey(includeIfNull: false, name: 'earthquake_default_sound') String? get earthquakeDefaultSound;@JsonKey(includeIfNull: false, name: 'earthquake_default_interruption_level') EarthquakeDefaultInterruptionLevel? get earthquakeDefaultInterruptionLevel;@JsonKey(includeIfNull: false, name: 'start_live_activity') bool? get startLiveActivity;@JsonKey(includeIfNull: false, name: 'eew_one_point_enabled') bool? get eewOnePointEnabled;@JsonKey(includeIfNull: false, name: 'eew_collapse_notification') bool? get eewCollapseNotification;@JsonKey(includeIfNull: false, name: 'earthquake_estimated_intensity_enabled') bool? get earthquakeEstimatedIntensityEnabled;@JsonKey(includeIfNull: false, name: 'earthquake_collapse_notification') bool? get earthquakeCollapseNotification;
/// Create a copy of NotificationDefaultsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDefaultsRequestCopyWith<NotificationDefaultsRequest> get copyWith => _$NotificationDefaultsRequestCopyWithImpl<NotificationDefaultsRequest>(this as NotificationDefaultsRequest, _$identity);

  /// Serializes this NotificationDefaultsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationDefaultsRequest&&(identical(other.eewDefaultSound, eewDefaultSound) || other.eewDefaultSound == eewDefaultSound)&&(identical(other.eewDefaultInterruptionLevel, eewDefaultInterruptionLevel) || other.eewDefaultInterruptionLevel == eewDefaultInterruptionLevel)&&(identical(other.earthquakeDefaultSound, earthquakeDefaultSound) || other.earthquakeDefaultSound == earthquakeDefaultSound)&&(identical(other.earthquakeDefaultInterruptionLevel, earthquakeDefaultInterruptionLevel) || other.earthquakeDefaultInterruptionLevel == earthquakeDefaultInterruptionLevel)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.eewOnePointEnabled, eewOnePointEnabled) || other.eewOnePointEnabled == eewOnePointEnabled)&&(identical(other.eewCollapseNotification, eewCollapseNotification) || other.eewCollapseNotification == eewCollapseNotification)&&(identical(other.earthquakeEstimatedIntensityEnabled, earthquakeEstimatedIntensityEnabled) || other.earthquakeEstimatedIntensityEnabled == earthquakeEstimatedIntensityEnabled)&&(identical(other.earthquakeCollapseNotification, earthquakeCollapseNotification) || other.earthquakeCollapseNotification == earthquakeCollapseNotification));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eewDefaultSound,eewDefaultInterruptionLevel,earthquakeDefaultSound,earthquakeDefaultInterruptionLevel,startLiveActivity,eewOnePointEnabled,eewCollapseNotification,earthquakeEstimatedIntensityEnabled,earthquakeCollapseNotification);

@override
String toString() {
  return 'NotificationDefaultsRequest(eewDefaultSound: $eewDefaultSound, eewDefaultInterruptionLevel: $eewDefaultInterruptionLevel, earthquakeDefaultSound: $earthquakeDefaultSound, earthquakeDefaultInterruptionLevel: $earthquakeDefaultInterruptionLevel, startLiveActivity: $startLiveActivity, eewOnePointEnabled: $eewOnePointEnabled, eewCollapseNotification: $eewCollapseNotification, earthquakeEstimatedIntensityEnabled: $earthquakeEstimatedIntensityEnabled, earthquakeCollapseNotification: $earthquakeCollapseNotification)';
}


}

/// @nodoc
abstract mixin class $NotificationDefaultsRequestCopyWith<$Res>  {
  factory $NotificationDefaultsRequestCopyWith(NotificationDefaultsRequest value, $Res Function(NotificationDefaultsRequest) _then) = _$NotificationDefaultsRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'eew_default_sound') String? eewDefaultSound,@JsonKey(includeIfNull: false, name: 'eew_default_interruption_level') EewDefaultInterruptionLevel? eewDefaultInterruptionLevel,@JsonKey(includeIfNull: false, name: 'earthquake_default_sound') String? earthquakeDefaultSound,@JsonKey(includeIfNull: false, name: 'earthquake_default_interruption_level') EarthquakeDefaultInterruptionLevel? earthquakeDefaultInterruptionLevel,@JsonKey(includeIfNull: false, name: 'start_live_activity') bool? startLiveActivity,@JsonKey(includeIfNull: false, name: 'eew_one_point_enabled') bool? eewOnePointEnabled,@JsonKey(includeIfNull: false, name: 'eew_collapse_notification') bool? eewCollapseNotification,@JsonKey(includeIfNull: false, name: 'earthquake_estimated_intensity_enabled') bool? earthquakeEstimatedIntensityEnabled,@JsonKey(includeIfNull: false, name: 'earthquake_collapse_notification') bool? earthquakeCollapseNotification
});




}
/// @nodoc
class _$NotificationDefaultsRequestCopyWithImpl<$Res>
    implements $NotificationDefaultsRequestCopyWith<$Res> {
  _$NotificationDefaultsRequestCopyWithImpl(this._self, this._then);

  final NotificationDefaultsRequest _self;
  final $Res Function(NotificationDefaultsRequest) _then;

/// Create a copy of NotificationDefaultsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eewDefaultSound = freezed,Object? eewDefaultInterruptionLevel = freezed,Object? earthquakeDefaultSound = freezed,Object? earthquakeDefaultInterruptionLevel = freezed,Object? startLiveActivity = freezed,Object? eewOnePointEnabled = freezed,Object? eewCollapseNotification = freezed,Object? earthquakeEstimatedIntensityEnabled = freezed,Object? earthquakeCollapseNotification = freezed,}) {
  return _then(_self.copyWith(
eewDefaultSound: freezed == eewDefaultSound ? _self.eewDefaultSound : eewDefaultSound // ignore: cast_nullable_to_non_nullable
as String?,eewDefaultInterruptionLevel: freezed == eewDefaultInterruptionLevel ? _self.eewDefaultInterruptionLevel : eewDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as EewDefaultInterruptionLevel?,earthquakeDefaultSound: freezed == earthquakeDefaultSound ? _self.earthquakeDefaultSound : earthquakeDefaultSound // ignore: cast_nullable_to_non_nullable
as String?,earthquakeDefaultInterruptionLevel: freezed == earthquakeDefaultInterruptionLevel ? _self.earthquakeDefaultInterruptionLevel : earthquakeDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as EarthquakeDefaultInterruptionLevel?,startLiveActivity: freezed == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool?,eewOnePointEnabled: freezed == eewOnePointEnabled ? _self.eewOnePointEnabled : eewOnePointEnabled // ignore: cast_nullable_to_non_nullable
as bool?,eewCollapseNotification: freezed == eewCollapseNotification ? _self.eewCollapseNotification : eewCollapseNotification // ignore: cast_nullable_to_non_nullable
as bool?,earthquakeEstimatedIntensityEnabled: freezed == earthquakeEstimatedIntensityEnabled ? _self.earthquakeEstimatedIntensityEnabled : earthquakeEstimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool?,earthquakeCollapseNotification: freezed == earthquakeCollapseNotification ? _self.earthquakeCollapseNotification : earthquakeCollapseNotification // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationDefaultsRequest].
extension NotificationDefaultsRequestPatterns on NotificationDefaultsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationDefaultsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationDefaultsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationDefaultsRequest value)  $default,){
final _that = this;
switch (_that) {
case _NotificationDefaultsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationDefaultsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationDefaultsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'eew_default_sound')  String? eewDefaultSound, @JsonKey(includeIfNull: false, name: 'eew_default_interruption_level')  EewDefaultInterruptionLevel? eewDefaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'earthquake_default_sound')  String? earthquakeDefaultSound, @JsonKey(includeIfNull: false, name: 'earthquake_default_interruption_level')  EarthquakeDefaultInterruptionLevel? earthquakeDefaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'start_live_activity')  bool? startLiveActivity, @JsonKey(includeIfNull: false, name: 'eew_one_point_enabled')  bool? eewOnePointEnabled, @JsonKey(includeIfNull: false, name: 'eew_collapse_notification')  bool? eewCollapseNotification, @JsonKey(includeIfNull: false, name: 'earthquake_estimated_intensity_enabled')  bool? earthquakeEstimatedIntensityEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_collapse_notification')  bool? earthquakeCollapseNotification)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationDefaultsRequest() when $default != null:
return $default(_that.eewDefaultSound,_that.eewDefaultInterruptionLevel,_that.earthquakeDefaultSound,_that.earthquakeDefaultInterruptionLevel,_that.startLiveActivity,_that.eewOnePointEnabled,_that.eewCollapseNotification,_that.earthquakeEstimatedIntensityEnabled,_that.earthquakeCollapseNotification);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'eew_default_sound')  String? eewDefaultSound, @JsonKey(includeIfNull: false, name: 'eew_default_interruption_level')  EewDefaultInterruptionLevel? eewDefaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'earthquake_default_sound')  String? earthquakeDefaultSound, @JsonKey(includeIfNull: false, name: 'earthquake_default_interruption_level')  EarthquakeDefaultInterruptionLevel? earthquakeDefaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'start_live_activity')  bool? startLiveActivity, @JsonKey(includeIfNull: false, name: 'eew_one_point_enabled')  bool? eewOnePointEnabled, @JsonKey(includeIfNull: false, name: 'eew_collapse_notification')  bool? eewCollapseNotification, @JsonKey(includeIfNull: false, name: 'earthquake_estimated_intensity_enabled')  bool? earthquakeEstimatedIntensityEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_collapse_notification')  bool? earthquakeCollapseNotification)  $default,) {final _that = this;
switch (_that) {
case _NotificationDefaultsRequest():
return $default(_that.eewDefaultSound,_that.eewDefaultInterruptionLevel,_that.earthquakeDefaultSound,_that.earthquakeDefaultInterruptionLevel,_that.startLiveActivity,_that.eewOnePointEnabled,_that.eewCollapseNotification,_that.earthquakeEstimatedIntensityEnabled,_that.earthquakeCollapseNotification);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'eew_default_sound')  String? eewDefaultSound, @JsonKey(includeIfNull: false, name: 'eew_default_interruption_level')  EewDefaultInterruptionLevel? eewDefaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'earthquake_default_sound')  String? earthquakeDefaultSound, @JsonKey(includeIfNull: false, name: 'earthquake_default_interruption_level')  EarthquakeDefaultInterruptionLevel? earthquakeDefaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'start_live_activity')  bool? startLiveActivity, @JsonKey(includeIfNull: false, name: 'eew_one_point_enabled')  bool? eewOnePointEnabled, @JsonKey(includeIfNull: false, name: 'eew_collapse_notification')  bool? eewCollapseNotification, @JsonKey(includeIfNull: false, name: 'earthquake_estimated_intensity_enabled')  bool? earthquakeEstimatedIntensityEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_collapse_notification')  bool? earthquakeCollapseNotification)?  $default,) {final _that = this;
switch (_that) {
case _NotificationDefaultsRequest() when $default != null:
return $default(_that.eewDefaultSound,_that.eewDefaultInterruptionLevel,_that.earthquakeDefaultSound,_that.earthquakeDefaultInterruptionLevel,_that.startLiveActivity,_that.eewOnePointEnabled,_that.eewCollapseNotification,_that.earthquakeEstimatedIntensityEnabled,_that.earthquakeCollapseNotification);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationDefaultsRequest implements NotificationDefaultsRequest {
  const _NotificationDefaultsRequest({@JsonKey(includeIfNull: false, name: 'eew_default_sound') this.eewDefaultSound, @JsonKey(includeIfNull: false, name: 'eew_default_interruption_level') this.eewDefaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'earthquake_default_sound') this.earthquakeDefaultSound, @JsonKey(includeIfNull: false, name: 'earthquake_default_interruption_level') this.earthquakeDefaultInterruptionLevel, @JsonKey(includeIfNull: false, name: 'start_live_activity') this.startLiveActivity, @JsonKey(includeIfNull: false, name: 'eew_one_point_enabled') this.eewOnePointEnabled, @JsonKey(includeIfNull: false, name: 'eew_collapse_notification') this.eewCollapseNotification, @JsonKey(includeIfNull: false, name: 'earthquake_estimated_intensity_enabled') this.earthquakeEstimatedIntensityEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_collapse_notification') this.earthquakeCollapseNotification});
  factory _NotificationDefaultsRequest.fromJson(Map<String, dynamic> json) => _$NotificationDefaultsRequestFromJson(json);

@override@JsonKey(includeIfNull: false, name: 'eew_default_sound') final  String? eewDefaultSound;
@override@JsonKey(includeIfNull: false, name: 'eew_default_interruption_level') final  EewDefaultInterruptionLevel? eewDefaultInterruptionLevel;
@override@JsonKey(includeIfNull: false, name: 'earthquake_default_sound') final  String? earthquakeDefaultSound;
@override@JsonKey(includeIfNull: false, name: 'earthquake_default_interruption_level') final  EarthquakeDefaultInterruptionLevel? earthquakeDefaultInterruptionLevel;
@override@JsonKey(includeIfNull: false, name: 'start_live_activity') final  bool? startLiveActivity;
@override@JsonKey(includeIfNull: false, name: 'eew_one_point_enabled') final  bool? eewOnePointEnabled;
@override@JsonKey(includeIfNull: false, name: 'eew_collapse_notification') final  bool? eewCollapseNotification;
@override@JsonKey(includeIfNull: false, name: 'earthquake_estimated_intensity_enabled') final  bool? earthquakeEstimatedIntensityEnabled;
@override@JsonKey(includeIfNull: false, name: 'earthquake_collapse_notification') final  bool? earthquakeCollapseNotification;

/// Create a copy of NotificationDefaultsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDefaultsRequestCopyWith<_NotificationDefaultsRequest> get copyWith => __$NotificationDefaultsRequestCopyWithImpl<_NotificationDefaultsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDefaultsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationDefaultsRequest&&(identical(other.eewDefaultSound, eewDefaultSound) || other.eewDefaultSound == eewDefaultSound)&&(identical(other.eewDefaultInterruptionLevel, eewDefaultInterruptionLevel) || other.eewDefaultInterruptionLevel == eewDefaultInterruptionLevel)&&(identical(other.earthquakeDefaultSound, earthquakeDefaultSound) || other.earthquakeDefaultSound == earthquakeDefaultSound)&&(identical(other.earthquakeDefaultInterruptionLevel, earthquakeDefaultInterruptionLevel) || other.earthquakeDefaultInterruptionLevel == earthquakeDefaultInterruptionLevel)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.eewOnePointEnabled, eewOnePointEnabled) || other.eewOnePointEnabled == eewOnePointEnabled)&&(identical(other.eewCollapseNotification, eewCollapseNotification) || other.eewCollapseNotification == eewCollapseNotification)&&(identical(other.earthquakeEstimatedIntensityEnabled, earthquakeEstimatedIntensityEnabled) || other.earthquakeEstimatedIntensityEnabled == earthquakeEstimatedIntensityEnabled)&&(identical(other.earthquakeCollapseNotification, earthquakeCollapseNotification) || other.earthquakeCollapseNotification == earthquakeCollapseNotification));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eewDefaultSound,eewDefaultInterruptionLevel,earthquakeDefaultSound,earthquakeDefaultInterruptionLevel,startLiveActivity,eewOnePointEnabled,eewCollapseNotification,earthquakeEstimatedIntensityEnabled,earthquakeCollapseNotification);

@override
String toString() {
  return 'NotificationDefaultsRequest(eewDefaultSound: $eewDefaultSound, eewDefaultInterruptionLevel: $eewDefaultInterruptionLevel, earthquakeDefaultSound: $earthquakeDefaultSound, earthquakeDefaultInterruptionLevel: $earthquakeDefaultInterruptionLevel, startLiveActivity: $startLiveActivity, eewOnePointEnabled: $eewOnePointEnabled, eewCollapseNotification: $eewCollapseNotification, earthquakeEstimatedIntensityEnabled: $earthquakeEstimatedIntensityEnabled, earthquakeCollapseNotification: $earthquakeCollapseNotification)';
}


}

/// @nodoc
abstract mixin class _$NotificationDefaultsRequestCopyWith<$Res> implements $NotificationDefaultsRequestCopyWith<$Res> {
  factory _$NotificationDefaultsRequestCopyWith(_NotificationDefaultsRequest value, $Res Function(_NotificationDefaultsRequest) _then) = __$NotificationDefaultsRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'eew_default_sound') String? eewDefaultSound,@JsonKey(includeIfNull: false, name: 'eew_default_interruption_level') EewDefaultInterruptionLevel? eewDefaultInterruptionLevel,@JsonKey(includeIfNull: false, name: 'earthquake_default_sound') String? earthquakeDefaultSound,@JsonKey(includeIfNull: false, name: 'earthquake_default_interruption_level') EarthquakeDefaultInterruptionLevel? earthquakeDefaultInterruptionLevel,@JsonKey(includeIfNull: false, name: 'start_live_activity') bool? startLiveActivity,@JsonKey(includeIfNull: false, name: 'eew_one_point_enabled') bool? eewOnePointEnabled,@JsonKey(includeIfNull: false, name: 'eew_collapse_notification') bool? eewCollapseNotification,@JsonKey(includeIfNull: false, name: 'earthquake_estimated_intensity_enabled') bool? earthquakeEstimatedIntensityEnabled,@JsonKey(includeIfNull: false, name: 'earthquake_collapse_notification') bool? earthquakeCollapseNotification
});




}
/// @nodoc
class __$NotificationDefaultsRequestCopyWithImpl<$Res>
    implements _$NotificationDefaultsRequestCopyWith<$Res> {
  __$NotificationDefaultsRequestCopyWithImpl(this._self, this._then);

  final _NotificationDefaultsRequest _self;
  final $Res Function(_NotificationDefaultsRequest) _then;

/// Create a copy of NotificationDefaultsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eewDefaultSound = freezed,Object? eewDefaultInterruptionLevel = freezed,Object? earthquakeDefaultSound = freezed,Object? earthquakeDefaultInterruptionLevel = freezed,Object? startLiveActivity = freezed,Object? eewOnePointEnabled = freezed,Object? eewCollapseNotification = freezed,Object? earthquakeEstimatedIntensityEnabled = freezed,Object? earthquakeCollapseNotification = freezed,}) {
  return _then(_NotificationDefaultsRequest(
eewDefaultSound: freezed == eewDefaultSound ? _self.eewDefaultSound : eewDefaultSound // ignore: cast_nullable_to_non_nullable
as String?,eewDefaultInterruptionLevel: freezed == eewDefaultInterruptionLevel ? _self.eewDefaultInterruptionLevel : eewDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as EewDefaultInterruptionLevel?,earthquakeDefaultSound: freezed == earthquakeDefaultSound ? _self.earthquakeDefaultSound : earthquakeDefaultSound // ignore: cast_nullable_to_non_nullable
as String?,earthquakeDefaultInterruptionLevel: freezed == earthquakeDefaultInterruptionLevel ? _self.earthquakeDefaultInterruptionLevel : earthquakeDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as EarthquakeDefaultInterruptionLevel?,startLiveActivity: freezed == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool?,eewOnePointEnabled: freezed == eewOnePointEnabled ? _self.eewOnePointEnabled : eewOnePointEnabled // ignore: cast_nullable_to_non_nullable
as bool?,eewCollapseNotification: freezed == eewCollapseNotification ? _self.eewCollapseNotification : eewCollapseNotification // ignore: cast_nullable_to_non_nullable
as bool?,earthquakeEstimatedIntensityEnabled: freezed == earthquakeEstimatedIntensityEnabled ? _self.earthquakeEstimatedIntensityEnabled : earthquakeEstimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool?,earthquakeCollapseNotification: freezed == earthquakeCollapseNotification ? _self.earthquakeCollapseNotification : earthquakeCollapseNotification // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
