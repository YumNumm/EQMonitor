// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_override.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationOverride {

 JmaIntensity get minJmaIntensity; String get sound; InterruptionLevel get interruptionLevel;
/// Create a copy of NotificationOverride
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationOverrideCopyWith<NotificationOverride> get copyWith => _$NotificationOverrideCopyWithImpl<NotificationOverride>(this as NotificationOverride, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationOverride&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}


@override
int get hashCode => Object.hash(runtimeType,minJmaIntensity,sound,interruptionLevel);

@override
String toString() {
  return 'NotificationOverride(minJmaIntensity: $minJmaIntensity, sound: $sound, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class $NotificationOverrideCopyWith<$Res>  {
  factory $NotificationOverrideCopyWith(NotificationOverride value, $Res Function(NotificationOverride) _then) = _$NotificationOverrideCopyWithImpl;
@useResult
$Res call({
 JmaIntensity minJmaIntensity, String sound, InterruptionLevel interruptionLevel
});




}
/// @nodoc
class _$NotificationOverrideCopyWithImpl<$Res>
    implements $NotificationOverrideCopyWith<$Res> {
  _$NotificationOverrideCopyWithImpl(this._self, this._then);

  final NotificationOverride _self;
  final $Res Function(NotificationOverride) _then;

/// Create a copy of NotificationOverride
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minJmaIntensity = null,Object? sound = null,Object? interruptionLevel = null,}) {
  return _then(NotificationOverride(
minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as String,interruptionLevel: null == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationOverride].
extension NotificationOverridePatterns on NotificationOverride {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationOverride value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationOverride() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationOverride value)  $default,){
final _that = this;
switch (_that) {
case _NotificationOverride():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationOverride value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationOverride() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaIntensity minJmaIntensity,  String sound,  InterruptionLevel interruptionLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationOverride() when $default != null:
return $default(_that.minJmaIntensity,_that.sound,_that.interruptionLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaIntensity minJmaIntensity,  String sound,  InterruptionLevel interruptionLevel)  $default,) {final _that = this;
switch (_that) {
case _NotificationOverride():
return $default(_that.minJmaIntensity,_that.sound,_that.interruptionLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaIntensity minJmaIntensity,  String sound,  InterruptionLevel interruptionLevel)?  $default,) {final _that = this;
switch (_that) {
case _NotificationOverride() when $default != null:
return $default(_that.minJmaIntensity,_that.sound,_that.interruptionLevel);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationOverride implements NotificationOverride {
  const _NotificationOverride({required this.minJmaIntensity, required this.sound, required this.interruptionLevel});
  

@override final  JmaIntensity minJmaIntensity;
@override final  String sound;
@override final  InterruptionLevel interruptionLevel;

/// Create a copy of NotificationOverride
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationOverrideCopyWith<_NotificationOverride> get copyWith => __$NotificationOverrideCopyWithImpl<_NotificationOverride>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationOverride&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}


@override
int get hashCode => Object.hash(runtimeType,minJmaIntensity,sound,interruptionLevel);

@override
String toString() {
  return 'NotificationOverride(minJmaIntensity: $minJmaIntensity, sound: $sound, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$NotificationOverrideCopyWith<$Res> implements $NotificationOverrideCopyWith<$Res> {
  factory _$NotificationOverrideCopyWith(_NotificationOverride value, $Res Function(_NotificationOverride) _then) = __$NotificationOverrideCopyWithImpl;
@override @useResult
$Res call({
 JmaIntensity minJmaIntensity, String sound, InterruptionLevel interruptionLevel
});




}
/// @nodoc
class __$NotificationOverrideCopyWithImpl<$Res>
    implements _$NotificationOverrideCopyWith<$Res> {
  __$NotificationOverrideCopyWithImpl(this._self, this._then);

  final _NotificationOverride _self;
  final $Res Function(_NotificationOverride) _then;

/// Create a copy of NotificationOverride
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minJmaIntensity = null,Object? sound = null,Object? interruptionLevel = null,}) {
  return _then(_NotificationOverride(
minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as String,interruptionLevel: null == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,
  ));
}


}

// dart format on
