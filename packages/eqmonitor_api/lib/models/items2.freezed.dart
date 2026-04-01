// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'items2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Items2 {

 String get id; String get startTime; String get endTime; String get objectKey;@JsonKey(includeIfNull: true) num? get fileSizeBytes; String get createdAt;@JsonKey(includeIfNull: true) String? get downloadUrl;
/// Create a copy of Items2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Items2CopyWith<Items2> get copyWith => _$Items2CopyWithImpl<Items2>(this as Items2, _$identity);

  /// Serializes this Items2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Items2&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,objectKey,fileSizeBytes,createdAt,downloadUrl);

@override
String toString() {
  return 'Items2(id: $id, startTime: $startTime, endTime: $endTime, objectKey: $objectKey, fileSizeBytes: $fileSizeBytes, createdAt: $createdAt, downloadUrl: $downloadUrl)';
}


}

/// @nodoc
abstract mixin class $Items2CopyWith<$Res>  {
  factory $Items2CopyWith(Items2 value, $Res Function(Items2) _then) = _$Items2CopyWithImpl;
@useResult
$Res call({
 String id, String startTime, String endTime, String objectKey,@JsonKey(includeIfNull: true) num? fileSizeBytes, String createdAt,@JsonKey(includeIfNull: true) String? downloadUrl
});




}
/// @nodoc
class _$Items2CopyWithImpl<$Res>
    implements $Items2CopyWith<$Res> {
  _$Items2CopyWithImpl(this._self, this._then);

  final Items2 _self;
  final $Res Function(Items2) _then;

/// Create a copy of Items2
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


/// Adds pattern-matching-related methods to [Items2].
extension Items2Patterns on Items2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Items2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Items2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Items2 value)  $default,){
final _that = this;
switch (_that) {
case _Items2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Items2 value)?  $default,){
final _that = this;
switch (_that) {
case _Items2() when $default != null:
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
case _Items2() when $default != null:
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
case _Items2():
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
case _Items2() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.objectKey,_that.fileSizeBytes,_that.createdAt,_that.downloadUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Items2 implements Items2 {
  const _Items2({required this.id, required this.startTime, required this.endTime, required this.objectKey, @JsonKey(includeIfNull: true) required this.fileSizeBytes, required this.createdAt, @JsonKey(includeIfNull: true) required this.downloadUrl});
  factory _Items2.fromJson(Map<String, dynamic> json) => _$Items2FromJson(json);

@override final  String id;
@override final  String startTime;
@override final  String endTime;
@override final  String objectKey;
@override@JsonKey(includeIfNull: true) final  num? fileSizeBytes;
@override final  String createdAt;
@override@JsonKey(includeIfNull: true) final  String? downloadUrl;

/// Create a copy of Items2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Items2CopyWith<_Items2> get copyWith => __$Items2CopyWithImpl<_Items2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Items2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Items2&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,objectKey,fileSizeBytes,createdAt,downloadUrl);

@override
String toString() {
  return 'Items2(id: $id, startTime: $startTime, endTime: $endTime, objectKey: $objectKey, fileSizeBytes: $fileSizeBytes, createdAt: $createdAt, downloadUrl: $downloadUrl)';
}


}

/// @nodoc
abstract mixin class _$Items2CopyWith<$Res> implements $Items2CopyWith<$Res> {
  factory _$Items2CopyWith(_Items2 value, $Res Function(_Items2) _then) = __$Items2CopyWithImpl;
@override @useResult
$Res call({
 String id, String startTime, String endTime, String objectKey,@JsonKey(includeIfNull: true) num? fileSizeBytes, String createdAt,@JsonKey(includeIfNull: true) String? downloadUrl
});




}
/// @nodoc
class __$Items2CopyWithImpl<$Res>
    implements _$Items2CopyWith<$Res> {
  __$Items2CopyWithImpl(this._self, this._then);

  final _Items2 _self;
  final $Res Function(_Items2) _then;

/// Create a copy of Items2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startTime = null,Object? endTime = null,Object? objectKey = null,Object? fileSizeBytes = freezed,Object? createdAt = null,Object? downloadUrl = freezed,}) {
  return _then(_Items2(
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
