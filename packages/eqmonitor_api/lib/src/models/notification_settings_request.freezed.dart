// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettingsRequest {

@JsonKey(includeIfNull: false, name: 'notification_enabled') bool? get notificationEnabled;@JsonKey(includeIfNull: false, name: 'tsunami_enabled') bool? get tsunamiEnabled;@JsonKey(includeIfNull: false, name: 'training_enabled') bool? get trainingEnabled;@JsonKey(includeIfNull: false, name: 'nankai_extraordinary_enabled') bool? get nankaiExtraordinaryEnabled;@JsonKey(includeIfNull: false, name: 'nankai_regular_enabled') bool? get nankaiRegularEnabled;@JsonKey(includeIfNull: false, name: 'vyse60_enabled') bool? get vyse60Enabled;@JsonKey(includeIfNull: false, name: 'earthquake_notice_enabled') bool? get earthquakeNoticeEnabled;
/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsRequestCopyWith<NotificationSettingsRequest> get copyWith => _$NotificationSettingsRequestCopyWithImpl<NotificationSettingsRequest>(this as NotificationSettingsRequest, _$identity);

  /// Serializes this NotificationSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsRequest&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.tsunamiEnabled, tsunamiEnabled) || other.tsunamiEnabled == tsunamiEnabled)&&(identical(other.trainingEnabled, trainingEnabled) || other.trainingEnabled == trainingEnabled)&&(identical(other.nankaiExtraordinaryEnabled, nankaiExtraordinaryEnabled) || other.nankaiExtraordinaryEnabled == nankaiExtraordinaryEnabled)&&(identical(other.nankaiRegularEnabled, nankaiRegularEnabled) || other.nankaiRegularEnabled == nankaiRegularEnabled)&&(identical(other.vyse60Enabled, vyse60Enabled) || other.vyse60Enabled == vyse60Enabled)&&(identical(other.earthquakeNoticeEnabled, earthquakeNoticeEnabled) || other.earthquakeNoticeEnabled == earthquakeNoticeEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationEnabled,tsunamiEnabled,trainingEnabled,nankaiExtraordinaryEnabled,nankaiRegularEnabled,vyse60Enabled,earthquakeNoticeEnabled);

