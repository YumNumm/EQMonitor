// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_constraint_variants.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanConstraintVariants {

 PlanConstraints get free; PlanConstraints get subscription;
/// Create a copy of PlanConstraintVariants
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanConstraintVariantsCopyWith<PlanConstraintVariants> get copyWith => _$PlanConstraintVariantsCopyWithImpl<PlanConstraintVariants>(this as PlanConstraintVariants, _$identity);

  /// Serializes this PlanConstraintVariants to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanConstraintVariants&&(identical(other.free, free) || other.free == free)&&(identical(other.subscription, subscription) || other.subscription == subscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free,subscription);

@override
String toString() {
  return 'PlanConstraintVariants(free: $free, subscription: $subscription)';
}


}

/// @nodoc
abstract mixin class $PlanConstraintVariantsCopyWith<$Res>  {
  factory $PlanConstraintVariantsCopyWith(PlanConstraintVariants value, $Res Function(PlanConstraintVariants) _then) = _$PlanConstraintVariantsCopyWithImpl;
@useResult
$Res call({
 PlanConstraints free, PlanConstraints subscription
});


$PlanConstraintsCopyWith<$Res> get free;$PlanConstraintsCopyWith<$Res> get subscription;

}
/// @nodoc
class _$PlanConstraintVariantsCopyWithImpl<$Res>
    implements $PlanConstraintVariantsCopyWith<$Res> {
  _$PlanConstraintVariantsCopyWithImpl(this._self, this._then);

  final PlanConstraintVariants _self;
  final $Res Function(PlanConstraintVariants) _then;

/// Create a copy of PlanConstraintVariants
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? free = null,Object? subscription = null,}) {
  return _then(PlanConstraintVariants(
free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as PlanConstraints,subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as PlanConstraints,
  ));
}
/// Create a copy of PlanConstraintVariants
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanConstraintsCopyWith<$Res> get free {
  
  return $PlanConstraintsCopyWith<$Res>(_self.free, (value) {
    return _then(_self.copyWith(free: value));
  });
}/// Create a copy of PlanConstraintVariants
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanConstraintsCopyWith<$Res> get subscription {
  
  return $PlanConstraintsCopyWith<$Res>(_self.subscription, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanConstraintVariants].
extension PlanConstraintVariantsPatterns on PlanConstraintVariants {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanConstraintVariants value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanConstraintVariants() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanConstraintVariants value)  $default,){
final _that = this;
switch (_that) {
case _PlanConstraintVariants():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanConstraintVariants value)?  $default,){
final _that = this;
switch (_that) {
case _PlanConstraintVariants() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlanConstraints free,  PlanConstraints subscription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanConstraintVariants() when $default != null:
return $default(_that.free,_that.subscription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlanConstraints free,  PlanConstraints subscription)  $default,) {final _that = this;
switch (_that) {
case _PlanConstraintVariants():
return $default(_that.free,_that.subscription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlanConstraints free,  PlanConstraints subscription)?  $default,) {final _that = this;
switch (_that) {
case _PlanConstraintVariants() when $default != null:
return $default(_that.free,_that.subscription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanConstraintVariants implements PlanConstraintVariants {
  const _PlanConstraintVariants({required this.free, required this.subscription});
  factory _PlanConstraintVariants.fromJson(Map<String, dynamic> json) => _$PlanConstraintVariantsFromJson(json);

@override final  PlanConstraints free;
@override final  PlanConstraints subscription;

/// Create a copy of PlanConstraintVariants
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanConstraintVariantsCopyWith<_PlanConstraintVariants> get copyWith => __$PlanConstraintVariantsCopyWithImpl<_PlanConstraintVariants>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanConstraintVariantsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanConstraintVariants&&(identical(other.free, free) || other.free == free)&&(identical(other.subscription, subscription) || other.subscription == subscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free,subscription);

@override
String toString() {
  return 'PlanConstraintVariants(free: $free, subscription: $subscription)';
}


}

/// @nodoc
abstract mixin class _$PlanConstraintVariantsCopyWith<$Res> implements $PlanConstraintVariantsCopyWith<$Res> {
  factory _$PlanConstraintVariantsCopyWith(_PlanConstraintVariants value, $Res Function(_PlanConstraintVariants) _then) = __$PlanConstraintVariantsCopyWithImpl;
@override @useResult
$Res call({
 PlanConstraints free, PlanConstraints subscription
});


@override $PlanConstraintsCopyWith<$Res> get free;@override $PlanConstraintsCopyWith<$Res> get subscription;

}
/// @nodoc
class __$PlanConstraintVariantsCopyWithImpl<$Res>
    implements _$PlanConstraintVariantsCopyWith<$Res> {
  __$PlanConstraintVariantsCopyWithImpl(this._self, this._then);

  final _PlanConstraintVariants _self;
  final $Res Function(_PlanConstraintVariants) _then;

/// Create a copy of PlanConstraintVariants
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? free = null,Object? subscription = null,}) {
  return _then(_PlanConstraintVariants(
free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as PlanConstraints,subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as PlanConstraints,
  ));
}

/// Create a copy of PlanConstraintVariants
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanConstraintsCopyWith<$Res> get free {
  
  return $PlanConstraintsCopyWith<$Res>(_self.free, (value) {
    return _then(_self.copyWith(free: value));
  });
}/// Create a copy of PlanConstraintVariants
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanConstraintsCopyWith<$Res> get subscription {
  
  return $PlanConstraintsCopyWith<$Res>(_self.subscription, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}
}

// dart format on
