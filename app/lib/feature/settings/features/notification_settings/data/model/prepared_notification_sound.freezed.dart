// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prepared_notification_sound.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PreparedNotificationSound {

 String get id; int get durationMs;
/// Create a copy of PreparedNotificationSound
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreparedNotificationSoundCopyWith<PreparedNotificationSound> get copyWith => _$PreparedNotificationSoundCopyWithImpl<PreparedNotificationSound>(this as PreparedNotificationSound, _$identity);

  /// Serializes this PreparedNotificationSound to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreparedNotificationSound&&(identical(other.id, id) || other.id == id)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,durationMs);

@override
String toString() {
  return 'PreparedNotificationSound(id: $id, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class $PreparedNotificationSoundCopyWith<$Res>  {
  factory $PreparedNotificationSoundCopyWith(PreparedNotificationSound value, $Res Function(PreparedNotificationSound) _then) = _$PreparedNotificationSoundCopyWithImpl;
@useResult
$Res call({
 String id, int durationMs
});




}
/// @nodoc
class _$PreparedNotificationSoundCopyWithImpl<$Res>
    implements $PreparedNotificationSoundCopyWith<$Res> {
  _$PreparedNotificationSoundCopyWithImpl(this._self, this._then);

  final PreparedNotificationSound _self;
  final $Res Function(PreparedNotificationSound) _then;

/// Create a copy of PreparedNotificationSound
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? durationMs = null,}) {
  return _then(PreparedNotificationSound(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PreparedNotificationSound].
extension PreparedNotificationSoundPatterns on PreparedNotificationSound {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreparedNotificationSound value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreparedNotificationSound() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreparedNotificationSound value)  $default,){
final _that = this;
switch (_that) {
case _PreparedNotificationSound():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreparedNotificationSound value)?  $default,){
final _that = this;
switch (_that) {
case _PreparedNotificationSound() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int durationMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreparedNotificationSound() when $default != null:
return $default(_that.id,_that.durationMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int durationMs)  $default,) {final _that = this;
switch (_that) {
case _PreparedNotificationSound():
return $default(_that.id,_that.durationMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int durationMs)?  $default,) {final _that = this;
switch (_that) {
case _PreparedNotificationSound() when $default != null:
return $default(_that.id,_that.durationMs);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _PreparedNotificationSound implements PreparedNotificationSound {
  const _PreparedNotificationSound({required this.id, required this.durationMs});
  factory _PreparedNotificationSound.fromJson(Map<String, dynamic> json) => _$PreparedNotificationSoundFromJson(json);

@override final  String id;
@override final  int durationMs;

/// Create a copy of PreparedNotificationSound
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreparedNotificationSoundCopyWith<_PreparedNotificationSound> get copyWith => __$PreparedNotificationSoundCopyWithImpl<_PreparedNotificationSound>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreparedNotificationSoundToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreparedNotificationSound&&(identical(other.id, id) || other.id == id)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,durationMs);

@override
String toString() {
  return 'PreparedNotificationSound(id: $id, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class _$PreparedNotificationSoundCopyWith<$Res> implements $PreparedNotificationSoundCopyWith<$Res> {
  factory _$PreparedNotificationSoundCopyWith(_PreparedNotificationSound value, $Res Function(_PreparedNotificationSound) _then) = __$PreparedNotificationSoundCopyWithImpl;
@override @useResult
$Res call({
 String id, int durationMs
});




}
/// @nodoc
class __$PreparedNotificationSoundCopyWithImpl<$Res>
    implements _$PreparedNotificationSoundCopyWith<$Res> {
  __$PreparedNotificationSoundCopyWithImpl(this._self, this._then);

  final _PreparedNotificationSound _self;
  final $Res Function(_PreparedNotificationSound) _then;

/// Create a copy of PreparedNotificationSound
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? durationMs = null,}) {
  return _then(_PreparedNotificationSound(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
