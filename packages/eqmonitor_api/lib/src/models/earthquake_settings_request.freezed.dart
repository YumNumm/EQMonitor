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

@JsonKey(includeIfNull: false) bool? get enabled;@JsonKey(includeIfNull: false, name: 'notification_tiers') List<NotificationTier>? get notificationTiers;@JsonKey(includeIfNull: false, name: 'estimated_intensity_enabled') bool? get estimatedIntensityEnabled;@JsonKey(includeIfNull: false, name: 'collapse_notification') bool? get collapseNotification;
/// Create a copy of EarthquakeSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSettingsRequestCopyWith<EarthquakeSettingsRequest> get copyWith => _$EarthquakeSettingsRequestCopyWithImpl<EarthquakeSettingsRequest>(this as EarthquakeSettingsRequest, _$identity);

  /// Serializes this EarthquakeSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.notificationTiers, notificationTiers)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled)&&(identical(other.collapseNotification, collapseNotification) || other.collapseNotification == collapseNotification));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(notificationTiers),estimatedIntensityEnabled,collapseNotification);

@override
String toString() {
  return 'EarthquakeSettingsRequest(enabled: $enabled, notificationTiers: $notificationTiers, estimatedIntensityEnabled: $estimatedIntensityEnabled, collapseNotification: $collapseNotification)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSettingsRequestCopyWith<$Res>  {
  factory $EarthquakeSettingsRequestCopyWith(EarthquakeSettingsRequest value, $Res Function(EarthquakeSettingsRequest) _then) = _$EarthquakeSettingsRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) bool? enabled,@JsonKey(includeIfNull: false, name: 'notification_tiers') List<NotificationTier>? notificationTiers,@JsonKey(includeIfNull: false, name: 'estimated_intensity_enabled') bool? estimatedIntensityEnabled,@JsonKey(includeIfNull: false, name: 'collapse_notification') bool? collapseNotification
});




}
/// @nodoc
class _$EarthquakeSettingsRequestCopyWithImpl<$Res>
    implements $EarthquakeSettingsRequestCopyWith<$Res> {
  _$EarthquakeSettingsRequestCopyWithImpl(this._self, this._then);

  final EarthquakeSettingsRequest _self;
  final $Res Function(EarthquakeSettingsRequest) _then;

/// Create a copy of EarthquakeSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = freezed,Object? notificationTiers = freezed,Object? estimatedIntensityEnabled = freezed,Object? collapseNotification = freezed,}) {
  return _then(_self.copyWith(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,notificationTiers: freezed == notificationTiers ? _self.notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<NotificationTier>?,estimatedIntensityEnabled: freezed == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool?,collapseNotification: freezed == collapseNotification ? _self.collapseNotification : collapseNotification // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  bool? enabled, @JsonKey(includeIfNull: false, name: 'notification_tiers')  List<NotificationTier>? notificationTiers, @JsonKey(includeIfNull: false, name: 'estimated_intensity_enabled')  bool? estimatedIntensityEnabled, @JsonKey(includeIfNull: false, name: 'collapse_notification')  bool? collapseNotification)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeSettingsRequest() when $default != null:
return $default(_that.enabled,_that.notificationTiers,_that.estimatedIntensityEnabled,_that.collapseNotification);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  bool? enabled, @JsonKey(includeIfNull: false, name: 'notification_tiers')  List<NotificationTier>? notificationTiers, @JsonKey(includeIfNull: false, name: 'estimated_intensity_enabled')  bool? estimatedIntensityEnabled, @JsonKey(includeIfNull: false, name: 'collapse_notification')  bool? collapseNotification)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSettingsRequest():
return $default(_that.enabled,_that.notificationTiers,_that.estimatedIntensityEnabled,_that.collapseNotification);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  bool? enabled, @JsonKey(includeIfNull: false, name: 'notification_tiers')  List<NotificationTier>? notificationTiers, @JsonKey(includeIfNull: false, name: 'estimated_intensity_enabled')  bool? estimatedIntensityEnabled, @JsonKey(includeIfNull: false, name: 'collapse_notification')  bool? collapseNotification)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSettingsRequest() when $default != null:
return $default(_that.enabled,_that.notificationTiers,_that.estimatedIntensityEnabled,_that.collapseNotification);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeSettingsRequest implements EarthquakeSettingsRequest {
  const _EarthquakeSettingsRequest({@JsonKey(includeIfNull: false) this.enabled, @JsonKey(includeIfNull: false, name: 'notification_tiers') final  List<NotificationTier>? notificationTiers, @JsonKey(includeIfNull: false, name: 'estimated_intensity_enabled') this.estimatedIntensityEnabled, @JsonKey(includeIfNull: false, name: 'collapse_notification') this.collapseNotification}): _notificationTiers = notificationTiers;
  factory _EarthquakeSettingsRequest.fromJson(Map<String, dynamic> json) => _$EarthquakeSettingsRequestFromJson(json);

@override@JsonKey(includeIfNull: false) final  bool? enabled;
 final  List<NotificationTier>? _notificationTiers;
@override@JsonKey(includeIfNull: false, name: 'notification_tiers') List<NotificationTier>? get notificationTiers {
  final value = _notificationTiers;
  if (value == null) return null;
  if (_notificationTiers is EqualUnmodifiableListView) return _notificationTiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false, name: 'estimated_intensity_enabled') final  bool? estimatedIntensityEnabled;
@override@JsonKey(includeIfNull: false, name: 'collapse_notification') final  bool? collapseNotification;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._notificationTiers, _notificationTiers)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled)&&(identical(other.collapseNotification, collapseNotification) || other.collapseNotification == collapseNotification));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(_notificationTiers),estimatedIntensityEnabled,collapseNotification);

@override
String toString() {
  return 'EarthquakeSettingsRequest(enabled: $enabled, notificationTiers: $notificationTiers, estimatedIntensityEnabled: $estimatedIntensityEnabled, collapseNotification: $collapseNotification)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeSettingsRequestCopyWith<$Res> implements $EarthquakeSettingsRequestCopyWith<$Res> {
  factory _$EarthquakeSettingsRequestCopyWith(_EarthquakeSettingsRequest value, $Res Function(_EarthquakeSettingsRequest) _then) = __$EarthquakeSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) bool? enabled,@JsonKey(includeIfNull: false, name: 'notification_tiers') List<NotificationTier>? notificationTiers,@JsonKey(includeIfNull: false, name: 'estimated_intensity_enabled') bool? estimatedIntensityEnabled,@JsonKey(includeIfNull: false, name: 'collapse_notification') bool? collapseNotification
});




}
/// @nodoc
class __$EarthquakeSettingsRequestCopyWithImpl<$Res>
    implements _$EarthquakeSettingsRequestCopyWith<$Res> {
  __$EarthquakeSettingsRequestCopyWithImpl(this._self, this._then);

  final _EarthquakeSettingsRequest _self;
  final $Res Function(_EarthquakeSettingsRequest) _then;

/// Create a copy of EarthquakeSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = freezed,Object? notificationTiers = freezed,Object? estimatedIntensityEnabled = freezed,Object? collapseNotification = freezed,}) {
  return _then(_EarthquakeSettingsRequest(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,notificationTiers: freezed == notificationTiers ? _self._notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<NotificationTier>?,estimatedIntensityEnabled: freezed == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool?,collapseNotification: freezed == collapseNotification ? _self.collapseNotification : collapseNotification // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
