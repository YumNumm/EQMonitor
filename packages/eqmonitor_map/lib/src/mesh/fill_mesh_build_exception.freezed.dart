// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fill_mesh_build_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FillMeshBuildException {

 String get reason;
/// Create a copy of FillMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FillMeshBuildExceptionCopyWith<FillMeshBuildException> get copyWith => _$FillMeshBuildExceptionCopyWithImpl<FillMeshBuildException>(this as FillMeshBuildException, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FillMeshBuildException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'FillMeshBuildException(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $FillMeshBuildExceptionCopyWith<$Res>  {
  factory $FillMeshBuildExceptionCopyWith(FillMeshBuildException value, $Res Function(FillMeshBuildException) _then) = _$FillMeshBuildExceptionCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$FillMeshBuildExceptionCopyWithImpl<$Res>
    implements $FillMeshBuildExceptionCopyWith<$Res> {
  _$FillMeshBuildExceptionCopyWithImpl(this._self, this._then);

  final FillMeshBuildException _self;
  final $Res Function(FillMeshBuildException) _then;

/// Create a copy of FillMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reason = null,}) {
  return _then(_self.copyWith(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FillMeshBuildException].
extension FillMeshBuildExceptionPatterns on FillMeshBuildException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FillMeshDegenerateRingException value)?  degenerateRing,TResult Function( FillMeshHoleBeforeExteriorException value)?  holeBeforeExterior,TResult Function( FillMeshLimitExceededException value)?  limitExceeded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FillMeshDegenerateRingException() when degenerateRing != null:
return degenerateRing(_that);case FillMeshHoleBeforeExteriorException() when holeBeforeExterior != null:
return holeBeforeExterior(_that);case FillMeshLimitExceededException() when limitExceeded != null:
return limitExceeded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FillMeshDegenerateRingException value)  degenerateRing,required TResult Function( FillMeshHoleBeforeExteriorException value)  holeBeforeExterior,required TResult Function( FillMeshLimitExceededException value)  limitExceeded,}){
final _that = this;
switch (_that) {
case FillMeshDegenerateRingException():
return degenerateRing(_that);case FillMeshHoleBeforeExteriorException():
return holeBeforeExterior(_that);case FillMeshLimitExceededException():
return limitExceeded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FillMeshDegenerateRingException value)?  degenerateRing,TResult? Function( FillMeshHoleBeforeExteriorException value)?  holeBeforeExterior,TResult? Function( FillMeshLimitExceededException value)?  limitExceeded,}){
final _that = this;
switch (_that) {
case FillMeshDegenerateRingException() when degenerateRing != null:
return degenerateRing(_that);case FillMeshHoleBeforeExteriorException() when holeBeforeExterior != null:
return holeBeforeExterior(_that);case FillMeshLimitExceededException() when limitExceeded != null:
return limitExceeded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String reason)?  degenerateRing,TResult Function( String reason)?  holeBeforeExterior,TResult Function( String reason)?  limitExceeded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FillMeshDegenerateRingException() when degenerateRing != null:
return degenerateRing(_that.reason);case FillMeshHoleBeforeExteriorException() when holeBeforeExterior != null:
return holeBeforeExterior(_that.reason);case FillMeshLimitExceededException() when limitExceeded != null:
return limitExceeded(_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String reason)  degenerateRing,required TResult Function( String reason)  holeBeforeExterior,required TResult Function( String reason)  limitExceeded,}) {final _that = this;
switch (_that) {
case FillMeshDegenerateRingException():
return degenerateRing(_that.reason);case FillMeshHoleBeforeExteriorException():
return holeBeforeExterior(_that.reason);case FillMeshLimitExceededException():
return limitExceeded(_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String reason)?  degenerateRing,TResult? Function( String reason)?  holeBeforeExterior,TResult? Function( String reason)?  limitExceeded,}) {final _that = this;
switch (_that) {
case FillMeshDegenerateRingException() when degenerateRing != null:
return degenerateRing(_that.reason);case FillMeshHoleBeforeExteriorException() when holeBeforeExterior != null:
return holeBeforeExterior(_that.reason);case FillMeshLimitExceededException() when limitExceeded != null:
return limitExceeded(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class FillMeshDegenerateRingException implements FillMeshBuildException {
  const FillMeshDegenerateRingException({required this.reason});
  

@override final  String reason;

/// Create a copy of FillMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FillMeshDegenerateRingExceptionCopyWith<FillMeshDegenerateRingException> get copyWith => _$FillMeshDegenerateRingExceptionCopyWithImpl<FillMeshDegenerateRingException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FillMeshDegenerateRingException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'FillMeshBuildException.degenerateRing(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $FillMeshDegenerateRingExceptionCopyWith<$Res> implements $FillMeshBuildExceptionCopyWith<$Res> {
  factory $FillMeshDegenerateRingExceptionCopyWith(FillMeshDegenerateRingException value, $Res Function(FillMeshDegenerateRingException) _then) = _$FillMeshDegenerateRingExceptionCopyWithImpl;
@override @useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$FillMeshDegenerateRingExceptionCopyWithImpl<$Res>
    implements $FillMeshDegenerateRingExceptionCopyWith<$Res> {
  _$FillMeshDegenerateRingExceptionCopyWithImpl(this._self, this._then);

  final FillMeshDegenerateRingException _self;
  final $Res Function(FillMeshDegenerateRingException) _then;

/// Create a copy of FillMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(FillMeshDegenerateRingException(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FillMeshHoleBeforeExteriorException implements FillMeshBuildException {
  const FillMeshHoleBeforeExteriorException({required this.reason});
  

@override final  String reason;

/// Create a copy of FillMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FillMeshHoleBeforeExteriorExceptionCopyWith<FillMeshHoleBeforeExteriorException> get copyWith => _$FillMeshHoleBeforeExteriorExceptionCopyWithImpl<FillMeshHoleBeforeExteriorException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FillMeshHoleBeforeExteriorException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'FillMeshBuildException.holeBeforeExterior(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $FillMeshHoleBeforeExteriorExceptionCopyWith<$Res> implements $FillMeshBuildExceptionCopyWith<$Res> {
  factory $FillMeshHoleBeforeExteriorExceptionCopyWith(FillMeshHoleBeforeExteriorException value, $Res Function(FillMeshHoleBeforeExteriorException) _then) = _$FillMeshHoleBeforeExteriorExceptionCopyWithImpl;
@override @useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$FillMeshHoleBeforeExteriorExceptionCopyWithImpl<$Res>
    implements $FillMeshHoleBeforeExteriorExceptionCopyWith<$Res> {
  _$FillMeshHoleBeforeExteriorExceptionCopyWithImpl(this._self, this._then);

  final FillMeshHoleBeforeExteriorException _self;
  final $Res Function(FillMeshHoleBeforeExteriorException) _then;

/// Create a copy of FillMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(FillMeshHoleBeforeExteriorException(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FillMeshLimitExceededException implements FillMeshBuildException {
  const FillMeshLimitExceededException({required this.reason});
  

@override final  String reason;

/// Create a copy of FillMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FillMeshLimitExceededExceptionCopyWith<FillMeshLimitExceededException> get copyWith => _$FillMeshLimitExceededExceptionCopyWithImpl<FillMeshLimitExceededException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FillMeshLimitExceededException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'FillMeshBuildException.limitExceeded(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $FillMeshLimitExceededExceptionCopyWith<$Res> implements $FillMeshBuildExceptionCopyWith<$Res> {
  factory $FillMeshLimitExceededExceptionCopyWith(FillMeshLimitExceededException value, $Res Function(FillMeshLimitExceededException) _then) = _$FillMeshLimitExceededExceptionCopyWithImpl;
@override @useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$FillMeshLimitExceededExceptionCopyWithImpl<$Res>
    implements $FillMeshLimitExceededExceptionCopyWith<$Res> {
  _$FillMeshLimitExceededExceptionCopyWithImpl(this._self, this._then);

  final FillMeshLimitExceededException _self;
  final $Res Function(FillMeshLimitExceededException) _then;

/// Create a copy of FillMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(FillMeshLimitExceededException(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
