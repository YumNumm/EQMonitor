// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_v2_admin_test_live_event_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostV2AdminTestLiveEventResponse {

/// const: true
 bool get ok;
/// Create a copy of PostV2AdminTestLiveEventResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostV2AdminTestLiveEventResponseCopyWith<PostV2AdminTestLiveEventResponse> get copyWith => _$PostV2AdminTestLiveEventResponseCopyWithImpl<PostV2AdminTestLiveEventResponse>(this as PostV2AdminTestLiveEventResponse, _$identity);

  /// Serializes this PostV2AdminTestLiveEventResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostV2AdminTestLiveEventResponse&&(identical(other.ok, ok) || other.ok == ok));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ok);

@override
String toString() {
  return 'PostV2AdminTestLiveEventResponse(ok: $ok)';
}


}

/// @nodoc
abstract mixin class $PostV2AdminTestLiveEventResponseCopyWith<$Res>  {
  factory $PostV2AdminTestLiveEventResponseCopyWith(PostV2AdminTestLiveEventResponse value, $Res Function(PostV2AdminTestLiveEventResponse) _then) = _$PostV2AdminTestLiveEventResponseCopyWithImpl;
@useResult
$Res call({
 bool ok
});




}
/// @nodoc
class _$PostV2AdminTestLiveEventResponseCopyWithImpl<$Res>
    implements $PostV2AdminTestLiveEventResponseCopyWith<$Res> {
  _$PostV2AdminTestLiveEventResponseCopyWithImpl(this._self, this._then);

  final PostV2AdminTestLiveEventResponse _self;
  final $Res Function(PostV2AdminTestLiveEventResponse) _then;

/// Create a copy of PostV2AdminTestLiveEventResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ok = null,}) {
  return _then(_self.copyWith(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostV2AdminTestLiveEventResponse].
extension PostV2AdminTestLiveEventResponsePatterns on PostV2AdminTestLiveEventResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostV2AdminTestLiveEventResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostV2AdminTestLiveEventResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostV2AdminTestLiveEventResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostV2AdminTestLiveEventResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostV2AdminTestLiveEventResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostV2AdminTestLiveEventResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool ok)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostV2AdminTestLiveEventResponse() when $default != null:
return $default(_that.ok);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool ok)  $default,) {final _that = this;
switch (_that) {
case _PostV2AdminTestLiveEventResponse():
return $default(_that.ok);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool ok)?  $default,) {final _that = this;
switch (_that) {
case _PostV2AdminTestLiveEventResponse() when $default != null:
return $default(_that.ok);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostV2AdminTestLiveEventResponse implements PostV2AdminTestLiveEventResponse {
  const _PostV2AdminTestLiveEventResponse({required this.ok});
  factory _PostV2AdminTestLiveEventResponse.fromJson(Map<String, dynamic> json) => _$PostV2AdminTestLiveEventResponseFromJson(json);

/// const: true
@override final  bool ok;

/// Create a copy of PostV2AdminTestLiveEventResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostV2AdminTestLiveEventResponseCopyWith<_PostV2AdminTestLiveEventResponse> get copyWith => __$PostV2AdminTestLiveEventResponseCopyWithImpl<_PostV2AdminTestLiveEventResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostV2AdminTestLiveEventResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostV2AdminTestLiveEventResponse&&(identical(other.ok, ok) || other.ok == ok));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ok);

@override
String toString() {
  return 'PostV2AdminTestLiveEventResponse(ok: $ok)';
}


}

/// @nodoc
abstract mixin class _$PostV2AdminTestLiveEventResponseCopyWith<$Res> implements $PostV2AdminTestLiveEventResponseCopyWith<$Res> {
  factory _$PostV2AdminTestLiveEventResponseCopyWith(_PostV2AdminTestLiveEventResponse value, $Res Function(_PostV2AdminTestLiveEventResponse) _then) = __$PostV2AdminTestLiveEventResponseCopyWithImpl;
@override @useResult
$Res call({
 bool ok
});




}
/// @nodoc
class __$PostV2AdminTestLiveEventResponseCopyWithImpl<$Res>
    implements _$PostV2AdminTestLiveEventResponseCopyWith<$Res> {
  __$PostV2AdminTestLiveEventResponseCopyWithImpl(this._self, this._then);

  final _PostV2AdminTestLiveEventResponse _self;
  final $Res Function(_PostV2AdminTestLiveEventResponse) _then;

/// Create a copy of PostV2AdminTestLiveEventResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ok = null,}) {
  return _then(_PostV2AdminTestLiveEventResponse(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
