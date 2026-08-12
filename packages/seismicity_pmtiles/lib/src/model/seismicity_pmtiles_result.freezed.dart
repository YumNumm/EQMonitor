// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_pmtiles_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeismicityPmTilesResult<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesResult<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeismicityPmTilesResult<$T>()';
}


}

/// @nodoc
class $SeismicityPmTilesResultCopyWith<T,$Res>  {
$SeismicityPmTilesResultCopyWith(SeismicityPmTilesResult<T> _, $Res Function(SeismicityPmTilesResult<T>) __);
}


/// Adds pattern-matching-related methods to [SeismicityPmTilesResult].
extension SeismicityPmTilesResultPatterns<T> on SeismicityPmTilesResult<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SeismicityPmTilesSuccess<T> value)?  success,TResult Function( SeismicityPmTilesFailure<T> value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SeismicityPmTilesSuccess() when success != null:
return success(_that);case SeismicityPmTilesFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SeismicityPmTilesSuccess<T> value)  success,required TResult Function( SeismicityPmTilesFailure<T> value)  failure,}){
final _that = this;
switch (_that) {
case SeismicityPmTilesSuccess():
return success(_that);case SeismicityPmTilesFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SeismicityPmTilesSuccess<T> value)?  success,TResult? Function( SeismicityPmTilesFailure<T> value)?  failure,}){
final _that = this;
switch (_that) {
case SeismicityPmTilesSuccess() when success != null:
return success(_that);case SeismicityPmTilesFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( T value)?  success,TResult Function( SeismicityPmTilesException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SeismicityPmTilesSuccess() when success != null:
return success(_that.value);case SeismicityPmTilesFailure() when failure != null:
return failure(_that.exception);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( T value)  success,required TResult Function( SeismicityPmTilesException exception)  failure,}) {final _that = this;
switch (_that) {
case SeismicityPmTilesSuccess():
return success(_that.value);case SeismicityPmTilesFailure():
return failure(_that.exception);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( T value)?  success,TResult? Function( SeismicityPmTilesException exception)?  failure,}) {final _that = this;
switch (_that) {
case SeismicityPmTilesSuccess() when success != null:
return success(_that.value);case SeismicityPmTilesFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class SeismicityPmTilesSuccess<T> implements SeismicityPmTilesResult<T> {
  const SeismicityPmTilesSuccess({required this.value});
  

 final  T value;

/// Create a copy of SeismicityPmTilesResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesSuccessCopyWith<T, SeismicityPmTilesSuccess<T>> get copyWith => _$SeismicityPmTilesSuccessCopyWithImpl<T, SeismicityPmTilesSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesSuccess<T>&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'SeismicityPmTilesResult<$T>.success(value: $value)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesSuccessCopyWith<T,$Res> implements $SeismicityPmTilesResultCopyWith<T, $Res> {
  factory $SeismicityPmTilesSuccessCopyWith(SeismicityPmTilesSuccess<T> value, $Res Function(SeismicityPmTilesSuccess<T>) _then) = _$SeismicityPmTilesSuccessCopyWithImpl;
@useResult
$Res call({
 T value
});




}
/// @nodoc
class _$SeismicityPmTilesSuccessCopyWithImpl<T,$Res>
    implements $SeismicityPmTilesSuccessCopyWith<T, $Res> {
  _$SeismicityPmTilesSuccessCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesSuccess<T> _self;
  final $Res Function(SeismicityPmTilesSuccess<T>) _then;

/// Create a copy of SeismicityPmTilesResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(SeismicityPmTilesSuccess<T>(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class SeismicityPmTilesFailure<T> implements SeismicityPmTilesResult<T> {
  const SeismicityPmTilesFailure({required this.exception});
  

 final  SeismicityPmTilesException exception;

/// Create a copy of SeismicityPmTilesResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesFailureCopyWith<T, SeismicityPmTilesFailure<T>> get copyWith => _$SeismicityPmTilesFailureCopyWithImpl<T, SeismicityPmTilesFailure<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesFailure<T>&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'SeismicityPmTilesResult<$T>.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesFailureCopyWith<T,$Res> implements $SeismicityPmTilesResultCopyWith<T, $Res> {
  factory $SeismicityPmTilesFailureCopyWith(SeismicityPmTilesFailure<T> value, $Res Function(SeismicityPmTilesFailure<T>) _then) = _$SeismicityPmTilesFailureCopyWithImpl;
@useResult
$Res call({
 SeismicityPmTilesException exception
});


$SeismicityPmTilesExceptionCopyWith<$Res> get exception;

}
/// @nodoc
class _$SeismicityPmTilesFailureCopyWithImpl<T,$Res>
    implements $SeismicityPmTilesFailureCopyWith<T, $Res> {
  _$SeismicityPmTilesFailureCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesFailure<T> _self;
  final $Res Function(SeismicityPmTilesFailure<T>) _then;

/// Create a copy of SeismicityPmTilesResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(SeismicityPmTilesFailure<T>(
exception: null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as SeismicityPmTilesException,
  ));
}

/// Create a copy of SeismicityPmTilesResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeismicityPmTilesExceptionCopyWith<$Res> get exception {
  
  return $SeismicityPmTilesExceptionCopyWith<$Res>(_self.exception, (value) {
    return _then(_self.copyWith(exception: value));
  });
}
}

// dart format on
