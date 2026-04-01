// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_setting_patch_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionSettingPatchRequest {

@JsonKey(includeIfNull: false, name: 'region_name') String? get regionName;@JsonKey(includeIfNull: false, name: 'is_current_location') bool? get isCurrentLocation;@JsonKey(includeIfNull: false, name: 'min_jma_intensity') JmaIntensity? get minJmaIntensity;
/// Create a copy of RegionSettingPatchRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionSettingPatchRequestCopyWith<RegionSettingPatchRequest> get copyWith => _$RegionSettingPatchRequestCopyWithImpl<RegionSettingPatchRequest>(this as RegionSettingPatchRequest, _$identity);

  /// Serializes this RegionSettingPatchRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionSettingPatchRequest&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionName,isCurrentLocation,minJmaIntensity);

@override
String toString() {
  return 'RegionSettingPatchRequest(regionName: $regionName, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity)';
}


}

/// @nodoc
abstract mixin class $RegionSettingPatchRequestCopyWith<$Res>  {
  factory $RegionSettingPatchRequestCopyWith(RegionSettingPatchRequest value, $Res Function(RegionSettingPatchRequest) _then) = _$RegionSettingPatchRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'region_name') String? regionName,@JsonKey(includeIfNull: false, name: 'is_current_location') bool? isCurrentLocation,@JsonKey(includeIfNull: false, name: 'min_jma_intensity') JmaIntensity? minJmaIntensity
});




}
/// @nodoc
class _$RegionSettingPatchRequestCopyWithImpl<$Res>
    implements $RegionSettingPatchRequestCopyWith<$Res> {
  _$RegionSettingPatchRequestCopyWithImpl(this._self, this._then);

  final RegionSettingPatchRequest _self;
  final $Res Function(RegionSettingPatchRequest) _then;

/// Create a copy of RegionSettingPatchRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionName = freezed,Object? isCurrentLocation = freezed,Object? minJmaIntensity = freezed,}) {
  return _then(_self.copyWith(
regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: freezed == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool?,minJmaIntensity: freezed == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionSettingPatchRequest].
extension RegionSettingPatchRequestPatterns on RegionSettingPatchRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionSettingPatchRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionSettingPatchRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionSettingPatchRequest value)  $default,){
final _that = this;
switch (_that) {
case _RegionSettingPatchRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionSettingPatchRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RegionSettingPatchRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: false, name: 'is_current_location')  bool? isCurrentLocation, @JsonKey(includeIfNull: false, name: 'min_jma_intensity')  JmaIntensity? minJmaIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionSettingPatchRequest() when $default != null:
return $default(_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: false, name: 'is_current_location')  bool? isCurrentLocation, @JsonKey(includeIfNull: false, name: 'min_jma_intensity')  JmaIntensity? minJmaIntensity)  $default,) {final _that = this;
switch (_that) {
case _RegionSettingPatchRequest():
return $default(_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: false, name: 'is_current_location')  bool? isCurrentLocation, @JsonKey(includeIfNull: false, name: 'min_jma_intensity')  JmaIntensity? minJmaIntensity)?  $default,) {final _that = this;
switch (_that) {
case _RegionSettingPatchRequest() when $default != null:
return $default(_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionSettingPatchRequest implements RegionSettingPatchRequest {
  const _RegionSettingPatchRequest({@JsonKey(includeIfNull: false, name: 'region_name') this.regionName, @JsonKey(includeIfNull: false, name: 'is_current_location') this.isCurrentLocation, @JsonKey(includeIfNull: false, name: 'min_jma_intensity') this.minJmaIntensity});
  factory _RegionSettingPatchRequest.fromJson(Map<String, dynamic> json) => _$RegionSettingPatchRequestFromJson(json);

@override@JsonKey(includeIfNull: false, name: 'region_name') final  String? regionName;
@override@JsonKey(includeIfNull: false, name: 'is_current_location') final  bool? isCurrentLocation;
@override@JsonKey(includeIfNull: false, name: 'min_jma_intensity') final  JmaIntensity? minJmaIntensity;

/// Create a copy of RegionSettingPatchRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionSettingPatchRequestCopyWith<_RegionSettingPatchRequest> get copyWith => __$RegionSettingPatchRequestCopyWithImpl<_RegionSettingPatchRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionSettingPatchRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionSettingPatchRequest&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionName,isCurrentLocation,minJmaIntensity);

@override
String toString() {
  return 'RegionSettingPatchRequest(regionName: $regionName, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity)';
}


}

/// @nodoc
abstract mixin class _$RegionSettingPatchRequestCopyWith<$Res> implements $RegionSettingPatchRequestCopyWith<$Res> {
  factory _$RegionSettingPatchRequestCopyWith(_RegionSettingPatchRequest value, $Res Function(_RegionSettingPatchRequest) _then) = __$RegionSettingPatchRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'region_name') String? regionName,@JsonKey(includeIfNull: false, name: 'is_current_location') bool? isCurrentLocation,@JsonKey(includeIfNull: false, name: 'min_jma_intensity') JmaIntensity? minJmaIntensity
});




}
/// @nodoc
class __$RegionSettingPatchRequestCopyWithImpl<$Res>
    implements _$RegionSettingPatchRequestCopyWith<$Res> {
  __$RegionSettingPatchRequestCopyWithImpl(this._self, this._then);

  final _RegionSettingPatchRequest _self;
  final $Res Function(_RegionSettingPatchRequest) _then;

/// Create a copy of RegionSettingPatchRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionName = freezed,Object? isCurrentLocation = freezed,Object? minJmaIntensity = freezed,}) {
  return _then(_RegionSettingPatchRequest(
regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: freezed == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool?,minJmaIntensity: freezed == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}


}

// dart format on
