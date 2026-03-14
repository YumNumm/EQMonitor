// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_station_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityStationItem {

 CodeName get value;/// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値
 num get sva;/// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
 List<PrePeriods> get prePeriods;@JsonKey(includeIfNull: false, name: 'max_intensity') JmaIntensity? get maxIntensity;@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') JmaLpgmIntensity? get maxLpgmIntensity;
/// Create a copy of IntensityStationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityStationItemCopyWith<IntensityStationItem> get copyWith => _$IntensityStationItemCopyWithImpl<IntensityStationItem>(this as IntensityStationItem, _$identity);

  /// Serializes this IntensityStationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityStationItem&&(identical(other.value, value) || other.value == value)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other.prePeriods, prePeriods)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,sva,const DeepCollectionEquality().hash(prePeriods),maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensityStationItem(value: $value, sva: $sva, prePeriods: $prePeriods, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityStationItemCopyWith<$Res>  {
  factory $IntensityStationItemCopyWith(IntensityStationItem value, $Res Function(IntensityStationItem) _then) = _$IntensityStationItemCopyWithImpl;
@useResult
$Res call({
 CodeName value, num sva, List<PrePeriods> prePeriods,@JsonKey(includeIfNull: false, name: 'max_intensity') JmaIntensity? maxIntensity,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') JmaLpgmIntensity? maxLpgmIntensity
});


$CodeNameCopyWith<$Res> get value;

}
/// @nodoc
class _$IntensityStationItemCopyWithImpl<$Res>
    implements $IntensityStationItemCopyWith<$Res> {
  _$IntensityStationItemCopyWithImpl(this._self, this._then);

  final IntensityStationItem _self;
  final $Res Function(IntensityStationItem) _then;

/// Create a copy of IntensityStationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? sva = null,Object? prePeriods = null,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,sva: null == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num,prePeriods: null == prePeriods ? _self.prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriods>,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}
/// Create a copy of IntensityStationItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityStationItem].
extension IntensityStationItemPatterns on IntensityStationItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityStationItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityStationItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityStationItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityStationItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityStationItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityStationItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CodeName value,  num sva,  List<PrePeriods> prePeriods, @JsonKey(includeIfNull: false, name: 'max_intensity')  JmaIntensity? maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  JmaLpgmIntensity? maxLpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityStationItem() when $default != null:
return $default(_that.value,_that.sva,_that.prePeriods,_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CodeName value,  num sva,  List<PrePeriods> prePeriods, @JsonKey(includeIfNull: false, name: 'max_intensity')  JmaIntensity? maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  JmaLpgmIntensity? maxLpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityStationItem():
return $default(_that.value,_that.sva,_that.prePeriods,_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CodeName value,  num sva,  List<PrePeriods> prePeriods, @JsonKey(includeIfNull: false, name: 'max_intensity')  JmaIntensity? maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  JmaLpgmIntensity? maxLpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityStationItem() when $default != null:
return $default(_that.value,_that.sva,_that.prePeriods,_that.maxIntensity,_that.maxLpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityStationItem implements IntensityStationItem {
  const _IntensityStationItem({required this.value, required this.sva, required final  List<PrePeriods> prePeriods, @JsonKey(includeIfNull: false, name: 'max_intensity') this.maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') this.maxLpgmIntensity}): _prePeriods = prePeriods;
  factory _IntensityStationItem.fromJson(Map<String, dynamic> json) => _$IntensityStationItemFromJson(json);

@override final  CodeName value;
/// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値
@override final  num sva;
/// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
 final  List<PrePeriods> _prePeriods;
/// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
@override List<PrePeriods> get prePeriods {
  if (_prePeriods is EqualUnmodifiableListView) return _prePeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prePeriods);
}

@override@JsonKey(includeIfNull: false, name: 'max_intensity') final  JmaIntensity? maxIntensity;
@override@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') final  JmaLpgmIntensity? maxLpgmIntensity;

/// Create a copy of IntensityStationItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityStationItemCopyWith<_IntensityStationItem> get copyWith => __$IntensityStationItemCopyWithImpl<_IntensityStationItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityStationItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityStationItem&&(identical(other.value, value) || other.value == value)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other._prePeriods, _prePeriods)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,sva,const DeepCollectionEquality().hash(_prePeriods),maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensityStationItem(value: $value, sva: $sva, prePeriods: $prePeriods, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityStationItemCopyWith<$Res> implements $IntensityStationItemCopyWith<$Res> {
  factory _$IntensityStationItemCopyWith(_IntensityStationItem value, $Res Function(_IntensityStationItem) _then) = __$IntensityStationItemCopyWithImpl;
@override @useResult
$Res call({
 CodeName value, num sva, List<PrePeriods> prePeriods,@JsonKey(includeIfNull: false, name: 'max_intensity') JmaIntensity? maxIntensity,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') JmaLpgmIntensity? maxLpgmIntensity
});


@override $CodeNameCopyWith<$Res> get value;

}
/// @nodoc
class __$IntensityStationItemCopyWithImpl<$Res>
    implements _$IntensityStationItemCopyWith<$Res> {
  __$IntensityStationItemCopyWithImpl(this._self, this._then);

  final _IntensityStationItem _self;
  final $Res Function(_IntensityStationItem) _then;

/// Create a copy of IntensityStationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? sva = null,Object? prePeriods = null,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,}) {
  return _then(_IntensityStationItem(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,sva: null == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num,prePeriods: null == prePeriods ? _self._prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriods>,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}

/// Create a copy of IntensityStationItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}

// dart format on
