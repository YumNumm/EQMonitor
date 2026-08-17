// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_custom_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationCustomSnapshot {

 int get schemaVersion; List<NotificationSlotDraft> get slots; EewWarningSettings get eewWarning; EewGlobalSettings get eewGlobal; EarthquakeGlobalSettings get earthquakeGlobal; GeneralNotificationSettings get general;
/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCustomSnapshotCopyWith<NotificationCustomSnapshot> get copyWith => _$NotificationCustomSnapshotCopyWithImpl<NotificationCustomSnapshot>(this as NotificationCustomSnapshot, _$identity);

  /// Serializes this NotificationCustomSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationCustomSnapshot&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.slots, slots)&&(identical(other.eewWarning, eewWarning) || other.eewWarning == eewWarning)&&(identical(other.eewGlobal, eewGlobal) || other.eewGlobal == eewGlobal)&&(identical(other.earthquakeGlobal, earthquakeGlobal) || other.earthquakeGlobal == earthquakeGlobal)&&(identical(other.general, general) || other.general == general));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(slots),eewWarning,eewGlobal,earthquakeGlobal,general);

@override
String toString() {
  return 'NotificationCustomSnapshot(schemaVersion: $schemaVersion, slots: $slots, eewWarning: $eewWarning, eewGlobal: $eewGlobal, earthquakeGlobal: $earthquakeGlobal, general: $general)';
}


}

/// @nodoc
abstract mixin class $NotificationCustomSnapshotCopyWith<$Res>  {
  factory $NotificationCustomSnapshotCopyWith(NotificationCustomSnapshot value, $Res Function(NotificationCustomSnapshot) _then) = _$NotificationCustomSnapshotCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<NotificationSlotDraft> slots, EewWarningSettings eewWarning, EewGlobalSettings eewGlobal, EarthquakeGlobalSettings earthquakeGlobal, GeneralNotificationSettings general
});


$EewWarningSettingsCopyWith<$Res> get eewWarning;$EewGlobalSettingsCopyWith<$Res> get eewGlobal;$EarthquakeGlobalSettingsCopyWith<$Res> get earthquakeGlobal;$GeneralNotificationSettingsCopyWith<$Res> get general;

}
/// @nodoc
class _$NotificationCustomSnapshotCopyWithImpl<$Res>
    implements $NotificationCustomSnapshotCopyWith<$Res> {
  _$NotificationCustomSnapshotCopyWithImpl(this._self, this._then);

  final NotificationCustomSnapshot _self;
  final $Res Function(NotificationCustomSnapshot) _then;

/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? slots = null,Object? eewWarning = null,Object? eewGlobal = null,Object? earthquakeGlobal = null,Object? general = null,}) {
  return _then(NotificationCustomSnapshot(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<NotificationSlotDraft>,eewWarning: null == eewWarning ? _self.eewWarning : eewWarning // ignore: cast_nullable_to_non_nullable
as EewWarningSettings,eewGlobal: null == eewGlobal ? _self.eewGlobal : eewGlobal // ignore: cast_nullable_to_non_nullable
as EewGlobalSettings,earthquakeGlobal: null == earthquakeGlobal ? _self.earthquakeGlobal : earthquakeGlobal // ignore: cast_nullable_to_non_nullable
as EarthquakeGlobalSettings,general: null == general ? _self.general : general // ignore: cast_nullable_to_non_nullable
as GeneralNotificationSettings,
  ));
}
/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewWarningSettingsCopyWith<$Res> get eewWarning {
  
  return $EewWarningSettingsCopyWith<$Res>(_self.eewWarning, (value) {
    return _then(_self.copyWith(eewWarning: value));
  });
}/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewGlobalSettingsCopyWith<$Res> get eewGlobal {
  
  return $EewGlobalSettingsCopyWith<$Res>(_self.eewGlobal, (value) {
    return _then(_self.copyWith(eewGlobal: value));
  });
}/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeGlobalSettingsCopyWith<$Res> get earthquakeGlobal {
  
  return $EarthquakeGlobalSettingsCopyWith<$Res>(_self.earthquakeGlobal, (value) {
    return _then(_self.copyWith(earthquakeGlobal: value));
  });
}/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeneralNotificationSettingsCopyWith<$Res> get general {
  
  return $GeneralNotificationSettingsCopyWith<$Res>(_self.general, (value) {
    return _then(_self.copyWith(general: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationCustomSnapshot].
extension NotificationCustomSnapshotPatterns on NotificationCustomSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationCustomSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationCustomSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationCustomSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _NotificationCustomSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationCustomSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationCustomSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<NotificationSlotDraft> slots,  EewWarningSettings eewWarning,  EewGlobalSettings eewGlobal,  EarthquakeGlobalSettings earthquakeGlobal,  GeneralNotificationSettings general)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationCustomSnapshot() when $default != null:
return $default(_that.schemaVersion,_that.slots,_that.eewWarning,_that.eewGlobal,_that.earthquakeGlobal,_that.general);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<NotificationSlotDraft> slots,  EewWarningSettings eewWarning,  EewGlobalSettings eewGlobal,  EarthquakeGlobalSettings earthquakeGlobal,  GeneralNotificationSettings general)  $default,) {final _that = this;
switch (_that) {
case _NotificationCustomSnapshot():
return $default(_that.schemaVersion,_that.slots,_that.eewWarning,_that.eewGlobal,_that.earthquakeGlobal,_that.general);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<NotificationSlotDraft> slots,  EewWarningSettings eewWarning,  EewGlobalSettings eewGlobal,  EarthquakeGlobalSettings earthquakeGlobal,  GeneralNotificationSettings general)?  $default,) {final _that = this;
switch (_that) {
case _NotificationCustomSnapshot() when $default != null:
return $default(_that.schemaVersion,_that.slots,_that.eewWarning,_that.eewGlobal,_that.earthquakeGlobal,_that.general);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationCustomSnapshot implements NotificationCustomSnapshot {
  const _NotificationCustomSnapshot({required this.schemaVersion, required  List<NotificationSlotDraft> slots, required this.eewWarning, required this.eewGlobal, required this.earthquakeGlobal, required this.general}): _slots = slots;
  factory _NotificationCustomSnapshot.fromJson(Map<String, dynamic> json) => _$NotificationCustomSnapshotFromJson(json);

@override final  int schemaVersion;
 final  List<NotificationSlotDraft> _slots;
@override List<NotificationSlotDraft> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}

@override final  EewWarningSettings eewWarning;
@override final  EewGlobalSettings eewGlobal;
@override final  EarthquakeGlobalSettings earthquakeGlobal;
@override final  GeneralNotificationSettings general;

/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationCustomSnapshotCopyWith<_NotificationCustomSnapshot> get copyWith => __$NotificationCustomSnapshotCopyWithImpl<_NotificationCustomSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationCustomSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationCustomSnapshot&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._slots, _slots)&&(identical(other.eewWarning, eewWarning) || other.eewWarning == eewWarning)&&(identical(other.eewGlobal, eewGlobal) || other.eewGlobal == eewGlobal)&&(identical(other.earthquakeGlobal, earthquakeGlobal) || other.earthquakeGlobal == earthquakeGlobal)&&(identical(other.general, general) || other.general == general));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_slots),eewWarning,eewGlobal,earthquakeGlobal,general);

