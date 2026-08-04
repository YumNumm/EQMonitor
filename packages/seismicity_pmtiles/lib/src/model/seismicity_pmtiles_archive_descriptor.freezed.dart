// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_pmtiles_archive_descriptor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeismicityPmTilesArchiveDescriptor {

 SeismicityPmTilesSource get source; int get schemaVersion; int get dataZoom; int get expectedSizeBytes; int get expectedFeatureCount; String get archiveRevision; DateTime get periodFrom; DateTime get periodTo;
/// Create a copy of SeismicityPmTilesArchiveDescriptor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesArchiveDescriptorCopyWith<SeismicityPmTilesArchiveDescriptor> get copyWith => _$SeismicityPmTilesArchiveDescriptorCopyWithImpl<SeismicityPmTilesArchiveDescriptor>(this as SeismicityPmTilesArchiveDescriptor, _$identity);

  /// Serializes this SeismicityPmTilesArchiveDescriptor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesArchiveDescriptor&&(identical(other.source, source) || other.source == source)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.dataZoom, dataZoom) || other.dataZoom == dataZoom)&&(identical(other.expectedSizeBytes, expectedSizeBytes) || other.expectedSizeBytes == expectedSizeBytes)&&(identical(other.expectedFeatureCount, expectedFeatureCount) || other.expectedFeatureCount == expectedFeatureCount)&&(identical(other.archiveRevision, archiveRevision) || other.archiveRevision == archiveRevision)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.periodTo, periodTo) || other.periodTo == periodTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,schemaVersion,dataZoom,expectedSizeBytes,expectedFeatureCount,archiveRevision,periodFrom,periodTo);

