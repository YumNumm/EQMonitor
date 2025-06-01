// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_configuration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeConfigurationModel {

/// 位置情報を表示するかどうか
 bool get showLocation;
/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeConfigurationModelCopyWith<HomeConfigurationModel> get copyWith => _$HomeConfigurationModelCopyWithImpl<HomeConfigurationModel>(this as HomeConfigurationModel, _$identity);

  /// Serializes this HomeConfigurationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeConfigurationModel&&(identical(other.showLocation, showLocation) || other.showLocation == showLocation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showLocation);

@override
String toString() {
  return 'HomeConfigurationModel(showLocation: $showLocation)';
}


}

/// @nodoc
abstract mixin class $HomeConfigurationModelCopyWith<$Res>  {
  factory $HomeConfigurationModelCopyWith(HomeConfigurationModel value, $Res Function(HomeConfigurationModel) _then) = _$HomeConfigurationModelCopyWithImpl;
@useResult
$Res call({
 bool showLocation
});




}
/// @nodoc
class _$HomeConfigurationModelCopyWithImpl<$Res>
    implements $HomeConfigurationModelCopyWith<$Res> {
  _$HomeConfigurationModelCopyWithImpl(this._self, this._then);

  final HomeConfigurationModel _self;
  final $Res Function(HomeConfigurationModel) _then;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showLocation = null,}) {
  return _then(_self.copyWith(
showLocation: null == showLocation ? _self.showLocation : showLocation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HomeConfigurationModel implements HomeConfigurationModel {
  const _HomeConfigurationModel({this.showLocation = false});
  factory _HomeConfigurationModel.fromJson(Map<String, dynamic> json) => _$HomeConfigurationModelFromJson(json);

/// 位置情報を表示するかどうか
@override@JsonKey() final  bool showLocation;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeConfigurationModelCopyWith<_HomeConfigurationModel> get copyWith => __$HomeConfigurationModelCopyWithImpl<_HomeConfigurationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeConfigurationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeConfigurationModel&&(identical(other.showLocation, showLocation) || other.showLocation == showLocation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showLocation);

@override
String toString() {
  return 'HomeConfigurationModel(showLocation: $showLocation)';
}


}

/// @nodoc
abstract mixin class _$HomeConfigurationModelCopyWith<$Res> implements $HomeConfigurationModelCopyWith<$Res> {
  factory _$HomeConfigurationModelCopyWith(_HomeConfigurationModel value, $Res Function(_HomeConfigurationModel) _then) = __$HomeConfigurationModelCopyWithImpl;
@override @useResult
$Res call({
 bool showLocation
});




}
/// @nodoc
class __$HomeConfigurationModelCopyWithImpl<$Res>
    implements _$HomeConfigurationModelCopyWith<$Res> {
  __$HomeConfigurationModelCopyWithImpl(this._self, this._then);

  final _HomeConfigurationModel _self;
  final $Res Function(_HomeConfigurationModel) _then;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showLocation = null,}) {
  return _then(_HomeConfigurationModel(
showLocation: null == showLocation ? _self.showLocation : showLocation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
