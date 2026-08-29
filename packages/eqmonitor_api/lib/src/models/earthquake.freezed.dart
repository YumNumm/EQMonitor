// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Earthquake {

/// yyyyMMddHHmmss形式のイベントID
@JsonKey(name: 'event_id') String get eventId; TelegramStatus get status;@JsonKey(name: 'earthquake_type') EarthquakeType get earthquakeType;@JsonKey(name: 'origin_time_precision') OriginTimePrecision get originTimePrecision; List<EarthquakeHypocentersUnion> get hypocenters;/// 地震データのソースの配列
 List<EarthquakeDatasource> get datasources; List<EarthquakeTelegram> get telegrams;@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? get originTime;@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? get arrivalTime;@JsonKey(includeIfNull: false) Hypocenter? get hypocenter;@JsonKey(includeIfNull: false) Intensity? get intensity;/// 推計震度PMTilesのフルURL
@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') String? get estimatedIntensityTile;@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile_archive') EstimatedIntensityTileArchive? get estimatedIntensityTileArchive;@JsonKey(includeIfNull: false) Catalog? get catalog;
/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<Earthquake> get copyWith => _$EarthquakeCopyWithImpl<Earthquake>(this as Earthquake, _$identity);

  /// Serializes this Earthquake to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Earthquake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&const DeepCollectionEquality().equals(other.hypocenters, hypocenters)&&const DeepCollectionEquality().equals(other.datasources, datasources)&&const DeepCollectionEquality().equals(other.telegrams, telegrams)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.estimatedIntensityTile, estimatedIntensityTile) || other.estimatedIntensityTile == estimatedIntensityTile)&&(identical(other.estimatedIntensityTileArchive, estimatedIntensityTileArchive) || other.estimatedIntensityTileArchive == estimatedIntensityTileArchive)&&(identical(other.catalog, catalog) || other.catalog == catalog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,earthquakeType,originTimePrecision,const DeepCollectionEquality().hash(hypocenters),const DeepCollectionEquality().hash(datasources),const DeepCollectionEquality().hash(telegrams),originTime,arrivalTime,hypocenter,intensity,estimatedIntensityTile,estimatedIntensityTileArchive,catalog);

@override
String toString() {
  return 'Earthquake(eventId: $eventId, status: $status, earthquakeType: $earthquakeType, originTimePrecision: $originTimePrecision, hypocenters: $hypocenters, datasources: $datasources, telegrams: $telegrams, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, intensity: $intensity, estimatedIntensityTile: $estimatedIntensityTile, estimatedIntensityTileArchive: $estimatedIntensityTileArchive, catalog: $catalog)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCopyWith<$Res>  {
  factory $EarthquakeCopyWith(Earthquake value, $Res Function(Earthquake) _then) = _$EarthquakeCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, TelegramStatus status,@JsonKey(name: 'earthquake_type') EarthquakeType earthquakeType,@JsonKey(name: 'origin_time_precision') OriginTimePrecision originTimePrecision, List<EarthquakeHypocentersUnion> hypocenters, List<EarthquakeDatasource> datasources, List<EarthquakeTelegram> telegrams,@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) Hypocenter? hypocenter,@JsonKey(includeIfNull: false) Intensity? intensity,@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') String? estimatedIntensityTile,@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile_archive') EstimatedIntensityTileArchive? estimatedIntensityTileArchive,@JsonKey(includeIfNull: false) Catalog? catalog
});


