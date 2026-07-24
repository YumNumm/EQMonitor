// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'correlated_eew2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CorrelatedEew2 {

 String get eventId; num get score;
/// Create a copy of CorrelatedEew2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CorrelatedEew2CopyWith<CorrelatedEew2> get copyWith => _$CorrelatedEew2CopyWithImpl<CorrelatedEew2>(this as CorrelatedEew2, _$identity);

  /// Serializes this CorrelatedEew2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CorrelatedEew2&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,score);

@override
String toString() {
  return 'CorrelatedEew2(eventId: $eventId, score: $score)';
}


}

/// @nodoc
abstract mixin class $CorrelatedEew2CopyWith<$Res>  {
  factory $CorrelatedEew2CopyWith(CorrelatedEew2 value, $Res Function(CorrelatedEew2) _then) = _$CorrelatedEew2CopyWithImpl;
@useResult
$Res call({
 String eventId, num score
});




}
/// @nodoc
class _$CorrelatedEew2CopyWithImpl<$Res>
    implements $CorrelatedEew2CopyWith<$Res> {
  _$CorrelatedEew2CopyWithImpl(this._self, this._then);

  final CorrelatedEew2 _self;
  final $Res Function(CorrelatedEew2) _then;

/// Create a copy of CorrelatedEew2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? score = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [CorrelatedEew2].
extension CorrelatedEew2Patterns on CorrelatedEew2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CorrelatedEew2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CorrelatedEew2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CorrelatedEew2 value)  $default,){
final _that = this;
switch (_that) {
case _CorrelatedEew2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CorrelatedEew2 value)?  $default,){
final _that = this;
switch (_that) {
case _CorrelatedEew2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  num score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CorrelatedEew2() when $default != null:
return $default(_that.eventId,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  num score)  $default,) {final _that = this;
switch (_that) {
case _CorrelatedEew2():
return $default(_that.eventId,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  num score)?  $default,) {final _that = this;
switch (_that) {
case _CorrelatedEew2() when $default != null:
return $default(_that.eventId,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CorrelatedEew2 implements CorrelatedEew2 {
  const _CorrelatedEew2({required this.eventId, required this.score});
  factory _CorrelatedEew2.fromJson(Map<String, dynamic> json) => _$CorrelatedEew2FromJson(json);

@override final  String eventId;
@override final  num score;

/// Create a copy of CorrelatedEew2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CorrelatedEew2CopyWith<_CorrelatedEew2> get copyWith => __$CorrelatedEew2CopyWithImpl<_CorrelatedEew2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CorrelatedEew2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CorrelatedEew2&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,score);

@override
String toString() {
  return 'CorrelatedEew2(eventId: $eventId, score: $score)';
}


}

/// @nodoc
abstract mixin class _$CorrelatedEew2CopyWith<$Res> implements $CorrelatedEew2CopyWith<$Res> {
  factory _$CorrelatedEew2CopyWith(_CorrelatedEew2 value, $Res Function(_CorrelatedEew2) _then) = __$CorrelatedEew2CopyWithImpl;
@override @useResult
$Res call({
 String eventId, num score
});




}
/// @nodoc
class __$CorrelatedEew2CopyWithImpl<$Res>
    implements _$CorrelatedEew2CopyWith<$Res> {
  __$CorrelatedEew2CopyWithImpl(this._self, this._then);

  final _CorrelatedEew2 _self;
  final $Res Function(_CorrelatedEew2) _then;

/// Create a copy of CorrelatedEew2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? score = null,}) {
  return _then(_CorrelatedEew2(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
