// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_outcome.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchaseOutcome {

 PurchaseResult get result; SubscriptionStatus? get status;
/// Create a copy of PurchaseOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseOutcomeCopyWith<PurchaseOutcome> get copyWith => _$PurchaseOutcomeCopyWithImpl<PurchaseOutcome>(this as PurchaseOutcome, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseOutcome&&(identical(other.result, result) || other.result == result)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,result,status);

@override
String toString() {
  return 'PurchaseOutcome(result: $result, status: $status)';
}


}

/// @nodoc
abstract mixin class $PurchaseOutcomeCopyWith<$Res>  {
  factory $PurchaseOutcomeCopyWith(PurchaseOutcome value, $Res Function(PurchaseOutcome) _then) = _$PurchaseOutcomeCopyWithImpl;
@useResult
$Res call({
 PurchaseResult result, SubscriptionStatus? status
});


$PurchaseResultCopyWith<$Res> get result;$SubscriptionStatusCopyWith<$Res>? get status;

}
/// @nodoc
class _$PurchaseOutcomeCopyWithImpl<$Res>
    implements $PurchaseOutcomeCopyWith<$Res> {
  _$PurchaseOutcomeCopyWithImpl(this._self, this._then);

  final PurchaseOutcome _self;
  final $Res Function(PurchaseOutcome) _then;

/// Create a copy of PurchaseOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? status = freezed,}) {
  return _then(PurchaseOutcome(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as PurchaseResult,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus?,
  ));
}
/// Create a copy of PurchaseOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PurchaseResultCopyWith<$Res> get result {
  
  return $PurchaseResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of PurchaseOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionStatusCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $SubscriptionStatusCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [PurchaseOutcome].
extension PurchaseOutcomePatterns on PurchaseOutcome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseOutcome value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseOutcome() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseOutcome value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseOutcome():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseOutcome value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseOutcome() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PurchaseResult result,  SubscriptionStatus? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseOutcome() when $default != null:
return $default(_that.result,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PurchaseResult result,  SubscriptionStatus? status)  $default,) {final _that = this;
switch (_that) {
case _PurchaseOutcome():
return $default(_that.result,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PurchaseResult result,  SubscriptionStatus? status)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseOutcome() when $default != null:
return $default(_that.result,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _PurchaseOutcome implements PurchaseOutcome {
  const _PurchaseOutcome({required this.result, this.status});
  

@override final  PurchaseResult result;
@override final  SubscriptionStatus? status;

/// Create a copy of PurchaseOutcome
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseOutcomeCopyWith<_PurchaseOutcome> get copyWith => __$PurchaseOutcomeCopyWithImpl<_PurchaseOutcome>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseOutcome&&(identical(other.result, result) || other.result == result)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,result,status);

@override
String toString() {
  return 'PurchaseOutcome(result: $result, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PurchaseOutcomeCopyWith<$Res> implements $PurchaseOutcomeCopyWith<$Res> {
  factory _$PurchaseOutcomeCopyWith(_PurchaseOutcome value, $Res Function(_PurchaseOutcome) _then) = __$PurchaseOutcomeCopyWithImpl;
@override @useResult
$Res call({
 PurchaseResult result, SubscriptionStatus? status
});


@override $PurchaseResultCopyWith<$Res> get result;@override $SubscriptionStatusCopyWith<$Res>? get status;

}
/// @nodoc
class __$PurchaseOutcomeCopyWithImpl<$Res>
    implements _$PurchaseOutcomeCopyWith<$Res> {
  __$PurchaseOutcomeCopyWithImpl(this._self, this._then);

  final _PurchaseOutcome _self;
  final $Res Function(_PurchaseOutcome) _then;

/// Create a copy of PurchaseOutcome
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? status = freezed,}) {
  return _then(_PurchaseOutcome(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as PurchaseResult,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus?,
  ));
}

/// Create a copy of PurchaseOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PurchaseResultCopyWith<$Res> get result {
  
  return $PurchaseResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of PurchaseOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionStatusCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $SubscriptionStatusCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
