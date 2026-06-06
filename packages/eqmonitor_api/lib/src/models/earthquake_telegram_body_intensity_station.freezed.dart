// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_telegram_body_intensity_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeTelegramBodyIntensityStation {

 String get eventId; String get code; String get name;@JsonKey(includeIfNull: true) JmaIntensity? get intensity;@JsonKey(includeIfNull: true) JmaLpgmIntensity? get lpgmIntensity;@JsonKey(includeIfNull: true) num? get sva;@JsonKey(includeIfNull: true) List<PrePeriods2>? get prePeriods;
/// Create a copy of EarthquakeTelegramBodyIntensityStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyIntensityStationCopyWith<EarthquakeTelegramBodyIntensityStation> get copyWith => _$EarthquakeTelegramBodyIntensityStationCopyWithImpl<EarthquakeTelegramBodyIntensityStation>(this as EarthquakeTelegramBodyIntensityStation, _$identity);

  /// Serializes this EarthquakeTelegramBodyIntensityStation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeTelegramBodyIntensityStation&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other.prePeriods, prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,code,name,intensity,lpgmIntensity,sva,const DeepCollectionEquality().hash(prePeriods));

@override
String toString() {
  return 'EarthquakeTelegramBodyIntensityStation(eventId: $eventId, code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class $EarthquakeTelegramBodyIntensityStationCopyWith<$Res>  {
  factory $EarthquakeTelegramBodyIntensityStationCopyWith(EarthquakeTelegramBodyIntensityStation value, $Res Function(EarthquakeTelegramBodyIntensityStation) _then) = _$EarthquakeTelegramBodyIntensityStationCopyWithImpl;
@useResult
$Res call({
 String eventId, String code, String name,@JsonKey(includeIfNull: true) JmaIntensity? intensity,@JsonKey(includeIfNull: true) JmaLpgmIntensity? lpgmIntensity,@JsonKey(includeIfNull: true) num? sva,@JsonKey(includeIfNull: true) List<PrePeriods2>? prePeriods
});




}
/// @nodoc
class _$EarthquakeTelegramBodyIntensityStationCopyWithImpl<$Res>
    implements $EarthquakeTelegramBodyIntensityStationCopyWith<$Res> {
  _$EarthquakeTelegramBodyIntensityStationCopyWithImpl(this._self, this._then);

  final EarthquakeTelegramBodyIntensityStation _self;
  final $Res Function(EarthquakeTelegramBodyIntensityStation) _then;

/// Create a copy of EarthquakeTelegramBodyIntensityStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num?,prePeriods: freezed == prePeriods ? _self.prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriods2>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeTelegramBodyIntensityStation].
extension EarthquakeTelegramBodyIntensityStationPatterns on EarthquakeTelegramBodyIntensityStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyIntensityStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyIntensityStation value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeTelegramBodyIntensityStation value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String code,  String name, @JsonKey(includeIfNull: true)  JmaIntensity? intensity, @JsonKey(includeIfNull: true)  JmaLpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: true)  num? sva, @JsonKey(includeIfNull: true)  List<PrePeriods2>? prePeriods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityStation() when $default != null:
return $default(_that.eventId,_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String code,  String name, @JsonKey(includeIfNull: true)  JmaIntensity? intensity, @JsonKey(includeIfNull: true)  JmaLpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: true)  num? sva, @JsonKey(includeIfNull: true)  List<PrePeriods2>? prePeriods)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityStation():
return $default(_that.eventId,_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String code,  String name, @JsonKey(includeIfNull: true)  JmaIntensity? intensity, @JsonKey(includeIfNull: true)  JmaLpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: true)  num? sva, @JsonKey(includeIfNull: true)  List<PrePeriods2>? prePeriods)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityStation() when $default != null:
return $default(_that.eventId,_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeTelegramBodyIntensityStation implements EarthquakeTelegramBodyIntensityStation {
  const _EarthquakeTelegramBodyIntensityStation({required this.eventId, required this.code, required this.name, @JsonKey(includeIfNull: true) required this.intensity, @JsonKey(includeIfNull: true) required this.lpgmIntensity, @JsonKey(includeIfNull: true) required this.sva, @JsonKey(includeIfNull: true) required final  List<PrePeriods2>? prePeriods}): _prePeriods = prePeriods;
  factory _EarthquakeTelegramBodyIntensityStation.fromJson(Map<String, dynamic> json) => _$EarthquakeTelegramBodyIntensityStationFromJson(json);

@override final  String eventId;
@override final  String code;
@override final  String name;
@override@JsonKey(includeIfNull: true) final  JmaIntensity? intensity;
@override@JsonKey(includeIfNull: true) final  JmaLpgmIntensity? lpgmIntensity;
@override@JsonKey(includeIfNull: true) final  num? sva;
 final  List<PrePeriods2>? _prePeriods;
@override@JsonKey(includeIfNull: true) List<PrePeriods2>? get prePeriods {
  final value = _prePeriods;
  if (value == null) return null;
  if (_prePeriods is EqualUnmodifiableListView) return _prePeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EarthquakeTelegramBodyIntensityStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeTelegramBodyIntensityStationCopyWith<_EarthquakeTelegramBodyIntensityStation> get copyWith => __$EarthquakeTelegramBodyIntensityStationCopyWithImpl<_EarthquakeTelegramBodyIntensityStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeTelegramBodyIntensityStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeTelegramBodyIntensityStation&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other._prePeriods, _prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,code,name,intensity,lpgmIntensity,sva,const DeepCollectionEquality().hash(_prePeriods));

@override
String toString() {
  return 'EarthquakeTelegramBodyIntensityStation(eventId: $eventId, code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeTelegramBodyIntensityStationCopyWith<$Res> implements $EarthquakeTelegramBodyIntensityStationCopyWith<$Res> {
  factory _$EarthquakeTelegramBodyIntensityStationCopyWith(_EarthquakeTelegramBodyIntensityStation value, $Res Function(_EarthquakeTelegramBodyIntensityStation) _then) = __$EarthquakeTelegramBodyIntensityStationCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String code, String name,@JsonKey(includeIfNull: true) JmaIntensity? intensity,@JsonKey(includeIfNull: true) JmaLpgmIntensity? lpgmIntensity,@JsonKey(includeIfNull: true) num? sva,@JsonKey(includeIfNull: true) List<PrePeriods2>? prePeriods
});




}
/// @nodoc
class __$EarthquakeTelegramBodyIntensityStationCopyWithImpl<$Res>
    implements _$EarthquakeTelegramBodyIntensityStationCopyWith<$Res> {
  __$EarthquakeTelegramBodyIntensityStationCopyWithImpl(this._self, this._then);

  final _EarthquakeTelegramBodyIntensityStation _self;
  final $Res Function(_EarthquakeTelegramBodyIntensityStation) _then;

/// Create a copy of EarthquakeTelegramBodyIntensityStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_EarthquakeTelegramBodyIntensityStation(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num?,prePeriods: freezed == prePeriods ? _self._prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriods2>?,
  ));
}


}

// dart format on
