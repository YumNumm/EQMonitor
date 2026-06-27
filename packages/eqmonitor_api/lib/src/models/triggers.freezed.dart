// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'triggers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Triggers {

 String get id; String get replayFileId;/// const: "SHAKE_DETECTION" | const: "EARTHQUAKE"
 TriggerType get triggerType; String get eventId; String get createdAt;
/// Create a copy of Triggers
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TriggersCopyWith<Triggers> get copyWith => _$TriggersCopyWithImpl<Triggers>(this as Triggers, _$identity);

  /// Serializes this Triggers to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Triggers&&(identical(other.id, id) || other.id == id)&&(identical(other.replayFileId, replayFileId) || other.replayFileId == replayFileId)&&(identical(other.triggerType, triggerType) || other.triggerType == triggerType)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,replayFileId,triggerType,eventId,createdAt);

@override
String toString() {
  return 'Triggers(id: $id, replayFileId: $replayFileId, triggerType: $triggerType, eventId: $eventId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TriggersCopyWith<$Res>  {
  factory $TriggersCopyWith(Triggers value, $Res Function(Triggers) _then) = _$TriggersCopyWithImpl;
@useResult
$Res call({
 String id, String replayFileId, TriggerType triggerType, String eventId, String createdAt
});




}
/// @nodoc
class _$TriggersCopyWithImpl<$Res>
    implements $TriggersCopyWith<$Res> {
  _$TriggersCopyWithImpl(this._self, this._then);

  final Triggers _self;
  final $Res Function(Triggers) _then;

/// Create a copy of Triggers
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? replayFileId = null,Object? triggerType = null,Object? eventId = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,replayFileId: null == replayFileId ? _self.replayFileId : replayFileId // ignore: cast_nullable_to_non_nullable
as String,triggerType: null == triggerType ? _self.triggerType : triggerType // ignore: cast_nullable_to_non_nullable
as TriggerType,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Triggers].
extension TriggersPatterns on Triggers {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Triggers value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Triggers() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Triggers value)  $default,){
final _that = this;
switch (_that) {
case _Triggers():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Triggers value)?  $default,){
final _that = this;
switch (_that) {
case _Triggers() when $default != null:
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
case _Triggers() when $default != null:
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
case _Triggers():
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
case _Triggers() when $default != null:
return $default(_that.id,_that.replayFileId,_that.triggerType,_that.eventId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Triggers implements Triggers {
  const _Triggers({required this.id, required this.replayFileId, required this.triggerType, required this.eventId, required this.createdAt});
  factory _Triggers.fromJson(Map<String, dynamic> json) => _$TriggersFromJson(json);

@override final  String id;
@override final  String replayFileId;
/// const: "SHAKE_DETECTION" | const: "EARTHQUAKE"
@override final  TriggerType triggerType;
@override final  String eventId;
@override final  String createdAt;

/// Create a copy of Triggers
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TriggersCopyWith<_Triggers> get copyWith => __$TriggersCopyWithImpl<_Triggers>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TriggersToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Triggers&&(identical(other.id, id) || other.id == id)&&(identical(other.replayFileId, replayFileId) || other.replayFileId == replayFileId)&&(identical(other.triggerType, triggerType) || other.triggerType == triggerType)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,replayFileId,triggerType,eventId,createdAt);

@override
String toString() {
  return 'Triggers(id: $id, replayFileId: $replayFileId, triggerType: $triggerType, eventId: $eventId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TriggersCopyWith<$Res> implements $TriggersCopyWith<$Res> {
  factory _$TriggersCopyWith(_Triggers value, $Res Function(_Triggers) _then) = __$TriggersCopyWithImpl;
@override @useResult
$Res call({
 String id, String replayFileId, TriggerType triggerType, String eventId, String createdAt
});




}
/// @nodoc
class __$TriggersCopyWithImpl<$Res>
    implements _$TriggersCopyWith<$Res> {
  __$TriggersCopyWithImpl(this._self, this._then);

  final _Triggers _self;
  final $Res Function(_Triggers) _then;

/// Create a copy of Triggers
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? replayFileId = null,Object? triggerType = null,Object? eventId = null,Object? createdAt = null,}) {
  return _then(_Triggers(
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