@override
String toString() {
  return 'NotificationCustomSnapshot(schemaVersion: $schemaVersion, slots: $slots, eewWarning: $eewWarning, eewGlobal: $eewGlobal, earthquakeGlobal: $earthquakeGlobal, general: $general)';
}


}

/// @nodoc
abstract mixin class _$NotificationCustomSnapshotCopyWith<$Res> implements $NotificationCustomSnapshotCopyWith<$Res> {
  factory _$NotificationCustomSnapshotCopyWith(_NotificationCustomSnapshot value, $Res Function(_NotificationCustomSnapshot) _then) = __$NotificationCustomSnapshotCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<NotificationSlotDraft> slots, EewWarningSettings eewWarning, EewGlobalSettings eewGlobal, EarthquakeGlobalSettings earthquakeGlobal, GeneralNotificationSettings general
});


@override $EewWarningSettingsCopyWith<$Res> get eewWarning;@override $EewGlobalSettingsCopyWith<$Res> get eewGlobal;@override $EarthquakeGlobalSettingsCopyWith<$Res> get earthquakeGlobal;@override $GeneralNotificationSettingsCopyWith<$Res> get general;

}
/// @nodoc
class __$NotificationCustomSnapshotCopyWithImpl<$Res>
    implements _$NotificationCustomSnapshotCopyWith<$Res> {
  __$NotificationCustomSnapshotCopyWithImpl(this._self, this._then);

  final _NotificationCustomSnapshot _self;
  final $Res Function(_NotificationCustomSnapshot) _then;

/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? slots = null,Object? eewWarning = null,Object? eewGlobal = null,Object? earthquakeGlobal = null,Object? general = null,}) {
  return _then(_NotificationCustomSnapshot(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<NotificationSlotDraft>,eewWarning: null == eewWarning ? _self.eewWarning : eewWarning // ignore: cast_nullable_to_non_nullable
as EewWarningSettings,eewGlobal: null == eewGlobal ? _self.eewGlobal : eewGlobal // ignore: cast_nullable_to_non_nullable
as EewGlobalSettings,earthquakeGlobal: null == earthquakeGlobal ? _self.earthquakeGlobal : earthquakeGlobal // ignore: cast_nullable_to_non_nullable
as EarthquakeGlobalSettings,general: null == general ? _self.general : general // ignore: cast_nullable_to_non_nullable
as GeneralNotificationSettings,
  ));
}

/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewWarningSettingsCopyWith<$Res> get eewWarning {
  
  return $EewWarningSettingsCopyWith<$Res>(_self.eewWarning, (value) {
    return _then(_self.copyWith(eewWarning: value));
  });
}/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewGlobalSettingsCopyWith<$Res> get eewGlobal {
  
  return $EewGlobalSettingsCopyWith<$Res>(_self.eewGlobal, (value) {
    return _then(_self.copyWith(eewGlobal: value));
  });
}/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeGlobalSettingsCopyWith<$Res> get earthquakeGlobal {
  
  return $EarthquakeGlobalSettingsCopyWith<$Res>(_self.earthquakeGlobal, (value) {
    return _then(_self.copyWith(earthquakeGlobal: value));
  });
}/// Create a copy of NotificationCustomSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeneralNotificationSettingsCopyWith<$Res> get general {
  
  return $GeneralNotificationSettingsCopyWith<$Res>(_self.general, (value) {
    return _then(_self.copyWith(general: value));
  });
}
}

// dart format on
