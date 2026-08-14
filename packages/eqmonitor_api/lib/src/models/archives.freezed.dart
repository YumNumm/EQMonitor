// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'archives.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Archives {

 Partition get partition; HypocenterCoverage get period;@JsonKey(name: 'query_revision') String get queryRevision;@JsonKey(name: 'archive_revision') String get archiveRevision; String get url;@JsonKey(name: 'feature_count') int get featureCount;@JsonKey(name: 'size_bytes') int get sizeBytes;/// const: 14
@JsonKey(includeIfNull: false, name: 'data_zoom') int? get dataZoom;@JsonKey(includeIfNull: false) Bounds? get bounds;
/// Create a copy of Archives
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArchivesCopyWith<Archives> get copyWith => _$ArchivesCopyWithImpl<Archives>(this as Archives, _$identity);

  /// Serializes this Archives to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Archives&&(identical(other.partition, partition) || other.partition == partition)&&(identical(other.period, period) || other.period == period)&&(identical(other.queryRevision, queryRevision) || other.queryRevision == queryRevision)&&(identical(other.archiveRevision, archiveRevision) || other.archiveRevision == archiveRevision)&&(identical(other.url, url) || other.url == url)&&(identical(other.featureCount, featureCount) || other.featureCount == featureCount)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.dataZoom, dataZoom) || other.dataZoom == dataZoom)&&(identical(other.bounds, bounds) || other.bounds == bounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,partition,period,queryRevision,archiveRevision,url,featureCount,sizeBytes,dataZoom,bounds);

@override
String toString() {
  return 'Archives(partition: $partition, period: $period, queryRevision: $queryRevision, archiveRevision: $archiveRevision, url: $url, featureCount: $featureCount, sizeBytes: $sizeBytes, dataZoom: $dataZoom, bounds: $bounds)';
}


}

/// @nodoc
abstract mixin class $ArchivesCopyWith<$Res>  {
  factory $ArchivesCopyWith(Archives value, $Res Function(Archives) _then) = _$ArchivesCopyWithImpl;
@useResult
$Res call({
 Partition partition, HypocenterCoverage period,@JsonKey(name: 'query_revision') String queryRevision,@JsonKey(name: 'archive_revision') String archiveRevision, String url,@JsonKey(name: 'feature_count') int featureCount,@JsonKey(name: 'size_bytes') int sizeBytes,@JsonKey(includeIfNull: false, name: 'data_zoom') int? dataZoom,@JsonKey(includeIfNull: false) Bounds? bounds
});


$HypocenterCoverageCopyWith<$Res> get period;$BoundsCopyWith<$Res>? get bounds;

}
/// @nodoc
class _$ArchivesCopyWithImpl<$Res>
    implements $ArchivesCopyWith<$Res> {
  _$ArchivesCopyWithImpl(this._self, this._then);

  final Archives _self;
  final $Res Function(Archives) _then;

/// Create a copy of Archives
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? partition = null,Object? period = null,Object? queryRevision = null,Object? archiveRevision = null,Object? url = null,Object? featureCount = null,Object? sizeBytes = null,Object? dataZoom = freezed,Object? bounds = freezed,}) {
  return _then(Archives(
partition: null == partition ? _self.partition : partition // ignore: cast_nullable_to_non_nullable
as Partition,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as HypocenterCoverage,queryRevision: null == queryRevision ? _self.queryRevision : queryRevision // ignore: cast_nullable_to_non_nullable
as String,archiveRevision: null == archiveRevision ? _self.archiveRevision : archiveRevision // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,featureCount: null == featureCount ? _self.featureCount : featureCount // ignore: cast_nullable_to_non_nullable
as int,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,dataZoom: freezed == dataZoom ? _self.dataZoom : dataZoom // ignore: cast_nullable_to_non_nullable
as int?,bounds: freezed == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as Bounds?,
  ));
}
/// Create a copy of Archives
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCoverageCopyWith<$Res> get period {

  return $HypocenterCoverageCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of Archives
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundsCopyWith<$Res>? get bounds {
    if (_self.bounds == null) {
    return null;
  }

  return $BoundsCopyWith<$Res>(_self.bounds!, (value) {
    return _then(_self.copyWith(bounds: value));
  });
}
}


