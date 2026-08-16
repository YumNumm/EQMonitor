// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_slot_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSlotDraft {

 NotificationSlotType get slotType; bool get eewEnabled; bool get earthquakeEnabled; int? get regionId; String? get regionName; String? get cityCode; String? get cityName; int? get displayOrder; JmaIntensity? get eewMinIntensity; List<NotificationOverride>? get eewOverrides; JmaIntensity? get earthquakeMinIntensity; List<NotificationOverride>? get earthquakeOverrides;
/// Create a copy of NotificationSlotDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSlotDraftCopyWith<NotificationSlotDraft> get copyWith => _$NotificationSlotDraftCopyWithImpl<NotificationSlotDraft>(this as NotificationSlotDraft, _$identity);

  /// Serializes this NotificationSlotDraft to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSlotDraft&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.eewMinIntensity, eewMinIntensity) || other.eewMinIntensity == eewMinIntensity)&&const DeepCollectionEquality().equals(other.eewOverrides, eewOverrides)&&(identical(other.earthquakeMinIntensity, earthquakeMinIntensity) || other.earthquakeMinIntensity == earthquakeMinIntensity)&&const DeepCollectionEquality().equals(other.earthquakeOverrides, earthquakeOverrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotType,eewEnabled,earthquakeEnabled,regionId,regionName,cityCode,cityName,displayOrder,eewMinIntensity,const DeepCollectionEquality().hash(eewOverrides),earthquakeMinIntensity,const DeepCollectionEquality().hash(earthquakeOverrides));

@override
String toString() {
  return 'NotificationSlotDraft(slotType: $slotType, eewEnabled: $eewEnabled, earthquakeEnabled: $earthquakeEnabled, regionId: $regionId, regionName: $regionName, cityCode: $cityCode, cityName: $cityName, displayOrder: $displayOrder, eewMinIntensity: $eewMinIntensity, eewOverrides: $eewOverrides, earthquakeMinIntensity: $earthquakeMinIntensity, earthquakeOverrides: $earthquakeOverrides)';
}


}

