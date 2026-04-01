// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_map_image_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityMapImageItem {

/// 画像レコードID
 String get id; AppLocale get language;/// 画像URL
@JsonKey(name: 'image_url') String get imageUrl;/// 画像ファイルサイズ(bytes)
@JsonKey(name: 'file_size') num get fileSize; Size get size;/// 生成インスタンス名
@JsonKey(name: 'generator_instance') String get generatorInstance;/// レンダリング時間(ms)
@JsonKey(name: 'render_duration_ms') num get renderDurationMs;/// アップロード時間(ms)
@JsonKey(name: 'upload_duration_ms') num get uploadDurationMs;/// 総処理時間(ms)
@JsonKey(name: 'total_duration_ms') num get totalDurationMs;@JsonKey(name: 'generated_at') DateTime get generatedAt;
/// Create a copy of IntensityMapImageItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityMapImageItemCopyWith<IntensityMapImageItem> get copyWith => _$IntensityMapImageItemCopyWithImpl<IntensityMapImageItem>(this as IntensityMapImageItem, _$identity);

  /// Serializes this IntensityMapImageItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityMapImageItem&&(identical(other.id, id) || other.id == id)&&(identical(other.language, language) || other.language == language)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.size, size) || other.size == size)&&(identical(other.generatorInstance, generatorInstance) || other.generatorInstance == generatorInstance)&&(identical(other.renderDurationMs, renderDurationMs) || other.renderDurationMs == renderDurationMs)&&(identical(other.uploadDurationMs, uploadDurationMs) || other.uploadDurationMs == uploadDurationMs)&&(identical(other.totalDurationMs, totalDurationMs) || other.totalDurationMs == totalDurationMs)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,language,imageUrl,fileSize,size,generatorInstance,renderDurationMs,uploadDurationMs,totalDurationMs,generatedAt);

@override
String toString() {
  return 'IntensityMapImageItem(id: $id, language: $language, imageUrl: $imageUrl, fileSize: $fileSize, size: $size, generatorInstance: $generatorInstance, renderDurationMs: $renderDurationMs, uploadDurationMs: $uploadDurationMs, totalDurationMs: $totalDurationMs, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class $IntensityMapImageItemCopyWith<$Res>  {
  factory $IntensityMapImageItemCopyWith(IntensityMapImageItem value, $Res Function(IntensityMapImageItem) _then) = _$IntensityMapImageItemCopyWithImpl;
@useResult
$Res call({
 String id, AppLocale language,@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'file_size') num fileSize, Size size,@JsonKey(name: 'generator_instance') String generatorInstance,@JsonKey(name: 'render_duration_ms') num renderDurationMs,@JsonKey(name: 'upload_duration_ms') num uploadDurationMs,@JsonKey(name: 'total_duration_ms') num totalDurationMs,@JsonKey(name: 'generated_at') DateTime generatedAt
});


