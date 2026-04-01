// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_region_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityRegionInfo {

 String get code; String get name;@JsonKey(includeIfNull: true) JmaIntensity? get intensity;@JsonKey(includeIfNull: true, name: 'lpgm_intensity') JmaLpgmIntensity? get lpgmIntensity;
/// Create a copy of IntensityRegionInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<IntensityRegionInfo> get copyWith => _$IntensityRegionInfoCopyWithImpl<IntensityRegionInfo>(this as IntensityRegionInfo, _$identity);

  /// Serializes this IntensityRegionInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityRegionInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity);

@override
String toString() {
  return 'IntensityRegionInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityRegionInfoCopyWith<$Res>  {
  factory $IntensityRegionInfoCopyWith(IntensityRegionInfo value, $Res Function(IntensityRegionInfo) _then) = _$IntensityRegionInfoCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(includeIfNull: true) JmaIntensity? intensity,@JsonKey(includeIfNull: true, name: 'lpgm_intensity') JmaLpgmIntensity? lpgmIntensity
});




}
/// @nodoc
class _$IntensityRegionInfoCopyWithImpl<$Res>
    implements $IntensityRegionInfoCopyWith<$Res> {
  _$IntensityRegionInfoCopyWithImpl(this._self, this._then);

  final IntensityRegionInfo _self;
  final $Res Function(IntensityRegionInfo) _then;

/// Create a copy of IntensityRegionInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityRegionInfo].
extension IntensityRegionInfoPatterns on IntensityRegionInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityRegionInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityRegionInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityRegionInfo value)  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityRegionInfo value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(includeIfNull: true)  JmaIntensity? intensity, @JsonKey(includeIfNull: true, name: 'lpgm_intensity')  JmaLpgmIntensity? lpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityRegionInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(includeIfNull: true)  JmaIntensity? intensity, @JsonKey(includeIfNull: true, name: 'lpgm_intensity')  JmaLpgmIntensity? lpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionInfo():
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name, @JsonKey(includeIfNull: true)  JmaIntensity? intensity, @JsonKey(includeIfNull: true, name: 'lpgm_intensity')  JmaLpgmIntensity? lpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityRegionInfo implements IntensityRegionInfo {
  const _IntensityRegionInfo({required this.code, required this.name, @JsonKey(includeIfNull: true) required this.intensity, @JsonKey(includeIfNull: true, name: 'lpgm_intensity') required this.lpgmIntensity});
  factory _IntensityRegionInfo.fromJson(Map<String, dynamic> json) => _$IntensityRegionInfoFromJson(json);

@override final  String code;
@override final  String name;
@override@JsonKey(includeIfNull: true) final  JmaIntensity? intensity;
@override@JsonKey(includeIfNull: true, name: 'lpgm_intensity') final  JmaLpgmIntensity? lpgmIntensity;

/// Create a copy of IntensityRegionInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityRegionInfoCopyWith<_IntensityRegionInfo> get copyWith => __$IntensityRegionInfoCopyWithImpl<_IntensityRegionInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityRegionInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityRegionInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity);

@override
String toString() {
  return 'IntensityRegionInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityRegionInfoCopyWith<$Res> implements $IntensityRegionInfoCopyWith<$Res> {
  factory _$IntensityRegionInfoCopyWith(_IntensityRegionInfo value, $Res Function(_IntensityRegionInfo) _then) = __$IntensityRegionInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(includeIfNull: true) JmaIntensity? intensity,@JsonKey(includeIfNull: true, name: 'lpgm_intensity') JmaLpgmIntensity? lpgmIntensity
});




}
/// @nodoc
class __$IntensityRegionInfoCopyWithImpl<$Res>
    implements _$IntensityRegionInfoCopyWith<$Res> {
  __$IntensityRegionInfoCopyWithImpl(this._self, this._then);

  final _IntensityRegionInfo _self;
  final $Res Function(_IntensityRegionInfo) _then;

/// Create a copy of IntensityRegionInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,}) {
  return _then(_IntensityRegionInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}


}

// dart format on
