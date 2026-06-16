// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_telegram_body_intensity_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeTelegramBodyIntensityRegion {

 String get code; String get name;@JsonKey(includeIfNull: false) String? get eventId;@JsonKey(includeIfNull: false) JmaIntensity? get intensity;@JsonKey(includeIfNull: false) JmaLpgmIntensity? get lpgmIntensity;@JsonKey(includeIfNull: false) EarthquakeDatasource? get datasource;
/// Create a copy of EarthquakeTelegramBodyIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyIntensityRegionCopyWith<EarthquakeTelegramBodyIntensityRegion> get copyWith => _$EarthquakeTelegramBodyIntensityRegionCopyWithImpl<EarthquakeTelegramBodyIntensityRegion>(this as EarthquakeTelegramBodyIntensityRegion, _$identity);

  /// Serializes this EarthquakeTelegramBodyIntensityRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeTelegramBodyIntensityRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.datasource, datasource) || other.datasource == datasource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,eventId,intensity,lpgmIntensity,datasource);

@override
String toString() {
  return 'EarthquakeTelegramBodyIntensityRegion(code: $code, name: $name, eventId: $eventId, intensity: $intensity, lpgmIntensity: $lpgmIntensity, datasource: $datasource)';
}


}

/// @nodoc
abstract mixin class $EarthquakeTelegramBodyIntensityRegionCopyWith<$Res>  {
  factory $EarthquakeTelegramBodyIntensityRegionCopyWith(EarthquakeTelegramBodyIntensityRegion value, $Res Function(EarthquakeTelegramBodyIntensityRegion) _then) = _$EarthquakeTelegramBodyIntensityRegionCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(includeIfNull: false) String? eventId,@JsonKey(includeIfNull: false) JmaIntensity? intensity,@JsonKey(includeIfNull: false) JmaLpgmIntensity? lpgmIntensity,@JsonKey(includeIfNull: false) EarthquakeDatasource? datasource
});




}
/// @nodoc
class _$EarthquakeTelegramBodyIntensityRegionCopyWithImpl<$Res>
    implements $EarthquakeTelegramBodyIntensityRegionCopyWith<$Res> {
  _$EarthquakeTelegramBodyIntensityRegionCopyWithImpl(this._self, this._then);

  final EarthquakeTelegramBodyIntensityRegion _self;
  final $Res Function(EarthquakeTelegramBodyIntensityRegion) _then;

/// Create a copy of EarthquakeTelegramBodyIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? eventId = freezed,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? datasource = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,datasource: freezed == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDatasource?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeTelegramBodyIntensityRegion].
extension EarthquakeTelegramBodyIntensityRegionPatterns on EarthquakeTelegramBodyIntensityRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyIntensityRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyIntensityRegion value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeTelegramBodyIntensityRegion value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(includeIfNull: false)  String? eventId, @JsonKey(includeIfNull: false)  JmaIntensity? intensity, @JsonKey(includeIfNull: false)  JmaLpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: false)  EarthquakeDatasource? datasource)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegion() when $default != null:
return $default(_that.code,_that.name,_that.eventId,_that.intensity,_that.lpgmIntensity,_that.datasource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(includeIfNull: false)  String? eventId, @JsonKey(includeIfNull: false)  JmaIntensity? intensity, @JsonKey(includeIfNull: false)  JmaLpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: false)  EarthquakeDatasource? datasource)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegion():
return $default(_that.code,_that.name,_that.eventId,_that.intensity,_that.lpgmIntensity,_that.datasource);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name, @JsonKey(includeIfNull: false)  String? eventId, @JsonKey(includeIfNull: false)  JmaIntensity? intensity, @JsonKey(includeIfNull: false)  JmaLpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: false)  EarthquakeDatasource? datasource)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegion() when $default != null:
return $default(_that.code,_that.name,_that.eventId,_that.intensity,_that.lpgmIntensity,_that.datasource);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeTelegramBodyIntensityRegion implements EarthquakeTelegramBodyIntensityRegion {
  const _EarthquakeTelegramBodyIntensityRegion({required this.code, required this.name, @JsonKey(includeIfNull: false) this.eventId, @JsonKey(includeIfNull: false) this.intensity, @JsonKey(includeIfNull: false) this.lpgmIntensity, @JsonKey(includeIfNull: false) this.datasource});
  factory _EarthquakeTelegramBodyIntensityRegion.fromJson(Map<String, dynamic> json) => _$EarthquakeTelegramBodyIntensityRegionFromJson(json);

@override final  String code;
@override final  String name;
@override@JsonKey(includeIfNull: false) final  String? eventId;
@override@JsonKey(includeIfNull: false) final  JmaIntensity? intensity;
@override@JsonKey(includeIfNull: false) final  JmaLpgmIntensity? lpgmIntensity;
@override@JsonKey(includeIfNull: false) final  EarthquakeDatasource? datasource;

/// Create a copy of EarthquakeTelegramBodyIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeTelegramBodyIntensityRegionCopyWith<_EarthquakeTelegramBodyIntensityRegion> get copyWith => __$EarthquakeTelegramBodyIntensityRegionCopyWithImpl<_EarthquakeTelegramBodyIntensityRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeTelegramBodyIntensityRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeTelegramBodyIntensityRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.datasource, datasource) || other.datasource == datasource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,eventId,intensity,lpgmIntensity,datasource);

@override
String toString() {
  return 'EarthquakeTelegramBodyIntensityRegion(code: $code, name: $name, eventId: $eventId, intensity: $intensity, lpgmIntensity: $lpgmIntensity, datasource: $datasource)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeTelegramBodyIntensityRegionCopyWith<$Res> implements $EarthquakeTelegramBodyIntensityRegionCopyWith<$Res> {
  factory _$EarthquakeTelegramBodyIntensityRegionCopyWith(_EarthquakeTelegramBodyIntensityRegion value, $Res Function(_EarthquakeTelegramBodyIntensityRegion) _then) = __$EarthquakeTelegramBodyIntensityRegionCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(includeIfNull: false) String? eventId,@JsonKey(includeIfNull: false) JmaIntensity? intensity,@JsonKey(includeIfNull: false) JmaLpgmIntensity? lpgmIntensity,@JsonKey(includeIfNull: false) EarthquakeDatasource? datasource
});




}
/// @nodoc
class __$EarthquakeTelegramBodyIntensityRegionCopyWithImpl<$Res>
    implements _$EarthquakeTelegramBodyIntensityRegionCopyWith<$Res> {
  __$EarthquakeTelegramBodyIntensityRegionCopyWithImpl(this._self, this._then);

  final _EarthquakeTelegramBodyIntensityRegion _self;
  final $Res Function(_EarthquakeTelegramBodyIntensityRegion) _then;

/// Create a copy of EarthquakeTelegramBodyIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? eventId = freezed,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? datasource = freezed,}) {
  return _then(_EarthquakeTelegramBodyIntensityRegion(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,datasource: freezed == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDatasource?,
  ));
}


}

// dart format on
