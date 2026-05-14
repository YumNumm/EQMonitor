// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_observation_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinObservationPoint {

 KyoshinObservationPointType get type;@JsonKey(name: 'source_type') String get sourceType; String get name; String get code;@JsonKey(includeIfNull: true, name: 'prefecture_code') String? get prefectureCode;@JsonKey(includeIfNull: true, name: 'region_code') String? get regionCode;@JsonKey(name: 'is_suspended') bool get isSuspended; ParameterLocation get location;@JsonKey(includeIfNull: true) KyoshinObservationPointMapPoint? get point;@JsonKey(includeIfNull: true, name: 'arv_400') num? get arv400;
/// Create a copy of KyoshinObservationPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinObservationPointCopyWith<KyoshinObservationPoint> get copyWith => _$KyoshinObservationPointCopyWithImpl<KyoshinObservationPoint>(this as KyoshinObservationPoint, _$identity);

  /// Serializes this KyoshinObservationPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinObservationPoint&&(identical(other.type, type) || other.type == type)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.isSuspended, isSuspended) || other.isSuspended == isSuspended)&&(identical(other.location, location) || other.location == location)&&(identical(other.point, point) || other.point == point)&&(identical(other.arv400, arv400) || other.arv400 == arv400));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,sourceType,name,code,prefectureCode,regionCode,isSuspended,location,point,arv400);

@override
String toString() {
  return 'KyoshinObservationPoint(type: $type, sourceType: $sourceType, name: $name, code: $code, prefectureCode: $prefectureCode, regionCode: $regionCode, isSuspended: $isSuspended, location: $location, point: $point, arv400: $arv400)';
}


}

/// @nodoc
abstract mixin class $KyoshinObservationPointCopyWith<$Res>  {
  factory $KyoshinObservationPointCopyWith(KyoshinObservationPoint value, $Res Function(KyoshinObservationPoint) _then) = _$KyoshinObservationPointCopyWithImpl;
@useResult
$Res call({
 KyoshinObservationPointType type,@JsonKey(name: 'source_type') String sourceType, String name, String code,@JsonKey(includeIfNull: true, name: 'prefecture_code') String? prefectureCode,@JsonKey(includeIfNull: true, name: 'region_code') String? regionCode,@JsonKey(name: 'is_suspended') bool isSuspended, ParameterLocation location,@JsonKey(includeIfNull: true) KyoshinObservationPointMapPoint? point,@JsonKey(includeIfNull: true, name: 'arv_400') num? arv400
});


$ParameterLocationCopyWith<$Res> get location;$KyoshinObservationPointMapPointCopyWith<$Res>? get point;

}
/// @nodoc
class _$KyoshinObservationPointCopyWithImpl<$Res>
    implements $KyoshinObservationPointCopyWith<$Res> {
  _$KyoshinObservationPointCopyWithImpl(this._self, this._then);

  final KyoshinObservationPoint _self;
  final $Res Function(KyoshinObservationPoint) _then;

/// Create a copy of KyoshinObservationPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? sourceType = null,Object? name = null,Object? code = null,Object? prefectureCode = freezed,Object? regionCode = freezed,Object? isSuspended = null,Object? location = null,Object? point = freezed,Object? arv400 = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointType,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,isSuspended: null == isSuspended ? _self.isSuspended : isSuspended // ignore: cast_nullable_to_non_nullable
as bool,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as ParameterLocation,point: freezed == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointMapPoint?,arv400: freezed == arv400 ? _self.arv400 : arv400 // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}
/// Create a copy of KyoshinObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterLocationCopyWith<$Res> get location {
  
  return $ParameterLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of KyoshinObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinObservationPointMapPointCopyWith<$Res>? get point {
    if (_self.point == null) {
    return null;
  }

  return $KyoshinObservationPointMapPointCopyWith<$Res>(_self.point!, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}


/// Adds pattern-matching-related methods to [KyoshinObservationPoint].
extension KyoshinObservationPointPatterns on KyoshinObservationPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinObservationPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinObservationPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinObservationPoint value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinObservationPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinObservationPoint value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinObservationPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KyoshinObservationPointType type, @JsonKey(name: 'source_type')  String sourceType,  String name,  String code, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'region_code')  String? regionCode, @JsonKey(name: 'is_suspended')  bool isSuspended,  ParameterLocation location, @JsonKey(includeIfNull: true)  KyoshinObservationPointMapPoint? point, @JsonKey(includeIfNull: true, name: 'arv_400')  num? arv400)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinObservationPoint() when $default != null:
return $default(_that.type,_that.sourceType,_that.name,_that.code,_that.prefectureCode,_that.regionCode,_that.isSuspended,_that.location,_that.point,_that.arv400);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KyoshinObservationPointType type, @JsonKey(name: 'source_type')  String sourceType,  String name,  String code, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'region_code')  String? regionCode, @JsonKey(name: 'is_suspended')  bool isSuspended,  ParameterLocation location, @JsonKey(includeIfNull: true)  KyoshinObservationPointMapPoint? point, @JsonKey(includeIfNull: true, name: 'arv_400')  num? arv400)  $default,) {final _that = this;
switch (_that) {
case _KyoshinObservationPoint():
return $default(_that.type,_that.sourceType,_that.name,_that.code,_that.prefectureCode,_that.regionCode,_that.isSuspended,_that.location,_that.point,_that.arv400);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KyoshinObservationPointType type, @JsonKey(name: 'source_type')  String sourceType,  String name,  String code, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'region_code')  String? regionCode, @JsonKey(name: 'is_suspended')  bool isSuspended,  ParameterLocation location, @JsonKey(includeIfNull: true)  KyoshinObservationPointMapPoint? point, @JsonKey(includeIfNull: true, name: 'arv_400')  num? arv400)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinObservationPoint() when $default != null:
return $default(_that.type,_that.sourceType,_that.name,_that.code,_that.prefectureCode,_that.regionCode,_that.isSuspended,_that.location,_that.point,_that.arv400);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinObservationPoint implements KyoshinObservationPoint {
  const _KyoshinObservationPoint({required this.type, @JsonKey(name: 'source_type') required this.sourceType, required this.name, required this.code, @JsonKey(includeIfNull: true, name: 'prefecture_code') required this.prefectureCode, @JsonKey(includeIfNull: true, name: 'region_code') required this.regionCode, @JsonKey(name: 'is_suspended') required this.isSuspended, required this.location, @JsonKey(includeIfNull: true) required this.point, @JsonKey(includeIfNull: true, name: 'arv_400') required this.arv400});
  factory _KyoshinObservationPoint.fromJson(Map<String, dynamic> json) => _$KyoshinObservationPointFromJson(json);

@override final  KyoshinObservationPointType type;
@override@JsonKey(name: 'source_type') final  String sourceType;
@override final  String name;
@override final  String code;
@override@JsonKey(includeIfNull: true, name: 'prefecture_code') final  String? prefectureCode;
@override@JsonKey(includeIfNull: true, name: 'region_code') final  String? regionCode;
@override@JsonKey(name: 'is_suspended') final  bool isSuspended;
@override final  ParameterLocation location;
@override@JsonKey(includeIfNull: true) final  KyoshinObservationPointMapPoint? point;
@override@JsonKey(includeIfNull: true, name: 'arv_400') final  num? arv400;

/// Create a copy of KyoshinObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinObservationPointCopyWith<_KyoshinObservationPoint> get copyWith => __$KyoshinObservationPointCopyWithImpl<_KyoshinObservationPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinObservationPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinObservationPoint&&(identical(other.type, type) || other.type == type)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.isSuspended, isSuspended) || other.isSuspended == isSuspended)&&(identical(other.location, location) || other.location == location)&&(identical(other.point, point) || other.point == point)&&(identical(other.arv400, arv400) || other.arv400 == arv400));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,sourceType,name,code,prefectureCode,regionCode,isSuspended,location,point,arv400);

@override
String toString() {
  return 'KyoshinObservationPoint(type: $type, sourceType: $sourceType, name: $name, code: $code, prefectureCode: $prefectureCode, regionCode: $regionCode, isSuspended: $isSuspended, location: $location, point: $point, arv400: $arv400)';
}


}

