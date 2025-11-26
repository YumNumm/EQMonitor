// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'devices_earthquake_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DevicesEarthquakeSettings {

 String get id; JmaForecastIntensity get minJmaIntensity; int get regionId; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of DevicesEarthquakeSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DevicesEarthquakeSettingsCopyWith<DevicesEarthquakeSettings> get copyWith => _$DevicesEarthquakeSettingsCopyWithImpl<DevicesEarthquakeSettings>(this as DevicesEarthquakeSettings, _$identity);

  /// Serializes this DevicesEarthquakeSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DevicesEarthquakeSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,minJmaIntensity,regionId,createdAt,updatedAt);

@override
String toString() {
  return 'DevicesEarthquakeSettings(id: $id, minJmaIntensity: $minJmaIntensity, regionId: $regionId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DevicesEarthquakeSettingsCopyWith<$Res>  {
  factory $DevicesEarthquakeSettingsCopyWith(DevicesEarthquakeSettings value, $Res Function(DevicesEarthquakeSettings) _then) = _$DevicesEarthquakeSettingsCopyWithImpl;
@useResult
$Res call({
 String id, JmaForecastIntensity minJmaIntensity, int regionId, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$DevicesEarthquakeSettingsCopyWithImpl<$Res>
    implements $DevicesEarthquakeSettingsCopyWith<$Res> {
  _$DevicesEarthquakeSettingsCopyWithImpl(this._self, this._then);

  final DevicesEarthquakeSettings _self;
  final $Res Function(DevicesEarthquakeSettings) _then;

/// Create a copy of DevicesEarthquakeSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? minJmaIntensity = null,Object? regionId = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DevicesEarthquakeSettings].
extension DevicesEarthquakeSettingsPatterns on DevicesEarthquakeSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DevicesEarthquakeSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DevicesEarthquakeSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DevicesEarthquakeSettings value)  $default,){
final _that = this;
switch (_that) {
case _DevicesEarthquakeSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DevicesEarthquakeSettings value)?  $default,){
final _that = this;
switch (_that) {
case _DevicesEarthquakeSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  JmaForecastIntensity minJmaIntensity,  int regionId,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DevicesEarthquakeSettings() when $default != null:
return $default(_that.id,_that.minJmaIntensity,_that.regionId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  JmaForecastIntensity minJmaIntensity,  int regionId,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DevicesEarthquakeSettings():
return $default(_that.id,_that.minJmaIntensity,_that.regionId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  JmaForecastIntensity minJmaIntensity,  int regionId,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DevicesEarthquakeSettings() when $default != null:
return $default(_that.id,_that.minJmaIntensity,_that.regionId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DevicesEarthquakeSettings implements DevicesEarthquakeSettings {
  const _DevicesEarthquakeSettings({required this.id, required this.minJmaIntensity, required this.regionId, required this.createdAt, required this.updatedAt});
  factory _DevicesEarthquakeSettings.fromJson(Map<String, dynamic> json) => _$DevicesEarthquakeSettingsFromJson(json);

@override final  String id;
@override final  JmaForecastIntensity minJmaIntensity;
@override final  int regionId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of DevicesEarthquakeSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DevicesEarthquakeSettingsCopyWith<_DevicesEarthquakeSettings> get copyWith => __$DevicesEarthquakeSettingsCopyWithImpl<_DevicesEarthquakeSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DevicesEarthquakeSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DevicesEarthquakeSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,minJmaIntensity,regionId,createdAt,updatedAt);

@override
String toString() {
  return 'DevicesEarthquakeSettings(id: $id, minJmaIntensity: $minJmaIntensity, regionId: $regionId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DevicesEarthquakeSettingsCopyWith<$Res> implements $DevicesEarthquakeSettingsCopyWith<$Res> {
  factory _$DevicesEarthquakeSettingsCopyWith(_DevicesEarthquakeSettings value, $Res Function(_DevicesEarthquakeSettings) _then) = __$DevicesEarthquakeSettingsCopyWithImpl;
@override @useResult
$Res call({
 String id, JmaForecastIntensity minJmaIntensity, int regionId, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$DevicesEarthquakeSettingsCopyWithImpl<$Res>
    implements _$DevicesEarthquakeSettingsCopyWith<$Res> {
  __$DevicesEarthquakeSettingsCopyWithImpl(this._self, this._then);

  final _DevicesEarthquakeSettings _self;
  final $Res Function(_DevicesEarthquakeSettings) _then;

/// Create a copy of DevicesEarthquakeSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? minJmaIntensity = null,Object? regionId = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_DevicesEarthquakeSettings(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
