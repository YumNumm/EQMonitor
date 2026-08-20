// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_max_intensity_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CityMaxIntensityItem {

/// 市区町村コード（気象庁防災情報XMLフォーマット コード表の7桁コード）
@JsonKey(name: 'city_id') String get cityId;@JsonKey(name: 'max_intensity') JmaIntensity get maxIntensity;
/// Create a copy of CityMaxIntensityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityMaxIntensityItemCopyWith<CityMaxIntensityItem> get copyWith => _$CityMaxIntensityItemCopyWithImpl<CityMaxIntensityItem>(this as CityMaxIntensityItem, _$identity);

  /// Serializes this CityMaxIntensityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityMaxIntensityItem&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cityId,maxIntensity);

@override
String toString() {
  return 'CityMaxIntensityItem(cityId: $cityId, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class $CityMaxIntensityItemCopyWith<$Res>  {
  factory $CityMaxIntensityItemCopyWith(CityMaxIntensityItem value, $Res Function(CityMaxIntensityItem) _then) = _$CityMaxIntensityItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'city_id') String cityId,@JsonKey(name: 'max_intensity') JmaIntensity maxIntensity
});




}
/// @nodoc
class _$CityMaxIntensityItemCopyWithImpl<$Res>
    implements $CityMaxIntensityItemCopyWith<$Res> {
  _$CityMaxIntensityItemCopyWithImpl(this._self, this._then);

  final CityMaxIntensityItem _self;
  final $Res Function(CityMaxIntensityItem) _then;

/// Create a copy of CityMaxIntensityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cityId = null,Object? maxIntensity = null,}) {
  return _then(CityMaxIntensityItem(
cityId: null == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,
  ));
}

}


/// Adds pattern-matching-related methods to [CityMaxIntensityItem].
extension CityMaxIntensityItemPatterns on CityMaxIntensityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityMaxIntensityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityMaxIntensityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityMaxIntensityItem value)  $default,){
final _that = this;
switch (_that) {
case _CityMaxIntensityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityMaxIntensityItem value)?  $default,){
final _that = this;
switch (_that) {
case _CityMaxIntensityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'city_id')  String cityId, @JsonKey(name: 'max_intensity')  JmaIntensity maxIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityMaxIntensityItem() when $default != null:
return $default(_that.cityId,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'city_id')  String cityId, @JsonKey(name: 'max_intensity')  JmaIntensity maxIntensity)  $default,) {final _that = this;
switch (_that) {
case _CityMaxIntensityItem():
return $default(_that.cityId,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'city_id')  String cityId, @JsonKey(name: 'max_intensity')  JmaIntensity maxIntensity)?  $default,) {final _that = this;
switch (_that) {
case _CityMaxIntensityItem() when $default != null:
return $default(_that.cityId,_that.maxIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityMaxIntensityItem implements CityMaxIntensityItem {
  const _CityMaxIntensityItem({@JsonKey(name: 'city_id') required this.cityId, @JsonKey(name: 'max_intensity') required this.maxIntensity});
  factory _CityMaxIntensityItem.fromJson(Map<String, dynamic> json) => _$CityMaxIntensityItemFromJson(json);

/// 市区町村コード（気象庁防災情報XMLフォーマット コード表の7桁コード）
@override@JsonKey(name: 'city_id') final  String cityId;
@override@JsonKey(name: 'max_intensity') final  JmaIntensity maxIntensity;

/// Create a copy of CityMaxIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityMaxIntensityItemCopyWith<_CityMaxIntensityItem> get copyWith => __$CityMaxIntensityItemCopyWithImpl<_CityMaxIntensityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityMaxIntensityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityMaxIntensityItem&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cityId,maxIntensity);

@override
String toString() {
  return 'CityMaxIntensityItem(cityId: $cityId, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class _$CityMaxIntensityItemCopyWith<$Res> implements $CityMaxIntensityItemCopyWith<$Res> {
  factory _$CityMaxIntensityItemCopyWith(_CityMaxIntensityItem value, $Res Function(_CityMaxIntensityItem) _then) = __$CityMaxIntensityItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'city_id') String cityId,@JsonKey(name: 'max_intensity') JmaIntensity maxIntensity
});




}
/// @nodoc
class __$CityMaxIntensityItemCopyWithImpl<$Res>
    implements _$CityMaxIntensityItemCopyWith<$Res> {
  __$CityMaxIntensityItemCopyWithImpl(this._self, this._then);

  final _CityMaxIntensityItem _self;
  final $Res Function(_CityMaxIntensityItem) _then;

/// Create a copy of CityMaxIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cityId = null,Object? maxIntensity = null,}) {
  return _then(_CityMaxIntensityItem(
cityId: null == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,
  ));
}


}

// dart format on
