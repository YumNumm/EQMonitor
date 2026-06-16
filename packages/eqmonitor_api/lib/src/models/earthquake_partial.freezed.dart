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

/// yyyyMMddHHmmss形式のイベントID
@JsonKey(name: 'event_id') String get eventId; TelegramStatus get status;@JsonKey(name: 'origin_time_precision') OriginTimePrecision get originTimePrecision; EarthquakeDatasource get datasource;/// この地震イベントに紐づく電文タイプの配列
@JsonKey(name: 'telegram_types') List<EarthquakeTelegramType> get telegramTypes;@JsonKey(name: 'earthquake_type') EarthquakeType get earthquakeType;@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? get originTime;@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? get arrivalTime;@JsonKey(includeIfNull: false) Hypocenter? get hypocenter;/// 推計震度PMTilesのフルURL
@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') String? get estimatedIntensityTile;@JsonKey(includeIfNull: false) IntensityPartial? get intensity;
/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<EarthquakePartial> get copyWith => _$EarthquakePartialCopyWithImpl<EarthquakePartial>(this as EarthquakePartial, _$identity);

  /// Serializes this EarthquakePartial to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakePartial&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.datasource, datasource) || other.datasource == datasource)&&const DeepCollectionEquality().equals(other.telegramTypes, telegramTypes)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.estimatedIntensityTile, estimatedIntensityTile) || other.estimatedIntensityTile == estimatedIntensityTile)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTimePrecision,datasource,const DeepCollectionEquality().hash(telegramTypes),earthquakeType,originTime,arrivalTime,hypocenter,estimatedIntensityTile,intensity);

@override
String toString() {
  return 'EarthquakePartial(eventId: $eventId, status: $status, originTimePrecision: $originTimePrecision, datasource: $datasource, telegramTypes: $telegramTypes, earthquakeType: $earthquakeType, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, estimatedIntensityTile: $estimatedIntensityTile, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $EarthquakePartialCopyWith<$Res>  {
  factory $EarthquakePartialCopyWith(EarthquakePartial value, $Res Function(EarthquakePartial) _then) = _$EarthquakePartialCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, TelegramStatus status,@JsonKey(name: 'origin_time_precision') OriginTimePrecision originTimePrecision, EarthquakeDatasource datasource,@JsonKey(name: 'telegram_types') List<EarthquakeTelegramType> telegramTypes,@JsonKey(name: 'earthquake_type') EarthquakeType earthquakeType,@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) Hypocenter? hypocenter,@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') String? estimatedIntensityTile,@JsonKey(includeIfNull: false) IntensityPartial? intensity
});