/// Adds pattern-matching-related methods to [Archives].
extension ArchivesPatterns on Archives {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Archives value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Archives() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Archives value)  $default,){
final _that = this;
switch (_that) {
case _Archives():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Archives value)?  $default,){
final _that = this;
switch (_that) {
case _Archives() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Partition partition,  HypocenterCoverage period, @JsonKey(name: 'query_revision')  String queryRevision, @JsonKey(name: 'archive_revision')  String archiveRevision,  String url, @JsonKey(name: 'feature_count')  int featureCount, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(includeIfNull: false, name: 'data_zoom')  int? dataZoom, @JsonKey(includeIfNull: false)  Bounds? bounds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Archives() when $default != null:
return $default(_that.partition,_that.period,_that.queryRevision,_that.archiveRevision,_that.url,_that.featureCount,_that.sizeBytes,_that.dataZoom,_that.bounds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Partition partition,  HypocenterCoverage period, @JsonKey(name: 'query_revision')  String queryRevision, @JsonKey(name: 'archive_revision')  String archiveRevision,  String url, @JsonKey(name: 'feature_count')  int featureCount, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(includeIfNull: false, name: 'data_zoom')  int? dataZoom, @JsonKey(includeIfNull: false)  Bounds? bounds)  $default,) {final _that = this;
switch (_that) {
case _Archives():
return $default(_that.partition,_that.period,_that.queryRevision,_that.archiveRevision,_that.url,_that.featureCount,_that.sizeBytes,_that.dataZoom,_that.bounds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Partition partition,  HypocenterCoverage period, @JsonKey(name: 'query_revision')  String queryRevision, @JsonKey(name: 'archive_revision')  String archiveRevision,  String url, @JsonKey(name: 'feature_count')  int featureCount, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(includeIfNull: false, name: 'data_zoom')  int? dataZoom, @JsonKey(includeIfNull: false)  Bounds? bounds)?  $default,) {final _that = this;
switch (_that) {
case _Archives() when $default != null:
return $default(_that.partition,_that.period,_that.queryRevision,_that.archiveRevision,_that.url,_that.featureCount,_that.sizeBytes,_that.dataZoom,_that.bounds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Archives implements Archives {
  const _Archives({required this.partition, required this.period, @JsonKey(name: 'query_revision') required this.queryRevision, @JsonKey(name: 'archive_revision') required this.archiveRevision, required this.url, @JsonKey(name: 'feature_count') required this.featureCount, @JsonKey(name: 'size_bytes') required this.sizeBytes, @JsonKey(includeIfNull: false, name: 'data_zoom') this.dataZoom, @JsonKey(includeIfNull: false) this.bounds});
  factory _Archives.fromJson(Map<String, dynamic> json) => _$ArchivesFromJson(json);

@override final  Partition partition;
@override final  HypocenterCoverage period;
@override@JsonKey(name: 'query_revision') final  String queryRevision;
@override@JsonKey(name: 'archive_revision') final  String archiveRevision;
@override final  String url;
@override@JsonKey(name: 'feature_count') final  int featureCount;
@override@JsonKey(name: 'size_bytes') final  int sizeBytes;
/// const: 14
@override@JsonKey(includeIfNull: false, name: 'data_zoom') final  int? dataZoom;
@override@JsonKey(includeIfNull: false) final  Bounds? bounds;

/// Create a copy of Archives
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArchivesCopyWith<_Archives> get copyWith => __$ArchivesCopyWithImpl<_Archives>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArchivesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Archives&&(identical(other.partition, partition) || other.partition == partition)&&(identical(other.period, period) || other.period == period)&&(identical(other.queryRevision, queryRevision) || other.queryRevision == queryRevision)&&(identical(other.archiveRevision, archiveRevision) || other.archiveRevision == archiveRevision)&&(identical(other.url, url) || other.url == url)&&(identical(other.featureCount, featureCount) || other.featureCount == featureCount)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.dataZoom, dataZoom) || other.dataZoom == dataZoom)&&(identical(other.bounds, bounds) || other.bounds == bounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,partition,period,queryRevision,archiveRevision,url,featureCount,sizeBytes,dataZoom,bounds);

@override
String toString() {
  return 'Archives(partition: $partition, period: $period, queryRevision: $queryRevision, archiveRevision: $archiveRevision, url: $url, featureCount: $featureCount, sizeBytes: $sizeBytes, dataZoom: $dataZoom, bounds: $bounds)';
}


}

/// @nodoc
abstract mixin class _$ArchivesCopyWith<$Res> implements $ArchivesCopyWith<$Res> {
  factory _$ArchivesCopyWith(_Archives value, $Res Function(_Archives) _then) = __$ArchivesCopyWithImpl;
@override @useResult
$Res call({
 Partition partition, HypocenterCoverage period,@JsonKey(name: 'query_revision') String queryRevision,@JsonKey(name: 'archive_revision') String archiveRevision, String url,@JsonKey(name: 'feature_count') int featureCount,@JsonKey(name: 'size_bytes') int sizeBytes,@JsonKey(includeIfNull: false, name: 'data_zoom') int? dataZoom,@JsonKey(includeIfNull: false) Bounds? bounds
});


@override $HypocenterCoverageCopyWith<$Res> get period;@override $BoundsCopyWith<$Res>? get bounds;

}
/// @nodoc
class __$ArchivesCopyWithImpl<$Res>
    implements _$ArchivesCopyWith<$Res> {
  __$ArchivesCopyWithImpl(this._self, this._then);

  final _Archives _self;
  final $Res Function(_Archives) _then;

/// Create a copy of Archives
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? partition = null,Object? period = null,Object? queryRevision = null,Object? archiveRevision = null,Object? url = null,Object? featureCount = null,Object? sizeBytes = null,Object? dataZoom = freezed,Object? bounds = freezed,}) {
  return _then(_Archives(
partition: null == partition ? _self.partition : partition // ignore: cast_nullable_to_non_nullable
as Partition,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as HypocenterCoverage,queryRevision: null == queryRevision ? _self.queryRevision : queryRevision // ignore: cast_nullable_to_non_nullable
as String,archiveRevision: null == archiveRevision ? _self.archiveRevision : archiveRevision // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,featureCount: null == featureCount ? _self.featureCount : featureCount // ignore: cast_nullable_to_non_nullable
as int,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,dataZoom: freezed == dataZoom ? _self.dataZoom : dataZoom // ignore: cast_nullable_to_non_nullable
as int?,bounds: freezed == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as Bounds?,
  ));
}

/// Create a copy of Archives
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCoverageCopyWith<$Res> get period {

  return $HypocenterCoverageCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of Archives
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundsCopyWith<$Res>? get bounds {
    if (_self.bounds == null) {
    return null;
  }

  return $BoundsCopyWith<$Res>(_self.bounds!, (value) {
    return _then(_self.copyWith(bounds: value));
  });
}
}

// dart format on
