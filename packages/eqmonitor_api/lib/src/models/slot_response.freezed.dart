// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slot_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SlotResponse {

 String get id;@JsonKey(name: 'slot_type') SlotType get slotType;@JsonKey(includeIfNull: true, name: 'region_id') num? get regionId;@JsonKey(includeIfNull: true, name: 'region_name') String? get regionName;@JsonKey(includeIfNull: true, name: 'city_code') String? get cityCode;@JsonKey(includeIfNull: true, name: 'city_name') String? get cityName;@JsonKey(name: 'display_order') num get displayOrder;@JsonKey(name: 'eew_enabled') bool get eewEnabled;@JsonKey(includeIfNull: true, name: 'eew_min_intensity') EewMinIntensity? get eewMinIntensity;@JsonKey(includeIfNull: true, name: 'eew_overrides') List<SlotOverride>? get eewOverrides;@JsonKey(name: 'earthquake_enabled') bool get earthquakeEnabled;@JsonKey(includeIfNull: true, name: 'earthquake_min_intensity') EarthquakeMinIntensity? get earthquakeMinIntensity;@JsonKey(includeIfNull: true, name: 'earthquake_overrides') List<SlotOverride>? get earthquakeOverrides;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of SlotResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotResponseCopyWith<SlotResponse> get copyWith => _$SlotResponseCopyWithImpl<SlotResponse>(this as SlotResponse, _$identity);

  /// Serializes this SlotResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.eewMinIntensity, eewMinIntensity) || other.eewMinIntensity == eewMinIntensity)&&const DeepCollectionEquality().equals(other.eewOverrides, eewOverrides)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.earthquakeMinIntensity, earthquakeMinIntensity) || other.earthquakeMinIntensity == earthquakeMinIntensity)&&const DeepCollectionEquality().equals(other.earthquakeOverrides, earthquakeOverrides)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slotType,regionId,regionName,cityCode,cityName,displayOrder,eewEnabled,eewMinIntensity,const DeepCollectionEquality().hash(eewOverrides),earthquakeEnabled,earthquakeMinIntensity,const DeepCollectionEquality().hash(earthquakeOverrides),createdAt,updatedAt);

