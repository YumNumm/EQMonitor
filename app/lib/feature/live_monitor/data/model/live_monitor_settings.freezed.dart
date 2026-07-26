// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_monitor_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveMonitorSettings {

 LiveMonitorDisplayMode get displayMode; int get earthquakeDisplaySeconds; bool get keepScreenAwake; double get portraitRealtimeRatio; double get landscapeRealtimeRatio;
/// Create a copy of LiveMonitorSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorSettingsCopyWith<LiveMonitorSettings> get copyWith => _$LiveMonitorSettingsCopyWithImpl<LiveMonitorSettings>(this as LiveMonitorSettings, _$identity);

  /// Serializes this LiveMonitorSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorSettings&&(identical(other.displayMode, displayMode) || other.displayMode == displayMode)&&(identical(other.earthquakeDisplaySeconds, earthquakeDisplaySeconds) || other.earthquakeDisplaySeconds == earthquakeDisplaySeconds)&&(identical(other.keepScreenAwake, keepScreenAwake) || other.keepScreenAwake == keepScreenAwake)&&(identical(other.portraitRealtimeRatio, portraitRealtimeRatio) || other.portraitRealtimeRatio == portraitRealtimeRatio)&&(identical(other.landscapeRealtimeRatio, landscapeRealtimeRatio) || other.landscapeRealtimeRatio == landscapeRealtimeRatio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayMode,earthquakeDisplaySeconds,keepScreenAwake,portraitRealtimeRatio,landscapeRealtimeRatio);

