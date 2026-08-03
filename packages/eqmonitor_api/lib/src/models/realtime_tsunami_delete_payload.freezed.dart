// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_tsunami_delete_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeTsunamiDeletePayload {

 RealtimeTsunamiDeletePayloadType get type; RealtimeTsunamiDeletePayloadOperation get operation;@JsonKey(name: 'event_id') String get eventId;@JsonKey(includeIfNull: false, name: 'group_id') String? get groupId;
/// Create a copy of RealtimeTsunamiDeletePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTsunamiDeletePayloadCopyWith<RealtimeTsunamiDeletePayload> get copyWith => _$RealtimeTsunamiDeletePayloadCopyWithImpl<RealtimeTsunamiDeletePayload>(this as RealtimeTsunamiDeletePayload, _$identity);

  /// Serializes this RealtimeTsunamiDeletePayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTsunamiDeletePayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId,groupId);

@override
String toString() {
  return 'RealtimeTsunamiDeletePayload(type: $type, operation: $operation, eventId: $eventId, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class $RealtimeTsunamiDeletePayloadCopyWith<$Res>  {
  factory $RealtimeTsunamiDeletePayloadCopyWith(RealtimeTsunamiDeletePayload value, $Res Function(RealtimeTsunamiDeletePayload) _then) = _$RealtimeTsunamiDeletePayloadCopyWithImpl;
@useResult
$Res call({
 RealtimeTsunamiDeletePayloadType type, RealtimeTsunamiDeletePayloadOperation operation,@JsonKey(name: 'event_id') String eventId,@JsonKey(includeIfNull: false, name: 'group_id') String? groupId
});




}
/// @nodoc
class _$RealtimeTsunamiDeletePayloadCopyWithImpl<$Res>
    implements $RealtimeTsunamiDeletePayloadCopyWith<$Res> {
  _$RealtimeTsunamiDeletePayloadCopyWithImpl(this._self, this._then);

  final RealtimeTsunamiDeletePayload _self;
  final $Res Function(RealtimeTsunamiDeletePayload) _then;

/// Create a copy of RealtimeTsunamiDeletePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? operation = null,Object? eventId = null,Object? groupId = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeTsunamiDeletePayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeTsunamiDeletePayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeTsunamiDeletePayload].
extension RealtimeTsunamiDeletePayloadPatterns on RealtimeTsunamiDeletePayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeTsunamiDeletePayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeTsunamiDeletePayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeTsunamiDeletePayload value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeTsunamiDeletePayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeTsunamiDeletePayload value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeTsunamiDeletePayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RealtimeTsunamiDeletePayloadType type,  RealtimeTsunamiDeletePayloadOperation operation, @JsonKey(name: 'event_id')  String eventId, @JsonKey(includeIfNull: false, name: 'group_id')  String? groupId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeTsunamiDeletePayload() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RealtimeTsunamiDeletePayloadType type,  RealtimeTsunamiDeletePayloadOperation operation, @JsonKey(name: 'event_id')  String eventId, @JsonKey(includeIfNull: false, name: 'group_id')  String? groupId)  $default,) {final _that = this;
switch (_that) {
case _RealtimeTsunamiDeletePayload():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RealtimeTsunamiDeletePayloadType type,  RealtimeTsunamiDeletePayloadOperation operation, @JsonKey(name: 'event_id')  String eventId, @JsonKey(includeIfNull: false, name: 'group_id')  String? groupId)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeTsunamiDeletePayload() when $default != null:
return $default(_that.type,_that.operation,_that.eventId,_that.groupId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeTsunamiDeletePayload implements RealtimeTsunamiDeletePayload {
  const _RealtimeTsunamiDeletePayload({required this.type, required this.operation, @JsonKey(name: 'event_id') required this.eventId, @JsonKey(includeIfNull: false, name: 'group_id') this.groupId});
  factory _RealtimeTsunamiDeletePayload.fromJson(Map<String, dynamic> json) => _$RealtimeTsunamiDeletePayloadFromJson(json);

@override final  RealtimeTsunamiDeletePayloadType type;
@override final  RealtimeTsunamiDeletePayloadOperation operation;
@override@JsonKey(name: 'event_id') final  String eventId;
@override@JsonKey(includeIfNull: false, name: 'group_id') final  String? groupId;

/// Create a copy of RealtimeTsunamiDeletePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeTsunamiDeletePayloadCopyWith<_RealtimeTsunamiDeletePayload> get copyWith => __$RealtimeTsunamiDeletePayloadCopyWithImpl<_RealtimeTsunamiDeletePayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeTsunamiDeletePayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeTsunamiDeletePayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId,groupId);

@override
String toString() {
  return 'RealtimeTsunamiDeletePayload(type: $type, operation: $operation, eventId: $eventId, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$RealtimeTsunamiDeletePayloadCopyWith<$Res> implements $RealtimeTsunamiDeletePayloadCopyWith<$Res> {
  factory _$RealtimeTsunamiDeletePayloadCopyWith(_RealtimeTsunamiDeletePayload value, $Res Function(_RealtimeTsunamiDeletePayload) _then) = __$RealtimeTsunamiDeletePayloadCopyWithImpl;
@override @useResult
$Res call({
 RealtimeTsunamiDeletePayloadType type, RealtimeTsunamiDeletePayloadOperation operation,@JsonKey(name: 'event_id') String eventId,@JsonKey(includeIfNull: false, name: 'group_id') String? groupId
});




}
/// @nodoc
class __$RealtimeTsunamiDeletePayloadCopyWithImpl<$Res>
    implements _$RealtimeTsunamiDeletePayloadCopyWith<$Res> {
  __$RealtimeTsunamiDeletePayloadCopyWithImpl(this._self, this._then);

  final _RealtimeTsunamiDeletePayload _self;
  final $Res Function(_RealtimeTsunamiDeletePayload) _then;

/// Create a copy of RealtimeTsunamiDeletePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? operation = null,Object? eventId = null,Object? groupId = freezed,}) {
  return _then(_RealtimeTsunamiDeletePayload(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeTsunamiDeletePayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeTsunamiDeletePayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
