// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchaseResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseResult()';
}


}

/// @nodoc
class $PurchaseResultCopyWith<$Res>  {
$PurchaseResultCopyWith(PurchaseResult _, $Res Function(PurchaseResult) __);
}


/// Adds pattern-matching-related methods to [PurchaseResult].
extension PurchaseResultPatterns on PurchaseResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PurchaseResultSuccess value)?  success,TResult Function( PurchaseResultCancelled value)?  cancelled,TResult Function( PurchaseResultFailed value)?  failed,TResult Function( PurchaseResultUnavailable value)?  unavailable,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PurchaseResultSuccess() when success != null:
return success(_that);case PurchaseResultCancelled() when cancelled != null:
return cancelled(_that);case PurchaseResultFailed() when failed != null:
return failed(_that);case PurchaseResultUnavailable() when unavailable != null:
return unavailable(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PurchaseResultSuccess value)  success,required TResult Function( PurchaseResultCancelled value)  cancelled,required TResult Function( PurchaseResultFailed value)  failed,required TResult Function( PurchaseResultUnavailable value)  unavailable,}){
final _that = this;
switch (_that) {
case PurchaseResultSuccess():
return success(_that);case PurchaseResultCancelled():
return cancelled(_that);case PurchaseResultFailed():
return failed(_that);case PurchaseResultUnavailable():
return unavailable(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PurchaseResultSuccess value)?  success,TResult? Function( PurchaseResultCancelled value)?  cancelled,TResult? Function( PurchaseResultFailed value)?  failed,TResult? Function( PurchaseResultUnavailable value)?  unavailable,}){
final _that = this;
switch (_that) {
case PurchaseResultSuccess() when success != null:
return success(_that);case PurchaseResultCancelled() when cancelled != null:
return cancelled(_that);case PurchaseResultFailed() when failed != null:
return failed(_that);case PurchaseResultUnavailable() when unavailable != null:
return unavailable(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  success,TResult Function()?  cancelled,TResult Function( String message)?  failed,TResult Function( String reason)?  unavailable,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PurchaseResultSuccess() when success != null:
return success();case PurchaseResultCancelled() when cancelled != null:
return cancelled();case PurchaseResultFailed() when failed != null:
return failed(_that.message);case PurchaseResultUnavailable() when unavailable != null:
return unavailable(_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  success,required TResult Function()  cancelled,required TResult Function( String message)  failed,required TResult Function( String reason)  unavailable,}) {final _that = this;
switch (_that) {
case PurchaseResultSuccess():
return success();case PurchaseResultCancelled():
return cancelled();case PurchaseResultFailed():
return failed(_that.message);case PurchaseResultUnavailable():
return unavailable(_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  success,TResult? Function()?  cancelled,TResult? Function( String message)?  failed,TResult? Function( String reason)?  unavailable,}) {final _that = this;
switch (_that) {
case PurchaseResultSuccess() when success != null:
return success();case PurchaseResultCancelled() when cancelled != null:
return cancelled();case PurchaseResultFailed() when failed != null:
return failed(_that.message);case PurchaseResultUnavailable() when unavailable != null:
return unavailable(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class PurchaseResultSuccess implements PurchaseResult {
  const PurchaseResultSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseResultSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseResult.success()';
}


}




/// @nodoc


class PurchaseResultCancelled implements PurchaseResult {
  const PurchaseResultCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseResultCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseResult.cancelled()';
}


}




/// @nodoc


class PurchaseResultFailed implements PurchaseResult {
  const PurchaseResultFailed(this.message);
  

 final  String message;

/// Create a copy of PurchaseResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseResultFailedCopyWith<PurchaseResultFailed> get copyWith => _$PurchaseResultFailedCopyWithImpl<PurchaseResultFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseResultFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PurchaseResult.failed(message: $message)';
}


}

/// @nodoc
abstract mixin class $PurchaseResultFailedCopyWith<$Res> implements $PurchaseResultCopyWith<$Res> {
  factory $PurchaseResultFailedCopyWith(PurchaseResultFailed value, $Res Function(PurchaseResultFailed) _then) = _$PurchaseResultFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PurchaseResultFailedCopyWithImpl<$Res>
    implements $PurchaseResultFailedCopyWith<$Res> {
  _$PurchaseResultFailedCopyWithImpl(this._self, this._then);

  final PurchaseResultFailed _self;
  final $Res Function(PurchaseResultFailed) _then;

/// Create a copy of PurchaseResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PurchaseResultFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PurchaseResultUnavailable implements PurchaseResult {
  const PurchaseResultUnavailable(this.reason);
  

 final  String reason;

/// Create a copy of PurchaseResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseResultUnavailableCopyWith<PurchaseResultUnavailable> get copyWith => _$PurchaseResultUnavailableCopyWithImpl<PurchaseResultUnavailable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseResultUnavailable&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'PurchaseResult.unavailable(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $PurchaseResultUnavailableCopyWith<$Res> implements $PurchaseResultCopyWith<$Res> {
  factory $PurchaseResultUnavailableCopyWith(PurchaseResultUnavailable value, $Res Function(PurchaseResultUnavailable) _then) = _$PurchaseResultUnavailableCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$PurchaseResultUnavailableCopyWithImpl<$Res>
    implements $PurchaseResultUnavailableCopyWith<$Res> {
  _$PurchaseResultUnavailableCopyWithImpl(this._self, this._then);

  final PurchaseResultUnavailable _self;
  final $Res Function(PurchaseResultUnavailable) _then;

/// Create a copy of PurchaseResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(PurchaseResultUnavailable(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
