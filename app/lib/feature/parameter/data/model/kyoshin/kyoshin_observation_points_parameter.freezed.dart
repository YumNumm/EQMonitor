// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_observation_points_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinObservationPointsParameter {

 ParameterMetadata get metadata; List<KyoshinObservationPoint> get points;
/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinObservationPointsParameterCopyWith<KyoshinObservationPointsParameter> get copyWith => _$KyoshinObservationPointsParameterCopyWithImpl<KyoshinObservationPointsParameter>(this as KyoshinObservationPointsParameter, _$identity);

  /// Serializes this KyoshinObservationPointsParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinObservationPointsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.points, points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(points));

@override
String toString() {
  return 'KyoshinObservationPointsParameter(metadata: $metadata, points: $points)';
}


}

/// @nodoc
abstract mixin class $KyoshinObservationPointsParameterCopyWith<$Res>  {
  factory $KyoshinObservationPointsParameterCopyWith(KyoshinObservationPointsParameter value, $Res Function(KyoshinObservationPointsParameter) _then) = _$KyoshinObservationPointsParameterCopyWithImpl;
@useResult
$Res call({
 ParameterMetadata metadata, List<KyoshinObservationPoint> points
});


$ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$KyoshinObservationPointsParameterCopyWithImpl<$Res>
    implements $KyoshinObservationPointsParameterCopyWith<$Res> {
  _$KyoshinObservationPointsParameterCopyWithImpl(this._self, this._then);

  final KyoshinObservationPointsParameter _self;
  final $Res Function(KyoshinObservationPointsParameter) _then;

/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? points = null,}) {
  return _then(KyoshinObservationPointsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<KyoshinObservationPoint>,
  ));
}
/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {
  
  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [KyoshinObservationPointsParameter].
extension KyoshinObservationPointsParameterPatterns on KyoshinObservationPointsParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinObservationPointsParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinObservationPointsParameter value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinObservationPointsParameter value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  List<KyoshinObservationPoint> points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter() when $default != null:
return $default(_that.metadata,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  List<KyoshinObservationPoint> points)  $default,) {final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter():
return $default(_that.metadata,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ParameterMetadata metadata,  List<KyoshinObservationPoint> points)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter() when $default != null:
return $default(_that.metadata,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinObservationPointsParameter implements KyoshinObservationPointsParameter {
  const _KyoshinObservationPointsParameter({required this.metadata, required  List<KyoshinObservationPoint> points}): _points = points;
  factory _KyoshinObservationPointsParameter.fromJson(Map<String, dynamic> json) => _$KyoshinObservationPointsParameterFromJson(json);

@override final  ParameterMetadata metadata;
 final  List<KyoshinObservationPoint> _points;
@override List<KyoshinObservationPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinObservationPointsParameterCopyWith<_KyoshinObservationPointsParameter> get copyWith => __$KyoshinObservationPointsParameterCopyWithImpl<_KyoshinObservationPointsParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinObservationPointsParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinObservationPointsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._points, _points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'KyoshinObservationPointsParameter(metadata: $metadata, points: $points)';
}


}

/// @nodoc
abstract mixin class _$KyoshinObservationPointsParameterCopyWith<$Res> implements $KyoshinObservationPointsParameterCopyWith<$Res> {
  factory _$KyoshinObservationPointsParameterCopyWith(_KyoshinObservationPointsParameter value, $Res Function(_KyoshinObservationPointsParameter) _then) = __$KyoshinObservationPointsParameterCopyWithImpl;
@override @useResult
$Res call({
 ParameterMetadata metadata, List<KyoshinObservationPoint> points
});


@override $ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$KyoshinObservationPointsParameterCopyWithImpl<$Res>
    implements _$KyoshinObservationPointsParameterCopyWith<$Res> {
  __$KyoshinObservationPointsParameterCopyWithImpl(this._self, this._then);

  final _KyoshinObservationPointsParameter _self;
  final $Res Function(_KyoshinObservationPointsParameter) _then;

/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? points = null,}) {
  return _then(_KyoshinObservationPointsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<KyoshinObservationPoint>,
  ));
}

