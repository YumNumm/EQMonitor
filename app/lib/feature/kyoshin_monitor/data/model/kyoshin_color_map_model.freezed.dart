// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_color_map_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinColorMapModel {

 double get intensity; int get r; int get g; int get b;
/// Create a copy of KyoshinColorMapModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinColorMapModelCopyWith<KyoshinColorMapModel> get copyWith => _$KyoshinColorMapModelCopyWithImpl<KyoshinColorMapModel>(this as KyoshinColorMapModel, _$identity);

  /// Serializes this KyoshinColorMapModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinColorMapModel&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.r, r) || other.r == r)&&(identical(other.g, g) || other.g == g)&&(identical(other.b, b) || other.b == b));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,r,g,b);

@override
String toString() {
  return 'KyoshinColorMapModel(intensity: $intensity, r: $r, g: $g, b: $b)';
}


}

/// @nodoc
abstract mixin class $KyoshinColorMapModelCopyWith<$Res>  {
  factory $KyoshinColorMapModelCopyWith(KyoshinColorMapModel value, $Res Function(KyoshinColorMapModel) _then) = _$KyoshinColorMapModelCopyWithImpl;
@useResult
$Res call({
 double intensity, int r, int g, int b
});




}
/// @nodoc
class _$KyoshinColorMapModelCopyWithImpl<$Res>
    implements $KyoshinColorMapModelCopyWith<$Res> {
  _$KyoshinColorMapModelCopyWithImpl(this._self, this._then);

  final KyoshinColorMapModel _self;
  final $Res Function(KyoshinColorMapModel) _then;

/// Create a copy of KyoshinColorMapModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intensity = null,Object? r = null,Object? g = null,Object? b = null,}) {
  return _then(_self.copyWith(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,g: null == g ? _self.g : g // ignore: cast_nullable_to_non_nullable
as int,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _KyoshinColorMapModel implements KyoshinColorMapModel {
  const _KyoshinColorMapModel({required this.intensity, required this.r, required this.g, required this.b});
  factory _KyoshinColorMapModel.fromJson(Map<String, dynamic> json) => _$KyoshinColorMapModelFromJson(json);

@override final  double intensity;
@override final  int r;
@override final  int g;
@override final  int b;

/// Create a copy of KyoshinColorMapModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinColorMapModelCopyWith<_KyoshinColorMapModel> get copyWith => __$KyoshinColorMapModelCopyWithImpl<_KyoshinColorMapModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinColorMapModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinColorMapModel&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.r, r) || other.r == r)&&(identical(other.g, g) || other.g == g)&&(identical(other.b, b) || other.b == b));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,r,g,b);

@override
String toString() {
  return 'KyoshinColorMapModel(intensity: $intensity, r: $r, g: $g, b: $b)';
}


}

/// @nodoc
abstract mixin class _$KyoshinColorMapModelCopyWith<$Res> implements $KyoshinColorMapModelCopyWith<$Res> {
  factory _$KyoshinColorMapModelCopyWith(_KyoshinColorMapModel value, $Res Function(_KyoshinColorMapModel) _then) = __$KyoshinColorMapModelCopyWithImpl;
@override @useResult
$Res call({
 double intensity, int r, int g, int b
});




}
/// @nodoc
class __$KyoshinColorMapModelCopyWithImpl<$Res>
    implements _$KyoshinColorMapModelCopyWith<$Res> {
  __$KyoshinColorMapModelCopyWithImpl(this._self, this._then);

  final _KyoshinColorMapModel _self;
  final $Res Function(_KyoshinColorMapModel) _then;

/// Create a copy of KyoshinColorMapModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intensity = null,Object? r = null,Object? g = null,Object? b = null,}) {
  return _then(_KyoshinColorMapModel(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,g: null == g ? _self.g : g // ignore: cast_nullable_to_non_nullable
as int,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
