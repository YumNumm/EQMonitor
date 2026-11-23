// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_replay_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedReplayFile {

 String get path; String get name; String get directory; int get sizeBytes; DateTime get modifiedAt;
/// Create a copy of SavedReplayFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedReplayFileCopyWith<SavedReplayFile> get copyWith => _$SavedReplayFileCopyWithImpl<SavedReplayFile>(this as SavedReplayFile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedReplayFile&&(identical(other.path, path) || other.path == path)&&(identical(other.name, name) || other.name == name)&&(identical(other.directory, directory) || other.directory == directory)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt));
}


@override
int get hashCode => Object.hash(runtimeType,path,name,directory,sizeBytes,modifiedAt);

@override
String toString() {
  return 'SavedReplayFile(path: $path, name: $name, directory: $directory, sizeBytes: $sizeBytes, modifiedAt: $modifiedAt)';
}


}

/// @nodoc
abstract mixin class $SavedReplayFileCopyWith<$Res>  {
  factory $SavedReplayFileCopyWith(SavedReplayFile value, $Res Function(SavedReplayFile) _then) = _$SavedReplayFileCopyWithImpl;
@useResult
$Res call({
 String path, String name, String directory, int sizeBytes, DateTime modifiedAt
});




}
/// @nodoc
class _$SavedReplayFileCopyWithImpl<$Res>
    implements $SavedReplayFileCopyWith<$Res> {
  _$SavedReplayFileCopyWithImpl(this._self, this._then);

  final SavedReplayFile _self;
  final $Res Function(SavedReplayFile) _then;

/// Create a copy of SavedReplayFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? name = null,Object? directory = null,Object? sizeBytes = null,Object? modifiedAt = null,}) {
  return _then(SavedReplayFile(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedReplayFile].
extension SavedReplayFilePatterns on SavedReplayFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedReplayFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedReplayFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedReplayFile value)  $default,){
final _that = this;
switch (_that) {
case _SavedReplayFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedReplayFile value)?  $default,){
final _that = this;
switch (_that) {
case _SavedReplayFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  String name,  String directory,  int sizeBytes,  DateTime modifiedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedReplayFile() when $default != null:
return $default(_that.path,_that.name,_that.directory,_that.sizeBytes,_that.modifiedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  String name,  String directory,  int sizeBytes,  DateTime modifiedAt)  $default,) {final _that = this;
switch (_that) {
case _SavedReplayFile():
return $default(_that.path,_that.name,_that.directory,_that.sizeBytes,_that.modifiedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  String name,  String directory,  int sizeBytes,  DateTime modifiedAt)?  $default,) {final _that = this;
switch (_that) {
case _SavedReplayFile() when $default != null:
return $default(_that.path,_that.name,_that.directory,_that.sizeBytes,_that.modifiedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SavedReplayFile extends SavedReplayFile {
  const _SavedReplayFile({required this.path, required this.name, required this.directory, required this.sizeBytes, required this.modifiedAt}): super._();
  

@override final  String path;
@override final  String name;
@override final  String directory;
@override final  int sizeBytes;
@override final  DateTime modifiedAt;

/// Create a copy of SavedReplayFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedReplayFileCopyWith<_SavedReplayFile> get copyWith => __$SavedReplayFileCopyWithImpl<_SavedReplayFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedReplayFile&&(identical(other.path, path) || other.path == path)&&(identical(other.name, name) || other.name == name)&&(identical(other.directory, directory) || other.directory == directory)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt));
}


@override
int get hashCode => Object.hash(runtimeType,path,name,directory,sizeBytes,modifiedAt);

@override
String toString() {
  return 'SavedReplayFile(path: $path, name: $name, directory: $directory, sizeBytes: $sizeBytes, modifiedAt: $modifiedAt)';
}


}

/// @nodoc
abstract mixin class _$SavedReplayFileCopyWith<$Res> implements $SavedReplayFileCopyWith<$Res> {
  factory _$SavedReplayFileCopyWith(_SavedReplayFile value, $Res Function(_SavedReplayFile) _then) = __$SavedReplayFileCopyWithImpl;
@override @useResult
$Res call({
 String path, String name, String directory, int sizeBytes, DateTime modifiedAt
});




}
/// @nodoc
class __$SavedReplayFileCopyWithImpl<$Res>
    implements _$SavedReplayFileCopyWith<$Res> {
  __$SavedReplayFileCopyWithImpl(this._self, this._then);

  final _SavedReplayFile _self;
  final $Res Function(_SavedReplayFile) _then;

/// Create a copy of SavedReplayFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? name = null,Object? directory = null,Object? sizeBytes = null,Object? modifiedAt = null,}) {
  return _then(_SavedReplayFile(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