@override
String toString() {
  return 'SlotResponse(id: $id, slotType: $slotType, regionId: $regionId, regionName: $regionName, cityCode: $cityCode, cityName: $cityName, displayOrder: $displayOrder, eewEnabled: $eewEnabled, eewMinIntensity: $eewMinIntensity, eewOverrides: $eewOverrides, earthquakeEnabled: $earthquakeEnabled, earthquakeMinIntensity: $earthquakeMinIntensity, earthquakeOverrides: $earthquakeOverrides, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SlotResponseCopyWith<$Res>  {
  factory $SlotResponseCopyWith(SlotResponse value, $Res Function(SlotResponse) _then) = _$SlotResponseCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'slot_type') SlotType slotType,@JsonKey(includeIfNull: true, name: 'region_id') num? regionId,@JsonKey(includeIfNull: true, name: 'region_name') String? regionName,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: true, name: 'city_name') String? cityName,@JsonKey(name: 'display_order') num displayOrder,@JsonKey(name: 'eew_enabled') bool eewEnabled,@JsonKey(includeIfNull: true, name: 'eew_min_intensity') EewMinIntensity? eewMinIntensity,@JsonKey(includeIfNull: true, name: 'eew_overrides') List<SlotOverride>? eewOverrides,@JsonKey(name: 'earthquake_enabled') bool earthquakeEnabled,@JsonKey(includeIfNull: true, name: 'earthquake_min_intensity') EarthquakeMinIntensity? earthquakeMinIntensity,@JsonKey(includeIfNull: true, name: 'earthquake_overrides') List<SlotOverride>? earthquakeOverrides,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class _$SlotResponseCopyWithImpl<$Res>
    implements $SlotResponseCopyWith<$Res> {
  _$SlotResponseCopyWithImpl(this._self, this._then);

  final SlotResponse _self;
  final $Res Function(SlotResponse) _then;

/// Create a copy of SlotResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slotType = null,Object? regionId = freezed,Object? regionName = freezed,Object? cityCode = freezed,Object? cityName = freezed,Object? displayOrder = null,Object? eewEnabled = null,Object? eewMinIntensity = freezed,Object? eewOverrides = freezed,Object? earthquakeEnabled = null,Object? earthquakeMinIntensity = freezed,Object? earthquakeOverrides = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(SlotResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as SlotType,regionId: freezed == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as num?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as num,eewEnabled: null == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool,eewMinIntensity: freezed == eewMinIntensity ? _self.eewMinIntensity : eewMinIntensity // ignore: cast_nullable_to_non_nullable
as EewMinIntensity?,eewOverrides: freezed == eewOverrides ? _self.eewOverrides : eewOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,earthquakeEnabled: null == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeMinIntensity: freezed == earthquakeMinIntensity ? _self.earthquakeMinIntensity : earthquakeMinIntensity // ignore: cast_nullable_to_non_nullable
as EarthquakeMinIntensity?,earthquakeOverrides: freezed == earthquakeOverrides ? _self.earthquakeOverrides : earthquakeOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SlotResponse].
extension SlotResponsePatterns on SlotResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlotResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlotResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlotResponse value)  $default,){
final _that = this;
switch (_that) {
case _SlotResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlotResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SlotResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'slot_type')  SlotType slotType, @JsonKey(includeIfNull: true, name: 'region_id')  num? regionId, @JsonKey(includeIfNull: true, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true, name: 'city_name')  String? cityName, @JsonKey(name: 'display_order')  num displayOrder, @JsonKey(name: 'eew_enabled')  bool eewEnabled, @JsonKey(includeIfNull: true, name: 'eew_min_intensity')  EewMinIntensity? eewMinIntensity, @JsonKey(includeIfNull: true, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(name: 'earthquake_enabled')  bool earthquakeEnabled, @JsonKey(includeIfNull: true, name: 'earthquake_min_intensity')  EarthquakeMinIntensity? earthquakeMinIntensity, @JsonKey(includeIfNull: true, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlotResponse() when $default != null:
return $default(_that.id,_that.slotType,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'slot_type')  SlotType slotType, @JsonKey(includeIfNull: true, name: 'region_id')  num? regionId, @JsonKey(includeIfNull: true, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true, name: 'city_name')  String? cityName, @JsonKey(name: 'display_order')  num displayOrder, @JsonKey(name: 'eew_enabled')  bool eewEnabled, @JsonKey(includeIfNull: true, name: 'eew_min_intensity')  EewMinIntensity? eewMinIntensity, @JsonKey(includeIfNull: true, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(name: 'earthquake_enabled')  bool earthquakeEnabled, @JsonKey(includeIfNull: true, name: 'earthquake_min_intensity')  EarthquakeMinIntensity? earthquakeMinIntensity, @JsonKey(includeIfNull: true, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SlotResponse():
return $default(_that.id,_that.slotType,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'slot_type')  SlotType slotType, @JsonKey(includeIfNull: true, name: 'region_id')  num? regionId, @JsonKey(includeIfNull: true, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true, name: 'city_name')  String? cityName, @JsonKey(name: 'display_order')  num displayOrder, @JsonKey(name: 'eew_enabled')  bool eewEnabled, @JsonKey(includeIfNull: true, name: 'eew_min_intensity')  EewMinIntensity? eewMinIntensity, @JsonKey(includeIfNull: true, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(name: 'earthquake_enabled')  bool earthquakeEnabled, @JsonKey(includeIfNull: true, name: 'earthquake_min_intensity')  EarthquakeMinIntensity? earthquakeMinIntensity, @JsonKey(includeIfNull: true, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SlotResponse() when $default != null:
return $default(_that.id,_that.slotType,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SlotResponse implements SlotResponse {
  const _SlotResponse({required this.id, @JsonKey(name: 'slot_type') required this.slotType, @JsonKey(includeIfNull: true, name: 'region_id') required this.regionId, @JsonKey(includeIfNull: true, name: 'region_name') required this.regionName, @JsonKey(includeIfNull: true, name: 'city_code') required this.cityCode, @JsonKey(includeIfNull: true, name: 'city_name') required this.cityName, @JsonKey(name: 'display_order') required this.displayOrder, @JsonKey(name: 'eew_enabled') required this.eewEnabled, @JsonKey(includeIfNull: true, name: 'eew_min_intensity') required this.eewMinIntensity, @JsonKey(includeIfNull: true, name: 'eew_overrides') required  List<SlotOverride>? eewOverrides, @JsonKey(name: 'earthquake_enabled') required this.earthquakeEnabled, @JsonKey(includeIfNull: true, name: 'earthquake_min_intensity') required this.earthquakeMinIntensity, @JsonKey(includeIfNull: true, name: 'earthquake_overrides') required  List<SlotOverride>? earthquakeOverrides, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): _eewOverrides = eewOverrides,_earthquakeOverrides = earthquakeOverrides;
  factory _SlotResponse.fromJson(Map<String, dynamic> json) => _$SlotResponseFromJson(json);

@override final  String id;
@override@JsonKey(name: 'slot_type') final  SlotType slotType;
@override@JsonKey(includeIfNull: true, name: 'region_id') final  num? regionId;
@override@JsonKey(includeIfNull: true, name: 'region_name') final  String? regionName;
@override@JsonKey(includeIfNull: true, name: 'city_code') final  String? cityCode;
@override@JsonKey(includeIfNull: true, name: 'city_name') final  String? cityName;
@override@JsonKey(name: 'display_order') final  num displayOrder;
@override@JsonKey(name: 'eew_enabled') final  bool eewEnabled;
@override@JsonKey(includeIfNull: true, name: 'eew_min_intensity') final  EewMinIntensity? eewMinIntensity;
 final  List<SlotOverride>? _eewOverrides;
@override@JsonKey(includeIfNull: true, name: 'eew_overrides') List<SlotOverride>? get eewOverrides {
  final value = _eewOverrides;
  if (value == null) return null;
  if (_eewOverrides is EqualUnmodifiableListView) return _eewOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'earthquake_enabled') final  bool earthquakeEnabled;
@override@JsonKey(includeIfNull: true, name: 'earthquake_min_intensity') final  EarthquakeMinIntensity? earthquakeMinIntensity;
 final  List<SlotOverride>? _earthquakeOverrides;
@override@JsonKey(includeIfNull: true, name: 'earthquake_overrides') List<SlotOverride>? get earthquakeOverrides {
  final value = _earthquakeOverrides;
  if (value == null) return null;
  if (_earthquakeOverrides is EqualUnmodifiableListView) return _earthquakeOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of SlotResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotResponseCopyWith<_SlotResponse> get copyWith => __$SlotResponseCopyWithImpl<_SlotResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlotResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.eewMinIntensity, eewMinIntensity) || other.eewMinIntensity == eewMinIntensity)&&const DeepCollectionEquality().equals(other._eewOverrides, _eewOverrides)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.earthquakeMinIntensity, earthquakeMinIntensity) || other.earthquakeMinIntensity == earthquakeMinIntensity)&&const DeepCollectionEquality().equals(other._earthquakeOverrides, _earthquakeOverrides)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slotType,regionId,regionName,cityCode,cityName,displayOrder,eewEnabled,eewMinIntensity,const DeepCollectionEquality().hash(_eewOverrides),earthquakeEnabled,earthquakeMinIntensity,const DeepCollectionEquality().hash(_earthquakeOverrides),createdAt,updatedAt);

@override
String toString() {
  return 'SlotResponse(id: $id, slotType: $slotType, regionId: $regionId, regionName: $regionName, cityCode: $cityCode, cityName: $cityName, displayOrder: $displayOrder, eewEnabled: $eewEnabled, eewMinIntensity: $eewMinIntensity, eewOverrides: $eewOverrides, earthquakeEnabled: $earthquakeEnabled, earthquakeMinIntensity: $earthquakeMinIntensity, earthquakeOverrides: $earthquakeOverrides, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SlotResponseCopyWith<$Res> implements $SlotResponseCopyWith<$Res> {
  factory _$SlotResponseCopyWith(_SlotResponse value, $Res Function(_SlotResponse) _then) = __$SlotResponseCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'slot_type') SlotType slotType,@JsonKey(includeIfNull: true, name: 'region_id') num? regionId,@JsonKey(includeIfNull: true, name: 'region_name') String? regionName,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: true, name: 'city_name') String? cityName,@JsonKey(name: 'display_order') num displayOrder,@JsonKey(name: 'eew_enabled') bool eewEnabled,@JsonKey(includeIfNull: true, name: 'eew_min_intensity') EewMinIntensity? eewMinIntensity,@JsonKey(includeIfNull: true, name: 'eew_overrides') List<SlotOverride>? eewOverrides,@JsonKey(name: 'earthquake_enabled') bool earthquakeEnabled,@JsonKey(includeIfNull: true, name: 'earthquake_min_intensity') EarthquakeMinIntensity? earthquakeMinIntensity,@JsonKey(includeIfNull: true, name: 'earthquake_overrides') List<SlotOverride>? earthquakeOverrides,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class __$SlotResponseCopyWithImpl<$Res>
    implements _$SlotResponseCopyWith<$Res> {
  __$SlotResponseCopyWithImpl(this._self, this._then);

  final _SlotResponse _self;
  final $Res Function(_SlotResponse) _then;

/// Create a copy of SlotResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slotType = null,Object? regionId = freezed,Object? regionName = freezed,Object? cityCode = freezed,Object? cityName = freezed,Object? displayOrder = null,Object? eewEnabled = null,Object? eewMinIntensity = freezed,Object? eewOverrides = freezed,Object? earthquakeEnabled = null,Object? earthquakeMinIntensity = freezed,Object? earthquakeOverrides = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_SlotResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as SlotType,regionId: freezed == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as num?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as num,eewEnabled: null == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool,eewMinIntensity: freezed == eewMinIntensity ? _self.eewMinIntensity : eewMinIntensity // ignore: cast_nullable_to_non_nullable
as EewMinIntensity?,eewOverrides: freezed == eewOverrides ? _self._eewOverrides : eewOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,earthquakeEnabled: null == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeMinIntensity: freezed == earthquakeMinIntensity ? _self.earthquakeMinIntensity : earthquakeMinIntensity // ignore: cast_nullable_to_non_nullable
as EarthquakeMinIntensity?,earthquakeOverrides: freezed == earthquakeOverrides ? _self._earthquakeOverrides : earthquakeOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
