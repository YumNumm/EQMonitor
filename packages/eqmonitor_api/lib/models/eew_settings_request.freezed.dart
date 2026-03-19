// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_settings_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewSettingsRequest {

 bool get enabled;@JsonKey(name: 'notification_tiers') List<NotificationTiers4> get notificationTiers;@JsonKey(name: 'start_live_activity') bool get startLiveActivity;
/// Create a copy of EewSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewSettingsRequestCopyWith<EewSettingsRequest> get copyWith => _$EewSettingsRequestCopyWithImpl<EewSettingsRequest>(this as EewSettingsRequest, _$identity);

  /// Serializes this EewSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.notificationTiers, notificationTiers)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(notificationTiers),startLiveActivity);

@override
String toString() {
  return 'EewSettingsRequest(enabled: $enabled, notificationTiers: $notificationTiers, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class $EewSettingsRequestCopyWith<$Res>  {
  factory $EewSettingsRequestCopyWith(EewSettingsRequest value, $Res Function(EewSettingsRequest) _then) = _$EewSettingsRequestCopyWithImpl;
@useResult
$Res call({
 bool enabled,@JsonKey(name: 'notification_tiers') List<NotificationTiers4> notificationTiers,@JsonKey(name: 'start_live_activity') bool startLiveActivity
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
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? notificationTiers = null,Object? startLiveActivity = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTiers: null == notificationTiers ? _self.notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<NotificationTiers4>,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'notification_tiers')  List<NotificationTiers4> notificationTiers, @JsonKey(name: 'start_live_activity')  bool startLiveActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewSettingsRequest() when $default != null:
return $default(_that.enabled,_that.notificationTiers,_that.startLiveActivity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'notification_tiers')  List<NotificationTiers4> notificationTiers, @JsonKey(name: 'start_live_activity')  bool startLiveActivity)  $default,) {final _that = this;
switch (_that) {
case _EewSettingsRequest():
return $default(_that.enabled,_that.notificationTiers,_that.startLiveActivity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled, @JsonKey(name: 'notification_tiers')  List<NotificationTiers4> notificationTiers, @JsonKey(name: 'start_live_activity')  bool startLiveActivity)?  $default,) {final _that = this;
switch (_that) {
case _EewSettingsRequest() when $default != null:
return $default(_that.enabled,_that.notificationTiers,_that.startLiveActivity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewSettingsRequest implements EewSettingsRequest {
  const _EewSettingsRequest({required this.enabled, @JsonKey(name: 'notification_tiers') required final  List<NotificationTiers4> notificationTiers, @JsonKey(name: 'start_live_activity') required this.startLiveActivity}): _notificationTiers = notificationTiers;
  factory _EewSettingsRequest.fromJson(Map<String, dynamic> json) => _$EewSettingsRequestFromJson(json);

@override final  bool enabled;
 final  List<NotificationTiers4> _notificationTiers;
@override@JsonKey(name: 'notification_tiers') List<NotificationTiers4> get notificationTiers {
  if (_notificationTiers is EqualUnmodifiableListView) return _notificationTiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationTiers);
}

@override@JsonKey(name: 'start_live_activity') final  bool startLiveActivity;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewSettingsRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._notificationTiers, _notificationTiers)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(_notificationTiers),startLiveActivity);

@override
String toString() {
  return 'EewSettingsRequest(enabled: $enabled, notificationTiers: $notificationTiers, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class _$EewSettingsRequestCopyWith<$Res> implements $EewSettingsRequestCopyWith<$Res> {
  factory _$EewSettingsRequestCopyWith(_EewSettingsRequest value, $Res Function(_EewSettingsRequest) _then) = __$EewSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
 bool enabled,@JsonKey(name: 'notification_tiers') List<NotificationTiers4> notificationTiers,@JsonKey(name: 'start_live_activity') bool startLiveActivity
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
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? notificationTiers = null,Object? startLiveActivity = null,}) {
  return _then(_EewSettingsRequest(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTiers: null == notificationTiers ? _self._notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<NotificationTiers4>,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
