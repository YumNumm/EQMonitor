// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimated_intensity_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EstimatedIntensityEvent {

 String get eventId; String get estimatedIntensityKey; String get createdAt;@JsonKey(includeIfNull: false) EstimatedIntensityHypocenter? get hypocenter;
/// Create a copy of EstimatedIntensityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimatedIntensityEventCopyWith<EstimatedIntensityEvent> get copyWith => _$EstimatedIntensityEventCopyWithImpl<EstimatedIntensityEvent>(this as EstimatedIntensityEvent, _$identity);

  /// Serializes this EstimatedIntensityEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimatedIntensityEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.estimatedIntensityKey, estimatedIntensityKey) || other.estimatedIntensityKey == estimatedIntensityKey)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,estimatedIntensityKey,createdAt,hypocenter);

@override
String toString() {
  return 'EstimatedIntensityEvent(eventId: $eventId, estimatedIntensityKey: $estimatedIntensityKey, createdAt: $createdAt, hypocenter: $hypocenter)';
}


}

/// @nodoc
abstract mixin class $EstimatedIntensityEventCopyWith<$Res>  {
  factory $EstimatedIntensityEventCopyWith(EstimatedIntensityEvent value, $Res Function(EstimatedIntensityEvent) _then) = _$EstimatedIntensityEventCopyWithImpl;
@useResult
$Res call({
 String eventId, String estimatedIntensityKey, String createdAt,@JsonKey(includeIfNull: false) EstimatedIntensityHypocenter? hypocenter
});


$EstimatedIntensityHypocenterCopyWith<$Res>? get hypocenter;

}
/// @nodoc
class _$EstimatedIntensityEventCopyWithImpl<$Res>
    implements $EstimatedIntensityEventCopyWith<$Res> {
  _$EstimatedIntensityEventCopyWithImpl(this._self, this._then);

  final EstimatedIntensityEvent _self;
  final $Res Function(EstimatedIntensityEvent) _then;

/// Create a copy of EstimatedIntensityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? estimatedIntensityKey = null,Object? createdAt = null,Object? hypocenter = freezed,}) {
  return _then(EstimatedIntensityEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,estimatedIntensityKey: null == estimatedIntensityKey ? _self.estimatedIntensityKey : estimatedIntensityKey // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EstimatedIntensityHypocenter?,
  ));
}
/// Create a copy of EstimatedIntensityEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstimatedIntensityHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $EstimatedIntensityHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}


/// Adds pattern-matching-related methods to [EstimatedIntensityEvent].
extension EstimatedIntensityEventPatterns on EstimatedIntensityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimatedIntensityEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimatedIntensityEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimatedIntensityEvent value)  $default,){
final _that = this;
switch (_that) {
case _EstimatedIntensityEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimatedIntensityEvent value)?  $default,){
final _that = this;
switch (_that) {
case _EstimatedIntensityEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String estimatedIntensityKey,  String createdAt, @JsonKey(includeIfNull: false)  EstimatedIntensityHypocenter? hypocenter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimatedIntensityEvent() when $default != null:
return $default(_that.eventId,_that.estimatedIntensityKey,_that.createdAt,_that.hypocenter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String estimatedIntensityKey,  String createdAt, @JsonKey(includeIfNull: false)  EstimatedIntensityHypocenter? hypocenter)  $default,) {final _that = this;
switch (_that) {
case _EstimatedIntensityEvent():
return $default(_that.eventId,_that.estimatedIntensityKey,_that.createdAt,_that.hypocenter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String estimatedIntensityKey,  String createdAt, @JsonKey(includeIfNull: false)  EstimatedIntensityHypocenter? hypocenter)?  $default,) {final _that = this;
switch (_that) {
case _EstimatedIntensityEvent() when $default != null:
return $default(_that.eventId,_that.estimatedIntensityKey,_that.createdAt,_that.hypocenter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstimatedIntensityEvent implements EstimatedIntensityEvent {
  const _EstimatedIntensityEvent({required this.eventId, required this.estimatedIntensityKey, required this.createdAt, @JsonKey(includeIfNull: false) this.hypocenter});
  factory _EstimatedIntensityEvent.fromJson(Map<String, dynamic> json) => _$EstimatedIntensityEventFromJson(json);

@override final  String eventId;
@override final  String estimatedIntensityKey;
@override final  String createdAt;
@override@JsonKey(includeIfNull: false) final  EstimatedIntensityHypocenter? hypocenter;

/// Create a copy of EstimatedIntensityEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimatedIntensityEventCopyWith<_EstimatedIntensityEvent> get copyWith => __$EstimatedIntensityEventCopyWithImpl<_EstimatedIntensityEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimatedIntensityEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimatedIntensityEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.estimatedIntensityKey, estimatedIntensityKey) || other.estimatedIntensityKey == estimatedIntensityKey)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,estimatedIntensityKey,createdAt,hypocenter);

@override
String toString() {
  return 'EstimatedIntensityEvent(eventId: $eventId, estimatedIntensityKey: $estimatedIntensityKey, createdAt: $createdAt, hypocenter: $hypocenter)';
}


}

/// @nodoc
abstract mixin class _$EstimatedIntensityEventCopyWith<$Res> implements $EstimatedIntensityEventCopyWith<$Res> {
  factory _$EstimatedIntensityEventCopyWith(_EstimatedIntensityEvent value, $Res Function(_EstimatedIntensityEvent) _then) = __$EstimatedIntensityEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String estimatedIntensityKey, String createdAt,@JsonKey(includeIfNull: false) EstimatedIntensityHypocenter? hypocenter
});


@override $EstimatedIntensityHypocenterCopyWith<$Res>? get hypocenter;

}
/// @nodoc
class __$EstimatedIntensityEventCopyWithImpl<$Res>
    implements _$EstimatedIntensityEventCopyWith<$Res> {
  __$EstimatedIntensityEventCopyWithImpl(this._self, this._then);

  final _EstimatedIntensityEvent _self;
  final $Res Function(_EstimatedIntensityEvent) _then;

/// Create a copy of EstimatedIntensityEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? estimatedIntensityKey = null,Object? createdAt = null,Object? hypocenter = freezed,}) {
  return _then(_EstimatedIntensityEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,estimatedIntensityKey: null == estimatedIntensityKey ? _self.estimatedIntensityKey : estimatedIntensityKey // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EstimatedIntensityHypocenter?,
  ));
}

/// Create a copy of EstimatedIntensityEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstimatedIntensityHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $EstimatedIntensityHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}

// dart format on
