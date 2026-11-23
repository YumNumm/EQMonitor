// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_library_folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReplayLibraryContents {

 List<SavedReplayFile> get files; List<String> get directories;
/// Create a copy of ReplayLibraryContents
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayLibraryContentsCopyWith<ReplayLibraryContents> get copyWith => _$ReplayLibraryContentsCopyWithImpl<ReplayLibraryContents>(this as ReplayLibraryContents, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayLibraryContents&&const DeepCollectionEquality().equals(other.files, files)&&const DeepCollectionEquality().equals(other.directories, directories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(files),const DeepCollectionEquality().hash(directories));

@override
String toString() {
  return 'ReplayLibraryContents(files: $files, directories: $directories)';
}


}

/// @nodoc
abstract mixin class $ReplayLibraryContentsCopyWith<$Res>  {
  factory $ReplayLibraryContentsCopyWith(ReplayLibraryContents value, $Res Function(ReplayLibraryContents) _then) = _$ReplayLibraryContentsCopyWithImpl;
@useResult
$Res call({
 List<SavedReplayFile> files, List<String> directories
});




}
/// @nodoc
class _$ReplayLibraryContentsCopyWithImpl<$Res>
    implements $ReplayLibraryContentsCopyWith<$Res> {
  _$ReplayLibraryContentsCopyWithImpl(this._self, this._then);

  final ReplayLibraryContents _self;
  final $Res Function(ReplayLibraryContents) _then;

/// Create a copy of ReplayLibraryContents
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? files = null,Object? directories = null,}) {
  return _then(ReplayLibraryContents(
files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<SavedReplayFile>,directories: null == directories ? _self.directories : directories // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayLibraryContents].
extension ReplayLibraryContentsPatterns on ReplayLibraryContents {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayLibraryContents value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayLibraryContents() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayLibraryContents value)  $default,){
final _that = this;
switch (_that) {
case _ReplayLibraryContents():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayLibraryContents value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayLibraryContents() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SavedReplayFile> files,  List<String> directories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayLibraryContents() when $default != null:
return $default(_that.files,_that.directories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SavedReplayFile> files,  List<String> directories)  $default,) {final _that = this;
switch (_that) {
case _ReplayLibraryContents():
return $default(_that.files,_that.directories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SavedReplayFile> files,  List<String> directories)?  $default,) {final _that = this;
switch (_that) {
case _ReplayLibraryContents() when $default != null:
return $default(_that.files,_that.directories);case _:
  return null;

}
}

}

/// @nodoc


class _ReplayLibraryContents implements ReplayLibraryContents {
  const _ReplayLibraryContents({required  List<SavedReplayFile> files, required  List<String> directories}): _files = files,_directories = directories;
  

 final  List<SavedReplayFile> _files;
@override List<SavedReplayFile> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}

 final  List<String> _directories;
@override List<String> get directories {
  if (_directories is EqualUnmodifiableListView) return _directories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_directories);
}


/// Create a copy of ReplayLibraryContents
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayLibraryContentsCopyWith<_ReplayLibraryContents> get copyWith => __$ReplayLibraryContentsCopyWithImpl<_ReplayLibraryContents>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayLibraryContents&&const DeepCollectionEquality().equals(other._files, _files)&&const DeepCollectionEquality().equals(other._directories, _directories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_files),const DeepCollectionEquality().hash(_directories));

@override
String toString() {
  return 'ReplayLibraryContents(files: $files, directories: $directories)';
}


}

