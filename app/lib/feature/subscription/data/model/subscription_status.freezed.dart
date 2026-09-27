// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionStatus {

 SubscriptionSyncPhase get syncPhase;
/// Create a copy of SubscriptionStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStatusCopyWith<SubscriptionStatus> get copyWith => _$SubscriptionStatusCopyWithImpl<SubscriptionStatus>(this as SubscriptionStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatus&&(identical(other.syncPhase, syncPhase) || other.syncPhase == syncPhase));
}


@override
int get hashCode => Object.hash(runtimeType,syncPhase);

@override
String toString() {
  return 'SubscriptionStatus(syncPhase: $syncPhase)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStatusCopyWith<$Res>  {
  factory $SubscriptionStatusCopyWith(SubscriptionStatus value, $Res Function(SubscriptionStatus) _then) = _$SubscriptionStatusCopyWithImpl;
@useResult
$Res call({
 SubscriptionSyncPhase syncPhase
});




}
/// @nodoc
class _$SubscriptionStatusCopyWithImpl<$Res>
    implements $SubscriptionStatusCopyWith<$Res> {
  _$SubscriptionStatusCopyWithImpl(this._self, this._then);

  final SubscriptionStatus _self;
  final $Res Function(SubscriptionStatus) _then;

/// Create a copy of SubscriptionStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? syncPhase = null,}) {
  return _then(_self.copyWith(
syncPhase: null == syncPhase ? _self.syncPhase : syncPhase // ignore: cast_nullable_to_non_nullable
as SubscriptionSyncPhase,
  ));
}

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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String productId,  DateTime? expiresAt,  bool willRenew,  SubscriptionSyncPhase syncPhase)?  active,TResult Function( SubscriptionSyncPhase syncPhase)?  inactive,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SubscriptionStatusActive() when active != null:
return active(_that.productId,_that.expiresAt,_that.willRenew,_that.syncPhase);case SubscriptionStatusInactive() when inactive != null:
return inactive(_that.syncPhase);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String productId,  DateTime? expiresAt,  bool willRenew,  SubscriptionSyncPhase syncPhase)  active,required TResult Function( SubscriptionSyncPhase syncPhase)  inactive,}) {final _that = this;
switch (_that) {
case SubscriptionStatusActive():
return active(_that.productId,_that.expiresAt,_that.willRenew,_that.syncPhase);case SubscriptionStatusInactive():
return inactive(_that.syncPhase);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String productId,  DateTime? expiresAt,  bool willRenew,  SubscriptionSyncPhase syncPhase)?  active,TResult? Function( SubscriptionSyncPhase syncPhase)?  inactive,}) {final _that = this;
switch (_that) {
case SubscriptionStatusActive() when active != null:
return active(_that.productId,_that.expiresAt,_that.willRenew,_that.syncPhase);case SubscriptionStatusInactive() when inactive != null:
return inactive(_that.syncPhase);case _:
  return null;

}
}

}

/// @nodoc


class SubscriptionStatusActive implements SubscriptionStatus {
  const SubscriptionStatusActive({required this.productId, this.expiresAt, this.willRenew = true, this.syncPhase = SubscriptionSyncPhase.idle});
  

 final  String productId;
 final  DateTime? expiresAt;
@JsonKey() final  bool willRenew;
@override@JsonKey() final  SubscriptionSyncPhase syncPhase;

/// Create a copy of SubscriptionStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStatusActiveCopyWith<SubscriptionStatusActive> get copyWith => _$SubscriptionStatusActiveCopyWithImpl<SubscriptionStatusActive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatusActive&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.willRenew, willRenew) || other.willRenew == willRenew)&&(identical(other.syncPhase, syncPhase) || other.syncPhase == syncPhase));
}


@override
int get hashCode => Object.hash(runtimeType,productId,expiresAt,willRenew,syncPhase);

@override
String toString() {
  return 'SubscriptionStatus.active(productId: $productId, expiresAt: $expiresAt, willRenew: $willRenew, syncPhase: $syncPhase)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStatusActiveCopyWith<$Res> implements $SubscriptionStatusCopyWith<$Res> {
  factory $SubscriptionStatusActiveCopyWith(SubscriptionStatusActive value, $Res Function(SubscriptionStatusActive) _then) = _$SubscriptionStatusActiveCopyWithImpl;
@override @useResult
$Res call({
 String productId, DateTime? expiresAt, bool willRenew, SubscriptionSyncPhase syncPhase
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
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? expiresAt = freezed,Object? willRenew = null,Object? syncPhase = null,}) {
  return _then(SubscriptionStatusActive(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,willRenew: null == willRenew ? _self.willRenew : willRenew // ignore: cast_nullable_to_non_nullable
as bool,syncPhase: null == syncPhase ? _self.syncPhase : syncPhase // ignore: cast_nullable_to_non_nullable
as SubscriptionSyncPhase,
  ));
}


}

/// @nodoc


class SubscriptionStatusInactive implements SubscriptionStatus {
  const SubscriptionStatusInactive({this.syncPhase = SubscriptionSyncPhase.idle});
  

@override@JsonKey() final  SubscriptionSyncPhase syncPhase;

/// Create a copy of SubscriptionStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStatusInactiveCopyWith<SubscriptionStatusInactive> get copyWith => _$SubscriptionStatusInactiveCopyWithImpl<SubscriptionStatusInactive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatusInactive&&(identical(other.syncPhase, syncPhase) || other.syncPhase == syncPhase));
}


@override
int get hashCode => Object.hash(runtimeType,syncPhase);

@override
String toString() {
  return 'SubscriptionStatus.inactive(syncPhase: $syncPhase)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStatusInactiveCopyWith<$Res> implements $SubscriptionStatusCopyWith<$Res> {
  factory $SubscriptionStatusInactiveCopyWith(SubscriptionStatusInactive value, $Res Function(SubscriptionStatusInactive) _then) = _$SubscriptionStatusInactiveCopyWithImpl;
@override @useResult
$Res call({
 SubscriptionSyncPhase syncPhase
});




}
/// @nodoc
class _$SubscriptionStatusInactiveCopyWithImpl<$Res>
    implements $SubscriptionStatusInactiveCopyWith<$Res> {
  _$SubscriptionStatusInactiveCopyWithImpl(this._self, this._then);

  final SubscriptionStatusInactive _self;
  final $Res Function(SubscriptionStatusInactive) _then;

/// Create a copy of SubscriptionStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? syncPhase = null,}) {
  return _then(SubscriptionStatusInactive(
syncPhase: null == syncPhase ? _self.syncPhase : syncPhase // ignore: cast_nullable_to_non_nullable
as SubscriptionSyncPhase,
  ));
}


}

// dart format on
