// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_archive.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HypocenterArchive {

 HypocenterArchiveId get id; DateTime get periodFrom; DateTime get periodTo; String get url; int get featureCount; int get sizeBytes; String get queryRevision;
/// Create a copy of HypocenterArchive
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterArchiveCopyWith<HypocenterArchive> get copyWith => _$HypocenterArchiveCopyWithImpl<HypocenterArchive>(this as HypocenterArchive, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterArchive&&(identical(other.id, id) || other.id == id)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.periodTo, periodTo) || other.periodTo == periodTo)&&(identical(other.url, url) || other.url == url)&&(identical(other.featureCount, featureCount) || other.featureCount == featureCount)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.queryRevision, queryRevision) || other.queryRevision == queryRevision));
}


@override
int get hashCode => Object.hash(runtimeType,id,periodFrom,periodTo,url,featureCount,sizeBytes,queryRevision);

@override
String toString() {
  return 'HypocenterArchive(id: $id, periodFrom: $periodFrom, periodTo: $periodTo, url: $url, featureCount: $featureCount, sizeBytes: $sizeBytes, queryRevision: $queryRevision)';
}


}

/// @nodoc
abstract mixin class $HypocenterArchiveCopyWith<$Res>  {
  factory $HypocenterArchiveCopyWith(HypocenterArchive value, $Res Function(HypocenterArchive) _then) = _$HypocenterArchiveCopyWithImpl;
@useResult
$Res call({
 HypocenterArchiveId id, DateTime periodFrom, DateTime periodTo, String url, int featureCount, int sizeBytes, String queryRevision
});


$HypocenterArchiveIdCopyWith<$Res> get id;

}
/// @nodoc
class _$HypocenterArchiveCopyWithImpl<$Res>
    implements $HypocenterArchiveCopyWith<$Res> {
  _$HypocenterArchiveCopyWithImpl(this._self, this._then);

  final HypocenterArchive _self;
  final $Res Function(HypocenterArchive) _then;

/// Create a copy of HypocenterArchive
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? periodFrom = null,Object? periodTo = null,Object? url = null,Object? featureCount = null,Object? sizeBytes = null,Object? queryRevision = null,}) {
  return _then(HypocenterArchive(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as HypocenterArchiveId,periodFrom: null == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as DateTime,periodTo: null == periodTo ? _self.periodTo : periodTo // ignore: cast_nullable_to_non_nullable
as DateTime,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,featureCount: null == featureCount ? _self.featureCount : featureCount // ignore: cast_nullable_to_non_nullable
as int,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,queryRevision: null == queryRevision ? _self.queryRevision : queryRevision // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of HypocenterArchive
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterArchiveIdCopyWith<$Res> get id {
  
  return $HypocenterArchiveIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}
}


/// Adds pattern-matching-related methods to [HypocenterArchive].
extension HypocenterArchivePatterns on HypocenterArchive {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterArchive value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterArchive() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterArchive value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterArchive():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterArchive value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterArchive() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HypocenterArchiveId id,  DateTime periodFrom,  DateTime periodTo,  String url,  int featureCount,  int sizeBytes,  String queryRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterArchive() when $default != null:
return $default(_that.id,_that.periodFrom,_that.periodTo,_that.url,_that.featureCount,_that.sizeBytes,_that.queryRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HypocenterArchiveId id,  DateTime periodFrom,  DateTime periodTo,  String url,  int featureCount,  int sizeBytes,  String queryRevision)  $default,) {final _that = this;
switch (_that) {
case _HypocenterArchive():
return $default(_that.id,_that.periodFrom,_that.periodTo,_that.url,_that.featureCount,_that.sizeBytes,_that.queryRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HypocenterArchiveId id,  DateTime periodFrom,  DateTime periodTo,  String url,  int featureCount,  int sizeBytes,  String queryRevision)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterArchive() when $default != null:
return $default(_that.id,_that.periodFrom,_that.periodTo,_that.url,_that.featureCount,_that.sizeBytes,_that.queryRevision);case _:
  return null;

}
}

}

/// @nodoc


class _HypocenterArchive implements HypocenterArchive {
  const _HypocenterArchive({required this.id, required this.periodFrom, required this.periodTo, required this.url, required this.featureCount, required this.sizeBytes, required this.queryRevision});
  

@override final  HypocenterArchiveId id;
@override final  DateTime periodFrom;
@override final  DateTime periodTo;
@override final  String url;
@override final  int featureCount;
@override final  int sizeBytes;
@override final  String queryRevision;

/// Create a copy of HypocenterArchive
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterArchiveCopyWith<_HypocenterArchive> get copyWith => __$HypocenterArchiveCopyWithImpl<_HypocenterArchive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterArchive&&(identical(other.id, id) || other.id == id)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.periodTo, periodTo) || other.periodTo == periodTo)&&(identical(other.url, url) || other.url == url)&&(identical(other.featureCount, featureCount) || other.featureCount == featureCount)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.queryRevision, queryRevision) || other.queryRevision == queryRevision));
}


@override
int get hashCode => Object.hash(runtimeType,id,periodFrom,periodTo,url,featureCount,sizeBytes,queryRevision);

@override
String toString() {
  return 'HypocenterArchive(id: $id, periodFrom: $periodFrom, periodTo: $periodTo, url: $url, featureCount: $featureCount, sizeBytes: $sizeBytes, queryRevision: $queryRevision)';
}


}

/// @nodoc
abstract mixin class _$HypocenterArchiveCopyWith<$Res> implements $HypocenterArchiveCopyWith<$Res> {
  factory _$HypocenterArchiveCopyWith(_HypocenterArchive value, $Res Function(_HypocenterArchive) _then) = __$HypocenterArchiveCopyWithImpl;
@override @useResult
$Res call({
 HypocenterArchiveId id, DateTime periodFrom, DateTime periodTo, String url, int featureCount, int sizeBytes, String queryRevision
});


@override $HypocenterArchiveIdCopyWith<$Res> get id;

}
/// @nodoc
class __$HypocenterArchiveCopyWithImpl<$Res>
    implements _$HypocenterArchiveCopyWith<$Res> {
  __$HypocenterArchiveCopyWithImpl(this._self, this._then);

  final _HypocenterArchive _self;
  final $Res Function(_HypocenterArchive) _then;

/// Create a copy of HypocenterArchive
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? periodFrom = null,Object? periodTo = null,Object? url = null,Object? featureCount = null,Object? sizeBytes = null,Object? queryRevision = null,}) {
  return _then(_HypocenterArchive(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as HypocenterArchiveId,periodFrom: null == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as DateTime,periodTo: null == periodTo ? _self.periodTo : periodTo // ignore: cast_nullable_to_non_nullable
as DateTime,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,featureCount: null == featureCount ? _self.featureCount : featureCount // ignore: cast_nullable_to_non_nullable
as int,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,queryRevision: null == queryRevision ? _self.queryRevision : queryRevision // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of HypocenterArchive
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterArchiveIdCopyWith<$Res> get id {
  
  return $HypocenterArchiveIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}
}

// dart format on
