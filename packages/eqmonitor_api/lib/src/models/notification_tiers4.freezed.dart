// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_tiers4.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationTiers4 {

@JsonKey(name: 'min_jma_intensity') MinJmaIntensity get minJmaIntensity; String get sound;@JsonKey(name: 'interruption_level') InterruptionLevel get interruptionLevel;
/// Create a copy of NotificationTiers4
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTiers4CopyWith<NotificationTiers4> get copyWith => _$NotificationTiers4CopyWithImpl<NotificationTiers4>(this as NotificationTiers4, _$identity);

  /// Serializes this NotificationTiers4 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTiers4&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minJmaIntensity,sound,interruptionLevel);

@override
String toString() {
  return 'NotificationTiers4(minJmaIntensity: $minJmaIntensity, sound: $sound, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class $NotificationTiers4CopyWith<$Res>  {
  factory $NotificationTiers4CopyWith(NotificationTiers4 value, $Res Function(NotificationTiers4) _then) = _$NotificationTiers4CopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'min_jma_intensity') MinJmaIntensity minJmaIntensity, String sound,@JsonKey(name: 'interruption_level') InterruptionLevel interruptionLevel
});




}
/// @nodoc
class _$NotificationTiers4CopyWithImpl<$Res>
    implements $NotificationTiers4CopyWith<$Res> {
  _$NotificationTiers4CopyWithImpl(this._self, this._then);

  final NotificationTiers4 _self;
  final $Res Function(NotificationTiers4) _then;

/// Create a copy of NotificationTiers4
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minJmaIntensity = null,Object? sound = null,Object? interruptionLevel = null,}) {
  return _then(_self.copyWith(
minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as MinJmaIntensity,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as String,interruptionLevel: null == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationTiers4].
extension NotificationTiers4Patterns on NotificationTiers4 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationTiers4 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationTiers4() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationTiers4 value)  $default,){
final _that = this;
switch (_that) {
case _NotificationTiers4():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationTiers4 value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationTiers4() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'min_jma_intensity')  MinJmaIntensity minJmaIntensity,  String sound, @JsonKey(name: 'interruption_level')  InterruptionLevel interruptionLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationTiers4() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'min_jma_intensity')  MinJmaIntensity minJmaIntensity,  String sound, @JsonKey(name: 'interruption_level')  InterruptionLevel interruptionLevel)  $default,) {final _that = this;
switch (_that) {
case _NotificationTiers4():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'min_jma_intensity')  MinJmaIntensity minJmaIntensity,  String sound, @JsonKey(name: 'interruption_level')  InterruptionLevel interruptionLevel)?  $default,) {final _that = this;
switch (_that) {
case _NotificationTiers4() when $default != null:
return $default(_that.minJmaIntensity,_that.sound,_that.interruptionLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationTiers4 implements NotificationTiers4 {
  const _NotificationTiers4({@JsonKey(name: 'min_jma_intensity') required this.minJmaIntensity, required this.sound, @JsonKey(name: 'interruption_level') required this.interruptionLevel});
  factory _NotificationTiers4.fromJson(Map<String, dynamic> json) => _$NotificationTiers4FromJson(json);

@override@JsonKey(name: 'min_jma_intensity') final  MinJmaIntensity minJmaIntensity;
@override final  String sound;
@override@JsonKey(name: 'interruption_level') final  InterruptionLevel interruptionLevel;

/// Create a copy of NotificationTiers4
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTiers4CopyWith<_NotificationTiers4> get copyWith => __$NotificationTiers4CopyWithImpl<_NotificationTiers4>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTiers4ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTiers4&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minJmaIntensity,sound,interruptionLevel);

@override
String toString() {
  return 'NotificationTiers4(minJmaIntensity: $minJmaIntensity, sound: $sound, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$NotificationTiers4CopyWith<$Res> implements $NotificationTiers4CopyWith<$Res> {
  factory _$NotificationTiers4CopyWith(_NotificationTiers4 value, $Res Function(_NotificationTiers4) _then) = __$NotificationTiers4CopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'min_jma_intensity') MinJmaIntensity minJmaIntensity, String sound,@JsonKey(name: 'interruption_level') InterruptionLevel interruptionLevel
});




}
/// @nodoc
class __$NotificationTiers4CopyWithImpl<$Res>
    implements _$NotificationTiers4CopyWith<$Res> {
  __$NotificationTiers4CopyWithImpl(this._self, this._then);

  final _NotificationTiers4 _self;
  final $Res Function(_NotificationTiers4) _then;

/// Create a copy of NotificationTiers4
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minJmaIntensity = null,Object? sound = null,Object? interruptionLevel = null,}) {
  return _then(_NotificationTiers4(
minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as MinJmaIntensity,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as String,interruptionLevel: null == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,
  ));
}


}

// dart format on
