// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiSettingsResponse {

@JsonKey(name: 'notification_tiers') List<TsunamiNotificationTier> get notificationTiers;@JsonKey(name: 'start_live_activity') bool get startLiveActivity;
/// Create a copy of TsunamiSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiSettingsResponseCopyWith<TsunamiSettingsResponse> get copyWith => _$TsunamiSettingsResponseCopyWithImpl<TsunamiSettingsResponse>(this as TsunamiSettingsResponse, _$identity);

  /// Serializes this TsunamiSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiSettingsResponse&&const DeepCollectionEquality().equals(other.notificationTiers, notificationTiers)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notificationTiers),startLiveActivity);

@override
String toString() {
  return 'TsunamiSettingsResponse(notificationTiers: $notificationTiers, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class $TsunamiSettingsResponseCopyWith<$Res>  {
  factory $TsunamiSettingsResponseCopyWith(TsunamiSettingsResponse value, $Res Function(TsunamiSettingsResponse) _then) = _$TsunamiSettingsResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'notification_tiers') List<TsunamiNotificationTier> notificationTiers,@JsonKey(name: 'start_live_activity') bool startLiveActivity
});




}
/// @nodoc
class _$TsunamiSettingsResponseCopyWithImpl<$Res>
    implements $TsunamiSettingsResponseCopyWith<$Res> {
  _$TsunamiSettingsResponseCopyWithImpl(this._self, this._then);

  final TsunamiSettingsResponse _self;
  final $Res Function(TsunamiSettingsResponse) _then;

/// Create a copy of TsunamiSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationTiers = null,Object? startLiveActivity = null,}) {
  return _then(TsunamiSettingsResponse(
notificationTiers: null == notificationTiers ? _self.notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<TsunamiNotificationTier>,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiSettingsResponse].
extension TsunamiSettingsResponsePatterns on TsunamiSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'notification_tiers')  List<TsunamiNotificationTier> notificationTiers, @JsonKey(name: 'start_live_activity')  bool startLiveActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiSettingsResponse() when $default != null:
return $default(_that.notificationTiers,_that.startLiveActivity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'notification_tiers')  List<TsunamiNotificationTier> notificationTiers, @JsonKey(name: 'start_live_activity')  bool startLiveActivity)  $default,) {final _that = this;
switch (_that) {
case _TsunamiSettingsResponse():
return $default(_that.notificationTiers,_that.startLiveActivity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'notification_tiers')  List<TsunamiNotificationTier> notificationTiers, @JsonKey(name: 'start_live_activity')  bool startLiveActivity)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiSettingsResponse() when $default != null:
return $default(_that.notificationTiers,_that.startLiveActivity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiSettingsResponse implements TsunamiSettingsResponse {
  const _TsunamiSettingsResponse({@JsonKey(name: 'notification_tiers') required  List<TsunamiNotificationTier> notificationTiers, @JsonKey(name: 'start_live_activity') required this.startLiveActivity}): _notificationTiers = notificationTiers;
  factory _TsunamiSettingsResponse.fromJson(Map<String, dynamic> json) => _$TsunamiSettingsResponseFromJson(json);

 final  List<TsunamiNotificationTier> _notificationTiers;
@override@JsonKey(name: 'notification_tiers') List<TsunamiNotificationTier> get notificationTiers {
  if (_notificationTiers is EqualUnmodifiableListView) return _notificationTiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationTiers);
}

@override@JsonKey(name: 'start_live_activity') final  bool startLiveActivity;

/// Create a copy of TsunamiSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiSettingsResponseCopyWith<_TsunamiSettingsResponse> get copyWith => __$TsunamiSettingsResponseCopyWithImpl<_TsunamiSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiSettingsResponse&&const DeepCollectionEquality().equals(other._notificationTiers, _notificationTiers)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notificationTiers),startLiveActivity);

@override
String toString() {
  return 'TsunamiSettingsResponse(notificationTiers: $notificationTiers, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class _$TsunamiSettingsResponseCopyWith<$Res> implements $TsunamiSettingsResponseCopyWith<$Res> {
  factory _$TsunamiSettingsResponseCopyWith(_TsunamiSettingsResponse value, $Res Function(_TsunamiSettingsResponse) _then) = __$TsunamiSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'notification_tiers') List<TsunamiNotificationTier> notificationTiers,@JsonKey(name: 'start_live_activity') bool startLiveActivity
});




}
/// @nodoc
class __$TsunamiSettingsResponseCopyWithImpl<$Res>
    implements _$TsunamiSettingsResponseCopyWith<$Res> {
  __$TsunamiSettingsResponseCopyWithImpl(this._self, this._then);

  final _TsunamiSettingsResponse _self;
  final $Res Function(_TsunamiSettingsResponse) _then;

/// Create a copy of TsunamiSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationTiers = null,Object? startLiveActivity = null,}) {
  return _then(_TsunamiSettingsResponse(
notificationTiers: null == notificationTiers ? _self._notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<TsunamiNotificationTier>,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
