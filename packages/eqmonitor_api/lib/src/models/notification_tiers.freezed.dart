// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_tiers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationTiers {

@JsonKey(name: 'min_jma_intensity') MinJmaIntensity get minJmaIntensity; String get sound;@JsonKey(name: 'interruption_level') InterruptionLevel get interruptionLevel;
/// Create a copy of NotificationTiers
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTiersCopyWith<NotificationTiers> get copyWith => _$NotificationTiersCopyWithImpl<NotificationTiers>(this as NotificationTiers, _$identity);

  /// Serializes this NotificationTiers to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTiers&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minJmaIntensity,sound,interruptionLevel);

@override
String toString() {
  return 'NotificationTiers(minJmaIntensity: $minJmaIntensity, sound: $sound, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class $NotificationTiersCopyWith<$Res>  {
  factory $NotificationTiersCopyWith(NotificationTiers value, $Res Function(NotificationTiers) _then) = _$NotificationTiersCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'min_jma_intensity') MinJmaIntensity minJmaIntensity, String sound,@JsonKey(name: 'interruption_level') InterruptionLevel interruptionLevel
});




}
/// @nodoc
class _$NotificationTiersCopyWithImpl<$Res>
    implements $NotificationTiersCopyWith<$Res> {
  _$NotificationTiersCopyWithImpl(this._self, this._then);

  final NotificationTiers _self;
  final $Res Function(NotificationTiers) _then;

/// Create a copy of NotificationTiers
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


/// Adds pattern-matching-related methods to [NotificationTiers].
extension NotificationTiersPatterns on NotificationTiers {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationTiers value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationTiers() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationTiers value)  $default,){
final _that = this;
switch (_that) {
case _NotificationTiers():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationTiers value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationTiers() when $default != null:
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
case _NotificationTiers() when $default != null:
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
case _NotificationTiers():
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
case _NotificationTiers() when $default != null:
return $default(_that.minJmaIntensity,_that.sound,_that.interruptionLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationTiers implements NotificationTiers {
  const _NotificationTiers({@JsonKey(name: 'min_jma_intensity') required this.minJmaIntensity, required this.sound, @JsonKey(name: 'interruption_level') required this.interruptionLevel});
  factory _NotificationTiers.fromJson(Map<String, dynamic> json) => _$NotificationTiersFromJson(json);

@override@JsonKey(name: 'min_jma_intensity') final  MinJmaIntensity minJmaIntensity;
@override final  String sound;
@override@JsonKey(name: 'interruption_level') final  InterruptionLevel interruptionLevel;

/// Create a copy of NotificationTiers
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTiersCopyWith<_NotificationTiers> get copyWith => __$NotificationTiersCopyWithImpl<_NotificationTiers>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTiersToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTiers&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minJmaIntensity,sound,interruptionLevel);

@override
String toString() {
  return 'NotificationTiers(minJmaIntensity: $minJmaIntensity, sound: $sound, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$NotificationTiersCopyWith<$Res> implements $NotificationTiersCopyWith<$Res> {
  factory _$NotificationTiersCopyWith(_NotificationTiers value, $Res Function(_NotificationTiers) _then) = __$NotificationTiersCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'min_jma_intensity') MinJmaIntensity minJmaIntensity, String sound,@JsonKey(name: 'interruption_level') InterruptionLevel interruptionLevel
});




}
/// @nodoc
class __$NotificationTiersCopyWithImpl<$Res>
    implements _$NotificationTiersCopyWith<$Res> {
  __$NotificationTiersCopyWithImpl(this._self, this._then);

  final _NotificationTiers _self;
  final $Res Function(_NotificationTiers) _then;

/// Create a copy of NotificationTiers
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minJmaIntensity = null,Object? sound = null,Object? interruptionLevel = null,}) {
  return _then(_NotificationTiers(
minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as MinJmaIntensity,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as String,interruptionLevel: null == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,
  ));
}


}

// dart format on
