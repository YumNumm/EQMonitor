// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_live_activity_end_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestLiveActivityEndRequest {

@JsonKey(includeIfNull: false, name: 'content_state') LiveActivityContentState? get contentState;
/// Create a copy of TestLiveActivityEndRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestLiveActivityEndRequestCopyWith<TestLiveActivityEndRequest> get copyWith => _$TestLiveActivityEndRequestCopyWithImpl<TestLiveActivityEndRequest>(this as TestLiveActivityEndRequest, _$identity);

  /// Serializes this TestLiveActivityEndRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestLiveActivityEndRequest&&const DeepCollectionEquality().equals(other.contentState, contentState));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(contentState));

@override
String toString() {
  return 'TestLiveActivityEndRequest(contentState: $contentState)';
}


}

/// @nodoc
abstract mixin class $TestLiveActivityEndRequestCopyWith<$Res>  {
  factory $TestLiveActivityEndRequestCopyWith(TestLiveActivityEndRequest value, $Res Function(TestLiveActivityEndRequest) _then) = _$TestLiveActivityEndRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'content_state') LiveActivityContentState? contentState
});




}
/// @nodoc
class _$TestLiveActivityEndRequestCopyWithImpl<$Res>
    implements $TestLiveActivityEndRequestCopyWith<$Res> {
  _$TestLiveActivityEndRequestCopyWithImpl(this._self, this._then);

  final TestLiveActivityEndRequest _self;
  final $Res Function(TestLiveActivityEndRequest) _then;

/// Create a copy of TestLiveActivityEndRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentState = freezed,}) {
  return _then(_self.copyWith(
contentState: freezed == contentState ? _self.contentState : contentState // ignore: cast_nullable_to_non_nullable
as LiveActivityContentState?,
  ));
}

}


/// Adds pattern-matching-related methods to [TestLiveActivityEndRequest].
extension TestLiveActivityEndRequestPatterns on TestLiveActivityEndRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestLiveActivityEndRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestLiveActivityEndRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestLiveActivityEndRequest value)  $default,){
final _that = this;
switch (_that) {
case _TestLiveActivityEndRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestLiveActivityEndRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TestLiveActivityEndRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'content_state')  LiveActivityContentState? contentState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestLiveActivityEndRequest() when $default != null:
return $default(_that.contentState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'content_state')  LiveActivityContentState? contentState)  $default,) {final _that = this;
switch (_that) {
case _TestLiveActivityEndRequest():
return $default(_that.contentState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'content_state')  LiveActivityContentState? contentState)?  $default,) {final _that = this;
switch (_that) {
case _TestLiveActivityEndRequest() when $default != null:
return $default(_that.contentState);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestLiveActivityEndRequest implements TestLiveActivityEndRequest {
  const _TestLiveActivityEndRequest({@JsonKey(includeIfNull: false, name: 'content_state') final  LiveActivityContentState? contentState}): _contentState = contentState;
  factory _TestLiveActivityEndRequest.fromJson(Map<String, dynamic> json) => _$TestLiveActivityEndRequestFromJson(json);

 final  LiveActivityContentState? _contentState;
@override@JsonKey(includeIfNull: false, name: 'content_state') LiveActivityContentState? get contentState {
  final value = _contentState;
  if (value == null) return null;
  if (_contentState is EqualUnmodifiableMapView) return _contentState;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of TestLiveActivityEndRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestLiveActivityEndRequestCopyWith<_TestLiveActivityEndRequest> get copyWith => __$TestLiveActivityEndRequestCopyWithImpl<_TestLiveActivityEndRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestLiveActivityEndRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestLiveActivityEndRequest&&const DeepCollectionEquality().equals(other._contentState, _contentState));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_contentState));

@override
String toString() {
  return 'TestLiveActivityEndRequest(contentState: $contentState)';
}


}

/// @nodoc
abstract mixin class _$TestLiveActivityEndRequestCopyWith<$Res> implements $TestLiveActivityEndRequestCopyWith<$Res> {
  factory _$TestLiveActivityEndRequestCopyWith(_TestLiveActivityEndRequest value, $Res Function(_TestLiveActivityEndRequest) _then) = __$TestLiveActivityEndRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'content_state') LiveActivityContentState? contentState
});




}
/// @nodoc
class __$TestLiveActivityEndRequestCopyWithImpl<$Res>
    implements _$TestLiveActivityEndRequestCopyWith<$Res> {
  __$TestLiveActivityEndRequestCopyWithImpl(this._self, this._then);

  final _TestLiveActivityEndRequest _self;
  final $Res Function(_TestLiveActivityEndRequest) _then;

/// Create a copy of TestLiveActivityEndRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentState = freezed,}) {
  return _then(_TestLiveActivityEndRequest(
contentState: freezed == contentState ? _self._contentState : contentState // ignore: cast_nullable_to_non_nullable
as LiveActivityContentState?,
  ));
}


}

// dart format on
