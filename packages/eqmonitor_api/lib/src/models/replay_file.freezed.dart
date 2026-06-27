// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReplayFile {

 String get id; String get startTime; String get endTime; String get objectKey;@JsonKey(includeIfNull: true) num? get fileSizeBytes; String get createdAt;@JsonKey(includeIfNull: true) String? get downloadUrl;
/// Create a copy of ReplayFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayFileCopyWith<ReplayFile> get copyWith => _$ReplayFileCopyWithImpl<ReplayFile>(this as ReplayFile, _$identity);

  /// Serializes this ReplayFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayFile&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,objectKey,fileSizeBytes,createdAt,downloadUrl);

@override
String toString() {
  return 'ReplayFile(id: $id, startTime: $startTime, endTime: $endTime, objectKey: $objectKey, fileSizeBytes: $fileSizeBytes, createdAt: $createdAt, downloadUrl: $downloadUrl)';
}


}

/// @nodoc
abstract mixin class $ReplayFileCopyWith<$Res>  {
  factory $ReplayFileCopyWith(ReplayFile value, $Res Function(ReplayFile) _then) = _$ReplayFileCopyWithImpl;
@useResult
$Res call({
 String id, String startTime, String endTime, String objectKey,@JsonKey(includeIfNull: true) num? fileSizeBytes, String createdAt,@JsonKey(includeIfNull: true) String? downloadUrl
});




}
/// @nodoc
class _$ReplayFileCopyWithImpl<$Res>
    implements $ReplayFileCopyWith<$Res> {
  _$ReplayFileCopyWithImpl(this._self, this._then);

  final ReplayFile _self;
  final $Res Function(ReplayFile) _then;

/// Create a copy of ReplayFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startTime = null,Object? endTime = null,Object? objectKey = null,Object? fileSizeBytes = freezed,Object? createdAt = null,Object? downloadUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,objectKey: null == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String,fileSizeBytes: freezed == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as num?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: freezed == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayFile].
extension ReplayFilePatterns on ReplayFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayFile value)  $default,){
final _that = this;
switch (_that) {
case _ReplayFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayFile value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String startTime,  String endTime,  String objectKey, @JsonKey(includeIfNull: true)  num? fileSizeBytes,  String createdAt, @JsonKey(includeIfNull: true)  String? downloadUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayFile() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.objectKey,_that.fileSizeBytes,_that.createdAt,_that.downloadUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String startTime,  String endTime,  String objectKey, @JsonKey(includeIfNull: true)  num? fileSizeBytes,  String createdAt, @JsonKey(includeIfNull: true)  String? downloadUrl)  $default,) {final _that = this;
switch (_that) {
case _ReplayFile():
return $default(_that.id,_that.startTime,_that.endTime,_that.objectKey,_that.fileSizeBytes,_that.createdAt,_that.downloadUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String startTime,  String endTime,  String objectKey, @JsonKey(includeIfNull: true)  num? fileSizeBytes,  String createdAt, @JsonKey(includeIfNull: true)  String? downloadUrl)?  $default,) {final _that = this;
switch (_that) {
case _ReplayFile() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.objectKey,_that.fileSizeBytes,_that.createdAt,_that.downloadUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplayFile implements ReplayFile {
  const _ReplayFile({required this.id, required this.startTime, required this.endTime, required this.objectKey, @JsonKey(includeIfNull: true) required this.fileSizeBytes, required this.createdAt, @JsonKey(includeIfNull: true) required this.downloadUrl});
  factory _ReplayFile.fromJson(Map<String, dynamic> json) => _$ReplayFileFromJson(json);

@override final  String id;
@override final  String startTime;
@override final  String endTime;
@override final  String objectKey;
@override@JsonKey(includeIfNull: true) final  num? fileSizeBytes;
@override final  String createdAt;
@override@JsonKey(includeIfNull: true) final  String? downloadUrl;

/// Create a copy of ReplayFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayFileCopyWith<_ReplayFile> get copyWith => __$ReplayFileCopyWithImpl<_ReplayFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplayFileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayFile&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,objectKey,fileSizeBytes,createdAt,downloadUrl);

@override
String toString() {
  return 'ReplayFile(id: $id, startTime: $startTime, endTime: $endTime, objectKey: $objectKey, fileSizeBytes: $fileSizeBytes, createdAt: $createdAt, downloadUrl: $downloadUrl)';
}


}

/// @nodoc
abstract mixin class _$ReplayFileCopyWith<$Res> implements $ReplayFileCopyWith<$Res> {
  factory _$ReplayFileCopyWith(_ReplayFile value, $Res Function(_ReplayFile) _then) = __$ReplayFileCopyWithImpl;
@override @useResult
$Res call({
 String id, String startTime, String endTime, String objectKey,@JsonKey(includeIfNull: true) num? fileSizeBytes, String createdAt,@JsonKey(includeIfNull: true) String? downloadUrl
});




}
/// @nodoc
class __$ReplayFileCopyWithImpl<$Res>
    implements _$ReplayFileCopyWith<$Res> {
  __$ReplayFileCopyWithImpl(this._self, this._then);

  final _ReplayFile _self;
  final $Res Function(_ReplayFile) _then;

/// Create a copy of ReplayFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startTime = null,Object? endTime = null,Object? objectKey = null,Object? fileSizeBytes = freezed,Object? createdAt = null,Object? downloadUrl = freezed,}) {
  return _then(_ReplayFile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,objectKey: null == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String,fileSizeBytes: freezed == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as num?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: freezed == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
