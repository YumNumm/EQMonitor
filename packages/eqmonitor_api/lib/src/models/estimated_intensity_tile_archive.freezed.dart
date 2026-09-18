// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimated_intensity_tile_archive.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EstimatedIntensityTileArchive {

/// 推計震度PMTilesのHTTPSフルURL
 String get url;/// 推計震度PMTilesのバイト数
@JsonKey(name: 'size_bytes') int get sizeBytes;/// 推計震度PMTilesのSHA-256
 String get sha256;
/// Create a copy of EstimatedIntensityTileArchive
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimatedIntensityTileArchiveCopyWith<EstimatedIntensityTileArchive> get copyWith => _$EstimatedIntensityTileArchiveCopyWithImpl<EstimatedIntensityTileArchive>(this as EstimatedIntensityTileArchive, _$identity);

  /// Serializes this EstimatedIntensityTileArchive to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimatedIntensityTileArchive&&(identical(other.url, url) || other.url == url)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.sha256, sha256) || other.sha256 == sha256));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,sizeBytes,sha256);

@override
String toString() {
  return 'EstimatedIntensityTileArchive(url: $url, sizeBytes: $sizeBytes, sha256: $sha256)';
}


}

/// @nodoc
abstract mixin class $EstimatedIntensityTileArchiveCopyWith<$Res>  {
  factory $EstimatedIntensityTileArchiveCopyWith(EstimatedIntensityTileArchive value, $Res Function(EstimatedIntensityTileArchive) _then) = _$EstimatedIntensityTileArchiveCopyWithImpl;
@useResult
$Res call({
 String url,@JsonKey(name: 'size_bytes') int sizeBytes, String sha256
});




}
/// @nodoc
class _$EstimatedIntensityTileArchiveCopyWithImpl<$Res>
    implements $EstimatedIntensityTileArchiveCopyWith<$Res> {
  _$EstimatedIntensityTileArchiveCopyWithImpl(this._self, this._then);

  final EstimatedIntensityTileArchive _self;
  final $Res Function(EstimatedIntensityTileArchive) _then;

/// Create a copy of EstimatedIntensityTileArchive
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? sizeBytes = null,Object? sha256 = null,}) {
  return _then(EstimatedIntensityTileArchive(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EstimatedIntensityTileArchive].
extension EstimatedIntensityTileArchivePatterns on EstimatedIntensityTileArchive {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimatedIntensityTileArchive value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimatedIntensityTileArchive() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimatedIntensityTileArchive value)  $default,){
final _that = this;
switch (_that) {
case _EstimatedIntensityTileArchive():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimatedIntensityTileArchive value)?  $default,){
final _that = this;
switch (_that) {
case _EstimatedIntensityTileArchive() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url, @JsonKey(name: 'size_bytes')  int sizeBytes,  String sha256)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimatedIntensityTileArchive() when $default != null:
return $default(_that.url,_that.sizeBytes,_that.sha256);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url, @JsonKey(name: 'size_bytes')  int sizeBytes,  String sha256)  $default,) {final _that = this;
switch (_that) {
case _EstimatedIntensityTileArchive():
return $default(_that.url,_that.sizeBytes,_that.sha256);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url, @JsonKey(name: 'size_bytes')  int sizeBytes,  String sha256)?  $default,) {final _that = this;
switch (_that) {
case _EstimatedIntensityTileArchive() when $default != null:
return $default(_that.url,_that.sizeBytes,_that.sha256);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstimatedIntensityTileArchive implements EstimatedIntensityTileArchive {
  const _EstimatedIntensityTileArchive({required this.url, @JsonKey(name: 'size_bytes') required this.sizeBytes, required this.sha256});
  factory _EstimatedIntensityTileArchive.fromJson(Map<String, dynamic> json) => _$EstimatedIntensityTileArchiveFromJson(json);

/// 推計震度PMTilesのHTTPSフルURL
@override final  String url;
/// 推計震度PMTilesのバイト数
@override@JsonKey(name: 'size_bytes') final  int sizeBytes;
/// 推計震度PMTilesのSHA-256
@override final  String sha256;

/// Create a copy of EstimatedIntensityTileArchive
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimatedIntensityTileArchiveCopyWith<_EstimatedIntensityTileArchive> get copyWith => __$EstimatedIntensityTileArchiveCopyWithImpl<_EstimatedIntensityTileArchive>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimatedIntensityTileArchiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimatedIntensityTileArchive&&(identical(other.url, url) || other.url == url)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.sha256, sha256) || other.sha256 == sha256));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,sizeBytes,sha256);

@override
String toString() {
  return 'EstimatedIntensityTileArchive(url: $url, sizeBytes: $sizeBytes, sha256: $sha256)';
}


}

/// @nodoc
abstract mixin class _$EstimatedIntensityTileArchiveCopyWith<$Res> implements $EstimatedIntensityTileArchiveCopyWith<$Res> {
  factory _$EstimatedIntensityTileArchiveCopyWith(_EstimatedIntensityTileArchive value, $Res Function(_EstimatedIntensityTileArchive) _then) = __$EstimatedIntensityTileArchiveCopyWithImpl;
@override @useResult
$Res call({
 String url,@JsonKey(name: 'size_bytes') int sizeBytes, String sha256
});




}
/// @nodoc
class __$EstimatedIntensityTileArchiveCopyWithImpl<$Res>
    implements _$EstimatedIntensityTileArchiveCopyWith<$Res> {
  __$EstimatedIntensityTileArchiveCopyWithImpl(this._self, this._then);

  final _EstimatedIntensityTileArchive _self;
  final $Res Function(_EstimatedIntensityTileArchive) _then;

/// Create a copy of EstimatedIntensityTileArchive
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? sizeBytes = null,Object? sha256 = null,}) {
  return _then(_EstimatedIntensityTileArchive(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
