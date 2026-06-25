// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_telegram_body_intensity_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewTelegramBodyIntensityRegion {

 String get eventId; num get serialNo; String get code; String get name; bool get isPlum; bool get isWarning; JmaIntensity get intensity; bool get intensityIsOver;@JsonKey(includeIfNull: false) JmaLpgmIntensity? get lpgmIntensity;@JsonKey(includeIfNull: false) bool? get lpgmIntensityIsOver;@JsonKey(includeIfNull: false) String? get arrivalTime;
/// Create a copy of EewTelegramBodyIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewTelegramBodyIntensityRegionCopyWith<EewTelegramBodyIntensityRegion> get copyWith => _$EewTelegramBodyIntensityRegionCopyWithImpl<EewTelegramBodyIntensityRegion>(this as EewTelegramBodyIntensityRegion, _$identity);

  /// Serializes this EewTelegramBodyIntensityRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewTelegramBodyIntensityRegion&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.intensityIsOver, intensityIsOver) || other.intensityIsOver == intensityIsOver)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.lpgmIntensityIsOver, lpgmIntensityIsOver) || other.lpgmIntensityIsOver == lpgmIntensityIsOver)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo,code,name,isPlum,isWarning,intensity,intensityIsOver,lpgmIntensity,lpgmIntensityIsOver,arrivalTime);

@override
String toString() {
  return 'EewTelegramBodyIntensityRegion(eventId: $eventId, serialNo: $serialNo, code: $code, name: $name, isPlum: $isPlum, isWarning: $isWarning, intensity: $intensity, intensityIsOver: $intensityIsOver, lpgmIntensity: $lpgmIntensity, lpgmIntensityIsOver: $lpgmIntensityIsOver, arrivalTime: $arrivalTime)';
}


}

