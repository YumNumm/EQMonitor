// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationRegion {

 int get regionId; String? get regionName; bool get isCurrentLocation; JmaIntensity get minJmaIntensity;// 市区町村コード (NULL = region 単位の通知設定)。
// EEW 設定では常に NULL (EEW は area_forecast_local_eew コード単位のみ対応)。
 String? get cityCode; String? get cityName;
/// Create a copy of NotificationRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationRegionCopyWith<NotificationRegion> get copyWith => _$NotificationRegionCopyWithImpl<NotificationRegion>(this as NotificationRegion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationRegion&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName));
}


@override
int get hashCode => Object.hash(runtimeType,regionId,regionName,isCurrentLocation,minJmaIntensity,cityCode,cityName);

@override
String toString() {
  return 'NotificationRegion(regionId: $regionId, regionName: $regionName, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity, cityCode: $cityCode, cityName: $cityName)';
}


}

/// @nodoc
abstract mixin class $NotificationRegionCopyWith<$Res>  {
  factory $NotificationRegionCopyWith(NotificationRegion value, $Res Function(NotificationRegion) _then) = _$NotificationRegionCopyWithImpl;
@useResult
$Res call({
 int regionId, String? regionName, bool isCurrentLocation, JmaIntensity minJmaIntensity, String? cityCode, String? cityName
});




}
/// @nodoc
class _$NotificationRegionCopyWithImpl<$Res>
    implements $NotificationRegionCopyWith<$Res> {
  _$NotificationRegionCopyWithImpl(this._self, this._then);

  final NotificationRegion _self;
  final $Res Function(NotificationRegion) _then;

/// Create a copy of NotificationRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionId = null,Object? regionName = freezed,Object? isCurrentLocation = null,Object? minJmaIntensity = null,Object? cityCode = freezed,Object? cityName = freezed,}) {
  return _then(_self.copyWith(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationRegion].
extension NotificationRegionPatterns on NotificationRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationRegion value)  $default,){
final _that = this;
switch (_that) {
case _NotificationRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationRegion value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int regionId,  String? regionName,  bool isCurrentLocation,  JmaIntensity minJmaIntensity,  String? cityCode,  String? cityName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationRegion() when $default != null:
return $default(_that.regionId,_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity,_that.cityCode,_that.cityName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int regionId,  String? regionName,  bool isCurrentLocation,  JmaIntensity minJmaIntensity,  String? cityCode,  String? cityName)  $default,) {final _that = this;
switch (_that) {
case _NotificationRegion():
return $default(_that.regionId,_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity,_that.cityCode,_that.cityName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int regionId,  String? regionName,  bool isCurrentLocation,  JmaIntensity minJmaIntensity,  String? cityCode,  String? cityName)?  $default,) {final _that = this;
switch (_that) {
case _NotificationRegion() when $default != null:
return $default(_that.regionId,_that.regionName,_that.isCurrentLocation,_that.minJmaIntensity,_that.cityCode,_that.cityName);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationRegion implements NotificationRegion {
  const _NotificationRegion({required this.regionId, required this.regionName, required this.isCurrentLocation, required this.minJmaIntensity, this.cityCode = null, this.cityName = null});
  

@override final  int regionId;
@override final  String? regionName;
@override final  bool isCurrentLocation;
@override final  JmaIntensity minJmaIntensity;
// 市区町村コード (NULL = region 単位の通知設定)。
// EEW 設定では常に NULL (EEW は area_forecast_local_eew コード単位のみ対応)。
@override@JsonKey() final  String? cityCode;
@override@JsonKey() final  String? cityName;

/// Create a copy of NotificationRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationRegionCopyWith<_NotificationRegion> get copyWith => __$NotificationRegionCopyWithImpl<_NotificationRegion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationRegion&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName));
}


@override
int get hashCode => Object.hash(runtimeType,regionId,regionName,isCurrentLocation,minJmaIntensity,cityCode,cityName);

@override
String toString() {
  return 'NotificationRegion(regionId: $regionId, regionName: $regionName, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity, cityCode: $cityCode, cityName: $cityName)';
}


}

/// @nodoc
abstract mixin class _$NotificationRegionCopyWith<$Res> implements $NotificationRegionCopyWith<$Res> {
  factory _$NotificationRegionCopyWith(_NotificationRegion value, $Res Function(_NotificationRegion) _then) = __$NotificationRegionCopyWithImpl;
@override @useResult
$Res call({
 int regionId, String? regionName, bool isCurrentLocation, JmaIntensity minJmaIntensity, String? cityCode, String? cityName
});




}
/// @nodoc
class __$NotificationRegionCopyWithImpl<$Res>
    implements _$NotificationRegionCopyWith<$Res> {
  __$NotificationRegionCopyWithImpl(this._self, this._then);

  final _NotificationRegion _self;
  final $Res Function(_NotificationRegion) _then;

/// Create a copy of NotificationRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionId = null,Object? regionName = freezed,Object? isCurrentLocation = null,Object? minJmaIntensity = null,Object? cityCode = freezed,Object? cityName = freezed,}) {
  return _then(_NotificationRegion(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
