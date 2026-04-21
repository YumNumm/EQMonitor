// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsHypocenter {

 int get regionCode; String get originTime; String? get regionName; double? get magnitude; double? get depthKm;
/// Create a copy of WsHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsHypocenterCopyWith<WsHypocenter> get copyWith => _$WsHypocenterCopyWithImpl<WsHypocenter>(this as WsHypocenter, _$identity);

  /// Serializes this WsHypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsHypocenter&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionCode,originTime,regionName,magnitude,depthKm);

@override
String toString() {
  return 'WsHypocenter(regionCode: $regionCode, originTime: $originTime, regionName: $regionName, magnitude: $magnitude, depthKm: $depthKm)';
}


}

/// @nodoc
abstract mixin class $WsHypocenterCopyWith<$Res>  {
  factory $WsHypocenterCopyWith(WsHypocenter value, $Res Function(WsHypocenter) _then) = _$WsHypocenterCopyWithImpl;
@useResult
$Res call({
 int regionCode, String originTime, String? regionName, double? magnitude, double? depthKm
});




}
/// @nodoc
class _$WsHypocenterCopyWithImpl<$Res>
    implements $WsHypocenterCopyWith<$Res> {
  _$WsHypocenterCopyWithImpl(this._self, this._then);

  final WsHypocenter _self;
  final $Res Function(WsHypocenter) _then;

/// Create a copy of WsHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionCode = null,Object? originTime = null,Object? regionName = freezed,Object? magnitude = freezed,Object? depthKm = freezed,}) {
  return _then(_self.copyWith(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as int,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [WsHypocenter].
extension WsHypocenterPatterns on WsHypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsHypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsHypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsHypocenter value)  $default,){
final _that = this;
switch (_that) {
case _WsHypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsHypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _WsHypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int regionCode,  String originTime,  String? regionName,  double? magnitude,  double? depthKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsHypocenter() when $default != null:
return $default(_that.regionCode,_that.originTime,_that.regionName,_that.magnitude,_that.depthKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int regionCode,  String originTime,  String? regionName,  double? magnitude,  double? depthKm)  $default,) {final _that = this;
switch (_that) {
case _WsHypocenter():
return $default(_that.regionCode,_that.originTime,_that.regionName,_that.magnitude,_that.depthKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int regionCode,  String originTime,  String? regionName,  double? magnitude,  double? depthKm)?  $default,) {final _that = this;
switch (_that) {
case _WsHypocenter() when $default != null:
return $default(_that.regionCode,_that.originTime,_that.regionName,_that.magnitude,_that.depthKm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsHypocenter implements WsHypocenter {
  const _WsHypocenter({required this.regionCode, required this.originTime, this.regionName, this.magnitude, this.depthKm});
  factory _WsHypocenter.fromJson(Map<String, dynamic> json) => _$WsHypocenterFromJson(json);

@override final  int regionCode;
@override final  String originTime;
@override final  String? regionName;
@override final  double? magnitude;
@override final  double? depthKm;

/// Create a copy of WsHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsHypocenterCopyWith<_WsHypocenter> get copyWith => __$WsHypocenterCopyWithImpl<_WsHypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsHypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsHypocenter&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionCode,originTime,regionName,magnitude,depthKm);

@override
String toString() {
  return 'WsHypocenter(regionCode: $regionCode, originTime: $originTime, regionName: $regionName, magnitude: $magnitude, depthKm: $depthKm)';
}


}

/// @nodoc
abstract mixin class _$WsHypocenterCopyWith<$Res> implements $WsHypocenterCopyWith<$Res> {
  factory _$WsHypocenterCopyWith(_WsHypocenter value, $Res Function(_WsHypocenter) _then) = __$WsHypocenterCopyWithImpl;
@override @useResult
$Res call({
 int regionCode, String originTime, String? regionName, double? magnitude, double? depthKm
});




}
/// @nodoc
class __$WsHypocenterCopyWithImpl<$Res>
    implements _$WsHypocenterCopyWith<$Res> {
  __$WsHypocenterCopyWithImpl(this._self, this._then);

  final _WsHypocenter _self;
  final $Res Function(_WsHypocenter) _then;

/// Create a copy of WsHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionCode = null,Object? originTime = null,Object? regionName = freezed,Object? magnitude = freezed,Object? depthKm = freezed,}) {
  return _then(_WsHypocenter(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as int,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
