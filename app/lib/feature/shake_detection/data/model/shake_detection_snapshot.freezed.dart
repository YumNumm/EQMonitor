// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShakeDetectionSnapshot {

 int get revision; DateTime get responseAt; List<ShakeDetectionEvent> get events; RealtimeShakeDetectionSnapshotPayload? get sourceRecord;
/// Create a copy of ShakeDetectionSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionSnapshotCopyWith<ShakeDetectionSnapshot> get copyWith => _$ShakeDetectionSnapshotCopyWithImpl<ShakeDetectionSnapshot>(this as ShakeDetectionSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionSnapshot&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.responseAt, responseAt) || other.responseAt == responseAt)&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.sourceRecord, sourceRecord) || other.sourceRecord == sourceRecord));
}


@override
int get hashCode => Object.hash(runtimeType,revision,responseAt,const DeepCollectionEquality().hash(events),sourceRecord);

@override
String toString() {
  return 'ShakeDetectionSnapshot(revision: $revision, responseAt: $responseAt, events: $events, sourceRecord: $sourceRecord)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionSnapshotCopyWith<$Res>  {
  factory $ShakeDetectionSnapshotCopyWith(ShakeDetectionSnapshot value, $Res Function(ShakeDetectionSnapshot) _then) = _$ShakeDetectionSnapshotCopyWithImpl;
@useResult
$Res call({
 int revision, DateTime responseAt, List<ShakeDetectionEvent> events, RealtimeShakeDetectionSnapshotPayload? sourceRecord
});


$RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res>? get sourceRecord;

}
/// @nodoc
class _$ShakeDetectionSnapshotCopyWithImpl<$Res>
    implements $ShakeDetectionSnapshotCopyWith<$Res> {
  _$ShakeDetectionSnapshotCopyWithImpl(this._self, this._then);

  final ShakeDetectionSnapshot _self;
  final $Res Function(ShakeDetectionSnapshot) _then;

/// Create a copy of ShakeDetectionSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? revision = null,Object? responseAt = null,Object? events = null,Object? sourceRecord = freezed,}) {
  return _then(_self.copyWith(
revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,responseAt: null == responseAt ? _self.responseAt : responseAt // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionEvent>,sourceRecord: freezed == sourceRecord ? _self.sourceRecord : sourceRecord // ignore: cast_nullable_to_non_nullable
as RealtimeShakeDetectionSnapshotPayload?,
  ));
}
/// Create a copy of ShakeDetectionSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res>? get sourceRecord {
    if (_self.sourceRecord == null) {
    return null;
  }

  return $RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res>(_self.sourceRecord!, (value) {
    return _then(_self.copyWith(sourceRecord: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShakeDetectionSnapshot].
extension ShakeDetectionSnapshotPatterns on ShakeDetectionSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int revision,  DateTime responseAt,  List<ShakeDetectionEvent> events,  RealtimeShakeDetectionSnapshotPayload? sourceRecord)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionSnapshot() when $default != null:
return $default(_that.revision,_that.responseAt,_that.events,_that.sourceRecord);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int revision,  DateTime responseAt,  List<ShakeDetectionEvent> events,  RealtimeShakeDetectionSnapshotPayload? sourceRecord)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSnapshot():
return $default(_that.revision,_that.responseAt,_that.events,_that.sourceRecord);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int revision,  DateTime responseAt,  List<ShakeDetectionEvent> events,  RealtimeShakeDetectionSnapshotPayload? sourceRecord)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSnapshot() when $default != null:
return $default(_that.revision,_that.responseAt,_that.events,_that.sourceRecord);case _:
  return null;

}
}

}

/// @nodoc


class _ShakeDetectionSnapshot implements ShakeDetectionSnapshot {
  const _ShakeDetectionSnapshot({required this.revision, required this.responseAt, required final  List<ShakeDetectionEvent> events, this.sourceRecord}): _events = events;
  

@override final  int revision;
@override final  DateTime responseAt;
 final  List<ShakeDetectionEvent> _events;
@override List<ShakeDetectionEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override final  RealtimeShakeDetectionSnapshotPayload? sourceRecord;

/// Create a copy of ShakeDetectionSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionSnapshotCopyWith<_ShakeDetectionSnapshot> get copyWith => __$ShakeDetectionSnapshotCopyWithImpl<_ShakeDetectionSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionSnapshot&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.responseAt, responseAt) || other.responseAt == responseAt)&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.sourceRecord, sourceRecord) || other.sourceRecord == sourceRecord));
}


@override
int get hashCode => Object.hash(runtimeType,revision,responseAt,const DeepCollectionEquality().hash(_events),sourceRecord);

@override
String toString() {
  return 'ShakeDetectionSnapshot(revision: $revision, responseAt: $responseAt, events: $events, sourceRecord: $sourceRecord)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionSnapshotCopyWith<$Res> implements $ShakeDetectionSnapshotCopyWith<$Res> {
  factory _$ShakeDetectionSnapshotCopyWith(_ShakeDetectionSnapshot value, $Res Function(_ShakeDetectionSnapshot) _then) = __$ShakeDetectionSnapshotCopyWithImpl;
@override @useResult
$Res call({
 int revision, DateTime responseAt, List<ShakeDetectionEvent> events, RealtimeShakeDetectionSnapshotPayload? sourceRecord
});


@override $RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res>? get sourceRecord;

}
/// @nodoc
class __$ShakeDetectionSnapshotCopyWithImpl<$Res>
    implements _$ShakeDetectionSnapshotCopyWith<$Res> {
  __$ShakeDetectionSnapshotCopyWithImpl(this._self, this._then);

  final _ShakeDetectionSnapshot _self;
  final $Res Function(_ShakeDetectionSnapshot) _then;

/// Create a copy of ShakeDetectionSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? revision = null,Object? responseAt = null,Object? events = null,Object? sourceRecord = freezed,}) {
  return _then(_ShakeDetectionSnapshot(
revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,responseAt: null == responseAt ? _self.responseAt : responseAt // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionEvent>,sourceRecord: freezed == sourceRecord ? _self.sourceRecord : sourceRecord // ignore: cast_nullable_to_non_nullable
as RealtimeShakeDetectionSnapshotPayload?,
  ));
}

/// Create a copy of ShakeDetectionSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res>? get sourceRecord {
    if (_self.sourceRecord == null) {
    return null;
  }

  return $RealtimeShakeDetectionSnapshotPayloadCopyWith<$Res>(_self.sourceRecord!, (value) {
    return _then(_self.copyWith(sourceRecord: value));
  });
}
}

// dart format on
