// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_earthquake_archive_download_url_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminEarthquakeArchiveDownloadUrlResponse {

 String get url;
/// Create a copy of AdminEarthquakeArchiveDownloadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminEarthquakeArchiveDownloadUrlResponseCopyWith<AdminEarthquakeArchiveDownloadUrlResponse> get copyWith => _$AdminEarthquakeArchiveDownloadUrlResponseCopyWithImpl<AdminEarthquakeArchiveDownloadUrlResponse>(this as AdminEarthquakeArchiveDownloadUrlResponse, _$identity);

  /// Serializes this AdminEarthquakeArchiveDownloadUrlResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminEarthquakeArchiveDownloadUrlResponse&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'AdminEarthquakeArchiveDownloadUrlResponse(url: $url)';
}


}

/// @nodoc
abstract mixin class $AdminEarthquakeArchiveDownloadUrlResponseCopyWith<$Res>  {
  factory $AdminEarthquakeArchiveDownloadUrlResponseCopyWith(AdminEarthquakeArchiveDownloadUrlResponse value, $Res Function(AdminEarthquakeArchiveDownloadUrlResponse) _then) = _$AdminEarthquakeArchiveDownloadUrlResponseCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$AdminEarthquakeArchiveDownloadUrlResponseCopyWithImpl<$Res>
    implements $AdminEarthquakeArchiveDownloadUrlResponseCopyWith<$Res> {
  _$AdminEarthquakeArchiveDownloadUrlResponseCopyWithImpl(this._self, this._then);

  final AdminEarthquakeArchiveDownloadUrlResponse _self;
  final $Res Function(AdminEarthquakeArchiveDownloadUrlResponse) _then;

/// Create a copy of AdminEarthquakeArchiveDownloadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,}) {
  return _then(AdminEarthquakeArchiveDownloadUrlResponse(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminEarthquakeArchiveDownloadUrlResponse].
extension AdminEarthquakeArchiveDownloadUrlResponsePatterns on AdminEarthquakeArchiveDownloadUrlResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminEarthquakeArchiveDownloadUrlResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminEarthquakeArchiveDownloadUrlResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminEarthquakeArchiveDownloadUrlResponse value)  $default,){
final _that = this;
switch (_that) {
case _AdminEarthquakeArchiveDownloadUrlResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminEarthquakeArchiveDownloadUrlResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AdminEarthquakeArchiveDownloadUrlResponse() when $default != null:
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
case _AdminEarthquakeArchiveDownloadUrlResponse() when $default != null:
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
case _AdminEarthquakeArchiveDownloadUrlResponse():
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
case _AdminEarthquakeArchiveDownloadUrlResponse() when $default != null:
return $default(_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminEarthquakeArchiveDownloadUrlResponse implements AdminEarthquakeArchiveDownloadUrlResponse {
  const _AdminEarthquakeArchiveDownloadUrlResponse({required this.url});
  factory _AdminEarthquakeArchiveDownloadUrlResponse.fromJson(Map<String, dynamic> json) => _$AdminEarthquakeArchiveDownloadUrlResponseFromJson(json);

@override final  String url;

/// Create a copy of AdminEarthquakeArchiveDownloadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminEarthquakeArchiveDownloadUrlResponseCopyWith<_AdminEarthquakeArchiveDownloadUrlResponse> get copyWith => __$AdminEarthquakeArchiveDownloadUrlResponseCopyWithImpl<_AdminEarthquakeArchiveDownloadUrlResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminEarthquakeArchiveDownloadUrlResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminEarthquakeArchiveDownloadUrlResponse&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'AdminEarthquakeArchiveDownloadUrlResponse(url: $url)';
}


}

/// @nodoc
abstract mixin class _$AdminEarthquakeArchiveDownloadUrlResponseCopyWith<$Res> implements $AdminEarthquakeArchiveDownloadUrlResponseCopyWith<$Res> {
  factory _$AdminEarthquakeArchiveDownloadUrlResponseCopyWith(_AdminEarthquakeArchiveDownloadUrlResponse value, $Res Function(_AdminEarthquakeArchiveDownloadUrlResponse) _then) = __$AdminEarthquakeArchiveDownloadUrlResponseCopyWithImpl;
@override @useResult
$Res call({
 String url
});




}
/// @nodoc
class __$AdminEarthquakeArchiveDownloadUrlResponseCopyWithImpl<$Res>
    implements _$AdminEarthquakeArchiveDownloadUrlResponseCopyWith<$Res> {
  __$AdminEarthquakeArchiveDownloadUrlResponseCopyWithImpl(this._self, this._then);

  final _AdminEarthquakeArchiveDownloadUrlResponse _self;
  final $Res Function(_AdminEarthquakeArchiveDownloadUrlResponse) _then;

/// Create a copy of AdminEarthquakeArchiveDownloadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(_AdminEarthquakeArchiveDownloadUrlResponse(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
