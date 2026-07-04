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
EarthquakePartial _$EarthquakePartialFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'normal':
          return EarthquakePartialNormal.fromJson(
            json
          );
                case 'prefecture':
          return EarthquakePartialPrefecture.fromJson(
            json
          );
                case 'region':
          return EarthquakePartialRegion.fromJson(
            json
          );
                case 'city':
          return EarthquakePartialCity.fromJson(
            json
          );
                case 'station':
          return EarthquakePartialStation.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'EarthquakePartial',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$EarthquakePartial {



  /// Serializes this EarthquakePartial to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakePartial);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarthquakePartial()';
}


}

/// @nodoc
class $EarthquakePartialCopyWith<$Res>  {
$EarthquakePartialCopyWith(EarthquakePartial _, $Res Function(EarthquakePartial) __);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EarthquakePartialNormal value)?  normal,TResult Function( EarthquakePartialPrefecture value)?  prefecture,TResult Function( EarthquakePartialRegion value)?  region,TResult Function( EarthquakePartialCity value)?  city,TResult Function( EarthquakePartialStation value)?  station,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EarthquakePartialNormal() when normal != null:
return normal(_that);case EarthquakePartialPrefecture() when prefecture != null:
return prefecture(_that);case EarthquakePartialRegion() when region != null:
return region(_that);case EarthquakePartialCity() when city != null:
return city(_that);case EarthquakePartialStation() when station != null:
return station(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EarthquakePartialNormal value)  normal,required TResult Function( EarthquakePartialPrefecture value)  prefecture,required TResult Function( EarthquakePartialRegion value)  region,required TResult Function( EarthquakePartialCity value)  city,required TResult Function( EarthquakePartialStation value)  station,}){
final _that = this;
switch (_that) {
case EarthquakePartialNormal():
return normal(_that);case EarthquakePartialPrefecture():
return prefecture(_that);case EarthquakePartialRegion():
return region(_that);case EarthquakePartialCity():
return city(_that);case EarthquakePartialStation():
return station(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EarthquakePartialNormal value)?  normal,TResult? Function( EarthquakePartialPrefecture value)?  prefecture,TResult? Function( EarthquakePartialRegion value)?  region,TResult? Function( EarthquakePartialCity value)?  city,TResult? Function( EarthquakePartialStation value)?  station,}){
final _that = this;
switch (_that) {
case EarthquakePartialNormal() when normal != null:
return normal(_that);case EarthquakePartialPrefecture() when prefecture != null:
return prefecture(_that);case EarthquakePartialRegion() when region != null:
return region(_that);case EarthquakePartialCity() when city != null:
return city(_that);case EarthquakePartialStation() when station != null:
return station(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String eventId,  TelegramStatus status,  DateTime? originTime,  OriginTimePrecision originTimePrecision,  DateTime? arrivalTime,  List<EarthquakeDataSource> dataSources,  EarthquakeHypocenter? hypocenter,  EarthquakeIntensityPartial? intensity,  EarthquakeType earthquakeType,  List<EarthquakeTelegramType> telegramTypes,  String? estimatedIntensityTileUrl)?  normal,TResult Function( JmaIntensity prefectureIntensity,  EarthquakePartialNormal earthquake)?  prefecture,TResult Function( JmaIntensity regionIntensity,  EarthquakePartialNormal earthquake)?  region,TResult Function( JmaIntensity cityIntensity,  EarthquakePartialNormal earthquake)?  city,TResult Function( JmaIntensity stationIntensity,  EarthquakePartialNormal earthquake)?  station,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EarthquakePartialNormal() when normal != null:
return normal(_that.eventId,_that.status,_that.originTime,_that.originTimePrecision,_that.arrivalTime,_that.dataSources,_that.hypocenter,_that.intensity,_that.earthquakeType,_that.telegramTypes,_that.estimatedIntensityTileUrl);case EarthquakePartialPrefecture() when prefecture != null:
return prefecture(_that.prefectureIntensity,_that.earthquake);case EarthquakePartialRegion() when region != null:
return region(_that.regionIntensity,_that.earthquake);case EarthquakePartialCity() when city != null:
return city(_that.cityIntensity,_that.earthquake);case EarthquakePartialStation() when station != null:
return station(_that.stationIntensity,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String eventId,  TelegramStatus status,  DateTime? originTime,  OriginTimePrecision originTimePrecision,  DateTime? arrivalTime,  List<EarthquakeDataSource> dataSources,  EarthquakeHypocenter? hypocenter,  EarthquakeIntensityPartial? intensity,  EarthquakeType earthquakeType,  List<EarthquakeTelegramType> telegramTypes,  String? estimatedIntensityTileUrl)  normal,required TResult Function( JmaIntensity prefectureIntensity,  EarthquakePartialNormal earthquake)  prefecture,required TResult Function( JmaIntensity regionIntensity,  EarthquakePartialNormal earthquake)  region,required TResult Function( JmaIntensity cityIntensity,  EarthquakePartialNormal earthquake)  city,required TResult Function( JmaIntensity stationIntensity,  EarthquakePartialNormal earthquake)  station,}) {final _that = this;
switch (_that) {
case EarthquakePartialNormal():
return normal(_that.eventId,_that.status,_that.originTime,_that.originTimePrecision,_that.arrivalTime,_that.dataSources,_that.hypocenter,_that.intensity,_that.earthquakeType,_that.telegramTypes,_that.estimatedIntensityTileUrl);case EarthquakePartialPrefecture():
return prefecture(_that.prefectureIntensity,_that.earthquake);case EarthquakePartialRegion():
return region(_that.regionIntensity,_that.earthquake);case EarthquakePartialCity():
return city(_that.cityIntensity,_that.earthquake);case EarthquakePartialStation():
return station(_that.stationIntensity,_that.earthquake);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String eventId,  TelegramStatus status,  DateTime? originTime,  OriginTimePrecision originTimePrecision,  DateTime? arrivalTime,  List<EarthquakeDataSource> dataSources,  EarthquakeHypocenter? hypocenter,  EarthquakeIntensityPartial? intensity,  EarthquakeType earthquakeType,  List<EarthquakeTelegramType> telegramTypes,  String? estimatedIntensityTileUrl)?  normal,TResult? Function( JmaIntensity prefectureIntensity,  EarthquakePartialNormal earthquake)?  prefecture,TResult? Function( JmaIntensity regionIntensity,  EarthquakePartialNormal earthquake)?  region,TResult? Function( JmaIntensity cityIntensity,  EarthquakePartialNormal earthquake)?  city,TResult? Function( JmaIntensity stationIntensity,  EarthquakePartialNormal earthquake)?  station,}) {final _that = this;
switch (_that) {
case EarthquakePartialNormal() when normal != null:
return normal(_that.eventId,_that.status,_that.originTime,_that.originTimePrecision,_that.arrivalTime,_that.dataSources,_that.hypocenter,_that.intensity,_that.earthquakeType,_that.telegramTypes,_that.estimatedIntensityTileUrl);case EarthquakePartialPrefecture() when prefecture != null:
return prefecture(_that.prefectureIntensity,_that.earthquake);case EarthquakePartialRegion() when region != null:
return region(_that.regionIntensity,_that.earthquake);case EarthquakePartialCity() when city != null:
return city(_that.cityIntensity,_that.earthquake);case EarthquakePartialStation() when station != null:
return station(_that.stationIntensity,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class EarthquakePartialNormal extends EarthquakePartial {
  const EarthquakePartialNormal({required this.eventId, required this.status, required this.originTime, required this.originTimePrecision, required this.arrivalTime, required final  List<EarthquakeDataSource> dataSources, required this.hypocenter, required this.intensity, required this.earthquakeType, required final  List<EarthquakeTelegramType> telegramTypes, required this.estimatedIntensityTileUrl, final  String? $type}): _dataSources = dataSources,_telegramTypes = telegramTypes,$type = $type ?? 'normal',super._();
  factory EarthquakePartialNormal.fromJson(Map<String, dynamic> json) => _$EarthquakePartialNormalFromJson(json);

 final  String eventId;
 final  TelegramStatus status;
 final  DateTime? originTime;
 final  OriginTimePrecision originTimePrecision;
 final  DateTime? arrivalTime;
 final  List<EarthquakeDataSource> _dataSources;
 List<EarthquakeDataSource> get dataSources {
  if (_dataSources is EqualUnmodifiableListView) return _dataSources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dataSources);
}

 final  EarthquakeHypocenter? hypocenter;
 final  EarthquakeIntensityPartial? intensity;
 final  EarthquakeType earthquakeType;
 final  List<EarthquakeTelegramType> _telegramTypes;
 List<EarthquakeTelegramType> get telegramTypes {
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegramTypes);
}

 final  String? estimatedIntensityTileUrl;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakePartialNormalCopyWith<EarthquakePartialNormal> get copyWith => _$EarthquakePartialNormalCopyWithImpl<EarthquakePartialNormal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakePartialNormalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakePartialNormal&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&const DeepCollectionEquality().equals(other._dataSources, _dataSources)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes)&&(identical(other.estimatedIntensityTileUrl, estimatedIntensityTileUrl) || other.estimatedIntensityTileUrl == estimatedIntensityTileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTime,originTimePrecision,arrivalTime,const DeepCollectionEquality().hash(_dataSources),hypocenter,intensity,earthquakeType,const DeepCollectionEquality().hash(_telegramTypes),estimatedIntensityTileUrl);

@override
String toString() {
  return 'EarthquakePartial.normal(eventId: $eventId, status: $status, originTime: $originTime, originTimePrecision: $originTimePrecision, arrivalTime: $arrivalTime, dataSources: $dataSources, hypocenter: $hypocenter, intensity: $intensity, earthquakeType: $earthquakeType, telegramTypes: $telegramTypes, estimatedIntensityTileUrl: $estimatedIntensityTileUrl)';
}


}

