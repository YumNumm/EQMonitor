// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_pmtiles_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SeismicityPmTilesSource _$SeismicityPmTilesSourceFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'network':
          return SeismicityPmTilesNetworkSource.fromJson(
            json
          );
                case 'file':
          return SeismicityPmTilesFileSource.fromJson(
            json
          );
                case 'asset':
          return SeismicityPmTilesAssetSource.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'SeismicityPmTilesSource',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$SeismicityPmTilesSource {



  /// Serializes this SeismicityPmTilesSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesSource);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeismicityPmTilesSource()';
}


}

/// @nodoc
class $SeismicityPmTilesSourceCopyWith<$Res>  {
$SeismicityPmTilesSourceCopyWith(SeismicityPmTilesSource _, $Res Function(SeismicityPmTilesSource) __);
}


/// Adds pattern-matching-related methods to [SeismicityPmTilesSource].
extension SeismicityPmTilesSourcePatterns on SeismicityPmTilesSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SeismicityPmTilesNetworkSource value)?  network,TResult Function( SeismicityPmTilesFileSource value)?  file,TResult Function( SeismicityPmTilesAssetSource value)?  asset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SeismicityPmTilesNetworkSource() when network != null:
return network(_that);case SeismicityPmTilesFileSource() when file != null:
return file(_that);case SeismicityPmTilesAssetSource() when asset != null:
return asset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SeismicityPmTilesNetworkSource value)  network,required TResult Function( SeismicityPmTilesFileSource value)  file,required TResult Function( SeismicityPmTilesAssetSource value)  asset,}){
final _that = this;
switch (_that) {
case SeismicityPmTilesNetworkSource():
return network(_that);case SeismicityPmTilesFileSource():
return file(_that);case SeismicityPmTilesAssetSource():
return asset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SeismicityPmTilesNetworkSource value)?  network,TResult? Function( SeismicityPmTilesFileSource value)?  file,TResult? Function( SeismicityPmTilesAssetSource value)?  asset,}){
final _that = this;
switch (_that) {
case SeismicityPmTilesNetworkSource() when network != null:
return network(_that);case SeismicityPmTilesFileSource() when file != null:
return file(_that);case SeismicityPmTilesAssetSource() when asset != null:
return asset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Uri archiveUri)?  network,TResult Function( String path)?  file,TResult Function( String assetKey)?  asset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SeismicityPmTilesNetworkSource() when network != null:
return network(_that.archiveUri);case SeismicityPmTilesFileSource() when file != null:
return file(_that.path);case SeismicityPmTilesAssetSource() when asset != null:
return asset(_that.assetKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Uri archiveUri)  network,required TResult Function( String path)  file,required TResult Function( String assetKey)  asset,}) {final _that = this;
switch (_that) {
case SeismicityPmTilesNetworkSource():
return network(_that.archiveUri);case SeismicityPmTilesFileSource():
return file(_that.path);case SeismicityPmTilesAssetSource():
return asset(_that.assetKey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Uri archiveUri)?  network,TResult? Function( String path)?  file,TResult? Function( String assetKey)?  asset,}) {final _that = this;
switch (_that) {
case SeismicityPmTilesNetworkSource() when network != null:
return network(_that.archiveUri);case SeismicityPmTilesFileSource() when file != null:
return file(_that.path);case SeismicityPmTilesAssetSource() when asset != null:
return asset(_that.assetKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SeismicityPmTilesNetworkSource implements SeismicityPmTilesSource {
  const SeismicityPmTilesNetworkSource({required this.archiveUri, final  String? $type}): $type = $type ?? 'network';
  factory SeismicityPmTilesNetworkSource.fromJson(Map<String, dynamic> json) => _$SeismicityPmTilesNetworkSourceFromJson(json);

 final  Uri archiveUri;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SeismicityPmTilesSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesNetworkSourceCopyWith<SeismicityPmTilesNetworkSource> get copyWith => _$SeismicityPmTilesNetworkSourceCopyWithImpl<SeismicityPmTilesNetworkSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeismicityPmTilesNetworkSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesNetworkSource&&(identical(other.archiveUri, archiveUri) || other.archiveUri == archiveUri));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,archiveUri);

@override
String toString() {
  return 'SeismicityPmTilesSource.network(archiveUri: $archiveUri)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesNetworkSourceCopyWith<$Res> implements $SeismicityPmTilesSourceCopyWith<$Res> {
  factory $SeismicityPmTilesNetworkSourceCopyWith(SeismicityPmTilesNetworkSource value, $Res Function(SeismicityPmTilesNetworkSource) _then) = _$SeismicityPmTilesNetworkSourceCopyWithImpl;
@useResult
$Res call({
 Uri archiveUri
});




}
/// @nodoc
class _$SeismicityPmTilesNetworkSourceCopyWithImpl<$Res>
    implements $SeismicityPmTilesNetworkSourceCopyWith<$Res> {
  _$SeismicityPmTilesNetworkSourceCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesNetworkSource _self;
  final $Res Function(SeismicityPmTilesNetworkSource) _then;

/// Create a copy of SeismicityPmTilesSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? archiveUri = null,}) {
  return _then(SeismicityPmTilesNetworkSource(
archiveUri: null == archiveUri ? _self.archiveUri : archiveUri // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SeismicityPmTilesFileSource implements SeismicityPmTilesSource {
  const SeismicityPmTilesFileSource({required this.path, final  String? $type}): $type = $type ?? 'file';
  factory SeismicityPmTilesFileSource.fromJson(Map<String, dynamic> json) => _$SeismicityPmTilesFileSourceFromJson(json);

 final  String path;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SeismicityPmTilesSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesFileSourceCopyWith<SeismicityPmTilesFileSource> get copyWith => _$SeismicityPmTilesFileSourceCopyWithImpl<SeismicityPmTilesFileSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeismicityPmTilesFileSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesFileSource&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path);

@override
String toString() {
  return 'SeismicityPmTilesSource.file(path: $path)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesFileSourceCopyWith<$Res> implements $SeismicityPmTilesSourceCopyWith<$Res> {
  factory $SeismicityPmTilesFileSourceCopyWith(SeismicityPmTilesFileSource value, $Res Function(SeismicityPmTilesFileSource) _then) = _$SeismicityPmTilesFileSourceCopyWithImpl;
@useResult
$Res call({
 String path
});




}
/// @nodoc
class _$SeismicityPmTilesFileSourceCopyWithImpl<$Res>
    implements $SeismicityPmTilesFileSourceCopyWith<$Res> {
  _$SeismicityPmTilesFileSourceCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesFileSource _self;
  final $Res Function(SeismicityPmTilesFileSource) _then;

/// Create a copy of SeismicityPmTilesSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? path = null,}) {
  return _then(SeismicityPmTilesFileSource(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SeismicityPmTilesAssetSource implements SeismicityPmTilesSource {
  const SeismicityPmTilesAssetSource({required this.assetKey, final  String? $type}): $type = $type ?? 'asset';
  factory SeismicityPmTilesAssetSource.fromJson(Map<String, dynamic> json) => _$SeismicityPmTilesAssetSourceFromJson(json);

 final  String assetKey;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SeismicityPmTilesSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesAssetSourceCopyWith<SeismicityPmTilesAssetSource> get copyWith => _$SeismicityPmTilesAssetSourceCopyWithImpl<SeismicityPmTilesAssetSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeismicityPmTilesAssetSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesAssetSource&&(identical(other.assetKey, assetKey) || other.assetKey == assetKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetKey);

@override
String toString() {
  return 'SeismicityPmTilesSource.asset(assetKey: $assetKey)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesAssetSourceCopyWith<$Res> implements $SeismicityPmTilesSourceCopyWith<$Res> {
  factory $SeismicityPmTilesAssetSourceCopyWith(SeismicityPmTilesAssetSource value, $Res Function(SeismicityPmTilesAssetSource) _then) = _$SeismicityPmTilesAssetSourceCopyWithImpl;
@useResult
$Res call({
 String assetKey
});




}
/// @nodoc
class _$SeismicityPmTilesAssetSourceCopyWithImpl<$Res>
    implements $SeismicityPmTilesAssetSourceCopyWith<$Res> {
  _$SeismicityPmTilesAssetSourceCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesAssetSource _self;
  final $Res Function(SeismicityPmTilesAssetSource) _then;

/// Create a copy of SeismicityPmTilesSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? assetKey = null,}) {
  return _then(SeismicityPmTilesAssetSource(
assetKey: null == assetKey ? _self.assetKey : assetKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
