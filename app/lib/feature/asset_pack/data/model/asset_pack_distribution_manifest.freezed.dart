// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_pack_distribution_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssetPackDistributionManifest {

 int get schemaVersion; int get revision; String get latestVersion; String get generatedAt; List<AssetPackDistributionEntry> get packs;
/// Create a copy of AssetPackDistributionManifest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetPackDistributionManifestCopyWith<AssetPackDistributionManifest> get copyWith => _$AssetPackDistributionManifestCopyWithImpl<AssetPackDistributionManifest>(this as AssetPackDistributionManifest, _$identity);

  /// Serializes this AssetPackDistributionManifest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetPackDistributionManifest&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&const DeepCollectionEquality().equals(other.packs, packs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,revision,latestVersion,generatedAt,const DeepCollectionEquality().hash(packs));

@override
String toString() {
  return 'AssetPackDistributionManifest(schemaVersion: $schemaVersion, revision: $revision, latestVersion: $latestVersion, generatedAt: $generatedAt, packs: $packs)';
}


}

/// @nodoc
abstract mixin class $AssetPackDistributionManifestCopyWith<$Res>  {
  factory $AssetPackDistributionManifestCopyWith(AssetPackDistributionManifest value, $Res Function(AssetPackDistributionManifest) _then) = _$AssetPackDistributionManifestCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, int revision, String latestVersion, String generatedAt, List<AssetPackDistributionEntry> packs
});




}
/// @nodoc
class _$AssetPackDistributionManifestCopyWithImpl<$Res>
    implements $AssetPackDistributionManifestCopyWith<$Res> {
  _$AssetPackDistributionManifestCopyWithImpl(this._self, this._then);

  final AssetPackDistributionManifest _self;
  final $Res Function(AssetPackDistributionManifest) _then;

/// Create a copy of AssetPackDistributionManifest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? revision = null,Object? latestVersion = null,Object? generatedAt = null,Object? packs = null,}) {
  return _then(AssetPackDistributionManifest(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,latestVersion: null == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,packs: null == packs ? _self.packs : packs // ignore: cast_nullable_to_non_nullable
as List<AssetPackDistributionEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetPackDistributionManifest].
extension AssetPackDistributionManifestPatterns on AssetPackDistributionManifest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetPackDistributionManifest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetPackDistributionManifest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetPackDistributionManifest value)  $default,){
final _that = this;
switch (_that) {
case _AssetPackDistributionManifest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetPackDistributionManifest value)?  $default,){
final _that = this;
switch (_that) {
case _AssetPackDistributionManifest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  int revision,  String latestVersion,  String generatedAt,  List<AssetPackDistributionEntry> packs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetPackDistributionManifest() when $default != null:
return $default(_that.schemaVersion,_that.revision,_that.latestVersion,_that.generatedAt,_that.packs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  int revision,  String latestVersion,  String generatedAt,  List<AssetPackDistributionEntry> packs)  $default,) {final _that = this;
switch (_that) {
case _AssetPackDistributionManifest():
return $default(_that.schemaVersion,_that.revision,_that.latestVersion,_that.generatedAt,_that.packs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  int revision,  String latestVersion,  String generatedAt,  List<AssetPackDistributionEntry> packs)?  $default,) {final _that = this;
switch (_that) {
case _AssetPackDistributionManifest() when $default != null:
return $default(_that.schemaVersion,_that.revision,_that.latestVersion,_that.generatedAt,_that.packs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetPackDistributionManifest implements AssetPackDistributionManifest {
  const _AssetPackDistributionManifest({required this.schemaVersion, required this.revision, required this.latestVersion, required this.generatedAt, required  List<AssetPackDistributionEntry> packs}): _packs = packs;
  factory _AssetPackDistributionManifest.fromJson(Map<String, dynamic> json) => _$AssetPackDistributionManifestFromJson(json);

@override final  int schemaVersion;
@override final  int revision;
@override final  String latestVersion;
@override final  String generatedAt;
 final  List<AssetPackDistributionEntry> _packs;
@override List<AssetPackDistributionEntry> get packs {
  if (_packs is EqualUnmodifiableListView) return _packs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_packs);
}


/// Create a copy of AssetPackDistributionManifest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetPackDistributionManifestCopyWith<_AssetPackDistributionManifest> get copyWith => __$AssetPackDistributionManifestCopyWithImpl<_AssetPackDistributionManifest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetPackDistributionManifestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetPackDistributionManifest&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&const DeepCollectionEquality().equals(other._packs, _packs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,revision,latestVersion,generatedAt,const DeepCollectionEquality().hash(_packs));

@override
String toString() {
  return 'AssetPackDistributionManifest(schemaVersion: $schemaVersion, revision: $revision, latestVersion: $latestVersion, generatedAt: $generatedAt, packs: $packs)';
}


}

/// @nodoc
abstract mixin class _$AssetPackDistributionManifestCopyWith<$Res> implements $AssetPackDistributionManifestCopyWith<$Res> {
  factory _$AssetPackDistributionManifestCopyWith(_AssetPackDistributionManifest value, $Res Function(_AssetPackDistributionManifest) _then) = __$AssetPackDistributionManifestCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, int revision, String latestVersion, String generatedAt, List<AssetPackDistributionEntry> packs
});




}
/// @nodoc
class __$AssetPackDistributionManifestCopyWithImpl<$Res>
    implements _$AssetPackDistributionManifestCopyWith<$Res> {
  __$AssetPackDistributionManifestCopyWithImpl(this._self, this._then);

  final _AssetPackDistributionManifest _self;
  final $Res Function(_AssetPackDistributionManifest) _then;

/// Create a copy of AssetPackDistributionManifest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? revision = null,Object? latestVersion = null,Object? generatedAt = null,Object? packs = null,}) {
  return _then(_AssetPackDistributionManifest(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,latestVersion: null == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,packs: null == packs ? _self._packs : packs // ignore: cast_nullable_to_non_nullable
as List<AssetPackDistributionEntry>,
  ));
}


}


/// @nodoc
mixin _$AssetPackDistributionEntry {

 String get version; String get publishedAt; String get minimumAppVersion; String get archivePath; int get archiveSizeBytes; String get archiveSha256; AssetPackChangelogLocalizations get localizations;
/// Create a copy of AssetPackDistributionEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetPackDistributionEntryCopyWith<AssetPackDistributionEntry> get copyWith => _$AssetPackDistributionEntryCopyWithImpl<AssetPackDistributionEntry>(this as AssetPackDistributionEntry, _$identity);

  /// Serializes this AssetPackDistributionEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetPackDistributionEntry&&(identical(other.version, version) || other.version == version)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.minimumAppVersion, minimumAppVersion) || other.minimumAppVersion == minimumAppVersion)&&(identical(other.archivePath, archivePath) || other.archivePath == archivePath)&&(identical(other.archiveSizeBytes, archiveSizeBytes) || other.archiveSizeBytes == archiveSizeBytes)&&(identical(other.archiveSha256, archiveSha256) || other.archiveSha256 == archiveSha256)&&(identical(other.localizations, localizations) || other.localizations == localizations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,publishedAt,minimumAppVersion,archivePath,archiveSizeBytes,archiveSha256,localizations);

@override
String toString() {
  return 'AssetPackDistributionEntry(version: $version, publishedAt: $publishedAt, minimumAppVersion: $minimumAppVersion, archivePath: $archivePath, archiveSizeBytes: $archiveSizeBytes, archiveSha256: $archiveSha256, localizations: $localizations)';
}


}

/// @nodoc
abstract mixin class $AssetPackDistributionEntryCopyWith<$Res>  {
  factory $AssetPackDistributionEntryCopyWith(AssetPackDistributionEntry value, $Res Function(AssetPackDistributionEntry) _then) = _$AssetPackDistributionEntryCopyWithImpl;
@useResult
$Res call({
 String version, String publishedAt, String minimumAppVersion, String archivePath, int archiveSizeBytes, String archiveSha256, AssetPackChangelogLocalizations localizations
});


$AssetPackChangelogLocalizationsCopyWith<$Res> get localizations;

}
/// @nodoc
class _$AssetPackDistributionEntryCopyWithImpl<$Res>
    implements $AssetPackDistributionEntryCopyWith<$Res> {
  _$AssetPackDistributionEntryCopyWithImpl(this._self, this._then);

  final AssetPackDistributionEntry _self;
  final $Res Function(AssetPackDistributionEntry) _then;

/// Create a copy of AssetPackDistributionEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? publishedAt = null,Object? minimumAppVersion = null,Object? archivePath = null,Object? archiveSizeBytes = null,Object? archiveSha256 = null,Object? localizations = null,}) {
  return _then(AssetPackDistributionEntry(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,minimumAppVersion: null == minimumAppVersion ? _self.minimumAppVersion : minimumAppVersion // ignore: cast_nullable_to_non_nullable
as String,archivePath: null == archivePath ? _self.archivePath : archivePath // ignore: cast_nullable_to_non_nullable
as String,archiveSizeBytes: null == archiveSizeBytes ? _self.archiveSizeBytes : archiveSizeBytes // ignore: cast_nullable_to_non_nullable
as int,archiveSha256: null == archiveSha256 ? _self.archiveSha256 : archiveSha256 // ignore: cast_nullable_to_non_nullable
as String,localizations: null == localizations ? _self.localizations : localizations // ignore: cast_nullable_to_non_nullable
as AssetPackChangelogLocalizations,
  ));
}
/// Create a copy of AssetPackDistributionEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetPackChangelogLocalizationsCopyWith<$Res> get localizations {
  
  return $AssetPackChangelogLocalizationsCopyWith<$Res>(_self.localizations, (value) {
    return _then(_self.copyWith(localizations: value));
  });
}
}