$HypocenterCopyWith<$Res>? get hypocenter;$IntensityPartialCopyWith<$Res>? get intensity;

}
/// @nodoc
class _$EarthquakePartialCopyWithImpl<$Res>
    implements $EarthquakePartialCopyWith<$Res> {
  _$EarthquakePartialCopyWithImpl(this._self, this._then);

  final EarthquakePartial _self;
  final $Res Function(EarthquakePartial) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? originTimePrecision = null,Object? datasource = null,Object? telegramTypes = null,Object? earthquakeType = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? estimatedIntensityTile = freezed,Object? intensity = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,datasource: null == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDatasource,telegramTypes: null == telegramTypes ? _self.telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>,earthquakeType: null == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter?,estimatedIntensityTile: freezed == estimatedIntensityTile ? _self.estimatedIntensityTile : estimatedIntensityTile // ignore: cast_nullable_to_non_nullable
as String?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityPartial?,
  ));
}
/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $HypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityPartialCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityPartialCopyWith<$Res>(_self.intensity!, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  TelegramStatus status, @JsonKey(name: 'origin_time_precision')  OriginTimePrecision originTimePrecision,  EarthquakeDatasource datasource, @JsonKey(name: 'telegram_types')  List<EarthquakeTelegramType> telegramTypes, @JsonKey(name: 'earthquake_type')  EarthquakeType earthquakeType, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  Hypocenter? hypocenter, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')  String? estimatedIntensityTile, @JsonKey(includeIfNull: false)  IntensityPartial? intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakePartial() when $default != null:
return $default(_that.eventId,_that.status,_that.originTimePrecision,_that.datasource,_that.telegramTypes,_that.earthquakeType,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.estimatedIntensityTile,_that.intensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  TelegramStatus status, @JsonKey(name: 'origin_time_precision')  OriginTimePrecision originTimePrecision,  EarthquakeDatasource datasource, @JsonKey(name: 'telegram_types')  List<EarthquakeTelegramType> telegramTypes, @JsonKey(name: 'earthquake_type')  EarthquakeType earthquakeType, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  Hypocenter? hypocenter, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')  String? estimatedIntensityTile, @JsonKey(includeIfNull: false)  IntensityPartial? intensity)  $default,) {final _that = this;
switch (_that) {
case _EarthquakePartial():
return $default(_that.eventId,_that.status,_that.originTimePrecision,_that.datasource,_that.telegramTypes,_that.earthquakeType,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.estimatedIntensityTile,_that.intensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId,  TelegramStatus status, @JsonKey(name: 'origin_time_precision')  OriginTimePrecision originTimePrecision,  EarthquakeDatasource datasource, @JsonKey(name: 'telegram_types')  List<EarthquakeTelegramType> telegramTypes, @JsonKey(name: 'earthquake_type')  EarthquakeType earthquakeType, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  Hypocenter? hypocenter, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')  String? estimatedIntensityTile, @JsonKey(includeIfNull: false)  IntensityPartial? intensity)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakePartial() when $default != null:
return $default(_that.eventId,_that.status,_that.originTimePrecision,_that.datasource,_that.telegramTypes,_that.earthquakeType,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.estimatedIntensityTile,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakePartial implements EarthquakePartial {
  const _EarthquakePartial({@JsonKey(name: 'event_id') required this.eventId, required this.status, @JsonKey(name: 'origin_time_precision') required this.originTimePrecision, required this.datasource, @JsonKey(name: 'telegram_types') required final  List<EarthquakeTelegramType> telegramTypes, @JsonKey(name: 'earthquake_type') required this.earthquakeType, @JsonKey(includeIfNull: false, name: 'origin_time') this.originTime, @JsonKey(includeIfNull: false, name: 'arrival_time') this.arrivalTime, @JsonKey(includeIfNull: false) this.hypocenter, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') this.estimatedIntensityTile, @JsonKey(includeIfNull: false) this.intensity}): _telegramTypes = telegramTypes;
  factory _EarthquakePartial.fromJson(Map<String, dynamic> json) => _$EarthquakePartialFromJson(json);

/// yyyyMMddHHmmss形式のイベントID
@override@JsonKey(name: 'event_id') final  String eventId;
@override final  TelegramStatus status;
@override@JsonKey(name: 'origin_time_precision') final  OriginTimePrecision originTimePrecision;
@override final  EarthquakeDatasource datasource;
/// この地震イベントに紐づく電文タイプの配列
 final  List<EarthquakeTelegramType> _telegramTypes;
/// この地震イベントに紐づく電文タイプの配列
@override@JsonKey(name: 'telegram_types') List<EarthquakeTelegramType> get telegramTypes {
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegramTypes);
}

@override@JsonKey(name: 'earthquake_type') final  EarthquakeType earthquakeType;
@override@JsonKey(includeIfNull: false, name: 'origin_time') final  DateTime? originTime;
@override@JsonKey(includeIfNull: false, name: 'arrival_time') final  DateTime? arrivalTime;
@override@JsonKey(includeIfNull: false) final  Hypocenter? hypocenter;
/// 推計震度PMTilesのフルURL
@override@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') final  String? estimatedIntensityTile;
@override@JsonKey(includeIfNull: false) final  IntensityPartial? intensity;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakePartial&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.datasource, datasource) || other.datasource == datasource)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.estimatedIntensityTile, estimatedIntensityTile) || other.estimatedIntensityTile == estimatedIntensityTile)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTimePrecision,datasource,const DeepCollectionEquality().hash(_telegramTypes),earthquakeType,originTime,arrivalTime,hypocenter,estimatedIntensityTile,intensity);

@override
String toString() {
  return 'EarthquakePartial(eventId: $eventId, status: $status, originTimePrecision: $originTimePrecision, datasource: $datasource, telegramTypes: $telegramTypes, earthquakeType: $earthquakeType, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, estimatedIntensityTile: $estimatedIntensityTile, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$EarthquakePartialCopyWith<$Res> implements $EarthquakePartialCopyWith<$Res> {
  factory _$EarthquakePartialCopyWith(_EarthquakePartial value, $Res Function(_EarthquakePartial) _then) = __$EarthquakePartialCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, TelegramStatus status,@JsonKey(name: 'origin_time_precision') OriginTimePrecision originTimePrecision, EarthquakeDatasource datasource,@JsonKey(name: 'telegram_types') List<EarthquakeTelegramType> telegramTypes,@JsonKey(name: 'earthquake_type') EarthquakeType earthquakeType,@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) Hypocenter? hypocenter,@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') String? estimatedIntensityTile,@JsonKey(includeIfNull: false) IntensityPartial? intensity
});


@override $HypocenterCopyWith<$Res>? get hypocenter;@override $IntensityPartialCopyWith<$Res>? get intensity;

}
/// @nodoc
class __$EarthquakePartialCopyWithImpl<$Res>
    implements _$EarthquakePartialCopyWith<$Res> {
  __$EarthquakePartialCopyWithImpl(this._self, this._then);

  final _EarthquakePartial _self;
  final $Res Function(_EarthquakePartial) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? originTimePrecision = null,Object? datasource = null,Object? telegramTypes = null,Object? earthquakeType = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? estimatedIntensityTile = freezed,Object? intensity = freezed,}) {
  return _then(_EarthquakePartial(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,datasource: null == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDatasource,telegramTypes: null == telegramTypes ? _self._telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>,earthquakeType: null == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter?,estimatedIntensityTile: freezed == estimatedIntensityTile ? _self.estimatedIntensityTile : estimatedIntensityTile // ignore: cast_nullable_to_non_nullable
as String?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityPartial?,
  ));
}

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $HypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityPartialCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityPartialCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}

// dart format on