/// @nodoc
abstract mixin class $NotificationSlotDraftCopyWith<$Res>  {
  factory $NotificationSlotDraftCopyWith(NotificationSlotDraft value, $Res Function(NotificationSlotDraft) _then) = _$NotificationSlotDraftCopyWithImpl;
@useResult
$Res call({
 NotificationSlotType slotType, bool eewEnabled, bool earthquakeEnabled, int? regionId, String? regionName, String? cityCode, String? cityName, int? displayOrder, JmaIntensity? eewMinIntensity, List<NotificationOverride>? eewOverrides, JmaIntensity? earthquakeMinIntensity, List<NotificationOverride>? earthquakeOverrides
});




}
/// @nodoc
class _$NotificationSlotDraftCopyWithImpl<$Res>
    implements $NotificationSlotDraftCopyWith<$Res> {
  _$NotificationSlotDraftCopyWithImpl(this._self, this._then);

  final NotificationSlotDraft _self;
  final $Res Function(NotificationSlotDraft) _then;

/// Create a copy of NotificationSlotDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slotType = null,Object? eewEnabled = null,Object? earthquakeEnabled = null,Object? regionId = freezed,Object? regionName = freezed,Object? cityCode = freezed,Object? cityName = freezed,Object? displayOrder = freezed,Object? eewMinIntensity = freezed,Object? eewOverrides = freezed,Object? earthquakeMinIntensity = freezed,Object? earthquakeOverrides = freezed,}) {
  return _then(NotificationSlotDraft(
slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as NotificationSlotType,eewEnabled: null == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeEnabled: null == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool,regionId: freezed == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: freezed == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int?,eewMinIntensity: freezed == eewMinIntensity ? _self.eewMinIntensity : eewMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,eewOverrides: freezed == eewOverrides ? _self.eewOverrides : eewOverrides // ignore: cast_nullable_to_non_nullable
as List<NotificationOverride>?,earthquakeMinIntensity: freezed == earthquakeMinIntensity ? _self.earthquakeMinIntensity : earthquakeMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,earthquakeOverrides: freezed == earthquakeOverrides ? _self.earthquakeOverrides : earthquakeOverrides // ignore: cast_nullable_to_non_nullable
as List<NotificationOverride>?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSlotDraft].
extension NotificationSlotDraftPatterns on NotificationSlotDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSlotDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSlotDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSlotDraft value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSlotDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSlotDraft value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSlotDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NotificationSlotType slotType,  bool eewEnabled,  bool earthquakeEnabled,  int? regionId,  String? regionName,  String? cityCode,  String? cityName,  int? displayOrder,  JmaIntensity? eewMinIntensity,  List<NotificationOverride>? eewOverrides,  JmaIntensity? earthquakeMinIntensity,  List<NotificationOverride>? earthquakeOverrides)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSlotDraft() when $default != null:
return $default(_that.slotType,_that.eewEnabled,_that.earthquakeEnabled,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NotificationSlotType slotType,  bool eewEnabled,  bool earthquakeEnabled,  int? regionId,  String? regionName,  String? cityCode,  String? cityName,  int? displayOrder,  JmaIntensity? eewMinIntensity,  List<NotificationOverride>? eewOverrides,  JmaIntensity? earthquakeMinIntensity,  List<NotificationOverride>? earthquakeOverrides)  $default,) {final _that = this;
switch (_that) {
case _NotificationSlotDraft():
return $default(_that.slotType,_that.eewEnabled,_that.earthquakeEnabled,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NotificationSlotType slotType,  bool eewEnabled,  bool earthquakeEnabled,  int? regionId,  String? regionName,  String? cityCode,  String? cityName,  int? displayOrder,  JmaIntensity? eewMinIntensity,  List<NotificationOverride>? eewOverrides,  JmaIntensity? earthquakeMinIntensity,  List<NotificationOverride>? earthquakeOverrides)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSlotDraft() when $default != null:
return $default(_that.slotType,_that.eewEnabled,_that.earthquakeEnabled,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSlotDraft implements NotificationSlotDraft {
  const _NotificationSlotDraft({required this.slotType, required this.eewEnabled, required this.earthquakeEnabled, this.regionId, this.regionName, this.cityCode, this.cityName, this.displayOrder, this.eewMinIntensity,  List<NotificationOverride>? eewOverrides, this.earthquakeMinIntensity,  List<NotificationOverride>? earthquakeOverrides}): _eewOverrides = eewOverrides,_earthquakeOverrides = earthquakeOverrides;
  factory _NotificationSlotDraft.fromJson(Map<String, dynamic> json) => _$NotificationSlotDraftFromJson(json);

@override final  NotificationSlotType slotType;
@override final  bool eewEnabled;
@override final  bool earthquakeEnabled;
@override final  int? regionId;
@override final  String? regionName;
@override final  String? cityCode;
@override final  String? cityName;
@override final  int? displayOrder;
@override final  JmaIntensity? eewMinIntensity;
 final  List<NotificationOverride>? _eewOverrides;
@override List<NotificationOverride>? get eewOverrides {
  final value = _eewOverrides;
  if (value == null) return null;
  if (_eewOverrides is EqualUnmodifiableListView) return _eewOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  JmaIntensity? earthquakeMinIntensity;
 final  List<NotificationOverride>? _earthquakeOverrides;
@override List<NotificationOverride>? get earthquakeOverrides {
  final value = _earthquakeOverrides;
  if (value == null) return null;
  if (_earthquakeOverrides is EqualUnmodifiableListView) return _earthquakeOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of NotificationSlotDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSlotDraftCopyWith<_NotificationSlotDraft> get copyWith => __$NotificationSlotDraftCopyWithImpl<_NotificationSlotDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSlotDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSlotDraft&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.eewMinIntensity, eewMinIntensity) || other.eewMinIntensity == eewMinIntensity)&&const DeepCollectionEquality().equals(other._eewOverrides, _eewOverrides)&&(identical(other.earthquakeMinIntensity, earthquakeMinIntensity) || other.earthquakeMinIntensity == earthquakeMinIntensity)&&const DeepCollectionEquality().equals(other._earthquakeOverrides, _earthquakeOverrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotType,eewEnabled,earthquakeEnabled,regionId,regionName,cityCode,cityName,displayOrder,eewMinIntensity,const DeepCollectionEquality().hash(_eewOverrides),earthquakeMinIntensity,const DeepCollectionEquality().hash(_earthquakeOverrides));

@override
String toString() {
  return 'NotificationSlotDraft(slotType: $slotType, eewEnabled: $eewEnabled, earthquakeEnabled: $earthquakeEnabled, regionId: $regionId, regionName: $regionName, cityCode: $cityCode, cityName: $cityName, displayOrder: $displayOrder, eewMinIntensity: $eewMinIntensity, eewOverrides: $eewOverrides, earthquakeMinIntensity: $earthquakeMinIntensity, earthquakeOverrides: $earthquakeOverrides)';
}


}

/// @nodoc
abstract mixin class _$NotificationSlotDraftCopyWith<$Res> implements $NotificationSlotDraftCopyWith<$Res> {
  factory _$NotificationSlotDraftCopyWith(_NotificationSlotDraft value, $Res Function(_NotificationSlotDraft) _then) = __$NotificationSlotDraftCopyWithImpl;
@override @useResult
$Res call({
 NotificationSlotType slotType, bool eewEnabled, bool earthquakeEnabled, int? regionId, String? regionName, String? cityCode, String? cityName, int? displayOrder, JmaIntensity? eewMinIntensity, List<NotificationOverride>? eewOverrides, JmaIntensity? earthquakeMinIntensity, List<NotificationOverride>? earthquakeOverrides
});




}
/// @nodoc
class __$NotificationSlotDraftCopyWithImpl<$Res>
    implements _$NotificationSlotDraftCopyWith<$Res> {
  __$NotificationSlotDraftCopyWithImpl(this._self, this._then);

  final _NotificationSlotDraft _self;
  final $Res Function(_NotificationSlotDraft) _then;

/// Create a copy of NotificationSlotDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slotType = null,Object? eewEnabled = null,Object? earthquakeEnabled = null,Object? regionId = freezed,Object? regionName = freezed,Object? cityCode = freezed,Object? cityName = freezed,Object? displayOrder = freezed,Object? eewMinIntensity = freezed,Object? eewOverrides = freezed,Object? earthquakeMinIntensity = freezed,Object? earthquakeOverrides = freezed,}) {
  return _then(_NotificationSlotDraft(
slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as NotificationSlotType,eewEnabled: null == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeEnabled: null == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool,regionId: freezed == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: freezed == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int?,eewMinIntensity: freezed == eewMinIntensity ? _self.eewMinIntensity : eewMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,eewOverrides: freezed == eewOverrides ? _self._eewOverrides : eewOverrides // ignore: cast_nullable_to_non_nullable
as List<NotificationOverride>?,earthquakeMinIntensity: freezed == earthquakeMinIntensity ? _self.earthquakeMinIntensity : earthquakeMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,earthquakeOverrides: freezed == earthquakeOverrides ? _self._earthquakeOverrides : earthquakeOverrides // ignore: cast_nullable_to_non_nullable
as List<NotificationOverride>?,
  ));
}


}

// dart format on
