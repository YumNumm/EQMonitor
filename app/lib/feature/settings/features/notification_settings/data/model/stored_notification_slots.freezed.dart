// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stored_notification_slots.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoredNotificationSlots {

 List<NotificationSlot> get slots;
/// Create a copy of StoredNotificationSlots
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoredNotificationSlotsCopyWith<StoredNotificationSlots> get copyWith => _$StoredNotificationSlotsCopyWithImpl<StoredNotificationSlots>(this as StoredNotificationSlots, _$identity);

  /// Serializes this StoredNotificationSlots to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoredNotificationSlots&&const DeepCollectionEquality().equals(other.slots, slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(slots));

@override
String toString() {
  return 'StoredNotificationSlots(slots: $slots)';
}


}

/// @nodoc
abstract mixin class $StoredNotificationSlotsCopyWith<$Res>  {
  factory $StoredNotificationSlotsCopyWith(StoredNotificationSlots value, $Res Function(StoredNotificationSlots) _then) = _$StoredNotificationSlotsCopyWithImpl;
@useResult
$Res call({
 List<NotificationSlot> slots
});




}
/// @nodoc
class _$StoredNotificationSlotsCopyWithImpl<$Res>
    implements $StoredNotificationSlotsCopyWith<$Res> {
  _$StoredNotificationSlotsCopyWithImpl(this._self, this._then);

  final StoredNotificationSlots _self;
  final $Res Function(StoredNotificationSlots) _then;

/// Create a copy of StoredNotificationSlots
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slots = null,}) {
  return _then(StoredNotificationSlots(
slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<NotificationSlot>,
  ));
}

}


/// Adds pattern-matching-related methods to [StoredNotificationSlots].
extension StoredNotificationSlotsPatterns on StoredNotificationSlots {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoredNotificationSlots value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoredNotificationSlots() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoredNotificationSlots value)  $default,){
final _that = this;
switch (_that) {
case _StoredNotificationSlots():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoredNotificationSlots value)?  $default,){
final _that = this;
switch (_that) {
case _StoredNotificationSlots() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NotificationSlot> slots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoredNotificationSlots() when $default != null:
return $default(_that.slots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NotificationSlot> slots)  $default,) {final _that = this;
switch (_that) {
case _StoredNotificationSlots():
return $default(_that.slots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NotificationSlot> slots)?  $default,) {final _that = this;
switch (_that) {
case _StoredNotificationSlots() when $default != null:
return $default(_that.slots);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _StoredNotificationSlots implements StoredNotificationSlots {
  const _StoredNotificationSlots({required  List<NotificationSlot> slots}): _slots = slots;
  factory _StoredNotificationSlots.fromJson(Map<String, dynamic> json) => _$StoredNotificationSlotsFromJson(json);

 final  List<NotificationSlot> _slots;
@override List<NotificationSlot> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}


/// Create a copy of StoredNotificationSlots
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoredNotificationSlotsCopyWith<_StoredNotificationSlots> get copyWith => __$StoredNotificationSlotsCopyWithImpl<_StoredNotificationSlots>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoredNotificationSlotsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoredNotificationSlots&&const DeepCollectionEquality().equals(other._slots, _slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_slots));

@override
String toString() {
  return 'StoredNotificationSlots(slots: $slots)';
}


}

/// @nodoc
abstract mixin class _$StoredNotificationSlotsCopyWith<$Res> implements $StoredNotificationSlotsCopyWith<$Res> {
  factory _$StoredNotificationSlotsCopyWith(_StoredNotificationSlots value, $Res Function(_StoredNotificationSlots) _then) = __$StoredNotificationSlotsCopyWithImpl;
@override @useResult
$Res call({
 List<NotificationSlot> slots
});




}
/// @nodoc
class __$StoredNotificationSlotsCopyWithImpl<$Res>
    implements _$StoredNotificationSlotsCopyWith<$Res> {
  __$StoredNotificationSlotsCopyWithImpl(this._self, this._then);

  final _StoredNotificationSlots _self;
  final $Res Function(_StoredNotificationSlots) _then;

/// Create a copy of StoredNotificationSlots
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slots = null,}) {
  return _then(_StoredNotificationSlots(
slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<NotificationSlot>,
  ));
}


}

// dart format on
