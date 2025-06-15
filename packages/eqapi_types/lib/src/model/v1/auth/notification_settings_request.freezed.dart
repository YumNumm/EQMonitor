// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettingsRequest {

 NotificationSettingsGlobal? get global; List<NotificationSettingsRegion>? get regions;
/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsRequestCopyWith<NotificationSettingsRequest> get copyWith => _$NotificationSettingsRequestCopyWithImpl<NotificationSettingsRequest>(this as NotificationSettingsRequest, _$identity);

  /// Serializes this NotificationSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsRequest&&(identical(other.global, global) || other.global == global)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,global,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'NotificationSettingsRequest(global: $global, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsRequestCopyWith<$Res>  {
  factory $NotificationSettingsRequestCopyWith(NotificationSettingsRequest value, $Res Function(NotificationSettingsRequest) _then) = _$NotificationSettingsRequestCopyWithImpl;
@useResult
$Res call({
 NotificationSettingsGlobal? global, List<NotificationSettingsRegion>? regions
});


$NotificationSettingsGlobalCopyWith<$Res>? get global;

}
/// @nodoc
class _$NotificationSettingsRequestCopyWithImpl<$Res>
    implements $NotificationSettingsRequestCopyWith<$Res> {
  _$NotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final NotificationSettingsRequest _self;
  final $Res Function(NotificationSettingsRequest) _then;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? global = freezed,Object? regions = freezed,}) {
  return _then(_self.copyWith(
global: freezed == global ? _self.global : global // ignore: cast_nullable_to_non_nullable
as NotificationSettingsGlobal?,regions: freezed == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<NotificationSettingsRegion>?,
  ));
}
/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationSettingsGlobalCopyWith<$Res>? get global {
    if (_self.global == null) {
    return null;
  }

  return $NotificationSettingsGlobalCopyWith<$Res>(_self.global!, (value) {
    return _then(_self.copyWith(global: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _NotificationSettingsRequest implements NotificationSettingsRequest {
  const _NotificationSettingsRequest({this.global, final  List<NotificationSettingsRegion>? regions}): _regions = regions;
  factory _NotificationSettingsRequest.fromJson(Map<String, dynamic> json) => _$NotificationSettingsRequestFromJson(json);

@override final  NotificationSettingsGlobal? global;
 final  List<NotificationSettingsRegion>? _regions;
@override List<NotificationSettingsRegion>? get regions {
  final value = _regions;
  if (value == null) return null;
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsRequestCopyWith<_NotificationSettingsRequest> get copyWith => __$NotificationSettingsRequestCopyWithImpl<_NotificationSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsRequest&&(identical(other.global, global) || other.global == global)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,global,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'NotificationSettingsRequest(global: $global, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsRequestCopyWith<$Res> implements $NotificationSettingsRequestCopyWith<$Res> {
  factory _$NotificationSettingsRequestCopyWith(_NotificationSettingsRequest value, $Res Function(_NotificationSettingsRequest) _then) = __$NotificationSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
 NotificationSettingsGlobal? global, List<NotificationSettingsRegion>? regions
});


@override $NotificationSettingsGlobalCopyWith<$Res>? get global;

}
/// @nodoc
class __$NotificationSettingsRequestCopyWithImpl<$Res>
    implements _$NotificationSettingsRequestCopyWith<$Res> {
  __$NotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final _NotificationSettingsRequest _self;
  final $Res Function(_NotificationSettingsRequest) _then;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? global = freezed,Object? regions = freezed,}) {
  return _then(_NotificationSettingsRequest(
global: freezed == global ? _self.global : global // ignore: cast_nullable_to_non_nullable
as NotificationSettingsGlobal?,regions: freezed == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<NotificationSettingsRegion>?,
  ));
}

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationSettingsGlobalCopyWith<$Res>? get global {
    if (_self.global == null) {
    return null;
  }

  return $NotificationSettingsGlobalCopyWith<$Res>(_self.global!, (value) {
    return _then(_self.copyWith(global: value));
  });
}
}


/// @nodoc
mixin _$NotificationSettingsGlobal {

 JmaForecastIntensity get minJmaIntensity;
/// Create a copy of NotificationSettingsGlobal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsGlobalCopyWith<NotificationSettingsGlobal> get copyWith => _$NotificationSettingsGlobalCopyWithImpl<NotificationSettingsGlobal>(this as NotificationSettingsGlobal, _$identity);

  /// Serializes this NotificationSettingsGlobal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsGlobal&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minJmaIntensity);

@override
String toString() {
  return 'NotificationSettingsGlobal(minJmaIntensity: $minJmaIntensity)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsGlobalCopyWith<$Res>  {
  factory $NotificationSettingsGlobalCopyWith(NotificationSettingsGlobal value, $Res Function(NotificationSettingsGlobal) _then) = _$NotificationSettingsGlobalCopyWithImpl;
@useResult
$Res call({
 JmaForecastIntensity minJmaIntensity
});




}
/// @nodoc
class _$NotificationSettingsGlobalCopyWithImpl<$Res>
    implements $NotificationSettingsGlobalCopyWith<$Res> {
  _$NotificationSettingsGlobalCopyWithImpl(this._self, this._then);

  final NotificationSettingsGlobal _self;
  final $Res Function(NotificationSettingsGlobal) _then;

/// Create a copy of NotificationSettingsGlobal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minJmaIntensity = null,}) {
  return _then(_self.copyWith(
minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NotificationSettingsGlobal implements NotificationSettingsGlobal {
  const _NotificationSettingsGlobal({required this.minJmaIntensity});
  factory _NotificationSettingsGlobal.fromJson(Map<String, dynamic> json) => _$NotificationSettingsGlobalFromJson(json);

@override final  JmaForecastIntensity minJmaIntensity;

/// Create a copy of NotificationSettingsGlobal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsGlobalCopyWith<_NotificationSettingsGlobal> get copyWith => __$NotificationSettingsGlobalCopyWithImpl<_NotificationSettingsGlobal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsGlobalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsGlobal&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minJmaIntensity);

@override
String toString() {
  return 'NotificationSettingsGlobal(minJmaIntensity: $minJmaIntensity)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsGlobalCopyWith<$Res> implements $NotificationSettingsGlobalCopyWith<$Res> {
  factory _$NotificationSettingsGlobalCopyWith(_NotificationSettingsGlobal value, $Res Function(_NotificationSettingsGlobal) _then) = __$NotificationSettingsGlobalCopyWithImpl;
@override @useResult
$Res call({
 JmaForecastIntensity minJmaIntensity
});




}
/// @nodoc
class __$NotificationSettingsGlobalCopyWithImpl<$Res>
    implements _$NotificationSettingsGlobalCopyWith<$Res> {
  __$NotificationSettingsGlobalCopyWithImpl(this._self, this._then);

  final _NotificationSettingsGlobal _self;
  final $Res Function(_NotificationSettingsGlobal) _then;

/// Create a copy of NotificationSettingsGlobal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minJmaIntensity = null,}) {
  return _then(_NotificationSettingsGlobal(
minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,
  ));
}


}


/// @nodoc
mixin _$NotificationSettingsRegion {

 int get code; JmaForecastIntensity get minIntensity;
/// Create a copy of NotificationSettingsRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsRegionCopyWith<NotificationSettingsRegion> get copyWith => _$NotificationSettingsRegionCopyWithImpl<NotificationSettingsRegion>(this as NotificationSettingsRegion, _$identity);

  /// Serializes this NotificationSettingsRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.minIntensity, minIntensity) || other.minIntensity == minIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,minIntensity);

@override
String toString() {
  return 'NotificationSettingsRegion(code: $code, minIntensity: $minIntensity)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsRegionCopyWith<$Res>  {
  factory $NotificationSettingsRegionCopyWith(NotificationSettingsRegion value, $Res Function(NotificationSettingsRegion) _then) = _$NotificationSettingsRegionCopyWithImpl;
@useResult
$Res call({
 int code, JmaForecastIntensity minIntensity
});




}
/// @nodoc
class _$NotificationSettingsRegionCopyWithImpl<$Res>
    implements $NotificationSettingsRegionCopyWith<$Res> {
  _$NotificationSettingsRegionCopyWithImpl(this._self, this._then);

  final NotificationSettingsRegion _self;
  final $Res Function(NotificationSettingsRegion) _then;

/// Create a copy of NotificationSettingsRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? minIntensity = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,minIntensity: null == minIntensity ? _self.minIntensity : minIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NotificationSettingsRegion implements NotificationSettingsRegion {
  const _NotificationSettingsRegion({required this.code, required this.minIntensity});
  factory _NotificationSettingsRegion.fromJson(Map<String, dynamic> json) => _$NotificationSettingsRegionFromJson(json);

@override final  int code;
@override final  JmaForecastIntensity minIntensity;

/// Create a copy of NotificationSettingsRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsRegionCopyWith<_NotificationSettingsRegion> get copyWith => __$NotificationSettingsRegionCopyWithImpl<_NotificationSettingsRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.minIntensity, minIntensity) || other.minIntensity == minIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,minIntensity);

@override
String toString() {
  return 'NotificationSettingsRegion(code: $code, minIntensity: $minIntensity)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsRegionCopyWith<$Res> implements $NotificationSettingsRegionCopyWith<$Res> {
  factory _$NotificationSettingsRegionCopyWith(_NotificationSettingsRegion value, $Res Function(_NotificationSettingsRegion) _then) = __$NotificationSettingsRegionCopyWithImpl;
@override @useResult
$Res call({
 int code, JmaForecastIntensity minIntensity
});




}
/// @nodoc
class __$NotificationSettingsRegionCopyWithImpl<$Res>
    implements _$NotificationSettingsRegionCopyWith<$Res> {
  __$NotificationSettingsRegionCopyWithImpl(this._self, this._then);

  final _NotificationSettingsRegion _self;
  final $Res Function(_NotificationSettingsRegion) _then;

/// Create a copy of NotificationSettingsRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? minIntensity = null,}) {
  return _then(_NotificationSettingsRegion(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,minIntensity: null == minIntensity ? _self.minIntensity : minIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,
  ));
}


}

// dart format on