@override
String toString() {
  return 'SeismicityPmTilesArchiveDescriptor(source: $source, schemaVersion: $schemaVersion, dataZoom: $dataZoom, expectedSizeBytes: $expectedSizeBytes, expectedFeatureCount: $expectedFeatureCount, archiveRevision: $archiveRevision, periodFrom: $periodFrom, periodTo: $periodTo)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesArchiveDescriptorCopyWith<$Res>  {
  factory $SeismicityPmTilesArchiveDescriptorCopyWith(SeismicityPmTilesArchiveDescriptor value, $Res Function(SeismicityPmTilesArchiveDescriptor) _then) = _$SeismicityPmTilesArchiveDescriptorCopyWithImpl;
@useResult
$Res call({
 SeismicityPmTilesSource source, int schemaVersion, int dataZoom, int expectedSizeBytes, int expectedFeatureCount, String archiveRevision, DateTime periodFrom, DateTime periodTo
});


$SeismicityPmTilesSourceCopyWith<$Res> get source;

}
/// @nodoc
class _$SeismicityPmTilesArchiveDescriptorCopyWithImpl<$Res>
    implements $SeismicityPmTilesArchiveDescriptorCopyWith<$Res> {
  _$SeismicityPmTilesArchiveDescriptorCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesArchiveDescriptor _self;
  final $Res Function(SeismicityPmTilesArchiveDescriptor) _then;

/// Create a copy of SeismicityPmTilesArchiveDescriptor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? schemaVersion = null,Object? dataZoom = null,Object? expectedSizeBytes = null,Object? expectedFeatureCount = null,Object? archiveRevision = null,Object? periodFrom = null,Object? periodTo = null,}) {
  return _then(_self.copyWith(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as SeismicityPmTilesSource,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,dataZoom: null == dataZoom ? _self.dataZoom : dataZoom // ignore: cast_nullable_to_non_nullable
as int,expectedSizeBytes: null == expectedSizeBytes ? _self.expectedSizeBytes : expectedSizeBytes // ignore: cast_nullable_to_non_nullable
as int,expectedFeatureCount: null == expectedFeatureCount ? _self.expectedFeatureCount : expectedFeatureCount // ignore: cast_nullable_to_non_nullable
as int,archiveRevision: null == archiveRevision ? _self.archiveRevision : archiveRevision // ignore: cast_nullable_to_non_nullable
as String,periodFrom: null == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as DateTime,periodTo: null == periodTo ? _self.periodTo : periodTo // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of SeismicityPmTilesArchiveDescriptor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeismicityPmTilesSourceCopyWith<$Res> get source {
  
  return $SeismicityPmTilesSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeismicityPmTilesArchiveDescriptor].
extension SeismicityPmTilesArchiveDescriptorPatterns on SeismicityPmTilesArchiveDescriptor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityPmTilesArchiveDescriptor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityPmTilesArchiveDescriptor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityPmTilesArchiveDescriptor value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityPmTilesArchiveDescriptor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityPmTilesArchiveDescriptor value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityPmTilesArchiveDescriptor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SeismicityPmTilesSource source,  int schemaVersion,  int dataZoom,  int expectedSizeBytes,  int expectedFeatureCount,  String archiveRevision,  DateTime periodFrom,  DateTime periodTo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityPmTilesArchiveDescriptor() when $default != null:
return $default(_that.source,_that.schemaVersion,_that.dataZoom,_that.expectedSizeBytes,_that.expectedFeatureCount,_that.archiveRevision,_that.periodFrom,_that.periodTo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SeismicityPmTilesSource source,  int schemaVersion,  int dataZoom,  int expectedSizeBytes,  int expectedFeatureCount,  String archiveRevision,  DateTime periodFrom,  DateTime periodTo)  $default,) {final _that = this;
switch (_that) {
case _SeismicityPmTilesArchiveDescriptor():
return $default(_that.source,_that.schemaVersion,_that.dataZoom,_that.expectedSizeBytes,_that.expectedFeatureCount,_that.archiveRevision,_that.periodFrom,_that.periodTo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SeismicityPmTilesSource source,  int schemaVersion,  int dataZoom,  int expectedSizeBytes,  int expectedFeatureCount,  String archiveRevision,  DateTime periodFrom,  DateTime periodTo)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityPmTilesArchiveDescriptor() when $default != null:
return $default(_that.source,_that.schemaVersion,_that.dataZoom,_that.expectedSizeBytes,_that.expectedFeatureCount,_that.archiveRevision,_that.periodFrom,_that.periodTo);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SeismicityPmTilesArchiveDescriptor implements SeismicityPmTilesArchiveDescriptor {
  const _SeismicityPmTilesArchiveDescriptor({required this.source, required this.schemaVersion, required this.dataZoom, required this.expectedSizeBytes, required this.expectedFeatureCount, required this.archiveRevision, required this.periodFrom, required this.periodTo});
  factory _SeismicityPmTilesArchiveDescriptor.fromJson(Map<String, dynamic> json) => _$SeismicityPmTilesArchiveDescriptorFromJson(json);

@override final  SeismicityPmTilesSource source;
@override final  int schemaVersion;
@override final  int dataZoom;
@override final  int expectedSizeBytes;
@override final  int expectedFeatureCount;
@override final  String archiveRevision;
@override final  DateTime periodFrom;
@override final  DateTime periodTo;

/// Create a copy of SeismicityPmTilesArchiveDescriptor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityPmTilesArchiveDescriptorCopyWith<_SeismicityPmTilesArchiveDescriptor> get copyWith => __$SeismicityPmTilesArchiveDescriptorCopyWithImpl<_SeismicityPmTilesArchiveDescriptor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeismicityPmTilesArchiveDescriptorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityPmTilesArchiveDescriptor&&(identical(other.source, source) || other.source == source)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.dataZoom, dataZoom) || other.dataZoom == dataZoom)&&(identical(other.expectedSizeBytes, expectedSizeBytes) || other.expectedSizeBytes == expectedSizeBytes)&&(identical(other.expectedFeatureCount, expectedFeatureCount) || other.expectedFeatureCount == expectedFeatureCount)&&(identical(other.archiveRevision, archiveRevision) || other.archiveRevision == archiveRevision)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.periodTo, periodTo) || other.periodTo == periodTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,schemaVersion,dataZoom,expectedSizeBytes,expectedFeatureCount,archiveRevision,periodFrom,periodTo);

@override
String toString() {
  return 'SeismicityPmTilesArchiveDescriptor(source: $source, schemaVersion: $schemaVersion, dataZoom: $dataZoom, expectedSizeBytes: $expectedSizeBytes, expectedFeatureCount: $expectedFeatureCount, archiveRevision: $archiveRevision, periodFrom: $periodFrom, periodTo: $periodTo)';
}


}

/// @nodoc
abstract mixin class _$SeismicityPmTilesArchiveDescriptorCopyWith<$Res> implements $SeismicityPmTilesArchiveDescriptorCopyWith<$Res> {
  factory _$SeismicityPmTilesArchiveDescriptorCopyWith(_SeismicityPmTilesArchiveDescriptor value, $Res Function(_SeismicityPmTilesArchiveDescriptor) _then) = __$SeismicityPmTilesArchiveDescriptorCopyWithImpl;
@override @useResult
$Res call({
 SeismicityPmTilesSource source, int schemaVersion, int dataZoom, int expectedSizeBytes, int expectedFeatureCount, String archiveRevision, DateTime periodFrom, DateTime periodTo
});


@override $SeismicityPmTilesSourceCopyWith<$Res> get source;

}
/// @nodoc
class __$SeismicityPmTilesArchiveDescriptorCopyWithImpl<$Res>
    implements _$SeismicityPmTilesArchiveDescriptorCopyWith<$Res> {
  __$SeismicityPmTilesArchiveDescriptorCopyWithImpl(this._self, this._then);

  final _SeismicityPmTilesArchiveDescriptor _self;
  final $Res Function(_SeismicityPmTilesArchiveDescriptor) _then;

/// Create a copy of SeismicityPmTilesArchiveDescriptor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? schemaVersion = null,Object? dataZoom = null,Object? expectedSizeBytes = null,Object? expectedFeatureCount = null,Object? archiveRevision = null,Object? periodFrom = null,Object? periodTo = null,}) {
  return _then(_SeismicityPmTilesArchiveDescriptor(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as SeismicityPmTilesSource,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,dataZoom: null == dataZoom ? _self.dataZoom : dataZoom // ignore: cast_nullable_to_non_nullable
as int,expectedSizeBytes: null == expectedSizeBytes ? _self.expectedSizeBytes : expectedSizeBytes // ignore: cast_nullable_to_non_nullable
as int,expectedFeatureCount: null == expectedFeatureCount ? _self.expectedFeatureCount : expectedFeatureCount // ignore: cast_nullable_to_non_nullable
as int,archiveRevision: null == archiveRevision ? _self.archiveRevision : archiveRevision // ignore: cast_nullable_to_non_nullable
as String,periodFrom: null == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as DateTime,periodTo: null == periodTo ? _self.periodTo : periodTo // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of SeismicityPmTilesArchiveDescriptor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeismicityPmTilesSourceCopyWith<$Res> get source {
  
  return $SeismicityPmTilesSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}

// dart format on
