// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_estimated_intensity_upsert_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeEstimatedIntensityUpsertPayload {

 RealtimeEstimatedIntensityUpsertPayloadType get type; RealtimeEstimatedIntensityUpsertPayloadOperation get operation;@JsonKey(name: 'event_id') String get eventId; EstimatedIntensityEvent get record;
/// Create a copy of RealtimeEstimatedIntensityUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEstimatedIntensityUpsertPayloadCopyWith<RealtimeEstimatedIntensityUpsertPayload> get copyWith => _$RealtimeEstimatedIntensityUpsertPayloadCopyWithImpl<RealtimeEstimatedIntensityUpsertPayload>(this as RealtimeEstimatedIntensityUpsertPayload, _$identity);

  /// Serializes this RealtimeEstimatedIntensityUpsertPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEstimatedIntensityUpsertPayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId,record);

@override
String toString() {
  return 'RealtimeEstimatedIntensityUpsertPayload(type: $type, operation: $operation, eventId: $eventId, record: $record)';
}


}

/// @nodoc
abstract mixin class $RealtimeEstimatedIntensityUpsertPayloadCopyWith<$Res>  {
  factory $RealtimeEstimatedIntensityUpsertPayloadCopyWith(RealtimeEstimatedIntensityUpsertPayload value, $Res Function(RealtimeEstimatedIntensityUpsertPayload) _then) = _$RealtimeEstimatedIntensityUpsertPayloadCopyWithImpl;
@useResult
$Res call({
 RealtimeEstimatedIntensityUpsertPayloadType type, RealtimeEstimatedIntensityUpsertPayloadOperation operation,@JsonKey(name: 'event_id') String eventId, EstimatedIntensityEvent record
});


$EstimatedIntensityEventCopyWith<$Res> get record;

}
/// @nodoc
class _$RealtimeEstimatedIntensityUpsertPayloadCopyWithImpl<$Res>
    implements $RealtimeEstimatedIntensityUpsertPayloadCopyWith<$Res> {
  _$RealtimeEstimatedIntensityUpsertPayloadCopyWithImpl(this._self, this._then);

  final RealtimeEstimatedIntensityUpsertPayload _self;
  final $Res Function(RealtimeEstimatedIntensityUpsertPayload) _then;

/// Create a copy of RealtimeEstimatedIntensityUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? operation = null,Object? eventId = null,Object? record = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeEstimatedIntensityUpsertPayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeEstimatedIntensityUpsertPayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as EstimatedIntensityEvent,
  ));
}
/// Create a copy of RealtimeEstimatedIntensityUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstimatedIntensityEventCopyWith<$Res> get record {

  return $EstimatedIntensityEventCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [RealtimeEstimatedIntensityUpsertPayload].
extension RealtimeEstimatedIntensityUpsertPayloadPatterns on RealtimeEstimatedIntensityUpsertPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeEstimatedIntensityUpsertPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeEstimatedIntensityUpsertPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeEstimatedIntensityUpsertPayload value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeEstimatedIntensityUpsertPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeEstimatedIntensityUpsertPayload value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeEstimatedIntensityUpsertPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RealtimeEstimatedIntensityUpsertPayloadType type,  RealtimeEstimatedIntensityUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId,  EstimatedIntensityEvent record)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeEstimatedIntensityUpsertPayload() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RealtimeEstimatedIntensityUpsertPayloadType type,  RealtimeEstimatedIntensityUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId,  EstimatedIntensityEvent record)  $default,) {final _that = this;
switch (_that) {
case _RealtimeEstimatedIntensityUpsertPayload():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RealtimeEstimatedIntensityUpsertPayloadType type,  RealtimeEstimatedIntensityUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId,  EstimatedIntensityEvent record)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeEstimatedIntensityUpsertPayload() when $default != null:
return $default(_that.type,_that.operation,_that.eventId,_that.record);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeEstimatedIntensityUpsertPayload implements RealtimeEstimatedIntensityUpsertPayload {
  const _RealtimeEstimatedIntensityUpsertPayload({required this.type, required this.operation, @JsonKey(name: 'event_id') required this.eventId, required this.record});
  factory _RealtimeEstimatedIntensityUpsertPayload.fromJson(Map<String, dynamic> json) => _$RealtimeEstimatedIntensityUpsertPayloadFromJson(json);

@override final  RealtimeEstimatedIntensityUpsertPayloadType type;
@override final  RealtimeEstimatedIntensityUpsertPayloadOperation operation;
@override@JsonKey(name: 'event_id') final  String eventId;
@override final  EstimatedIntensityEvent record;

/// Create a copy of RealtimeEstimatedIntensityUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeEstimatedIntensityUpsertPayloadCopyWith<_RealtimeEstimatedIntensityUpsertPayload> get copyWith => __$RealtimeEstimatedIntensityUpsertPayloadCopyWithImpl<_RealtimeEstimatedIntensityUpsertPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeEstimatedIntensityUpsertPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeEstimatedIntensityUpsertPayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId,record);

@override
String toString() {
  return 'RealtimeEstimatedIntensityUpsertPayload(type: $type, operation: $operation, eventId: $eventId, record: $record)';
}


}

/// @nodoc
abstract mixin class _$RealtimeEstimatedIntensityUpsertPayloadCopyWith<$Res> implements $RealtimeEstimatedIntensityUpsertPayloadCopyWith<$Res> {
  factory _$RealtimeEstimatedIntensityUpsertPayloadCopyWith(_RealtimeEstimatedIntensityUpsertPayload value, $Res Function(_RealtimeEstimatedIntensityUpsertPayload) _then) = __$RealtimeEstimatedIntensityUpsertPayloadCopyWithImpl;
@override @useResult
$Res call({
 RealtimeEstimatedIntensityUpsertPayloadType type, RealtimeEstimatedIntensityUpsertPayloadOperation operation,@JsonKey(name: 'event_id') String eventId, EstimatedIntensityEvent record
});


@override $EstimatedIntensityEventCopyWith<$Res> get record;

}
/// @nodoc
class __$RealtimeEstimatedIntensityUpsertPayloadCopyWithImpl<$Res>
    implements _$RealtimeEstimatedIntensityUpsertPayloadCopyWith<$Res> {
  __$RealtimeEstimatedIntensityUpsertPayloadCopyWithImpl(this._self, this._then);

  final _RealtimeEstimatedIntensityUpsertPayload _self;
  final $Res Function(_RealtimeEstimatedIntensityUpsertPayload) _then;

/// Create a copy of RealtimeEstimatedIntensityUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? operation = null,Object? eventId = null,Object? record = null,}) {
  return _then(_RealtimeEstimatedIntensityUpsertPayload(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeEstimatedIntensityUpsertPayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeEstimatedIntensityUpsertPayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as EstimatedIntensityEvent,
  ));
}

/// Create a copy of RealtimeEstimatedIntensityUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstimatedIntensityEventCopyWith<$Res> get record {

  return $EstimatedIntensityEventCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

// dart format on
