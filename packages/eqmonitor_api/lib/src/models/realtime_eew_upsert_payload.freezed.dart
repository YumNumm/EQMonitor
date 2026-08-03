// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_eew_upsert_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeEewUpsertPayload {

 RealtimeEewUpsertPayloadType get type; RealtimeEewUpsertPayloadOperation get operation;@JsonKey(name: 'event_id') String get eventId; EewItemWithRelations get record;
/// Create a copy of RealtimeEewUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEewUpsertPayloadCopyWith<RealtimeEewUpsertPayload> get copyWith => _$RealtimeEewUpsertPayloadCopyWithImpl<RealtimeEewUpsertPayload>(this as RealtimeEewUpsertPayload, _$identity);

  /// Serializes this RealtimeEewUpsertPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEewUpsertPayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId,record);

@override
String toString() {
  return 'RealtimeEewUpsertPayload(type: $type, operation: $operation, eventId: $eventId, record: $record)';
}


}

/// @nodoc
abstract mixin class $RealtimeEewUpsertPayloadCopyWith<$Res>  {
  factory $RealtimeEewUpsertPayloadCopyWith(RealtimeEewUpsertPayload value, $Res Function(RealtimeEewUpsertPayload) _then) = _$RealtimeEewUpsertPayloadCopyWithImpl;
@useResult
$Res call({
 RealtimeEewUpsertPayloadType type, RealtimeEewUpsertPayloadOperation operation,@JsonKey(name: 'event_id') String eventId, EewItemWithRelations record
});


$EewItemWithRelationsCopyWith<$Res> get record;

}
/// @nodoc
class _$RealtimeEewUpsertPayloadCopyWithImpl<$Res>
    implements $RealtimeEewUpsertPayloadCopyWith<$Res> {
  _$RealtimeEewUpsertPayloadCopyWithImpl(this._self, this._then);

  final RealtimeEewUpsertPayload _self;
  final $Res Function(RealtimeEewUpsertPayload) _then;

/// Create a copy of RealtimeEewUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? operation = null,Object? eventId = null,Object? record = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeEewUpsertPayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeEewUpsertPayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as EewItemWithRelations,
  ));
}
/// Create a copy of RealtimeEewUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewItemWithRelationsCopyWith<$Res> get record {

  return $EewItemWithRelationsCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [RealtimeEewUpsertPayload].
extension RealtimeEewUpsertPayloadPatterns on RealtimeEewUpsertPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeEewUpsertPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeEewUpsertPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeEewUpsertPayload value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeEewUpsertPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeEewUpsertPayload value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeEewUpsertPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RealtimeEewUpsertPayloadType type,  RealtimeEewUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId,  EewItemWithRelations record)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeEewUpsertPayload() when $default != null:
return $default(_that.type,_that.operation,_that.eventId,_that.record);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RealtimeEewUpsertPayloadType type,  RealtimeEewUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId,  EewItemWithRelations record)  $default,) {final _that = this;
switch (_that) {
case _RealtimeEewUpsertPayload():
return $default(_that.type,_that.operation,_that.eventId,_that.record);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RealtimeEewUpsertPayloadType type,  RealtimeEewUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId,  EewItemWithRelations record)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeEewUpsertPayload() when $default != null:
return $default(_that.type,_that.operation,_that.eventId,_that.record);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeEewUpsertPayload implements RealtimeEewUpsertPayload {
  const _RealtimeEewUpsertPayload({required this.type, required this.operation, @JsonKey(name: 'event_id') required this.eventId, required this.record});
  factory _RealtimeEewUpsertPayload.fromJson(Map<String, dynamic> json) => _$RealtimeEewUpsertPayloadFromJson(json);

@override final  RealtimeEewUpsertPayloadType type;
@override final  RealtimeEewUpsertPayloadOperation operation;
@override@JsonKey(name: 'event_id') final  String eventId;
@override final  EewItemWithRelations record;

/// Create a copy of RealtimeEewUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeEewUpsertPayloadCopyWith<_RealtimeEewUpsertPayload> get copyWith => __$RealtimeEewUpsertPayloadCopyWithImpl<_RealtimeEewUpsertPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeEewUpsertPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeEewUpsertPayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId,record);

@override
String toString() {
  return 'RealtimeEewUpsertPayload(type: $type, operation: $operation, eventId: $eventId, record: $record)';
}


}

/// @nodoc
abstract mixin class _$RealtimeEewUpsertPayloadCopyWith<$Res> implements $RealtimeEewUpsertPayloadCopyWith<$Res> {
  factory _$RealtimeEewUpsertPayloadCopyWith(_RealtimeEewUpsertPayload value, $Res Function(_RealtimeEewUpsertPayload) _then) = __$RealtimeEewUpsertPayloadCopyWithImpl;
@override @useResult
$Res call({
 RealtimeEewUpsertPayloadType type, RealtimeEewUpsertPayloadOperation operation,@JsonKey(name: 'event_id') String eventId, EewItemWithRelations record
});


@override $EewItemWithRelationsCopyWith<$Res> get record;

}
/// @nodoc
class __$RealtimeEewUpsertPayloadCopyWithImpl<$Res>
    implements _$RealtimeEewUpsertPayloadCopyWith<$Res> {
  __$RealtimeEewUpsertPayloadCopyWithImpl(this._self, this._then);

  final _RealtimeEewUpsertPayload _self;
  final $Res Function(_RealtimeEewUpsertPayload) _then;

/// Create a copy of RealtimeEewUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? operation = null,Object? eventId = null,Object? record = null,}) {
  return _then(_RealtimeEewUpsertPayload(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeEewUpsertPayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeEewUpsertPayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as EewItemWithRelations,
  ));
}

/// Create a copy of RealtimeEewUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewItemWithRelationsCopyWith<$Res> get record {

  return $EewItemWithRelationsCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

// dart format on
