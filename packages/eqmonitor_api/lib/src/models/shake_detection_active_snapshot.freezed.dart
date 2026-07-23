// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_active_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionActiveSnapshot {

/// const: "shake_detection"
 String get type; int get revision; DateTime get responseAt; List<ShakeDetectionActiveEvent> get events;
/// Create a copy of ShakeDetectionActiveSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionActiveSnapshotCopyWith<ShakeDetectionActiveSnapshot> get copyWith => _$ShakeDetectionActiveSnapshotCopyWithImpl<ShakeDetectionActiveSnapshot>(this as ShakeDetectionActiveSnapshot, _$identity);

  /// Serializes this ShakeDetectionActiveSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionActiveSnapshot&&(identical(other.type, type) || other.type == type)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.responseAt, responseAt) || other.responseAt == responseAt)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,revision,responseAt,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'ShakeDetectionActiveSnapshot(type: $type, revision: $revision, responseAt: $responseAt, events: $events)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionActiveSnapshotCopyWith<$Res>  {
  factory $ShakeDetectionActiveSnapshotCopyWith(ShakeDetectionActiveSnapshot value, $Res Function(ShakeDetectionActiveSnapshot) _then) = _$ShakeDetectionActiveSnapshotCopyWithImpl;
@useResult
$Res call({
 String type, int revision, DateTime responseAt, List<ShakeDetectionActiveEvent> events
});




}
/// @nodoc
class _$ShakeDetectionActiveSnapshotCopyWithImpl<$Res>
    implements $ShakeDetectionActiveSnapshotCopyWith<$Res> {
  _$ShakeDetectionActiveSnapshotCopyWithImpl(this._self, this._then);

  final ShakeDetectionActiveSnapshot _self;
  final $Res Function(ShakeDetectionActiveSnapshot) _then;

/// Create a copy of ShakeDetectionActiveSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? revision = null,Object? responseAt = null,Object? events = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,responseAt: null == responseAt ? _self.responseAt : responseAt // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionActiveEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionActiveSnapshot].
extension ShakeDetectionActiveSnapshotPatterns on ShakeDetectionActiveSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionActiveSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionActiveSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionActiveSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionActiveSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionActiveSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionActiveSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int revision,  DateTime responseAt,  List<ShakeDetectionActiveEvent> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionActiveSnapshot() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int revision,  DateTime responseAt,  List<ShakeDetectionActiveEvent> events)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionActiveSnapshot():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int revision,  DateTime responseAt,  List<ShakeDetectionActiveEvent> events)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionActiveSnapshot() when $default != null:
return $default(_that.type,_that.revision,_that.responseAt,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShakeDetectionActiveSnapshot implements ShakeDetectionActiveSnapshot {
  const _ShakeDetectionActiveSnapshot({required this.type, required this.revision, required this.responseAt, required final  List<ShakeDetectionActiveEvent> events}): _events = events;
  factory _ShakeDetectionActiveSnapshot.fromJson(Map<String, dynamic> json) => _$ShakeDetectionActiveSnapshotFromJson(json);

/// const: "shake_detection"
@override final  String type;
@override final  int revision;
@override final  DateTime responseAt;
 final  List<ShakeDetectionActiveEvent> _events;
@override List<ShakeDetectionActiveEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of ShakeDetectionActiveSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionActiveSnapshotCopyWith<_ShakeDetectionActiveSnapshot> get copyWith => __$ShakeDetectionActiveSnapshotCopyWithImpl<_ShakeDetectionActiveSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionActiveSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionActiveSnapshot&&(identical(other.type, type) || other.type == type)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.responseAt, responseAt) || other.responseAt == responseAt)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,revision,responseAt,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'ShakeDetectionActiveSnapshot(type: $type, revision: $revision, responseAt: $responseAt, events: $events)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionActiveSnapshotCopyWith<$Res> implements $ShakeDetectionActiveSnapshotCopyWith<$Res> {
  factory _$ShakeDetectionActiveSnapshotCopyWith(_ShakeDetectionActiveSnapshot value, $Res Function(_ShakeDetectionActiveSnapshot) _then) = __$ShakeDetectionActiveSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String type, int revision, DateTime responseAt, List<ShakeDetectionActiveEvent> events
});




}
/// @nodoc
class __$ShakeDetectionActiveSnapshotCopyWithImpl<$Res>
    implements _$ShakeDetectionActiveSnapshotCopyWith<$Res> {
  __$ShakeDetectionActiveSnapshotCopyWithImpl(this._self, this._then);

  final _ShakeDetectionActiveSnapshot _self;
  final $Res Function(_ShakeDetectionActiveSnapshot) _then;

/// Create a copy of ShakeDetectionActiveSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? revision = null,Object? responseAt = null,Object? events = null,}) {
  return _then(_ShakeDetectionActiveSnapshot(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,responseAt: null == responseAt ? _self.responseAt : responseAt // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionActiveEvent>,
  ));
}


}

// dart format on
