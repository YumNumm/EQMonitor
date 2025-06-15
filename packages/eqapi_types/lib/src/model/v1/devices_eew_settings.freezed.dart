// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'devices_eew_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DevicesEewSettings {

 String get id; JmaForecastIntensity get minJmaIntensity; int get regionId; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of DevicesEewSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DevicesEewSettingsCopyWith<DevicesEewSettings> get copyWith => _$DevicesEewSettingsCopyWithImpl<DevicesEewSettings>(this as DevicesEewSettings, _$identity);

  /// Serializes this DevicesEewSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DevicesEewSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,minJmaIntensity,regionId,createdAt,updatedAt);

@override
String toString() {
  return 'DevicesEewSettings(id: $id, minJmaIntensity: $minJmaIntensity, regionId: $regionId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DevicesEewSettingsCopyWith<$Res>  {
  factory $DevicesEewSettingsCopyWith(DevicesEewSettings value, $Res Function(DevicesEewSettings) _then) = _$DevicesEewSettingsCopyWithImpl;
@useResult
$Res call({
 String id, JmaForecastIntensity minJmaIntensity, int regionId, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$DevicesEewSettingsCopyWithImpl<$Res>
    implements $DevicesEewSettingsCopyWith<$Res> {
  _$DevicesEewSettingsCopyWithImpl(this._self, this._then);

  final DevicesEewSettings _self;
  final $Res Function(DevicesEewSettings) _then;

/// Create a copy of DevicesEewSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? minJmaIntensity = null,Object? regionId = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DevicesEewSettings implements DevicesEewSettings {
  const _DevicesEewSettings({required this.id, required this.minJmaIntensity, required this.regionId, required this.createdAt, required this.updatedAt});
  factory _DevicesEewSettings.fromJson(Map<String, dynamic> json) => _$DevicesEewSettingsFromJson(json);

@override final  String id;
@override final  JmaForecastIntensity minJmaIntensity;
@override final  int regionId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of DevicesEewSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DevicesEewSettingsCopyWith<_DevicesEewSettings> get copyWith => __$DevicesEewSettingsCopyWithImpl<_DevicesEewSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DevicesEewSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DevicesEewSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,minJmaIntensity,regionId,createdAt,updatedAt);

@override
String toString() {
  return 'DevicesEewSettings(id: $id, minJmaIntensity: $minJmaIntensity, regionId: $regionId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DevicesEewSettingsCopyWith<$Res> implements $DevicesEewSettingsCopyWith<$Res> {
  factory _$DevicesEewSettingsCopyWith(_DevicesEewSettings value, $Res Function(_DevicesEewSettings) _then) = __$DevicesEewSettingsCopyWithImpl;
@override @useResult
$Res call({
 String id, JmaForecastIntensity minJmaIntensity, int regionId, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$DevicesEewSettingsCopyWithImpl<$Res>
    implements _$DevicesEewSettingsCopyWith<$Res> {
  __$DevicesEewSettingsCopyWithImpl(this._self, this._then);

  final _DevicesEewSettings _self;
  final $Res Function(_DevicesEewSettings) _then;

/// Create a copy of DevicesEewSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? minJmaIntensity = null,Object? regionId = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_DevicesEewSettings(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
