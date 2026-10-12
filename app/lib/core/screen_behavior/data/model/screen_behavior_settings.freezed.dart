// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_behavior_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScreenBehaviorSettings {

 bool get keepScreenAwake; bool get showWhenLocked;
/// Create a copy of ScreenBehaviorSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScreenBehaviorSettingsCopyWith<ScreenBehaviorSettings> get copyWith => _$ScreenBehaviorSettingsCopyWithImpl<ScreenBehaviorSettings>(this as ScreenBehaviorSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenBehaviorSettings&&(identical(other.keepScreenAwake, keepScreenAwake) || other.keepScreenAwake == keepScreenAwake)&&(identical(other.showWhenLocked, showWhenLocked) || other.showWhenLocked == showWhenLocked));
}


@override
int get hashCode => Object.hash(runtimeType,keepScreenAwake,showWhenLocked);

@override
String toString() {
  return 'ScreenBehaviorSettings(keepScreenAwake: $keepScreenAwake, showWhenLocked: $showWhenLocked)';
}


}

/// @nodoc
abstract mixin class $ScreenBehaviorSettingsCopyWith<$Res>  {
  factory $ScreenBehaviorSettingsCopyWith(ScreenBehaviorSettings value, $Res Function(ScreenBehaviorSettings) _then) = _$ScreenBehaviorSettingsCopyWithImpl;
@useResult
$Res call({
 bool keepScreenAwake, bool showWhenLocked
});




}
/// @nodoc
class _$ScreenBehaviorSettingsCopyWithImpl<$Res>
    implements $ScreenBehaviorSettingsCopyWith<$Res> {
  _$ScreenBehaviorSettingsCopyWithImpl(this._self, this._then);

  final ScreenBehaviorSettings _self;
  final $Res Function(ScreenBehaviorSettings) _then;

/// Create a copy of ScreenBehaviorSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keepScreenAwake = null,Object? showWhenLocked = null,}) {
  return _then(ScreenBehaviorSettings(
keepScreenAwake: null == keepScreenAwake ? _self.keepScreenAwake : keepScreenAwake // ignore: cast_nullable_to_non_nullable
as bool,showWhenLocked: null == showWhenLocked ? _self.showWhenLocked : showWhenLocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ScreenBehaviorSettings].
extension ScreenBehaviorSettingsPatterns on ScreenBehaviorSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScreenBehaviorSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScreenBehaviorSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScreenBehaviorSettings value)  $default,){
final _that = this;
switch (_that) {
case _ScreenBehaviorSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScreenBehaviorSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ScreenBehaviorSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool keepScreenAwake,  bool showWhenLocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScreenBehaviorSettings() when $default != null:
return $default(_that.keepScreenAwake,_that.showWhenLocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool keepScreenAwake,  bool showWhenLocked)  $default,) {final _that = this;
switch (_that) {
case _ScreenBehaviorSettings():
return $default(_that.keepScreenAwake,_that.showWhenLocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool keepScreenAwake,  bool showWhenLocked)?  $default,) {final _that = this;
switch (_that) {
case _ScreenBehaviorSettings() when $default != null:
return $default(_that.keepScreenAwake,_that.showWhenLocked);case _:
  return null;

}
}

}

/// @nodoc


class _ScreenBehaviorSettings implements ScreenBehaviorSettings {
  const _ScreenBehaviorSettings({this.keepScreenAwake = false, this.showWhenLocked = true});
  

@override@JsonKey() final  bool keepScreenAwake;
@override@JsonKey() final  bool showWhenLocked;

/// Create a copy of ScreenBehaviorSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScreenBehaviorSettingsCopyWith<_ScreenBehaviorSettings> get copyWith => __$ScreenBehaviorSettingsCopyWithImpl<_ScreenBehaviorSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScreenBehaviorSettings&&(identical(other.keepScreenAwake, keepScreenAwake) || other.keepScreenAwake == keepScreenAwake)&&(identical(other.showWhenLocked, showWhenLocked) || other.showWhenLocked == showWhenLocked));
}


@override
int get hashCode => Object.hash(runtimeType,keepScreenAwake,showWhenLocked);

@override
String toString() {
  return 'ScreenBehaviorSettings(keepScreenAwake: $keepScreenAwake, showWhenLocked: $showWhenLocked)';
}


}

/// @nodoc
abstract mixin class _$ScreenBehaviorSettingsCopyWith<$Res> implements $ScreenBehaviorSettingsCopyWith<$Res> {
  factory _$ScreenBehaviorSettingsCopyWith(_ScreenBehaviorSettings value, $Res Function(_ScreenBehaviorSettings) _then) = __$ScreenBehaviorSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool keepScreenAwake, bool showWhenLocked
});




}
/// @nodoc
class __$ScreenBehaviorSettingsCopyWithImpl<$Res>
    implements _$ScreenBehaviorSettingsCopyWith<$Res> {
  __$ScreenBehaviorSettingsCopyWithImpl(this._self, this._then);

  final _ScreenBehaviorSettings _self;
  final $Res Function(_ScreenBehaviorSettings) _then;

/// Create a copy of ScreenBehaviorSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keepScreenAwake = null,Object? showWhenLocked = null,}) {
  return _then(_ScreenBehaviorSettings(
keepScreenAwake: null == keepScreenAwake ? _self.keepScreenAwake : keepScreenAwake // ignore: cast_nullable_to_non_nullable
as bool,showWhenLocked: null == showWhenLocked ? _self.showWhenLocked : showWhenLocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
