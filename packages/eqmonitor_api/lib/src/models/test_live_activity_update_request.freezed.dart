// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_live_activity_update_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestLiveActivityUpdateRequest {

@JsonKey(name: 'content_state') LiveActivityContentState get contentState;
/// Create a copy of TestLiveActivityUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestLiveActivityUpdateRequestCopyWith<TestLiveActivityUpdateRequest> get copyWith => _$TestLiveActivityUpdateRequestCopyWithImpl<TestLiveActivityUpdateRequest>(this as TestLiveActivityUpdateRequest, _$identity);

  /// Serializes this TestLiveActivityUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestLiveActivityUpdateRequest&&const DeepCollectionEquality().equals(other.contentState, contentState));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(contentState));

@override
String toString() {
  return 'TestLiveActivityUpdateRequest(contentState: $contentState)';
}


}

/// @nodoc
abstract mixin class $TestLiveActivityUpdateRequestCopyWith<$Res>  {
  factory $TestLiveActivityUpdateRequestCopyWith(TestLiveActivityUpdateRequest value, $Res Function(TestLiveActivityUpdateRequest) _then) = _$TestLiveActivityUpdateRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'content_state') LiveActivityContentState contentState
});




}
/// @nodoc
class _$TestLiveActivityUpdateRequestCopyWithImpl<$Res>
    implements $TestLiveActivityUpdateRequestCopyWith<$Res> {
  _$TestLiveActivityUpdateRequestCopyWithImpl(this._self, this._then);

  final TestLiveActivityUpdateRequest _self;
  final $Res Function(TestLiveActivityUpdateRequest) _then;

/// Create a copy of TestLiveActivityUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentState = null,}) {
  return _then(_self.copyWith(
contentState: null == contentState ? _self.contentState : contentState // ignore: cast_nullable_to_non_nullable
as LiveActivityContentState,
  ));
}

}


/// Adds pattern-matching-related methods to [TestLiveActivityUpdateRequest].
extension TestLiveActivityUpdateRequestPatterns on TestLiveActivityUpdateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestLiveActivityUpdateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestLiveActivityUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestLiveActivityUpdateRequest value)  $default,){
final _that = this;
switch (_that) {
case _TestLiveActivityUpdateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestLiveActivityUpdateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TestLiveActivityUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'content_state')  LiveActivityContentState contentState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestLiveActivityUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'content_state')  LiveActivityContentState contentState)  $default,) {final _that = this;
switch (_that) {
case _TestLiveActivityUpdateRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'content_state')  LiveActivityContentState contentState)?  $default,) {final _that = this;
switch (_that) {
case _TestLiveActivityUpdateRequest() when $default != null:
return $default(_that.contentState);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestLiveActivityUpdateRequest implements TestLiveActivityUpdateRequest {
  const _TestLiveActivityUpdateRequest({@JsonKey(name: 'content_state') required final  LiveActivityContentState contentState}): _contentState = contentState;
  factory _TestLiveActivityUpdateRequest.fromJson(Map<String, dynamic> json) => _$TestLiveActivityUpdateRequestFromJson(json);

 final  LiveActivityContentState _contentState;
@override@JsonKey(name: 'content_state') LiveActivityContentState get contentState {
  if (_contentState is EqualUnmodifiableMapView) return _contentState;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_contentState);
}


/// Create a copy of TestLiveActivityUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestLiveActivityUpdateRequestCopyWith<_TestLiveActivityUpdateRequest> get copyWith => __$TestLiveActivityUpdateRequestCopyWithImpl<_TestLiveActivityUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestLiveActivityUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestLiveActivityUpdateRequest&&const DeepCollectionEquality().equals(other._contentState, _contentState));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_contentState));

@override
String toString() {
  return 'TestLiveActivityUpdateRequest(contentState: $contentState)';
}


}

/// @nodoc
abstract mixin class _$TestLiveActivityUpdateRequestCopyWith<$Res> implements $TestLiveActivityUpdateRequestCopyWith<$Res> {
  factory _$TestLiveActivityUpdateRequestCopyWith(_TestLiveActivityUpdateRequest value, $Res Function(_TestLiveActivityUpdateRequest) _then) = __$TestLiveActivityUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'content_state') LiveActivityContentState contentState
});




}
/// @nodoc
class __$TestLiveActivityUpdateRequestCopyWithImpl<$Res>
    implements _$TestLiveActivityUpdateRequestCopyWith<$Res> {
  __$TestLiveActivityUpdateRequestCopyWithImpl(this._self, this._then);

  final _TestLiveActivityUpdateRequest _self;
  final $Res Function(_TestLiveActivityUpdateRequest) _then;

/// Create a copy of TestLiveActivityUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentState = null,}) {
  return _then(_TestLiveActivityUpdateRequest(
contentState: null == contentState ? _self._contentState : contentState // ignore: cast_nullable_to_non_nullable
as LiveActivityContentState,
  ));
}


}

// dart format on
