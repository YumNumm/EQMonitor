// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_partial.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakePartial {

 String get eventId; TelegramStatus get status; DateTime? get originTime; OriginTimePrecision get originTimePrecision; DateTime? get arrivalTime; EarthquakeDataSource get dataSource; EarthquakeHypocenter? get hypocenter; EarthquakeIntensityPartial? get intensity; EarthquakeType get earthquakeType; List<EarthquakeTelegramType> get telegramTypes; String? get estimatedIntensityTileUrl;
/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<EarthquakePartial> get copyWith => _$EarthquakePartialCopyWithImpl<EarthquakePartial>(this as EarthquakePartial, _$identity);

  /// Serializes this EarthquakePartial to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakePartial&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&const DeepCollectionEquality().equals(other.telegramTypes, telegramTypes)&&(identical(other.estimatedIntensityTileUrl, estimatedIntensityTileUrl) || other.estimatedIntensityTileUrl == estimatedIntensityTileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTime,originTimePrecision,arrivalTime,dataSource,hypocenter,intensity,earthquakeType,const DeepCollectionEquality().hash(telegramTypes),estimatedIntensityTileUrl);

@override
String toString() {
  return 'EarthquakePartial(eventId: $eventId, status: $status, originTime: $originTime, originTimePrecision: $originTimePrecision, arrivalTime: $arrivalTime, dataSource: $dataSource, hypocenter: $hypocenter, intensity: $intensity, earthquakeType: $earthquakeType, telegramTypes: $telegramTypes, estimatedIntensityTileUrl: $estimatedIntensityTileUrl)';
}


}

/// @nodoc
abstract mixin class $EarthquakePartialCopyWith<$Res>  {
  factory $EarthquakePartialCopyWith(EarthquakePartial value, $Res Function(EarthquakePartial) _then) = _$EarthquakePartialCopyWithImpl;
@useResult
$Res call({
 String eventId, TelegramStatus status, DateTime? originTime, OriginTimePrecision originTimePrecision, DateTime? arrivalTime, EarthquakeDataSource dataSource, EarthquakeHypocenter? hypocenter, EarthquakeIntensityPartial? intensity, EarthquakeType earthquakeType, List<EarthquakeTelegramType> telegramTypes, String? estimatedIntensityTileUrl
});


$EarthquakeHypocenterCopyWith<$Res>? get hypocenter;$EarthquakeIntensityPartialCopyWith<$Res>? get intensity;

}
/// @nodoc
class _$EarthquakePartialCopyWithImpl<$Res>
    implements $EarthquakePartialCopyWith<$Res> {
  _$EarthquakePartialCopyWithImpl(this._self, this._then);

  final EarthquakePartial _self;
  final $Res Function(EarthquakePartial) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? originTime = freezed,Object? originTimePrecision = null,Object? arrivalTime = freezed,Object? dataSource = null,Object? hypocenter = freezed,Object? intensity = freezed,Object? earthquakeType = null,Object? telegramTypes = null,Object? estimatedIntensityTileUrl = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,dataSource: null == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as EarthquakeDataSource,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as EarthquakeIntensityPartial?,earthquakeType: null == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType,telegramTypes: null == telegramTypes ? _self.telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>,estimatedIntensityTileUrl: freezed == estimatedIntensityTileUrl ? _self.estimatedIntensityTileUrl : estimatedIntensityTileUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $EarthquakeHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeIntensityPartialCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $EarthquakeIntensityPartialCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakePartial].
