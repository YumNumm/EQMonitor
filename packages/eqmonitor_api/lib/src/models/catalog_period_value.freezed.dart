// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_period_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogPeriodValue {

 CatalogPeriodKind get kind;/// flagのみ記録され数値が欠測の行が実データに存在するため省略される場合がある
@JsonKey(includeIfNull: false) num? get value;
/// Create a copy of CatalogPeriodValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogPeriodValueCopyWith<CatalogPeriodValue> get copyWith => _$CatalogPeriodValueCopyWithImpl<CatalogPeriodValue>(this as CatalogPeriodValue, _$identity);

  /// Serializes this CatalogPeriodValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogPeriodValue&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,value);

@override
String toString() {
  return 'CatalogPeriodValue(kind: $kind, value: $value)';
}


}

/// @nodoc
abstract mixin class $CatalogPeriodValueCopyWith<$Res>  {
  factory $CatalogPeriodValueCopyWith(CatalogPeriodValue value, $Res Function(CatalogPeriodValue) _then) = _$CatalogPeriodValueCopyWithImpl;
@useResult
$Res call({
 CatalogPeriodKind kind,@JsonKey(includeIfNull: false) num? value
});




}
/// @nodoc
class _$CatalogPeriodValueCopyWithImpl<$Res>
    implements $CatalogPeriodValueCopyWith<$Res> {
  _$CatalogPeriodValueCopyWithImpl(this._self, this._then);

  final CatalogPeriodValue _self;
  final $Res Function(CatalogPeriodValue) _then;

/// Create a copy of CatalogPeriodValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? value = freezed,}) {
  return _then(CatalogPeriodValue(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CatalogPeriodKind,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogPeriodValue].
extension CatalogPeriodValuePatterns on CatalogPeriodValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogPeriodValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogPeriodValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogPeriodValue value)  $default,){
final _that = this;
switch (_that) {
case _CatalogPeriodValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogPeriodValue value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogPeriodValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CatalogPeriodKind kind, @JsonKey(includeIfNull: false)  num? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogPeriodValue() when $default != null:
return $default(_that.kind,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CatalogPeriodKind kind, @JsonKey(includeIfNull: false)  num? value)  $default,) {final _that = this;
switch (_that) {
case _CatalogPeriodValue():
return $default(_that.kind,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CatalogPeriodKind kind, @JsonKey(includeIfNull: false)  num? value)?  $default,) {final _that = this;
switch (_that) {
case _CatalogPeriodValue() when $default != null:
return $default(_that.kind,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogPeriodValue implements CatalogPeriodValue {
  const _CatalogPeriodValue({required this.kind, @JsonKey(includeIfNull: false) this.value});
  factory _CatalogPeriodValue.fromJson(Map<String, dynamic> json) => _$CatalogPeriodValueFromJson(json);

@override final  CatalogPeriodKind kind;
/// flagのみ記録され数値が欠測の行が実データに存在するため省略される場合がある
@override@JsonKey(includeIfNull: false) final  num? value;

/// Create a copy of CatalogPeriodValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogPeriodValueCopyWith<_CatalogPeriodValue> get copyWith => __$CatalogPeriodValueCopyWithImpl<_CatalogPeriodValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogPeriodValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogPeriodValue&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,value);

@override
String toString() {
  return 'CatalogPeriodValue(kind: $kind, value: $value)';
}


}

/// @nodoc
abstract mixin class _$CatalogPeriodValueCopyWith<$Res> implements $CatalogPeriodValueCopyWith<$Res> {
  factory _$CatalogPeriodValueCopyWith(_CatalogPeriodValue value, $Res Function(_CatalogPeriodValue) _then) = __$CatalogPeriodValueCopyWithImpl;
@override @useResult
$Res call({
 CatalogPeriodKind kind,@JsonKey(includeIfNull: false) num? value
});




}
/// @nodoc
class __$CatalogPeriodValueCopyWithImpl<$Res>
    implements _$CatalogPeriodValueCopyWith<$Res> {
  __$CatalogPeriodValueCopyWithImpl(this._self, this._then);

  final _CatalogPeriodValue _self;
  final $Res Function(_CatalogPeriodValue) _then;

/// Create a copy of CatalogPeriodValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? value = freezed,}) {
  return _then(_CatalogPeriodValue(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CatalogPeriodKind,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
