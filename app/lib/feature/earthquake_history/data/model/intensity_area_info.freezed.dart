// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_area_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityAreaInfo {

 String get code; String get name; JmaIntensity? get intensity; JmaLpgmIntensity? get lpgmIntensity;
/// Create a copy of IntensityAreaInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityAreaInfoCopyWith<IntensityAreaInfo> get copyWith => _$IntensityAreaInfoCopyWithImpl<IntensityAreaInfo>(this as IntensityAreaInfo, _$identity);

  /// Serializes this IntensityAreaInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityAreaInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity);

@override
String toString() {
  return 'IntensityAreaInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityAreaInfoCopyWith<$Res>  {
  factory $IntensityAreaInfoCopyWith(IntensityAreaInfo value, $Res Function(IntensityAreaInfo) _then) = _$IntensityAreaInfoCopyWithImpl;
@useResult
$Res call({
 String code, String name, JmaIntensity? intensity, JmaLpgmIntensity? lpgmIntensity
});




}
/// @nodoc
class _$IntensityAreaInfoCopyWithImpl<$Res>
    implements $IntensityAreaInfoCopyWith<$Res> {
  _$IntensityAreaInfoCopyWithImpl(this._self, this._then);

  final IntensityAreaInfo _self;
  final $Res Function(IntensityAreaInfo) _then;

/// Create a copy of IntensityAreaInfo
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


/// Adds pattern-matching-related methods to [IntensityAreaInfo].
extension IntensityAreaInfoPatterns on IntensityAreaInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityAreaInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityAreaInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityAreaInfo value)  $default,){
final _that = this;
switch (_that) {
case _IntensityAreaInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityAreaInfo value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityAreaInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  JmaIntensity? intensity,  JmaLpgmIntensity? lpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityAreaInfo() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  JmaIntensity? intensity,  JmaLpgmIntensity? lpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityAreaInfo():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  JmaIntensity? intensity,  JmaLpgmIntensity? lpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityAreaInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityAreaInfo implements IntensityAreaInfo {
  const _IntensityAreaInfo({required this.code, required this.name, required this.intensity, required this.lpgmIntensity});
  factory _IntensityAreaInfo.fromJson(Map<String, dynamic> json) => _$IntensityAreaInfoFromJson(json);

@override final  String code;
@override final  String name;
@override final  JmaIntensity? intensity;
@override final  JmaLpgmIntensity? lpgmIntensity;

/// Create a copy of IntensityAreaInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityAreaInfoCopyWith<_IntensityAreaInfo> get copyWith => __$IntensityAreaInfoCopyWithImpl<_IntensityAreaInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityAreaInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityAreaInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity);

@override
String toString() {
  return 'IntensityAreaInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityAreaInfoCopyWith<$Res> implements $IntensityAreaInfoCopyWith<$Res> {
  factory _$IntensityAreaInfoCopyWith(_IntensityAreaInfo value, $Res Function(_IntensityAreaInfo) _then) = __$IntensityAreaInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, JmaIntensity? intensity, JmaLpgmIntensity? lpgmIntensity
});




}
/// @nodoc
class __$IntensityAreaInfoCopyWithImpl<$Res>
    implements _$IntensityAreaInfoCopyWith<$Res> {
  __$IntensityAreaInfoCopyWithImpl(this._self, this._then);

  final _IntensityAreaInfo _self;
  final $Res Function(_IntensityAreaInfo) _then;

/// Create a copy of IntensityAreaInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,}) {
  return _then(_IntensityAreaInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}


}

// dart format on
