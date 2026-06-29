// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationSlot {

 String get id; NotificationSlotType get slotType; int? get regionId; String? get regionName; String? get cityCode; String? get cityName; int get displayOrder; bool get eewEnabled; JmaIntensity? get eewMinIntensity; List<NotificationOverride>? get eewOverrides; bool get earthquakeEnabled; JmaIntensity? get earthquakeMinIntensity; List<NotificationOverride>? get earthquakeOverrides;
/// Create a copy of NotificationSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSlotCopyWith<NotificationSlot> get copyWith => _$NotificationSlotCopyWithImpl<NotificationSlot>(this as NotificationSlot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.eewMinIntensity, eewMinIntensity) || other.eewMinIntensity == eewMinIntensity)&&const DeepCollectionEquality().equals(other.eewOverrides, eewOverrides)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.earthquakeMinIntensity, earthquakeMinIntensity) || other.earthquakeMinIntensity == earthquakeMinIntensity)&&const DeepCollectionEquality().equals(other.earthquakeOverrides, earthquakeOverrides));
}


@override
int get hashCode => Object.hash(runtimeType,id,slotType,regionId,regionName,cityCode,cityName,displayOrder,eewEnabled,eewMinIntensity,const DeepCollectionEquality().hash(eewOverrides),earthquakeEnabled,earthquakeMinIntensity,const DeepCollectionEquality().hash(earthquakeOverrides));

@override
String toString() {
  return 'NotificationSlot(id: $id, slotType: $slotType, regionId: $regionId, regionName: $regionName, cityCode: $cityCode, cityName: $cityName, displayOrder: $displayOrder, eewEnabled: $eewEnabled, eewMinIntensity: $eewMinIntensity, eewOverrides: $eewOverrides, earthquakeEnabled: $earthquakeEnabled, earthquakeMinIntensity: $earthquakeMinIntensity, earthquakeOverrides: $earthquakeOverrides)';
}


}

/// @nodoc
abstract mixin class $NotificationSlotCopyWith<$Res>  {
  factory $NotificationSlotCopyWith(NotificationSlot value, $Res Function(NotificationSlot) _then) = _$NotificationSlotCopyWithImpl;
@useResult
$Res call({
 String id, NotificationSlotType slotType, int? regionId, String? regionName, String? cityCode, String? cityName, int displayOrder, bool eewEnabled, JmaIntensity? eewMinIntensity, List<NotificationOverride>? eewOverrides, bool earthquakeEnabled, JmaIntensity? earthquakeMinIntensity, List<NotificationOverride>? earthquakeOverrides
});




}
/// @nodoc
class _$NotificationSlotCopyWithImpl<$Res>
    implements $NotificationSlotCopyWith<$Res> {
  _$NotificationSlotCopyWithImpl(this._self, this._then);

  final NotificationSlot _self;
  final $Res Function(NotificationSlot) _then;

/// Create a copy of NotificationSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slotType = null,Object? regionId = freezed,Object? regionName = freezed,Object? cityCode = freezed,Object? cityName = freezed,Object? displayOrder = null,Object? eewEnabled = null,Object? eewMinIntensity = freezed,Object? eewOverrides = freezed,Object? earthquakeEnabled = null,Object? earthquakeMinIntensity = freezed,Object? earthquakeOverrides = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as NotificationSlotType,regionId: freezed == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,eewEnabled: null == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool,eewMinIntensity: freezed == eewMinIntensity ? _self.eewMinIntensity : eewMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,eewOverrides: freezed == eewOverrides ? _self.eewOverrides : eewOverrides // ignore: cast_nullable_to_non_nullable
as List<NotificationOverride>?,earthquakeEnabled: null == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeMinIntensity: freezed == earthquakeMinIntensity ? _self.earthquakeMinIntensity : earthquakeMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,earthquakeOverrides: freezed == earthquakeOverrides ? _self.earthquakeOverrides : earthquakeOverrides // ignore: cast_nullable_to_non_nullable
as List<NotificationOverride>?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSlot].
extension NotificationSlotPatterns on NotificationSlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSlot value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSlot value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSlot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  NotificationSlotType slotType,  int? regionId,  String? regionName,  String? cityCode,  String? cityName,  int displayOrder,  bool eewEnabled,  JmaIntensity? eewMinIntensity,  List<NotificationOverride>? eewOverrides,  bool earthquakeEnabled,  JmaIntensity? earthquakeMinIntensity,  List<NotificationOverride>? earthquakeOverrides)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSlot() when $default != null:
return $default(_that.id,_that.slotType,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  NotificationSlotType slotType,  int? regionId,  String? regionName,  String? cityCode,  String? cityName,  int displayOrder,  bool eewEnabled,  JmaIntensity? eewMinIntensity,  List<NotificationOverride>? eewOverrides,  bool earthquakeEnabled,  JmaIntensity? earthquakeMinIntensity,  List<NotificationOverride>? earthquakeOverrides)  $default,) {final _that = this;
switch (_that) {
case _NotificationSlot():
return $default(_that.id,_that.slotType,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  NotificationSlotType slotType,  int? regionId,  String? regionName,  String? cityCode,  String? cityName,  int displayOrder,  bool eewEnabled,  JmaIntensity? eewMinIntensity,  List<NotificationOverride>? eewOverrides,  bool earthquakeEnabled,  JmaIntensity? earthquakeMinIntensity,  List<NotificationOverride>? earthquakeOverrides)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSlot() when $default != null:
return $default(_that.id,_that.slotType,_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.displayOrder,_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationSlot implements NotificationSlot {
  const _NotificationSlot({required this.id, required this.slotType, required this.regionId, required this.regionName, required this.cityCode, required this.cityName, required this.displayOrder, required this.eewEnabled, required this.eewMinIntensity, required final  List<NotificationOverride>? eewOverrides, required this.earthquakeEnabled, required this.earthquakeMinIntensity, required final  List<NotificationOverride>? earthquakeOverrides}): _eewOverrides = eewOverrides,_earthquakeOverrides = earthquakeOverrides;
  

@override final  String id;
@override final  NotificationSlotType slotType;
@override final  int? regionId;
@override final  String? regionName;
@override final  String? cityCode;
@override final  String? cityName;
@override final  int displayOrder;
@override final  bool eewEnabled;
@override final  JmaIntensity? eewMinIntensity;
 final  List<NotificationOverride>? _eewOverrides;
@override List<NotificationOverride>? get eewOverrides {
  final value = _eewOverrides;
  if (value == null) return null;
  if (_eewOverrides is EqualUnmodifiableListView) return _eewOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool earthquakeEnabled;
@override final  JmaIntensity? earthquakeMinIntensity;
 final  List<NotificationOverride>? _earthquakeOverrides;
@override List<NotificationOverride>? get earthquakeOverrides {
  final value = _earthquakeOverrides;
  if (value == null) return null;
  if (_earthquakeOverrides is EqualUnmodifiableListView) return _earthquakeOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of NotificationSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSlotCopyWith<_NotificationSlot> get copyWith => __$NotificationSlotCopyWithImpl<_NotificationSlot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.eewMinIntensity, eewMinIntensity) || other.eewMinIntensity == eewMinIntensity)&&const DeepCollectionEquality().equals(other._eewOverrides, _eewOverrides)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.earthquakeMinIntensity, earthquakeMinIntensity) || other.earthquakeMinIntensity == earthquakeMinIntensity)&&const DeepCollectionEquality().equals(other._earthquakeOverrides, _earthquakeOverrides));
}


