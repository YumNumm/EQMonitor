// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_tsunami_upsert_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeTsunamiUpsertPayload {

 RealtimeTsunamiUpsertPayloadType get type; RealtimeTsunamiUpsertPayloadOperation get operation;@JsonKey(name: 'event_id') String get eventId;@JsonKey(includeIfNull: false, name: 'group_id') String? get groupId;
/// Create a copy of RealtimeTsunamiUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTsunamiUpsertPayloadCopyWith<RealtimeTsunamiUpsertPayload> get copyWith => _$RealtimeTsunamiUpsertPayloadCopyWithImpl<RealtimeTsunamiUpsertPayload>(this as RealtimeTsunamiUpsertPayload, _$identity);

  /// Serializes this RealtimeTsunamiUpsertPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTsunamiUpsertPayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId,groupId);

@override
String toString() {
  return 'RealtimeTsunamiUpsertPayload(type: $type, operation: $operation, eventId: $eventId, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class $RealtimeTsunamiUpsertPayloadCopyWith<$Res>  {
  factory $RealtimeTsunamiUpsertPayloadCopyWith(RealtimeTsunamiUpsertPayload value, $Res Function(RealtimeTsunamiUpsertPayload) _then) = _$RealtimeTsunamiUpsertPayloadCopyWithImpl;
@useResult
$Res call({
 RealtimeTsunamiUpsertPayloadType type, RealtimeTsunamiUpsertPayloadOperation operation,@JsonKey(name: 'event_id') String eventId,@JsonKey(includeIfNull: false, name: 'group_id') String? groupId
});




}
/// @nodoc
class _$RealtimeTsunamiUpsertPayloadCopyWithImpl<$Res>
    implements $RealtimeTsunamiUpsertPayloadCopyWith<$Res> {
  _$RealtimeTsunamiUpsertPayloadCopyWithImpl(this._self, this._then);

  final RealtimeTsunamiUpsertPayload _self;
  final $Res Function(RealtimeTsunamiUpsertPayload) _then;

/// Create a copy of RealtimeTsunamiUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? operation = null,Object? eventId = null,Object? groupId = freezed,}) {
  return _then(RealtimeTsunamiUpsertPayload(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeTsunamiUpsertPayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeTsunamiUpsertPayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeTsunamiUpsertPayload].
extension RealtimeTsunamiUpsertPayloadPatterns on RealtimeTsunamiUpsertPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeTsunamiUpsertPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeTsunamiUpsertPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeTsunamiUpsertPayload value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeTsunamiUpsertPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeTsunamiUpsertPayload value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeTsunamiUpsertPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RealtimeTsunamiUpsertPayloadType type,  RealtimeTsunamiUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId, @JsonKey(includeIfNull: false, name: 'group_id')  String? groupId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeTsunamiUpsertPayload() when $default != null:
return $default(_that.type,_that.operation,_that.eventId,_that.groupId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RealtimeTsunamiUpsertPayloadType type,  RealtimeTsunamiUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId, @JsonKey(includeIfNull: false, name: 'group_id')  String? groupId)  $default,) {final _that = this;
switch (_that) {
case _RealtimeTsunamiUpsertPayload():
return $default(_that.type,_that.operation,_that.eventId,_that.groupId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RealtimeTsunamiUpsertPayloadType type,  RealtimeTsunamiUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId, @JsonKey(includeIfNull: false, name: 'group_id')  String? groupId)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeTsunamiUpsertPayload() when $default != null:
return $default(_that.type,_that.operation,_that.eventId,_that.groupId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeTsunamiUpsertPayload implements RealtimeTsunamiUpsertPayload {
  const _RealtimeTsunamiUpsertPayload({required this.type, required this.operation, @JsonKey(name: 'event_id') required this.eventId, @JsonKey(includeIfNull: false, name: 'group_id') this.groupId});
  factory _RealtimeTsunamiUpsertPayload.fromJson(Map<String, dynamic> json) => _$RealtimeTsunamiUpsertPayloadFromJson(json);

@override final  RealtimeTsunamiUpsertPayloadType type;
@override final  RealtimeTsunamiUpsertPayloadOperation operation;
@override@JsonKey(name: 'event_id') final  String eventId;
@override@JsonKey(includeIfNull: false, name: 'group_id') final  String? groupId;

/// Create a copy of RealtimeTsunamiUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeTsunamiUpsertPayloadCopyWith<_RealtimeTsunamiUpsertPayload> get copyWith => __$RealtimeTsunamiUpsertPayloadCopyWithImpl<_RealtimeTsunamiUpsertPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeTsunamiUpsertPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeTsunamiUpsertPayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId,groupId);

@override
String toString() {
  return 'RealtimeTsunamiUpsertPayload(type: $type, operation: $operation, eventId: $eventId, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$RealtimeTsunamiUpsertPayloadCopyWith<$Res> implements $RealtimeTsunamiUpsertPayloadCopyWith<$Res> {
  factory _$RealtimeTsunamiUpsertPayloadCopyWith(_RealtimeTsunamiUpsertPayload value, $Res Function(_RealtimeTsunamiUpsertPayload) _then) = __$RealtimeTsunamiUpsertPayloadCopyWithImpl;
@override @useResult
$Res call({
 RealtimeTsunamiUpsertPayloadType type, RealtimeTsunamiUpsertPayloadOperation operation,@JsonKey(name: 'event_id') String eventId,@JsonKey(includeIfNull: false, name: 'group_id') String? groupId
});




}
/// @nodoc
class __$RealtimeTsunamiUpsertPayloadCopyWithImpl<$Res>
    implements _$RealtimeTsunamiUpsertPayloadCopyWith<$Res> {
  __$RealtimeTsunamiUpsertPayloadCopyWithImpl(this._self, this._then);

  final _RealtimeTsunamiUpsertPayload _self;
  final $Res Function(_RealtimeTsunamiUpsertPayload) _then;

/// Create a copy of RealtimeTsunamiUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? operation = null,Object? eventId = null,Object? groupId = freezed,}) {
  return _then(_RealtimeTsunamiUpsertPayload(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeTsunamiUpsertPayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeTsunamiUpsertPayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