$HypocenterCopyWith<$Res>? get hypocenter;$IntensityCopyWith<$Res>? get intensity;$EstimatedIntensityTileArchiveCopyWith<$Res>? get estimatedIntensityTileArchive;$CatalogCopyWith<$Res>? get catalog;

}
/// @nodoc
class _$EarthquakeCopyWithImpl<$Res>
    implements $EarthquakeCopyWith<$Res> {
  _$EarthquakeCopyWithImpl(this._self, this._then);

  final Earthquake _self;
  final $Res Function(Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? earthquakeType = null,Object? originTimePrecision = null,Object? hypocenters = null,Object? datasources = null,Object? telegrams = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? intensity = freezed,Object? estimatedIntensityTile = freezed,Object? estimatedIntensityTileArchive = freezed,Object? catalog = freezed,}) {
  return _then(Earthquake(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,earthquakeType: null == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,hypocenters: null == hypocenters ? _self.hypocenters : hypocenters // ignore: cast_nullable_to_non_nullable
as List<EarthquakeHypocentersUnion>,datasources: null == datasources ? _self.datasources : datasources // ignore: cast_nullable_to_non_nullable
as List<EarthquakeDatasource>,telegrams: null == telegrams ? _self.telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegram>,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as Intensity?,estimatedIntensityTile: freezed == estimatedIntensityTile ? _self.estimatedIntensityTile : estimatedIntensityTile // ignore: cast_nullable_to_non_nullable
as String?,estimatedIntensityTileArchive: freezed == estimatedIntensityTileArchive ? _self.estimatedIntensityTileArchive : estimatedIntensityTileArchive // ignore: cast_nullable_to_non_nullable
as EstimatedIntensityTileArchive?,catalog: freezed == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as Catalog?,
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
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstimatedIntensityTileArchiveCopyWith<$Res>? get estimatedIntensityTileArchive {
    if (_self.estimatedIntensityTileArchive == null) {
    return null;
  }

  return $EstimatedIntensityTileArchiveCopyWith<$Res>(_self.estimatedIntensityTileArchive!, (value) {
    return _then(_self.copyWith(estimatedIntensityTileArchive: value));
  });
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogCopyWith<$Res>? get catalog {
    if (_self.catalog == null) {
    return null;
  }

  return $CatalogCopyWith<$Res>(_self.catalog!, (value) {
    return _then(_self.copyWith(catalog: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  TelegramStatus status, @JsonKey(name: 'earthquake_type')  EarthquakeType earthquakeType, @JsonKey(name: 'origin_time_precision')  OriginTimePrecision originTimePrecision,  List<EarthquakeHypocentersUnion> hypocenters,  List<EarthquakeDatasource> datasources,  List<EarthquakeTelegram> telegrams, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  Hypocenter? hypocenter, @JsonKey(includeIfNull: false)  Intensity? intensity, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')  String? estimatedIntensityTile, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile_archive')  EstimatedIntensityTileArchive? estimatedIntensityTileArchive, @JsonKey(includeIfNull: false)  Catalog? catalog)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
return $default(_that.eventId,_that.status,_that.earthquakeType,_that.originTimePrecision,_that.hypocenters,_that.datasources,_that.telegrams,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity,_that.estimatedIntensityTile,_that.estimatedIntensityTileArchive,_that.catalog);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  TelegramStatus status, @JsonKey(name: 'earthquake_type')  EarthquakeType earthquakeType, @JsonKey(name: 'origin_time_precision')  OriginTimePrecision originTimePrecision,  List<EarthquakeHypocentersUnion> hypocenters,  List<EarthquakeDatasource> datasources,  List<EarthquakeTelegram> telegrams, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  Hypocenter? hypocenter, @JsonKey(includeIfNull: false)  Intensity? intensity, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')  String? estimatedIntensityTile, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile_archive')  EstimatedIntensityTileArchive? estimatedIntensityTileArchive, @JsonKey(includeIfNull: false)  Catalog? catalog)  $default,) {final _that = this;
switch (_that) {
case _Earthquake():
return $default(_that.eventId,_that.status,_that.earthquakeType,_that.originTimePrecision,_that.hypocenters,_that.datasources,_that.telegrams,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity,_that.estimatedIntensityTile,_that.estimatedIntensityTileArchive,_that.catalog);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId,  TelegramStatus status, @JsonKey(name: 'earthquake_type')  EarthquakeType earthquakeType, @JsonKey(name: 'origin_time_precision')  OriginTimePrecision originTimePrecision,  List<EarthquakeHypocentersUnion> hypocenters,  List<EarthquakeDatasource> datasources,  List<EarthquakeTelegram> telegrams, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  Hypocenter? hypocenter, @JsonKey(includeIfNull: false)  Intensity? intensity, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile')  String? estimatedIntensityTile, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile_archive')  EstimatedIntensityTileArchive? estimatedIntensityTileArchive, @JsonKey(includeIfNull: false)  Catalog? catalog)?  $default,) {final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
return $default(_that.eventId,_that.status,_that.earthquakeType,_that.originTimePrecision,_that.hypocenters,_that.datasources,_that.telegrams,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity,_that.estimatedIntensityTile,_that.estimatedIntensityTileArchive,_that.catalog);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Earthquake implements Earthquake {
  const _Earthquake({@JsonKey(name: 'event_id') required this.eventId, required this.status, @JsonKey(name: 'earthquake_type') required this.earthquakeType, @JsonKey(name: 'origin_time_precision') required this.originTimePrecision, required  List<EarthquakeHypocentersUnion> hypocenters, required  List<EarthquakeDatasource> datasources, required  List<EarthquakeTelegram> telegrams, @JsonKey(includeIfNull: false, name: 'origin_time') this.originTime, @JsonKey(includeIfNull: false, name: 'arrival_time') this.arrivalTime, @JsonKey(includeIfNull: false) this.hypocenter, @JsonKey(includeIfNull: false) this.intensity, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') this.estimatedIntensityTile, @JsonKey(includeIfNull: false, name: 'estimated_intensity_tile_archive') this.estimatedIntensityTileArchive, @JsonKey(includeIfNull: false) this.catalog}): _hypocenters = hypocenters,_datasources = datasources,_telegrams = telegrams;
  factory _Earthquake.fromJson(Map<String, dynamic> json) => _$EarthquakeFromJson(json);

/// yyyyMMddHHmmss形式のイベントID
@override@JsonKey(name: 'event_id') final  String eventId;
@override final  TelegramStatus status;
@override@JsonKey(name: 'earthquake_type') final  EarthquakeType earthquakeType;
@override@JsonKey(name: 'origin_time_precision') final  OriginTimePrecision originTimePrecision;
 final  List<EarthquakeHypocentersUnion> _hypocenters;
@override List<EarthquakeHypocentersUnion> get hypocenters {
  if (_hypocenters is EqualUnmodifiableListView) return _hypocenters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hypocenters);
}

/// 地震データのソースの配列
 final  List<EarthquakeDatasource> _datasources;
/// 地震データのソースの配列
@override List<EarthquakeDatasource> get datasources {
  if (_datasources is EqualUnmodifiableListView) return _datasources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_datasources);
}

 final  List<EarthquakeTelegram> _telegrams;
@override List<EarthquakeTelegram> get telegrams {
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
@override@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile_archive') final  EstimatedIntensityTileArchive? estimatedIntensityTileArchive;
@override@JsonKey(includeIfNull: false) final  Catalog? catalog;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Earthquake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&const DeepCollectionEquality().equals(other._hypocenters, _hypocenters)&&const DeepCollectionEquality().equals(other._datasources, _datasources)&&const DeepCollectionEquality().equals(other._telegrams, _telegrams)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.estimatedIntensityTile, estimatedIntensityTile) || other.estimatedIntensityTile == estimatedIntensityTile)&&(identical(other.estimatedIntensityTileArchive, estimatedIntensityTileArchive) || other.estimatedIntensityTileArchive == estimatedIntensityTileArchive)&&(identical(other.catalog, catalog) || other.catalog == catalog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,earthquakeType,originTimePrecision,const DeepCollectionEquality().hash(_hypocenters),const DeepCollectionEquality().hash(_datasources),const DeepCollectionEquality().hash(_telegrams),originTime,arrivalTime,hypocenter,intensity,estimatedIntensityTile,estimatedIntensityTileArchive,catalog);

@override
String toString() {
  return 'Earthquake(eventId: $eventId, status: $status, earthquakeType: $earthquakeType, originTimePrecision: $originTimePrecision, hypocenters: $hypocenters, datasources: $datasources, telegrams: $telegrams, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, intensity: $intensity, estimatedIntensityTile: $estimatedIntensityTile, estimatedIntensityTileArchive: $estimatedIntensityTileArchive, catalog: $catalog)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCopyWith<$Res> implements $EarthquakeCopyWith<$Res> {
  factory _$EarthquakeCopyWith(_Earthquake value, $Res Function(_Earthquake) _then) = __$EarthquakeCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, TelegramStatus status,@JsonKey(name: 'earthquake_type') EarthquakeType earthquakeType,@JsonKey(name: 'origin_time_precision') OriginTimePrecision originTimePrecision, List<EarthquakeHypocentersUnion> hypocenters, List<EarthquakeDatasource> datasources, List<EarthquakeTelegram> telegrams,@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) Hypocenter? hypocenter,@JsonKey(includeIfNull: false) Intensity? intensity,@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile') String? estimatedIntensityTile,@JsonKey(includeIfNull: false, name: 'estimated_intensity_tile_archive') EstimatedIntensityTileArchive? estimatedIntensityTileArchive,@JsonKey(includeIfNull: false) Catalog? catalog
});


@override $HypocenterCopyWith<$Res>? get hypocenter;@override $IntensityCopyWith<$Res>? get intensity;@override $EstimatedIntensityTileArchiveCopyWith<$Res>? get estimatedIntensityTileArchive;@override $CatalogCopyWith<$Res>? get catalog;

}
/// @nodoc
class __$EarthquakeCopyWithImpl<$Res>
    implements _$EarthquakeCopyWith<$Res> {
  __$EarthquakeCopyWithImpl(this._self, this._then);

  final _Earthquake _self;
  final $Res Function(_Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? earthquakeType = null,Object? originTimePrecision = null,Object? hypocenters = null,Object? datasources = null,Object? telegrams = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? intensity = freezed,Object? estimatedIntensityTile = freezed,Object? estimatedIntensityTileArchive = freezed,Object? catalog = freezed,}) {
  return _then(_Earthquake(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,earthquakeType: null == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,hypocenters: null == hypocenters ? _self._hypocenters : hypocenters // ignore: cast_nullable_to_non_nullable
as List<EarthquakeHypocentersUnion>,datasources: null == datasources ? _self._datasources : datasources // ignore: cast_nullable_to_non_nullable
as List<EarthquakeDatasource>,telegrams: null == telegrams ? _self._telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegram>,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as Intensity?,estimatedIntensityTile: freezed == estimatedIntensityTile ? _self.estimatedIntensityTile : estimatedIntensityTile // ignore: cast_nullable_to_non_nullable
as String?,estimatedIntensityTileArchive: freezed == estimatedIntensityTileArchive ? _self.estimatedIntensityTileArchive : estimatedIntensityTileArchive // ignore: cast_nullable_to_non_nullable
as EstimatedIntensityTileArchive?,catalog: freezed == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as Catalog?,
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
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstimatedIntensityTileArchiveCopyWith<$Res>? get estimatedIntensityTileArchive {
    if (_self.estimatedIntensityTileArchive == null) {
    return null;
  }

  return $EstimatedIntensityTileArchiveCopyWith<$Res>(_self.estimatedIntensityTileArchive!, (value) {
    return _then(_self.copyWith(estimatedIntensityTileArchive: value));
  });
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogCopyWith<$Res>? get catalog {
    if (_self.catalog == null) {
    return null;
  }

  return $CatalogCopyWith<$Res>(_self.catalog!, (value) {
    return _then(_self.copyWith(catalog: value));
  });
}
}

// dart format on
