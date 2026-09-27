// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'v2_admin_test_live_event_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$V2AdminTestLiveEventRequestBody {

 EventType get eventType; TargetUnion get target;
/// Create a copy of V2AdminTestLiveEventRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$V2AdminTestLiveEventRequestBodyCopyWith<V2AdminTestLiveEventRequestBody> get copyWith => _$V2AdminTestLiveEventRequestBodyCopyWithImpl<V2AdminTestLiveEventRequestBody>(this as V2AdminTestLiveEventRequestBody, _$identity);

  /// Serializes this V2AdminTestLiveEventRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is V2AdminTestLiveEventRequestBody&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventType,target);

@override
String toString() {
  return 'V2AdminTestLiveEventRequestBody(eventType: $eventType, target: $target)';
}


}

/// @nodoc
abstract mixin class $V2AdminTestLiveEventRequestBodyCopyWith<$Res>  {
  factory $V2AdminTestLiveEventRequestBodyCopyWith(V2AdminTestLiveEventRequestBody value, $Res Function(V2AdminTestLiveEventRequestBody) _then) = _$V2AdminTestLiveEventRequestBodyCopyWithImpl;
@useResult
$Res call({
 EventType eventType, TargetUnion target
});


$TargetUnionCopyWith<$Res> get target;

}
/// @nodoc
class _$V2AdminTestLiveEventRequestBodyCopyWithImpl<$Res>
    implements $V2AdminTestLiveEventRequestBodyCopyWith<$Res> {
  _$V2AdminTestLiveEventRequestBodyCopyWithImpl(this._self, this._then);

  final V2AdminTestLiveEventRequestBody _self;
  final $Res Function(V2AdminTestLiveEventRequestBody) _then;

/// Create a copy of V2AdminTestLiveEventRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventType = null,Object? target = null,}) {
  return _then(V2AdminTestLiveEventRequestBody(
eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventType,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as TargetUnion,
  ));
}
/// Create a copy of V2AdminTestLiveEventRequestBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetUnionCopyWith<$Res> get target {
  
  return $TargetUnionCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}


/// Adds pattern-matching-related methods to [V2AdminTestLiveEventRequestBody].
extension V2AdminTestLiveEventRequestBodyPatterns on V2AdminTestLiveEventRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _V2AdminTestLiveEventRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _V2AdminTestLiveEventRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _V2AdminTestLiveEventRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _V2AdminTestLiveEventRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _V2AdminTestLiveEventRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _V2AdminTestLiveEventRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EventType eventType,  TargetUnion target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _V2AdminTestLiveEventRequestBody() when $default != null:
return $default(_that.eventType,_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EventType eventType,  TargetUnion target)  $default,) {final _that = this;
switch (_that) {
case _V2AdminTestLiveEventRequestBody():
return $default(_that.eventType,_that.target);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EventType eventType,  TargetUnion target)?  $default,) {final _that = this;
switch (_that) {
case _V2AdminTestLiveEventRequestBody() when $default != null:
return $default(_that.eventType,_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _V2AdminTestLiveEventRequestBody implements V2AdminTestLiveEventRequestBody {
  const _V2AdminTestLiveEventRequestBody({required this.eventType, required this.target});
  factory _V2AdminTestLiveEventRequestBody.fromJson(Map<String, dynamic> json) => _$V2AdminTestLiveEventRequestBodyFromJson(json);

@override final  EventType eventType;
@override final  TargetUnion target;

/// Create a copy of V2AdminTestLiveEventRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$V2AdminTestLiveEventRequestBodyCopyWith<_V2AdminTestLiveEventRequestBody> get copyWith => __$V2AdminTestLiveEventRequestBodyCopyWithImpl<_V2AdminTestLiveEventRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$V2AdminTestLiveEventRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _V2AdminTestLiveEventRequestBody&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventType,target);

@override
String toString() {
  return 'V2AdminTestLiveEventRequestBody(eventType: $eventType, target: $target)';
}


}

/// @nodoc
abstract mixin class _$V2AdminTestLiveEventRequestBodyCopyWith<$Res> implements $V2AdminTestLiveEventRequestBodyCopyWith<$Res> {
  factory _$V2AdminTestLiveEventRequestBodyCopyWith(_V2AdminTestLiveEventRequestBody value, $Res Function(_V2AdminTestLiveEventRequestBody) _then) = __$V2AdminTestLiveEventRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 EventType eventType, TargetUnion target
});


@override $TargetUnionCopyWith<$Res> get target;

}
/// @nodoc
class __$V2AdminTestLiveEventRequestBodyCopyWithImpl<$Res>
    implements _$V2AdminTestLiveEventRequestBodyCopyWith<$Res> {
  __$V2AdminTestLiveEventRequestBodyCopyWithImpl(this._self, this._then);

  final _V2AdminTestLiveEventRequestBody _self;
  final $Res Function(_V2AdminTestLiveEventRequestBody) _then;

/// Create a copy of V2AdminTestLiveEventRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventType = null,Object? target = null,}) {
  return _then(_V2AdminTestLiveEventRequestBody(
eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventType,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as TargetUnion,
  ));
}

/// Create a copy of V2AdminTestLiveEventRequestBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetUnionCopyWith<$Res> get target {
  
  return $TargetUnionCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}

// dart format on
