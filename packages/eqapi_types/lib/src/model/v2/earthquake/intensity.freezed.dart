// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityItem {

 CodeName get value; IntensityValue? get maxIntensity; LpgmIntensityValue? get maxLpgmIntensity;
/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityItemCopyWith<IntensityItem> get copyWith => _$IntensityItemCopyWithImpl<IntensityItem>(this as IntensityItem, _$identity);

  /// Serializes this IntensityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityItem&&(identical(other.value, value) || other.value == value)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensityItem(value: $value, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityItemCopyWith<$Res>  {
  factory $IntensityItemCopyWith(IntensityItem value, $Res Function(IntensityItem) _then) = _$IntensityItemCopyWithImpl;
@useResult
$Res call({
 CodeName value, IntensityValue? maxIntensity, LpgmIntensityValue? maxLpgmIntensity
});


$CodeNameCopyWith<$Res> get value;

}
/// @nodoc
class _$IntensityItemCopyWithImpl<$Res>
    implements $IntensityItemCopyWith<$Res> {
  _$IntensityItemCopyWithImpl(this._self, this._then);

  final IntensityItem _self;
  final $Res Function(IntensityItem) _then;

/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,
  ));
}
/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityItem].
extension IntensityItemPatterns on IntensityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CodeName value,  IntensityValue? maxIntensity,  LpgmIntensityValue? maxLpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityItem() when $default != null:
return $default(_that.value,_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CodeName value,  IntensityValue? maxIntensity,  LpgmIntensityValue? maxLpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityItem():
return $default(_that.value,_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CodeName value,  IntensityValue? maxIntensity,  LpgmIntensityValue? maxLpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityItem() when $default != null:
return $default(_that.value,_that.maxIntensity,_that.maxLpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityItem implements IntensityItem {
  const _IntensityItem({required this.value, this.maxIntensity, this.maxLpgmIntensity});
  factory _IntensityItem.fromJson(Map<String, dynamic> json) => _$IntensityItemFromJson(json);

@override final  CodeName value;
@override final  IntensityValue? maxIntensity;
@override final  LpgmIntensityValue? maxLpgmIntensity;

/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityItemCopyWith<_IntensityItem> get copyWith => __$IntensityItemCopyWithImpl<_IntensityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityItem&&(identical(other.value, value) || other.value == value)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensityItem(value: $value, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityItemCopyWith<$Res> implements $IntensityItemCopyWith<$Res> {
  factory _$IntensityItemCopyWith(_IntensityItem value, $Res Function(_IntensityItem) _then) = __$IntensityItemCopyWithImpl;
@override @useResult
$Res call({
 CodeName value, IntensityValue? maxIntensity, LpgmIntensityValue? maxLpgmIntensity
});


@override $CodeNameCopyWith<$Res> get value;

}
/// @nodoc
class __$IntensityItemCopyWithImpl<$Res>
    implements _$IntensityItemCopyWith<$Res> {
  __$IntensityItemCopyWithImpl(this._self, this._then);

  final _IntensityItem _self;
  final $Res Function(_IntensityItem) _then;

/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,}) {
  return _then(_IntensityItem(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,
  ));
}

/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}


/// @nodoc
mixin _$PrePeriod {

 int get band; LpgmIntensityValue get lpgmIntensity; double get sva;
/// Create a copy of PrePeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrePeriodCopyWith<PrePeriod> get copyWith => _$PrePeriodCopyWithImpl<PrePeriod>(this as PrePeriod, _$identity);

  /// Serializes this PrePeriod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrePeriod&&(identical(other.band, band) || other.band == band)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,band,lpgmIntensity,sva);

@override
String toString() {
  return 'PrePeriod(band: $band, lpgmIntensity: $lpgmIntensity, sva: $sva)';
}


}

/// @nodoc
abstract mixin class $PrePeriodCopyWith<$Res>  {
  factory $PrePeriodCopyWith(PrePeriod value, $Res Function(PrePeriod) _then) = _$PrePeriodCopyWithImpl;
@useResult
$Res call({
 int band, LpgmIntensityValue lpgmIntensity, double sva
});




}
/// @nodoc
class _$PrePeriodCopyWithImpl<$Res>
    implements $PrePeriodCopyWith<$Res> {
  _$PrePeriodCopyWithImpl(this._self, this._then);

  final PrePeriod _self;
  final $Res Function(PrePeriod) _then;

/// Create a copy of PrePeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? band = null,Object? lpgmIntensity = null,Object? sva = null,}) {
  return _then(_self.copyWith(
band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as int,lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue,sva: null == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PrePeriod].
extension PrePeriodPatterns on PrePeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrePeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrePeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrePeriod value)  $default,){
final _that = this;
switch (_that) {
case _PrePeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrePeriod value)?  $default,){
final _that = this;
switch (_that) {
case _PrePeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int band,  LpgmIntensityValue lpgmIntensity,  double sva)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrePeriod() when $default != null:
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int band,  LpgmIntensityValue lpgmIntensity,  double sva)  $default,) {final _that = this;
switch (_that) {
case _PrePeriod():
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int band,  LpgmIntensityValue lpgmIntensity,  double sva)?  $default,) {final _that = this;
switch (_that) {
case _PrePeriod() when $default != null:
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrePeriod implements PrePeriod {
  const _PrePeriod({required this.band, required this.lpgmIntensity, required this.sva});
  factory _PrePeriod.fromJson(Map<String, dynamic> json) => _$PrePeriodFromJson(json);

@override final  int band;
@override final  LpgmIntensityValue lpgmIntensity;
@override final  double sva;

/// Create a copy of PrePeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrePeriodCopyWith<_PrePeriod> get copyWith => __$PrePeriodCopyWithImpl<_PrePeriod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrePeriodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrePeriod&&(identical(other.band, band) || other.band == band)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,band,lpgmIntensity,sva);

@override
String toString() {
  return 'PrePeriod(band: $band, lpgmIntensity: $lpgmIntensity, sva: $sva)';
}


}

/// @nodoc
abstract mixin class _$PrePeriodCopyWith<$Res> implements $PrePeriodCopyWith<$Res> {
  factory _$PrePeriodCopyWith(_PrePeriod value, $Res Function(_PrePeriod) _then) = __$PrePeriodCopyWithImpl;
@override @useResult
$Res call({
 int band, LpgmIntensityValue lpgmIntensity, double sva
});




}
/// @nodoc
class __$PrePeriodCopyWithImpl<$Res>
    implements _$PrePeriodCopyWith<$Res> {
  __$PrePeriodCopyWithImpl(this._self, this._then);

  final _PrePeriod _self;
  final $Res Function(_PrePeriod) _then;

/// Create a copy of PrePeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? band = null,Object? lpgmIntensity = null,Object? sva = null,}) {
  return _then(_PrePeriod(
band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as int,lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue,sva: null == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$IntensityStationItem {

 CodeName get value; IntensityValue? get maxIntensity; LpgmIntensityValue? get maxLpgmIntensity;/// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値
 double? get sva;/// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
 List<PrePeriod>? get prePeriods;
/// Create a copy of IntensityStationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityStationItemCopyWith<IntensityStationItem> get copyWith => _$IntensityStationItemCopyWithImpl<IntensityStationItem>(this as IntensityStationItem, _$identity);

  /// Serializes this IntensityStationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityStationItem&&(identical(other.value, value) || other.value == value)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other.prePeriods, prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,maxIntensity,maxLpgmIntensity,sva,const DeepCollectionEquality().hash(prePeriods));

@override
String toString() {
  return 'IntensityStationItem(value: $value, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class $IntensityStationItemCopyWith<$Res>  {
  factory $IntensityStationItemCopyWith(IntensityStationItem value, $Res Function(IntensityStationItem) _then) = _$IntensityStationItemCopyWithImpl;
@useResult
$Res call({
 CodeName value, IntensityValue? maxIntensity, LpgmIntensityValue? maxLpgmIntensity, double? sva, List<PrePeriod>? prePeriods
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
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double?,prePeriods: freezed == prePeriods ? _self.prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriod>?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CodeName value,  IntensityValue? maxIntensity,  LpgmIntensityValue? maxLpgmIntensity,  double? sva,  List<PrePeriod>? prePeriods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityStationItem() when $default != null:
return $default(_that.value,_that.maxIntensity,_that.maxLpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CodeName value,  IntensityValue? maxIntensity,  LpgmIntensityValue? maxLpgmIntensity,  double? sva,  List<PrePeriod>? prePeriods)  $default,) {final _that = this;
switch (_that) {
case _IntensityStationItem():
return $default(_that.value,_that.maxIntensity,_that.maxLpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CodeName value,  IntensityValue? maxIntensity,  LpgmIntensityValue? maxLpgmIntensity,  double? sva,  List<PrePeriod>? prePeriods)?  $default,) {final _that = this;
switch (_that) {
case _IntensityStationItem() when $default != null:
return $default(_that.value,_that.maxIntensity,_that.maxLpgmIntensity,_that.sva,_that.prePeriods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityStationItem implements IntensityStationItem {
  const _IntensityStationItem({required this.value, this.maxIntensity, this.maxLpgmIntensity, this.sva, final  List<PrePeriod>? prePeriods}): _prePeriods = prePeriods;
  factory _IntensityStationItem.fromJson(Map<String, dynamic> json) => _$IntensityStationItemFromJson(json);

@override final  CodeName value;
@override final  IntensityValue? maxIntensity;
@override final  LpgmIntensityValue? maxLpgmIntensity;
/// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値
@override final  double? sva;
/// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
 final  List<PrePeriod>? _prePeriods;
/// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
@override List<PrePeriod>? get prePeriods {
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityStationItem&&(identical(other.value, value) || other.value == value)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other._prePeriods, _prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,maxIntensity,maxLpgmIntensity,sva,const DeepCollectionEquality().hash(_prePeriods));

@override
String toString() {
  return 'IntensityStationItem(value: $value, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class _$IntensityStationItemCopyWith<$Res> implements $IntensityStationItemCopyWith<$Res> {
  factory _$IntensityStationItemCopyWith(_IntensityStationItem value, $Res Function(_IntensityStationItem) _then) = __$IntensityStationItemCopyWithImpl;
@override @useResult
$Res call({
 CodeName value, IntensityValue? maxIntensity, LpgmIntensityValue? maxLpgmIntensity, double? sva, List<PrePeriod>? prePeriods
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
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_IntensityStationItem(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double?,prePeriods: freezed == prePeriods ? _self._prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriod>?,
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


/// @nodoc
mixin _$Intensity {

 IntensityValue get maxIntensity; LpgmIntensityValue? get maxLpgmIntensity; List<IntensityItem> get prefectures; List<IntensityItem> get regions; List<IntensityItem>? get cities; List<IntensityStationItem>? get stations;
/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityCopyWith<Intensity> get copyWith => _$IntensityCopyWithImpl<Intensity>(this as Intensity, _$identity);

  /// Serializes this Intensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Intensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other.prefectures, prefectures)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.cities, cities)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(prefectures),const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(cities),const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'Intensity(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, prefectures: $prefectures, regions: $regions, cities: $cities, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $IntensityCopyWith<$Res>  {
  factory $IntensityCopyWith(Intensity value, $Res Function(Intensity) _then) = _$IntensityCopyWithImpl;
@useResult
$Res call({
 IntensityValue maxIntensity, LpgmIntensityValue? maxLpgmIntensity, List<IntensityItem> prefectures, List<IntensityItem> regions, List<IntensityItem>? cities, List<IntensityStationItem>? stations
});




}
/// @nodoc
class _$IntensityCopyWithImpl<$Res>
    implements $IntensityCopyWith<$Res> {
  _$IntensityCopyWithImpl(this._self, this._then);

  final Intensity _self;
  final $Res Function(Intensity) _then;

/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? prefectures = null,Object? regions = null,Object? cities = freezed,Object? stations = freezed,}) {
  return _then(_self.copyWith(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,prefectures: null == prefectures ? _self.prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,cities: freezed == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>?,stations: freezed == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<IntensityStationItem>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Intensity].
extension IntensityPatterns on Intensity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Intensity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Intensity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Intensity value)  $default,){
final _that = this;
switch (_that) {
case _Intensity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Intensity value)?  $default,){
final _that = this;
switch (_that) {
case _Intensity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IntensityValue maxIntensity,  LpgmIntensityValue? maxLpgmIntensity,  List<IntensityItem> prefectures,  List<IntensityItem> regions,  List<IntensityItem>? cities,  List<IntensityStationItem>? stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Intensity() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.prefectures,_that.regions,_that.cities,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IntensityValue maxIntensity,  LpgmIntensityValue? maxLpgmIntensity,  List<IntensityItem> prefectures,  List<IntensityItem> regions,  List<IntensityItem>? cities,  List<IntensityStationItem>? stations)  $default,) {final _that = this;
switch (_that) {
case _Intensity():
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.prefectures,_that.regions,_that.cities,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IntensityValue maxIntensity,  LpgmIntensityValue? maxLpgmIntensity,  List<IntensityItem> prefectures,  List<IntensityItem> regions,  List<IntensityItem>? cities,  List<IntensityStationItem>? stations)?  $default,) {final _that = this;
switch (_that) {
case _Intensity() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.prefectures,_that.regions,_that.cities,_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Intensity implements Intensity {
  const _Intensity({required this.maxIntensity, this.maxLpgmIntensity, required final  List<IntensityItem> prefectures, required final  List<IntensityItem> regions, final  List<IntensityItem>? cities, final  List<IntensityStationItem>? stations}): _prefectures = prefectures,_regions = regions,_cities = cities,_stations = stations;
  factory _Intensity.fromJson(Map<String, dynamic> json) => _$IntensityFromJson(json);

@override final  IntensityValue maxIntensity;
@override final  LpgmIntensityValue? maxLpgmIntensity;
 final  List<IntensityItem> _prefectures;
@override List<IntensityItem> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}

 final  List<IntensityItem> _regions;
@override List<IntensityItem> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<IntensityItem>? _cities;
@override List<IntensityItem>? get cities {
  final value = _cities;
  if (value == null) return null;
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<IntensityStationItem>? _stations;
@override List<IntensityStationItem>? get stations {
  final value = _stations;
  if (value == null) return null;
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityCopyWith<_Intensity> get copyWith => __$IntensityCopyWithImpl<_Intensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Intensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._cities, _cities)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(_prefectures),const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_cities),const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'Intensity(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, prefectures: $prefectures, regions: $regions, cities: $cities, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$IntensityCopyWith<$Res> implements $IntensityCopyWith<$Res> {
  factory _$IntensityCopyWith(_Intensity value, $Res Function(_Intensity) _then) = __$IntensityCopyWithImpl;
@override @useResult
$Res call({
 IntensityValue maxIntensity, LpgmIntensityValue? maxLpgmIntensity, List<IntensityItem> prefectures, List<IntensityItem> regions, List<IntensityItem>? cities, List<IntensityStationItem>? stations
});




}
/// @nodoc
class __$IntensityCopyWithImpl<$Res>
    implements _$IntensityCopyWith<$Res> {
  __$IntensityCopyWithImpl(this._self, this._then);

  final _Intensity _self;
  final $Res Function(_Intensity) _then;

/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? prefectures = null,Object? regions = null,Object? cities = freezed,Object? stations = freezed,}) {
  return _then(_Intensity(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,cities: freezed == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>?,stations: freezed == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<IntensityStationItem>?,
  ));
}


}


/// @nodoc
mixin _$IntensityPartial {

 IntensityValue get maxIntensity; LpgmIntensityValue? get maxLpgmIntensity; List<IntensityItem> get prefectures; List<IntensityItem> get regions;
/// Create a copy of IntensityPartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityPartialCopyWith<IntensityPartial> get copyWith => _$IntensityPartialCopyWithImpl<IntensityPartial>(this as IntensityPartial, _$identity);

  /// Serializes this IntensityPartial to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityPartial&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other.prefectures, prefectures)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(prefectures),const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'IntensityPartial(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, prefectures: $prefectures, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $IntensityPartialCopyWith<$Res>  {
  factory $IntensityPartialCopyWith(IntensityPartial value, $Res Function(IntensityPartial) _then) = _$IntensityPartialCopyWithImpl;
@useResult
$Res call({
 IntensityValue maxIntensity, LpgmIntensityValue? maxLpgmIntensity, List<IntensityItem> prefectures, List<IntensityItem> regions
});




}
/// @nodoc
class _$IntensityPartialCopyWithImpl<$Res>
    implements $IntensityPartialCopyWith<$Res> {
  _$IntensityPartialCopyWithImpl(this._self, this._then);

  final IntensityPartial _self;
  final $Res Function(IntensityPartial) _then;

/// Create a copy of IntensityPartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? prefectures = null,Object? regions = null,}) {
  return _then(_self.copyWith(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,prefectures: null == prefectures ? _self.prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityPartial].
extension IntensityPartialPatterns on IntensityPartial {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityPartial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityPartial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityPartial value)  $default,){
final _that = this;
switch (_that) {
case _IntensityPartial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityPartial value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityPartial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IntensityValue maxIntensity,  LpgmIntensityValue? maxLpgmIntensity,  List<IntensityItem> prefectures,  List<IntensityItem> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityPartial() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.prefectures,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IntensityValue maxIntensity,  LpgmIntensityValue? maxLpgmIntensity,  List<IntensityItem> prefectures,  List<IntensityItem> regions)  $default,) {final _that = this;
switch (_that) {
case _IntensityPartial():
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.prefectures,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IntensityValue maxIntensity,  LpgmIntensityValue? maxLpgmIntensity,  List<IntensityItem> prefectures,  List<IntensityItem> regions)?  $default,) {final _that = this;
switch (_that) {
case _IntensityPartial() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.prefectures,_that.regions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityPartial implements IntensityPartial {
  const _IntensityPartial({required this.maxIntensity, this.maxLpgmIntensity, required final  List<IntensityItem> prefectures, required final  List<IntensityItem> regions}): _prefectures = prefectures,_regions = regions;
  factory _IntensityPartial.fromJson(Map<String, dynamic> json) => _$IntensityPartialFromJson(json);

@override final  IntensityValue maxIntensity;
@override final  LpgmIntensityValue? maxLpgmIntensity;
 final  List<IntensityItem> _prefectures;
@override List<IntensityItem> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}

 final  List<IntensityItem> _regions;
@override List<IntensityItem> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of IntensityPartial
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityPartialCopyWith<_IntensityPartial> get copyWith => __$IntensityPartialCopyWithImpl<_IntensityPartial>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityPartialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityPartial&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(_prefectures),const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'IntensityPartial(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, prefectures: $prefectures, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$IntensityPartialCopyWith<$Res> implements $IntensityPartialCopyWith<$Res> {
  factory _$IntensityPartialCopyWith(_IntensityPartial value, $Res Function(_IntensityPartial) _then) = __$IntensityPartialCopyWithImpl;
@override @useResult
$Res call({
 IntensityValue maxIntensity, LpgmIntensityValue? maxLpgmIntensity, List<IntensityItem> prefectures, List<IntensityItem> regions
});




}
/// @nodoc
class __$IntensityPartialCopyWithImpl<$Res>
    implements _$IntensityPartialCopyWith<$Res> {
  __$IntensityPartialCopyWithImpl(this._self, this._then);

  final _IntensityPartial _self;
  final $Res Function(_IntensityPartial) _then;

/// Create a copy of IntensityPartial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? prefectures = null,Object? regions = null,}) {
  return _then(_IntensityPartial(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,
  ));
}


}

// dart format on
