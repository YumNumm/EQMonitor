// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Earthquake {

/// yyyyMMddHHmmss形式のイベントID
@JsonKey(name: 'event_id') String get eventId; TelegramStatus get status;@JsonKey(name: 'origin_time_precision') OriginTimePrecision get originTimePrecision; EarthquakeDatasource get datasource; List<Telegrams> get telegrams;@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? get originTime;@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? get arrivalTime;@JsonKey(includeIfNull: false) Hypocenter? get hypocenter;@JsonKey(includeIfNull: false) Intensity? get intensity;/// 推計震度PMTilesのフルURL
@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') String? get estimatedIntensityTile;
/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<Earthquake> get copyWith => _$EarthquakeCopyWithImpl<Earthquake>(this as Earthquake, _$identity);

  /// Serializes this Earthquake to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Earthquake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.datasource, datasource) || other.datasource == datasource)&&const DeepCollectionEquality().equals(other.telegrams, telegrams)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.estimatedIntensityTile, estimatedIntensityTile) || other.estimatedIntensityTile == estimatedIntensityTile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTimePrecision,datasource,const DeepCollectionEquality().hash(telegrams),originTime,arrivalTime,hypocenter,intensity,estimatedIntensityTile);

@override
String toString() {
  return 'Earthquake(eventId: $eventId, status: $status, originTimePrecision: $originTimePrecision, datasource: $datasource, telegrams: $telegrams, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, intensity: $intensity, estimatedIntensityTile: $estimatedIntensityTile)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCopyWith<$Res>  {
  factory $EarthquakeCopyWith(Earthquake value, $Res Function(Earthquake) _then) = _$EarthquakeCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, TelegramStatus status,@JsonKey(name: 'origin_time_precision') OriginTimePrecision originTimePrecision, EarthquakeDatasource datasource, List<Telegrams> telegrams,@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) Hypocenter? hypocenter,@JsonKey(includeIfNull: false) Intensity? intensity,@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') String? estimatedIntensityTile
});


