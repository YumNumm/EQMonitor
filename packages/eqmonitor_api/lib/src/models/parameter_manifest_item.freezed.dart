// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parameter_manifest_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParameterManifestItem {

 ParameterType get type;/// const: 1
@JsonKey(name: 'schema_version') int get schemaVersion;@JsonKey(name: 'source_version') String get sourceVersion;@JsonKey(includeIfNull: true, name: 'source_updated_at') String? get sourceUpdatedAt;@JsonKey(name: 'source_urls') List<String> get sourceUrls; String get sha256;@JsonKey(name: 'size_bytes') num get sizeBytes; String get url;
/// Create a copy of ParameterManifestItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterManifestItemCopyWith<ParameterManifestItem> get copyWith => _$ParameterManifestItemCopyWithImpl<ParameterManifestItem>(this as ParameterManifestItem, _$identity);

  /// Serializes this ParameterManifestItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterManifestItem&&(identical(other.type, type) || other.type == type)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.sourceVersion, sourceVersion) || other.sourceVersion == sourceVersion)&&(identical(other.sourceUpdatedAt, sourceUpdatedAt) || other.sourceUpdatedAt == sourceUpdatedAt)&&const DeepCollectionEquality().equals(other.sourceUrls, sourceUrls)&&(identical(other.sha256, sha256) || other.sha256 == sha256)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,schemaVersion,sourceVersion,sourceUpdatedAt,const DeepCollectionEquality().hash(sourceUrls),sha256,sizeBytes,url);

@override
String toString() {
  return 'ParameterManifestItem(type: $type, schemaVersion: $schemaVersion, sourceVersion: $sourceVersion, sourceUpdatedAt: $sourceUpdatedAt, sourceUrls: $sourceUrls, sha256: $sha256, sizeBytes: $sizeBytes, url: $url)';
}


}

