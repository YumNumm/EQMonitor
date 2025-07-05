// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParameterRegion {

 String get code; String get name; String get kana;
/// Create a copy of ParameterRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterRegionCopyWith<ParameterRegion> get copyWith => _$ParameterRegionCopyWithImpl<ParameterRegion>(this as ParameterRegion, _$identity);

  /// Serializes this ParameterRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana);

@override
String toString() {
  return 'ParameterRegion(code: $code, name: $name, kana: $kana)';
}


}

/// @nodoc
abstract mixin class $ParameterRegionCopyWith<$Res>  {
  factory $ParameterRegionCopyWith(ParameterRegion value, $Res Function(ParameterRegion) _then) = _$ParameterRegionCopyWithImpl;
@useResult
$Res call({
 String code, String name, String kana
});




}
/// @nodoc
class _$ParameterRegionCopyWithImpl<$Res>
    implements $ParameterRegionCopyWith<$Res> {
  _$ParameterRegionCopyWithImpl(this._self, this._then);

  final ParameterRegion _self;
  final $Res Function(ParameterRegion) _then;

/// Create a copy of ParameterRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kana = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kana: null == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ParameterRegion implements ParameterRegion {
  const _ParameterRegion({required this.code, required this.name, required this.kana});
  factory _ParameterRegion.fromJson(Map<String, dynamic> json) => _$ParameterRegionFromJson(json);

@override final  String code;
@override final  String name;
@override final  String kana;

/// Create a copy of ParameterRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParameterRegionCopyWith<_ParameterRegion> get copyWith => __$ParameterRegionCopyWithImpl<_ParameterRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParameterRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParameterRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana);

@override
String toString() {
  return 'ParameterRegion(code: $code, name: $name, kana: $kana)';
}


}

/// @nodoc
abstract mixin class _$ParameterRegionCopyWith<$Res> implements $ParameterRegionCopyWith<$Res> {
  factory _$ParameterRegionCopyWith(_ParameterRegion value, $Res Function(_ParameterRegion) _then) = __$ParameterRegionCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String kana
});




}
/// @nodoc
class __$ParameterRegionCopyWithImpl<$Res>
    implements _$ParameterRegionCopyWith<$Res> {
  __$ParameterRegionCopyWithImpl(this._self, this._then);

  final _ParameterRegion _self;
  final $Res Function(_ParameterRegion) _then;

/// Create a copy of ParameterRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kana = null,}) {
  return _then(_ParameterRegion(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kana: null == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ParameterCity {

 String get code; String get name; String get kana;
/// Create a copy of ParameterCity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterCityCopyWith<ParameterCity> get copyWith => _$ParameterCityCopyWithImpl<ParameterCity>(this as ParameterCity, _$identity);

  /// Serializes this ParameterCity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterCity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana);

@override
String toString() {
  return 'ParameterCity(code: $code, name: $name, kana: $kana)';
}


}

/// @nodoc
abstract mixin class $ParameterCityCopyWith<$Res>  {
  factory $ParameterCityCopyWith(ParameterCity value, $Res Function(ParameterCity) _then) = _$ParameterCityCopyWithImpl;
@useResult
$Res call({
 String code, String name, String kana
});




}
/// @nodoc
class _$ParameterCityCopyWithImpl<$Res>
    implements $ParameterCityCopyWith<$Res> {
  _$ParameterCityCopyWithImpl(this._self, this._then);

  final ParameterCity _self;
  final $Res Function(ParameterCity) _then;

/// Create a copy of ParameterCity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kana = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kana: null == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ParameterCity implements ParameterCity {
  const _ParameterCity({required this.code, required this.name, required this.kana});
  factory _ParameterCity.fromJson(Map<String, dynamic> json) => _$ParameterCityFromJson(json);

@override final  String code;
@override final  String name;
@override final  String kana;

/// Create a copy of ParameterCity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParameterCityCopyWith<_ParameterCity> get copyWith => __$ParameterCityCopyWithImpl<_ParameterCity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParameterCityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParameterCity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana);

@override
String toString() {
  return 'ParameterCity(code: $code, name: $name, kana: $kana)';
}


}

/// @nodoc
abstract mixin class _$ParameterCityCopyWith<$Res> implements $ParameterCityCopyWith<$Res> {
  factory _$ParameterCityCopyWith(_ParameterCity value, $Res Function(_ParameterCity) _then) = __$ParameterCityCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String kana
});




}
/// @nodoc
class __$ParameterCityCopyWithImpl<$Res>
    implements _$ParameterCityCopyWith<$Res> {
  __$ParameterCityCopyWithImpl(this._self, this._then);

  final _ParameterCity _self;
  final $Res Function(_ParameterCity) _then;

/// Create a copy of ParameterCity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kana = null,}) {
  return _then(_ParameterCity(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kana: null == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