/// @nodoc
abstract mixin class _$ReplayLibraryContentsCopyWith<$Res> implements $ReplayLibraryContentsCopyWith<$Res> {
  factory _$ReplayLibraryContentsCopyWith(_ReplayLibraryContents value, $Res Function(_ReplayLibraryContents) _then) = __$ReplayLibraryContentsCopyWithImpl;
@override @useResult
$Res call({
 List<SavedReplayFile> files, List<String> directories
});




}
/// @nodoc
class __$ReplayLibraryContentsCopyWithImpl<$Res>
    implements _$ReplayLibraryContentsCopyWith<$Res> {
  __$ReplayLibraryContentsCopyWithImpl(this._self, this._then);

  final _ReplayLibraryContents _self;
  final $Res Function(_ReplayLibraryContents) _then;

/// Create a copy of ReplayLibraryContents
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? files = null,Object? directories = null,}) {
  return _then(_ReplayLibraryContents(
files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<SavedReplayFile>,directories: null == directories ? _self._directories : directories // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$ReplayLibraryFolder {

 String get path; String get name; List<SavedReplayFile> get files;
/// Create a copy of ReplayLibraryFolder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayLibraryFolderCopyWith<ReplayLibraryFolder> get copyWith => _$ReplayLibraryFolderCopyWithImpl<ReplayLibraryFolder>(this as ReplayLibraryFolder, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayLibraryFolder&&(identical(other.path, path) || other.path == path)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.files, files));
}


@override
int get hashCode => Object.hash(runtimeType,path,name,const DeepCollectionEquality().hash(files));

@override
String toString() {
  return 'ReplayLibraryFolder(path: $path, name: $name, files: $files)';
}


}

/// @nodoc
abstract mixin class $ReplayLibraryFolderCopyWith<$Res>  {
  factory $ReplayLibraryFolderCopyWith(ReplayLibraryFolder value, $Res Function(ReplayLibraryFolder) _then) = _$ReplayLibraryFolderCopyWithImpl;
@useResult
$Res call({
 String path, String name, List<SavedReplayFile> files
});




}
/// @nodoc
class _$ReplayLibraryFolderCopyWithImpl<$Res>
    implements $ReplayLibraryFolderCopyWith<$Res> {
  _$ReplayLibraryFolderCopyWithImpl(this._self, this._then);

  final ReplayLibraryFolder _self;
  final $Res Function(ReplayLibraryFolder) _then;

/// Create a copy of ReplayLibraryFolder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? name = null,Object? files = null,}) {
  return _then(ReplayLibraryFolder(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<SavedReplayFile>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayLibraryFolder].
extension ReplayLibraryFolderPatterns on ReplayLibraryFolder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayLibraryFolder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayLibraryFolder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayLibraryFolder value)  $default,){
final _that = this;
switch (_that) {
case _ReplayLibraryFolder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayLibraryFolder value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayLibraryFolder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  String name,  List<SavedReplayFile> files)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayLibraryFolder() when $default != null:
return $default(_that.path,_that.name,_that.files);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  String name,  List<SavedReplayFile> files)  $default,) {final _that = this;
switch (_that) {
case _ReplayLibraryFolder():
return $default(_that.path,_that.name,_that.files);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  String name,  List<SavedReplayFile> files)?  $default,) {final _that = this;
switch (_that) {
case _ReplayLibraryFolder() when $default != null:
return $default(_that.path,_that.name,_that.files);case _:
  return null;

}
}

}

/// @nodoc


class _ReplayLibraryFolder extends ReplayLibraryFolder {
  const _ReplayLibraryFolder({required this.path, required this.name, required  List<SavedReplayFile> files}): _files = files,super._();
  

@override final  String path;
@override final  String name;
 final  List<SavedReplayFile> _files;
@override List<SavedReplayFile> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}


/// Create a copy of ReplayLibraryFolder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayLibraryFolderCopyWith<_ReplayLibraryFolder> get copyWith => __$ReplayLibraryFolderCopyWithImpl<_ReplayLibraryFolder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayLibraryFolder&&(identical(other.path, path) || other.path == path)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._files, _files));
}


@override
int get hashCode => Object.hash(runtimeType,path,name,const DeepCollectionEquality().hash(_files));

@override
String toString() {
  return 'ReplayLibraryFolder(path: $path, name: $name, files: $files)';
}


}

/// @nodoc
abstract mixin class _$ReplayLibraryFolderCopyWith<$Res> implements $ReplayLibraryFolderCopyWith<$Res> {
  factory _$ReplayLibraryFolderCopyWith(_ReplayLibraryFolder value, $Res Function(_ReplayLibraryFolder) _then) = __$ReplayLibraryFolderCopyWithImpl;
@override @useResult
$Res call({
 String path, String name, List<SavedReplayFile> files
});




}
/// @nodoc
class __$ReplayLibraryFolderCopyWithImpl<$Res>
    implements _$ReplayLibraryFolderCopyWith<$Res> {
  __$ReplayLibraryFolderCopyWithImpl(this._self, this._then);

  final _ReplayLibraryFolder _self;
  final $Res Function(_ReplayLibraryFolder) _then;

/// Create a copy of ReplayLibraryFolder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? name = null,Object? files = null,}) {
  return _then(_ReplayLibraryFolder(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<SavedReplayFile>,
  ));
}


}

