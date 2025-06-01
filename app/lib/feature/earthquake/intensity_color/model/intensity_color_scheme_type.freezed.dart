// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_color_scheme_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
IntensityColorSchemeType _$IntensityColorSchemeTypeFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'predefined':
          return _Predefined.fromJson(
            json
          );
                case 'custom':
          return _Custom.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'IntensityColorSchemeType',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$IntensityColorSchemeType {



  /// Serializes this IntensityColorSchemeType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityColorSchemeType);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IntensityColorSchemeType()';
}


}

/// @nodoc
class $IntensityColorSchemeTypeCopyWith<$Res>  {
$IntensityColorSchemeTypeCopyWith(IntensityColorSchemeType _, $Res Function(IntensityColorSchemeType) __);
}


/// @nodoc
@JsonSerializable()

class _Predefined implements IntensityColorSchemeType {
  const _Predefined({required this.scheme, final  String? $type}): $type = $type ?? 'predefined';
  factory _Predefined.fromJson(Map<String, dynamic> json) => _$PredefinedFromJson(json);

 final  PredefinedScheme scheme;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of IntensityColorSchemeType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PredefinedCopyWith<_Predefined> get copyWith => __$PredefinedCopyWithImpl<_Predefined>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PredefinedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Predefined&&(identical(other.scheme, scheme) || other.scheme == scheme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scheme);

@override
String toString() {
  return 'IntensityColorSchemeType.predefined(scheme: $scheme)';
}


}

/// @nodoc
abstract mixin class _$PredefinedCopyWith<$Res> implements $IntensityColorSchemeTypeCopyWith<$Res> {
  factory _$PredefinedCopyWith(_Predefined value, $Res Function(_Predefined) _then) = __$PredefinedCopyWithImpl;
@useResult
$Res call({
 PredefinedScheme scheme
});




}
/// @nodoc
class __$PredefinedCopyWithImpl<$Res>
    implements _$PredefinedCopyWith<$Res> {
  __$PredefinedCopyWithImpl(this._self, this._then);

  final _Predefined _self;
  final $Res Function(_Predefined) _then;

/// Create a copy of IntensityColorSchemeType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? scheme = null,}) {
  return _then(_Predefined(
scheme: null == scheme ? _self.scheme : scheme // ignore: cast_nullable_to_non_nullable
as PredefinedScheme,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _Custom implements IntensityColorSchemeType {
  const _Custom({final  String? $type}): $type = $type ?? 'custom';
  factory _Custom.fromJson(Map<String, dynamic> json) => _$CustomFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$CustomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Custom);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IntensityColorSchemeType.custom()';
}


}




// dart format on
