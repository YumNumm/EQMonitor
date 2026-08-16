// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replace_slot_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReplaceSlotEntry {

@JsonKey(name: 'slot_type') SlotType get slotType;@JsonKey(includeIfNull: false, name: 'region_id') num? get regionId;@JsonKey(includeIfNull: false, name: 'region_name') String? get regionName;@JsonKey(includeIfNull: false, name: 'city_code') String? get cityCode;@JsonKey(includeIfNull: false, name: 'city_name') String? get cityName;@JsonKey(includeIfNull: false, name: 'display_order') num? get displayOrder;@JsonKey(includeIfNull: false, name: 'eew_enabled') bool? get eewEnabled;@JsonKey(includeIfNull: false, name: 'eew_min_intensity') JmaIntensity? get eewMinIntensity;@JsonKey(includeIfNull: false, name: 'eew_overrides') List<SlotOverride>? get eewOverrides;@JsonKey(includeIfNull: false, name: 'earthquake_enabled') bool? get earthquakeEnabled;@JsonKey(includeIfNull: false, name: 'earthquake_min_intensity') JmaIntensity? get earthquakeMinIntensity;@JsonKey(includeIfNull: false, name: 'earthquake_overrides') List<SlotOverride>? get earthquakeOverrides;
/// Create a copy of ReplaceSlotEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplaceSlotEntryCopyWith<ReplaceSlotEntry> get copyWith => _$ReplaceSlotEntryCopyWithImpl<ReplaceSlotEntry>(this as ReplaceSlotEntry, _$identity);

  /// Serializes this ReplaceSlotEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplaceSlotEntry&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.eewMinIntensity, eewMinIntensity) || other.eewMinIntensity == eewMinIntensity)&&const DeepCollectionEquality().equals(other.eewOverrides, eewOverrides)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.earthquakeMinIntensity, earthquakeMinIntensity) || other.earthquakeMinIntensity == earthquakeMinIntensity)&&const DeepCollectionEquality().equals(other.earthquakeOverrides, earthquakeOverrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotType,regionId,regionName,cityCode,cityName,displayOrder,eewEnabled,eewMinIntensity,const DeepCollectionEquality().hash(eewOverrides),earthquakeEnabled,earthquakeMinIntensity,const DeepCollectionEquality().hash(earthquakeOverrides));

@override
String toString() {
  return 'ReplaceSlotEntry(slotType: $slotType, regionId: $regionId, regionName: $regionName, cityCode: $cityCode, cityName: $cityName, displayOrder: $displayOrder, eewEnabled: $eewEnabled, eewMinIntensity: $eewMinIntensity, eewOverrides: $eewOverrides, earthquakeEnabled: $earthquakeEnabled, earthquakeMinIntensity: $earthquakeMinIntensity, earthquakeOverrides: $earthquakeOverrides)';
}


}

