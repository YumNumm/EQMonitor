// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimated_intensity_hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EstimatedIntensityHypocenter {

 num get regionCode; String get originTime;@JsonKey(includeIfNull: false) String? get regionName;@JsonKey(includeIfNull: false) num? get magnitude;@JsonKey(includeIfNull: false) num? get depthKm;
/// Create a copy of EstimatedIntensityHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimatedIntensityHypocenterCopyWith<EstimatedIntensityHypocenter> get copyWith => _$EstimatedIntensityHypocenterCopyWithImpl<EstimatedIntensityHypocenter>(this as EstimatedIntensityHypocenter, _$identity);

  /// Serializes this EstimatedIntensityHypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimatedIntensityHypocenter&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionCode,originTime,regionName,magnitude,depthKm);

@override
String toString() {
  return 'EstimatedIntensityHypocenter(regionCode: $regionCode, originTime: $originTime, regionName: $regionName, magnitude: $magnitude, depthKm: $depthKm)';
}


}

/// @nodoc
abstract mixin class $EstimatedIntensityHypocenterCopyWith<$Res>  {
  factory $EstimatedIntensityHypocenterCopyWith(EstimatedIntensityHypocenter value, $Res Function(EstimatedIntensityHypocenter) _then) = _$EstimatedIntensityHypocenterCopyWithImpl;
@useResult
$Res call({
 num regionCode, String originTime,@JsonKey(includeIfNull: false) String? regionName,@JsonKey(includeIfNull: false) num? magnitude,@JsonKey(includeIfNull: false) num? depthKm
});




}
/// @nodoc
class _$EstimatedIntensityHypocenterCopyWithImpl<$Res>
    implements $EstimatedIntensityHypocenterCopyWith<$Res> {
  _$EstimatedIntensityHypocenterCopyWithImpl(this._self, this._then);

  final EstimatedIntensityHypocenter _self;
  final $Res Function(EstimatedIntensityHypocenter) _then;

/// Create a copy of EstimatedIntensityHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionCode = null,Object? originTime = null,Object? regionName = freezed,Object? magnitude = freezed,Object? depthKm = freezed,}) {
  return _then(_self.copyWith(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as num,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as num?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [EstimatedIntensityHypocenter].
extension EstimatedIntensityHypocenterPatterns on EstimatedIntensityHypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimatedIntensityHypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimatedIntensityHypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimatedIntensityHypocenter value)  $default,){
final _that = this;
switch (_that) {
case _EstimatedIntensityHypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimatedIntensityHypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _EstimatedIntensityHypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num regionCode,  String originTime, @JsonKey(includeIfNull: false)  String? regionName, @JsonKey(includeIfNull: false)  num? magnitude, @JsonKey(includeIfNull: false)  num? depthKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimatedIntensityHypocenter() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num regionCode,  String originTime, @JsonKey(includeIfNull: false)  String? regionName, @JsonKey(includeIfNull: false)  num? magnitude, @JsonKey(includeIfNull: false)  num? depthKm)  $default,) {final _that = this;
switch (_that) {
case _EstimatedIntensityHypocenter():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num regionCode,  String originTime, @JsonKey(includeIfNull: false)  String? regionName, @JsonKey(includeIfNull: false)  num? magnitude, @JsonKey(includeIfNull: false)  num? depthKm)?  $default,) {final _that = this;
switch (_that) {
case _EstimatedIntensityHypocenter() when $default != null:
return $default(_that.regionCode,_that.originTime,_that.regionName,_that.magnitude,_that.depthKm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstimatedIntensityHypocenter implements EstimatedIntensityHypocenter {
  const _EstimatedIntensityHypocenter({required this.regionCode, required this.originTime, @JsonKey(includeIfNull: false) this.regionName, @JsonKey(includeIfNull: false) this.magnitude, @JsonKey(includeIfNull: false) this.depthKm});
  factory _EstimatedIntensityHypocenter.fromJson(Map<String, dynamic> json) => _$EstimatedIntensityHypocenterFromJson(json);

@override final  num regionCode;
@override final  String originTime;
@override@JsonKey(includeIfNull: false) final  String? regionName;
@override@JsonKey(includeIfNull: false) final  num? magnitude;
@override@JsonKey(includeIfNull: false) final  num? depthKm;

/// Create a copy of EstimatedIntensityHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimatedIntensityHypocenterCopyWith<_EstimatedIntensityHypocenter> get copyWith => __$EstimatedIntensityHypocenterCopyWithImpl<_EstimatedIntensityHypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimatedIntensityHypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimatedIntensityHypocenter&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionCode,originTime,regionName,magnitude,depthKm);

@override
String toString() {
  return 'EstimatedIntensityHypocenter(regionCode: $regionCode, originTime: $originTime, regionName: $regionName, magnitude: $magnitude, depthKm: $depthKm)';
}


}

/// @nodoc
abstract mixin class _$EstimatedIntensityHypocenterCopyWith<$Res> implements $EstimatedIntensityHypocenterCopyWith<$Res> {
  factory _$EstimatedIntensityHypocenterCopyWith(_EstimatedIntensityHypocenter value, $Res Function(_EstimatedIntensityHypocenter) _then) = __$EstimatedIntensityHypocenterCopyWithImpl;
@override @useResult
$Res call({
 num regionCode, String originTime,@JsonKey(includeIfNull: false) String? regionName,@JsonKey(includeIfNull: false) num? magnitude,@JsonKey(includeIfNull: false) num? depthKm
});




}
/// @nodoc
class __$EstimatedIntensityHypocenterCopyWithImpl<$Res>
    implements _$EstimatedIntensityHypocenterCopyWith<$Res> {
  __$EstimatedIntensityHypocenterCopyWithImpl(this._self, this._then);

  final _EstimatedIntensityHypocenter _self;
  final $Res Function(_EstimatedIntensityHypocenter) _then;

/// Create a copy of EstimatedIntensityHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionCode = null,Object? originTime = null,Object? regionName = freezed,Object? magnitude = freezed,Object? depthKm = freezed,}) {
  return _then(_EstimatedIntensityHypocenter(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as num,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as num?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
