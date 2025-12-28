// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeSearchResultItem {

 String get eventId; EarthquakePartial get earthquake;
/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSearchResultItemCopyWith<EarthquakeSearchResultItem> get copyWith => _$EarthquakeSearchResultItemCopyWithImpl<EarthquakeSearchResultItem>(this as EarthquakeSearchResultItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSearchResultItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,earthquake);

@override
String toString() {
  return 'EarthquakeSearchResultItem(eventId: $eventId, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSearchResultItemCopyWith<$Res>  {
  factory $EarthquakeSearchResultItemCopyWith(EarthquakeSearchResultItem value, $Res Function(EarthquakeSearchResultItem) _then) = _$EarthquakeSearchResultItemCopyWithImpl;
@useResult
$Res call({
 String eventId, EarthquakePartial earthquake
});


$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$EarthquakeSearchResultItemCopyWithImpl<$Res>
    implements $EarthquakeSearchResultItemCopyWith<$Res> {
  _$EarthquakeSearchResultItemCopyWithImpl(this._self, this._then);

  final EarthquakeSearchResultItem _self;
  final $Res Function(EarthquakeSearchResultItem) _then;

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeSearchResultItem].
extension EarthquakeSearchResultItemPatterns on EarthquakeSearchResultItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EarthquakeSearchResultItemRegion value)?  region,TResult Function( EarthquakeSearchResultItemPrefecture value)?  prefecture,TResult Function( EarthquakeSearchResultItemCity value)?  city,TResult Function( EarthquakeSearchResultItemStation value)?  station,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EarthquakeSearchResultItemRegion() when region != null:
return region(_that);case EarthquakeSearchResultItemPrefecture() when prefecture != null:
return prefecture(_that);case EarthquakeSearchResultItemCity() when city != null:
return city(_that);case EarthquakeSearchResultItemStation() when station != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EarthquakeSearchResultItemRegion value)  region,required TResult Function( EarthquakeSearchResultItemPrefecture value)  prefecture,required TResult Function( EarthquakeSearchResultItemCity value)  city,required TResult Function( EarthquakeSearchResultItemStation value)  station,}){
final _that = this;
switch (_that) {
case EarthquakeSearchResultItemRegion():
return region(_that);case EarthquakeSearchResultItemPrefecture():
return prefecture(_that);case EarthquakeSearchResultItemCity():
return city(_that);case EarthquakeSearchResultItemStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EarthquakeSearchResultItemRegion value)?  region,TResult? Function( EarthquakeSearchResultItemPrefecture value)?  prefecture,TResult? Function( EarthquakeSearchResultItemCity value)?  city,TResult? Function( EarthquakeSearchResultItemStation value)?  station,}){
final _that = this;
switch (_that) {
case EarthquakeSearchResultItemRegion() when region != null:
return region(_that);case EarthquakeSearchResultItemPrefecture() when prefecture != null:
return prefecture(_that);case EarthquakeSearchResultItemCity() when city != null:
return city(_that);case EarthquakeSearchResultItemStation() when station != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String eventId,  IntensityRegionInfo region,  EarthquakePartial earthquake)?  region,TResult Function( String eventId,  IntensityRegionInfo prefecture,  EarthquakePartial earthquake)?  prefecture,TResult Function( String eventId,  IntensityRegionInfo city,  EarthquakePartial earthquake)?  city,TResult Function( String eventId,  IntensityStationInfo station,  EarthquakePartial earthquake)?  station,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EarthquakeSearchResultItemRegion() when region != null:
return region(_that.eventId,_that.region,_that.earthquake);case EarthquakeSearchResultItemPrefecture() when prefecture != null:
return prefecture(_that.eventId,_that.prefecture,_that.earthquake);case EarthquakeSearchResultItemCity() when city != null:
return city(_that.eventId,_that.city,_that.earthquake);case EarthquakeSearchResultItemStation() when station != null:
return station(_that.eventId,_that.station,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String eventId,  IntensityRegionInfo region,  EarthquakePartial earthquake)  region,required TResult Function( String eventId,  IntensityRegionInfo prefecture,  EarthquakePartial earthquake)  prefecture,required TResult Function( String eventId,  IntensityRegionInfo city,  EarthquakePartial earthquake)  city,required TResult Function( String eventId,  IntensityStationInfo station,  EarthquakePartial earthquake)  station,}) {final _that = this;
switch (_that) {
case EarthquakeSearchResultItemRegion():
return region(_that.eventId,_that.region,_that.earthquake);case EarthquakeSearchResultItemPrefecture():
return prefecture(_that.eventId,_that.prefecture,_that.earthquake);case EarthquakeSearchResultItemCity():
return city(_that.eventId,_that.city,_that.earthquake);case EarthquakeSearchResultItemStation():
return station(_that.eventId,_that.station,_that.earthquake);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String eventId,  IntensityRegionInfo region,  EarthquakePartial earthquake)?  region,TResult? Function( String eventId,  IntensityRegionInfo prefecture,  EarthquakePartial earthquake)?  prefecture,TResult? Function( String eventId,  IntensityRegionInfo city,  EarthquakePartial earthquake)?  city,TResult? Function( String eventId,  IntensityStationInfo station,  EarthquakePartial earthquake)?  station,}) {final _that = this;
switch (_that) {
case EarthquakeSearchResultItemRegion() when region != null:
return region(_that.eventId,_that.region,_that.earthquake);case EarthquakeSearchResultItemPrefecture() when prefecture != null:
return prefecture(_that.eventId,_that.prefecture,_that.earthquake);case EarthquakeSearchResultItemCity() when city != null:
return city(_that.eventId,_that.city,_that.earthquake);case EarthquakeSearchResultItemStation() when station != null:
return station(_that.eventId,_that.station,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc


class EarthquakeSearchResultItemRegion implements EarthquakeSearchResultItem {
  const EarthquakeSearchResultItemRegion({required this.eventId, required this.region, required this.earthquake});
  

@override final  String eventId;
 final  IntensityRegionInfo region;
@override final  EarthquakePartial earthquake;

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSearchResultItemRegionCopyWith<EarthquakeSearchResultItemRegion> get copyWith => _$EarthquakeSearchResultItemRegionCopyWithImpl<EarthquakeSearchResultItemRegion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSearchResultItemRegion&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.region, region) || other.region == region)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,region,earthquake);

@override
String toString() {
  return 'EarthquakeSearchResultItem.region(eventId: $eventId, region: $region, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSearchResultItemRegionCopyWith<$Res> implements $EarthquakeSearchResultItemCopyWith<$Res> {
  factory $EarthquakeSearchResultItemRegionCopyWith(EarthquakeSearchResultItemRegion value, $Res Function(EarthquakeSearchResultItemRegion) _then) = _$EarthquakeSearchResultItemRegionCopyWithImpl;
@override @useResult
$Res call({
 String eventId, IntensityRegionInfo region, EarthquakePartial earthquake
});


$IntensityRegionInfoCopyWith<$Res> get region;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$EarthquakeSearchResultItemRegionCopyWithImpl<$Res>
    implements $EarthquakeSearchResultItemRegionCopyWith<$Res> {
  _$EarthquakeSearchResultItemRegionCopyWithImpl(this._self, this._then);

  final EarthquakeSearchResultItemRegion _self;
  final $Res Function(EarthquakeSearchResultItemRegion) _then;

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? region = null,Object? earthquake = null,}) {
  return _then(EarthquakeSearchResultItemRegion(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get region {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

/// @nodoc


class EarthquakeSearchResultItemPrefecture implements EarthquakeSearchResultItem {
  const EarthquakeSearchResultItemPrefecture({required this.eventId, required this.prefecture, required this.earthquake});
  

@override final  String eventId;
 final  IntensityRegionInfo prefecture;
@override final  EarthquakePartial earthquake;

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSearchResultItemPrefectureCopyWith<EarthquakeSearchResultItemPrefecture> get copyWith => _$EarthquakeSearchResultItemPrefectureCopyWithImpl<EarthquakeSearchResultItemPrefecture>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSearchResultItemPrefecture&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,prefecture,earthquake);

@override
String toString() {
  return 'EarthquakeSearchResultItem.prefecture(eventId: $eventId, prefecture: $prefecture, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSearchResultItemPrefectureCopyWith<$Res> implements $EarthquakeSearchResultItemCopyWith<$Res> {
  factory $EarthquakeSearchResultItemPrefectureCopyWith(EarthquakeSearchResultItemPrefecture value, $Res Function(EarthquakeSearchResultItemPrefecture) _then) = _$EarthquakeSearchResultItemPrefectureCopyWithImpl;
@override @useResult
$Res call({
 String eventId, IntensityRegionInfo prefecture, EarthquakePartial earthquake
});


$IntensityRegionInfoCopyWith<$Res> get prefecture;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$EarthquakeSearchResultItemPrefectureCopyWithImpl<$Res>
    implements $EarthquakeSearchResultItemPrefectureCopyWith<$Res> {
  _$EarthquakeSearchResultItemPrefectureCopyWithImpl(this._self, this._then);

  final EarthquakeSearchResultItemPrefecture _self;
  final $Res Function(EarthquakeSearchResultItemPrefecture) _then;

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? prefecture = null,Object? earthquake = null,}) {
  return _then(EarthquakeSearchResultItemPrefecture(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get prefecture {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.prefecture, (value) {
    return _then(_self.copyWith(prefecture: value));
  });
}/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

/// @nodoc


class EarthquakeSearchResultItemCity implements EarthquakeSearchResultItem {
  const EarthquakeSearchResultItemCity({required this.eventId, required this.city, required this.earthquake});
  

@override final  String eventId;
 final  IntensityRegionInfo city;
@override final  EarthquakePartial earthquake;

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSearchResultItemCityCopyWith<EarthquakeSearchResultItemCity> get copyWith => _$EarthquakeSearchResultItemCityCopyWithImpl<EarthquakeSearchResultItemCity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSearchResultItemCity&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.city, city) || other.city == city)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,city,earthquake);

@override
String toString() {
  return 'EarthquakeSearchResultItem.city(eventId: $eventId, city: $city, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSearchResultItemCityCopyWith<$Res> implements $EarthquakeSearchResultItemCopyWith<$Res> {
  factory $EarthquakeSearchResultItemCityCopyWith(EarthquakeSearchResultItemCity value, $Res Function(EarthquakeSearchResultItemCity) _then) = _$EarthquakeSearchResultItemCityCopyWithImpl;
@override @useResult
$Res call({
 String eventId, IntensityRegionInfo city, EarthquakePartial earthquake
});


$IntensityRegionInfoCopyWith<$Res> get city;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$EarthquakeSearchResultItemCityCopyWithImpl<$Res>
    implements $EarthquakeSearchResultItemCityCopyWith<$Res> {
  _$EarthquakeSearchResultItemCityCopyWithImpl(this._self, this._then);

  final EarthquakeSearchResultItemCity _self;
  final $Res Function(EarthquakeSearchResultItemCity) _then;

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? city = null,Object? earthquake = null,}) {
  return _then(EarthquakeSearchResultItemCity(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get city {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

/// @nodoc


class EarthquakeSearchResultItemStation implements EarthquakeSearchResultItem {
  const EarthquakeSearchResultItemStation({required this.eventId, required this.station, required this.earthquake});
  

@override final  String eventId;
 final  IntensityStationInfo station;
@override final  EarthquakePartial earthquake;

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSearchResultItemStationCopyWith<EarthquakeSearchResultItemStation> get copyWith => _$EarthquakeSearchResultItemStationCopyWithImpl<EarthquakeSearchResultItemStation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSearchResultItemStation&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.station, station) || other.station == station)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,station,earthquake);

@override
String toString() {
  return 'EarthquakeSearchResultItem.station(eventId: $eventId, station: $station, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSearchResultItemStationCopyWith<$Res> implements $EarthquakeSearchResultItemCopyWith<$Res> {
  factory $EarthquakeSearchResultItemStationCopyWith(EarthquakeSearchResultItemStation value, $Res Function(EarthquakeSearchResultItemStation) _then) = _$EarthquakeSearchResultItemStationCopyWithImpl;
@override @useResult
$Res call({
 String eventId, IntensityStationInfo station, EarthquakePartial earthquake
});


$IntensityStationInfoCopyWith<$Res> get station;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$EarthquakeSearchResultItemStationCopyWithImpl<$Res>
    implements $EarthquakeSearchResultItemStationCopyWith<$Res> {
  _$EarthquakeSearchResultItemStationCopyWithImpl(this._self, this._then);

  final EarthquakeSearchResultItemStation _self;
  final $Res Function(EarthquakeSearchResultItemStation) _then;

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? station = null,Object? earthquake = null,}) {
  return _then(EarthquakeSearchResultItemStation(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as IntensityStationInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityStationInfoCopyWith<$Res> get station {
  
  return $IntensityStationInfoCopyWith<$Res>(_self.station, (value) {
    return _then(_self.copyWith(station: value));
  });
}/// Create a copy of EarthquakeSearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

// dart format on