@override
String toString() {
  return 'NotificationSettingsRequest(notificationEnabled: $notificationEnabled, tsunamiEnabled: $tsunamiEnabled, trainingEnabled: $trainingEnabled, nankaiExtraordinaryEnabled: $nankaiExtraordinaryEnabled, nankaiRegularEnabled: $nankaiRegularEnabled, vyse60Enabled: $vyse60Enabled, earthquakeNoticeEnabled: $earthquakeNoticeEnabled)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsRequestCopyWith<$Res>  {
  factory $NotificationSettingsRequestCopyWith(NotificationSettingsRequest value, $Res Function(NotificationSettingsRequest) _then) = _$NotificationSettingsRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'notification_enabled') bool? notificationEnabled,@JsonKey(includeIfNull: false, name: 'tsunami_enabled') bool? tsunamiEnabled,@JsonKey(includeIfNull: false, name: 'training_enabled') bool? trainingEnabled,@JsonKey(includeIfNull: false, name: 'nankai_extraordinary_enabled') bool? nankaiExtraordinaryEnabled,@JsonKey(includeIfNull: false, name: 'nankai_regular_enabled') bool? nankaiRegularEnabled,@JsonKey(includeIfNull: false, name: 'vyse60_enabled') bool? vyse60Enabled,@JsonKey(includeIfNull: false, name: 'earthquake_notice_enabled') bool? earthquakeNoticeEnabled
});




}
/// @nodoc
class _$NotificationSettingsRequestCopyWithImpl<$Res>
    implements $NotificationSettingsRequestCopyWith<$Res> {
  _$NotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final NotificationSettingsRequest _self;
  final $Res Function(NotificationSettingsRequest) _then;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationEnabled = freezed,Object? tsunamiEnabled = freezed,Object? trainingEnabled = freezed,Object? nankaiExtraordinaryEnabled = freezed,Object? nankaiRegularEnabled = freezed,Object? vyse60Enabled = freezed,Object? earthquakeNoticeEnabled = freezed,}) {
  return _then(_self.copyWith(
notificationEnabled: freezed == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool?,tsunamiEnabled: freezed == tsunamiEnabled ? _self.tsunamiEnabled : tsunamiEnabled // ignore: cast_nullable_to_non_nullable
as bool?,trainingEnabled: freezed == trainingEnabled ? _self.trainingEnabled : trainingEnabled // ignore: cast_nullable_to_non_nullable
as bool?,nankaiExtraordinaryEnabled: freezed == nankaiExtraordinaryEnabled ? _self.nankaiExtraordinaryEnabled : nankaiExtraordinaryEnabled // ignore: cast_nullable_to_non_nullable
as bool?,nankaiRegularEnabled: freezed == nankaiRegularEnabled ? _self.nankaiRegularEnabled : nankaiRegularEnabled // ignore: cast_nullable_to_non_nullable
as bool?,vyse60Enabled: freezed == vyse60Enabled ? _self.vyse60Enabled : vyse60Enabled // ignore: cast_nullable_to_non_nullable
as bool?,earthquakeNoticeEnabled: freezed == earthquakeNoticeEnabled ? _self.earthquakeNoticeEnabled : earthquakeNoticeEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSettingsRequest].
extension NotificationSettingsRequestPatterns on NotificationSettingsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSettingsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSettingsRequest value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSettingsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'notification_enabled')  bool? notificationEnabled, @JsonKey(includeIfNull: false, name: 'tsunami_enabled')  bool? tsunamiEnabled, @JsonKey(includeIfNull: false, name: 'training_enabled')  bool? trainingEnabled, @JsonKey(includeIfNull: false, name: 'nankai_extraordinary_enabled')  bool? nankaiExtraordinaryEnabled, @JsonKey(includeIfNull: false, name: 'nankai_regular_enabled')  bool? nankaiRegularEnabled, @JsonKey(includeIfNull: false, name: 'vyse60_enabled')  bool? vyse60Enabled, @JsonKey(includeIfNull: false, name: 'earthquake_notice_enabled')  bool? earthquakeNoticeEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'notification_enabled')  bool? notificationEnabled, @JsonKey(includeIfNull: false, name: 'tsunami_enabled')  bool? tsunamiEnabled, @JsonKey(includeIfNull: false, name: 'training_enabled')  bool? trainingEnabled, @JsonKey(includeIfNull: false, name: 'nankai_extraordinary_enabled')  bool? nankaiExtraordinaryEnabled, @JsonKey(includeIfNull: false, name: 'nankai_regular_enabled')  bool? nankaiRegularEnabled, @JsonKey(includeIfNull: false, name: 'vyse60_enabled')  bool? vyse60Enabled, @JsonKey(includeIfNull: false, name: 'earthquake_notice_enabled')  bool? earthquakeNoticeEnabled)  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'notification_enabled')  bool? notificationEnabled, @JsonKey(includeIfNull: false, name: 'tsunami_enabled')  bool? tsunamiEnabled, @JsonKey(includeIfNull: false, name: 'training_enabled')  bool? trainingEnabled, @JsonKey(includeIfNull: false, name: 'nankai_extraordinary_enabled')  bool? nankaiExtraordinaryEnabled, @JsonKey(includeIfNull: false, name: 'nankai_regular_enabled')  bool? nankaiRegularEnabled, @JsonKey(includeIfNull: false, name: 'vyse60_enabled')  bool? vyse60Enabled, @JsonKey(includeIfNull: false, name: 'earthquake_notice_enabled')  bool? earthquakeNoticeEnabled)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
return $default(_that.notificationEnabled,_that.tsunamiEnabled,_that.trainingEnabled,_that.nankaiExtraordinaryEnabled,_that.nankaiRegularEnabled,_that.vyse60Enabled,_that.earthquakeNoticeEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSettingsRequest implements NotificationSettingsRequest {
  const _NotificationSettingsRequest({@JsonKey(includeIfNull: false, name: 'notification_enabled') this.notificationEnabled, @JsonKey(includeIfNull: false, name: 'tsunami_enabled') this.tsunamiEnabled, @JsonKey(includeIfNull: false, name: 'training_enabled') this.trainingEnabled, @JsonKey(includeIfNull: false, name: 'nankai_extraordinary_enabled') this.nankaiExtraordinaryEnabled, @JsonKey(includeIfNull: false, name: 'nankai_regular_enabled') this.nankaiRegularEnabled, @JsonKey(includeIfNull: false, name: 'vyse60_enabled') this.vyse60Enabled, @JsonKey(includeIfNull: false, name: 'earthquake_notice_enabled') this.earthquakeNoticeEnabled});
  factory _NotificationSettingsRequest.fromJson(Map<String, dynamic> json) => _$NotificationSettingsRequestFromJson(json);

@override@JsonKey(includeIfNull: false, name: 'notification_enabled') final  bool? notificationEnabled;
@override@JsonKey(includeIfNull: false, name: 'tsunami_enabled') final  bool? tsunamiEnabled;
@override@JsonKey(includeIfNull: false, name: 'training_enabled') final  bool? trainingEnabled;
@override@JsonKey(includeIfNull: false, name: 'nankai_extraordinary_enabled') final  bool? nankaiExtraordinaryEnabled;
@override@JsonKey(includeIfNull: false, name: 'nankai_regular_enabled') final  bool? nankaiRegularEnabled;
@override@JsonKey(includeIfNull: false, name: 'vyse60_enabled') final  bool? vyse60Enabled;
@override@JsonKey(includeIfNull: false, name: 'earthquake_notice_enabled') final  bool? earthquakeNoticeEnabled;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsRequestCopyWith<_NotificationSettingsRequest> get copyWith => __$NotificationSettingsRequestCopyWithImpl<_NotificationSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsRequest&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.tsunamiEnabled, tsunamiEnabled) || other.tsunamiEnabled == tsunamiEnabled)&&(identical(other.trainingEnabled, trainingEnabled) || other.trainingEnabled == trainingEnabled)&&(identical(other.nankaiExtraordinaryEnabled, nankaiExtraordinaryEnabled) || other.nankaiExtraordinaryEnabled == nankaiExtraordinaryEnabled)&&(identical(other.nankaiRegularEnabled, nankaiRegularEnabled) || other.nankaiRegularEnabled == nankaiRegularEnabled)&&(identical(other.vyse60Enabled, vyse60Enabled) || other.vyse60Enabled == vyse60Enabled)&&(identical(other.earthquakeNoticeEnabled, earthquakeNoticeEnabled) || other.earthquakeNoticeEnabled == earthquakeNoticeEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationEnabled,tsunamiEnabled,trainingEnabled,nankaiExtraordinaryEnabled,nankaiRegularEnabled,vyse60Enabled,earthquakeNoticeEnabled);

