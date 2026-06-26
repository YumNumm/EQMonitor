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

/// 観測点ID
 String get code;/// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値
@JsonKey(includeIfNull: false) num? get sva;/// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
@JsonKey(includeIfNull: false, name: 'pre_periods') List<LpgmPrePeriod>? get prePeriods;
/// Create a copy of IntensityStationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityStationItemCopyWith<IntensityStationItem> get copyWith => _$IntensityStationItemCopyWithImpl<IntensityStationItem>(this as IntensityStationItem, _$identity);

  /// Serializes this IntensityStationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityStationItem&&(identical(other.code, code) || other.code == code)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other.prePeriods, prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,sva,const DeepCollectionEquality().hash(prePeriods));

@override
String toString() {
  return 'IntensityStationItem(code: $code, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class $IntensityStationItemCopyWith<$Res>  {
  factory $IntensityStationItemCopyWith(IntensityStationItem value, $Res Function(IntensityStationItem) _then) = _$IntensityStationItemCopyWithImpl;
@useResult
$Res call({
 String code,@JsonKey(includeIfNull: false) num? sva,@JsonKey(includeIfNull: false, name: 'pre_periods') List<LpgmPrePeriod>? prePeriods
});




}
/// @nodoc
class _$IntensityStationItemCopyWithImpl<$Res>
    implements $IntensityStationItemCopyWith<$Res> {
  _$IntensityStationItemCopyWithImpl(this._self, this._then);

  final IntensityStationItem _self;
  final $Res Function(IntensityStationItem) _then;

/// Create a copy of IntensityStationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num?,prePeriods: freezed == prePeriods ? _self.prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<LpgmPrePeriod>?,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code, @JsonKey(includeIfNull: false)  num? sva, @JsonKey(includeIfNull: false, name: 'pre_periods')  List<LpgmPrePeriod>? prePeriods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityStationItem() when $default != null:
return $default(_that.code,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code, @JsonKey(includeIfNull: false)  num? sva, @JsonKey(includeIfNull: false, name: 'pre_periods')  List<LpgmPrePeriod>? prePeriods)  $default,) {final _that = this;
switch (_that) {
case _IntensityStationItem():
return $default(_that.code,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code, @JsonKey(includeIfNull: false)  num? sva, @JsonKey(includeIfNull: false, name: 'pre_periods')  List<LpgmPrePeriod>? prePeriods)?  $default,) {final _that = this;
switch (_that) {
case _IntensityStationItem() when $default != null:
return $default(_that.code,_that.sva,_that.prePeriods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityStationItem implements IntensityStationItem {
  const _IntensityStationItem({required this.code, @JsonKey(includeIfNull: false) this.sva, @JsonKey(includeIfNull: false, name: 'pre_periods') final  List<LpgmPrePeriod>? prePeriods}): _prePeriods = prePeriods;
  factory _IntensityStationItem.fromJson(Map<String, dynamic> json) => _$IntensityStationItemFromJson(json);

/// 観測点ID
@override final  String code;
/// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値
@override@JsonKey(includeIfNull: false) final  num? sva;
/// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
 final  List<LpgmPrePeriod>? _prePeriods;
/// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
@override@JsonKey(includeIfNull: false, name: 'pre_periods') List<LpgmPrePeriod>? get prePeriods {
  final value = _prePeriods;
  if (value == null) return null;
  if (_prePeriods is EqualUnmodifiableListView) return _prePeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityStationItem&&(identical(other.code, code) || other.code == code)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other._prePeriods, _prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,sva,const DeepCollectionEquality().hash(_prePeriods));

@override
String toString() {
  return 'IntensityStationItem(code: $code, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class _$IntensityStationItemCopyWith<$Res> implements $IntensityStationItemCopyWith<$Res> {
  factory _$IntensityStationItemCopyWith(_IntensityStationItem value, $Res Function(_IntensityStationItem) _then) = __$IntensityStationItemCopyWithImpl;
@override @useResult
$Res call({
 String code,@JsonKey(includeIfNull: false) num? sva,@JsonKey(includeIfNull: false, name: 'pre_periods') List<LpgmPrePeriod>? prePeriods
});




}
/// @nodoc
class __$IntensityStationItemCopyWithImpl<$Res>
    implements _$IntensityStationItemCopyWith<$Res> {
  __$IntensityStationItemCopyWithImpl(this._self, this._then);

  final _IntensityStationItem _self;
  final $Res Function(_IntensityStationItem) _then;

/// Create a copy of IntensityStationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_IntensityStationItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num?,prePeriods: freezed == prePeriods ? _self._prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<LpgmPrePeriod>?,
  ));
}


}

// dart format on
