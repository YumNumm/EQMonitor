// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewSettingsResponse {

 bool get enabled;@JsonKey(name: 'notification_tiers') List<NotificationTier> get notificationTiers;@JsonKey(name: 'start_live_activity') bool get startLiveActivity;@JsonKey(name: 'one_point_enabled') bool get onePointEnabled;
/// Create a copy of EewSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewSettingsResponseCopyWith<EewSettingsResponse> get copyWith => _$EewSettingsResponseCopyWithImpl<EewSettingsResponse>(this as EewSettingsResponse, _$identity);

  /// Serializes this EewSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewSettingsResponse&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.notificationTiers, notificationTiers)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.onePointEnabled, onePointEnabled) || other.onePointEnabled == onePointEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(notificationTiers),startLiveActivity,onePointEnabled);

@override
String toString() {
  return 'EewSettingsResponse(enabled: $enabled, notificationTiers: $notificationTiers, startLiveActivity: $startLiveActivity, onePointEnabled: $onePointEnabled)';
}


}

/// @nodoc
abstract mixin class $EewSettingsResponseCopyWith<$Res>  {
  factory $EewSettingsResponseCopyWith(EewSettingsResponse value, $Res Function(EewSettingsResponse) _then) = _$EewSettingsResponseCopyWithImpl;
@useResult
$Res call({
 bool enabled,@JsonKey(name: 'notification_tiers') List<NotificationTier> notificationTiers,@JsonKey(name: 'start_live_activity') bool startLiveActivity,@JsonKey(name: 'one_point_enabled') bool onePointEnabled
});




}
/// @nodoc
class _$EewSettingsResponseCopyWithImpl<$Res>
    implements $EewSettingsResponseCopyWith<$Res> {
  _$EewSettingsResponseCopyWithImpl(this._self, this._then);

  final EewSettingsResponse _self;
  final $Res Function(EewSettingsResponse) _then;

/// Create a copy of EewSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? notificationTiers = null,Object? startLiveActivity = null,Object? onePointEnabled = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTiers: null == notificationTiers ? _self.notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<NotificationTier>,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,onePointEnabled: null == onePointEnabled ? _self.onePointEnabled : onePointEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewSettingsResponse].
extension EewSettingsResponsePatterns on EewSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _EewSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EewSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'notification_tiers')  List<NotificationTier> notificationTiers, @JsonKey(name: 'start_live_activity')  bool startLiveActivity, @JsonKey(name: 'one_point_enabled')  bool onePointEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewSettingsResponse() when $default != null:
return $default(_that.enabled,_that.notificationTiers,_that.startLiveActivity,_that.onePointEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'notification_tiers')  List<NotificationTier> notificationTiers, @JsonKey(name: 'start_live_activity')  bool startLiveActivity, @JsonKey(name: 'one_point_enabled')  bool onePointEnabled)  $default,) {final _that = this;
switch (_that) {
case _EewSettingsResponse():
return $default(_that.enabled,_that.notificationTiers,_that.startLiveActivity,_that.onePointEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled, @JsonKey(name: 'notification_tiers')  List<NotificationTier> notificationTiers, @JsonKey(name: 'start_live_activity')  bool startLiveActivity, @JsonKey(name: 'one_point_enabled')  bool onePointEnabled)?  $default,) {final _that = this;
switch (_that) {
case _EewSettingsResponse() when $default != null:
return $default(_that.enabled,_that.notificationTiers,_that.startLiveActivity,_that.onePointEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewSettingsResponse implements EewSettingsResponse {
  const _EewSettingsResponse({required this.enabled, @JsonKey(name: 'notification_tiers') required final  List<NotificationTier> notificationTiers, @JsonKey(name: 'start_live_activity') required this.startLiveActivity, @JsonKey(name: 'one_point_enabled') required this.onePointEnabled}): _notificationTiers = notificationTiers;
  factory _EewSettingsResponse.fromJson(Map<String, dynamic> json) => _$EewSettingsResponseFromJson(json);

@override final  bool enabled;
 final  List<NotificationTier> _notificationTiers;
@override@JsonKey(name: 'notification_tiers') List<NotificationTier> get notificationTiers {
  if (_notificationTiers is EqualUnmodifiableListView) return _notificationTiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationTiers);
}

@override@JsonKey(name: 'start_live_activity') final  bool startLiveActivity;
@override@JsonKey(name: 'one_point_enabled') final  bool onePointEnabled;

/// Create a copy of EewSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewSettingsResponseCopyWith<_EewSettingsResponse> get copyWith => __$EewSettingsResponseCopyWithImpl<_EewSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewSettingsResponse&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._notificationTiers, _notificationTiers)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.onePointEnabled, onePointEnabled) || other.onePointEnabled == onePointEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(_notificationTiers),startLiveActivity,onePointEnabled);

@override
String toString() {
  return 'EewSettingsResponse(enabled: $enabled, notificationTiers: $notificationTiers, startLiveActivity: $startLiveActivity, onePointEnabled: $onePointEnabled)';
}


}

/// @nodoc
abstract mixin class _$EewSettingsResponseCopyWith<$Res> implements $EewSettingsResponseCopyWith<$Res> {
  factory _$EewSettingsResponseCopyWith(_EewSettingsResponse value, $Res Function(_EewSettingsResponse) _then) = __$EewSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool enabled,@JsonKey(name: 'notification_tiers') List<NotificationTier> notificationTiers,@JsonKey(name: 'start_live_activity') bool startLiveActivity,@JsonKey(name: 'one_point_enabled') bool onePointEnabled
});




}
/// @nodoc
class __$EewSettingsResponseCopyWithImpl<$Res>
    implements _$EewSettingsResponseCopyWith<$Res> {
  __$EewSettingsResponseCopyWithImpl(this._self, this._then);

  final _EewSettingsResponse _self;
  final $Res Function(_EewSettingsResponse) _then;

/// Create a copy of EewSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? notificationTiers = null,Object? startLiveActivity = null,Object? onePointEnabled = null,}) {
  return _then(_EewSettingsResponse(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTiers: null == notificationTiers ? _self._notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<NotificationTier>,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,onePointEnabled: null == onePointEnabled ? _self.onePointEnabled : onePointEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