/// Adds pattern-matching-related methods to [AssetPackDistributionEntry].
extension AssetPackDistributionEntryPatterns on AssetPackDistributionEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetPackDistributionEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetPackDistributionEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetPackDistributionEntry value)  $default,){
final _that = this;
switch (_that) {
case _AssetPackDistributionEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetPackDistributionEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AssetPackDistributionEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  String publishedAt,  String minimumAppVersion,  String archivePath,  int archiveSizeBytes,  String archiveSha256,  AssetPackChangelogLocalizations localizations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetPackDistributionEntry() when $default != null:
return $default(_that.version,_that.publishedAt,_that.minimumAppVersion,_that.archivePath,_that.archiveSizeBytes,_that.archiveSha256,_that.localizations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  String publishedAt,  String minimumAppVersion,  String archivePath,  int archiveSizeBytes,  String archiveSha256,  AssetPackChangelogLocalizations localizations)  $default,) {final _that = this;
switch (_that) {
case _AssetPackDistributionEntry():
return $default(_that.version,_that.publishedAt,_that.minimumAppVersion,_that.archivePath,_that.archiveSizeBytes,_that.archiveSha256,_that.localizations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  String publishedAt,  String minimumAppVersion,  String archivePath,  int archiveSizeBytes,  String archiveSha256,  AssetPackChangelogLocalizations localizations)?  $default,) {final _that = this;
switch (_that) {
case _AssetPackDistributionEntry() when $default != null:
return $default(_that.version,_that.publishedAt,_that.minimumAppVersion,_that.archivePath,_that.archiveSizeBytes,_that.archiveSha256,_that.localizations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetPackDistributionEntry implements AssetPackDistributionEntry {
  const _AssetPackDistributionEntry({required this.version, required this.publishedAt, required this.minimumAppVersion, required this.archivePath, required this.archiveSizeBytes, required this.archiveSha256, required this.localizations});
  factory _AssetPackDistributionEntry.fromJson(Map<String, dynamic> json) => _$AssetPackDistributionEntryFromJson(json);

@override final  String version;
@override final  String publishedAt;
@override final  String minimumAppVersion;
@override final  String archivePath;
@override final  int archiveSizeBytes;
@override final  String archiveSha256;
@override final  AssetPackChangelogLocalizations localizations;

/// Create a copy of AssetPackDistributionEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetPackDistributionEntryCopyWith<_AssetPackDistributionEntry> get copyWith => __$AssetPackDistributionEntryCopyWithImpl<_AssetPackDistributionEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetPackDistributionEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetPackDistributionEntry&&(identical(other.version, version) || other.version == version)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.minimumAppVersion, minimumAppVersion) || other.minimumAppVersion == minimumAppVersion)&&(identical(other.archivePath, archivePath) || other.archivePath == archivePath)&&(identical(other.archiveSizeBytes, archiveSizeBytes) || other.archiveSizeBytes == archiveSizeBytes)&&(identical(other.archiveSha256, archiveSha256) || other.archiveSha256 == archiveSha256)&&(identical(other.localizations, localizations) || other.localizations == localizations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,publishedAt,minimumAppVersion,archivePath,archiveSizeBytes,archiveSha256,localizations);

@override
String toString() {
  return 'AssetPackDistributionEntry(version: $version, publishedAt: $publishedAt, minimumAppVersion: $minimumAppVersion, archivePath: $archivePath, archiveSizeBytes: $archiveSizeBytes, archiveSha256: $archiveSha256, localizations: $localizations)';
}


}

/// @nodoc
abstract mixin class _$AssetPackDistributionEntryCopyWith<$Res> implements $AssetPackDistributionEntryCopyWith<$Res> {
  factory _$AssetPackDistributionEntryCopyWith(_AssetPackDistributionEntry value, $Res Function(_AssetPackDistributionEntry) _then) = __$AssetPackDistributionEntryCopyWithImpl;
@override @useResult
$Res call({
 String version, String publishedAt, String minimumAppVersion, String archivePath, int archiveSizeBytes, String archiveSha256, AssetPackChangelogLocalizations localizations
});


@override $AssetPackChangelogLocalizationsCopyWith<$Res> get localizations;

}
/// @nodoc
class __$AssetPackDistributionEntryCopyWithImpl<$Res>
    implements _$AssetPackDistributionEntryCopyWith<$Res> {
  __$AssetPackDistributionEntryCopyWithImpl(this._self, this._then);

  final _AssetPackDistributionEntry _self;
  final $Res Function(_AssetPackDistributionEntry) _then;

/// Create a copy of AssetPackDistributionEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? publishedAt = null,Object? minimumAppVersion = null,Object? archivePath = null,Object? archiveSizeBytes = null,Object? archiveSha256 = null,Object? localizations = null,}) {
  return _then(_AssetPackDistributionEntry(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,minimumAppVersion: null == minimumAppVersion ? _self.minimumAppVersion : minimumAppVersion // ignore: cast_nullable_to_non_nullable
as String,archivePath: null == archivePath ? _self.archivePath : archivePath // ignore: cast_nullable_to_non_nullable
as String,archiveSizeBytes: null == archiveSizeBytes ? _self.archiveSizeBytes : archiveSizeBytes // ignore: cast_nullable_to_non_nullable
as int,archiveSha256: null == archiveSha256 ? _self.archiveSha256 : archiveSha256 // ignore: cast_nullable_to_non_nullable
as String,localizations: null == localizations ? _self.localizations : localizations // ignore: cast_nullable_to_non_nullable
as AssetPackChangelogLocalizations,
  ));
}

/// Create a copy of AssetPackDistributionEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetPackChangelogLocalizationsCopyWith<$Res> get localizations {
  
  return $AssetPackChangelogLocalizationsCopyWith<$Res>(_self.localizations, (value) {
    return _then(_self.copyWith(localizations: value));
  });
}
}


/// @nodoc
mixin _$AssetPackChangelogLocalizations {

 AssetPackChangelogLocalization get ja; AssetPackChangelogLocalization get en;
/// Create a copy of AssetPackChangelogLocalizations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetPackChangelogLocalizationsCopyWith<AssetPackChangelogLocalizations> get copyWith => _$AssetPackChangelogLocalizationsCopyWithImpl<AssetPackChangelogLocalizations>(this as AssetPackChangelogLocalizations, _$identity);

  /// Serializes this AssetPackChangelogLocalizations to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetPackChangelogLocalizations&&(identical(other.ja, ja) || other.ja == ja)&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ja,en);

@override
String toString() {
  return 'AssetPackChangelogLocalizations(ja: $ja, en: $en)';
}


}

/// @nodoc
abstract mixin class $AssetPackChangelogLocalizationsCopyWith<$Res>  {
  factory $AssetPackChangelogLocalizationsCopyWith(AssetPackChangelogLocalizations value, $Res Function(AssetPackChangelogLocalizations) _then) = _$AssetPackChangelogLocalizationsCopyWithImpl;
@useResult
$Res call({
 AssetPackChangelogLocalization ja, AssetPackChangelogLocalization en
});


$AssetPackChangelogLocalizationCopyWith<$Res> get ja;$AssetPackChangelogLocalizationCopyWith<$Res> get en;

}
/// @nodoc
class _$AssetPackChangelogLocalizationsCopyWithImpl<$Res>
    implements $AssetPackChangelogLocalizationsCopyWith<$Res> {
  _$AssetPackChangelogLocalizationsCopyWithImpl(this._self, this._then);

  final AssetPackChangelogLocalizations _self;
  final $Res Function(AssetPackChangelogLocalizations) _then;

/// Create a copy of AssetPackChangelogLocalizations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ja = null,Object? en = null,}) {
  return _then(AssetPackChangelogLocalizations(
ja: null == ja ? _self.ja : ja // ignore: cast_nullable_to_non_nullable
as AssetPackChangelogLocalization,en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as AssetPackChangelogLocalization,
  ));
}
/// Create a copy of AssetPackChangelogLocalizations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetPackChangelogLocalizationCopyWith<$Res> get ja {
  
  return $AssetPackChangelogLocalizationCopyWith<$Res>(_self.ja, (value) {
    return _then(_self.copyWith(ja: value));
  });
}/// Create a copy of AssetPackChangelogLocalizations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetPackChangelogLocalizationCopyWith<$Res> get en {
  
  return $AssetPackChangelogLocalizationCopyWith<$Res>(_self.en, (value) {
    return _then(_self.copyWith(en: value));
  });
}
}


