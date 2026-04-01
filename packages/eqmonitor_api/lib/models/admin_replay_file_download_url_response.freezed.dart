// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_replay_file_download_url_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminReplayFileDownloadUrlResponse {

 String get url;
/// Create a copy of AdminReplayFileDownloadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminReplayFileDownloadUrlResponseCopyWith<AdminReplayFileDownloadUrlResponse> get copyWith => _$AdminReplayFileDownloadUrlResponseCopyWithImpl<AdminReplayFileDownloadUrlResponse>(this as AdminReplayFileDownloadUrlResponse, _$identity);

  /// Serializes this AdminReplayFileDownloadUrlResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminReplayFileDownloadUrlResponse&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'AdminReplayFileDownloadUrlResponse(url: $url)';
}


}

/// @nodoc
abstract mixin class $AdminReplayFileDownloadUrlResponseCopyWith<$Res>  {
  factory $AdminReplayFileDownloadUrlResponseCopyWith(AdminReplayFileDownloadUrlResponse value, $Res Function(AdminReplayFileDownloadUrlResponse) _then) = _$AdminReplayFileDownloadUrlResponseCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$AdminReplayFileDownloadUrlResponseCopyWithImpl<$Res>
    implements $AdminReplayFileDownloadUrlResponseCopyWith<$Res> {
  _$AdminReplayFileDownloadUrlResponseCopyWithImpl(this._self, this._then);

  final AdminReplayFileDownloadUrlResponse _self;
  final $Res Function(AdminReplayFileDownloadUrlResponse) _then;

/// Create a copy of AdminReplayFileDownloadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminReplayFileDownloadUrlResponse].
extension AdminReplayFileDownloadUrlResponsePatterns on AdminReplayFileDownloadUrlResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminReplayFileDownloadUrlResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminReplayFileDownloadUrlResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminReplayFileDownloadUrlResponse value)  $default,){
final _that = this;
switch (_that) {
case _AdminReplayFileDownloadUrlResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminReplayFileDownloadUrlResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AdminReplayFileDownloadUrlResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminReplayFileDownloadUrlResponse() when $default != null:
return $default(_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url)  $default,) {final _that = this;
switch (_that) {
case _AdminReplayFileDownloadUrlResponse():
return $default(_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url)?  $default,) {final _that = this;
switch (_that) {
case _AdminReplayFileDownloadUrlResponse() when $default != null:
return $default(_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminReplayFileDownloadUrlResponse implements AdminReplayFileDownloadUrlResponse {
  const _AdminReplayFileDownloadUrlResponse({required this.url});
  factory _AdminReplayFileDownloadUrlResponse.fromJson(Map<String, dynamic> json) => _$AdminReplayFileDownloadUrlResponseFromJson(json);

@override final  String url;

/// Create a copy of AdminReplayFileDownloadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminReplayFileDownloadUrlResponseCopyWith<_AdminReplayFileDownloadUrlResponse> get copyWith => __$AdminReplayFileDownloadUrlResponseCopyWithImpl<_AdminReplayFileDownloadUrlResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminReplayFileDownloadUrlResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminReplayFileDownloadUrlResponse&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'AdminReplayFileDownloadUrlResponse(url: $url)';
}


}

/// @nodoc
abstract mixin class _$AdminReplayFileDownloadUrlResponseCopyWith<$Res> implements $AdminReplayFileDownloadUrlResponseCopyWith<$Res> {
  factory _$AdminReplayFileDownloadUrlResponseCopyWith(_AdminReplayFileDownloadUrlResponse value, $Res Function(_AdminReplayFileDownloadUrlResponse) _then) = __$AdminReplayFileDownloadUrlResponseCopyWithImpl;
@override @useResult
$Res call({
 String url
});




}
/// @nodoc
class __$AdminReplayFileDownloadUrlResponseCopyWithImpl<$Res>
    implements _$AdminReplayFileDownloadUrlResponseCopyWith<$Res> {
  __$AdminReplayFileDownloadUrlResponseCopyWithImpl(this._self, this._then);

  final _AdminReplayFileDownloadUrlResponse _self;
  final $Res Function(_AdminReplayFileDownloadUrlResponse) _then;

/// Create a copy of AdminReplayFileDownloadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(_AdminReplayFileDownloadUrlResponse(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
