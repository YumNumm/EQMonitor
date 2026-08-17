// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_file_trigger.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReplayFileTrigger {

 String get id; String get replayFileId;/// const: "SHAKE_DETECTION" | const: "EARTHQUAKE"
 TriggerType get triggerType; String get eventId; String get createdAt;
/// Create a copy of ReplayFileTrigger
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayFileTriggerCopyWith<ReplayFileTrigger> get copyWith => _$ReplayFileTriggerCopyWithImpl<ReplayFileTrigger>(this as ReplayFileTrigger, _$identity);

  /// Serializes this ReplayFileTrigger to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayFileTrigger&&(identical(other.id, id) || other.id == id)&&(identical(other.replayFileId, replayFileId) || other.replayFileId == replayFileId)&&(identical(other.triggerType, triggerType) || other.triggerType == triggerType)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,replayFileId,triggerType,eventId,createdAt);

@override
String toString() {
  return 'ReplayFileTrigger(id: $id, replayFileId: $replayFileId, triggerType: $triggerType, eventId: $eventId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ReplayFileTriggerCopyWith<$Res>  {
  factory $ReplayFileTriggerCopyWith(ReplayFileTrigger value, $Res Function(ReplayFileTrigger) _then) = _$ReplayFileTriggerCopyWithImpl;
@useResult
$Res call({
 String id, String replayFileId, TriggerType triggerType, String eventId, String createdAt
});




}
/// @nodoc
class _$ReplayFileTriggerCopyWithImpl<$Res>
    implements $ReplayFileTriggerCopyWith<$Res> {
  _$ReplayFileTriggerCopyWithImpl(this._self, this._then);

  final ReplayFileTrigger _self;
  final $Res Function(ReplayFileTrigger) _then;

/// Create a copy of ReplayFileTrigger
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? replayFileId = null,Object? triggerType = null,Object? eventId = null,Object? createdAt = null,}) {
  return _then(ReplayFileTrigger(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,replayFileId: null == replayFileId ? _self.replayFileId : replayFileId // ignore: cast_nullable_to_non_nullable
as String,triggerType: null == triggerType ? _self.triggerType : triggerType // ignore: cast_nullable_to_non_nullable
as TriggerType,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayFileTrigger].
extension ReplayFileTriggerPatterns on ReplayFileTrigger {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayFileTrigger value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayFileTrigger() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayFileTrigger value)  $default,){
final _that = this;
switch (_that) {
case _ReplayFileTrigger():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayFileTrigger value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayFileTrigger() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String replayFileId,  TriggerType triggerType,  String eventId,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayFileTrigger() when $default != null:
return $default(_that.id,_that.replayFileId,_that.triggerType,_that.eventId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String replayFileId,  TriggerType triggerType,  String eventId,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _ReplayFileTrigger():
return $default(_that.id,_that.replayFileId,_that.triggerType,_that.eventId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String replayFileId,  TriggerType triggerType,  String eventId,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ReplayFileTrigger() when $default != null:
return $default(_that.id,_that.replayFileId,_that.triggerType,_that.eventId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplayFileTrigger implements ReplayFileTrigger {
  const _ReplayFileTrigger({required this.id, required this.replayFileId, required this.triggerType, required this.eventId, required this.createdAt});
  factory _ReplayFileTrigger.fromJson(Map<String, dynamic> json) => _$ReplayFileTriggerFromJson(json);

@override final  String id;
@override final  String replayFileId;
/// const: "SHAKE_DETECTION" | const: "EARTHQUAKE"
@override final  TriggerType triggerType;
@override final  String eventId;
@override final  String createdAt;

/// Create a copy of ReplayFileTrigger
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayFileTriggerCopyWith<_ReplayFileTrigger> get copyWith => __$ReplayFileTriggerCopyWithImpl<_ReplayFileTrigger>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplayFileTriggerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayFileTrigger&&(identical(other.id, id) || other.id == id)&&(identical(other.replayFileId, replayFileId) || other.replayFileId == replayFileId)&&(identical(other.triggerType, triggerType) || other.triggerType == triggerType)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,replayFileId,triggerType,eventId,createdAt);

@override
String toString() {
  return 'ReplayFileTrigger(id: $id, replayFileId: $replayFileId, triggerType: $triggerType, eventId: $eventId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReplayFileTriggerCopyWith<$Res> implements $ReplayFileTriggerCopyWith<$Res> {
  factory _$ReplayFileTriggerCopyWith(_ReplayFileTrigger value, $Res Function(_ReplayFileTrigger) _then) = __$ReplayFileTriggerCopyWithImpl;
@override @useResult
$Res call({
 String id, String replayFileId, TriggerType triggerType, String eventId, String createdAt
});




}
/// @nodoc
class __$ReplayFileTriggerCopyWithImpl<$Res>
    implements _$ReplayFileTriggerCopyWith<$Res> {
  __$ReplayFileTriggerCopyWithImpl(this._self, this._then);

  final _ReplayFileTrigger _self;
  final $Res Function(_ReplayFileTrigger) _then;

/// Create a copy of ReplayFileTrigger
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? replayFileId = null,Object? triggerType = null,Object? eventId = null,Object? createdAt = null,}) {
  return _then(_ReplayFileTrigger(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,replayFileId: null == replayFileId ? _self.replayFileId : replayFileId // ignore: cast_nullable_to_non_nullable
as String,triggerType: null == triggerType ? _self.triggerType : triggerType // ignore: cast_nullable_to_non_nullable
as TriggerType,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