/// @nodoc
abstract mixin class $EewTelegramBodyIntensityRegionCopyWith<$Res>  {
  factory $EewTelegramBodyIntensityRegionCopyWith(EewTelegramBodyIntensityRegion value, $Res Function(EewTelegramBodyIntensityRegion) _then) = _$EewTelegramBodyIntensityRegionCopyWithImpl;
@useResult
$Res call({
 String eventId, num serialNo, String code, String name, bool isPlum, bool isWarning, JmaIntensity intensity, bool intensityIsOver,@JsonKey(includeIfNull: false) JmaLpgmIntensity? lpgmIntensity,@JsonKey(includeIfNull: false) bool? lpgmIntensityIsOver,@JsonKey(includeIfNull: false) String? arrivalTime
});




}
/// @nodoc
class _$EewTelegramBodyIntensityRegionCopyWithImpl<$Res>
    implements $EewTelegramBodyIntensityRegionCopyWith<$Res> {
  _$EewTelegramBodyIntensityRegionCopyWithImpl(this._self, this._then);

  final EewTelegramBodyIntensityRegion _self;
  final $Res Function(EewTelegramBodyIntensityRegion) _then;

/// Create a copy of EewTelegramBodyIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? serialNo = null,Object? code = null,Object? name = null,Object? isPlum = null,Object? isWarning = null,Object? intensity = null,Object? intensityIsOver = null,Object? lpgmIntensity = freezed,Object? lpgmIntensityIsOver = freezed,Object? arrivalTime = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,intensityIsOver: null == intensityIsOver ? _self.intensityIsOver : intensityIsOver // ignore: cast_nullable_to_non_nullable
as bool,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,lpgmIntensityIsOver: freezed == lpgmIntensityIsOver ? _self.lpgmIntensityIsOver : lpgmIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EewTelegramBodyIntensityRegion].
extension EewTelegramBodyIntensityRegionPatterns on EewTelegramBodyIntensityRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewTelegramBodyIntensityRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewTelegramBodyIntensityRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewTelegramBodyIntensityRegion value)  $default,){
final _that = this;
switch (_that) {
case _EewTelegramBodyIntensityRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewTelegramBodyIntensityRegion value)?  $default,){
final _that = this;
switch (_that) {
case _EewTelegramBodyIntensityRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  num serialNo,  String code,  String name,  bool isPlum,  bool isWarning,  JmaIntensity intensity,  bool intensityIsOver, @JsonKey(includeIfNull: false)  JmaLpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: false)  bool? lpgmIntensityIsOver, @JsonKey(includeIfNull: false)  String? arrivalTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewTelegramBodyIntensityRegion() when $default != null:
return $default(_that.eventId,_that.serialNo,_that.code,_that.name,_that.isPlum,_that.isWarning,_that.intensity,_that.intensityIsOver,_that.lpgmIntensity,_that.lpgmIntensityIsOver,_that.arrivalTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  num serialNo,  String code,  String name,  bool isPlum,  bool isWarning,  JmaIntensity intensity,  bool intensityIsOver, @JsonKey(includeIfNull: false)  JmaLpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: false)  bool? lpgmIntensityIsOver, @JsonKey(includeIfNull: false)  String? arrivalTime)  $default,) {final _that = this;
switch (_that) {
case _EewTelegramBodyIntensityRegion():
return $default(_that.eventId,_that.serialNo,_that.code,_that.name,_that.isPlum,_that.isWarning,_that.intensity,_that.intensityIsOver,_that.lpgmIntensity,_that.lpgmIntensityIsOver,_that.arrivalTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  num serialNo,  String code,  String name,  bool isPlum,  bool isWarning,  JmaIntensity intensity,  bool intensityIsOver, @JsonKey(includeIfNull: false)  JmaLpgmIntensity? lpgmIntensity, @JsonKey(includeIfNull: false)  bool? lpgmIntensityIsOver, @JsonKey(includeIfNull: false)  String? arrivalTime)?  $default,) {final _that = this;
switch (_that) {
case _EewTelegramBodyIntensityRegion() when $default != null:
return $default(_that.eventId,_that.serialNo,_that.code,_that.name,_that.isPlum,_that.isWarning,_that.intensity,_that.intensityIsOver,_that.lpgmIntensity,_that.lpgmIntensityIsOver,_that.arrivalTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewTelegramBodyIntensityRegion implements EewTelegramBodyIntensityRegion {
  const _EewTelegramBodyIntensityRegion({required this.eventId, required this.serialNo, required this.code, required this.name, required this.isPlum, required this.isWarning, required this.intensity, required this.intensityIsOver, @JsonKey(includeIfNull: false) this.lpgmIntensity, @JsonKey(includeIfNull: false) this.lpgmIntensityIsOver, @JsonKey(includeIfNull: false) this.arrivalTime});
  factory _EewTelegramBodyIntensityRegion.fromJson(Map<String, dynamic> json) => _$EewTelegramBodyIntensityRegionFromJson(json);

@override final  String eventId;
@override final  num serialNo;
@override final  String code;
@override final  String name;
@override final  bool isPlum;
@override final  bool isWarning;
@override final  JmaIntensity intensity;
@override final  bool intensityIsOver;
@override@JsonKey(includeIfNull: false) final  JmaLpgmIntensity? lpgmIntensity;
@override@JsonKey(includeIfNull: false) final  bool? lpgmIntensityIsOver;
@override@JsonKey(includeIfNull: false) final  String? arrivalTime;

/// Create a copy of EewTelegramBodyIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewTelegramBodyIntensityRegionCopyWith<_EewTelegramBodyIntensityRegion> get copyWith => __$EewTelegramBodyIntensityRegionCopyWithImpl<_EewTelegramBodyIntensityRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewTelegramBodyIntensityRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewTelegramBodyIntensityRegion&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.intensityIsOver, intensityIsOver) || other.intensityIsOver == intensityIsOver)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.lpgmIntensityIsOver, lpgmIntensityIsOver) || other.lpgmIntensityIsOver == lpgmIntensityIsOver)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo,code,name,isPlum,isWarning,intensity,intensityIsOver,lpgmIntensity,lpgmIntensityIsOver,arrivalTime);

@override
String toString() {
  return 'EewTelegramBodyIntensityRegion(eventId: $eventId, serialNo: $serialNo, code: $code, name: $name, isPlum: $isPlum, isWarning: $isWarning, intensity: $intensity, intensityIsOver: $intensityIsOver, lpgmIntensity: $lpgmIntensity, lpgmIntensityIsOver: $lpgmIntensityIsOver, arrivalTime: $arrivalTime)';
}


}

/// @nodoc
abstract mixin class _$EewTelegramBodyIntensityRegionCopyWith<$Res> implements $EewTelegramBodyIntensityRegionCopyWith<$Res> {
  factory _$EewTelegramBodyIntensityRegionCopyWith(_EewTelegramBodyIntensityRegion value, $Res Function(_EewTelegramBodyIntensityRegion) _then) = __$EewTelegramBodyIntensityRegionCopyWithImpl;
@override @useResult
$Res call({
 String eventId, num serialNo, String code, String name, bool isPlum, bool isWarning, JmaIntensity intensity, bool intensityIsOver,@JsonKey(includeIfNull: false) JmaLpgmIntensity? lpgmIntensity,@JsonKey(includeIfNull: false) bool? lpgmIntensityIsOver,@JsonKey(includeIfNull: false) String? arrivalTime
});




}
/// @nodoc
class __$EewTelegramBodyIntensityRegionCopyWithImpl<$Res>
    implements _$EewTelegramBodyIntensityRegionCopyWith<$Res> {
  __$EewTelegramBodyIntensityRegionCopyWithImpl(this._self, this._then);

  final _EewTelegramBodyIntensityRegion _self;
  final $Res Function(_EewTelegramBodyIntensityRegion) _then;

/// Create a copy of EewTelegramBodyIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? serialNo = null,Object? code = null,Object? name = null,Object? isPlum = null,Object? isWarning = null,Object? intensity = null,Object? intensityIsOver = null,Object? lpgmIntensity = freezed,Object? lpgmIntensityIsOver = freezed,Object? arrivalTime = freezed,}) {
  return _then(_EewTelegramBodyIntensityRegion(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,intensityIsOver: null == intensityIsOver ? _self.intensityIsOver : intensityIsOver // ignore: cast_nullable_to_non_nullable
as bool,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,lpgmIntensityIsOver: freezed == lpgmIntensityIsOver ? _self.lpgmIntensityIsOver : lpgmIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