extension EarthquakePartialPatterns on EarthquakePartial {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakePartial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakePartial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakePartial value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakePartial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakePartial value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakePartial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  TelegramStatus status,  DateTime? originTime,  OriginTimePrecision originTimePrecision,  DateTime? arrivalTime,  EarthquakeDataSource dataSource,  EarthquakeHypocenter? hypocenter,  EarthquakeIntensityPartial? intensity,  EarthquakeType earthquakeType,  List<EarthquakeTelegramType> telegramTypes,  String? estimatedIntensityTileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakePartial() when $default != null:
return $default(_that.eventId,_that.status,_that.originTime,_that.originTimePrecision,_that.arrivalTime,_that.dataSource,_that.hypocenter,_that.intensity,_that.earthquakeType,_that.telegramTypes,_that.estimatedIntensityTileUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  TelegramStatus status,  DateTime? originTime,  OriginTimePrecision originTimePrecision,  DateTime? arrivalTime,  EarthquakeDataSource dataSource,  EarthquakeHypocenter? hypocenter,  EarthquakeIntensityPartial? intensity,  EarthquakeType earthquakeType,  List<EarthquakeTelegramType> telegramTypes,  String? estimatedIntensityTileUrl)  $default,) {final _that = this;
switch (_that) {
case _EarthquakePartial():
return $default(_that.eventId,_that.status,_that.originTime,_that.originTimePrecision,_that.arrivalTime,_that.dataSource,_that.hypocenter,_that.intensity,_that.earthquakeType,_that.telegramTypes,_that.estimatedIntensityTileUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  TelegramStatus status,  DateTime? originTime,  OriginTimePrecision originTimePrecision,  DateTime? arrivalTime,  EarthquakeDataSource dataSource,  EarthquakeHypocenter? hypocenter,  EarthquakeIntensityPartial? intensity,  EarthquakeType earthquakeType,  List<EarthquakeTelegramType> telegramTypes,  String? estimatedIntensityTileUrl)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakePartial() when $default != null:
return $default(_that.eventId,_that.status,_that.originTime,_that.originTimePrecision,_that.arrivalTime,_that.dataSource,_that.hypocenter,_that.intensity,_that.earthquakeType,_that.telegramTypes,_that.estimatedIntensityTileUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakePartial implements EarthquakePartial {
  const _EarthquakePartial({required this.eventId, required this.status, required this.originTime, required this.originTimePrecision, required this.arrivalTime, required this.dataSource, required this.hypocenter, required this.intensity, required this.earthquakeType, required final  List<EarthquakeTelegramType> telegramTypes, required this.estimatedIntensityTileUrl}): _telegramTypes = telegramTypes;
  factory _EarthquakePartial.fromJson(Map<String, dynamic> json) => _$EarthquakePartialFromJson(json);

@override final  String eventId;
@override final  TelegramStatus status;
@override final  DateTime? originTime;
@override final  OriginTimePrecision originTimePrecision;
@override final  DateTime? arrivalTime;
@override final  EarthquakeDataSource dataSource;
@override final  EarthquakeHypocenter? hypocenter;
@override final  EarthquakeIntensityPartial? intensity;
@override final  EarthquakeType earthquakeType;
 final  List<EarthquakeTelegramType> _telegramTypes;
@override List<EarthquakeTelegramType> get telegramTypes {
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegramTypes);
}

@override final  String? estimatedIntensityTileUrl;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakePartialCopyWith<_EarthquakePartial> get copyWith => __$EarthquakePartialCopyWithImpl<_EarthquakePartial>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakePartialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakePartial&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes)&&(identical(other.estimatedIntensityTileUrl, estimatedIntensityTileUrl) || other.estimatedIntensityTileUrl == estimatedIntensityTileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTime,originTimePrecision,arrivalTime,dataSource,hypocenter,intensity,earthquakeType,const DeepCollectionEquality().hash(_telegramTypes),estimatedIntensityTileUrl);

@override
String toString() {
  return 'EarthquakePartial(eventId: $eventId, status: $status, originTime: $originTime, originTimePrecision: $originTimePrecision, arrivalTime: $arrivalTime, dataSource: $dataSource, hypocenter: $hypocenter, intensity: $intensity, earthquakeType: $earthquakeType, telegramTypes: $telegramTypes, estimatedIntensityTileUrl: $estimatedIntensityTileUrl)';
}


}

/// @nodoc
abstract mixin class _$EarthquakePartialCopyWith<$Res> implements $EarthquakePartialCopyWith<$Res> {
  factory _$EarthquakePartialCopyWith(_EarthquakePartial value, $Res Function(_EarthquakePartial) _then) = __$EarthquakePartialCopyWithImpl;
@override @useResult
$Res call({
 String eventId, TelegramStatus status, DateTime? originTime, OriginTimePrecision originTimePrecision, DateTime? arrivalTime, EarthquakeDataSource dataSource, EarthquakeHypocenter? hypocenter, EarthquakeIntensityPartial? intensity, EarthquakeType earthquakeType, List<EarthquakeTelegramType> telegramTypes, String? estimatedIntensityTileUrl
});


@override $EarthquakeHypocenterCopyWith<$Res>? get hypocenter;@override $EarthquakeIntensityPartialCopyWith<$Res>? get intensity;

}
/// @nodoc
class __$EarthquakePartialCopyWithImpl<$Res>
    implements _$EarthquakePartialCopyWith<$Res> {
  __$EarthquakePartialCopyWithImpl(this._self, this._then);

  final _EarthquakePartial _self;
  final $Res Function(_EarthquakePartial) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? originTime = freezed,Object? originTimePrecision = null,Object? arrivalTime = freezed,Object? dataSource = null,Object? hypocenter = freezed,Object? intensity = freezed,Object? earthquakeType = null,Object? telegramTypes = null,Object? estimatedIntensityTileUrl = freezed,}) {
  return _then(_EarthquakePartial(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,dataSource: null == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as EarthquakeDataSource,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as EarthquakeIntensityPartial?,earthquakeType: null == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType,telegramTypes: null == telegramTypes ? _self._telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>,estimatedIntensityTileUrl: freezed == estimatedIntensityTileUrl ? _self.estimatedIntensityTileUrl : estimatedIntensityTileUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $EarthquakeHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeIntensityPartialCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $EarthquakeIntensityPartialCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}

// dart format on