/// @nodoc
abstract mixin class $ParameterManifestItemCopyWith<$Res>  {
  factory $ParameterManifestItemCopyWith(ParameterManifestItem value, $Res Function(ParameterManifestItem) _then) = _$ParameterManifestItemCopyWithImpl;
@useResult
$Res call({
 ParameterType type,@JsonKey(name: 'schema_version') int schemaVersion,@JsonKey(name: 'source_version') String sourceVersion,@JsonKey(includeIfNull: true, name: 'source_updated_at') String? sourceUpdatedAt,@JsonKey(name: 'source_urls') List<String> sourceUrls, String sha256,@JsonKey(name: 'size_bytes') num sizeBytes, String url
});




}
/// @nodoc
class _$ParameterManifestItemCopyWithImpl<$Res>
    implements $ParameterManifestItemCopyWith<$Res> {
  _$ParameterManifestItemCopyWithImpl(this._self, this._then);

  final ParameterManifestItem _self;
  final $Res Function(ParameterManifestItem) _then;

/// Create a copy of ParameterManifestItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? schemaVersion = null,Object? sourceVersion = null,Object? sourceUpdatedAt = freezed,Object? sourceUrls = null,Object? sha256 = null,Object? sizeBytes = null,Object? url = null,}) {
  return _then(ParameterManifestItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ParameterType,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,sourceVersion: null == sourceVersion ? _self.sourceVersion : sourceVersion // ignore: cast_nullable_to_non_nullable
as String,sourceUpdatedAt: freezed == sourceUpdatedAt ? _self.sourceUpdatedAt : sourceUpdatedAt // ignore: cast_nullable_to_non_nullable
as String?,sourceUrls: null == sourceUrls ? _self.sourceUrls : sourceUrls // ignore: cast_nullable_to_non_nullable
as List<String>,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as num,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ParameterManifestItem].
extension ParameterManifestItemPatterns on ParameterManifestItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParameterManifestItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParameterManifestItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParameterManifestItem value)  $default,){
final _that = this;
switch (_that) {
case _ParameterManifestItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParameterManifestItem value)?  $default,){
final _that = this;
switch (_that) {
case _ParameterManifestItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ParameterType type, @JsonKey(name: 'schema_version')  int schemaVersion, @JsonKey(name: 'source_version')  String sourceVersion, @JsonKey(includeIfNull: true, name: 'source_updated_at')  String? sourceUpdatedAt, @JsonKey(name: 'source_urls')  List<String> sourceUrls,  String sha256, @JsonKey(name: 'size_bytes')  num sizeBytes,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParameterManifestItem() when $default != null:
return $default(_that.type,_that.schemaVersion,_that.sourceVersion,_that.sourceUpdatedAt,_that.sourceUrls,_that.sha256,_that.sizeBytes,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ParameterType type, @JsonKey(name: 'schema_version')  int schemaVersion, @JsonKey(name: 'source_version')  String sourceVersion, @JsonKey(includeIfNull: true, name: 'source_updated_at')  String? sourceUpdatedAt, @JsonKey(name: 'source_urls')  List<String> sourceUrls,  String sha256, @JsonKey(name: 'size_bytes')  num sizeBytes,  String url)  $default,) {final _that = this;
switch (_that) {
case _ParameterManifestItem():
return $default(_that.type,_that.schemaVersion,_that.sourceVersion,_that.sourceUpdatedAt,_that.sourceUrls,_that.sha256,_that.sizeBytes,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ParameterType type, @JsonKey(name: 'schema_version')  int schemaVersion, @JsonKey(name: 'source_version')  String sourceVersion, @JsonKey(includeIfNull: true, name: 'source_updated_at')  String? sourceUpdatedAt, @JsonKey(name: 'source_urls')  List<String> sourceUrls,  String sha256, @JsonKey(name: 'size_bytes')  num sizeBytes,  String url)?  $default,) {final _that = this;
switch (_that) {
case _ParameterManifestItem() when $default != null:
return $default(_that.type,_that.schemaVersion,_that.sourceVersion,_that.sourceUpdatedAt,_that.sourceUrls,_that.sha256,_that.sizeBytes,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParameterManifestItem implements ParameterManifestItem {
  const _ParameterManifestItem({required this.type, @JsonKey(name: 'schema_version') required this.schemaVersion, @JsonKey(name: 'source_version') required this.sourceVersion, @JsonKey(includeIfNull: true, name: 'source_updated_at') required this.sourceUpdatedAt, @JsonKey(name: 'source_urls') required  List<String> sourceUrls, required this.sha256, @JsonKey(name: 'size_bytes') required this.sizeBytes, required this.url}): _sourceUrls = sourceUrls;
  factory _ParameterManifestItem.fromJson(Map<String, dynamic> json) => _$ParameterManifestItemFromJson(json);

@override final  ParameterType type;
/// const: 1
@override@JsonKey(name: 'schema_version') final  int schemaVersion;
@override@JsonKey(name: 'source_version') final  String sourceVersion;
@override@JsonKey(includeIfNull: true, name: 'source_updated_at') final  String? sourceUpdatedAt;
 final  List<String> _sourceUrls;
@override@JsonKey(name: 'source_urls') List<String> get sourceUrls {
  if (_sourceUrls is EqualUnmodifiableListView) return _sourceUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sourceUrls);
}

@override final  String sha256;
@override@JsonKey(name: 'size_bytes') final  num sizeBytes;
@override final  String url;

/// Create a copy of ParameterManifestItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParameterManifestItemCopyWith<_ParameterManifestItem> get copyWith => __$ParameterManifestItemCopyWithImpl<_ParameterManifestItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParameterManifestItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParameterManifestItem&&(identical(other.type, type) || other.type == type)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.sourceVersion, sourceVersion) || other.sourceVersion == sourceVersion)&&(identical(other.sourceUpdatedAt, sourceUpdatedAt) || other.sourceUpdatedAt == sourceUpdatedAt)&&const DeepCollectionEquality().equals(other._sourceUrls, _sourceUrls)&&(identical(other.sha256, sha256) || other.sha256 == sha256)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,schemaVersion,sourceVersion,sourceUpdatedAt,const DeepCollectionEquality().hash(_sourceUrls),sha256,sizeBytes,url);

@override
String toString() {
  return 'ParameterManifestItem(type: $type, schemaVersion: $schemaVersion, sourceVersion: $sourceVersion, sourceUpdatedAt: $sourceUpdatedAt, sourceUrls: $sourceUrls, sha256: $sha256, sizeBytes: $sizeBytes, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ParameterManifestItemCopyWith<$Res> implements $ParameterManifestItemCopyWith<$Res> {
  factory _$ParameterManifestItemCopyWith(_ParameterManifestItem value, $Res Function(_ParameterManifestItem) _then) = __$ParameterManifestItemCopyWithImpl;
@override @useResult
$Res call({
 ParameterType type,@JsonKey(name: 'schema_version') int schemaVersion,@JsonKey(name: 'source_version') String sourceVersion,@JsonKey(includeIfNull: true, name: 'source_updated_at') String? sourceUpdatedAt,@JsonKey(name: 'source_urls') List<String> sourceUrls, String sha256,@JsonKey(name: 'size_bytes') num sizeBytes, String url
});




}
/// @nodoc
class __$ParameterManifestItemCopyWithImpl<$Res>
    implements _$ParameterManifestItemCopyWith<$Res> {
  __$ParameterManifestItemCopyWithImpl(this._self, this._then);

  final _ParameterManifestItem _self;
  final $Res Function(_ParameterManifestItem) _then;

/// Create a copy of ParameterManifestItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? schemaVersion = null,Object? sourceVersion = null,Object? sourceUpdatedAt = freezed,Object? sourceUrls = null,Object? sha256 = null,Object? sizeBytes = null,Object? url = null,}) {
  return _then(_ParameterManifestItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ParameterType,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,sourceVersion: null == sourceVersion ? _self.sourceVersion : sourceVersion // ignore: cast_nullable_to_non_nullable
as String,sourceUpdatedAt: freezed == sourceUpdatedAt ? _self.sourceUpdatedAt : sourceUpdatedAt // ignore: cast_nullable_to_non_nullable
as String?,sourceUrls: null == sourceUrls ? _self._sourceUrls : sourceUrls // ignore: cast_nullable_to_non_nullable
as List<String>,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as num,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