@override
String toString() {
  return 'NotificationSettingsRequest(notificationEnabled: $notificationEnabled, tsunamiEnabled: $tsunamiEnabled, trainingEnabled: $trainingEnabled, nankaiExtraordinaryEnabled: $nankaiExtraordinaryEnabled, nankaiRegularEnabled: $nankaiRegularEnabled, vyse60Enabled: $vyse60Enabled, earthquakeNoticeEnabled: $earthquakeNoticeEnabled)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsRequestCopyWith<$Res> implements $NotificationSettingsRequestCopyWith<$Res> {
  factory _$NotificationSettingsRequestCopyWith(_NotificationSettingsRequest value, $Res Function(_NotificationSettingsRequest) _then) = __$NotificationSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'notification_enabled') bool? notificationEnabled,@JsonKey(includeIfNull: false, name: 'tsunami_enabled') bool? tsunamiEnabled,@JsonKey(includeIfNull: false, name: 'training_enabled') bool? trainingEnabled,@JsonKey(includeIfNull: false, name: 'nankai_extraordinary_enabled') bool? nankaiExtraordinaryEnabled,@JsonKey(includeIfNull: false, name: 'nankai_regular_enabled') bool? nankaiRegularEnabled,@JsonKey(includeIfNull: false, name: 'vyse60_enabled') bool? vyse60Enabled,@JsonKey(includeIfNull: false, name: 'earthquake_notice_enabled') bool? earthquakeNoticeEnabled
});




}
/// @nodoc
class __$NotificationSettingsRequestCopyWithImpl<$Res>
    implements _$NotificationSettingsRequestCopyWith<$Res> {
  __$NotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final _NotificationSettingsRequest _self;
  final $Res Function(_NotificationSettingsRequest) _then;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationEnabled = freezed,Object? tsunamiEnabled = freezed,Object? trainingEnabled = freezed,Object? nankaiExtraordinaryEnabled = freezed,Object? nankaiRegularEnabled = freezed,Object? vyse60Enabled = freezed,Object? earthquakeNoticeEnabled = freezed,}) {
  return _then(_NotificationSettingsRequest(
notificationEnabled: freezed == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool?,tsunamiEnabled: freezed == tsunamiEnabled ? _self.tsunamiEnabled : tsunamiEnabled // ignore: cast_nullable_to_non_nullable
as bool?,trainingEnabled: freezed == trainingEnabled ? _self.trainingEnabled : trainingEnabled // ignore: cast_nullable_to_non_nullable
as bool?,nankaiExtraordinaryEnabled: freezed == nankaiExtraordinaryEnabled ? _self.nankaiExtraordinaryEnabled : nankaiExtraordinaryEnabled // ignore: cast_nullable_to_non_nullable
as bool?,nankaiRegularEnabled: freezed == nankaiRegularEnabled ? _self.nankaiRegularEnabled : nankaiRegularEnabled // ignore: cast_nullable_to_non_nullable
as bool?,vyse60Enabled: freezed == vyse60Enabled ? _self.vyse60Enabled : vyse60Enabled // ignore: cast_nullable_to_non_nullable
as bool?,earthquakeNoticeEnabled: freezed == earthquakeNoticeEnabled ? _self.earthquakeNoticeEnabled : earthquakeNoticeEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
