// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_sub_region_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionSubRegionResponse {

 String get id;/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
 String get code; String get name;
/// Create a copy of ShakeDetectionSubRegionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionSubRegionResponseCopyWith<ShakeDetectionSubRegionResponse> get copyWith => _$ShakeDetectionSubRegionResponseCopyWithImpl<ShakeDetectionSubRegionResponse>(this as ShakeDetectionSubRegionResponse, _$identity);

  /// Serializes this ShakeDetectionSubRegionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionSubRegionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name);

@override
String toString() {
  return 'ShakeDetectionSubRegionResponse(id: $id, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionSubRegionResponseCopyWith<$Res>  {
  factory $ShakeDetectionSubRegionResponseCopyWith(ShakeDetectionSubRegionResponse value, $Res Function(ShakeDetectionSubRegionResponse) _then) = _$ShakeDetectionSubRegionResponseCopyWithImpl;
@useResult
$Res call({
 String id, String code, String name
});




}
/// @nodoc
class _$ShakeDetectionSubRegionResponseCopyWithImpl<$Res>
    implements $ShakeDetectionSubRegionResponseCopyWith<$Res> {
  _$ShakeDetectionSubRegionResponseCopyWithImpl(this._self, this._then);

  final ShakeDetectionSubRegionResponse _self;
  final $Res Function(ShakeDetectionSubRegionResponse) _then;

/// Create a copy of ShakeDetectionSubRegionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,}) {
  return _then(ShakeDetectionSubRegionResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionSubRegionResponse].
extension ShakeDetectionSubRegionResponsePatterns on ShakeDetectionSubRegionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionSubRegionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionSubRegionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionSubRegionResponse value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSubRegionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionSubRegionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSubRegionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionSubRegionResponse() when $default != null:
return $default(_that.id,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String name)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSubRegionResponse():
return $default(_that.id,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String name)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSubRegionResponse() when $default != null:
return $default(_that.id,_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShakeDetectionSubRegionResponse implements ShakeDetectionSubRegionResponse {
  const _ShakeDetectionSubRegionResponse({required this.id, required this.code, required this.name});
  factory _ShakeDetectionSubRegionResponse.fromJson(Map<String, dynamic> json) => _$ShakeDetectionSubRegionResponseFromJson(json);

@override final  String id;
/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
@override final  String code;
@override final  String name;

/// Create a copy of ShakeDetectionSubRegionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionSubRegionResponseCopyWith<_ShakeDetectionSubRegionResponse> get copyWith => __$ShakeDetectionSubRegionResponseCopyWithImpl<_ShakeDetectionSubRegionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionSubRegionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionSubRegionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name);

@override
String toString() {
  return 'ShakeDetectionSubRegionResponse(id: $id, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionSubRegionResponseCopyWith<$Res> implements $ShakeDetectionSubRegionResponseCopyWith<$Res> {
  factory _$ShakeDetectionSubRegionResponseCopyWith(_ShakeDetectionSubRegionResponse value, $Res Function(_ShakeDetectionSubRegionResponse) _then) = __$ShakeDetectionSubRegionResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String name
});




}
/// @nodoc
class __$ShakeDetectionSubRegionResponseCopyWithImpl<$Res>
    implements _$ShakeDetectionSubRegionResponseCopyWith<$Res> {
  __$ShakeDetectionSubRegionResponseCopyWithImpl(this._self, this._then);

  final _ShakeDetectionSubRegionResponse _self;
  final $Res Function(_ShakeDetectionSubRegionResponse) _then;

/// Create a copy of ShakeDetectionSubRegionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,}) {
  return _then(_ShakeDetectionSubRegionResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
