// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_settings_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiSettingsRequest {

@JsonKey(includeIfNull: false, name: 'notification_tiers') List<TsunamiNotificationTier>? get notificationTiers;@JsonKey(includeIfNull: false, name: 'start_live_activity') bool? get startLiveActivity;
/// Create a copy of TsunamiSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiSettingsRequestCopyWith<TsunamiSettingsRequest> get copyWith => _$TsunamiSettingsRequestCopyWithImpl<TsunamiSettingsRequest>(this as TsunamiSettingsRequest, _$identity);

  /// Serializes this TsunamiSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiSettingsRequest&&const DeepCollectionEquality().equals(other.notificationTiers, notificationTiers)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notificationTiers),startLiveActivity);

@override
String toString() {
  return 'TsunamiSettingsRequest(notificationTiers: $notificationTiers, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class $TsunamiSettingsRequestCopyWith<$Res>  {
  factory $TsunamiSettingsRequestCopyWith(TsunamiSettingsRequest value, $Res Function(TsunamiSettingsRequest) _then) = _$TsunamiSettingsRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'notification_tiers') List<TsunamiNotificationTier>? notificationTiers,@JsonKey(includeIfNull: false, name: 'start_live_activity') bool? startLiveActivity
});




}
/// @nodoc
class _$TsunamiSettingsRequestCopyWithImpl<$Res>
    implements $TsunamiSettingsRequestCopyWith<$Res> {
  _$TsunamiSettingsRequestCopyWithImpl(this._self, this._then);

  final TsunamiSettingsRequest _self;
  final $Res Function(TsunamiSettingsRequest) _then;

/// Create a copy of TsunamiSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationTiers = freezed,Object? startLiveActivity = freezed,}) {
  return _then(TsunamiSettingsRequest(
notificationTiers: freezed == notificationTiers ? _self.notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<TsunamiNotificationTier>?,startLiveActivity: freezed == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiSettingsRequest].
extension TsunamiSettingsRequestPatterns on TsunamiSettingsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiSettingsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiSettingsRequest value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiSettingsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiSettingsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'notification_tiers')  List<TsunamiNotificationTier>? notificationTiers, @JsonKey(includeIfNull: false, name: 'start_live_activity')  bool? startLiveActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'notification_tiers')  List<TsunamiNotificationTier>? notificationTiers, @JsonKey(includeIfNull: false, name: 'start_live_activity')  bool? startLiveActivity)  $default,) {final _that = this;
switch (_that) {
case _TsunamiSettingsRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'notification_tiers')  List<TsunamiNotificationTier>? notificationTiers, @JsonKey(includeIfNull: false, name: 'start_live_activity')  bool? startLiveActivity)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiSettingsRequest() when $default != null:
return $default(_that.notificationTiers,_that.startLiveActivity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiSettingsRequest implements TsunamiSettingsRequest {
  const _TsunamiSettingsRequest({@JsonKey(includeIfNull: false, name: 'notification_tiers')  List<TsunamiNotificationTier>? notificationTiers, @JsonKey(includeIfNull: false, name: 'start_live_activity') this.startLiveActivity}): _notificationTiers = notificationTiers;
  factory _TsunamiSettingsRequest.fromJson(Map<String, dynamic> json) => _$TsunamiSettingsRequestFromJson(json);

 final  List<TsunamiNotificationTier>? _notificationTiers;
@override@JsonKey(includeIfNull: false, name: 'notification_tiers') List<TsunamiNotificationTier>? get notificationTiers {
  final value = _notificationTiers;
  if (value == null) return null;
  if (_notificationTiers is EqualUnmodifiableListView) return _notificationTiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false, name: 'start_live_activity') final  bool? startLiveActivity;

/// Create a copy of TsunamiSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiSettingsRequestCopyWith<_TsunamiSettingsRequest> get copyWith => __$TsunamiSettingsRequestCopyWithImpl<_TsunamiSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiSettingsRequest&&const DeepCollectionEquality().equals(other._notificationTiers, _notificationTiers)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notificationTiers),startLiveActivity);

@override
String toString() {
  return 'TsunamiSettingsRequest(notificationTiers: $notificationTiers, startLiveActivity: $startLiveActivity)';
}


}

/// @nodoc
abstract mixin class _$TsunamiSettingsRequestCopyWith<$Res> implements $TsunamiSettingsRequestCopyWith<$Res> {
  factory _$TsunamiSettingsRequestCopyWith(_TsunamiSettingsRequest value, $Res Function(_TsunamiSettingsRequest) _then) = __$TsunamiSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'notification_tiers') List<TsunamiNotificationTier>? notificationTiers,@JsonKey(includeIfNull: false, name: 'start_live_activity') bool? startLiveActivity
});




}
/// @nodoc
class __$TsunamiSettingsRequestCopyWithImpl<$Res>
    implements _$TsunamiSettingsRequestCopyWith<$Res> {
  __$TsunamiSettingsRequestCopyWithImpl(this._self, this._then);

  final _TsunamiSettingsRequest _self;
  final $Res Function(_TsunamiSettingsRequest) _then;

/// Create a copy of TsunamiSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationTiers = freezed,Object? startLiveActivity = freezed,}) {
  return _then(_TsunamiSettingsRequest(
notificationTiers: freezed == notificationTiers ? _self._notificationTiers : notificationTiers // ignore: cast_nullable_to_non_nullable
as List<TsunamiNotificationTier>?,startLiveActivity: freezed == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