/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {
  
  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// @nodoc
mixin _$KyoshinObservationPoint {

 KyoshinObservationPointType get type;@JsonKey(name: 'source_type') String get sourceType; String get name; String get code;@JsonKey(name: 'prefecture_code') String? get prefectureCode;@JsonKey(name: 'region_code') String? get regionCode;@JsonKey(name: 'is_suspended') bool get isSuspended; LatLng get location; KyoshinObservationPointMapPoint? get point;@JsonKey(name: 'arv_400') double? get arv400;
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
 KyoshinObservationPointType type,@JsonKey(name: 'source_type') String sourceType, String name, String code,@JsonKey(name: 'prefecture_code') String? prefectureCode,@JsonKey(name: 'region_code') String? regionCode,@JsonKey(name: 'is_suspended') bool isSuspended, LatLng location, KyoshinObservationPointMapPoint? point,@JsonKey(name: 'arv_400') double? arv400
});


$KyoshinObservationPointMapPointCopyWith<$Res>? get point;

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
  return _then(KyoshinObservationPoint(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointType,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,isSuspended: null == isSuspended ? _self.isSuspended : isSuspended // ignore: cast_nullable_to_non_nullable
as bool,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,point: freezed == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointMapPoint?,arv400: freezed == arv400 ? _self.arv400 : arv400 // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of KyoshinObservationPoint
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KyoshinObservationPointType type, @JsonKey(name: 'source_type')  String sourceType,  String name,  String code, @JsonKey(name: 'prefecture_code')  String? prefectureCode, @JsonKey(name: 'region_code')  String? regionCode, @JsonKey(name: 'is_suspended')  bool isSuspended,  LatLng location,  KyoshinObservationPointMapPoint? point, @JsonKey(name: 'arv_400')  double? arv400)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KyoshinObservationPointType type, @JsonKey(name: 'source_type')  String sourceType,  String name,  String code, @JsonKey(name: 'prefecture_code')  String? prefectureCode, @JsonKey(name: 'region_code')  String? regionCode, @JsonKey(name: 'is_suspended')  bool isSuspended,  LatLng location,  KyoshinObservationPointMapPoint? point, @JsonKey(name: 'arv_400')  double? arv400)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KyoshinObservationPointType type, @JsonKey(name: 'source_type')  String sourceType,  String name,  String code, @JsonKey(name: 'prefecture_code')  String? prefectureCode, @JsonKey(name: 'region_code')  String? regionCode, @JsonKey(name: 'is_suspended')  bool isSuspended,  LatLng location,  KyoshinObservationPointMapPoint? point, @JsonKey(name: 'arv_400')  double? arv400)?  $default,) {final _that = this;
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
  const _KyoshinObservationPoint({required this.type, @JsonKey(name: 'source_type') required this.sourceType, required this.name, required this.code, @JsonKey(name: 'prefecture_code') required this.prefectureCode, @JsonKey(name: 'region_code') required this.regionCode, @JsonKey(name: 'is_suspended') required this.isSuspended, required this.location, required this.point, @JsonKey(name: 'arv_400') required this.arv400});
  factory _KyoshinObservationPoint.fromJson(Map<String, dynamic> json) => _$KyoshinObservationPointFromJson(json);

@override final  KyoshinObservationPointType type;
@override@JsonKey(name: 'source_type') final  String sourceType;
@override final  String name;
@override final  String code;
@override@JsonKey(name: 'prefecture_code') final  String? prefectureCode;
@override@JsonKey(name: 'region_code') final  String? regionCode;
@override@JsonKey(name: 'is_suspended') final  bool isSuspended;
@override final  LatLng location;
@override final  KyoshinObservationPointMapPoint? point;
@override@JsonKey(name: 'arv_400') final  double? arv400;

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
 KyoshinObservationPointType type,@JsonKey(name: 'source_type') String sourceType, String name, String code,@JsonKey(name: 'prefecture_code') String? prefectureCode,@JsonKey(name: 'region_code') String? regionCode,@JsonKey(name: 'is_suspended') bool isSuspended, LatLng location, KyoshinObservationPointMapPoint? point,@JsonKey(name: 'arv_400') double? arv400
});


@override $KyoshinObservationPointMapPointCopyWith<$Res>? get point;

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
as LatLng,point: freezed == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointMapPoint?,arv400: freezed == arv400 ? _self.arv400 : arv400 // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of KyoshinObservationPoint
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