@override
String toString() {
  return 'LiveMonitorSettings(displayMode: $displayMode, earthquakeDisplaySeconds: $earthquakeDisplaySeconds, keepScreenAwake: $keepScreenAwake, portraitRealtimeRatio: $portraitRealtimeRatio, landscapeRealtimeRatio: $landscapeRealtimeRatio)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorSettingsCopyWith<$Res>  {
  factory $LiveMonitorSettingsCopyWith(LiveMonitorSettings value, $Res Function(LiveMonitorSettings) _then) = _$LiveMonitorSettingsCopyWithImpl;
@useResult
$Res call({
 LiveMonitorDisplayMode displayMode, int earthquakeDisplaySeconds, bool keepScreenAwake, double portraitRealtimeRatio, double landscapeRealtimeRatio
});




}
/// @nodoc
class _$LiveMonitorSettingsCopyWithImpl<$Res>
    implements $LiveMonitorSettingsCopyWith<$Res> {
  _$LiveMonitorSettingsCopyWithImpl(this._self, this._then);

  final LiveMonitorSettings _self;
  final $Res Function(LiveMonitorSettings) _then;

/// Create a copy of LiveMonitorSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayMode = null,Object? earthquakeDisplaySeconds = null,Object? keepScreenAwake = null,Object? portraitRealtimeRatio = null,Object? landscapeRealtimeRatio = null,}) {
  return _then(_self.copyWith(
displayMode: null == displayMode ? _self.displayMode : displayMode // ignore: cast_nullable_to_non_nullable
as LiveMonitorDisplayMode,earthquakeDisplaySeconds: null == earthquakeDisplaySeconds ? _self.earthquakeDisplaySeconds : earthquakeDisplaySeconds // ignore: cast_nullable_to_non_nullable
as int,keepScreenAwake: null == keepScreenAwake ? _self.keepScreenAwake : keepScreenAwake // ignore: cast_nullable_to_non_nullable
as bool,portraitRealtimeRatio: null == portraitRealtimeRatio ? _self.portraitRealtimeRatio : portraitRealtimeRatio // ignore: cast_nullable_to_non_nullable
as double,landscapeRealtimeRatio: null == landscapeRealtimeRatio ? _self.landscapeRealtimeRatio : landscapeRealtimeRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveMonitorSettings].
extension LiveMonitorSettingsPatterns on LiveMonitorSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveMonitorSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveMonitorSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveMonitorSettings value)  $default,){
final _that = this;
switch (_that) {
case _LiveMonitorSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveMonitorSettings value)?  $default,){
final _that = this;
switch (_that) {
case _LiveMonitorSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LiveMonitorDisplayMode displayMode,  int earthquakeDisplaySeconds,  bool keepScreenAwake,  double portraitRealtimeRatio,  double landscapeRealtimeRatio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveMonitorSettings() when $default != null:
return $default(_that.displayMode,_that.earthquakeDisplaySeconds,_that.keepScreenAwake,_that.portraitRealtimeRatio,_that.landscapeRealtimeRatio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LiveMonitorDisplayMode displayMode,  int earthquakeDisplaySeconds,  bool keepScreenAwake,  double portraitRealtimeRatio,  double landscapeRealtimeRatio)  $default,) {final _that = this;
switch (_that) {
case _LiveMonitorSettings():
return $default(_that.displayMode,_that.earthquakeDisplaySeconds,_that.keepScreenAwake,_that.portraitRealtimeRatio,_that.landscapeRealtimeRatio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LiveMonitorDisplayMode displayMode,  int earthquakeDisplaySeconds,  bool keepScreenAwake,  double portraitRealtimeRatio,  double landscapeRealtimeRatio)?  $default,) {final _that = this;
switch (_that) {
case _LiveMonitorSettings() when $default != null:
return $default(_that.displayMode,_that.earthquakeDisplaySeconds,_that.keepScreenAwake,_that.portraitRealtimeRatio,_that.landscapeRealtimeRatio);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _LiveMonitorSettings implements LiveMonitorSettings {
  const _LiveMonitorSettings({this.displayMode = LiveMonitorDisplayMode.automatic, this.earthquakeDisplaySeconds = 10, this.keepScreenAwake = true, this.portraitRealtimeRatio = 0.5, this.landscapeRealtimeRatio = 0.5});
  factory _LiveMonitorSettings.fromJson(Map<String, dynamic> json) => _$LiveMonitorSettingsFromJson(json);

@override@JsonKey() final  LiveMonitorDisplayMode displayMode;
@override@JsonKey() final  int earthquakeDisplaySeconds;
@override@JsonKey() final  bool keepScreenAwake;
@override@JsonKey() final  double portraitRealtimeRatio;
@override@JsonKey() final  double landscapeRealtimeRatio;

/// Create a copy of LiveMonitorSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveMonitorSettingsCopyWith<_LiveMonitorSettings> get copyWith => __$LiveMonitorSettingsCopyWithImpl<_LiveMonitorSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveMonitorSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveMonitorSettings&&(identical(other.displayMode, displayMode) || other.displayMode == displayMode)&&(identical(other.earthquakeDisplaySeconds, earthquakeDisplaySeconds) || other.earthquakeDisplaySeconds == earthquakeDisplaySeconds)&&(identical(other.keepScreenAwake, keepScreenAwake) || other.keepScreenAwake == keepScreenAwake)&&(identical(other.portraitRealtimeRatio, portraitRealtimeRatio) || other.portraitRealtimeRatio == portraitRealtimeRatio)&&(identical(other.landscapeRealtimeRatio, landscapeRealtimeRatio) || other.landscapeRealtimeRatio == landscapeRealtimeRatio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayMode,earthquakeDisplaySeconds,keepScreenAwake,portraitRealtimeRatio,landscapeRealtimeRatio);

@override
String toString() {
  return 'LiveMonitorSettings(displayMode: $displayMode, earthquakeDisplaySeconds: $earthquakeDisplaySeconds, keepScreenAwake: $keepScreenAwake, portraitRealtimeRatio: $portraitRealtimeRatio, landscapeRealtimeRatio: $landscapeRealtimeRatio)';
}


}

/// @nodoc
abstract mixin class _$LiveMonitorSettingsCopyWith<$Res> implements $LiveMonitorSettingsCopyWith<$Res> {
  factory _$LiveMonitorSettingsCopyWith(_LiveMonitorSettings value, $Res Function(_LiveMonitorSettings) _then) = __$LiveMonitorSettingsCopyWithImpl;
@override @useResult
$Res call({
 LiveMonitorDisplayMode displayMode, int earthquakeDisplaySeconds, bool keepScreenAwake, double portraitRealtimeRatio, double landscapeRealtimeRatio
});




}
/// @nodoc
class __$LiveMonitorSettingsCopyWithImpl<$Res>
    implements _$LiveMonitorSettingsCopyWith<$Res> {
  __$LiveMonitorSettingsCopyWithImpl(this._self, this._then);

  final _LiveMonitorSettings _self;
  final $Res Function(_LiveMonitorSettings) _then;

/// Create a copy of LiveMonitorSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayMode = null,Object? earthquakeDisplaySeconds = null,Object? keepScreenAwake = null,Object? portraitRealtimeRatio = null,Object? landscapeRealtimeRatio = null,}) {
  return _then(_LiveMonitorSettings(
displayMode: null == displayMode ? _self.displayMode : displayMode // ignore: cast_nullable_to_non_nullable
as LiveMonitorDisplayMode,earthquakeDisplaySeconds: null == earthquakeDisplaySeconds ? _self.earthquakeDisplaySeconds : earthquakeDisplaySeconds // ignore: cast_nullable_to_non_nullable
as int,keepScreenAwake: null == keepScreenAwake ? _self.keepScreenAwake : keepScreenAwake // ignore: cast_nullable_to_non_nullable
as bool,portraitRealtimeRatio: null == portraitRealtimeRatio ? _self.portraitRealtimeRatio : portraitRealtimeRatio // ignore: cast_nullable_to_non_nullable
as double,landscapeRealtimeRatio: null == landscapeRealtimeRatio ? _self.landscapeRealtimeRatio : landscapeRealtimeRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
