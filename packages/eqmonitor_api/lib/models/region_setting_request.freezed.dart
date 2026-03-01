// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_setting_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionSettingRequest {

@JsonKey(name: 'region_id') num get regionId;@JsonKey(name: 'is_current_location') bool get isCurrentLocation;@JsonKey(name: 'min_jma_intensity') RegionSettingRequestMinJmaIntensity get minJmaIntensity;@JsonKey(includeIfNull: false, name: 'region_name') String? get regionName;
/// Create a copy of RegionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionSettingRequestCopyWith<RegionSettingRequest> get copyWith => _$RegionSettingRequestCopyWithImpl<RegionSettingRequest>(this as RegionSettingRequest, _$identity);

  /// Serializes this RegionSettingRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionSettingRequest&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.regionName, regionName) || other.regionName == regionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,isCurrentLocation,minJmaIntensity,regionName);

@override
String toString() {
  return 'RegionSettingRequest(regionId: $regionId, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity, regionName: $regionName)';
}


}

/// @nodoc
abstract mixin class $RegionSettingRequestCopyWith<$Res>  {
  factory $RegionSettingRequestCopyWith(RegionSettingRequest value, $Res Function(RegionSettingRequest) _then) = _$RegionSettingRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'region_id') num regionId,@JsonKey(name: 'is_current_location') bool isCurrentLocation,@JsonKey(name: 'min_jma_intensity') RegionSettingRequestMinJmaIntensity minJmaIntensity,@JsonKey(includeIfNull: false, name: 'region_name') String? regionName
});




}
/// @nodoc
class _$RegionSettingRequestCopyWithImpl<$Res>
    implements $RegionSettingRequestCopyWith<$Res> {
  _$RegionSettingRequestCopyWithImpl(this._self, this._then);

  final RegionSettingRequest _self;
  final $Res Function(RegionSettingRequest) _then;

/// Create a copy of RegionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionId = null,Object? isCurrentLocation = null,Object? minJmaIntensity = null,Object? regionName = freezed,}) {
  return _then(_self.copyWith(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as num,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as RegionSettingRequestMinJmaIntensity,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionSettingRequest].
extension RegionSettingRequestPatterns on RegionSettingRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionSettingRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionSettingRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionSettingRequest value)  $default,){
final _that = this;
switch (_that) {
case _RegionSettingRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionSettingRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RegionSettingRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'region_id')  num regionId, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_jma_intensity')  RegionSettingRequestMinJmaIntensity minJmaIntensity, @JsonKey(includeIfNull: false, name: 'region_name')  String? regionName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionSettingRequest() when $default != null:
return $default(_that.regionId,_that.isCurrentLocation,_that.minJmaIntensity,_that.regionName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'region_id')  num regionId, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_jma_intensity')  RegionSettingRequestMinJmaIntensity minJmaIntensity, @JsonKey(includeIfNull: false, name: 'region_name')  String? regionName)  $default,) {final _that = this;
switch (_that) {
case _RegionSettingRequest():
return $default(_that.regionId,_that.isCurrentLocation,_that.minJmaIntensity,_that.regionName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'region_id')  num regionId, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_jma_intensity')  RegionSettingRequestMinJmaIntensity minJmaIntensity, @JsonKey(includeIfNull: false, name: 'region_name')  String? regionName)?  $default,) {final _that = this;
switch (_that) {
case _RegionSettingRequest() when $default != null:
return $default(_that.regionId,_that.isCurrentLocation,_that.minJmaIntensity,_that.regionName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionSettingRequest implements RegionSettingRequest {
  const _RegionSettingRequest({@JsonKey(name: 'region_id') required this.regionId, @JsonKey(name: 'is_current_location') required this.isCurrentLocation, @JsonKey(name: 'min_jma_intensity') required this.minJmaIntensity, @JsonKey(includeIfNull: false, name: 'region_name') this.regionName});
  factory _RegionSettingRequest.fromJson(Map<String, dynamic> json) => _$RegionSettingRequestFromJson(json);

@override@JsonKey(name: 'region_id') final  num regionId;
@override@JsonKey(name: 'is_current_location') final  bool isCurrentLocation;
@override@JsonKey(name: 'min_jma_intensity') final  RegionSettingRequestMinJmaIntensity minJmaIntensity;
@override@JsonKey(includeIfNull: false, name: 'region_name') final  String? regionName;

/// Create a copy of RegionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionSettingRequestCopyWith<_RegionSettingRequest> get copyWith => __$RegionSettingRequestCopyWithImpl<_RegionSettingRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionSettingRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionSettingRequest&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.regionName, regionName) || other.regionName == regionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,isCurrentLocation,minJmaIntensity,regionName);

@override
String toString() {
  return 'RegionSettingRequest(regionId: $regionId, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity, regionName: $regionName)';
}


}

/// @nodoc
abstract mixin class _$RegionSettingRequestCopyWith<$Res> implements $RegionSettingRequestCopyWith<$Res> {
  factory _$RegionSettingRequestCopyWith(_RegionSettingRequest value, $Res Function(_RegionSettingRequest) _then) = __$RegionSettingRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'region_id') num regionId,@JsonKey(name: 'is_current_location') bool isCurrentLocation,@JsonKey(name: 'min_jma_intensity') RegionSettingRequestMinJmaIntensity minJmaIntensity,@JsonKey(includeIfNull: false, name: 'region_name') String? regionName
});




}
/// @nodoc
class __$RegionSettingRequestCopyWithImpl<$Res>
    implements _$RegionSettingRequestCopyWith<$Res> {
  __$RegionSettingRequestCopyWithImpl(this._self, this._then);

  final _RegionSettingRequest _self;
  final $Res Function(_RegionSettingRequest) _then;

/// Create a copy of RegionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionId = null,Object? isCurrentLocation = null,Object? minJmaIntensity = null,Object? regionName = freezed,}) {
  return _then(_RegionSettingRequest(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as num,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as RegionSettingRequestMinJmaIntensity,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
