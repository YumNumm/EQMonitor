// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeSettingsResponse {

 bool get enabled;@JsonKey(name: 'notification_tiers') List<NotificationTiers> get notificationTiers;@JsonKey(name: 'estimated_intensity_enabled') bool get estimatedIntensityEnabled;
/// Create a copy of EarthquakeSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSettingsResponseCopyWith<EarthquakeSettingsResponse> get copyWith => _$EarthquakeSettingsResponseCopyWithImpl<EarthquakeSettingsResponse>(this as EarthquakeSettingsResponse, _$identity);

  /// Serializes this EarthquakeSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSettingsResponse&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.notificationTiers, notificationTiers)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(notificationTiers),estimatedIntensityEnabled);

@override
String toString() {
  return 'EarthquakeSettingsResponse(enabled: $enabled, notificationTiers: $notificationTiers, estimatedIntensityEnabled: $estimatedIntensityEnabled)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSettingsResponseCopyWith<$Res>  {
  factory $EarthquakeSettingsResponseCopyWith(EarthquakeSettingsResponse value, $Res Function(EarthquakeSettingsResponse) _then) = _$EarthquakeSettingsResponseCopyWithImpl;
@useResult
$Res call({
 bool enabled,@JsonKey(name: 'notification_tiers') List<NotificationTiers> notificationTiers,@JsonKey(name: 'estimated_intensity_enabled') bool estimatedIntensityEnabled
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
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? notificationTiers = null,Object? estimatedIntensityEnabled = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTiers: null == notificationTiers ? _self.notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<NotificationTiers>,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'notification_tiers')  List<NotificationTiers> notificationTiers, @JsonKey(name: 'estimated_intensity_enabled')  bool estimatedIntensityEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeSettingsResponse() when $default != null:
return $default(_that.enabled,_that.notificationTiers,_that.estimatedIntensityEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'notification_tiers')  List<NotificationTiers> notificationTiers, @JsonKey(name: 'estimated_intensity_enabled')  bool estimatedIntensityEnabled)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSettingsResponse():
return $default(_that.enabled,_that.notificationTiers,_that.estimatedIntensityEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled, @JsonKey(name: 'notification_tiers')  List<NotificationTiers> notificationTiers, @JsonKey(name: 'estimated_intensity_enabled')  bool estimatedIntensityEnabled)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSettingsResponse() when $default != null:
return $default(_that.enabled,_that.notificationTiers,_that.estimatedIntensityEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeSettingsResponse implements EarthquakeSettingsResponse {
  const _EarthquakeSettingsResponse({required this.enabled, @JsonKey(name: 'notification_tiers') required final  List<NotificationTiers> notificationTiers, @JsonKey(name: 'estimated_intensity_enabled') required this.estimatedIntensityEnabled}): _notificationTiers = notificationTiers;
  factory _EarthquakeSettingsResponse.fromJson(Map<String, dynamic> json) => _$EarthquakeSettingsResponseFromJson(json);

@override final  bool enabled;
 final  List<NotificationTiers> _notificationTiers;
@override@JsonKey(name: 'notification_tiers') List<NotificationTiers> get notificationTiers {
  if (_notificationTiers is EqualUnmodifiableListView) return _notificationTiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationTiers);
}

@override@JsonKey(name: 'estimated_intensity_enabled') final  bool estimatedIntensityEnabled;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeSettingsResponse&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._notificationTiers, _notificationTiers)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(_notificationTiers),estimatedIntensityEnabled);

@override
String toString() {
  return 'EarthquakeSettingsResponse(enabled: $enabled, notificationTiers: $notificationTiers, estimatedIntensityEnabled: $estimatedIntensityEnabled)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeSettingsResponseCopyWith<$Res> implements $EarthquakeSettingsResponseCopyWith<$Res> {
  factory _$EarthquakeSettingsResponseCopyWith(_EarthquakeSettingsResponse value, $Res Function(_EarthquakeSettingsResponse) _then) = __$EarthquakeSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool enabled,@JsonKey(name: 'notification_tiers') List<NotificationTiers> notificationTiers,@JsonKey(name: 'estimated_intensity_enabled') bool estimatedIntensityEnabled
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
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? notificationTiers = null,Object? estimatedIntensityEnabled = null,}) {
  return _then(_EarthquakeSettingsResponse(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTiers: null == notificationTiers ? _self._notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<NotificationTiers>,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
