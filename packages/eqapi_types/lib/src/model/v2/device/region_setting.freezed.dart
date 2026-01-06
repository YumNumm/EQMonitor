// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionSetting {

 int get regionId; String? get regionName; bool get isCurrentLocation; DeviceJmaIntensity get minJmaIntensity; String get createdAt; String get updatedAt;
/// Create a copy of RegionSetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionSettingCopyWith<RegionSetting> get copyWith => _$RegionSettingCopyWithImpl<RegionSetting>(this as RegionSetting, _$identity);

  /// Serializes this RegionSetting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionSetting&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,regionName,isCurrentLocation,minJmaIntensity,createdAt,updatedAt);

@override
String toString() {
  return 'RegionSetting(regionId: $regionId, regionName: $regionName, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RegionSettingCopyWith<$Res>  {
  factory $RegionSettingCopyWith(RegionSetting value, $Res Function(RegionSetting) _then) = _$RegionSettingCopyWithImpl;
@useResult
$Res call({
 int regionId, String? regionName, bool isCurrentLocation, DeviceJmaIntensity minJmaIntensity, String createdAt, String updatedAt
});




}
/// @nodoc
class _$RegionSettingCopyWithImpl<$Res>
    implements $RegionSettingCopyWith<$Res> {
  _$RegionSettingCopyWithImpl(this._self, this._then);

  final RegionSetting _self;
  final $Res Function(RegionSetting) _then;

/// Create a copy of RegionSetting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionId = null,Object? regionName = freezed,Object? isCurrentLocation = null,Object? minJmaIntensity = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as DeviceJmaIntensity,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionSetting].
extension RegionSettingPatterns on RegionSetting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionSetting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionSetting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionSetting value)  $default,){
final _that = this;
switch (_that) {
case _RegionSetting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionSetting value)?  $default,){
final _that = this;
switch (_that) {
case _RegionSetting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int regionId,  String? regionName,  bool isCurrentLocation,  DeviceJmaIntensity minJmaIntensity,  String createdAt,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionSetting() when $default != null:
return $default(_that.regionId,_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int regionId,  String? regionName,  bool isCurrentLocation,  DeviceJmaIntensity minJmaIntensity,  String createdAt,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RegionSetting():
return $default(_that.regionId,_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int regionId,  String? regionName,  bool isCurrentLocation,  DeviceJmaIntensity minJmaIntensity,  String createdAt,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RegionSetting() when $default != null:
return $default(_that.regionId,_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionSetting implements RegionSetting {
  const _RegionSetting({required this.regionId, this.regionName, required this.isCurrentLocation, required this.minJmaIntensity, required this.createdAt, required this.updatedAt});
  factory _RegionSetting.fromJson(Map<String, dynamic> json) => _$RegionSettingFromJson(json);

@override final  int regionId;
@override final  String? regionName;
@override final  bool isCurrentLocation;
@override final  DeviceJmaIntensity minJmaIntensity;
@override final  String createdAt;
@override final  String updatedAt;

/// Create a copy of RegionSetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionSettingCopyWith<_RegionSetting> get copyWith => __$RegionSettingCopyWithImpl<_RegionSetting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionSettingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionSetting&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,regionName,isCurrentLocation,minJmaIntensity,createdAt,updatedAt);

@override
String toString() {
  return 'RegionSetting(regionId: $regionId, regionName: $regionName, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RegionSettingCopyWith<$Res> implements $RegionSettingCopyWith<$Res> {
  factory _$RegionSettingCopyWith(_RegionSetting value, $Res Function(_RegionSetting) _then) = __$RegionSettingCopyWithImpl;
@override @useResult
$Res call({
 int regionId, String? regionName, bool isCurrentLocation, DeviceJmaIntensity minJmaIntensity, String createdAt, String updatedAt
});




}
/// @nodoc
class __$RegionSettingCopyWithImpl<$Res>
    implements _$RegionSettingCopyWith<$Res> {
  __$RegionSettingCopyWithImpl(this._self, this._then);

  final _RegionSetting _self;
  final $Res Function(_RegionSetting) _then;

/// Create a copy of RegionSetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionId = null,Object? regionName = freezed,Object? isCurrentLocation = null,Object? minJmaIntensity = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_RegionSetting(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as DeviceJmaIntensity,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RegionSettingRequest {

 int get regionId; String? get regionName; bool get isCurrentLocation; DeviceJmaIntensity get minJmaIntensity;
/// Create a copy of RegionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionSettingRequestCopyWith<RegionSettingRequest> get copyWith => _$RegionSettingRequestCopyWithImpl<RegionSettingRequest>(this as RegionSettingRequest, _$identity);

  /// Serializes this RegionSettingRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionSettingRequest&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,regionName,isCurrentLocation,minJmaIntensity);

@override
String toString() {
  return 'RegionSettingRequest(regionId: $regionId, regionName: $regionName, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity)';
}


}

/// @nodoc
abstract mixin class $RegionSettingRequestCopyWith<$Res>  {
  factory $RegionSettingRequestCopyWith(RegionSettingRequest value, $Res Function(RegionSettingRequest) _then) = _$RegionSettingRequestCopyWithImpl;
@useResult
$Res call({
 int regionId, String? regionName, bool isCurrentLocation, DeviceJmaIntensity minJmaIntensity
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
@pragma('vm:prefer-inline') @override $Res call({Object? regionId = null,Object? regionName = freezed,Object? isCurrentLocation = null,Object? minJmaIntensity = null,}) {
  return _then(_self.copyWith(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as DeviceJmaIntensity,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int regionId,  String? regionName,  bool isCurrentLocation,  DeviceJmaIntensity minJmaIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionSettingRequest() when $default != null:
return $default(_that.regionId,_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int regionId,  String? regionName,  bool isCurrentLocation,  DeviceJmaIntensity minJmaIntensity)  $default,) {final _that = this;
switch (_that) {
case _RegionSettingRequest():
return $default(_that.regionId,_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int regionId,  String? regionName,  bool isCurrentLocation,  DeviceJmaIntensity minJmaIntensity)?  $default,) {final _that = this;
switch (_that) {
case _RegionSettingRequest() when $default != null:
return $default(_that.regionId,_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionSettingRequest implements RegionSettingRequest {
  const _RegionSettingRequest({required this.regionId, this.regionName, required this.isCurrentLocation, required this.minJmaIntensity});
  factory _RegionSettingRequest.fromJson(Map<String, dynamic> json) => _$RegionSettingRequestFromJson(json);

@override final  int regionId;
@override final  String? regionName;
@override final  bool isCurrentLocation;
@override final  DeviceJmaIntensity minJmaIntensity;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionSettingRequest&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,regionName,isCurrentLocation,minJmaIntensity);

@override
String toString() {
  return 'RegionSettingRequest(regionId: $regionId, regionName: $regionName, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity)';
}


}

/// @nodoc
abstract mixin class _$RegionSettingRequestCopyWith<$Res> implements $RegionSettingRequestCopyWith<$Res> {
  factory _$RegionSettingRequestCopyWith(_RegionSettingRequest value, $Res Function(_RegionSettingRequest) _then) = __$RegionSettingRequestCopyWithImpl;
@override @useResult
$Res call({
 int regionId, String? regionName, bool isCurrentLocation, DeviceJmaIntensity minJmaIntensity
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
@override @pragma('vm:prefer-inline') $Res call({Object? regionId = null,Object? regionName = freezed,Object? isCurrentLocation = null,Object? minJmaIntensity = null,}) {
  return _then(_RegionSettingRequest(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as DeviceJmaIntensity,
  ));
}


}


/// @nodoc
mixin _$RegionSettingPatchRequest {

 String? get regionName; bool? get isCurrentLocation; DeviceJmaIntensity? get minJmaIntensity;
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
 String? regionName, bool? isCurrentLocation, DeviceJmaIntensity? minJmaIntensity
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
as DeviceJmaIntensity?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? regionName,  bool? isCurrentLocation,  DeviceJmaIntensity? minJmaIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? regionName,  bool? isCurrentLocation,  DeviceJmaIntensity? minJmaIntensity)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? regionName,  bool? isCurrentLocation,  DeviceJmaIntensity? minJmaIntensity)?  $default,) {final _that = this;
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
  const _RegionSettingPatchRequest({this.regionName, this.isCurrentLocation, this.minJmaIntensity});
  factory _RegionSettingPatchRequest.fromJson(Map<String, dynamic> json) => _$RegionSettingPatchRequestFromJson(json);

@override final  String? regionName;
@override final  bool? isCurrentLocation;
@override final  DeviceJmaIntensity? minJmaIntensity;

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
 String? regionName, bool? isCurrentLocation, DeviceJmaIntensity? minJmaIntensity
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
as DeviceJmaIntensity?,
  ));
}


}

// dart format on
