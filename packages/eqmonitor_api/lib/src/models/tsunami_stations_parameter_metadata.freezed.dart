// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_stations_parameter_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStationsParameterMetadata {

 String get type;@JsonKey(name: 'schema_version') int get schemaVersion;@JsonKey(name: 'source_version') String get sourceVersion;@JsonKey(includeIfNull: true, name: 'source_updated_at') String? get sourceUpdatedAt;@JsonKey(name: 'source_urls') List<String> get sourceUrls; String get sha256;
/// Create a copy of TsunamiStationsParameterMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationsParameterMetadataCopyWith<TsunamiStationsParameterMetadata> get copyWith => _$TsunamiStationsParameterMetadataCopyWithImpl<TsunamiStationsParameterMetadata>(this as TsunamiStationsParameterMetadata, _$identity);

  /// Serializes this TsunamiStationsParameterMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationsParameterMetadata&&(identical(other.type, type) || other.type == type)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.sourceVersion, sourceVersion) || other.sourceVersion == sourceVersion)&&(identical(other.sourceUpdatedAt, sourceUpdatedAt) || other.sourceUpdatedAt == sourceUpdatedAt)&&const DeepCollectionEquality().equals(other.sourceUrls, sourceUrls)&&(identical(other.sha256, sha256) || other.sha256 == sha256));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,schemaVersion,sourceVersion,sourceUpdatedAt,const DeepCollectionEquality().hash(sourceUrls),sha256);

