// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_notification_sound.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomNotificationSound {

 String get id; String get displayName; String get fileName; int get durationMs; DateTime get createdAt; bool get isAvailable;
/// Create a copy of CustomNotificationSound
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomNotificationSoundCopyWith<CustomNotificationSound> get copyWith => _$CustomNotificationSoundCopyWithImpl<CustomNotificationSound>(this as CustomNotificationSound, _$identity);

  /// Serializes this CustomNotificationSound to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomNotificationSound&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,fileName,durationMs,createdAt,isAvailable);

@override
String toString() {
  return 'CustomNotificationSound(id: $id, displayName: $displayName, fileName: $fileName, durationMs: $durationMs, createdAt: $createdAt, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $CustomNotificationSoundCopyWith<$Res>  {
  factory $CustomNotificationSoundCopyWith(CustomNotificationSound value, $Res Function(CustomNotificationSound) _then) = _$CustomNotificationSoundCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String fileName, int durationMs, DateTime createdAt, bool isAvailable
});




}
/// @nodoc
class _$CustomNotificationSoundCopyWithImpl<$Res>
    implements $CustomNotificationSoundCopyWith<$Res> {
  _$CustomNotificationSoundCopyWithImpl(this._self, this._then);

  final CustomNotificationSound _self;
  final $Res Function(CustomNotificationSound) _then;

/// Create a copy of CustomNotificationSound
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? fileName = null,Object? durationMs = null,Object? createdAt = null,Object? isAvailable = null,}) {
  return _then(CustomNotificationSound(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomNotificationSound].
extension CustomNotificationSoundPatterns on CustomNotificationSound {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomNotificationSound value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomNotificationSound() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomNotificationSound value)  $default,){
final _that = this;
switch (_that) {
case _CustomNotificationSound():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomNotificationSound value)?  $default,){
final _that = this;
switch (_that) {
case _CustomNotificationSound() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String fileName,  int durationMs,  DateTime createdAt,  bool isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomNotificationSound() when $default != null:
return $default(_that.id,_that.displayName,_that.fileName,_that.durationMs,_that.createdAt,_that.isAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String fileName,  int durationMs,  DateTime createdAt,  bool isAvailable)  $default,) {final _that = this;
switch (_that) {
case _CustomNotificationSound():
return $default(_that.id,_that.displayName,_that.fileName,_that.durationMs,_that.createdAt,_that.isAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String fileName,  int durationMs,  DateTime createdAt,  bool isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _CustomNotificationSound() when $default != null:
return $default(_that.id,_that.displayName,_that.fileName,_that.durationMs,_that.createdAt,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _CustomNotificationSound implements CustomNotificationSound {
  const _CustomNotificationSound({required this.id, required this.displayName, required this.fileName, required this.durationMs, required this.createdAt, this.isAvailable = true});
  factory _CustomNotificationSound.fromJson(Map<String, dynamic> json) => _$CustomNotificationSoundFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String fileName;
@override final  int durationMs;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isAvailable;

/// Create a copy of CustomNotificationSound
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomNotificationSoundCopyWith<_CustomNotificationSound> get copyWith => __$CustomNotificationSoundCopyWithImpl<_CustomNotificationSound>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomNotificationSoundToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomNotificationSound&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,fileName,durationMs,createdAt,isAvailable);

@override
String toString() {
  return 'CustomNotificationSound(id: $id, displayName: $displayName, fileName: $fileName, durationMs: $durationMs, createdAt: $createdAt, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$CustomNotificationSoundCopyWith<$Res> implements $CustomNotificationSoundCopyWith<$Res> {
  factory _$CustomNotificationSoundCopyWith(_CustomNotificationSound value, $Res Function(_CustomNotificationSound) _then) = __$CustomNotificationSoundCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String fileName, int durationMs, DateTime createdAt, bool isAvailable
});




}
/// @nodoc
class __$CustomNotificationSoundCopyWithImpl<$Res>
    implements _$CustomNotificationSoundCopyWith<$Res> {
  __$CustomNotificationSoundCopyWithImpl(this._self, this._then);

  final _CustomNotificationSound _self;
  final $Res Function(_CustomNotificationSound) _then;

/// Create a copy of CustomNotificationSound
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? fileName = null,Object? durationMs = null,Object? createdAt = null,Object? isAvailable = null,}) {
  return _then(_CustomNotificationSound(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