/// @nodoc
mixin _$ReplayLibraryListing {

 List<ReplayLibraryFolder> get folders; List<SavedReplayFile> get files;
/// Create a copy of ReplayLibraryListing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayLibraryListingCopyWith<ReplayLibraryListing> get copyWith => _$ReplayLibraryListingCopyWithImpl<ReplayLibraryListing>(this as ReplayLibraryListing, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayLibraryListing&&const DeepCollectionEquality().equals(other.folders, folders)&&const DeepCollectionEquality().equals(other.files, files));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(folders),const DeepCollectionEquality().hash(files));

@override
String toString() {
  return 'ReplayLibraryListing(folders: $folders, files: $files)';
}


}

/// @nodoc
abstract mixin class $ReplayLibraryListingCopyWith<$Res>  {
  factory $ReplayLibraryListingCopyWith(ReplayLibraryListing value, $Res Function(ReplayLibraryListing) _then) = _$ReplayLibraryListingCopyWithImpl;
@useResult
$Res call({
 List<ReplayLibraryFolder> folders, List<SavedReplayFile> files
});




}
/// @nodoc
class _$ReplayLibraryListingCopyWithImpl<$Res>
    implements $ReplayLibraryListingCopyWith<$Res> {
  _$ReplayLibraryListingCopyWithImpl(this._self, this._then);

  final ReplayLibraryListing _self;
  final $Res Function(ReplayLibraryListing) _then;

/// Create a copy of ReplayLibraryListing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? folders = null,Object? files = null,}) {
  return _then(ReplayLibraryListing(
folders: null == folders ? _self.folders : folders // ignore: cast_nullable_to_non_nullable
as List<ReplayLibraryFolder>,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<SavedReplayFile>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayLibraryListing].
extension ReplayLibraryListingPatterns on ReplayLibraryListing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayLibraryListing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayLibraryListing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayLibraryListing value)  $default,){
final _that = this;
switch (_that) {
case _ReplayLibraryListing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayLibraryListing value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayLibraryListing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ReplayLibraryFolder> folders,  List<SavedReplayFile> files)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayLibraryListing() when $default != null:
return $default(_that.folders,_that.files);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ReplayLibraryFolder> folders,  List<SavedReplayFile> files)  $default,) {final _that = this;
switch (_that) {
case _ReplayLibraryListing():
return $default(_that.folders,_that.files);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ReplayLibraryFolder> folders,  List<SavedReplayFile> files)?  $default,) {final _that = this;
switch (_that) {
case _ReplayLibraryListing() when $default != null:
return $default(_that.folders,_that.files);case _:
  return null;

}
}

}

/// @nodoc


class _ReplayLibraryListing implements ReplayLibraryListing {
  const _ReplayLibraryListing({required  List<ReplayLibraryFolder> folders, required  List<SavedReplayFile> files}): _folders = folders,_files = files;
  

 final  List<ReplayLibraryFolder> _folders;
@override List<ReplayLibraryFolder> get folders {
  if (_folders is EqualUnmodifiableListView) return _folders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_folders);
}

 final  List<SavedReplayFile> _files;
@override List<SavedReplayFile> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}


/// Create a copy of ReplayLibraryListing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayLibraryListingCopyWith<_ReplayLibraryListing> get copyWith => __$ReplayLibraryListingCopyWithImpl<_ReplayLibraryListing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayLibraryListing&&const DeepCollectionEquality().equals(other._folders, _folders)&&const DeepCollectionEquality().equals(other._files, _files));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_folders),const DeepCollectionEquality().hash(_files));

@override
String toString() {
  return 'ReplayLibraryListing(folders: $folders, files: $files)';
}


}

/// @nodoc
abstract mixin class _$ReplayLibraryListingCopyWith<$Res> implements $ReplayLibraryListingCopyWith<$Res> {
  factory _$ReplayLibraryListingCopyWith(_ReplayLibraryListing value, $Res Function(_ReplayLibraryListing) _then) = __$ReplayLibraryListingCopyWithImpl;
@override @useResult
$Res call({
 List<ReplayLibraryFolder> folders, List<SavedReplayFile> files
});




}
/// @nodoc
class __$ReplayLibraryListingCopyWithImpl<$Res>
    implements _$ReplayLibraryListingCopyWith<$Res> {
  __$ReplayLibraryListingCopyWithImpl(this._self, this._then);

  final _ReplayLibraryListing _self;
  final $Res Function(_ReplayLibraryListing) _then;

/// Create a copy of ReplayLibraryListing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? folders = null,Object? files = null,}) {
  return _then(_ReplayLibraryListing(
folders: null == folders ? _self._folders : folders // ignore: cast_nullable_to_non_nullable
as List<ReplayLibraryFolder>,files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<SavedReplayFile>,
  ));
}


}

// dart format on
