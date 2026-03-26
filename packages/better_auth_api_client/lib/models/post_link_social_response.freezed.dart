// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_link_social_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostLinkSocialResponse {

/// Indicates if the user should be redirected to the authorization URL
 bool get redirect;/// The authorization URL to redirect the user to
@JsonKey(includeIfNull: false) String? get url;@JsonKey(includeIfNull: false) bool? get status;
/// Create a copy of PostLinkSocialResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostLinkSocialResponseCopyWith<PostLinkSocialResponse> get copyWith => _$PostLinkSocialResponseCopyWithImpl<PostLinkSocialResponse>(this as PostLinkSocialResponse, _$identity);

  /// Serializes this PostLinkSocialResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostLinkSocialResponse&&(identical(other.redirect, redirect) || other.redirect == redirect)&&(identical(other.url, url) || other.url == url)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,redirect,url,status);

@override
String toString() {
  return 'PostLinkSocialResponse(redirect: $redirect, url: $url, status: $status)';
}


}

/// @nodoc
abstract mixin class $PostLinkSocialResponseCopyWith<$Res>  {
  factory $PostLinkSocialResponseCopyWith(PostLinkSocialResponse value, $Res Function(PostLinkSocialResponse) _then) = _$PostLinkSocialResponseCopyWithImpl;
@useResult
$Res call({
 bool redirect,@JsonKey(includeIfNull: false) String? url,@JsonKey(includeIfNull: false) bool? status
});




}
/// @nodoc
class _$PostLinkSocialResponseCopyWithImpl<$Res>
    implements $PostLinkSocialResponseCopyWith<$Res> {
  _$PostLinkSocialResponseCopyWithImpl(this._self, this._then);

  final PostLinkSocialResponse _self;
  final $Res Function(PostLinkSocialResponse) _then;

/// Create a copy of PostLinkSocialResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? redirect = null,Object? url = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as bool,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostLinkSocialResponse].
extension PostLinkSocialResponsePatterns on PostLinkSocialResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostLinkSocialResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostLinkSocialResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostLinkSocialResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostLinkSocialResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostLinkSocialResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostLinkSocialResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool redirect, @JsonKey(includeIfNull: false)  String? url, @JsonKey(includeIfNull: false)  bool? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostLinkSocialResponse() when $default != null:
return $default(_that.redirect,_that.url,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool redirect, @JsonKey(includeIfNull: false)  String? url, @JsonKey(includeIfNull: false)  bool? status)  $default,) {final _that = this;
switch (_that) {
case _PostLinkSocialResponse():
return $default(_that.redirect,_that.url,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool redirect, @JsonKey(includeIfNull: false)  String? url, @JsonKey(includeIfNull: false)  bool? status)?  $default,) {final _that = this;
switch (_that) {
case _PostLinkSocialResponse() when $default != null:
return $default(_that.redirect,_that.url,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostLinkSocialResponse implements PostLinkSocialResponse {
  const _PostLinkSocialResponse({required this.redirect, @JsonKey(includeIfNull: false) this.url, @JsonKey(includeIfNull: false) this.status});
  factory _PostLinkSocialResponse.fromJson(Map<String, dynamic> json) => _$PostLinkSocialResponseFromJson(json);

/// Indicates if the user should be redirected to the authorization URL
@override final  bool redirect;
/// The authorization URL to redirect the user to
@override@JsonKey(includeIfNull: false) final  String? url;
@override@JsonKey(includeIfNull: false) final  bool? status;

/// Create a copy of PostLinkSocialResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostLinkSocialResponseCopyWith<_PostLinkSocialResponse> get copyWith => __$PostLinkSocialResponseCopyWithImpl<_PostLinkSocialResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostLinkSocialResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostLinkSocialResponse&&(identical(other.redirect, redirect) || other.redirect == redirect)&&(identical(other.url, url) || other.url == url)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,redirect,url,status);

@override
String toString() {
  return 'PostLinkSocialResponse(redirect: $redirect, url: $url, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PostLinkSocialResponseCopyWith<$Res> implements $PostLinkSocialResponseCopyWith<$Res> {
  factory _$PostLinkSocialResponseCopyWith(_PostLinkSocialResponse value, $Res Function(_PostLinkSocialResponse) _then) = __$PostLinkSocialResponseCopyWithImpl;
@override @useResult
$Res call({
 bool redirect,@JsonKey(includeIfNull: false) String? url,@JsonKey(includeIfNull: false) bool? status
});




}
/// @nodoc
class __$PostLinkSocialResponseCopyWithImpl<$Res>
    implements _$PostLinkSocialResponseCopyWith<$Res> {
  __$PostLinkSocialResponseCopyWithImpl(this._self, this._then);

  final _PostLinkSocialResponse _self;
  final $Res Function(_PostLinkSocialResponse) _then;

/// Create a copy of PostLinkSocialResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? redirect = null,Object? url = freezed,Object? status = freezed,}) {
  return _then(_PostLinkSocialResponse(
redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as bool,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
