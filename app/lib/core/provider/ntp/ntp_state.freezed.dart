// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ntp_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NtpState {

 Duration get offset; DateTime get updatedAt;
/// Create a copy of NtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NtpStateCopyWith<NtpState> get copyWith => _$NtpStateCopyWithImpl<NtpState>(this as NtpState, _$identity);

  /// Serializes this NtpState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NtpState&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offset,updatedAt);

@override
String toString() {
  return 'NtpState(offset: $offset, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $NtpStateCopyWith<$Res>  {
  factory $NtpStateCopyWith(NtpState value, $Res Function(NtpState) _then) = _$NtpStateCopyWithImpl;
@useResult
$Res call({
 Duration offset, DateTime updatedAt
});




}
/// @nodoc
class _$NtpStateCopyWithImpl<$Res>
    implements $NtpStateCopyWith<$Res> {
  _$NtpStateCopyWithImpl(this._self, this._then);

  final NtpState _self;
  final $Res Function(NtpState) _then;

/// Create a copy of NtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? offset = null,Object? updatedAt = null,}) {
  return _then(NtpState(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as Duration,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [NtpState].
extension NtpStatePatterns on NtpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NtpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NtpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NtpState value)  $default,){
final _that = this;
switch (_that) {
case _NtpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NtpState value)?  $default,){
final _that = this;
switch (_that) {
case _NtpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration offset,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NtpState() when $default != null:
return $default(_that.offset,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration offset,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _NtpState():
return $default(_that.offset,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration offset,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _NtpState() when $default != null:
return $default(_that.offset,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NtpState implements NtpState {
  const _NtpState({required this.offset, required this.updatedAt});
  factory _NtpState.fromJson(Map<String, dynamic> json) => _$NtpStateFromJson(json);

@override final  Duration offset;
@override final  DateTime updatedAt;

/// Create a copy of NtpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NtpStateCopyWith<_NtpState> get copyWith => __$NtpStateCopyWithImpl<_NtpState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NtpStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NtpState&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offset,updatedAt);

@override
String toString() {
  return 'NtpState(offset: $offset, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$NtpStateCopyWith<$Res> implements $NtpStateCopyWith<$Res> {
  factory _$NtpStateCopyWith(_NtpState value, $Res Function(_NtpState) _then) = __$NtpStateCopyWithImpl;
@override @useResult
$Res call({
 Duration offset, DateTime updatedAt
});




}
/// @nodoc
class __$NtpStateCopyWithImpl<$Res>
    implements _$NtpStateCopyWith<$Res> {
  __$NtpStateCopyWithImpl(this._self, this._then);

  final _NtpState _self;
  final $Res Function(_NtpState) _then;

/// Create a copy of NtpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? offset = null,Object? updatedAt = null,}) {
  return _then(_NtpState(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as Duration,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
