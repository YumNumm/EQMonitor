// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeNotificationSettings {

 bool get enabled; bool get estimatedIntensityEnabled; List<NotificationRegion> get regions;
/// Create a copy of EarthquakeNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeNotificationSettingsCopyWith<EarthquakeNotificationSettings> get copyWith => _$EarthquakeNotificationSettingsCopyWithImpl<EarthquakeNotificationSettings>(this as EarthquakeNotificationSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeNotificationSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled)&&const DeepCollectionEquality().equals(other.regions, regions));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,estimatedIntensityEnabled,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'EarthquakeNotificationSettings(enabled: $enabled, estimatedIntensityEnabled: $estimatedIntensityEnabled, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $EarthquakeNotificationSettingsCopyWith<$Res>  {
  factory $EarthquakeNotificationSettingsCopyWith(EarthquakeNotificationSettings value, $Res Function(EarthquakeNotificationSettings) _then) = _$EarthquakeNotificationSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool estimatedIntensityEnabled, List<NotificationRegion> regions
});




}
/// @nodoc
class _$EarthquakeNotificationSettingsCopyWithImpl<$Res>
    implements $EarthquakeNotificationSettingsCopyWith<$Res> {
  _$EarthquakeNotificationSettingsCopyWithImpl(this._self, this._then);

  final EarthquakeNotificationSettings _self;
  final $Res Function(EarthquakeNotificationSettings) _then;

/// Create a copy of EarthquakeNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? estimatedIntensityEnabled = null,Object? regions = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<NotificationRegion>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeNotificationSettings].
extension EarthquakeNotificationSettingsPatterns on EarthquakeNotificationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeNotificationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeNotificationSettings value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeNotificationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  bool estimatedIntensityEnabled,  List<NotificationRegion> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings() when $default != null:
return $default(_that.enabled,_that.estimatedIntensityEnabled,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  bool estimatedIntensityEnabled,  List<NotificationRegion> regions)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings():
return $default(_that.enabled,_that.estimatedIntensityEnabled,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  bool estimatedIntensityEnabled,  List<NotificationRegion> regions)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeNotificationSettings() when $default != null:
return $default(_that.enabled,_that.estimatedIntensityEnabled,_that.regions);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeNotificationSettings implements EarthquakeNotificationSettings {
  const _EarthquakeNotificationSettings({required this.enabled, required this.estimatedIntensityEnabled, required final  List<NotificationRegion> regions}): _regions = regions;
  

@override final  bool enabled;
@override final  bool estimatedIntensityEnabled;
 final  List<NotificationRegion> _regions;
@override List<NotificationRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of EarthquakeNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeNotificationSettingsCopyWith<_EarthquakeNotificationSettings> get copyWith => __$EarthquakeNotificationSettingsCopyWithImpl<_EarthquakeNotificationSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeNotificationSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.estimatedIntensityEnabled, estimatedIntensityEnabled) || other.estimatedIntensityEnabled == estimatedIntensityEnabled)&&const DeepCollectionEquality().equals(other._regions, _regions));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,estimatedIntensityEnabled,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'EarthquakeNotificationSettings(enabled: $enabled, estimatedIntensityEnabled: $estimatedIntensityEnabled, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeNotificationSettingsCopyWith<$Res> implements $EarthquakeNotificationSettingsCopyWith<$Res> {
  factory _$EarthquakeNotificationSettingsCopyWith(_EarthquakeNotificationSettings value, $Res Function(_EarthquakeNotificationSettings) _then) = __$EarthquakeNotificationSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool estimatedIntensityEnabled, List<NotificationRegion> regions
});




}
/// @nodoc
class __$EarthquakeNotificationSettingsCopyWithImpl<$Res>
    implements _$EarthquakeNotificationSettingsCopyWith<$Res> {
  __$EarthquakeNotificationSettingsCopyWithImpl(this._self, this._then);

  final _EarthquakeNotificationSettings _self;
  final $Res Function(_EarthquakeNotificationSettings) _then;

/// Create a copy of EarthquakeNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? estimatedIntensityEnabled = null,Object? regions = null,}) {
  return _then(_EarthquakeNotificationSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,estimatedIntensityEnabled: null == estimatedIntensityEnabled ? _self.estimatedIntensityEnabled : estimatedIntensityEnabled // ignore: cast_nullable_to_non_nullable
as bool,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<NotificationRegion>,
  ));
}


}

// dart format on