$SizeCopyWith<$Res> get size;

}
/// @nodoc
class _$IntensityMapImageItemCopyWithImpl<$Res>
    implements $IntensityMapImageItemCopyWith<$Res> {
  _$IntensityMapImageItemCopyWithImpl(this._self, this._then);

  final IntensityMapImageItem _self;
  final $Res Function(IntensityMapImageItem) _then;

/// Create a copy of IntensityMapImageItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? language = null,Object? imageUrl = null,Object? fileSize = null,Object? size = null,Object? generatorInstance = null,Object? renderDurationMs = null,Object? uploadDurationMs = null,Object? totalDurationMs = null,Object? generatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLocale,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as num,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as Size,generatorInstance: null == generatorInstance ? _self.generatorInstance : generatorInstance // ignore: cast_nullable_to_non_nullable
as String,renderDurationMs: null == renderDurationMs ? _self.renderDurationMs : renderDurationMs // ignore: cast_nullable_to_non_nullable
as num,uploadDurationMs: null == uploadDurationMs ? _self.uploadDurationMs : uploadDurationMs // ignore: cast_nullable_to_non_nullable
as num,totalDurationMs: null == totalDurationMs ? _self.totalDurationMs : totalDurationMs // ignore: cast_nullable_to_non_nullable
as num,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of IntensityMapImageItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SizeCopyWith<$Res> get size {
  
  return $SizeCopyWith<$Res>(_self.size, (value) {
    return _then(_self.copyWith(size: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityMapImageItem].
extension IntensityMapImageItemPatterns on IntensityMapImageItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityMapImageItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityMapImageItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityMapImageItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityMapImageItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityMapImageItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityMapImageItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  AppLocale language, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'file_size')  num fileSize,  Size size, @JsonKey(name: 'generator_instance')  String generatorInstance, @JsonKey(name: 'render_duration_ms')  num renderDurationMs, @JsonKey(name: 'upload_duration_ms')  num uploadDurationMs, @JsonKey(name: 'total_duration_ms')  num totalDurationMs, @JsonKey(name: 'generated_at')  DateTime generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityMapImageItem() when $default != null:
return $default(_that.id,_that.language,_that.imageUrl,_that.fileSize,_that.size,_that.generatorInstance,_that.renderDurationMs,_that.uploadDurationMs,_that.totalDurationMs,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  AppLocale language, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'file_size')  num fileSize,  Size size, @JsonKey(name: 'generator_instance')  String generatorInstance, @JsonKey(name: 'render_duration_ms')  num renderDurationMs, @JsonKey(name: 'upload_duration_ms')  num uploadDurationMs, @JsonKey(name: 'total_duration_ms')  num totalDurationMs, @JsonKey(name: 'generated_at')  DateTime generatedAt)  $default,) {final _that = this;
switch (_that) {
case _IntensityMapImageItem():
return $default(_that.id,_that.language,_that.imageUrl,_that.fileSize,_that.size,_that.generatorInstance,_that.renderDurationMs,_that.uploadDurationMs,_that.totalDurationMs,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  AppLocale language, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'file_size')  num fileSize,  Size size, @JsonKey(name: 'generator_instance')  String generatorInstance, @JsonKey(name: 'render_duration_ms')  num renderDurationMs, @JsonKey(name: 'upload_duration_ms')  num uploadDurationMs, @JsonKey(name: 'total_duration_ms')  num totalDurationMs, @JsonKey(name: 'generated_at')  DateTime generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _IntensityMapImageItem() when $default != null:
return $default(_that.id,_that.language,_that.imageUrl,_that.fileSize,_that.size,_that.generatorInstance,_that.renderDurationMs,_that.uploadDurationMs,_that.totalDurationMs,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityMapImageItem implements IntensityMapImageItem {
  const _IntensityMapImageItem({required this.id, required this.language, @JsonKey(name: 'image_url') required this.imageUrl, @JsonKey(name: 'file_size') required this.fileSize, required this.size, @JsonKey(name: 'generator_instance') required this.generatorInstance, @JsonKey(name: 'render_duration_ms') required this.renderDurationMs, @JsonKey(name: 'upload_duration_ms') required this.uploadDurationMs, @JsonKey(name: 'total_duration_ms') required this.totalDurationMs, @JsonKey(name: 'generated_at') required this.generatedAt});
  factory _IntensityMapImageItem.fromJson(Map<String, dynamic> json) => _$IntensityMapImageItemFromJson(json);

/// 画像レコードID
@override final  String id;
@override final  AppLocale language;
/// 画像URL
@override@JsonKey(name: 'image_url') final  String imageUrl;
/// 画像ファイルサイズ(bytes)
@override@JsonKey(name: 'file_size') final  num fileSize;
@override final  Size size;
/// 生成インスタンス名
@override@JsonKey(name: 'generator_instance') final  String generatorInstance;
/// レンダリング時間(ms)
@override@JsonKey(name: 'render_duration_ms') final  num renderDurationMs;
/// アップロード時間(ms)
@override@JsonKey(name: 'upload_duration_ms') final  num uploadDurationMs;
/// 総処理時間(ms)
@override@JsonKey(name: 'total_duration_ms') final  num totalDurationMs;
@override@JsonKey(name: 'generated_at') final  DateTime generatedAt;

/// Create a copy of IntensityMapImageItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityMapImageItemCopyWith<_IntensityMapImageItem> get copyWith => __$IntensityMapImageItemCopyWithImpl<_IntensityMapImageItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityMapImageItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityMapImageItem&&(identical(other.id, id) || other.id == id)&&(identical(other.language, language) || other.language == language)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.size, size) || other.size == size)&&(identical(other.generatorInstance, generatorInstance) || other.generatorInstance == generatorInstance)&&(identical(other.renderDurationMs, renderDurationMs) || other.renderDurationMs == renderDurationMs)&&(identical(other.uploadDurationMs, uploadDurationMs) || other.uploadDurationMs == uploadDurationMs)&&(identical(other.totalDurationMs, totalDurationMs) || other.totalDurationMs == totalDurationMs)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,language,imageUrl,fileSize,size,generatorInstance,renderDurationMs,uploadDurationMs,totalDurationMs,generatedAt);

@override
String toString() {
  return 'IntensityMapImageItem(id: $id, language: $language, imageUrl: $imageUrl, fileSize: $fileSize, size: $size, generatorInstance: $generatorInstance, renderDurationMs: $renderDurationMs, uploadDurationMs: $uploadDurationMs, totalDurationMs: $totalDurationMs, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$IntensityMapImageItemCopyWith<$Res> implements $IntensityMapImageItemCopyWith<$Res> {
  factory _$IntensityMapImageItemCopyWith(_IntensityMapImageItem value, $Res Function(_IntensityMapImageItem) _then) = __$IntensityMapImageItemCopyWithImpl;
@override @useResult
$Res call({
 String id, AppLocale language,@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'file_size') num fileSize, Size size,@JsonKey(name: 'generator_instance') String generatorInstance,@JsonKey(name: 'render_duration_ms') num renderDurationMs,@JsonKey(name: 'upload_duration_ms') num uploadDurationMs,@JsonKey(name: 'total_duration_ms') num totalDurationMs,@JsonKey(name: 'generated_at') DateTime generatedAt
});


@override $SizeCopyWith<$Res> get size;

}
/// @nodoc
class __$IntensityMapImageItemCopyWithImpl<$Res>
    implements _$IntensityMapImageItemCopyWith<$Res> {
  __$IntensityMapImageItemCopyWithImpl(this._self, this._then);

  final _IntensityMapImageItem _self;
  final $Res Function(_IntensityMapImageItem) _then;

/// Create a copy of IntensityMapImageItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? language = null,Object? imageUrl = null,Object? fileSize = null,Object? size = null,Object? generatorInstance = null,Object? renderDurationMs = null,Object? uploadDurationMs = null,Object? totalDurationMs = null,Object? generatedAt = null,}) {
  return _then(_IntensityMapImageItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLocale,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as num,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as Size,generatorInstance: null == generatorInstance ? _self.generatorInstance : generatorInstance // ignore: cast_nullable_to_non_nullable
as String,renderDurationMs: null == renderDurationMs ? _self.renderDurationMs : renderDurationMs // ignore: cast_nullable_to_non_nullable
as num,uploadDurationMs: null == uploadDurationMs ? _self.uploadDurationMs : uploadDurationMs // ignore: cast_nullable_to_non_nullable
as num,totalDurationMs: null == totalDurationMs ? _self.totalDurationMs : totalDurationMs // ignore: cast_nullable_to_non_nullable
as num,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of IntensityMapImageItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SizeCopyWith<$Res> get size {
  
  return $SizeCopyWith<$Res>(_self.size, (value) {
    return _then(_self.copyWith(size: value));
  });
}
}

// dart format on