/// @nodoc
abstract mixin class $EarthquakePartialNormalCopyWith<$Res> implements $EarthquakePartialCopyWith<$Res> {
  factory $EarthquakePartialNormalCopyWith(EarthquakePartialNormal value, $Res Function(EarthquakePartialNormal) _then) = _$EarthquakePartialNormalCopyWithImpl;
@useResult
$Res call({
 String eventId, TelegramStatus status, DateTime? originTime, OriginTimePrecision originTimePrecision, DateTime? arrivalTime, List<EarthquakeDataSource> dataSources, EarthquakeHypocenter? hypocenter, EarthquakeIntensityPartial? intensity, EarthquakeType earthquakeType, List<EarthquakeTelegramType> telegramTypes, String? estimatedIntensityTileUrl
});


$EarthquakeHypocenterCopyWith<$Res>? get hypocenter;$EarthquakeIntensityPartialCopyWith<$Res>? get intensity;

}
/// @nodoc
class _$EarthquakePartialNormalCopyWithImpl<$Res>
    implements $EarthquakePartialNormalCopyWith<$Res> {
  _$EarthquakePartialNormalCopyWithImpl(this._self, this._then);

  final EarthquakePartialNormal _self;
  final $Res Function(EarthquakePartialNormal) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? originTime = freezed,Object? originTimePrecision = null,Object? arrivalTime = freezed,Object? dataSources = null,Object? hypocenter = freezed,Object? intensity = freezed,Object? earthquakeType = null,Object? telegramTypes = null,Object? estimatedIntensityTileUrl = freezed,}) {
  return _then(EarthquakePartialNormal(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,dataSources: null == dataSources ? _self._dataSources : dataSources // ignore: cast_nullable_to_non_nullable
as List<EarthquakeDataSource>,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
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

/// @nodoc
@JsonSerializable()

class EarthquakePartialPrefecture extends EarthquakePartial {
  const EarthquakePartialPrefecture({required this.prefectureIntensity, required this.earthquake, final  String? $type}): $type = $type ?? 'prefecture',super._();
  factory EarthquakePartialPrefecture.fromJson(Map<String, dynamic> json) => _$EarthquakePartialPrefectureFromJson(json);

 final  JmaIntensity prefectureIntensity;
 final  EarthquakePartialNormal earthquake;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakePartialPrefectureCopyWith<EarthquakePartialPrefecture> get copyWith => _$EarthquakePartialPrefectureCopyWithImpl<EarthquakePartialPrefecture>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakePartialPrefectureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakePartialPrefecture&&(identical(other.prefectureIntensity, prefectureIntensity) || other.prefectureIntensity == prefectureIntensity)&&const DeepCollectionEquality().equals(other.earthquake, earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prefectureIntensity,const DeepCollectionEquality().hash(earthquake));

@override
String toString() {
  return 'EarthquakePartial.prefecture(prefectureIntensity: $prefectureIntensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakePartialPrefectureCopyWith<$Res> implements $EarthquakePartialCopyWith<$Res> {
  factory $EarthquakePartialPrefectureCopyWith(EarthquakePartialPrefecture value, $Res Function(EarthquakePartialPrefecture) _then) = _$EarthquakePartialPrefectureCopyWithImpl;
@useResult
$Res call({
 JmaIntensity prefectureIntensity, EarthquakePartialNormal earthquake
});




}
/// @nodoc
class _$EarthquakePartialPrefectureCopyWithImpl<$Res>
    implements $EarthquakePartialPrefectureCopyWith<$Res> {
  _$EarthquakePartialPrefectureCopyWithImpl(this._self, this._then);

  final EarthquakePartialPrefecture _self;
  final $Res Function(EarthquakePartialPrefecture) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? prefectureIntensity = null,Object? earthquake = freezed,}) {
  return _then(EarthquakePartialPrefecture(
prefectureIntensity: null == prefectureIntensity ? _self.prefectureIntensity : prefectureIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,earthquake: freezed == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartialNormal,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EarthquakePartialRegion extends EarthquakePartial {
  const EarthquakePartialRegion({required this.regionIntensity, required this.earthquake, final  String? $type}): $type = $type ?? 'region',super._();
  factory EarthquakePartialRegion.fromJson(Map<String, dynamic> json) => _$EarthquakePartialRegionFromJson(json);

 final  JmaIntensity regionIntensity;
 final  EarthquakePartialNormal earthquake;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakePartialRegionCopyWith<EarthquakePartialRegion> get copyWith => _$EarthquakePartialRegionCopyWithImpl<EarthquakePartialRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakePartialRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakePartialRegion&&(identical(other.regionIntensity, regionIntensity) || other.regionIntensity == regionIntensity)&&const DeepCollectionEquality().equals(other.earthquake, earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionIntensity,const DeepCollectionEquality().hash(earthquake));

@override
String toString() {
  return 'EarthquakePartial.region(regionIntensity: $regionIntensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakePartialRegionCopyWith<$Res> implements $EarthquakePartialCopyWith<$Res> {
  factory $EarthquakePartialRegionCopyWith(EarthquakePartialRegion value, $Res Function(EarthquakePartialRegion) _then) = _$EarthquakePartialRegionCopyWithImpl;
@useResult
$Res call({
 JmaIntensity regionIntensity, EarthquakePartialNormal earthquake
});




}
/// @nodoc
class _$EarthquakePartialRegionCopyWithImpl<$Res>
    implements $EarthquakePartialRegionCopyWith<$Res> {
  _$EarthquakePartialRegionCopyWithImpl(this._self, this._then);

  final EarthquakePartialRegion _self;
  final $Res Function(EarthquakePartialRegion) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? regionIntensity = null,Object? earthquake = freezed,}) {
  return _then(EarthquakePartialRegion(
regionIntensity: null == regionIntensity ? _self.regionIntensity : regionIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,earthquake: freezed == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartialNormal,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EarthquakePartialCity extends EarthquakePartial {
  const EarthquakePartialCity({required this.cityIntensity, required this.earthquake, final  String? $type}): $type = $type ?? 'city',super._();
  factory EarthquakePartialCity.fromJson(Map<String, dynamic> json) => _$EarthquakePartialCityFromJson(json);

 final  JmaIntensity cityIntensity;
 final  EarthquakePartialNormal earthquake;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakePartialCityCopyWith<EarthquakePartialCity> get copyWith => _$EarthquakePartialCityCopyWithImpl<EarthquakePartialCity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakePartialCityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakePartialCity&&(identical(other.cityIntensity, cityIntensity) || other.cityIntensity == cityIntensity)&&const DeepCollectionEquality().equals(other.earthquake, earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cityIntensity,const DeepCollectionEquality().hash(earthquake));

@override
String toString() {
  return 'EarthquakePartial.city(cityIntensity: $cityIntensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakePartialCityCopyWith<$Res> implements $EarthquakePartialCopyWith<$Res> {
  factory $EarthquakePartialCityCopyWith(EarthquakePartialCity value, $Res Function(EarthquakePartialCity) _then) = _$EarthquakePartialCityCopyWithImpl;
@useResult
$Res call({
 JmaIntensity cityIntensity, EarthquakePartialNormal earthquake
});




}
/// @nodoc
class _$EarthquakePartialCityCopyWithImpl<$Res>
    implements $EarthquakePartialCityCopyWith<$Res> {
  _$EarthquakePartialCityCopyWithImpl(this._self, this._then);

  final EarthquakePartialCity _self;
  final $Res Function(EarthquakePartialCity) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cityIntensity = null,Object? earthquake = freezed,}) {
  return _then(EarthquakePartialCity(
cityIntensity: null == cityIntensity ? _self.cityIntensity : cityIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,earthquake: freezed == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartialNormal,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EarthquakePartialStation extends EarthquakePartial {
  const EarthquakePartialStation({required this.stationIntensity, required this.earthquake, final  String? $type}): $type = $type ?? 'station',super._();
  factory EarthquakePartialStation.fromJson(Map<String, dynamic> json) => _$EarthquakePartialStationFromJson(json);

 final  JmaIntensity stationIntensity;
 final  EarthquakePartialNormal earthquake;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakePartialStationCopyWith<EarthquakePartialStation> get copyWith => _$EarthquakePartialStationCopyWithImpl<EarthquakePartialStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakePartialStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakePartialStation&&(identical(other.stationIntensity, stationIntensity) || other.stationIntensity == stationIntensity)&&const DeepCollectionEquality().equals(other.earthquake, earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationIntensity,const DeepCollectionEquality().hash(earthquake));

@override
String toString() {
  return 'EarthquakePartial.station(stationIntensity: $stationIntensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakePartialStationCopyWith<$Res> implements $EarthquakePartialCopyWith<$Res> {
  factory $EarthquakePartialStationCopyWith(EarthquakePartialStation value, $Res Function(EarthquakePartialStation) _then) = _$EarthquakePartialStationCopyWithImpl;
@useResult
$Res call({
 JmaIntensity stationIntensity, EarthquakePartialNormal earthquake
});




}
/// @nodoc
class _$EarthquakePartialStationCopyWithImpl<$Res>
    implements $EarthquakePartialStationCopyWith<$Res> {
  _$EarthquakePartialStationCopyWithImpl(this._self, this._then);

  final EarthquakePartialStation _self;
  final $Res Function(EarthquakePartialStation) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stationIntensity = null,Object? earthquake = freezed,}) {
  return _then(EarthquakePartialStation(
stationIntensity: null == stationIntensity ? _self.stationIntensity : stationIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,earthquake: freezed == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartialNormal,
  ));
}


}


/// @nodoc
mixin _$IntensityAreaInfo {

 String get code; LocalizedName get name; JmaIntensity get intensity; JmaLpgmIntensity? get lpgmIntensity;
/// Create a copy of IntensityAreaInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityAreaInfoCopyWith<IntensityAreaInfo> get copyWith => _$IntensityAreaInfoCopyWithImpl<IntensityAreaInfo>(this as IntensityAreaInfo, _$identity);

  /// Serializes this IntensityAreaInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityAreaInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity);

@override
String toString() {
  return 'IntensityAreaInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityAreaInfoCopyWith<$Res>  {
  factory $IntensityAreaInfoCopyWith(IntensityAreaInfo value, $Res Function(IntensityAreaInfo) _then) = _$IntensityAreaInfoCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name, JmaIntensity intensity, JmaLpgmIntensity? lpgmIntensity
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$IntensityAreaInfoCopyWithImpl<$Res>
    implements $IntensityAreaInfoCopyWith<$Res> {
  _$IntensityAreaInfoCopyWithImpl(this._self, this._then);

  final IntensityAreaInfo _self;
  final $Res Function(IntensityAreaInfo) _then;

/// Create a copy of IntensityAreaInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = null,Object? lpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}
/// Create a copy of IntensityAreaInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityAreaInfo].
extension IntensityAreaInfoPatterns on IntensityAreaInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityAreaInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityAreaInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityAreaInfo value)  $default,){
final _that = this;
switch (_that) {
case _IntensityAreaInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityAreaInfo value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityAreaInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  JmaIntensity intensity,  JmaLpgmIntensity? lpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityAreaInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  JmaIntensity intensity,  JmaLpgmIntensity? lpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityAreaInfo():
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name,  JmaIntensity intensity,  JmaLpgmIntensity? lpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityAreaInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityAreaInfo implements IntensityAreaInfo {
  const _IntensityAreaInfo({required this.code, required this.name, required this.intensity, required this.lpgmIntensity});
  factory _IntensityAreaInfo.fromJson(Map<String, dynamic> json) => _$IntensityAreaInfoFromJson(json);

@override final  String code;
@override final  LocalizedName name;
@override final  JmaIntensity intensity;
@override final  JmaLpgmIntensity? lpgmIntensity;

/// Create a copy of IntensityAreaInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityAreaInfoCopyWith<_IntensityAreaInfo> get copyWith => __$IntensityAreaInfoCopyWithImpl<_IntensityAreaInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityAreaInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityAreaInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity);

@override
String toString() {
  return 'IntensityAreaInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityAreaInfoCopyWith<$Res> implements $IntensityAreaInfoCopyWith<$Res> {
  factory _$IntensityAreaInfoCopyWith(_IntensityAreaInfo value, $Res Function(_IntensityAreaInfo) _then) = __$IntensityAreaInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name, JmaIntensity intensity, JmaLpgmIntensity? lpgmIntensity
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$IntensityAreaInfoCopyWithImpl<$Res>
    implements _$IntensityAreaInfoCopyWith<$Res> {
  __$IntensityAreaInfoCopyWithImpl(this._self, this._then);

  final _IntensityAreaInfo _self;
  final $Res Function(_IntensityAreaInfo) _then;

/// Create a copy of IntensityAreaInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = null,Object? lpgmIntensity = freezed,}) {
  return _then(_IntensityAreaInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}

/// Create a copy of IntensityAreaInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// @nodoc
mixin _$StationSearchInfo {

 String get code; LocalizedName get name; JmaIntensity? get intensity; JmaLpgmIntensity? get lpgmIntensity; double? get sva; List<PrePeriod>? get prePeriods;
/// Create a copy of StationSearchInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationSearchInfoCopyWith<StationSearchInfo> get copyWith => _$StationSearchInfoCopyWithImpl<StationSearchInfo>(this as StationSearchInfo, _$identity);

  /// Serializes this StationSearchInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationSearchInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other.prePeriods, prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity,sva,const DeepCollectionEquality().hash(prePeriods));

@override
String toString() {
  return 'StationSearchInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class $StationSearchInfoCopyWith<$Res>  {
  factory $StationSearchInfoCopyWith(StationSearchInfo value, $Res Function(StationSearchInfo) _then) = _$StationSearchInfoCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name, JmaIntensity? intensity, JmaLpgmIntensity? lpgmIntensity, double? sva, List<PrePeriod>? prePeriods
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$StationSearchInfoCopyWithImpl<$Res>
    implements $StationSearchInfoCopyWith<$Res> {
  _$StationSearchInfoCopyWithImpl(this._self, this._then);

  final StationSearchInfo _self;
  final $Res Function(StationSearchInfo) _then;

/// Create a copy of StationSearchInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double?,prePeriods: freezed == prePeriods ? _self.prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriod>?,
  ));
}
/// Create a copy of StationSearchInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [StationSearchInfo].
extension StationSearchInfoPatterns on StationSearchInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationSearchInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationSearchInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationSearchInfo value)  $default,){
final _that = this;
switch (_that) {
case _StationSearchInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationSearchInfo value)?  $default,){
final _that = this;
switch (_that) {
case _StationSearchInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  JmaIntensity? intensity,  JmaLpgmIntensity? lpgmIntensity,  double? sva,  List<PrePeriod>? prePeriods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationSearchInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  JmaIntensity? intensity,  JmaLpgmIntensity? lpgmIntensity,  double? sva,  List<PrePeriod>? prePeriods)  $default,) {final _that = this;
switch (_that) {
case _StationSearchInfo():
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name,  JmaIntensity? intensity,  JmaLpgmIntensity? lpgmIntensity,  double? sva,  List<PrePeriod>? prePeriods)?  $default,) {final _that = this;
switch (_that) {
case _StationSearchInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StationSearchInfo implements StationSearchInfo {
  const _StationSearchInfo({required this.code, required this.name, required this.intensity, required this.lpgmIntensity, required this.sva, required final  List<PrePeriod>? prePeriods}): _prePeriods = prePeriods;
  factory _StationSearchInfo.fromJson(Map<String, dynamic> json) => _$StationSearchInfoFromJson(json);

@override final  String code;
@override final  LocalizedName name;
@override final  JmaIntensity? intensity;
@override final  JmaLpgmIntensity? lpgmIntensity;
@override final  double? sva;
 final  List<PrePeriod>? _prePeriods;
@override List<PrePeriod>? get prePeriods {
  final value = _prePeriods;
  if (value == null) return null;
  if (_prePeriods is EqualUnmodifiableListView) return _prePeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of StationSearchInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationSearchInfoCopyWith<_StationSearchInfo> get copyWith => __$StationSearchInfoCopyWithImpl<_StationSearchInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StationSearchInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationSearchInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other._prePeriods, _prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity,sva,const DeepCollectionEquality().hash(_prePeriods));

@override
String toString() {
  return 'StationSearchInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class _$StationSearchInfoCopyWith<$Res> implements $StationSearchInfoCopyWith<$Res> {
  factory _$StationSearchInfoCopyWith(_StationSearchInfo value, $Res Function(_StationSearchInfo) _then) = __$StationSearchInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name, JmaIntensity? intensity, JmaLpgmIntensity? lpgmIntensity, double? sva, List<PrePeriod>? prePeriods
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$StationSearchInfoCopyWithImpl<$Res>
    implements _$StationSearchInfoCopyWith<$Res> {
  __$StationSearchInfoCopyWithImpl(this._self, this._then);

  final _StationSearchInfo _self;
  final $Res Function(_StationSearchInfo) _then;

/// Create a copy of StationSearchInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_StationSearchInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double?,prePeriods: freezed == prePeriods ? _self._prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<PrePeriod>?,
  ));
}

/// Create a copy of StationSearchInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}

// dart format on
