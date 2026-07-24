// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_shake_detection_snapshot_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeShakeDetectionSnapshotPayload {

 Type3 get type; int get revision; DateTime get responseAt; List<Events2> get events;
/// Create a copy of RealtimeShakeDetectionSnapshotPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeShakeDetectionSnapshotPayloadCopyWith<RealtimeShakeDetectionSnapshotPayload> get copyWith => _$RealtimeShakeDetectionSnapshotPayloadCopyWithImpl<RealtimeShakeDetectionSnapshotPayload>(this as RealtimeShakeDetectionSnapshotPayload, _$identity);

  /// Serializes this RealtimeShakeDetectionSnapshotPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeShakeDetectionSnapshotPayload&&(identical(other.type, type) || other.type == type)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.responseAt, responseAt) || other.responseAt == responseAt)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,revision,responseAt,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'RealtimeShakeDetectionSnapshotPayload(type: $type, revision: $revision, responseAt: $responseAt, events: $events)';
}


}

/// @nodoc
abstract mixin class $RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res>  {
  factory $RealtimeShakeDetectionSnapshotPayloadCopyWith(RealtimeShakeDetectionSnapshotPayload value, $Res Function(RealtimeShakeDetectionSnapshotPayload) _then) = _$RealtimeShakeDetectionSnapshotPayloadCopyWithImpl;
@useResult
$Res call({
 Type3 type, int revision, DateTime responseAt, List<Events2> events
});




}
/// @nodoc
class _$RealtimeShakeDetectionSnapshotPayloadCopyWithImpl<$Res>
    implements $RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res> {
  _$RealtimeShakeDetectionSnapshotPayloadCopyWithImpl(this._self, this._then);

  final RealtimeShakeDetectionSnapshotPayload _self;
  final $Res Function(RealtimeShakeDetectionSnapshotPayload) _then;

/// Create a copy of RealtimeShakeDetectionSnapshotPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? revision = null,Object? responseAt = null,Object? events = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as Type3,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,responseAt: null == responseAt ? _self.responseAt : responseAt // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<Events2>,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeShakeDetectionSnapshotPayload].
extension RealtimeShakeDetectionSnapshotPayloadPatterns on RealtimeShakeDetectionSnapshotPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeShakeDetectionSnapshotPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeShakeDetectionSnapshotPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeShakeDetectionSnapshotPayload value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeShakeDetectionSnapshotPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeShakeDetectionSnapshotPayload value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeShakeDetectionSnapshotPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Type3 type,  int revision,  DateTime responseAt,  List<Events2> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeShakeDetectionSnapshotPayload() when $default != null:
return $default(_that.type,_that.revision,_that.responseAt,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Type3 type,  int revision,  DateTime responseAt,  List<Events2> events)  $default,) {final _that = this;
switch (_that) {
case _RealtimeShakeDetectionSnapshotPayload():
return $default(_that.type,_that.revision,_that.responseAt,_that.events);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Type3 type,  int revision,  DateTime responseAt,  List<Events2> events)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeShakeDetectionSnapshotPayload() when $default != null:
return $default(_that.type,_that.revision,_that.responseAt,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeShakeDetectionSnapshotPayload implements RealtimeShakeDetectionSnapshotPayload {
  const _RealtimeShakeDetectionSnapshotPayload({required this.type, required this.revision, required this.responseAt, required final  List<Events2> events}): _events = events;
  factory _RealtimeShakeDetectionSnapshotPayload.fromJson(Map<String, dynamic> json) => _$RealtimeShakeDetectionSnapshotPayloadFromJson(json);

@override final  Type3 type;
@override final  int revision;
@override final  DateTime responseAt;
 final  List<Events2> _events;
@override List<Events2> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of RealtimeShakeDetectionSnapshotPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeShakeDetectionSnapshotPayloadCopyWith<_RealtimeShakeDetectionSnapshotPayload> get copyWith => __$RealtimeShakeDetectionSnapshotPayloadCopyWithImpl<_RealtimeShakeDetectionSnapshotPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeShakeDetectionSnapshotPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeShakeDetectionSnapshotPayload&&(identical(other.type, type) || other.type == type)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.responseAt, responseAt) || other.responseAt == responseAt)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,revision,responseAt,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'RealtimeShakeDetectionSnapshotPayload(type: $type, revision: $revision, responseAt: $responseAt, events: $events)';
}


}

/// @nodoc
abstract mixin class _$RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res> implements $RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res> {
  factory _$RealtimeShakeDetectionSnapshotPayloadCopyWith(_RealtimeShakeDetectionSnapshotPayload value, $Res Function(_RealtimeShakeDetectionSnapshotPayload) _then) = __$RealtimeShakeDetectionSnapshotPayloadCopyWithImpl;
@override @useResult
$Res call({
 Type3 type, int revision, DateTime responseAt, List<Events2> events
});




}
/// @nodoc
class __$RealtimeShakeDetectionSnapshotPayloadCopyWithImpl<$Res>
    implements _$RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res> {
  __$RealtimeShakeDetectionSnapshotPayloadCopyWithImpl(this._self, this._then);

  final _RealtimeShakeDetectionSnapshotPayload _self;
  final $Res Function(_RealtimeShakeDetectionSnapshotPayload) _then;

/// Create a copy of RealtimeShakeDetectionSnapshotPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? revision = null,Object? responseAt = null,Object? events = null,}) {
  return _then(_RealtimeShakeDetectionSnapshotPayload(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as Type3,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,responseAt: null == responseAt ? _self.responseAt : responseAt // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<Events2>,
  ));
}


}

// dart format on
