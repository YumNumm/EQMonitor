// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merged_events2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MergedEvents2 {

 String get eventId; DateTime get mergedAt;
/// Create a copy of MergedEvents2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MergedEvents2CopyWith<MergedEvents2> get copyWith => _$MergedEvents2CopyWithImpl<MergedEvents2>(this as MergedEvents2, _$identity);

  /// Serializes this MergedEvents2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MergedEvents2&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.mergedAt, mergedAt) || other.mergedAt == mergedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,mergedAt);

@override
String toString() {
  return 'MergedEvents2(eventId: $eventId, mergedAt: $mergedAt)';
}


}

/// @nodoc
abstract mixin class $MergedEvents2CopyWith<$Res>  {
  factory $MergedEvents2CopyWith(MergedEvents2 value, $Res Function(MergedEvents2) _then) = _$MergedEvents2CopyWithImpl;
@useResult
$Res call({
 String eventId, DateTime mergedAt
});




}
/// @nodoc
class _$MergedEvents2CopyWithImpl<$Res>
    implements $MergedEvents2CopyWith<$Res> {
  _$MergedEvents2CopyWithImpl(this._self, this._then);

  final MergedEvents2 _self;
  final $Res Function(MergedEvents2) _then;

/// Create a copy of MergedEvents2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? mergedAt = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,mergedAt: null == mergedAt ? _self.mergedAt : mergedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MergedEvents2].
extension MergedEvents2Patterns on MergedEvents2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MergedEvents2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MergedEvents2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MergedEvents2 value)  $default,){
final _that = this;
switch (_that) {
case _MergedEvents2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MergedEvents2 value)?  $default,){
final _that = this;
switch (_that) {
case _MergedEvents2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  DateTime mergedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MergedEvents2() when $default != null:
return $default(_that.eventId,_that.mergedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  DateTime mergedAt)  $default,) {final _that = this;
switch (_that) {
case _MergedEvents2():
return $default(_that.eventId,_that.mergedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  DateTime mergedAt)?  $default,) {final _that = this;
switch (_that) {
case _MergedEvents2() when $default != null:
return $default(_that.eventId,_that.mergedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MergedEvents2 implements MergedEvents2 {
  const _MergedEvents2({required this.eventId, required this.mergedAt});
  factory _MergedEvents2.fromJson(Map<String, dynamic> json) => _$MergedEvents2FromJson(json);

@override final  String eventId;
@override final  DateTime mergedAt;

/// Create a copy of MergedEvents2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MergedEvents2CopyWith<_MergedEvents2> get copyWith => __$MergedEvents2CopyWithImpl<_MergedEvents2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MergedEvents2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MergedEvents2&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.mergedAt, mergedAt) || other.mergedAt == mergedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,mergedAt);

@override
String toString() {
  return 'MergedEvents2(eventId: $eventId, mergedAt: $mergedAt)';
}


}

/// @nodoc
abstract mixin class _$MergedEvents2CopyWith<$Res> implements $MergedEvents2CopyWith<$Res> {
  factory _$MergedEvents2CopyWith(_MergedEvents2 value, $Res Function(_MergedEvents2) _then) = __$MergedEvents2CopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime mergedAt
});




}
/// @nodoc
class __$MergedEvents2CopyWithImpl<$Res>
    implements _$MergedEvents2CopyWith<$Res> {
  __$MergedEvents2CopyWithImpl(this._self, this._then);

  final _MergedEvents2 _self;
  final $Res Function(_MergedEvents2) _then;

/// Create a copy of MergedEvents2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? mergedAt = null,}) {
  return _then(_MergedEvents2(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,mergedAt: null == mergedAt ? _self.mergedAt : mergedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
