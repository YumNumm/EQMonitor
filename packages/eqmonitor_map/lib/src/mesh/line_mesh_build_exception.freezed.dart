// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'line_mesh_build_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LineMeshBuildException {

 String get reason;
/// Create a copy of LineMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineMeshBuildExceptionCopyWith<LineMeshBuildException> get copyWith => _$LineMeshBuildExceptionCopyWithImpl<LineMeshBuildException>(this as LineMeshBuildException, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineMeshBuildException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'LineMeshBuildException(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $LineMeshBuildExceptionCopyWith<$Res>  {
  factory $LineMeshBuildExceptionCopyWith(LineMeshBuildException value, $Res Function(LineMeshBuildException) _then) = _$LineMeshBuildExceptionCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$LineMeshBuildExceptionCopyWithImpl<$Res>
    implements $LineMeshBuildExceptionCopyWith<$Res> {
  _$LineMeshBuildExceptionCopyWithImpl(this._self, this._then);

  final LineMeshBuildException _self;
  final $Res Function(LineMeshBuildException) _then;

/// Create a copy of LineMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reason = null,}) {
  return _then(_self.copyWith(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LineMeshBuildException].
extension LineMeshBuildExceptionPatterns on LineMeshBuildException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LineMeshLimitExceededException value)?  limitExceeded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LineMeshLimitExceededException() when limitExceeded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LineMeshLimitExceededException value)  limitExceeded,}){
final _that = this;
switch (_that) {
case LineMeshLimitExceededException():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LineMeshLimitExceededException value)?  limitExceeded,}){
final _that = this;
switch (_that) {
case LineMeshLimitExceededException() when limitExceeded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String reason)?  limitExceeded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LineMeshLimitExceededException() when limitExceeded != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String reason)  limitExceeded,}) {final _that = this;
switch (_that) {
case LineMeshLimitExceededException():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String reason)?  limitExceeded,}) {final _that = this;
switch (_that) {
case LineMeshLimitExceededException() when limitExceeded != null:
return limitExceeded(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class LineMeshLimitExceededException implements LineMeshBuildException {
  const LineMeshLimitExceededException({required this.reason});
  

@override final  String reason;

/// Create a copy of LineMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineMeshLimitExceededExceptionCopyWith<LineMeshLimitExceededException> get copyWith => _$LineMeshLimitExceededExceptionCopyWithImpl<LineMeshLimitExceededException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineMeshLimitExceededException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'LineMeshBuildException.limitExceeded(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $LineMeshLimitExceededExceptionCopyWith<$Res> implements $LineMeshBuildExceptionCopyWith<$Res> {
  factory $LineMeshLimitExceededExceptionCopyWith(LineMeshLimitExceededException value, $Res Function(LineMeshLimitExceededException) _then) = _$LineMeshLimitExceededExceptionCopyWithImpl;
@override @useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$LineMeshLimitExceededExceptionCopyWithImpl<$Res>
    implements $LineMeshLimitExceededExceptionCopyWith<$Res> {
  _$LineMeshLimitExceededExceptionCopyWithImpl(this._self, this._then);

  final LineMeshLimitExceededException _self;
  final $Res Function(LineMeshLimitExceededException) _then;

/// Create a copy of LineMeshBuildException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(LineMeshLimitExceededException(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
