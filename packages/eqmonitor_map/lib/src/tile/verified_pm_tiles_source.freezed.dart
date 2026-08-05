// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verified_pm_tiles_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifiedPmTilesSource {

 String get sourceInstanceId; String get absolutePath; int get sizeBytes; String get sha256;
/// Create a copy of VerifiedPmTilesSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifiedPmTilesSourceCopyWith<VerifiedPmTilesSource> get copyWith => _$VerifiedPmTilesSourceCopyWithImpl<VerifiedPmTilesSource>(this as VerifiedPmTilesSource, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifiedPmTilesSource&&(identical(other.sourceInstanceId, sourceInstanceId) || other.sourceInstanceId == sourceInstanceId)&&(identical(other.absolutePath, absolutePath) || other.absolutePath == absolutePath)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.sha256, sha256) || other.sha256 == sha256));
}


@override
int get hashCode => Object.hash(runtimeType,sourceInstanceId,absolutePath,sizeBytes,sha256);

@override
String toString() {
  return 'VerifiedPmTilesSource(sourceInstanceId: $sourceInstanceId, absolutePath: $absolutePath, sizeBytes: $sizeBytes, sha256: $sha256)';
}


}

/// @nodoc
abstract mixin class $VerifiedPmTilesSourceCopyWith<$Res>  {
  factory $VerifiedPmTilesSourceCopyWith(VerifiedPmTilesSource value, $Res Function(VerifiedPmTilesSource) _then) = _$VerifiedPmTilesSourceCopyWithImpl;
@useResult
$Res call({
 String sourceInstanceId, String absolutePath, int sizeBytes, String sha256
});




}
/// @nodoc
class _$VerifiedPmTilesSourceCopyWithImpl<$Res>
    implements $VerifiedPmTilesSourceCopyWith<$Res> {
  _$VerifiedPmTilesSourceCopyWithImpl(this._self, this._then);

  final VerifiedPmTilesSource _self;
  final $Res Function(VerifiedPmTilesSource) _then;

/// Create a copy of VerifiedPmTilesSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceInstanceId = null,Object? absolutePath = null,Object? sizeBytes = null,Object? sha256 = null,}) {
  return _then(_self.copyWith(
sourceInstanceId: null == sourceInstanceId ? _self.sourceInstanceId : sourceInstanceId // ignore: cast_nullable_to_non_nullable
as String,absolutePath: null == absolutePath ? _self.absolutePath : absolutePath // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifiedPmTilesSource].
extension VerifiedPmTilesSourcePatterns on VerifiedPmTilesSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifiedPmTilesSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifiedPmTilesSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifiedPmTilesSource value)  $default,){
final _that = this;
switch (_that) {
case _VerifiedPmTilesSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifiedPmTilesSource value)?  $default,){
final _that = this;
switch (_that) {
case _VerifiedPmTilesSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sourceInstanceId,  String absolutePath,  int sizeBytes,  String sha256)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifiedPmTilesSource() when $default != null:
return $default(_that.sourceInstanceId,_that.absolutePath,_that.sizeBytes,_that.sha256);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sourceInstanceId,  String absolutePath,  int sizeBytes,  String sha256)  $default,) {final _that = this;
switch (_that) {
case _VerifiedPmTilesSource():
return $default(_that.sourceInstanceId,_that.absolutePath,_that.sizeBytes,_that.sha256);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sourceInstanceId,  String absolutePath,  int sizeBytes,  String sha256)?  $default,) {final _that = this;
switch (_that) {
case _VerifiedPmTilesSource() when $default != null:
return $default(_that.sourceInstanceId,_that.absolutePath,_that.sizeBytes,_that.sha256);case _:
  return null;

}
}

}

/// @nodoc


class _VerifiedPmTilesSource implements VerifiedPmTilesSource {
  const _VerifiedPmTilesSource({required this.sourceInstanceId, required this.absolutePath, required this.sizeBytes, required this.sha256});
  

@override final  String sourceInstanceId;
@override final  String absolutePath;
@override final  int sizeBytes;
@override final  String sha256;

/// Create a copy of VerifiedPmTilesSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifiedPmTilesSourceCopyWith<_VerifiedPmTilesSource> get copyWith => __$VerifiedPmTilesSourceCopyWithImpl<_VerifiedPmTilesSource>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifiedPmTilesSource&&(identical(other.sourceInstanceId, sourceInstanceId) || other.sourceInstanceId == sourceInstanceId)&&(identical(other.absolutePath, absolutePath) || other.absolutePath == absolutePath)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.sha256, sha256) || other.sha256 == sha256));
}


@override
int get hashCode => Object.hash(runtimeType,sourceInstanceId,absolutePath,sizeBytes,sha256);

@override
String toString() {
  return 'VerifiedPmTilesSource(sourceInstanceId: $sourceInstanceId, absolutePath: $absolutePath, sizeBytes: $sizeBytes, sha256: $sha256)';
}


}

/// @nodoc
abstract mixin class _$VerifiedPmTilesSourceCopyWith<$Res> implements $VerifiedPmTilesSourceCopyWith<$Res> {
  factory _$VerifiedPmTilesSourceCopyWith(_VerifiedPmTilesSource value, $Res Function(_VerifiedPmTilesSource) _then) = __$VerifiedPmTilesSourceCopyWithImpl;
@override @useResult
$Res call({
 String sourceInstanceId, String absolutePath, int sizeBytes, String sha256
});




}
/// @nodoc
class __$VerifiedPmTilesSourceCopyWithImpl<$Res>
    implements _$VerifiedPmTilesSourceCopyWith<$Res> {
  __$VerifiedPmTilesSourceCopyWithImpl(this._self, this._then);

  final _VerifiedPmTilesSource _self;
  final $Res Function(_VerifiedPmTilesSource) _then;

/// Create a copy of VerifiedPmTilesSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceInstanceId = null,Object? absolutePath = null,Object? sizeBytes = null,Object? sha256 = null,}) {
  return _then(_VerifiedPmTilesSource(
sourceInstanceId: null == sourceInstanceId ? _self.sourceInstanceId : sourceInstanceId // ignore: cast_nullable_to_non_nullable
as String,absolutePath: null == absolutePath ? _self.absolutePath : absolutePath // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