/// @nodoc
abstract mixin class _$KyoshinObservationPointCopyWith<$Res> implements $KyoshinObservationPointCopyWith<$Res> {
  factory _$KyoshinObservationPointCopyWith(_KyoshinObservationPoint value, $Res Function(_KyoshinObservationPoint) _then) = __$KyoshinObservationPointCopyWithImpl;
@override @useResult
$Res call({
 KyoshinObservationPointType type,@JsonKey(name: 'source_type') String sourceType, String name, String code,@JsonKey(includeIfNull: true, name: 'prefecture_code') String? prefectureCode,@JsonKey(includeIfNull: true, name: 'region_code') String? regionCode,@JsonKey(name: 'is_suspended') bool isSuspended, ParameterLocation location,@JsonKey(includeIfNull: true) KyoshinObservationPointMapPoint? point,@JsonKey(includeIfNull: true, name: 'arv_400') num? arv400
});


@override $ParameterLocationCopyWith<$Res> get location;@override $KyoshinObservationPointMapPointCopyWith<$Res>? get point;

}
/// @nodoc
class __$KyoshinObservationPointCopyWithImpl<$Res>
    implements _$KyoshinObservationPointCopyWith<$Res> {
  __$KyoshinObservationPointCopyWithImpl(this._self, this._then);

  final _KyoshinObservationPoint _self;
  final $Res Function(_KyoshinObservationPoint) _then;

/// Create a copy of KyoshinObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? sourceType = null,Object? name = null,Object? code = null,Object? prefectureCode = freezed,Object? regionCode = freezed,Object? isSuspended = null,Object? location = null,Object? point = freezed,Object? arv400 = freezed,}) {
  return _then(_KyoshinObservationPoint(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointType,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,isSuspended: null == isSuspended ? _self.isSuspended : isSuspended // ignore: cast_nullable_to_non_nullable
as bool,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as ParameterLocation,point: freezed == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointMapPoint?,arv400: freezed == arv400 ? _self.arv400 : arv400 // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

/// Create a copy of KyoshinObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterLocationCopyWith<$Res> get location {
  
  return $ParameterLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of KyoshinObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinObservationPointMapPointCopyWith<$Res>? get point {
    if (_self.point == null) {
    return null;
  }

  return $KyoshinObservationPointMapPointCopyWith<$Res>(_self.point!, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}

// dart format on
