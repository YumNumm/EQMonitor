// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_replay_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebugReplayState {

 DebugReplayStatus get status; int get currentIndex; int get totalCount;
/// Create a copy of DebugReplayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugReplayStateCopyWith<DebugReplayState> get copyWith => _$DebugReplayStateCopyWithImpl<DebugReplayState>(this as DebugReplayState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugReplayState&&(identical(other.status, status) || other.status == status)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}


@override
int get hashCode => Object.hash(runtimeType,status,currentIndex,totalCount);

@override
String toString() {
  return 'DebugReplayState(status: $status, currentIndex: $currentIndex, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class $DebugReplayStateCopyWith<$Res>  {
  factory $DebugReplayStateCopyWith(DebugReplayState value, $Res Function(DebugReplayState) _then) = _$DebugReplayStateCopyWithImpl;
@useResult
$Res call({
 DebugReplayStatus status, int currentIndex, int totalCount
});




}
/// @nodoc
class _$DebugReplayStateCopyWithImpl<$Res>
    implements $DebugReplayStateCopyWith<$Res> {
  _$DebugReplayStateCopyWithImpl(this._self, this._then);

  final DebugReplayState _self;
  final $Res Function(DebugReplayState) _then;

/// Create a copy of DebugReplayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? currentIndex = null,Object? totalCount = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebugReplayStatus,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DebugReplayState].
extension DebugReplayStatePatterns on DebugReplayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebugReplayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebugReplayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebugReplayState value)  $default,){
final _that = this;
switch (_that) {
case _DebugReplayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebugReplayState value)?  $default,){
final _that = this;
switch (_that) {
case _DebugReplayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DebugReplayStatus status,  int currentIndex,  int totalCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebugReplayState() when $default != null:
return $default(_that.status,_that.currentIndex,_that.totalCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DebugReplayStatus status,  int currentIndex,  int totalCount)  $default,) {final _that = this;
switch (_that) {
case _DebugReplayState():
return $default(_that.status,_that.currentIndex,_that.totalCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DebugReplayStatus status,  int currentIndex,  int totalCount)?  $default,) {final _that = this;
switch (_that) {
case _DebugReplayState() when $default != null:
return $default(_that.status,_that.currentIndex,_that.totalCount);case _:
  return null;

}
}

}

/// @nodoc


class _DebugReplayState implements DebugReplayState {
  const _DebugReplayState({this.status = DebugReplayStatus.idle, this.currentIndex = 0, this.totalCount = 0});
  

@override@JsonKey() final  DebugReplayStatus status;
@override@JsonKey() final  int currentIndex;
@override@JsonKey() final  int totalCount;

/// Create a copy of DebugReplayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebugReplayStateCopyWith<_DebugReplayState> get copyWith => __$DebugReplayStateCopyWithImpl<_DebugReplayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebugReplayState&&(identical(other.status, status) || other.status == status)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}


@override
int get hashCode => Object.hash(runtimeType,status,currentIndex,totalCount);

@override
String toString() {
  return 'DebugReplayState(status: $status, currentIndex: $currentIndex, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class _$DebugReplayStateCopyWith<$Res> implements $DebugReplayStateCopyWith<$Res> {
  factory _$DebugReplayStateCopyWith(_DebugReplayState value, $Res Function(_DebugReplayState) _then) = __$DebugReplayStateCopyWithImpl;
@override @useResult
$Res call({
 DebugReplayStatus status, int currentIndex, int totalCount
});




}
/// @nodoc
class __$DebugReplayStateCopyWithImpl<$Res>
    implements _$DebugReplayStateCopyWith<$Res> {
  __$DebugReplayStateCopyWithImpl(this._self, this._then);

  final _DebugReplayState _self;
  final $Res Function(_DebugReplayState) _then;

/// Create a copy of DebugReplayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? currentIndex = null,Object? totalCount = null,}) {
  return _then(_DebugReplayState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebugReplayStatus,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
