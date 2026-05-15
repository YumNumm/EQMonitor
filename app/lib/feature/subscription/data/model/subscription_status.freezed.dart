// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionStatus()';
}


}

/// @nodoc
class $SubscriptionStatusCopyWith<$Res>  {
$SubscriptionStatusCopyWith(SubscriptionStatus _, $Res Function(SubscriptionStatus) __);
}


/// Adds pattern-matching-related methods to [SubscriptionStatus].
extension SubscriptionStatusPatterns on SubscriptionStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SubscriptionStatusActive value)?  active,TResult Function( SubscriptionStatusInactive value)?  inactive,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SubscriptionStatusActive() when active != null:
return active(_that);case SubscriptionStatusInactive() when inactive != null:
return inactive(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SubscriptionStatusActive value)  active,required TResult Function( SubscriptionStatusInactive value)  inactive,}){
final _that = this;
switch (_that) {
case SubscriptionStatusActive():
return active(_that);case SubscriptionStatusInactive():
return inactive(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SubscriptionStatusActive value)?  active,TResult? Function( SubscriptionStatusInactive value)?  inactive,}){
final _that = this;
switch (_that) {
case SubscriptionStatusActive() when active != null:
return active(_that);case SubscriptionStatusInactive() when inactive != null:
return inactive(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String productId,  DateTime? expiresAt,  bool willRenew)?  active,TResult Function()?  inactive,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SubscriptionStatusActive() when active != null:
return active(_that.productId,_that.expiresAt,_that.willRenew);case SubscriptionStatusInactive() when inactive != null:
return inactive();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String productId,  DateTime? expiresAt,  bool willRenew)  active,required TResult Function()  inactive,}) {final _that = this;
switch (_that) {
case SubscriptionStatusActive():
return active(_that.productId,_that.expiresAt,_that.willRenew);case SubscriptionStatusInactive():
return inactive();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String productId,  DateTime? expiresAt,  bool willRenew)?  active,TResult? Function()?  inactive,}) {final _that = this;
switch (_that) {
case SubscriptionStatusActive() when active != null:
return active(_that.productId,_that.expiresAt,_that.willRenew);case SubscriptionStatusInactive() when inactive != null:
return inactive();case _:
  return null;

}
}

}

/// @nodoc


class SubscriptionStatusActive implements SubscriptionStatus {
  const SubscriptionStatusActive({required this.productId, this.expiresAt, this.willRenew = true});
  

 final  String productId;
 final  DateTime? expiresAt;
@JsonKey() final  bool willRenew;

/// Create a copy of SubscriptionStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStatusActiveCopyWith<SubscriptionStatusActive> get copyWith => _$SubscriptionStatusActiveCopyWithImpl<SubscriptionStatusActive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatusActive&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.willRenew, willRenew) || other.willRenew == willRenew));
}


@override
int get hashCode => Object.hash(runtimeType,productId,expiresAt,willRenew);

@override
String toString() {
  return 'SubscriptionStatus.active(productId: $productId, expiresAt: $expiresAt, willRenew: $willRenew)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStatusActiveCopyWith<$Res> implements $SubscriptionStatusCopyWith<$Res> {
  factory $SubscriptionStatusActiveCopyWith(SubscriptionStatusActive value, $Res Function(SubscriptionStatusActive) _then) = _$SubscriptionStatusActiveCopyWithImpl;
@useResult
$Res call({
 String productId, DateTime? expiresAt, bool willRenew
});




}
/// @nodoc
class _$SubscriptionStatusActiveCopyWithImpl<$Res>
    implements $SubscriptionStatusActiveCopyWith<$Res> {
  _$SubscriptionStatusActiveCopyWithImpl(this._self, this._then);

  final SubscriptionStatusActive _self;
  final $Res Function(SubscriptionStatusActive) _then;

/// Create a copy of SubscriptionStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? expiresAt = freezed,Object? willRenew = null,}) {
  return _then(SubscriptionStatusActive(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,willRenew: null == willRenew ? _self.willRenew : willRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SubscriptionStatusInactive implements SubscriptionStatus {
  const SubscriptionStatusInactive();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatusInactive);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionStatus.inactive()';
}


}




// dart format on