/// @nodoc
mixin _$KyoshinObservationPointMapPoint {

@ParameterPointConverter() Point<double> get center;@ParameterPointConverter() Point<double> get offset;
/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinObservationPointMapPointCopyWith<KyoshinObservationPointMapPoint> get copyWith => _$KyoshinObservationPointMapPointCopyWithImpl<KyoshinObservationPointMapPoint>(this as KyoshinObservationPointMapPoint, _$identity);

  /// Serializes this KyoshinObservationPointMapPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinObservationPointMapPoint&&(identical(other.center, center) || other.center == center)&&(identical(other.offset, offset) || other.offset == offset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,center,offset);

@override
String toString() {
  return 'KyoshinObservationPointMapPoint(center: $center, offset: $offset)';
}


}

/// @nodoc
abstract mixin class $KyoshinObservationPointMapPointCopyWith<$Res>  {
  factory $KyoshinObservationPointMapPointCopyWith(KyoshinObservationPointMapPoint value, $Res Function(KyoshinObservationPointMapPoint) _then) = _$KyoshinObservationPointMapPointCopyWithImpl;
@useResult
$Res call({
@ParameterPointConverter() Point<double> center,@ParameterPointConverter() Point<double> offset
});




}
/// @nodoc
class _$KyoshinObservationPointMapPointCopyWithImpl<$Res>
    implements $KyoshinObservationPointMapPointCopyWith<$Res> {
  _$KyoshinObservationPointMapPointCopyWithImpl(this._self, this._then);

  final KyoshinObservationPointMapPoint _self;
  final $Res Function(KyoshinObservationPointMapPoint) _then;

/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? center = null,Object? offset = null,}) {
  return _then(KyoshinObservationPointMapPoint(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Point<double>,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as Point<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [KyoshinObservationPointMapPoint].
extension KyoshinObservationPointMapPointPatterns on KyoshinObservationPointMapPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinObservationPointMapPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinObservationPointMapPoint value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinObservationPointMapPoint value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ParameterPointConverter()  Point<double> center, @ParameterPointConverter()  Point<double> offset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint() when $default != null:
return $default(_that.center,_that.offset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ParameterPointConverter()  Point<double> center, @ParameterPointConverter()  Point<double> offset)  $default,) {final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint():
return $default(_that.center,_that.offset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ParameterPointConverter()  Point<double> center, @ParameterPointConverter()  Point<double> offset)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint() when $default != null:
return $default(_that.center,_that.offset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinObservationPointMapPoint implements KyoshinObservationPointMapPoint {
  const _KyoshinObservationPointMapPoint({@ParameterPointConverter() required this.center, @ParameterPointConverter() required this.offset});
  factory _KyoshinObservationPointMapPoint.fromJson(Map<String, dynamic> json) => _$KyoshinObservationPointMapPointFromJson(json);

@override@ParameterPointConverter() final  Point<double> center;
@override@ParameterPointConverter() final  Point<double> offset;

/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinObservationPointMapPointCopyWith<_KyoshinObservationPointMapPoint> get copyWith => __$KyoshinObservationPointMapPointCopyWithImpl<_KyoshinObservationPointMapPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinObservationPointMapPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinObservationPointMapPoint&&(identical(other.center, center) || other.center == center)&&(identical(other.offset, offset) || other.offset == offset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,center,offset);

@override
String toString() {
  return 'KyoshinObservationPointMapPoint(center: $center, offset: $offset)';
}


}

/// @nodoc
abstract mixin class _$KyoshinObservationPointMapPointCopyWith<$Res> implements $KyoshinObservationPointMapPointCopyWith<$Res> {
  factory _$KyoshinObservationPointMapPointCopyWith(_KyoshinObservationPointMapPoint value, $Res Function(_KyoshinObservationPointMapPoint) _then) = __$KyoshinObservationPointMapPointCopyWithImpl;
@override @useResult
$Res call({
@ParameterPointConverter() Point<double> center,@ParameterPointConverter() Point<double> offset
});




}
/// @nodoc
class __$KyoshinObservationPointMapPointCopyWithImpl<$Res>
    implements _$KyoshinObservationPointMapPointCopyWith<$Res> {
  __$KyoshinObservationPointMapPointCopyWithImpl(this._self, this._then);

  final _KyoshinObservationPointMapPoint _self;
  final $Res Function(_KyoshinObservationPointMapPoint) _then;

/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? center = null,Object? offset = null,}) {
  return _then(_KyoshinObservationPointMapPoint(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Point<double>,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as Point<double>,
  ));
}


}

// dart format on