@override
int get hashCode => Object.hash(runtimeType,id,slotType,regionId,regionName,cityCode,cityName,displayOrder,eewEnabled,eewMinIntensity,const DeepCollectionEquality().hash(_eewOverrides),earthquakeEnabled,earthquakeMinIntensity,const DeepCollectionEquality().hash(_earthquakeOverrides));

@override
String toString() {
  return 'NotificationSlot(id: $id, slotType: $slotType, regionId: $regionId, regionName: $regionName, cityCode: $cityCode, cityName: $cityName, displayOrder: $displayOrder, eewEnabled: $eewEnabled, eewMinIntensity: $eewMinIntensity, eewOverrides: $eewOverrides, earthquakeEnabled: $earthquakeEnabled, earthquakeMinIntensity: $earthquakeMinIntensity, earthquakeOverrides: $earthquakeOverrides)';
}


}

/// @nodoc
abstract mixin class _$NotificationSlotCopyWith<$Res> implements $NotificationSlotCopyWith<$Res> {
  factory _$NotificationSlotCopyWith(_NotificationSlot value, $Res Function(_NotificationSlot) _then) = __$NotificationSlotCopyWithImpl;
@override @useResult
$Res call({
 String id, NotificationSlotType slotType, int? regionId, String? regionName, String? cityCode, String? cityName, int displayOrder, bool eewEnabled, JmaIntensity? eewMinIntensity, List<NotificationOverride>? eewOverrides, bool earthquakeEnabled, JmaIntensity? earthquakeMinIntensity, List<NotificationOverride>? earthquakeOverrides
});




}
/// @nodoc
class __$NotificationSlotCopyWithImpl<$Res>
    implements _$NotificationSlotCopyWith<$Res> {
  __$NotificationSlotCopyWithImpl(this._self, this._then);

  final _NotificationSlot _self;
  final $Res Function(_NotificationSlot) _then;

/// Create a copy of NotificationSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slotType = null,Object? regionId = freezed,Object? regionName = freezed,Object? cityCode = freezed,Object? cityName = freezed,Object? displayOrder = null,Object? eewEnabled = null,Object? eewMinIntensity = freezed,Object? eewOverrides = freezed,Object? earthquakeEnabled = null,Object? earthquakeMinIntensity = freezed,Object? earthquakeOverrides = freezed,}) {
  return _then(_NotificationSlot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as NotificationSlotType,regionId: freezed == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,eewEnabled: null == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool,eewMinIntensity: freezed == eewMinIntensity ? _self.eewMinIntensity : eewMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,eewOverrides: freezed == eewOverrides ? _self._eewOverrides : eewOverrides // ignore: cast_nullable_to_non_nullable
as List<NotificationOverride>?,earthquakeEnabled: null == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool,earthquakeMinIntensity: freezed == earthquakeMinIntensity ? _self.earthquakeMinIntensity : earthquakeMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,earthquakeOverrides: freezed == earthquakeOverrides ? _self._earthquakeOverrides : earthquakeOverrides // ignore: cast_nullable_to_non_nullable
as List<NotificationOverride>?,
  ));
}


}

// dart format on
