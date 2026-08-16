// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pmtiles_v3_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PmTilesV3Exception {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmTilesV3Exception);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PmTilesV3Exception()';
}


}

/// @nodoc
class $PmTilesV3ExceptionCopyWith<$Res>  {
$PmTilesV3ExceptionCopyWith(PmTilesV3Exception _, $Res Function(PmTilesV3Exception) __);
}


/// Adds pattern-matching-related methods to [PmTilesV3Exception].
extension PmTilesV3ExceptionPatterns on PmTilesV3Exception {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PmTilesV3InvalidRangeException value)?  invalidRange,TResult Function( PmTilesV3CorruptArchiveException value)?  corruptArchive,TResult Function( PmTilesV3UnsupportedCompressionException value)?  unsupportedCompression,TResult Function( PmTilesV3SourceReadFailedException value)?  sourceReadFailed,TResult Function( PmTilesV3InvalidTileIdException value)?  invalidTileId,TResult Function( PmTilesV3InvalidTileCoordinateException value)?  invalidTileCoordinate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PmTilesV3InvalidRangeException() when invalidRange != null:
return invalidRange(_that);case PmTilesV3CorruptArchiveException() when corruptArchive != null:
return corruptArchive(_that);case PmTilesV3UnsupportedCompressionException() when unsupportedCompression != null:
return unsupportedCompression(_that);case PmTilesV3SourceReadFailedException() when sourceReadFailed != null:
return sourceReadFailed(_that);case PmTilesV3InvalidTileIdException() when invalidTileId != null:
return invalidTileId(_that);case PmTilesV3InvalidTileCoordinateException() when invalidTileCoordinate != null:
return invalidTileCoordinate(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PmTilesV3InvalidRangeException value)  invalidRange,required TResult Function( PmTilesV3CorruptArchiveException value)  corruptArchive,required TResult Function( PmTilesV3UnsupportedCompressionException value)  unsupportedCompression,required TResult Function( PmTilesV3SourceReadFailedException value)  sourceReadFailed,required TResult Function( PmTilesV3InvalidTileIdException value)  invalidTileId,required TResult Function( PmTilesV3InvalidTileCoordinateException value)  invalidTileCoordinate,}){
final _that = this;
switch (_that) {
case PmTilesV3InvalidRangeException():
return invalidRange(_that);case PmTilesV3CorruptArchiveException():
return corruptArchive(_that);case PmTilesV3UnsupportedCompressionException():
return unsupportedCompression(_that);case PmTilesV3SourceReadFailedException():
return sourceReadFailed(_that);case PmTilesV3InvalidTileIdException():
return invalidTileId(_that);case PmTilesV3InvalidTileCoordinateException():
return invalidTileCoordinate(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PmTilesV3InvalidRangeException value)?  invalidRange,TResult? Function( PmTilesV3CorruptArchiveException value)?  corruptArchive,TResult? Function( PmTilesV3UnsupportedCompressionException value)?  unsupportedCompression,TResult? Function( PmTilesV3SourceReadFailedException value)?  sourceReadFailed,TResult? Function( PmTilesV3InvalidTileIdException value)?  invalidTileId,TResult? Function( PmTilesV3InvalidTileCoordinateException value)?  invalidTileCoordinate,}){
final _that = this;
switch (_that) {
case PmTilesV3InvalidRangeException() when invalidRange != null:
return invalidRange(_that);case PmTilesV3CorruptArchiveException() when corruptArchive != null:
return corruptArchive(_that);case PmTilesV3UnsupportedCompressionException() when unsupportedCompression != null:
return unsupportedCompression(_that);case PmTilesV3SourceReadFailedException() when sourceReadFailed != null:
return sourceReadFailed(_that);case PmTilesV3InvalidTileIdException() when invalidTileId != null:
return invalidTileId(_that);case PmTilesV3InvalidTileCoordinateException() when invalidTileCoordinate != null:
return invalidTileCoordinate(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int offset,  int length,  int sizeBytes)?  invalidRange,TResult Function( String reason)?  corruptArchive,TResult Function( int compression)?  unsupportedCompression,TResult Function( String reason)?  sourceReadFailed,TResult Function( int tileId,  int minTileId,  int maxTileId)?  invalidTileId,TResult Function( int z,  int x,  int y)?  invalidTileCoordinate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PmTilesV3InvalidRangeException() when invalidRange != null:
return invalidRange(_that.offset,_that.length,_that.sizeBytes);case PmTilesV3CorruptArchiveException() when corruptArchive != null:
return corruptArchive(_that.reason);case PmTilesV3UnsupportedCompressionException() when unsupportedCompression != null:
return unsupportedCompression(_that.compression);case PmTilesV3SourceReadFailedException() when sourceReadFailed != null:
return sourceReadFailed(_that.reason);case PmTilesV3InvalidTileIdException() when invalidTileId != null:
return invalidTileId(_that.tileId,_that.minTileId,_that.maxTileId);case PmTilesV3InvalidTileCoordinateException() when invalidTileCoordinate != null:
return invalidTileCoordinate(_that.z,_that.x,_that.y);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int offset,  int length,  int sizeBytes)  invalidRange,required TResult Function( String reason)  corruptArchive,required TResult Function( int compression)  unsupportedCompression,required TResult Function( String reason)  sourceReadFailed,required TResult Function( int tileId,  int minTileId,  int maxTileId)  invalidTileId,required TResult Function( int z,  int x,  int y)  invalidTileCoordinate,}) {final _that = this;
switch (_that) {
case PmTilesV3InvalidRangeException():
return invalidRange(_that.offset,_that.length,_that.sizeBytes);case PmTilesV3CorruptArchiveException():
return corruptArchive(_that.reason);case PmTilesV3UnsupportedCompressionException():
return unsupportedCompression(_that.compression);case PmTilesV3SourceReadFailedException():
return sourceReadFailed(_that.reason);case PmTilesV3InvalidTileIdException():
return invalidTileId(_that.tileId,_that.minTileId,_that.maxTileId);case PmTilesV3InvalidTileCoordinateException():
return invalidTileCoordinate(_that.z,_that.x,_that.y);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int offset,  int length,  int sizeBytes)?  invalidRange,TResult? Function( String reason)?  corruptArchive,TResult? Function( int compression)?  unsupportedCompression,TResult? Function( String reason)?  sourceReadFailed,TResult? Function( int tileId,  int minTileId,  int maxTileId)?  invalidTileId,TResult? Function( int z,  int x,  int y)?  invalidTileCoordinate,}) {final _that = this;
switch (_that) {
case PmTilesV3InvalidRangeException() when invalidRange != null:
return invalidRange(_that.offset,_that.length,_that.sizeBytes);case PmTilesV3CorruptArchiveException() when corruptArchive != null:
return corruptArchive(_that.reason);case PmTilesV3UnsupportedCompressionException() when unsupportedCompression != null:
return unsupportedCompression(_that.compression);case PmTilesV3SourceReadFailedException() when sourceReadFailed != null:
return sourceReadFailed(_that.reason);case PmTilesV3InvalidTileIdException() when invalidTileId != null:
return invalidTileId(_that.tileId,_that.minTileId,_that.maxTileId);case PmTilesV3InvalidTileCoordinateException() when invalidTileCoordinate != null:
return invalidTileCoordinate(_that.z,_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc


class PmTilesV3InvalidRangeException implements PmTilesV3Exception {
  const PmTilesV3InvalidRangeException({required this.offset, required this.length, required this.sizeBytes});
  

 final  int offset;
 final  int length;
 final  int sizeBytes;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PmTilesV3InvalidRangeExceptionCopyWith<PmTilesV3InvalidRangeException> get copyWith => _$PmTilesV3InvalidRangeExceptionCopyWithImpl<PmTilesV3InvalidRangeException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmTilesV3InvalidRangeException&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.length, length) || other.length == length)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,offset,length,sizeBytes);

@override
String toString() {
  return 'PmTilesV3Exception.invalidRange(offset: $offset, length: $length, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class $PmTilesV3InvalidRangeExceptionCopyWith<$Res> implements $PmTilesV3ExceptionCopyWith<$Res> {
  factory $PmTilesV3InvalidRangeExceptionCopyWith(PmTilesV3InvalidRangeException value, $Res Function(PmTilesV3InvalidRangeException) _then) = _$PmTilesV3InvalidRangeExceptionCopyWithImpl;
@useResult
$Res call({
 int offset, int length, int sizeBytes
});




}
/// @nodoc
class _$PmTilesV3InvalidRangeExceptionCopyWithImpl<$Res>
    implements $PmTilesV3InvalidRangeExceptionCopyWith<$Res> {
  _$PmTilesV3InvalidRangeExceptionCopyWithImpl(this._self, this._then);

  final PmTilesV3InvalidRangeException _self;
  final $Res Function(PmTilesV3InvalidRangeException) _then;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? offset = null,Object? length = null,Object? sizeBytes = null,}) {
  return _then(PmTilesV3InvalidRangeException(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PmTilesV3CorruptArchiveException implements PmTilesV3Exception {
  const PmTilesV3CorruptArchiveException({required this.reason});
  

 final  String reason;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PmTilesV3CorruptArchiveExceptionCopyWith<PmTilesV3CorruptArchiveException> get copyWith => _$PmTilesV3CorruptArchiveExceptionCopyWithImpl<PmTilesV3CorruptArchiveException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmTilesV3CorruptArchiveException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'PmTilesV3Exception.corruptArchive(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $PmTilesV3CorruptArchiveExceptionCopyWith<$Res> implements $PmTilesV3ExceptionCopyWith<$Res> {
  factory $PmTilesV3CorruptArchiveExceptionCopyWith(PmTilesV3CorruptArchiveException value, $Res Function(PmTilesV3CorruptArchiveException) _then) = _$PmTilesV3CorruptArchiveExceptionCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$PmTilesV3CorruptArchiveExceptionCopyWithImpl<$Res>
    implements $PmTilesV3CorruptArchiveExceptionCopyWith<$Res> {
  _$PmTilesV3CorruptArchiveExceptionCopyWithImpl(this._self, this._then);

  final PmTilesV3CorruptArchiveException _self;
  final $Res Function(PmTilesV3CorruptArchiveException) _then;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(PmTilesV3CorruptArchiveException(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PmTilesV3UnsupportedCompressionException implements PmTilesV3Exception {
  const PmTilesV3UnsupportedCompressionException({required this.compression});
  

 final  int compression;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PmTilesV3UnsupportedCompressionExceptionCopyWith<PmTilesV3UnsupportedCompressionException> get copyWith => _$PmTilesV3UnsupportedCompressionExceptionCopyWithImpl<PmTilesV3UnsupportedCompressionException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmTilesV3UnsupportedCompressionException&&(identical(other.compression, compression) || other.compression == compression));
}


@override
int get hashCode => Object.hash(runtimeType,compression);

@override
String toString() {
  return 'PmTilesV3Exception.unsupportedCompression(compression: $compression)';
}


}

/// @nodoc
abstract mixin class $PmTilesV3UnsupportedCompressionExceptionCopyWith<$Res> implements $PmTilesV3ExceptionCopyWith<$Res> {
  factory $PmTilesV3UnsupportedCompressionExceptionCopyWith(PmTilesV3UnsupportedCompressionException value, $Res Function(PmTilesV3UnsupportedCompressionException) _then) = _$PmTilesV3UnsupportedCompressionExceptionCopyWithImpl;
@useResult
$Res call({
 int compression
});




}
/// @nodoc
class _$PmTilesV3UnsupportedCompressionExceptionCopyWithImpl<$Res>
    implements $PmTilesV3UnsupportedCompressionExceptionCopyWith<$Res> {
  _$PmTilesV3UnsupportedCompressionExceptionCopyWithImpl(this._self, this._then);

  final PmTilesV3UnsupportedCompressionException _self;
  final $Res Function(PmTilesV3UnsupportedCompressionException) _then;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? compression = null,}) {
  return _then(PmTilesV3UnsupportedCompressionException(
compression: null == compression ? _self.compression : compression // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PmTilesV3SourceReadFailedException implements PmTilesV3Exception {
  const PmTilesV3SourceReadFailedException({required this.reason});
  

 final  String reason;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PmTilesV3SourceReadFailedExceptionCopyWith<PmTilesV3SourceReadFailedException> get copyWith => _$PmTilesV3SourceReadFailedExceptionCopyWithImpl<PmTilesV3SourceReadFailedException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmTilesV3SourceReadFailedException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'PmTilesV3Exception.sourceReadFailed(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $PmTilesV3SourceReadFailedExceptionCopyWith<$Res> implements $PmTilesV3ExceptionCopyWith<$Res> {
  factory $PmTilesV3SourceReadFailedExceptionCopyWith(PmTilesV3SourceReadFailedException value, $Res Function(PmTilesV3SourceReadFailedException) _then) = _$PmTilesV3SourceReadFailedExceptionCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$PmTilesV3SourceReadFailedExceptionCopyWithImpl<$Res>
    implements $PmTilesV3SourceReadFailedExceptionCopyWith<$Res> {
  _$PmTilesV3SourceReadFailedExceptionCopyWithImpl(this._self, this._then);

  final PmTilesV3SourceReadFailedException _self;
  final $Res Function(PmTilesV3SourceReadFailedException) _then;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(PmTilesV3SourceReadFailedException(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PmTilesV3InvalidTileIdException implements PmTilesV3Exception {
  const PmTilesV3InvalidTileIdException({required this.tileId, required this.minTileId, required this.maxTileId});
  

 final  int tileId;
 final  int minTileId;
 final  int maxTileId;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PmTilesV3InvalidTileIdExceptionCopyWith<PmTilesV3InvalidTileIdException> get copyWith => _$PmTilesV3InvalidTileIdExceptionCopyWithImpl<PmTilesV3InvalidTileIdException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmTilesV3InvalidTileIdException&&(identical(other.tileId, tileId) || other.tileId == tileId)&&(identical(other.minTileId, minTileId) || other.minTileId == minTileId)&&(identical(other.maxTileId, maxTileId) || other.maxTileId == maxTileId));
}


@override
int get hashCode => Object.hash(runtimeType,tileId,minTileId,maxTileId);

@override
String toString() {
  return 'PmTilesV3Exception.invalidTileId(tileId: $tileId, minTileId: $minTileId, maxTileId: $maxTileId)';
}


}

/// @nodoc
abstract mixin class $PmTilesV3InvalidTileIdExceptionCopyWith<$Res> implements $PmTilesV3ExceptionCopyWith<$Res> {
  factory $PmTilesV3InvalidTileIdExceptionCopyWith(PmTilesV3InvalidTileIdException value, $Res Function(PmTilesV3InvalidTileIdException) _then) = _$PmTilesV3InvalidTileIdExceptionCopyWithImpl;
@useResult
$Res call({
 int tileId, int minTileId, int maxTileId
});




}
/// @nodoc
class _$PmTilesV3InvalidTileIdExceptionCopyWithImpl<$Res>
    implements $PmTilesV3InvalidTileIdExceptionCopyWith<$Res> {
  _$PmTilesV3InvalidTileIdExceptionCopyWithImpl(this._self, this._then);

  final PmTilesV3InvalidTileIdException _self;
  final $Res Function(PmTilesV3InvalidTileIdException) _then;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tileId = null,Object? minTileId = null,Object? maxTileId = null,}) {
  return _then(PmTilesV3InvalidTileIdException(
tileId: null == tileId ? _self.tileId : tileId // ignore: cast_nullable_to_non_nullable
as int,minTileId: null == minTileId ? _self.minTileId : minTileId // ignore: cast_nullable_to_non_nullable
as int,maxTileId: null == maxTileId ? _self.maxTileId : maxTileId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PmTilesV3InvalidTileCoordinateException implements PmTilesV3Exception {
  const PmTilesV3InvalidTileCoordinateException({required this.z, required this.x, required this.y});
  

 final  int z;
 final  int x;
 final  int y;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PmTilesV3InvalidTileCoordinateExceptionCopyWith<PmTilesV3InvalidTileCoordinateException> get copyWith => _$PmTilesV3InvalidTileCoordinateExceptionCopyWithImpl<PmTilesV3InvalidTileCoordinateException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmTilesV3InvalidTileCoordinateException&&(identical(other.z, z) || other.z == z)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}


@override
int get hashCode => Object.hash(runtimeType,z,x,y);

@override
String toString() {
  return 'PmTilesV3Exception.invalidTileCoordinate(z: $z, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $PmTilesV3InvalidTileCoordinateExceptionCopyWith<$Res> implements $PmTilesV3ExceptionCopyWith<$Res> {
  factory $PmTilesV3InvalidTileCoordinateExceptionCopyWith(PmTilesV3InvalidTileCoordinateException value, $Res Function(PmTilesV3InvalidTileCoordinateException) _then) = _$PmTilesV3InvalidTileCoordinateExceptionCopyWithImpl;
@useResult
$Res call({
 int z, int x, int y
});




}
/// @nodoc
class _$PmTilesV3InvalidTileCoordinateExceptionCopyWithImpl<$Res>
    implements $PmTilesV3InvalidTileCoordinateExceptionCopyWith<$Res> {
  _$PmTilesV3InvalidTileCoordinateExceptionCopyWithImpl(this._self, this._then);

  final PmTilesV3InvalidTileCoordinateException _self;
  final $Res Function(PmTilesV3InvalidTileCoordinateException) _then;

/// Create a copy of PmTilesV3Exception
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? z = null,Object? x = null,Object? y = null,}) {
  return _then(PmTilesV3InvalidTileCoordinateException(
z: null == z ? _self.z : z // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
