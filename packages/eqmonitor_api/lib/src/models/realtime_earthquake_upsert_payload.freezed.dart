// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_earthquake_upsert_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeEarthquakeUpsertPayload {

 RealtimeEarthquakeUpsertPayloadType get type; RealtimeEarthquakeUpsertPayloadOperation get operation;@JsonKey(name: 'event_id') String get eventId; Earthquake get record;
/// Create a copy of RealtimeEarthquakeUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEarthquakeUpsertPayloadCopyWith<RealtimeEarthquakeUpsertPayload> get copyWith => _$RealtimeEarthquakeUpsertPayloadCopyWithImpl<RealtimeEarthquakeUpsertPayload>(this as RealtimeEarthquakeUpsertPayload, _$identity);

  /// Serializes this RealtimeEarthquakeUpsertPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEarthquakeUpsertPayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId,record);

@override
String toString() {
  return 'RealtimeEarthquakeUpsertPayload(type: $type, operation: $operation, eventId: $eventId, record: $record)';
}


}

/// @nodoc
abstract mixin class $RealtimeEarthquakeUpsertPayloadCopyWith<$Res>  {
  factory $RealtimeEarthquakeUpsertPayloadCopyWith(RealtimeEarthquakeUpsertPayload value, $Res Function(RealtimeEarthquakeUpsertPayload) _then) = _$RealtimeEarthquakeUpsertPayloadCopyWithImpl;
@useResult
$Res call({
 RealtimeEarthquakeUpsertPayloadType type, RealtimeEarthquakeUpsertPayloadOperation operation,@JsonKey(name: 'event_id') String eventId, Earthquake record
});


$EarthquakeCopyWith<$Res> get record;

}
/// @nodoc
class _$RealtimeEarthquakeUpsertPayloadCopyWithImpl<$Res>
    implements $RealtimeEarthquakeUpsertPayloadCopyWith<$Res> {
  _$RealtimeEarthquakeUpsertPayloadCopyWithImpl(this._self, this._then);

  final RealtimeEarthquakeUpsertPayload _self;
  final $Res Function(RealtimeEarthquakeUpsertPayload) _then;

/// Create a copy of RealtimeEarthquakeUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? operation = null,Object? eventId = null,Object? record = null,}) {
  return _then(RealtimeEarthquakeUpsertPayload(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeEarthquakeUpsertPayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeEarthquakeUpsertPayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as Earthquake,
  ));
}
/// Create a copy of RealtimeEarthquakeUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<$Res> get record {

  return $EarthquakeCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [RealtimeEarthquakeUpsertPayload].
extension RealtimeEarthquakeUpsertPayloadPatterns on RealtimeEarthquakeUpsertPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeEarthquakeUpsertPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeEarthquakeUpsertPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeEarthquakeUpsertPayload value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeEarthquakeUpsertPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeEarthquakeUpsertPayload value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeEarthquakeUpsertPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RealtimeEarthquakeUpsertPayloadType type,  RealtimeEarthquakeUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId,  Earthquake record)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeEarthquakeUpsertPayload() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RealtimeEarthquakeUpsertPayloadType type,  RealtimeEarthquakeUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId,  Earthquake record)  $default,) {final _that = this;
switch (_that) {
case _RealtimeEarthquakeUpsertPayload():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RealtimeEarthquakeUpsertPayloadType type,  RealtimeEarthquakeUpsertPayloadOperation operation, @JsonKey(name: 'event_id')  String eventId,  Earthquake record)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeEarthquakeUpsertPayload() when $default != null:
return $default(_that.type,_that.operation,_that.eventId,_that.record);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeEarthquakeUpsertPayload implements RealtimeEarthquakeUpsertPayload {
  const _RealtimeEarthquakeUpsertPayload({required this.type, required this.operation, @JsonKey(name: 'event_id') required this.eventId, required this.record});
  factory _RealtimeEarthquakeUpsertPayload.fromJson(Map<String, dynamic> json) => _$RealtimeEarthquakeUpsertPayloadFromJson(json);

@override final  RealtimeEarthquakeUpsertPayloadType type;
@override final  RealtimeEarthquakeUpsertPayloadOperation operation;
@override@JsonKey(name: 'event_id') final  String eventId;
@override final  Earthquake record;

/// Create a copy of RealtimeEarthquakeUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeEarthquakeUpsertPayloadCopyWith<_RealtimeEarthquakeUpsertPayload> get copyWith => __$RealtimeEarthquakeUpsertPayloadCopyWithImpl<_RealtimeEarthquakeUpsertPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeEarthquakeUpsertPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeEarthquakeUpsertPayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId,record);

@override
String toString() {
  return 'RealtimeEarthquakeUpsertPayload(type: $type, operation: $operation, eventId: $eventId, record: $record)';
}


}

/// @nodoc
abstract mixin class _$RealtimeEarthquakeUpsertPayloadCopyWith<$Res> implements $RealtimeEarthquakeUpsertPayloadCopyWith<$Res> {
  factory _$RealtimeEarthquakeUpsertPayloadCopyWith(_RealtimeEarthquakeUpsertPayload value, $Res Function(_RealtimeEarthquakeUpsertPayload) _then) = __$RealtimeEarthquakeUpsertPayloadCopyWithImpl;
@override @useResult
$Res call({
 RealtimeEarthquakeUpsertPayloadType type, RealtimeEarthquakeUpsertPayloadOperation operation,@JsonKey(name: 'event_id') String eventId, Earthquake record
});


@override $EarthquakeCopyWith<$Res> get record;

}
/// @nodoc
class __$RealtimeEarthquakeUpsertPayloadCopyWithImpl<$Res>
    implements _$RealtimeEarthquakeUpsertPayloadCopyWith<$Res> {
  __$RealtimeEarthquakeUpsertPayloadCopyWithImpl(this._self, this._then);

  final _RealtimeEarthquakeUpsertPayload _self;
  final $Res Function(_RealtimeEarthquakeUpsertPayload) _then;

/// Create a copy of RealtimeEarthquakeUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? operation = null,Object? eventId = null,Object? record = null,}) {
  return _then(_RealtimeEarthquakeUpsertPayload(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeEarthquakeUpsertPayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeEarthquakeUpsertPayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as Earthquake,
  ));
}

/// Create a copy of RealtimeEarthquakeUpsertPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<$Res> get record {

  return $EarthquakeCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

// dart format on