/// @nodoc
abstract mixin class $ReplaceSlotEntryCopyWith<$Res>  {
  factory $ReplaceSlotEntryCopyWith(ReplaceSlotEntry value, $Res Function(ReplaceSlotEntry) _then) = _$ReplaceSlotEntryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'slot_type') SlotType slotType,@JsonKey(includeIfNull: false, name: 'region_id') num? regionId,@JsonKey(includeIfNull: false, name: 'region_name') String? regionName,@JsonKey(includeIfNull: false, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: false, name: 'city_name') String? cityName,@JsonKey(includeIfNull: false, name: 'display_order') num? displayOrder,@JsonKey(includeIfNull: false, name: 'eew_enabled') bool? eewEnabled,@JsonKey(includeIfNull: false, name: 'eew_min_intensity') JmaIntensity? eewMinIntensity,@JsonKey(includeIfNull: false, name: 'eew_overrides') List<SlotOverride>? eewOverrides,@JsonKey(includeIfNull: false, name: 'earthquake_enabled') bool? earthquakeEnabled,@JsonKey(includeIfNull: false, name: 'earthquake_min_intensity') JmaIntensity? earthquakeMinIntensity,@JsonKey(includeIfNull: false, name: 'earthquake_overrides') List<SlotOverride>? earthquakeOverrides
});




}
/// @nodoc
class _$ReplaceSlotEntryCopyWithImpl<$Res>
    implements $ReplaceSlotEntryCopyWith<$Res> {
  _$ReplaceSlotEntryCopyWithImpl(this._self, this._then);

  final ReplaceSlotEntry _self;
  final $Res Function(ReplaceSlotEntry) _then;

/// Create a copy of ReplaceSlotEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slotType = null,Object? regionId = freezed,Object? regionName = freezed,Object? cityCode = freezed,Object? cityName = freezed,Object? displayOrder = freezed,Object? eewEnabled = freezed,Object? eewMinIntensity = freezed,Object? eewOverrides = freezed,Object? earthquakeEnabled = freezed,Object? earthquakeMinIntensity = freezed,Object? earthquakeOverrides = freezed,}) {
  return _then(ReplaceSlotEntry(
slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as SlotType,regionId: freezed == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as num?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: freezed == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as num?,eewEnabled: freezed == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool?,eewMinIntensity: freezed == eewMinIntensity ? _self.eewMinIntensity : eewMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,eewOverrides: freezed == eewOverrides ? _self.eewOverrides : eewOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,earthquakeEnabled: freezed == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool?,earthquakeMinIntensity: freezed == earthquakeMinIntensity ? _self.earthquakeMinIntensity : earthquakeMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,earthquakeOverrides: freezed == earthquakeOverrides ? _self.earthquakeOverrides : earthquakeOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplaceSlotEntry].
extension ReplaceSlotEntryPatterns on ReplaceSlotEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplaceSlotEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplaceSlotEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplaceSlotEntry value)  $default,){
final _that = this;
switch (_that) {
case _ReplaceSlotEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplaceSlotEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ReplaceSlotEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'slot_type')  SlotType slotType, @JsonKey(includeIfNull: false, name: 'region_id')  num? regionId, @JsonKey(includeIfNull: false, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: false, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: false, name: 'city_name')  String? cityName, @JsonKey(includeIfNull: false, name: 'display_order')  num? displayOrder, @JsonKey(includeIfNull: false, name: 'eew_enabled')  bool? eewEnabled, @JsonKey(includeIfNull: false, name: 'eew_min_intensity')  JmaIntensity? eewMinIntensity, @JsonKey(includeIfNull: false, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(includeIfNull: false, name: 'earthquake_enabled')  bool? earthquakeEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_min_intensity')  JmaIntensity? earthquakeMinIntensity, @JsonKey(includeIfNull: false, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplaceSlotEntry() when $default != null:
return $default(_that.slotType,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'slot_type')  SlotType slotType, @JsonKey(includeIfNull: false, name: 'region_id')  num? regionId, @JsonKey(includeIfNull: false, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: false, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: false, name: 'city_name')  String? cityName, @JsonKey(includeIfNull: false, name: 'display_order')  num? displayOrder, @JsonKey(includeIfNull: false, name: 'eew_enabled')  bool? eewEnabled, @JsonKey(includeIfNull: false, name: 'eew_min_intensity')  JmaIntensity? eewMinIntensity, @JsonKey(includeIfNull: false, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(includeIfNull: false, name: 'earthquake_enabled')  bool? earthquakeEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_min_intensity')  JmaIntensity? earthquakeMinIntensity, @JsonKey(includeIfNull: false, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides)  $default,) {final _that = this;
switch (_that) {
case _ReplaceSlotEntry():
return $default(_that.slotType,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'slot_type')  SlotType slotType, @JsonKey(includeIfNull: false, name: 'region_id')  num? regionId, @JsonKey(includeIfNull: false, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: false, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: false, name: 'city_name')  String? cityName, @JsonKey(includeIfNull: false, name: 'display_order')  num? displayOrder, @JsonKey(includeIfNull: false, name: 'eew_enabled')  bool? eewEnabled, @JsonKey(includeIfNull: false, name: 'eew_min_intensity')  JmaIntensity? eewMinIntensity, @JsonKey(includeIfNull: false, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(includeIfNull: false, name: 'earthquake_enabled')  bool? earthquakeEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_min_intensity')  JmaIntensity? earthquakeMinIntensity, @JsonKey(includeIfNull: false, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides)?  $default,) {final _that = this;
switch (_that) {
case _ReplaceSlotEntry() when $default != null:
return $default(_that.slotType,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplaceSlotEntry implements ReplaceSlotEntry {
  const _ReplaceSlotEntry({@JsonKey(name: 'slot_type') required this.slotType, @JsonKey(includeIfNull: false, name: 'region_id') this.regionId, @JsonKey(includeIfNull: false, name: 'region_name') this.regionName, @JsonKey(includeIfNull: false, name: 'city_code') this.cityCode, @JsonKey(includeIfNull: false, name: 'city_name') this.cityName, @JsonKey(includeIfNull: false, name: 'display_order') this.displayOrder, @JsonKey(includeIfNull: false, name: 'eew_enabled') this.eewEnabled, @JsonKey(includeIfNull: false, name: 'eew_min_intensity') this.eewMinIntensity, @JsonKey(includeIfNull: false, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(includeIfNull: false, name: 'earthquake_enabled') this.earthquakeEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_min_intensity') this.earthquakeMinIntensity, @JsonKey(includeIfNull: false, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides}): _eewOverrides = eewOverrides,_earthquakeOverrides = earthquakeOverrides;
  factory _ReplaceSlotEntry.fromJson(Map<String, dynamic> json) => _$ReplaceSlotEntryFromJson(json);

@override@JsonKey(name: 'slot_type') final  SlotType slotType;
@override@JsonKey(includeIfNull: false, name: 'region_id') final  num? regionId;
@override@JsonKey(includeIfNull: false, name: 'region_name') final  String? regionName;
@override@JsonKey(includeIfNull: false, name: 'city_code') final  String? cityCode;
@override@JsonKey(includeIfNull: false, name: 'city_name') final  String? cityName;
@override@JsonKey(includeIfNull: false, name: 'display_order') final  num? displayOrder;
@override@JsonKey(includeIfNull: false, name: 'eew_enabled') final  bool? eewEnabled;
@override@JsonKey(includeIfNull: false, name: 'eew_min_intensity') final  JmaIntensity? eewMinIntensity;
 final  List<SlotOverride>? _eewOverrides;
@override@JsonKey(includeIfNull: false, name: 'eew_overrides') List<SlotOverride>? get eewOverrides {
  final value = _eewOverrides;
  if (value == null) return null;
  if (_eewOverrides is EqualUnmodifiableListView) return _eewOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false, name: 'earthquake_enabled') final  bool? earthquakeEnabled;
@override@JsonKey(includeIfNull: false, name: 'earthquake_min_intensity') final  JmaIntensity? earthquakeMinIntensity;
 final  List<SlotOverride>? _earthquakeOverrides;
@override@JsonKey(includeIfNull: false, name: 'earthquake_overrides') List<SlotOverride>? get earthquakeOverrides {
  final value = _earthquakeOverrides;
  if (value == null) return null;
  if (_earthquakeOverrides is EqualUnmodifiableListView) return _earthquakeOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ReplaceSlotEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplaceSlotEntryCopyWith<_ReplaceSlotEntry> get copyWith => __$ReplaceSlotEntryCopyWithImpl<_ReplaceSlotEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplaceSlotEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplaceSlotEntry&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.eewMinIntensity, eewMinIntensity) || other.eewMinIntensity == eewMinIntensity)&&const DeepCollectionEquality().equals(other._eewOverrides, _eewOverrides)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.earthquakeMinIntensity, earthquakeMinIntensity) || other.earthquakeMinIntensity == earthquakeMinIntensity)&&const DeepCollectionEquality().equals(other._earthquakeOverrides, _earthquakeOverrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotType,regionId,regionName,cityCode,cityName,displayOrder,eewEnabled,eewMinIntensity,const DeepCollectionEquality().hash(_eewOverrides),earthquakeEnabled,earthquakeMinIntensity,const DeepCollectionEquality().hash(_earthquakeOverrides));

@override
String toString() {
  return 'ReplaceSlotEntry(slotType: $slotType, regionId: $regionId, regionName: $regionName, cityCode: $cityCode, cityName: $cityName, displayOrder: $displayOrder, eewEnabled: $eewEnabled, eewMinIntensity: $eewMinIntensity, eewOverrides: $eewOverrides, earthquakeEnabled: $earthquakeEnabled, earthquakeMinIntensity: $earthquakeMinIntensity, earthquakeOverrides: $earthquakeOverrides)';
}


}

/// @nodoc
abstract mixin class _$ReplaceSlotEntryCopyWith<$Res> implements $ReplaceSlotEntryCopyWith<$Res> {
  factory _$ReplaceSlotEntryCopyWith(_ReplaceSlotEntry value, $Res Function(_ReplaceSlotEntry) _then) = __$ReplaceSlotEntryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'slot_type') SlotType slotType,@JsonKey(includeIfNull: false, name: 'region_id') num? regionId,@JsonKey(includeIfNull: false, name: 'region_name') String? regionName,@JsonKey(includeIfNull: false, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: false, name: 'city_name') String? cityName,@JsonKey(includeIfNull: false, name: 'display_order') num? displayOrder,@JsonKey(includeIfNull: false, name: 'eew_enabled') bool? eewEnabled,@JsonKey(includeIfNull: false, name: 'eew_min_intensity') JmaIntensity? eewMinIntensity,@JsonKey(includeIfNull: false, name: 'eew_overrides') List<SlotOverride>? eewOverrides,@JsonKey(includeIfNull: false, name: 'earthquake_enabled') bool? earthquakeEnabled,@JsonKey(includeIfNull: false, name: 'earthquake_min_intensity') JmaIntensity? earthquakeMinIntensity,@JsonKey(includeIfNull: false, name: 'earthquake_overrides') List<SlotOverride>? earthquakeOverrides
});




}
/// @nodoc
class __$ReplaceSlotEntryCopyWithImpl<$Res>
    implements _$ReplaceSlotEntryCopyWith<$Res> {
  __$ReplaceSlotEntryCopyWithImpl(this._self, this._then);

  final _ReplaceSlotEntry _self;
  final $Res Function(_ReplaceSlotEntry) _then;

/// Create a copy of ReplaceSlotEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slotType = null,Object? regionId = freezed,Object? regionName = freezed,Object? cityCode = freezed,Object? cityName = freezed,Object? displayOrder = freezed,Object? eewEnabled = freezed,Object? eewMinIntensity = freezed,Object? eewOverrides = freezed,Object? earthquakeEnabled = freezed,Object? earthquakeMinIntensity = freezed,Object? earthquakeOverrides = freezed,}) {
  return _then(_ReplaceSlotEntry(
slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as SlotType,regionId: freezed == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as num?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: freezed == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as num?,eewEnabled: freezed == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool?,eewMinIntensity: freezed == eewMinIntensity ? _self.eewMinIntensity : eewMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,eewOverrides: freezed == eewOverrides ? _self._eewOverrides : eewOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,earthquakeEnabled: freezed == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool?,earthquakeMinIntensity: freezed == earthquakeMinIntensity ? _self.earthquakeMinIntensity : earthquakeMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,earthquakeOverrides: freezed == earthquakeOverrides ? _self._earthquakeOverrides : earthquakeOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,
  ));
}


}

// dart format on
