// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_hypocenter_depth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogHypocenterDepth {

/// 震源の深さ(km)
 num get value;/// 深さフリー条件（震源評価コード1）で計算された震源かどうか
@JsonKey(name: 'is_free') bool get isFree;/// 震源の深さの標準誤差(km)
@JsonKey(includeIfNull: false) num? get stderr;
/// Create a copy of CatalogHypocenterDepth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogHypocenterDepthCopyWith<CatalogHypocenterDepth> get copyWith => _$CatalogHypocenterDepthCopyWithImpl<CatalogHypocenterDepth>(this as CatalogHypocenterDepth, _$identity);

  /// Serializes this CatalogHypocenterDepth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogHypocenterDepth&&(identical(other.value, value) || other.value == value)&&(identical(other.isFree, isFree) || other.isFree == isFree)&&(identical(other.stderr, stderr) || other.stderr == stderr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isFree,stderr);

@override
String toString() {
  return 'CatalogHypocenterDepth(value: $value, isFree: $isFree, stderr: $stderr)';
}


}

/// @nodoc
abstract mixin class $CatalogHypocenterDepthCopyWith<$Res>  {
  factory $CatalogHypocenterDepthCopyWith(CatalogHypocenterDepth value, $Res Function(CatalogHypocenterDepth) _then) = _$CatalogHypocenterDepthCopyWithImpl;
@useResult
$Res call({
 num value,@JsonKey(name: 'is_free') bool isFree,@JsonKey(includeIfNull: false) num? stderr
});




}
/// @nodoc
class _$CatalogHypocenterDepthCopyWithImpl<$Res>
    implements $CatalogHypocenterDepthCopyWith<$Res> {
  _$CatalogHypocenterDepthCopyWithImpl(this._self, this._then);

  final CatalogHypocenterDepth _self;
  final $Res Function(CatalogHypocenterDepth) _then;

/// Create a copy of CatalogHypocenterDepth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? isFree = null,Object? stderr = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,isFree: null == isFree ? _self.isFree : isFree // ignore: cast_nullable_to_non_nullable
as bool,stderr: freezed == stderr ? _self.stderr : stderr // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogHypocenterDepth].
extension CatalogHypocenterDepthPatterns on CatalogHypocenterDepth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogHypocenterDepth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogHypocenterDepth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogHypocenterDepth value)  $default,){
final _that = this;
switch (_that) {
case _CatalogHypocenterDepth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogHypocenterDepth value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogHypocenterDepth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num value, @JsonKey(name: 'is_free')  bool isFree, @JsonKey(includeIfNull: false)  num? stderr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogHypocenterDepth() when $default != null:
return $default(_that.value,_that.isFree,_that.stderr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num value, @JsonKey(name: 'is_free')  bool isFree, @JsonKey(includeIfNull: false)  num? stderr)  $default,) {final _that = this;
switch (_that) {
case _CatalogHypocenterDepth():
return $default(_that.value,_that.isFree,_that.stderr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num value, @JsonKey(name: 'is_free')  bool isFree, @JsonKey(includeIfNull: false)  num? stderr)?  $default,) {final _that = this;
switch (_that) {
case _CatalogHypocenterDepth() when $default != null:
return $default(_that.value,_that.isFree,_that.stderr);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogHypocenterDepth implements CatalogHypocenterDepth {
  const _CatalogHypocenterDepth({required this.value, @JsonKey(name: 'is_free') required this.isFree, @JsonKey(includeIfNull: false) this.stderr});
  factory _CatalogHypocenterDepth.fromJson(Map<String, dynamic> json) => _$CatalogHypocenterDepthFromJson(json);

/// 震源の深さ(km)
@override final  num value;
/// 深さフリー条件（震源評価コード1）で計算された震源かどうか
@override@JsonKey(name: 'is_free') final  bool isFree;
/// 震源の深さの標準誤差(km)
@override@JsonKey(includeIfNull: false) final  num? stderr;

/// Create a copy of CatalogHypocenterDepth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogHypocenterDepthCopyWith<_CatalogHypocenterDepth> get copyWith => __$CatalogHypocenterDepthCopyWithImpl<_CatalogHypocenterDepth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogHypocenterDepthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogHypocenterDepth&&(identical(other.value, value) || other.value == value)&&(identical(other.isFree, isFree) || other.isFree == isFree)&&(identical(other.stderr, stderr) || other.stderr == stderr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isFree,stderr);

@override
String toString() {
  return 'CatalogHypocenterDepth(value: $value, isFree: $isFree, stderr: $stderr)';
}


}

/// @nodoc
abstract mixin class _$CatalogHypocenterDepthCopyWith<$Res> implements $CatalogHypocenterDepthCopyWith<$Res> {
  factory _$CatalogHypocenterDepthCopyWith(_CatalogHypocenterDepth value, $Res Function(_CatalogHypocenterDepth) _then) = __$CatalogHypocenterDepthCopyWithImpl;
@override @useResult
$Res call({
 num value,@JsonKey(name: 'is_free') bool isFree,@JsonKey(includeIfNull: false) num? stderr
});




}
/// @nodoc
class __$CatalogHypocenterDepthCopyWithImpl<$Res>
    implements _$CatalogHypocenterDepthCopyWith<$Res> {
  __$CatalogHypocenterDepthCopyWithImpl(this._self, this._then);

  final _CatalogHypocenterDepth _self;
  final $Res Function(_CatalogHypocenterDepth) _then;

/// Create a copy of CatalogHypocenterDepth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? isFree = null,Object? stderr = freezed,}) {
  return _then(_CatalogHypocenterDepth(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,isFree: null == isFree ? _self.isFree : isFree // ignore: cast_nullable_to_non_nullable
as bool,stderr: freezed == stderr ? _self.stderr : stderr // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
