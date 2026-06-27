// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EewNotificationSettings {

 bool get enabled; bool get startLiveActivity; bool get onePointEnabled; List<NotificationRegion> get regions;
/// Create a copy of EewNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewNotificationSettingsCopyWith<EewNotificationSettings> get copyWith => _$EewNotificationSettingsCopyWithImpl<EewNotificationSettings>(this as EewNotificationSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewNotificationSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.onePointEnabled, onePointEnabled) || other.onePointEnabled == onePointEnabled)&&const DeepCollectionEquality().equals(other.regions, regions));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,startLiveActivity,onePointEnabled,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'EewNotificationSettings(enabled: $enabled, startLiveActivity: $startLiveActivity, onePointEnabled: $onePointEnabled, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $EewNotificationSettingsCopyWith<$Res>  {
  factory $EewNotificationSettingsCopyWith(EewNotificationSettings value, $Res Function(EewNotificationSettings) _then) = _$EewNotificationSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool startLiveActivity, bool onePointEnabled, List<NotificationRegion> regions
});




}
/// @nodoc
class _$EewNotificationSettingsCopyWithImpl<$Res>
    implements $EewNotificationSettingsCopyWith<$Res> {
  _$EewNotificationSettingsCopyWithImpl(this._self, this._then);

  final EewNotificationSettings _self;
  final $Res Function(EewNotificationSettings) _then;

/// Create a copy of EewNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? startLiveActivity = null,Object? onePointEnabled = null,Object? regions = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,onePointEnabled: null == onePointEnabled ? _self.onePointEnabled : onePointEnabled // ignore: cast_nullable_to_non_nullable
as bool,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<NotificationRegion>,
  ));
}

}


/// Adds pattern-matching-related methods to [EewNotificationSettings].
extension EewNotificationSettingsPatterns on EewNotificationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewNotificationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewNotificationSettings value)  $default,){
final _that = this;
switch (_that) {
case _EewNotificationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewNotificationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _EewNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  bool startLiveActivity,  bool onePointEnabled,  List<NotificationRegion> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewNotificationSettings() when $default != null:
return $default(_that.enabled,_that.startLiveActivity,_that.onePointEnabled,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  bool startLiveActivity,  bool onePointEnabled,  List<NotificationRegion> regions)  $default,) {final _that = this;
switch (_that) {
case _EewNotificationSettings():
return $default(_that.enabled,_that.startLiveActivity,_that.onePointEnabled,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  bool startLiveActivity,  bool onePointEnabled,  List<NotificationRegion> regions)?  $default,) {final _that = this;
switch (_that) {
case _EewNotificationSettings() when $default != null:
return $default(_that.enabled,_that.startLiveActivity,_that.onePointEnabled,_that.regions);case _:
  return null;

}
}

}

/// @nodoc


class _EewNotificationSettings implements EewNotificationSettings {
  const _EewNotificationSettings({required this.enabled, required this.startLiveActivity, required this.onePointEnabled, required final  List<NotificationRegion> regions}): _regions = regions;
  

@override final  bool enabled;
@override final  bool startLiveActivity;
@override final  bool onePointEnabled;
 final  List<NotificationRegion> _regions;
@override List<NotificationRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of EewNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewNotificationSettingsCopyWith<_EewNotificationSettings> get copyWith => __$EewNotificationSettingsCopyWithImpl<_EewNotificationSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewNotificationSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.startLiveActivity, startLiveActivity) || other.startLiveActivity == startLiveActivity)&&(identical(other.onePointEnabled, onePointEnabled) || other.onePointEnabled == onePointEnabled)&&const DeepCollectionEquality().equals(other._regions, _regions));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,startLiveActivity,onePointEnabled,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'EewNotificationSettings(enabled: $enabled, startLiveActivity: $startLiveActivity, onePointEnabled: $onePointEnabled, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$EewNotificationSettingsCopyWith<$Res> implements $EewNotificationSettingsCopyWith<$Res> {
  factory _$EewNotificationSettingsCopyWith(_EewNotificationSettings value, $Res Function(_EewNotificationSettings) _then) = __$EewNotificationSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool startLiveActivity, bool onePointEnabled, List<NotificationRegion> regions
});




}
/// @nodoc
class __$EewNotificationSettingsCopyWithImpl<$Res>
    implements _$EewNotificationSettingsCopyWith<$Res> {
  __$EewNotificationSettingsCopyWithImpl(this._self, this._then);

  final _EewNotificationSettings _self;
  final $Res Function(_EewNotificationSettings) _then;

/// Create a copy of EewNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? startLiveActivity = null,Object? onePointEnabled = null,Object? regions = null,}) {
  return _then(_EewNotificationSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,startLiveActivity: null == startLiveActivity ? _self.startLiveActivity : startLiveActivity // ignore: cast_nullable_to_non_nullable
as bool,onePointEnabled: null == onePointEnabled ? _self.onePointEnabled : onePointEnabled // ignore: cast_nullable_to_non_nullable
as bool,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<NotificationRegion>,
  ));
}


}

// dart format on