$HypocenterCopyWith<$Res>? get hypocenter;$IntensityCopyWith<$Res>? get intensity;

}
/// @nodoc
class _$EarthquakeCopyWithImpl<$Res>
    implements $EarthquakeCopyWith<$Res> {
  _$EarthquakeCopyWithImpl(this._self, this._then);

  final Earthquake _self;
  final $Res Function(Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? originTimePrecision = null,Object? datasource = null,Object? telegrams = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? intensity = freezed,Object? estimatedIntensityTile = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,datasource: null == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDatasource,telegrams: null == telegrams ? _self.telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<Telegrams>,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as Intensity?,estimatedIntensityTile: freezed == estimatedIntensityTile ? _self.estimatedIntensityTile : estimatedIntensityTile // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Earthquake
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
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [Earthquake].
extension EarthquakePatterns on Earthquake {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Earthquake value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Earthquake value)  $default,){
final _that = this;
switch (_that) {
case _Earthquake():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Earthquake value)?  $default,){
final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  TelegramStatus status, @JsonKey(name: 'origin_time_precision')  OriginTimePrecision originTimePrecision,  EarthquakeDatasource datasource,  List<Telegrams> telegrams, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  Hypocenter? hypocenter, @JsonKey(includeIfNull: false)  Intensity? intensity, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')  String? estimatedIntensityTile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
return $default(_that.eventId,_that.status,_that.originTimePrecision,_that.datasource,_that.telegrams,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity,_that.estimatedIntensityTile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  TelegramStatus status, @JsonKey(name: 'origin_time_precision')  OriginTimePrecision originTimePrecision,  EarthquakeDatasource datasource,  List<Telegrams> telegrams, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  Hypocenter? hypocenter, @JsonKey(includeIfNull: false)  Intensity? intensity, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')  String? estimatedIntensityTile)  $default,) {final _that = this;
switch (_that) {
case _Earthquake():
return $default(_that.eventId,_that.status,_that.originTimePrecision,_that.datasource,_that.telegrams,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity,_that.estimatedIntensityTile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId,  TelegramStatus status, @JsonKey(name: 'origin_time_precision')  OriginTimePrecision originTimePrecision,  EarthquakeDatasource datasource,  List<Telegrams> telegrams, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  Hypocenter? hypocenter, @JsonKey(includeIfNull: false)  Intensity? intensity, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')  String? estimatedIntensityTile)?  $default,) {final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
return $default(_that.eventId,_that.status,_that.originTimePrecision,_that.datasource,_that.telegrams,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity,_that.estimatedIntensityTile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Earthquake implements Earthquake {
  const _Earthquake({@JsonKey(name: 'event_id') required this.eventId, required this.status, @JsonKey(name: 'origin_time_precision') required this.originTimePrecision, required this.datasource, required final  List<Telegrams> telegrams, @JsonKey(includeIfNull: false, name: 'origin_time') this.originTime, @JsonKey(includeIfNull: false, name: 'arrival_time') this.arrivalTime, @JsonKey(includeIfNull: false) this.hypocenter, @JsonKey(includeIfNull: false) this.intensity, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') this.estimatedIntensityTile}): _telegrams = telegrams;
  factory _Earthquake.fromJson(Map<String, dynamic> json) => _$EarthquakeFromJson(json);

/// yyyyMMddHHmmss形式のイベントID
@override@JsonKey(name: 'event_id') final  String eventId;
@override final  TelegramStatus status;
@override@JsonKey(name: 'origin_time_precision') final  OriginTimePrecision originTimePrecision;
@override final  EarthquakeDatasource datasource;
 final  List<Telegrams> _telegrams;
@override List<Telegrams> get telegrams {
  if (_telegrams is EqualUnmodifiableListView) return _telegrams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegrams);
}

@override@JsonKey(includeIfNull: false, name: 'origin_time') final  DateTime? originTime;
@override@JsonKey(includeIfNull: false, name: 'arrival_time') final  DateTime? arrivalTime;
@override@JsonKey(includeIfNull: false) final  Hypocenter? hypocenter;
@override@JsonKey(includeIfNull: false) final  Intensity? intensity;
/// 推計震度PMTilesのフルURL
@override@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') final  String? estimatedIntensityTile;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCopyWith<_Earthquake> get copyWith => __$EarthquakeCopyWithImpl<_Earthquake>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Earthquake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.datasource, datasource) || other.datasource == datasource)&&const DeepCollectionEquality().equals(other._telegrams, _telegrams)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.estimatedIntensityTile, estimatedIntensityTile) || other.estimatedIntensityTile == estimatedIntensityTile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTimePrecision,datasource,const DeepCollectionEquality().hash(_telegrams),originTime,arrivalTime,hypocenter,intensity,estimatedIntensityTile);

@override
String toString() {
  return 'Earthquake(eventId: $eventId, status: $status, originTimePrecision: $originTimePrecision, datasource: $datasource, telegrams: $telegrams, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, intensity: $intensity, estimatedIntensityTile: $estimatedIntensityTile)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCopyWith<$Res> implements $EarthquakeCopyWith<$Res> {
  factory _$EarthquakeCopyWith(_Earthquake value, $Res Function(_Earthquake) _then) = __$EarthquakeCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, TelegramStatus status,@JsonKey(name: 'origin_time_precision') OriginTimePrecision originTimePrecision, EarthquakeDatasource datasource, List<Telegrams> telegrams,@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) Hypocenter? hypocenter,@JsonKey(includeIfNull: false) Intensity? intensity,@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') String? estimatedIntensityTile
});


@override $HypocenterCopyWith<$Res>? get hypocenter;@override $IntensityCopyWith<$Res>? get intensity;

}
/// @nodoc
class __$EarthquakeCopyWithImpl<$Res>
    implements _$EarthquakeCopyWith<$Res> {
  __$EarthquakeCopyWithImpl(this._self, this._then);

  final _Earthquake _self;
  final $Res Function(_Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? originTimePrecision = null,Object? datasource = null,Object? telegrams = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? intensity = freezed,Object? estimatedIntensityTile = freezed,}) {
  return _then(_Earthquake(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,datasource: null == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDatasource,telegrams: null == telegrams ? _self._telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<Telegrams>,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as Intensity?,estimatedIntensityTile: freezed == estimatedIntensityTile ? _self.estimatedIntensityTile : estimatedIntensityTile // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Earthquake
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
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}

// dart format on
