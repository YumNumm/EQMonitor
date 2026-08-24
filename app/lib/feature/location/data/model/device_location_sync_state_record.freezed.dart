// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_location_sync_state_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceLocationSyncStateRecord {

 DeviceLocationSyncScope get scope; DeviceLocationPayload get payload;
/// Create a copy of DeviceLocationSyncStateRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceLocationSyncStateRecordCopyWith<DeviceLocationSyncStateRecord> get copyWith => _$DeviceLocationSyncStateRecordCopyWithImpl<DeviceLocationSyncStateRecord>(this as DeviceLocationSyncStateRecord, _$identity);

  /// Serializes this DeviceLocationSyncStateRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceLocationSyncStateRecord&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scope,payload);

@override
String toString() {
  return 'DeviceLocationSyncStateRecord(scope: $scope, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $DeviceLocationSyncStateRecordCopyWith<$Res>  {
  factory $DeviceLocationSyncStateRecordCopyWith(DeviceLocationSyncStateRecord value, $Res Function(DeviceLocationSyncStateRecord) _then) = _$DeviceLocationSyncStateRecordCopyWithImpl;
@useResult
$Res call({
 DeviceLocationSyncScope scope, DeviceLocationPayload payload
});


$DeviceLocationSyncScopeCopyWith<$Res> get scope;$DeviceLocationPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class _$DeviceLocationSyncStateRecordCopyWithImpl<$Res>
    implements $DeviceLocationSyncStateRecordCopyWith<$Res> {
  _$DeviceLocationSyncStateRecordCopyWithImpl(this._self, this._then);

  final DeviceLocationSyncStateRecord _self;
  final $Res Function(DeviceLocationSyncStateRecord) _then;

/// Create a copy of DeviceLocationSyncStateRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scope = null,Object? payload = null,}) {
  return _then(DeviceLocationSyncStateRecord(
scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as DeviceLocationSyncScope,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as DeviceLocationPayload,
  ));
}
/// Create a copy of DeviceLocationSyncStateRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceLocationSyncScopeCopyWith<$Res> get scope {

  return $DeviceLocationSyncScopeCopyWith<$Res>(_self.scope, (value) {
    return _then(_self.copyWith(scope: value));
  });
}/// Create a copy of DeviceLocationSyncStateRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceLocationPayloadCopyWith<$Res> get payload {

  return $DeviceLocationPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeviceLocationSyncStateRecord].
extension DeviceLocationSyncStateRecordPatterns on DeviceLocationSyncStateRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceLocationSyncStateRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceLocationSyncStateRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceLocationSyncStateRecord value)  $default,){
final _that = this;
switch (_that) {
case _DeviceLocationSyncStateRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceLocationSyncStateRecord value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceLocationSyncStateRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeviceLocationSyncScope scope,  DeviceLocationPayload payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceLocationSyncStateRecord() when $default != null:
return $default(_that.scope,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeviceLocationSyncScope scope,  DeviceLocationPayload payload)  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationSyncStateRecord():
return $default(_that.scope,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeviceLocationSyncScope scope,  DeviceLocationPayload payload)?  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationSyncStateRecord() when $default != null:
return $default(_that.scope,_that.payload);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _DeviceLocationSyncStateRecord implements DeviceLocationSyncStateRecord {
  const _DeviceLocationSyncStateRecord({required this.scope, required this.payload});
  factory _DeviceLocationSyncStateRecord.fromJson(Map<String, dynamic> json) => _$DeviceLocationSyncStateRecordFromJson(json);

@override final  DeviceLocationSyncScope scope;
@override final  DeviceLocationPayload payload;

/// Create a copy of DeviceLocationSyncStateRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceLocationSyncStateRecordCopyWith<_DeviceLocationSyncStateRecord> get copyWith => __$DeviceLocationSyncStateRecordCopyWithImpl<_DeviceLocationSyncStateRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceLocationSyncStateRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceLocationSyncStateRecord&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scope,payload);

@override
String toString() {
  return 'DeviceLocationSyncStateRecord(scope: $scope, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$DeviceLocationSyncStateRecordCopyWith<$Res> implements $DeviceLocationSyncStateRecordCopyWith<$Res> {
  factory _$DeviceLocationSyncStateRecordCopyWith(_DeviceLocationSyncStateRecord value, $Res Function(_DeviceLocationSyncStateRecord) _then) = __$DeviceLocationSyncStateRecordCopyWithImpl;
@override @useResult
$Res call({
 DeviceLocationSyncScope scope, DeviceLocationPayload payload
});


@override $DeviceLocationSyncScopeCopyWith<$Res> get scope;@override $DeviceLocationPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class __$DeviceLocationSyncStateRecordCopyWithImpl<$Res>
    implements _$DeviceLocationSyncStateRecordCopyWith<$Res> {
  __$DeviceLocationSyncStateRecordCopyWithImpl(this._self, this._then);

  final _DeviceLocationSyncStateRecord _self;
  final $Res Function(_DeviceLocationSyncStateRecord) _then;

/// Create a copy of DeviceLocationSyncStateRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scope = null,Object? payload = null,}) {
  return _then(_DeviceLocationSyncStateRecord(
scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as DeviceLocationSyncScope,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as DeviceLocationPayload,
  ));
}

/// Create a copy of DeviceLocationSyncStateRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceLocationSyncScopeCopyWith<$Res> get scope {

  return $DeviceLocationSyncScopeCopyWith<$Res>(_self.scope, (value) {
    return _then(_self.copyWith(scope: value));
  });
}/// Create a copy of DeviceLocationSyncStateRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceLocationPayloadCopyWith<$Res> get payload {

  return $DeviceLocationPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}

// dart format on
