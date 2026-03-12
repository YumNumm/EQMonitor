// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_station_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityStationInfo {

 String get code; String get name;@JsonKey(includeIfNull: true) Intensity? get intensity;@JsonKey(includeIfNull: true, name: 'lpgm_intensity') LpgmIntensity? get lpgmIntensity;@JsonKey(includeIfNull: true) num? get sva;@JsonKey(includeIfNull: true, name: 'pre_periods') List<PrePeriods2>? get prePeriods;
/// Create a copy of IntensityStationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityStationInfoCopyWith<IntensityStationInfo> get copyWith => _$IntensityStationInfoCopyWithImpl<IntensityStationInfo>(this as IntensityStationInfo, _$identity);

  /// Serializes this IntensityStationInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityStationInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other.prePeriods, prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity,sva,const DeepCollectionEquality().hash(prePeriods));

@override
String toString() {
  return 'IntensityStationInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class $IntensityStationInfoCopyWith<$Res>  {
  factory $IntensityStationInfoCopyWith(IntensityStationInfo value, $Res Function(IntensityStationInfo) _then) = _$IntensityStationInfoCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(includeIfNull: true) Intensity? intensity,@JsonKey(includeIfNull: true, name: 'lpgm_intensity') LpgmIntensity? lpgmIntensity,@JsonKey(includeIfNull: true) num? sva,@JsonKey(includeIfNull: true, name: 'pre_periods') List<PrePeriods2>? prePeriods
});


$IntensityCopyWith<$Res>? get intensity;

}
/// @nodoc
class _$IntensityStationInfoCopyWithImpl<$Res>
    implements $IntensityStationInfoCopyWith<$Res> {
  _$IntensityStationInfoCopyWithImpl(this._self, this._then);

  final IntensityStationInfo _self;
  final $Res Function(IntensityStationInfo) _then;

/// Create a copy of IntensityStationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as Intensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensity?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num?,prePeriods: freezed == prePeriods ? _self.prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriods2>?,
  ));
}
/// Create a copy of IntensityStationInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityStationInfo].
extension IntensityStationInfoPatterns on IntensityStationInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityStationInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityStationInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityStationInfo value)  $default,){
final _that = this;
switch (_that) {
case _IntensityStationInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityStationInfo value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityStationInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(includeIfNull: true)  Intensity? intensity, @JsonKey(includeIfNull: true, name: 'lpgm_intensity')  LpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: true)  num? sva, @JsonKey(includeIfNull: true, name: 'pre_periods')  List<PrePeriods2>? prePeriods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityStationInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(includeIfNull: true)  Intensity? intensity, @JsonKey(includeIfNull: true, name: 'lpgm_intensity')  LpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: true)  num? sva, @JsonKey(includeIfNull: true, name: 'pre_periods')  List<PrePeriods2>? prePeriods)  $default,) {final _that = this;
switch (_that) {
case _IntensityStationInfo():
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name, @JsonKey(includeIfNull: true)  Intensity? intensity, @JsonKey(includeIfNull: true, name: 'lpgm_intensity')  LpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: true)  num? sva, @JsonKey(includeIfNull: true, name: 'pre_periods')  List<PrePeriods2>? prePeriods)?  $default,) {final _that = this;
switch (_that) {
case _IntensityStationInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityStationInfo implements IntensityStationInfo {
  const _IntensityStationInfo({required this.code, required this.name, @JsonKey(includeIfNull: true) required this.intensity, @JsonKey(includeIfNull: true, name: 'lpgm_intensity') required this.lpgmIntensity, @JsonKey(includeIfNull: true) required this.sva, @JsonKey(includeIfNull: true, name: 'pre_periods') required final  List<PrePeriods2>? prePeriods}): _prePeriods = prePeriods;
  factory _IntensityStationInfo.fromJson(Map<String, dynamic> json) => _$IntensityStationInfoFromJson(json);

@override final  String code;
@override final  String name;
@override@JsonKey(includeIfNull: true) final  Intensity? intensity;
@override@JsonKey(includeIfNull: true, name: 'lpgm_intensity') final  LpgmIntensity? lpgmIntensity;
@override@JsonKey(includeIfNull: true) final  num? sva;
 final  List<PrePeriods2>? _prePeriods;
@override@JsonKey(includeIfNull: true, name: 'pre_periods') List<PrePeriods2>? get prePeriods {
  final value = _prePeriods;
  if (value == null) return null;
  if (_prePeriods is EqualUnmodifiableListView) return _prePeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of IntensityStationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityStationInfoCopyWith<_IntensityStationInfo> get copyWith => __$IntensityStationInfoCopyWithImpl<_IntensityStationInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityStationInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityStationInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other._prePeriods, _prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity,sva,const DeepCollectionEquality().hash(_prePeriods));

@override
String toString() {
  return 'IntensityStationInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class _$IntensityStationInfoCopyWith<$Res> implements $IntensityStationInfoCopyWith<$Res> {
  factory _$IntensityStationInfoCopyWith(_IntensityStationInfo value, $Res Function(_IntensityStationInfo) _then) = __$IntensityStationInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(includeIfNull: true) Intensity? intensity,@JsonKey(includeIfNull: true, name: 'lpgm_intensity') LpgmIntensity? lpgmIntensity,@JsonKey(includeIfNull: true) num? sva,@JsonKey(includeIfNull: true, name: 'pre_periods') List<PrePeriods2>? prePeriods
});


@override $IntensityCopyWith<$Res>? get intensity;

}
/// @nodoc
class __$IntensityStationInfoCopyWithImpl<$Res>
    implements _$IntensityStationInfoCopyWith<$Res> {
  __$IntensityStationInfoCopyWithImpl(this._self, this._then);

  final _IntensityStationInfo _self;
  final $Res Function(_IntensityStationInfo) _then;

/// Create a copy of IntensityStationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_IntensityStationInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as Intensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensity?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num?,prePeriods: freezed == prePeriods ? _self._prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriods2>?,
  ));
}

/// Create a copy of IntensityStationInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}

// dart format on
