// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_unlink_account_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostUnlinkAccountResponse {

 bool get status;
/// Create a copy of PostUnlinkAccountResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostUnlinkAccountResponseCopyWith<PostUnlinkAccountResponse> get copyWith => _$PostUnlinkAccountResponseCopyWithImpl<PostUnlinkAccountResponse>(this as PostUnlinkAccountResponse, _$identity);

  /// Serializes this PostUnlinkAccountResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostUnlinkAccountResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostUnlinkAccountResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class $PostUnlinkAccountResponseCopyWith<$Res>  {
  factory $PostUnlinkAccountResponseCopyWith(PostUnlinkAccountResponse value, $Res Function(PostUnlinkAccountResponse) _then) = _$PostUnlinkAccountResponseCopyWithImpl;
@useResult
$Res call({
 bool status
});




}
/// @nodoc
class _$PostUnlinkAccountResponseCopyWithImpl<$Res>
    implements $PostUnlinkAccountResponseCopyWith<$Res> {
  _$PostUnlinkAccountResponseCopyWithImpl(this._self, this._then);

  final PostUnlinkAccountResponse _self;
  final $Res Function(PostUnlinkAccountResponse) _then;

/// Create a copy of PostUnlinkAccountResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostUnlinkAccountResponse].
extension PostUnlinkAccountResponsePatterns on PostUnlinkAccountResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostUnlinkAccountResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostUnlinkAccountResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostUnlinkAccountResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostUnlinkAccountResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostUnlinkAccountResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostUnlinkAccountResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostUnlinkAccountResponse() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool status)  $default,) {final _that = this;
switch (_that) {
case _PostUnlinkAccountResponse():
return $default(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool status)?  $default,) {final _that = this;
switch (_that) {
case _PostUnlinkAccountResponse() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostUnlinkAccountResponse implements PostUnlinkAccountResponse {
  const _PostUnlinkAccountResponse({required this.status});
  factory _PostUnlinkAccountResponse.fromJson(Map<String, dynamic> json) => _$PostUnlinkAccountResponseFromJson(json);

@override final  bool status;

/// Create a copy of PostUnlinkAccountResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostUnlinkAccountResponseCopyWith<_PostUnlinkAccountResponse> get copyWith => __$PostUnlinkAccountResponseCopyWithImpl<_PostUnlinkAccountResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostUnlinkAccountResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostUnlinkAccountResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostUnlinkAccountResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class _$PostUnlinkAccountResponseCopyWith<$Res> implements $PostUnlinkAccountResponseCopyWith<$Res> {
  factory _$PostUnlinkAccountResponseCopyWith(_PostUnlinkAccountResponse value, $Res Function(_PostUnlinkAccountResponse) _then) = __$PostUnlinkAccountResponseCopyWithImpl;
@override @useResult
$Res call({
 bool status
});




}
/// @nodoc
class __$PostUnlinkAccountResponseCopyWithImpl<$Res>
    implements _$PostUnlinkAccountResponseCopyWith<$Res> {
  __$PostUnlinkAccountResponseCopyWithImpl(this._self, this._then);

  final _PostUnlinkAccountResponse _self;
  final $Res Function(_PostUnlinkAccountResponse) _then;

/// Create a copy of PostUnlinkAccountResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_PostUnlinkAccountResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
