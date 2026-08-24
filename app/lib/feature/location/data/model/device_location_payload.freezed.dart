// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_location_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceLocationPayload {

 String get region; String? get city;@JsonKey(name: 'tsunamiForecastRegion') String? get tsunamiForecastRegion;
/// Create a copy of DeviceLocationPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceLocationPayloadCopyWith<DeviceLocationPayload> get copyWith => _$DeviceLocationPayloadCopyWithImpl<DeviceLocationPayload>(this as DeviceLocationPayload, _$identity);

  /// Serializes this DeviceLocationPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceLocationPayload&&(identical(other.region, region) || other.region == region)&&(identical(other.city, city) || other.city == city)&&(identical(other.tsunamiForecastRegion, tsunamiForecastRegion) || other.tsunamiForecastRegion == tsunamiForecastRegion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,city,tsunamiForecastRegion);

@override
String toString() {
  return 'DeviceLocationPayload(region: $region, city: $city, tsunamiForecastRegion: $tsunamiForecastRegion)';
}


}

/// @nodoc
abstract mixin class $DeviceLocationPayloadCopyWith<$Res>  {
  factory $DeviceLocationPayloadCopyWith(DeviceLocationPayload value, $Res Function(DeviceLocationPayload) _then) = _$DeviceLocationPayloadCopyWithImpl;
@useResult
$Res call({
 String region, String? city,@JsonKey(name: 'tsunamiForecastRegion') String? tsunamiForecastRegion
});




}
/// @nodoc
class _$DeviceLocationPayloadCopyWithImpl<$Res>
    implements $DeviceLocationPayloadCopyWith<$Res> {
  _$DeviceLocationPayloadCopyWithImpl(this._self, this._then);

  final DeviceLocationPayload _self;
  final $Res Function(DeviceLocationPayload) _then;

/// Create a copy of DeviceLocationPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? city = freezed,Object? tsunamiForecastRegion = freezed,}) {
  return _then(DeviceLocationPayload(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,tsunamiForecastRegion: freezed == tsunamiForecastRegion ? _self.tsunamiForecastRegion : tsunamiForecastRegion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceLocationPayload].
extension DeviceLocationPayloadPatterns on DeviceLocationPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceLocationPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceLocationPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceLocationPayload value)  $default,){
final _that = this;
switch (_that) {
case _DeviceLocationPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceLocationPayload value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceLocationPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String region,  String? city, @JsonKey(name: 'tsunamiForecastRegion')  String? tsunamiForecastRegion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceLocationPayload() when $default != null:
return $default(_that.region,_that.city,_that.tsunamiForecastRegion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String region,  String? city, @JsonKey(name: 'tsunamiForecastRegion')  String? tsunamiForecastRegion)  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationPayload():
return $default(_that.region,_that.city,_that.tsunamiForecastRegion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String region,  String? city, @JsonKey(name: 'tsunamiForecastRegion')  String? tsunamiForecastRegion)?  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationPayload() when $default != null:
return $default(_that.region,_that.city,_that.tsunamiForecastRegion);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _DeviceLocationPayload implements DeviceLocationPayload {
  const _DeviceLocationPayload({required this.region, this.city, @JsonKey(name: 'tsunamiForecastRegion') this.tsunamiForecastRegion});
  factory _DeviceLocationPayload.fromJson(Map<String, dynamic> json) => _$DeviceLocationPayloadFromJson(json);

@override final  String region;
@override final  String? city;
@override@JsonKey(name: 'tsunamiForecastRegion') final  String? tsunamiForecastRegion;

/// Create a copy of DeviceLocationPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceLocationPayloadCopyWith<_DeviceLocationPayload> get copyWith => __$DeviceLocationPayloadCopyWithImpl<_DeviceLocationPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceLocationPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceLocationPayload&&(identical(other.region, region) || other.region == region)&&(identical(other.city, city) || other.city == city)&&(identical(other.tsunamiForecastRegion, tsunamiForecastRegion) || other.tsunamiForecastRegion == tsunamiForecastRegion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,city,tsunamiForecastRegion);

@override
String toString() {
  return 'DeviceLocationPayload(region: $region, city: $city, tsunamiForecastRegion: $tsunamiForecastRegion)';
}


}

/// @nodoc
abstract mixin class _$DeviceLocationPayloadCopyWith<$Res> implements $DeviceLocationPayloadCopyWith<$Res> {
  factory _$DeviceLocationPayloadCopyWith(_DeviceLocationPayload value, $Res Function(_DeviceLocationPayload) _then) = __$DeviceLocationPayloadCopyWithImpl;
@override @useResult
$Res call({
 String region, String? city,@JsonKey(name: 'tsunamiForecastRegion') String? tsunamiForecastRegion
});




}
/// @nodoc
class __$DeviceLocationPayloadCopyWithImpl<$Res>
    implements _$DeviceLocationPayloadCopyWith<$Res> {
  __$DeviceLocationPayloadCopyWithImpl(this._self, this._then);

  final _DeviceLocationPayload _self;
  final $Res Function(_DeviceLocationPayload) _then;

/// Create a copy of DeviceLocationPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? city = freezed,Object? tsunamiForecastRegion = freezed,}) {
  return _then(_DeviceLocationPayload(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,tsunamiForecastRegion: freezed == tsunamiForecastRegion ? _self.tsunamiForecastRegion : tsunamiForecastRegion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