@override
String toString() {
  return 'TsunamiStationsParameterMetadata(type: $type, schemaVersion: $schemaVersion, sourceVersion: $sourceVersion, sourceUpdatedAt: $sourceUpdatedAt, sourceUrls: $sourceUrls, sha256: $sha256)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationsParameterMetadataCopyWith<$Res>  {
  factory $TsunamiStationsParameterMetadataCopyWith(TsunamiStationsParameterMetadata value, $Res Function(TsunamiStationsParameterMetadata) _then) = _$TsunamiStationsParameterMetadataCopyWithImpl;
@useResult
$Res call({
 String type,@JsonKey(name: 'schema_version') int schemaVersion,@JsonKey(name: 'source_version') String sourceVersion,@JsonKey(includeIfNull: true, name: 'source_updated_at') String? sourceUpdatedAt,@JsonKey(name: 'source_urls') List<String> sourceUrls, String sha256
});




}
/// @nodoc
class _$TsunamiStationsParameterMetadataCopyWithImpl<$Res>
    implements $TsunamiStationsParameterMetadataCopyWith<$Res> {
  _$TsunamiStationsParameterMetadataCopyWithImpl(this._self, this._then);

  final TsunamiStationsParameterMetadata _self;
  final $Res Function(TsunamiStationsParameterMetadata) _then;

/// Create a copy of TsunamiStationsParameterMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? schemaVersion = null,Object? sourceVersion = null,Object? sourceUpdatedAt = freezed,Object? sourceUrls = null,Object? sha256 = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,sourceVersion: null == sourceVersion ? _self.sourceVersion : sourceVersion // ignore: cast_nullable_to_non_nullable
as String,sourceUpdatedAt: freezed == sourceUpdatedAt ? _self.sourceUpdatedAt : sourceUpdatedAt // ignore: cast_nullable_to_non_nullable
as String?,sourceUrls: null == sourceUrls ? _self.sourceUrls : sourceUrls // ignore: cast_nullable_to_non_nullable
as List<String>,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiStationsParameterMetadata].
extension TsunamiStationsParameterMetadataPatterns on TsunamiStationsParameterMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStationsParameterMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStationsParameterMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStationsParameterMetadata value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationsParameterMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStationsParameterMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationsParameterMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type, @JsonKey(name: 'schema_version')  int schemaVersion, @JsonKey(name: 'source_version')  String sourceVersion, @JsonKey(includeIfNull: true, name: 'source_updated_at')  String? sourceUpdatedAt, @JsonKey(name: 'source_urls')  List<String> sourceUrls,  String sha256)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStationsParameterMetadata() when $default != null:
return $default(_that.type,_that.schemaVersion,_that.sourceVersion,_that.sourceUpdatedAt,_that.sourceUrls,_that.sha256);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type, @JsonKey(name: 'schema_version')  int schemaVersion, @JsonKey(name: 'source_version')  String sourceVersion, @JsonKey(includeIfNull: true, name: 'source_updated_at')  String? sourceUpdatedAt, @JsonKey(name: 'source_urls')  List<String> sourceUrls,  String sha256)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationsParameterMetadata():
return $default(_that.type,_that.schemaVersion,_that.sourceVersion,_that.sourceUpdatedAt,_that.sourceUrls,_that.sha256);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type, @JsonKey(name: 'schema_version')  int schemaVersion, @JsonKey(name: 'source_version')  String sourceVersion, @JsonKey(includeIfNull: true, name: 'source_updated_at')  String? sourceUpdatedAt, @JsonKey(name: 'source_urls')  List<String> sourceUrls,  String sha256)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationsParameterMetadata() when $default != null:
return $default(_that.type,_that.schemaVersion,_that.sourceVersion,_that.sourceUpdatedAt,_that.sourceUrls,_that.sha256);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStationsParameterMetadata implements TsunamiStationsParameterMetadata {
  const _TsunamiStationsParameterMetadata({required this.type, @JsonKey(name: 'schema_version') required this.schemaVersion, @JsonKey(name: 'source_version') required this.sourceVersion, @JsonKey(includeIfNull: true, name: 'source_updated_at') required this.sourceUpdatedAt, @JsonKey(name: 'source_urls') required final  List<String> sourceUrls, required this.sha256}): _sourceUrls = sourceUrls;
  factory _TsunamiStationsParameterMetadata.fromJson(Map<String, dynamic> json) => _$TsunamiStationsParameterMetadataFromJson(json);

@override final  String type;
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

/// Create a copy of TsunamiStationsParameterMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationsParameterMetadataCopyWith<_TsunamiStationsParameterMetadata> get copyWith => __$TsunamiStationsParameterMetadataCopyWithImpl<_TsunamiStationsParameterMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStationsParameterMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationsParameterMetadata&&(identical(other.type, type) || other.type == type)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.sourceVersion, sourceVersion) || other.sourceVersion == sourceVersion)&&(identical(other.sourceUpdatedAt, sourceUpdatedAt) || other.sourceUpdatedAt == sourceUpdatedAt)&&const DeepCollectionEquality().equals(other._sourceUrls, _sourceUrls)&&(identical(other.sha256, sha256) || other.sha256 == sha256));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,schemaVersion,sourceVersion,sourceUpdatedAt,const DeepCollectionEquality().hash(_sourceUrls),sha256);

@override
String toString() {
  return 'TsunamiStationsParameterMetadata(type: $type, schemaVersion: $schemaVersion, sourceVersion: $sourceVersion, sourceUpdatedAt: $sourceUpdatedAt, sourceUrls: $sourceUrls, sha256: $sha256)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationsParameterMetadataCopyWith<$Res> implements $TsunamiStationsParameterMetadataCopyWith<$Res> {
  factory _$TsunamiStationsParameterMetadataCopyWith(_TsunamiStationsParameterMetadata value, $Res Function(_TsunamiStationsParameterMetadata) _then) = __$TsunamiStationsParameterMetadataCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(name: 'schema_version') int schemaVersion,@JsonKey(name: 'source_version') String sourceVersion,@JsonKey(includeIfNull: true, name: 'source_updated_at') String? sourceUpdatedAt,@JsonKey(name: 'source_urls') List<String> sourceUrls, String sha256
});




}
/// @nodoc
class __$TsunamiStationsParameterMetadataCopyWithImpl<$Res>
    implements _$TsunamiStationsParameterMetadataCopyWith<$Res> {
  __$TsunamiStationsParameterMetadataCopyWithImpl(this._self, this._then);

  final _TsunamiStationsParameterMetadata _self;
  final $Res Function(_TsunamiStationsParameterMetadata) _then;

/// Create a copy of TsunamiStationsParameterMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? schemaVersion = null,Object? sourceVersion = null,Object? sourceUpdatedAt = freezed,Object? sourceUrls = null,Object? sha256 = null,}) {
  return _then(_TsunamiStationsParameterMetadata(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,sourceVersion: null == sourceVersion ? _self.sourceVersion : sourceVersion // ignore: cast_nullable_to_non_nullable
as String,sourceUpdatedAt: freezed == sourceUpdatedAt ? _self.sourceUpdatedAt : sourceUpdatedAt // ignore: cast_nullable_to_non_nullable
as String?,sourceUrls: null == sourceUrls ? _self._sourceUrls : sourceUrls // ignore: cast_nullable_to_non_nullable
as List<String>,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
