// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_update_session_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostUpdateSessionResponse {

 Session get session;
/// Create a copy of PostUpdateSessionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostUpdateSessionResponseCopyWith<PostUpdateSessionResponse> get copyWith => _$PostUpdateSessionResponseCopyWithImpl<PostUpdateSessionResponse>(this as PostUpdateSessionResponse, _$identity);

  /// Serializes this PostUpdateSessionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostUpdateSessionResponse&&(identical(other.session, session) || other.session == session));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'PostUpdateSessionResponse(session: $session)';
}


}

/// @nodoc
abstract mixin class $PostUpdateSessionResponseCopyWith<$Res>  {
  factory $PostUpdateSessionResponseCopyWith(PostUpdateSessionResponse value, $Res Function(PostUpdateSessionResponse) _then) = _$PostUpdateSessionResponseCopyWithImpl;
@useResult
$Res call({
 Session session
});


$SessionCopyWith<$Res> get session;

}
/// @nodoc
class _$PostUpdateSessionResponseCopyWithImpl<$Res>
    implements $PostUpdateSessionResponseCopyWith<$Res> {
  _$PostUpdateSessionResponseCopyWithImpl(this._self, this._then);

  final PostUpdateSessionResponse _self;
  final $Res Function(PostUpdateSessionResponse) _then;

/// Create a copy of PostUpdateSessionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,}) {
  return _then(_self.copyWith(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,
  ));
}
/// Create a copy of PostUpdateSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res> get session {
  
  return $SessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostUpdateSessionResponse].
extension PostUpdateSessionResponsePatterns on PostUpdateSessionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostUpdateSessionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostUpdateSessionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostUpdateSessionResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostUpdateSessionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostUpdateSessionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostUpdateSessionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Session session)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostUpdateSessionResponse() when $default != null:
return $default(_that.session);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Session session)  $default,) {final _that = this;
switch (_that) {
case _PostUpdateSessionResponse():
return $default(_that.session);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Session session)?  $default,) {final _that = this;
switch (_that) {
case _PostUpdateSessionResponse() when $default != null:
return $default(_that.session);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostUpdateSessionResponse implements PostUpdateSessionResponse {
  const _PostUpdateSessionResponse({required this.session});
  factory _PostUpdateSessionResponse.fromJson(Map<String, dynamic> json) => _$PostUpdateSessionResponseFromJson(json);

@override final  Session session;

/// Create a copy of PostUpdateSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostUpdateSessionResponseCopyWith<_PostUpdateSessionResponse> get copyWith => __$PostUpdateSessionResponseCopyWithImpl<_PostUpdateSessionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostUpdateSessionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostUpdateSessionResponse&&(identical(other.session, session) || other.session == session));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'PostUpdateSessionResponse(session: $session)';
}


}

/// @nodoc
abstract mixin class _$PostUpdateSessionResponseCopyWith<$Res> implements $PostUpdateSessionResponseCopyWith<$Res> {
  factory _$PostUpdateSessionResponseCopyWith(_PostUpdateSessionResponse value, $Res Function(_PostUpdateSessionResponse) _then) = __$PostUpdateSessionResponseCopyWithImpl;
@override @useResult
$Res call({
 Session session
});


@override $SessionCopyWith<$Res> get session;

}
/// @nodoc
class __$PostUpdateSessionResponseCopyWithImpl<$Res>
    implements _$PostUpdateSessionResponseCopyWith<$Res> {
  __$PostUpdateSessionResponseCopyWithImpl(this._self, this._then);

  final _PostUpdateSessionResponse _self;
  final $Res Function(_PostUpdateSessionResponse) _then;

/// Create a copy of PostUpdateSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(_PostUpdateSessionResponse(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,
  ));
}

/// Create a copy of PostUpdateSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res> get session {
  
  return $SessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
