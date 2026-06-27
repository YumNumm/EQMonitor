// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_tiers5.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationTiers5 {

@JsonKey(name: 'min_warning_kind') TsunamiWarningKind get minWarningKind; String get sound;@JsonKey(name: 'interruption_level') InterruptionLevel get interruptionLevel;
/// Create a copy of NotificationTiers5
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTiers5CopyWith<NotificationTiers5> get copyWith => _$NotificationTiers5CopyWithImpl<NotificationTiers5>(this as NotificationTiers5, _$identity);

  /// Serializes this NotificationTiers5 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTiers5&&(identical(other.minWarningKind, minWarningKind) || other.minWarningKind == minWarningKind)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minWarningKind,sound,interruptionLevel);

@override
String toString() {
  return 'NotificationTiers5(minWarningKind: $minWarningKind, sound: $sound, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class $NotificationTiers5CopyWith<$Res>  {
  factory $NotificationTiers5CopyWith(NotificationTiers5 value, $Res Function(NotificationTiers5) _then) = _$NotificationTiers5CopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'min_warning_kind') TsunamiWarningKind minWarningKind, String sound,@JsonKey(name: 'interruption_level') InterruptionLevel interruptionLevel
});




}
/// @nodoc
class _$NotificationTiers5CopyWithImpl<$Res>
    implements $NotificationTiers5CopyWith<$Res> {
  _$NotificationTiers5CopyWithImpl(this._self, this._then);

  final NotificationTiers5 _self;
  final $Res Function(NotificationTiers5) _then;

/// Create a copy of NotificationTiers5
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minWarningKind = null,Object? sound = null,Object? interruptionLevel = null,}) {
  return _then(_self.copyWith(
minWarningKind: null == minWarningKind ? _self.minWarningKind : minWarningKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as String,interruptionLevel: null == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationTiers5].
extension NotificationTiers5Patterns on NotificationTiers5 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationTiers5 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationTiers5() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationTiers5 value)  $default,){
final _that = this;
switch (_that) {
case _NotificationTiers5():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationTiers5 value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationTiers5() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'min_warning_kind')  TsunamiWarningKind minWarningKind,  String sound, @JsonKey(name: 'interruption_level')  InterruptionLevel interruptionLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationTiers5() when $default != null:
return $default(_that.minWarningKind,_that.sound,_that.interruptionLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'min_warning_kind')  TsunamiWarningKind minWarningKind,  String sound, @JsonKey(name: 'interruption_level')  InterruptionLevel interruptionLevel)  $default,) {final _that = this;
switch (_that) {
case _NotificationTiers5():
return $default(_that.minWarningKind,_that.sound,_that.interruptionLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'min_warning_kind')  TsunamiWarningKind minWarningKind,  String sound, @JsonKey(name: 'interruption_level')  InterruptionLevel interruptionLevel)?  $default,) {final _that = this;
switch (_that) {
case _NotificationTiers5() when $default != null:
return $default(_that.minWarningKind,_that.sound,_that.interruptionLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationTiers5 implements NotificationTiers5 {
  const _NotificationTiers5({@JsonKey(name: 'min_warning_kind') required this.minWarningKind, required this.sound, @JsonKey(name: 'interruption_level') required this.interruptionLevel});
  factory _NotificationTiers5.fromJson(Map<String, dynamic> json) => _$NotificationTiers5FromJson(json);

@override@JsonKey(name: 'min_warning_kind') final  TsunamiWarningKind minWarningKind;
@override final  String sound;
@override@JsonKey(name: 'interruption_level') final  InterruptionLevel interruptionLevel;

/// Create a copy of NotificationTiers5
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTiers5CopyWith<_NotificationTiers5> get copyWith => __$NotificationTiers5CopyWithImpl<_NotificationTiers5>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTiers5ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTiers5&&(identical(other.minWarningKind, minWarningKind) || other.minWarningKind == minWarningKind)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minWarningKind,sound,interruptionLevel);

@override
String toString() {
  return 'NotificationTiers5(minWarningKind: $minWarningKind, sound: $sound, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$NotificationTiers5CopyWith<$Res> implements $NotificationTiers5CopyWith<$Res> {
  factory _$NotificationTiers5CopyWith(_NotificationTiers5 value, $Res Function(_NotificationTiers5) _then) = __$NotificationTiers5CopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'min_warning_kind') TsunamiWarningKind minWarningKind, String sound,@JsonKey(name: 'interruption_level') InterruptionLevel interruptionLevel
});




}
/// @nodoc
class __$NotificationTiers5CopyWithImpl<$Res>
    implements _$NotificationTiers5CopyWith<$Res> {
  __$NotificationTiers5CopyWithImpl(this._self, this._then);

  final _NotificationTiers5 _self;
  final $Res Function(_NotificationTiers5) _then;

/// Create a copy of NotificationTiers5
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minWarningKind = null,Object? sound = null,Object? interruptionLevel = null,}) {
  return _then(_NotificationTiers5(
minWarningKind: null == minWarningKind ? _self.minWarningKind : minWarningKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as String,interruptionLevel: null == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,
  ));
}


}

// dart format on
