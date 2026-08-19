// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pmtiles_v3_directory_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PmTilesV3DirectoryEntry {

 int get tileId; int get offset; int get length; int get runLength;
/// Create a copy of PmTilesV3DirectoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PmTilesV3DirectoryEntryCopyWith<PmTilesV3DirectoryEntry> get copyWith => _$PmTilesV3DirectoryEntryCopyWithImpl<PmTilesV3DirectoryEntry>(this as PmTilesV3DirectoryEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmTilesV3DirectoryEntry&&(identical(other.tileId, tileId) || other.tileId == tileId)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.length, length) || other.length == length)&&(identical(other.runLength, runLength) || other.runLength == runLength));
}


@override
int get hashCode => Object.hash(runtimeType,tileId,offset,length,runLength);

@override
String toString() {
  return 'PmTilesV3DirectoryEntry(tileId: $tileId, offset: $offset, length: $length, runLength: $runLength)';
}


}

/// @nodoc
abstract mixin class $PmTilesV3DirectoryEntryCopyWith<$Res>  {
  factory $PmTilesV3DirectoryEntryCopyWith(PmTilesV3DirectoryEntry value, $Res Function(PmTilesV3DirectoryEntry) _then) = _$PmTilesV3DirectoryEntryCopyWithImpl;
@useResult
$Res call({
 int tileId, int offset, int length, int runLength
});




}
/// @nodoc
class _$PmTilesV3DirectoryEntryCopyWithImpl<$Res>
    implements $PmTilesV3DirectoryEntryCopyWith<$Res> {
  _$PmTilesV3DirectoryEntryCopyWithImpl(this._self, this._then);

  final PmTilesV3DirectoryEntry _self;
  final $Res Function(PmTilesV3DirectoryEntry) _then;

/// Create a copy of PmTilesV3DirectoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tileId = null,Object? offset = null,Object? length = null,Object? runLength = null,}) {
  return _then(PmTilesV3DirectoryEntry(
tileId: null == tileId ? _self.tileId : tileId // ignore: cast_nullable_to_non_nullable
as int,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,runLength: null == runLength ? _self.runLength : runLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PmTilesV3DirectoryEntry].
extension PmTilesV3DirectoryEntryPatterns on PmTilesV3DirectoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PmTilesV3DirectoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PmTilesV3DirectoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PmTilesV3DirectoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _PmTilesV3DirectoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PmTilesV3DirectoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _PmTilesV3DirectoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int tileId,  int offset,  int length,  int runLength)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PmTilesV3DirectoryEntry() when $default != null:
return $default(_that.tileId,_that.offset,_that.length,_that.runLength);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int tileId,  int offset,  int length,  int runLength)  $default,) {final _that = this;
switch (_that) {
case _PmTilesV3DirectoryEntry():
return $default(_that.tileId,_that.offset,_that.length,_that.runLength);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int tileId,  int offset,  int length,  int runLength)?  $default,) {final _that = this;
switch (_that) {
case _PmTilesV3DirectoryEntry() when $default != null:
return $default(_that.tileId,_that.offset,_that.length,_that.runLength);case _:
  return null;

}
}

}

/// @nodoc


class _PmTilesV3DirectoryEntry implements PmTilesV3DirectoryEntry {
  const _PmTilesV3DirectoryEntry({required this.tileId, required this.offset, required this.length, required this.runLength});
  

@override final  int tileId;
@override final  int offset;
@override final  int length;
@override final  int runLength;

/// Create a copy of PmTilesV3DirectoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PmTilesV3DirectoryEntryCopyWith<_PmTilesV3DirectoryEntry> get copyWith => __$PmTilesV3DirectoryEntryCopyWithImpl<_PmTilesV3DirectoryEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PmTilesV3DirectoryEntry&&(identical(other.tileId, tileId) || other.tileId == tileId)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.length, length) || other.length == length)&&(identical(other.runLength, runLength) || other.runLength == runLength));
}


@override
int get hashCode => Object.hash(runtimeType,tileId,offset,length,runLength);

@override
String toString() {
  return 'PmTilesV3DirectoryEntry(tileId: $tileId, offset: $offset, length: $length, runLength: $runLength)';
}


}

/// @nodoc
abstract mixin class _$PmTilesV3DirectoryEntryCopyWith<$Res> implements $PmTilesV3DirectoryEntryCopyWith<$Res> {
  factory _$PmTilesV3DirectoryEntryCopyWith(_PmTilesV3DirectoryEntry value, $Res Function(_PmTilesV3DirectoryEntry) _then) = __$PmTilesV3DirectoryEntryCopyWithImpl;
@override @useResult
$Res call({
 int tileId, int offset, int length, int runLength
});




}
/// @nodoc
class __$PmTilesV3DirectoryEntryCopyWithImpl<$Res>
    implements _$PmTilesV3DirectoryEntryCopyWith<$Res> {
  __$PmTilesV3DirectoryEntryCopyWithImpl(this._self, this._then);

  final _PmTilesV3DirectoryEntry _self;
  final $Res Function(_PmTilesV3DirectoryEntry) _then;

/// Create a copy of PmTilesV3DirectoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tileId = null,Object? offset = null,Object? length = null,Object? runLength = null,}) {
  return _then(_PmTilesV3DirectoryEntry(
tileId: null == tileId ? _self.tileId : tileId // ignore: cast_nullable_to_non_nullable
as int,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,runLength: null == runLength ? _self.runLength : runLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
