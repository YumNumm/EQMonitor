// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_pmtiles_dataset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeismicityPmTilesDataset {

 String get archiveRevision; int get schemaVersion; int get dataZoom; int get featureCount; List<SeismicityPmTilesChunk> get chunks;
/// Create a copy of SeismicityPmTilesDataset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesDatasetCopyWith<SeismicityPmTilesDataset> get copyWith => _$SeismicityPmTilesDatasetCopyWithImpl<SeismicityPmTilesDataset>(this as SeismicityPmTilesDataset, _$identity);





@override
String toString() {
  return 'SeismicityPmTilesDataset(archiveRevision: $archiveRevision, schemaVersion: $schemaVersion, dataZoom: $dataZoom, featureCount: $featureCount, chunks: $chunks)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesDatasetCopyWith<$Res>  {
  factory $SeismicityPmTilesDatasetCopyWith(SeismicityPmTilesDataset value, $Res Function(SeismicityPmTilesDataset) _then) = _$SeismicityPmTilesDatasetCopyWithImpl;
@useResult
$Res call({
 String archiveRevision, int schemaVersion, int dataZoom, int featureCount, List<SeismicityPmTilesChunk> chunks
});




}
/// @nodoc
class _$SeismicityPmTilesDatasetCopyWithImpl<$Res>
    implements $SeismicityPmTilesDatasetCopyWith<$Res> {
  _$SeismicityPmTilesDatasetCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesDataset _self;
  final $Res Function(SeismicityPmTilesDataset) _then;

/// Create a copy of SeismicityPmTilesDataset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? archiveRevision = null,Object? schemaVersion = null,Object? dataZoom = null,Object? featureCount = null,Object? chunks = null,}) {
  return _then(SeismicityPmTilesDataset(
archiveRevision: null == archiveRevision ? _self.archiveRevision : archiveRevision // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,dataZoom: null == dataZoom ? _self.dataZoom : dataZoom // ignore: cast_nullable_to_non_nullable
as int,featureCount: null == featureCount ? _self.featureCount : featureCount // ignore: cast_nullable_to_non_nullable
as int,chunks: null == chunks ? _self.chunks : chunks // ignore: cast_nullable_to_non_nullable
as List<SeismicityPmTilesChunk>,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityPmTilesDataset].
extension SeismicityPmTilesDatasetPatterns on SeismicityPmTilesDataset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityPmTilesDataset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityPmTilesDataset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityPmTilesDataset value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityPmTilesDataset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityPmTilesDataset value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityPmTilesDataset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String archiveRevision,  int schemaVersion,  int dataZoom,  int featureCount,  List<SeismicityPmTilesChunk> chunks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityPmTilesDataset() when $default != null:
return $default(_that.archiveRevision,_that.schemaVersion,_that.dataZoom,_that.featureCount,_that.chunks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String archiveRevision,  int schemaVersion,  int dataZoom,  int featureCount,  List<SeismicityPmTilesChunk> chunks)  $default,) {final _that = this;
switch (_that) {
case _SeismicityPmTilesDataset():
return $default(_that.archiveRevision,_that.schemaVersion,_that.dataZoom,_that.featureCount,_that.chunks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String archiveRevision,  int schemaVersion,  int dataZoom,  int featureCount,  List<SeismicityPmTilesChunk> chunks)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityPmTilesDataset() when $default != null:
return $default(_that.archiveRevision,_that.schemaVersion,_that.dataZoom,_that.featureCount,_that.chunks);case _:
  return null;

}
}

}

/// @nodoc


class _SeismicityPmTilesDataset implements SeismicityPmTilesDataset {
  const _SeismicityPmTilesDataset({required this.archiveRevision, required this.schemaVersion, required this.dataZoom, required this.featureCount, required  List<SeismicityPmTilesChunk> chunks}): _chunks = chunks;
  

@override final  String archiveRevision;
@override final  int schemaVersion;
@override final  int dataZoom;
@override final  int featureCount;
 final  List<SeismicityPmTilesChunk> _chunks;
@override List<SeismicityPmTilesChunk> get chunks {
  if (_chunks is EqualUnmodifiableListView) return _chunks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chunks);
}


/// Create a copy of SeismicityPmTilesDataset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityPmTilesDatasetCopyWith<_SeismicityPmTilesDataset> get copyWith => __$SeismicityPmTilesDatasetCopyWithImpl<_SeismicityPmTilesDataset>(this, _$identity);





@override
String toString() {
  return 'SeismicityPmTilesDataset(archiveRevision: $archiveRevision, schemaVersion: $schemaVersion, dataZoom: $dataZoom, featureCount: $featureCount, chunks: $chunks)';
}


}

/// @nodoc
abstract mixin class _$SeismicityPmTilesDatasetCopyWith<$Res> implements $SeismicityPmTilesDatasetCopyWith<$Res> {
  factory _$SeismicityPmTilesDatasetCopyWith(_SeismicityPmTilesDataset value, $Res Function(_SeismicityPmTilesDataset) _then) = __$SeismicityPmTilesDatasetCopyWithImpl;
@override @useResult
$Res call({
 String archiveRevision, int schemaVersion, int dataZoom, int featureCount, List<SeismicityPmTilesChunk> chunks
});




}
/// @nodoc
class __$SeismicityPmTilesDatasetCopyWithImpl<$Res>
    implements _$SeismicityPmTilesDatasetCopyWith<$Res> {
  __$SeismicityPmTilesDatasetCopyWithImpl(this._self, this._then);

  final _SeismicityPmTilesDataset _self;
  final $Res Function(_SeismicityPmTilesDataset) _then;

/// Create a copy of SeismicityPmTilesDataset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? archiveRevision = null,Object? schemaVersion = null,Object? dataZoom = null,Object? featureCount = null,Object? chunks = null,}) {
  return _then(_SeismicityPmTilesDataset(
archiveRevision: null == archiveRevision ? _self.archiveRevision : archiveRevision // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,dataZoom: null == dataZoom ? _self.dataZoom : dataZoom // ignore: cast_nullable_to_non_nullable
as int,featureCount: null == featureCount ? _self.featureCount : featureCount // ignore: cast_nullable_to_non_nullable
as int,chunks: null == chunks ? _self._chunks : chunks // ignore: cast_nullable_to_non_nullable
as List<SeismicityPmTilesChunk>,
  ));
}


}

// dart format on