/// Adds pattern-matching-related methods to [AssetPackChangelogLocalizations].
extension AssetPackChangelogLocalizationsPatterns on AssetPackChangelogLocalizations {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetPackChangelogLocalizations value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetPackChangelogLocalizations() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetPackChangelogLocalizations value)  $default,){
final _that = this;
switch (_that) {
case _AssetPackChangelogLocalizations():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetPackChangelogLocalizations value)?  $default,){
final _that = this;
switch (_that) {
case _AssetPackChangelogLocalizations() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AssetPackChangelogLocalization ja,  AssetPackChangelogLocalization en)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetPackChangelogLocalizations() when $default != null:
return $default(_that.ja,_that.en);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AssetPackChangelogLocalization ja,  AssetPackChangelogLocalization en)  $default,) {final _that = this;
switch (_that) {
case _AssetPackChangelogLocalizations():
return $default(_that.ja,_that.en);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AssetPackChangelogLocalization ja,  AssetPackChangelogLocalization en)?  $default,) {final _that = this;
switch (_that) {
case _AssetPackChangelogLocalizations() when $default != null:
return $default(_that.ja,_that.en);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetPackChangelogLocalizations implements AssetPackChangelogLocalizations {
  const _AssetPackChangelogLocalizations({required this.ja, required this.en});
  factory _AssetPackChangelogLocalizations.fromJson(Map<String, dynamic> json) => _$AssetPackChangelogLocalizationsFromJson(json);

@override final  AssetPackChangelogLocalization ja;
@override final  AssetPackChangelogLocalization en;

/// Create a copy of AssetPackChangelogLocalizations
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetPackChangelogLocalizationsCopyWith<_AssetPackChangelogLocalizations> get copyWith => __$AssetPackChangelogLocalizationsCopyWithImpl<_AssetPackChangelogLocalizations>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetPackChangelogLocalizationsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetPackChangelogLocalizations&&(identical(other.ja, ja) || other.ja == ja)&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ja,en);

@override
String toString() {
  return 'AssetPackChangelogLocalizations(ja: $ja, en: $en)';
}


}

/// @nodoc
abstract mixin class _$AssetPackChangelogLocalizationsCopyWith<$Res> implements $AssetPackChangelogLocalizationsCopyWith<$Res> {
  factory _$AssetPackChangelogLocalizationsCopyWith(_AssetPackChangelogLocalizations value, $Res Function(_AssetPackChangelogLocalizations) _then) = __$AssetPackChangelogLocalizationsCopyWithImpl;
@override @useResult
$Res call({
 AssetPackChangelogLocalization ja, AssetPackChangelogLocalization en
});


@override $AssetPackChangelogLocalizationCopyWith<$Res> get ja;@override $AssetPackChangelogLocalizationCopyWith<$Res> get en;

}
/// @nodoc
class __$AssetPackChangelogLocalizationsCopyWithImpl<$Res>
    implements _$AssetPackChangelogLocalizationsCopyWith<$Res> {
  __$AssetPackChangelogLocalizationsCopyWithImpl(this._self, this._then);

  final _AssetPackChangelogLocalizations _self;
  final $Res Function(_AssetPackChangelogLocalizations) _then;

/// Create a copy of AssetPackChangelogLocalizations
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ja = null,Object? en = null,}) {
  return _then(_AssetPackChangelogLocalizations(
ja: null == ja ? _self.ja : ja // ignore: cast_nullable_to_non_nullable
as AssetPackChangelogLocalization,en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as AssetPackChangelogLocalization,
  ));
}

