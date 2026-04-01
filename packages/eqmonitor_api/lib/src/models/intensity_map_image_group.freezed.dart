// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_map_image_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityMapImageGroup {

/// 電文ID
@JsonKey(name: 'telegram_id') String get telegramId;@JsonKey(name: 'created_at') DateTime get createdAt; List<IntensityMapImageItem> get images;
/// Create a copy of IntensityMapImageGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityMapImageGroupCopyWith<IntensityMapImageGroup> get copyWith => _$IntensityMapImageGroupCopyWithImpl<IntensityMapImageGroup>(this as IntensityMapImageGroup, _$identity);

  /// Serializes this IntensityMapImageGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityMapImageGroup&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegramId,createdAt,const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'IntensityMapImageGroup(telegramId: $telegramId, createdAt: $createdAt, images: $images)';
}


}

/// @nodoc
abstract mixin class $IntensityMapImageGroupCopyWith<$Res>  {
  factory $IntensityMapImageGroupCopyWith(IntensityMapImageGroup value, $Res Function(IntensityMapImageGroup) _then) = _$IntensityMapImageGroupCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'telegram_id') String telegramId,@JsonKey(name: 'created_at') DateTime createdAt, List<IntensityMapImageItem> images
});




}
/// @nodoc
class _$IntensityMapImageGroupCopyWithImpl<$Res>
    implements $IntensityMapImageGroupCopyWith<$Res> {
  _$IntensityMapImageGroupCopyWithImpl(this._self, this._then);

  final IntensityMapImageGroup _self;
  final $Res Function(IntensityMapImageGroup) _then;

/// Create a copy of IntensityMapImageGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? telegramId = null,Object? createdAt = null,Object? images = null,}) {
  return _then(_self.copyWith(
telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<IntensityMapImageItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityMapImageGroup].
extension IntensityMapImageGroupPatterns on IntensityMapImageGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityMapImageGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityMapImageGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityMapImageGroup value)  $default,){
final _that = this;
switch (_that) {
case _IntensityMapImageGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityMapImageGroup value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityMapImageGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'telegram_id')  String telegramId, @JsonKey(name: 'created_at')  DateTime createdAt,  List<IntensityMapImageItem> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityMapImageGroup() when $default != null:
return $default(_that.telegramId,_that.createdAt,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'telegram_id')  String telegramId, @JsonKey(name: 'created_at')  DateTime createdAt,  List<IntensityMapImageItem> images)  $default,) {final _that = this;
switch (_that) {
case _IntensityMapImageGroup():
return $default(_that.telegramId,_that.createdAt,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'telegram_id')  String telegramId, @JsonKey(name: 'created_at')  DateTime createdAt,  List<IntensityMapImageItem> images)?  $default,) {final _that = this;
switch (_that) {
case _IntensityMapImageGroup() when $default != null:
return $default(_that.telegramId,_that.createdAt,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityMapImageGroup implements IntensityMapImageGroup {
  const _IntensityMapImageGroup({@JsonKey(name: 'telegram_id') required this.telegramId, @JsonKey(name: 'created_at') required this.createdAt, required final  List<IntensityMapImageItem> images}): _images = images;
  factory _IntensityMapImageGroup.fromJson(Map<String, dynamic> json) => _$IntensityMapImageGroupFromJson(json);

/// 電文ID
@override@JsonKey(name: 'telegram_id') final  String telegramId;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
 final  List<IntensityMapImageItem> _images;
@override List<IntensityMapImageItem> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of IntensityMapImageGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityMapImageGroupCopyWith<_IntensityMapImageGroup> get copyWith => __$IntensityMapImageGroupCopyWithImpl<_IntensityMapImageGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityMapImageGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityMapImageGroup&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegramId,createdAt,const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'IntensityMapImageGroup(telegramId: $telegramId, createdAt: $createdAt, images: $images)';
}


}

/// @nodoc
abstract mixin class _$IntensityMapImageGroupCopyWith<$Res> implements $IntensityMapImageGroupCopyWith<$Res> {
  factory _$IntensityMapImageGroupCopyWith(_IntensityMapImageGroup value, $Res Function(_IntensityMapImageGroup) _then) = __$IntensityMapImageGroupCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'telegram_id') String telegramId,@JsonKey(name: 'created_at') DateTime createdAt, List<IntensityMapImageItem> images
});




}
/// @nodoc
class __$IntensityMapImageGroupCopyWithImpl<$Res>
    implements _$IntensityMapImageGroupCopyWith<$Res> {
  __$IntensityMapImageGroupCopyWithImpl(this._self, this._then);

  final _IntensityMapImageGroup _self;
  final $Res Function(_IntensityMapImageGroup) _then;

/// Create a copy of IntensityMapImageGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? telegramId = null,Object? createdAt = null,Object? images = null,}) {
  return _then(_IntensityMapImageGroup(
telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<IntensityMapImageItem>,
  ));
}


}

// dart format on
