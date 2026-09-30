// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_sound_inspection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSoundInspection {

 String get sourceDisplayName; int get durationMs;
/// Create a copy of NotificationSoundInspection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSoundInspectionCopyWith<NotificationSoundInspection> get copyWith => _$NotificationSoundInspectionCopyWithImpl<NotificationSoundInspection>(this as NotificationSoundInspection, _$identity);

  /// Serializes this NotificationSoundInspection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSoundInspection&&(identical(other.sourceDisplayName, sourceDisplayName) || other.sourceDisplayName == sourceDisplayName)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceDisplayName,durationMs);

@override
String toString() {
  return 'NotificationSoundInspection(sourceDisplayName: $sourceDisplayName, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class $NotificationSoundInspectionCopyWith<$Res>  {
  factory $NotificationSoundInspectionCopyWith(NotificationSoundInspection value, $Res Function(NotificationSoundInspection) _then) = _$NotificationSoundInspectionCopyWithImpl;
@useResult
$Res call({
 String sourceDisplayName, int durationMs
});




}
/// @nodoc
class _$NotificationSoundInspectionCopyWithImpl<$Res>
    implements $NotificationSoundInspectionCopyWith<$Res> {
  _$NotificationSoundInspectionCopyWithImpl(this._self, this._then);

  final NotificationSoundInspection _self;
  final $Res Function(NotificationSoundInspection) _then;

/// Create a copy of NotificationSoundInspection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceDisplayName = null,Object? durationMs = null,}) {
  return _then(NotificationSoundInspection(
sourceDisplayName: null == sourceDisplayName ? _self.sourceDisplayName : sourceDisplayName // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSoundInspection].
extension NotificationSoundInspectionPatterns on NotificationSoundInspection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSoundInspection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSoundInspection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSoundInspection value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSoundInspection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSoundInspection value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSoundInspection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sourceDisplayName,  int durationMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSoundInspection() when $default != null:
return $default(_that.sourceDisplayName,_that.durationMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sourceDisplayName,  int durationMs)  $default,) {final _that = this;
switch (_that) {
case _NotificationSoundInspection():
return $default(_that.sourceDisplayName,_that.durationMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sourceDisplayName,  int durationMs)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSoundInspection() when $default != null:
return $default(_that.sourceDisplayName,_that.durationMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSoundInspection implements NotificationSoundInspection {
  const _NotificationSoundInspection({required this.sourceDisplayName, required this.durationMs});
  factory _NotificationSoundInspection.fromJson(Map<String, dynamic> json) => _$NotificationSoundInspectionFromJson(json);

@override final  String sourceDisplayName;
@override final  int durationMs;

/// Create a copy of NotificationSoundInspection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSoundInspectionCopyWith<_NotificationSoundInspection> get copyWith => __$NotificationSoundInspectionCopyWithImpl<_NotificationSoundInspection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSoundInspectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSoundInspection&&(identical(other.sourceDisplayName, sourceDisplayName) || other.sourceDisplayName == sourceDisplayName)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceDisplayName,durationMs);

@override
String toString() {
  return 'NotificationSoundInspection(sourceDisplayName: $sourceDisplayName, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class _$NotificationSoundInspectionCopyWith<$Res> implements $NotificationSoundInspectionCopyWith<$Res> {
  factory _$NotificationSoundInspectionCopyWith(_NotificationSoundInspection value, $Res Function(_NotificationSoundInspection) _then) = __$NotificationSoundInspectionCopyWithImpl;
@override @useResult
$Res call({
 String sourceDisplayName, int durationMs
});




}
/// @nodoc
class __$NotificationSoundInspectionCopyWithImpl<$Res>
    implements _$NotificationSoundInspectionCopyWith<$Res> {
  __$NotificationSoundInspectionCopyWithImpl(this._self, this._then);

  final _NotificationSoundInspection _self;
  final $Res Function(_NotificationSoundInspection) _then;

/// Create a copy of NotificationSoundInspection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceDisplayName = null,Object? durationMs = null,}) {
  return _then(_NotificationSoundInspection(
sourceDisplayName: null == sourceDisplayName ? _self.sourceDisplayName : sourceDisplayName // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
