// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_notification_tier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiNotificationTier {

@JsonKey(name: 'min_warning_kind') TsunamiWarningKind get minWarningKind; String get sound;@JsonKey(name: 'interruption_level') InterruptionLevel get interruptionLevel;
/// Create a copy of TsunamiNotificationTier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiNotificationTierCopyWith<TsunamiNotificationTier> get copyWith => _$TsunamiNotificationTierCopyWithImpl<TsunamiNotificationTier>(this as TsunamiNotificationTier, _$identity);

  /// Serializes this TsunamiNotificationTier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiNotificationTier&&(identical(other.minWarningKind, minWarningKind) || other.minWarningKind == minWarningKind)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minWarningKind,sound,interruptionLevel);

@override
String toString() {
  return 'TsunamiNotificationTier(minWarningKind: $minWarningKind, sound: $sound, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class $TsunamiNotificationTierCopyWith<$Res>  {
  factory $TsunamiNotificationTierCopyWith(TsunamiNotificationTier value, $Res Function(TsunamiNotificationTier) _then) = _$TsunamiNotificationTierCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'min_warning_kind') TsunamiWarningKind minWarningKind, String sound,@JsonKey(name: 'interruption_level') InterruptionLevel interruptionLevel
});




}
/// @nodoc
class _$TsunamiNotificationTierCopyWithImpl<$Res>
    implements $TsunamiNotificationTierCopyWith<$Res> {
  _$TsunamiNotificationTierCopyWithImpl(this._self, this._then);

  final TsunamiNotificationTier _self;
  final $Res Function(TsunamiNotificationTier) _then;

/// Create a copy of TsunamiNotificationTier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minWarningKind = null,Object? sound = null,Object? interruptionLevel = null,}) {
  return _then(TsunamiNotificationTier(
minWarningKind: null == minWarningKind ? _self.minWarningKind : minWarningKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as String,interruptionLevel: null == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiNotificationTier].
extension TsunamiNotificationTierPatterns on TsunamiNotificationTier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiNotificationTier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiNotificationTier() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiNotificationTier value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiNotificationTier():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiNotificationTier value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiNotificationTier() when $default != null:
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
case _TsunamiNotificationTier() when $default != null:
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
case _TsunamiNotificationTier():
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
case _TsunamiNotificationTier() when $default != null:
return $default(_that.minWarningKind,_that.sound,_that.interruptionLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiNotificationTier implements TsunamiNotificationTier {
  const _TsunamiNotificationTier({@JsonKey(name: 'min_warning_kind') required this.minWarningKind, required this.sound, @JsonKey(name: 'interruption_level') required this.interruptionLevel});
  factory _TsunamiNotificationTier.fromJson(Map<String, dynamic> json) => _$TsunamiNotificationTierFromJson(json);

@override@JsonKey(name: 'min_warning_kind') final  TsunamiWarningKind minWarningKind;
@override final  String sound;
@override@JsonKey(name: 'interruption_level') final  InterruptionLevel interruptionLevel;

/// Create a copy of TsunamiNotificationTier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiNotificationTierCopyWith<_TsunamiNotificationTier> get copyWith => __$TsunamiNotificationTierCopyWithImpl<_TsunamiNotificationTier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiNotificationTierToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiNotificationTier&&(identical(other.minWarningKind, minWarningKind) || other.minWarningKind == minWarningKind)&&(identical(other.sound, sound) || other.sound == sound)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minWarningKind,sound,interruptionLevel);

@override
String toString() {
  return 'TsunamiNotificationTier(minWarningKind: $minWarningKind, sound: $sound, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$TsunamiNotificationTierCopyWith<$Res> implements $TsunamiNotificationTierCopyWith<$Res> {
  factory _$TsunamiNotificationTierCopyWith(_TsunamiNotificationTier value, $Res Function(_TsunamiNotificationTier) _then) = __$TsunamiNotificationTierCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'min_warning_kind') TsunamiWarningKind minWarningKind, String sound,@JsonKey(name: 'interruption_level') InterruptionLevel interruptionLevel
});




}
/// @nodoc
class __$TsunamiNotificationTierCopyWithImpl<$Res>
    implements _$TsunamiNotificationTierCopyWith<$Res> {
  __$TsunamiNotificationTierCopyWithImpl(this._self, this._then);

  final _TsunamiNotificationTier _self;
  final $Res Function(_TsunamiNotificationTier) _then;

/// Create a copy of TsunamiNotificationTier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minWarningKind = null,Object? sound = null,Object? interruptionLevel = null,}) {
  return _then(_TsunamiNotificationTier(
minWarningKind: null == minWarningKind ? _self.minWarningKind : minWarningKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,sound: null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as String,interruptionLevel: null == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel,
  ));
}


}

// dart format on