/// Create a copy of AssetPackChangelogLocalizations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetPackChangelogLocalizationCopyWith<$Res> get ja {
  
  return $AssetPackChangelogLocalizationCopyWith<$Res>(_self.ja, (value) {
    return _then(_self.copyWith(ja: value));
  });
}/// Create a copy of AssetPackChangelogLocalizations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetPackChangelogLocalizationCopyWith<$Res> get en {
  
  return $AssetPackChangelogLocalizationCopyWith<$Res>(_self.en, (value) {
    return _then(_self.copyWith(en: value));
  });
}
}


/// @nodoc
mixin _$AssetPackChangelogLocalization {

 List<AssetPackChangelogSection> get sections;
/// Create a copy of AssetPackChangelogLocalization
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetPackChangelogLocalizationCopyWith<AssetPackChangelogLocalization> get copyWith => _$AssetPackChangelogLocalizationCopyWithImpl<AssetPackChangelogLocalization>(this as AssetPackChangelogLocalization, _$identity);

  /// Serializes this AssetPackChangelogLocalization to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetPackChangelogLocalization&&const DeepCollectionEquality().equals(other.sections, sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sections));

@override
String toString() {
  return 'AssetPackChangelogLocalization(sections: $sections)';
}


}

/// @nodoc
abstract mixin class $AssetPackChangelogLocalizationCopyWith<$Res>  {
  factory $AssetPackChangelogLocalizationCopyWith(AssetPackChangelogLocalization value, $Res Function(AssetPackChangelogLocalization) _then) = _$AssetPackChangelogLocalizationCopyWithImpl;
@useResult
$Res call({
 List<AssetPackChangelogSection> sections
});




}
/// @nodoc
class _$AssetPackChangelogLocalizationCopyWithImpl<$Res>
    implements $AssetPackChangelogLocalizationCopyWith<$Res> {
  _$AssetPackChangelogLocalizationCopyWithImpl(this._self, this._then);

  final AssetPackChangelogLocalization _self;
  final $Res Function(AssetPackChangelogLocalization) _then;

/// Create a copy of AssetPackChangelogLocalization
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sections = null,}) {
  return _then(AssetPackChangelogLocalization(
sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<AssetPackChangelogSection>,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetPackChangelogLocalization].
extension AssetPackChangelogLocalizationPatterns on AssetPackChangelogLocalization {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetPackChangelogLocalization value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetPackChangelogLocalization() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetPackChangelogLocalization value)  $default,){
final _that = this;
switch (_that) {
case _AssetPackChangelogLocalization():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetPackChangelogLocalization value)?  $default,){
final _that = this;
switch (_that) {
case _AssetPackChangelogLocalization() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AssetPackChangelogSection> sections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetPackChangelogLocalization() when $default != null:
return $default(_that.sections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AssetPackChangelogSection> sections)  $default,) {final _that = this;
switch (_that) {
case _AssetPackChangelogLocalization():
return $default(_that.sections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AssetPackChangelogSection> sections)?  $default,) {final _that = this;
switch (_that) {
case _AssetPackChangelogLocalization() when $default != null:
return $default(_that.sections);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetPackChangelogLocalization implements AssetPackChangelogLocalization {
  const _AssetPackChangelogLocalization({required  List<AssetPackChangelogSection> sections}): _sections = sections;
  factory _AssetPackChangelogLocalization.fromJson(Map<String, dynamic> json) => _$AssetPackChangelogLocalizationFromJson(json);

 final  List<AssetPackChangelogSection> _sections;
@override List<AssetPackChangelogSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}


/// Create a copy of AssetPackChangelogLocalization
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetPackChangelogLocalizationCopyWith<_AssetPackChangelogLocalization> get copyWith => __$AssetPackChangelogLocalizationCopyWithImpl<_AssetPackChangelogLocalization>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetPackChangelogLocalizationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetPackChangelogLocalization&&const DeepCollectionEquality().equals(other._sections, _sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sections));

@override
String toString() {
  return 'AssetPackChangelogLocalization(sections: $sections)';
}


}

/// @nodoc
abstract mixin class _$AssetPackChangelogLocalizationCopyWith<$Res> implements $AssetPackChangelogLocalizationCopyWith<$Res> {
  factory _$AssetPackChangelogLocalizationCopyWith(_AssetPackChangelogLocalization value, $Res Function(_AssetPackChangelogLocalization) _then) = __$AssetPackChangelogLocalizationCopyWithImpl;
@override @useResult
$Res call({
 List<AssetPackChangelogSection> sections
});




}
/// @nodoc
class __$AssetPackChangelogLocalizationCopyWithImpl<$Res>
    implements _$AssetPackChangelogLocalizationCopyWith<$Res> {
  __$AssetPackChangelogLocalizationCopyWithImpl(this._self, this._then);

  final _AssetPackChangelogLocalization _self;
  final $Res Function(_AssetPackChangelogLocalization) _then;

/// Create a copy of AssetPackChangelogLocalization
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sections = null,}) {
  return _then(_AssetPackChangelogLocalization(
sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<AssetPackChangelogSection>,
  ));
}


}


/// @nodoc
mixin _$AssetPackChangelogSection {

 String get title; List<String> get items;
/// Create a copy of AssetPackChangelogSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetPackChangelogSectionCopyWith<AssetPackChangelogSection> get copyWith => _$AssetPackChangelogSectionCopyWithImpl<AssetPackChangelogSection>(this as AssetPackChangelogSection, _$identity);

  /// Serializes this AssetPackChangelogSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetPackChangelogSection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'AssetPackChangelogSection(title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class $AssetPackChangelogSectionCopyWith<$Res>  {
  factory $AssetPackChangelogSectionCopyWith(AssetPackChangelogSection value, $Res Function(AssetPackChangelogSection) _then) = _$AssetPackChangelogSectionCopyWithImpl;
@useResult
$Res call({
 String title, List<String> items
});




}
/// @nodoc
class _$AssetPackChangelogSectionCopyWithImpl<$Res>
    implements $AssetPackChangelogSectionCopyWith<$Res> {
  _$AssetPackChangelogSectionCopyWithImpl(this._self, this._then);

  final AssetPackChangelogSection _self;
  final $Res Function(AssetPackChangelogSection) _then;

/// Create a copy of AssetPackChangelogSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? items = null,}) {
  return _then(AssetPackChangelogSection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetPackChangelogSection].
extension AssetPackChangelogSectionPatterns on AssetPackChangelogSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetPackChangelogSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetPackChangelogSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetPackChangelogSection value)  $default,){
final _that = this;
switch (_that) {
case _AssetPackChangelogSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetPackChangelogSection value)?  $default,){
final _that = this;
switch (_that) {
case _AssetPackChangelogSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<String> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetPackChangelogSection() when $default != null:
return $default(_that.title,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<String> items)  $default,) {final _that = this;
switch (_that) {
case _AssetPackChangelogSection():
return $default(_that.title,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<String> items)?  $default,) {final _that = this;
switch (_that) {
case _AssetPackChangelogSection() when $default != null:
return $default(_that.title,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetPackChangelogSection implements AssetPackChangelogSection {
  const _AssetPackChangelogSection({required this.title, required  List<String> items}): _items = items;
  factory _AssetPackChangelogSection.fromJson(Map<String, dynamic> json) => _$AssetPackChangelogSectionFromJson(json);

@override final  String title;
 final  List<String> _items;
@override List<String> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of AssetPackChangelogSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetPackChangelogSectionCopyWith<_AssetPackChangelogSection> get copyWith => __$AssetPackChangelogSectionCopyWithImpl<_AssetPackChangelogSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetPackChangelogSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetPackChangelogSection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'AssetPackChangelogSection(title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class _$AssetPackChangelogSectionCopyWith<$Res> implements $AssetPackChangelogSectionCopyWith<$Res> {
  factory _$AssetPackChangelogSectionCopyWith(_AssetPackChangelogSection value, $Res Function(_AssetPackChangelogSection) _then) = __$AssetPackChangelogSectionCopyWithImpl;
@override @useResult
$Res call({
 String title, List<String> items
});




}
/// @nodoc
class __$AssetPackChangelogSectionCopyWithImpl<$Res>
    implements _$AssetPackChangelogSectionCopyWith<$Res> {
  __$AssetPackChangelogSectionCopyWithImpl(this._self, this._then);

  final _AssetPackChangelogSection _self;
  final $Res Function(_AssetPackChangelogSection) _then;

/// Create a copy of AssetPackChangelogSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? items = null,}) {
  return _then(_AssetPackChangelogSection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
