// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_history_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
EarthquakeHistoryParameter _$EarthquakeHistoryParameterFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'all':
          return EarthquakeHistoryParameterAll.fromJson(
            json
          );
                case 'prefecture':
          return EarthquakeHistoryParameterPrefecture.fromJson(
            json
          );
                case 'region':
          return EarthquakeHistoryParameterRegion.fromJson(
            json
          );
                case 'city':
          return EarthquakeHistoryParameterCity.fromJson(
            json
          );
                case 'station':
          return EarthquakeHistoryParameterStation.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'EarthquakeHistoryParameter',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$EarthquakeHistoryParameter {

 EarthquakeSortBy get sortBy; SortOrder get sortOrder; double? get magnitudeGte; double? get magnitudeLte; int? get depthGte; int? get depthLte; JmaIntensity? get intensityGte; JmaIntensity? get intensityLte; List<TelegramStatus>? get statuses; List<int>? get epicenterCodes; EarthquakeType? get earthquakeType; EarthquakeDataSource? get datasource; List<EarthquakeTelegramType>? get telegramTypes; Date? get originTimeGte; Date? get originTimeLte; JmaLpgmIntensity? get maxLpgmIntensityGte; JmaLpgmIntensity? get maxLpgmIntensityLte; double? get latitudeGte; double? get latitudeLte; double? get longitudeGte; double? get longitudeLte;
/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryParameterCopyWith<EarthquakeHistoryParameter> get copyWith => _$EarthquakeHistoryParameterCopyWithImpl<EarthquakeHistoryParameter>(this as EarthquakeHistoryParameter, _$identity);

  /// Serializes this EarthquakeHistoryParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryParameter&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&const DeepCollectionEquality().equals(other.statuses, statuses)&&const DeepCollectionEquality().equals(other.epicenterCodes, epicenterCodes)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.datasource, datasource) || other.datasource == datasource)&&const DeepCollectionEquality().equals(other.telegramTypes, telegramTypes)&&(identical(other.originTimeGte, originTimeGte) || other.originTimeGte == originTimeGte)&&(identical(other.originTimeLte, originTimeLte) || other.originTimeLte == originTimeLte)&&(identical(other.maxLpgmIntensityGte, maxLpgmIntensityGte) || other.maxLpgmIntensityGte == maxLpgmIntensityGte)&&(identical(other.maxLpgmIntensityLte, maxLpgmIntensityLte) || other.maxLpgmIntensityLte == maxLpgmIntensityLte)&&(identical(other.latitudeGte, latitudeGte) || other.latitudeGte == latitudeGte)&&(identical(other.latitudeLte, latitudeLte) || other.latitudeLte == latitudeLte)&&(identical(other.longitudeGte, longitudeGte) || other.longitudeGte == longitudeGte)&&(identical(other.longitudeLte, longitudeLte) || other.longitudeLte == longitudeLte));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sortBy,sortOrder,magnitudeGte,magnitudeLte,depthGte,depthLte,intensityGte,intensityLte,const DeepCollectionEquality().hash(statuses),const DeepCollectionEquality().hash(epicenterCodes),earthquakeType,datasource,const DeepCollectionEquality().hash(telegramTypes),originTimeGte,originTimeLte,maxLpgmIntensityGte,maxLpgmIntensityLte,latitudeGte,latitudeLte,longitudeGte,longitudeLte]);

@override
String toString() {
  return 'EarthquakeHistoryParameter(sortBy: $sortBy, sortOrder: $sortOrder, magnitudeGte: $magnitudeGte, magnitudeLte: $magnitudeLte, depthGte: $depthGte, depthLte: $depthLte, intensityGte: $intensityGte, intensityLte: $intensityLte, statuses: $statuses, epicenterCodes: $epicenterCodes, earthquakeType: $earthquakeType, datasource: $datasource, telegramTypes: $telegramTypes, originTimeGte: $originTimeGte, originTimeLte: $originTimeLte, maxLpgmIntensityGte: $maxLpgmIntensityGte, maxLpgmIntensityLte: $maxLpgmIntensityLte, latitudeGte: $latitudeGte, latitudeLte: $latitudeLte, longitudeGte: $longitudeGte, longitudeLte: $longitudeLte)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryParameterCopyWith<$Res>  {
  factory $EarthquakeHistoryParameterCopyWith(EarthquakeHistoryParameter value, $Res Function(EarthquakeHistoryParameter) _then) = _$EarthquakeHistoryParameterCopyWithImpl;
@useResult
$Res call({
 EarthquakeSortBy sortBy, SortOrder sortOrder, double? magnitudeGte, double? magnitudeLte, int? depthGte, int? depthLte, JmaIntensity? intensityGte, JmaIntensity? intensityLte, List<TelegramStatus>? statuses, List<int>? epicenterCodes, EarthquakeType? earthquakeType, EarthquakeDataSource? datasource, List<EarthquakeTelegramType>? telegramTypes, Date? originTimeGte, Date? originTimeLte, JmaLpgmIntensity? maxLpgmIntensityGte, JmaLpgmIntensity? maxLpgmIntensityLte, double? latitudeGte, double? latitudeLte, double? longitudeGte, double? longitudeLte
});


$DateCopyWith<$Res>? get originTimeGte;$DateCopyWith<$Res>? get originTimeLte;

}
/// @nodoc
class _$EarthquakeHistoryParameterCopyWithImpl<$Res>
    implements $EarthquakeHistoryParameterCopyWith<$Res> {
  _$EarthquakeHistoryParameterCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryParameter _self;
  final $Res Function(EarthquakeHistoryParameter) _then;

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sortBy = null,Object? sortOrder = null,Object? magnitudeGte = freezed,Object? magnitudeLte = freezed,Object? depthGte = freezed,Object? depthLte = freezed,Object? intensityGte = freezed,Object? intensityLte = freezed,Object? statuses = freezed,Object? epicenterCodes = freezed,Object? earthquakeType = freezed,Object? datasource = freezed,Object? telegramTypes = freezed,Object? originTimeGte = freezed,Object? originTimeLte = freezed,Object? maxLpgmIntensityGte = freezed,Object? maxLpgmIntensityLte = freezed,Object? latitudeGte = freezed,Object? latitudeLte = freezed,Object? longitudeGte = freezed,Object? longitudeLte = freezed,}) {
  return _then(_self.copyWith(
sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as EarthquakeSortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,statuses: freezed == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TelegramStatus>?,epicenterCodes: freezed == epicenterCodes ? _self.epicenterCodes : epicenterCodes // ignore: cast_nullable_to_non_nullable
as List<int>?,earthquakeType: freezed == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType?,datasource: freezed == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDataSource?,telegramTypes: freezed == telegramTypes ? _self.telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>?,originTimeGte: freezed == originTimeGte ? _self.originTimeGte : originTimeGte // ignore: cast_nullable_to_non_nullable
as Date?,originTimeLte: freezed == originTimeLte ? _self.originTimeLte : originTimeLte // ignore: cast_nullable_to_non_nullable
as Date?,maxLpgmIntensityGte: freezed == maxLpgmIntensityGte ? _self.maxLpgmIntensityGte : maxLpgmIntensityGte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,maxLpgmIntensityLte: freezed == maxLpgmIntensityLte ? _self.maxLpgmIntensityLte : maxLpgmIntensityLte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,latitudeGte: freezed == latitudeGte ? _self.latitudeGte : latitudeGte // ignore: cast_nullable_to_non_nullable
as double?,latitudeLte: freezed == latitudeLte ? _self.latitudeLte : latitudeLte // ignore: cast_nullable_to_non_nullable
as double?,longitudeGte: freezed == longitudeGte ? _self.longitudeGte : longitudeGte // ignore: cast_nullable_to_non_nullable
as double?,longitudeLte: freezed == longitudeLte ? _self.longitudeLte : longitudeLte // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeGte {
    if (_self.originTimeGte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeGte!, (value) {
    return _then(_self.copyWith(originTimeGte: value));
  });
}/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeLte {
    if (_self.originTimeLte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeLte!, (value) {
    return _then(_self.copyWith(originTimeLte: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeHistoryParameter].
extension EarthquakeHistoryParameterPatterns on EarthquakeHistoryParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EarthquakeHistoryParameterAll value)?  all,TResult Function( EarthquakeHistoryParameterPrefecture value)?  prefecture,TResult Function( EarthquakeHistoryParameterRegion value)?  region,TResult Function( EarthquakeHistoryParameterCity value)?  city,TResult Function( EarthquakeHistoryParameterStation value)?  station,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EarthquakeHistoryParameterAll() when all != null:
return all(_that);case EarthquakeHistoryParameterPrefecture() when prefecture != null:
return prefecture(_that);case EarthquakeHistoryParameterRegion() when region != null:
return region(_that);case EarthquakeHistoryParameterCity() when city != null:
return city(_that);case EarthquakeHistoryParameterStation() when station != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EarthquakeHistoryParameterAll value)  all,required TResult Function( EarthquakeHistoryParameterPrefecture value)  prefecture,required TResult Function( EarthquakeHistoryParameterRegion value)  region,required TResult Function( EarthquakeHistoryParameterCity value)  city,required TResult Function( EarthquakeHistoryParameterStation value)  station,}){
final _that = this;
switch (_that) {
case EarthquakeHistoryParameterAll():
return all(_that);case EarthquakeHistoryParameterPrefecture():
return prefecture(_that);case EarthquakeHistoryParameterRegion():
return region(_that);case EarthquakeHistoryParameterCity():
return city(_that);case EarthquakeHistoryParameterStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EarthquakeHistoryParameterAll value)?  all,TResult? Function( EarthquakeHistoryParameterPrefecture value)?  prefecture,TResult? Function( EarthquakeHistoryParameterRegion value)?  region,TResult? Function( EarthquakeHistoryParameterCity value)?  city,TResult? Function( EarthquakeHistoryParameterStation value)?  station,}){
final _that = this;
switch (_that) {
case EarthquakeHistoryParameterAll() when all != null:
return all(_that);case EarthquakeHistoryParameterPrefecture() when prefecture != null:
return prefecture(_that);case EarthquakeHistoryParameterRegion() when region != null:
return region(_that);case EarthquakeHistoryParameterCity() when city != null:
return city(_that);case EarthquakeHistoryParameterStation() when station != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)?  all,TResult Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String prefectureCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)?  prefecture,TResult Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String regionCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)?  region,TResult Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String cityCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)?  city,TResult Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String stationCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)?  station,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EarthquakeHistoryParameterAll() when all != null:
return all(_that.sortBy,_that.sortOrder,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterPrefecture() when prefecture != null:
return prefecture(_that.sortBy,_that.sortOrder,_that.prefectureCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterRegion() when region != null:
return region(_that.sortBy,_that.sortOrder,_that.regionCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterCity() when city != null:
return city(_that.sortBy,_that.sortOrder,_that.cityCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterStation() when station != null:
return station(_that.sortBy,_that.sortOrder,_that.stationCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)  all,required TResult Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String prefectureCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)  prefecture,required TResult Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String regionCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)  region,required TResult Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String cityCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)  city,required TResult Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String stationCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)  station,}) {final _that = this;
switch (_that) {
case EarthquakeHistoryParameterAll():
return all(_that.sortBy,_that.sortOrder,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterPrefecture():
return prefecture(_that.sortBy,_that.sortOrder,_that.prefectureCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterRegion():
return region(_that.sortBy,_that.sortOrder,_that.regionCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterCity():
return city(_that.sortBy,_that.sortOrder,_that.cityCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterStation():
return station(_that.sortBy,_that.sortOrder,_that.stationCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)?  all,TResult? Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String prefectureCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)?  prefecture,TResult? Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String regionCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)?  region,TResult? Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String cityCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)?  city,TResult? Function( EarthquakeSortBy sortBy,  SortOrder sortOrder,  String stationCode,  int? limit,  String? cursor,  double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes,  EarthquakeType? earthquakeType,  EarthquakeDataSource? datasource,  List<EarthquakeTelegramType>? telegramTypes,  Date? originTimeGte,  Date? originTimeLte,  JmaLpgmIntensity? maxLpgmIntensityGte,  JmaLpgmIntensity? maxLpgmIntensityLte,  double? latitudeGte,  double? latitudeLte,  double? longitudeGte,  double? longitudeLte)?  station,}) {final _that = this;
switch (_that) {
case EarthquakeHistoryParameterAll() when all != null:
return all(_that.sortBy,_that.sortOrder,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterPrefecture() when prefecture != null:
return prefecture(_that.sortBy,_that.sortOrder,_that.prefectureCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterRegion() when region != null:
return region(_that.sortBy,_that.sortOrder,_that.regionCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterCity() when city != null:
return city(_that.sortBy,_that.sortOrder,_that.cityCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case EarthquakeHistoryParameterStation() when station != null:
return station(_that.sortBy,_that.sortOrder,_that.stationCode,_that.limit,_that.cursor,_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.statuses,_that.epicenterCodes,_that.earthquakeType,_that.datasource,_that.telegramTypes,_that.originTimeGte,_that.originTimeLte,_that.maxLpgmIntensityGte,_that.maxLpgmIntensityLte,_that.latitudeGte,_that.latitudeLte,_that.longitudeGte,_that.longitudeLte);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class EarthquakeHistoryParameterAll implements EarthquakeHistoryParameter {
  const EarthquakeHistoryParameterAll({required this.sortBy, required this.sortOrder, this.magnitudeGte, this.magnitudeLte, this.depthGte, this.depthLte, this.intensityGte, this.intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes, this.earthquakeType, this.datasource,  List<EarthquakeTelegramType>? telegramTypes, this.originTimeGte, this.originTimeLte, this.maxLpgmIntensityGte, this.maxLpgmIntensityLte, this.latitudeGte, this.latitudeLte, this.longitudeGte, this.longitudeLte,  String? $type}): _statuses = statuses,_epicenterCodes = epicenterCodes,_telegramTypes = telegramTypes,$type = $type ?? 'all';
  factory EarthquakeHistoryParameterAll.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryParameterAllFromJson(json);

@override final  EarthquakeSortBy sortBy;
@override final  SortOrder sortOrder;
@override final  double? magnitudeGte;
@override final  double? magnitudeLte;
@override final  int? depthGte;
@override final  int? depthLte;
@override final  JmaIntensity? intensityGte;
@override final  JmaIntensity? intensityLte;
 final  List<TelegramStatus>? _statuses;
@override List<TelegramStatus>? get statuses {
  final value = _statuses;
  if (value == null) return null;
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<int>? _epicenterCodes;
@override List<int>? get epicenterCodes {
  final value = _epicenterCodes;
  if (value == null) return null;
  if (_epicenterCodes is EqualUnmodifiableListView) return _epicenterCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  EarthquakeType? earthquakeType;
@override final  EarthquakeDataSource? datasource;
 final  List<EarthquakeTelegramType>? _telegramTypes;
@override List<EarthquakeTelegramType>? get telegramTypes {
  final value = _telegramTypes;
  if (value == null) return null;
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Date? originTimeGte;
@override final  Date? originTimeLte;
@override final  JmaLpgmIntensity? maxLpgmIntensityGte;
@override final  JmaLpgmIntensity? maxLpgmIntensityLte;
@override final  double? latitudeGte;
@override final  double? latitudeLte;
@override final  double? longitudeGte;
@override final  double? longitudeLte;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryParameterAllCopyWith<EarthquakeHistoryParameterAll> get copyWith => _$EarthquakeHistoryParameterAllCopyWithImpl<EarthquakeHistoryParameterAll>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryParameterAllToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryParameterAll&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&const DeepCollectionEquality().equals(other._statuses, _statuses)&&const DeepCollectionEquality().equals(other._epicenterCodes, _epicenterCodes)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.datasource, datasource) || other.datasource == datasource)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes)&&(identical(other.originTimeGte, originTimeGte) || other.originTimeGte == originTimeGte)&&(identical(other.originTimeLte, originTimeLte) || other.originTimeLte == originTimeLte)&&(identical(other.maxLpgmIntensityGte, maxLpgmIntensityGte) || other.maxLpgmIntensityGte == maxLpgmIntensityGte)&&(identical(other.maxLpgmIntensityLte, maxLpgmIntensityLte) || other.maxLpgmIntensityLte == maxLpgmIntensityLte)&&(identical(other.latitudeGte, latitudeGte) || other.latitudeGte == latitudeGte)&&(identical(other.latitudeLte, latitudeLte) || other.latitudeLte == latitudeLte)&&(identical(other.longitudeGte, longitudeGte) || other.longitudeGte == longitudeGte)&&(identical(other.longitudeLte, longitudeLte) || other.longitudeLte == longitudeLte));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sortBy,sortOrder,magnitudeGte,magnitudeLte,depthGte,depthLte,intensityGte,intensityLte,const DeepCollectionEquality().hash(_statuses),const DeepCollectionEquality().hash(_epicenterCodes),earthquakeType,datasource,const DeepCollectionEquality().hash(_telegramTypes),originTimeGte,originTimeLte,maxLpgmIntensityGte,maxLpgmIntensityLte,latitudeGte,latitudeLte,longitudeGte,longitudeLte]);

@override
String toString() {
  return 'EarthquakeHistoryParameter.all(sortBy: $sortBy, sortOrder: $sortOrder, magnitudeGte: $magnitudeGte, magnitudeLte: $magnitudeLte, depthGte: $depthGte, depthLte: $depthLte, intensityGte: $intensityGte, intensityLte: $intensityLte, statuses: $statuses, epicenterCodes: $epicenterCodes, earthquakeType: $earthquakeType, datasource: $datasource, telegramTypes: $telegramTypes, originTimeGte: $originTimeGte, originTimeLte: $originTimeLte, maxLpgmIntensityGte: $maxLpgmIntensityGte, maxLpgmIntensityLte: $maxLpgmIntensityLte, latitudeGte: $latitudeGte, latitudeLte: $latitudeLte, longitudeGte: $longitudeGte, longitudeLte: $longitudeLte)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryParameterAllCopyWith<$Res> implements $EarthquakeHistoryParameterCopyWith<$Res> {
  factory $EarthquakeHistoryParameterAllCopyWith(EarthquakeHistoryParameterAll value, $Res Function(EarthquakeHistoryParameterAll) _then) = _$EarthquakeHistoryParameterAllCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeSortBy sortBy, SortOrder sortOrder, double? magnitudeGte, double? magnitudeLte, int? depthGte, int? depthLte, JmaIntensity? intensityGte, JmaIntensity? intensityLte, List<TelegramStatus>? statuses, List<int>? epicenterCodes, EarthquakeType? earthquakeType, EarthquakeDataSource? datasource, List<EarthquakeTelegramType>? telegramTypes, Date? originTimeGte, Date? originTimeLte, JmaLpgmIntensity? maxLpgmIntensityGte, JmaLpgmIntensity? maxLpgmIntensityLte, double? latitudeGte, double? latitudeLte, double? longitudeGte, double? longitudeLte
});


@override $DateCopyWith<$Res>? get originTimeGte;@override $DateCopyWith<$Res>? get originTimeLte;

}
/// @nodoc
class _$EarthquakeHistoryParameterAllCopyWithImpl<$Res>
    implements $EarthquakeHistoryParameterAllCopyWith<$Res> {
  _$EarthquakeHistoryParameterAllCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryParameterAll _self;
  final $Res Function(EarthquakeHistoryParameterAll) _then;

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortBy = null,Object? sortOrder = null,Object? magnitudeGte = freezed,Object? magnitudeLte = freezed,Object? depthGte = freezed,Object? depthLte = freezed,Object? intensityGte = freezed,Object? intensityLte = freezed,Object? statuses = freezed,Object? epicenterCodes = freezed,Object? earthquakeType = freezed,Object? datasource = freezed,Object? telegramTypes = freezed,Object? originTimeGte = freezed,Object? originTimeLte = freezed,Object? maxLpgmIntensityGte = freezed,Object? maxLpgmIntensityLte = freezed,Object? latitudeGte = freezed,Object? latitudeLte = freezed,Object? longitudeGte = freezed,Object? longitudeLte = freezed,}) {
  return _then(EarthquakeHistoryParameterAll(
sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as EarthquakeSortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,statuses: freezed == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TelegramStatus>?,epicenterCodes: freezed == epicenterCodes ? _self._epicenterCodes : epicenterCodes // ignore: cast_nullable_to_non_nullable
as List<int>?,earthquakeType: freezed == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType?,datasource: freezed == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDataSource?,telegramTypes: freezed == telegramTypes ? _self._telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>?,originTimeGte: freezed == originTimeGte ? _self.originTimeGte : originTimeGte // ignore: cast_nullable_to_non_nullable
as Date?,originTimeLte: freezed == originTimeLte ? _self.originTimeLte : originTimeLte // ignore: cast_nullable_to_non_nullable
as Date?,maxLpgmIntensityGte: freezed == maxLpgmIntensityGte ? _self.maxLpgmIntensityGte : maxLpgmIntensityGte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,maxLpgmIntensityLte: freezed == maxLpgmIntensityLte ? _self.maxLpgmIntensityLte : maxLpgmIntensityLte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,latitudeGte: freezed == latitudeGte ? _self.latitudeGte : latitudeGte // ignore: cast_nullable_to_non_nullable
as double?,latitudeLte: freezed == latitudeLte ? _self.latitudeLte : latitudeLte // ignore: cast_nullable_to_non_nullable
as double?,longitudeGte: freezed == longitudeGte ? _self.longitudeGte : longitudeGte // ignore: cast_nullable_to_non_nullable
as double?,longitudeLte: freezed == longitudeLte ? _self.longitudeLte : longitudeLte // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeGte {
    if (_self.originTimeGte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeGte!, (value) {
    return _then(_self.copyWith(originTimeGte: value));
  });
}/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeLte {
    if (_self.originTimeLte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeLte!, (value) {
    return _then(_self.copyWith(originTimeLte: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class EarthquakeHistoryParameterPrefecture implements EarthquakeHistoryParameter {
  const EarthquakeHistoryParameterPrefecture({required this.sortBy, required this.sortOrder, required this.prefectureCode, this.limit, this.cursor, this.magnitudeGte, this.magnitudeLte, this.depthGte, this.depthLte, this.intensityGte, this.intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes, this.earthquakeType, this.datasource,  List<EarthquakeTelegramType>? telegramTypes, this.originTimeGte, this.originTimeLte, this.maxLpgmIntensityGte, this.maxLpgmIntensityLte, this.latitudeGte, this.latitudeLte, this.longitudeGte, this.longitudeLte,  String? $type}): _statuses = statuses,_epicenterCodes = epicenterCodes,_telegramTypes = telegramTypes,$type = $type ?? 'prefecture';
  factory EarthquakeHistoryParameterPrefecture.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryParameterPrefectureFromJson(json);

@override final  EarthquakeSortBy sortBy;
@override final  SortOrder sortOrder;
 final  String prefectureCode;
 final  int? limit;
 final  String? cursor;
@override final  double? magnitudeGte;
@override final  double? magnitudeLte;
@override final  int? depthGte;
@override final  int? depthLte;
@override final  JmaIntensity? intensityGte;
@override final  JmaIntensity? intensityLte;
 final  List<TelegramStatus>? _statuses;
@override List<TelegramStatus>? get statuses {
  final value = _statuses;
  if (value == null) return null;
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<int>? _epicenterCodes;
@override List<int>? get epicenterCodes {
  final value = _epicenterCodes;
  if (value == null) return null;
  if (_epicenterCodes is EqualUnmodifiableListView) return _epicenterCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  EarthquakeType? earthquakeType;
@override final  EarthquakeDataSource? datasource;
 final  List<EarthquakeTelegramType>? _telegramTypes;
@override List<EarthquakeTelegramType>? get telegramTypes {
  final value = _telegramTypes;
  if (value == null) return null;
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Date? originTimeGte;
@override final  Date? originTimeLte;
@override final  JmaLpgmIntensity? maxLpgmIntensityGte;
@override final  JmaLpgmIntensity? maxLpgmIntensityLte;
@override final  double? latitudeGte;
@override final  double? latitudeLte;
@override final  double? longitudeGte;
@override final  double? longitudeLte;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryParameterPrefectureCopyWith<EarthquakeHistoryParameterPrefecture> get copyWith => _$EarthquakeHistoryParameterPrefectureCopyWithImpl<EarthquakeHistoryParameterPrefecture>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryParameterPrefectureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryParameterPrefecture&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&const DeepCollectionEquality().equals(other._statuses, _statuses)&&const DeepCollectionEquality().equals(other._epicenterCodes, _epicenterCodes)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.datasource, datasource) || other.datasource == datasource)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes)&&(identical(other.originTimeGte, originTimeGte) || other.originTimeGte == originTimeGte)&&(identical(other.originTimeLte, originTimeLte) || other.originTimeLte == originTimeLte)&&(identical(other.maxLpgmIntensityGte, maxLpgmIntensityGte) || other.maxLpgmIntensityGte == maxLpgmIntensityGte)&&(identical(other.maxLpgmIntensityLte, maxLpgmIntensityLte) || other.maxLpgmIntensityLte == maxLpgmIntensityLte)&&(identical(other.latitudeGte, latitudeGte) || other.latitudeGte == latitudeGte)&&(identical(other.latitudeLte, latitudeLte) || other.latitudeLte == latitudeLte)&&(identical(other.longitudeGte, longitudeGte) || other.longitudeGte == longitudeGte)&&(identical(other.longitudeLte, longitudeLte) || other.longitudeLte == longitudeLte));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sortBy,sortOrder,prefectureCode,limit,cursor,magnitudeGte,magnitudeLte,depthGte,depthLte,intensityGte,intensityLte,const DeepCollectionEquality().hash(_statuses),const DeepCollectionEquality().hash(_epicenterCodes),earthquakeType,datasource,const DeepCollectionEquality().hash(_telegramTypes),originTimeGte,originTimeLte,maxLpgmIntensityGte,maxLpgmIntensityLte,latitudeGte,latitudeLte,longitudeGte,longitudeLte]);

@override
String toString() {
  return 'EarthquakeHistoryParameter.prefecture(sortBy: $sortBy, sortOrder: $sortOrder, prefectureCode: $prefectureCode, limit: $limit, cursor: $cursor, magnitudeGte: $magnitudeGte, magnitudeLte: $magnitudeLte, depthGte: $depthGte, depthLte: $depthLte, intensityGte: $intensityGte, intensityLte: $intensityLte, statuses: $statuses, epicenterCodes: $epicenterCodes, earthquakeType: $earthquakeType, datasource: $datasource, telegramTypes: $telegramTypes, originTimeGte: $originTimeGte, originTimeLte: $originTimeLte, maxLpgmIntensityGte: $maxLpgmIntensityGte, maxLpgmIntensityLte: $maxLpgmIntensityLte, latitudeGte: $latitudeGte, latitudeLte: $latitudeLte, longitudeGte: $longitudeGte, longitudeLte: $longitudeLte)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryParameterPrefectureCopyWith<$Res> implements $EarthquakeHistoryParameterCopyWith<$Res> {
  factory $EarthquakeHistoryParameterPrefectureCopyWith(EarthquakeHistoryParameterPrefecture value, $Res Function(EarthquakeHistoryParameterPrefecture) _then) = _$EarthquakeHistoryParameterPrefectureCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeSortBy sortBy, SortOrder sortOrder, String prefectureCode, int? limit, String? cursor, double? magnitudeGte, double? magnitudeLte, int? depthGte, int? depthLte, JmaIntensity? intensityGte, JmaIntensity? intensityLte, List<TelegramStatus>? statuses, List<int>? epicenterCodes, EarthquakeType? earthquakeType, EarthquakeDataSource? datasource, List<EarthquakeTelegramType>? telegramTypes, Date? originTimeGte, Date? originTimeLte, JmaLpgmIntensity? maxLpgmIntensityGte, JmaLpgmIntensity? maxLpgmIntensityLte, double? latitudeGte, double? latitudeLte, double? longitudeGte, double? longitudeLte
});


@override $DateCopyWith<$Res>? get originTimeGte;@override $DateCopyWith<$Res>? get originTimeLte;

}
/// @nodoc
class _$EarthquakeHistoryParameterPrefectureCopyWithImpl<$Res>
    implements $EarthquakeHistoryParameterPrefectureCopyWith<$Res> {
  _$EarthquakeHistoryParameterPrefectureCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryParameterPrefecture _self;
  final $Res Function(EarthquakeHistoryParameterPrefecture) _then;

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortBy = null,Object? sortOrder = null,Object? prefectureCode = null,Object? limit = freezed,Object? cursor = freezed,Object? magnitudeGte = freezed,Object? magnitudeLte = freezed,Object? depthGte = freezed,Object? depthLte = freezed,Object? intensityGte = freezed,Object? intensityLte = freezed,Object? statuses = freezed,Object? epicenterCodes = freezed,Object? earthquakeType = freezed,Object? datasource = freezed,Object? telegramTypes = freezed,Object? originTimeGte = freezed,Object? originTimeLte = freezed,Object? maxLpgmIntensityGte = freezed,Object? maxLpgmIntensityLte = freezed,Object? latitudeGte = freezed,Object? latitudeLte = freezed,Object? longitudeGte = freezed,Object? longitudeLte = freezed,}) {
  return _then(EarthquakeHistoryParameterPrefecture(
sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as EarthquakeSortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,prefectureCode: null == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,statuses: freezed == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TelegramStatus>?,epicenterCodes: freezed == epicenterCodes ? _self._epicenterCodes : epicenterCodes // ignore: cast_nullable_to_non_nullable
as List<int>?,earthquakeType: freezed == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType?,datasource: freezed == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDataSource?,telegramTypes: freezed == telegramTypes ? _self._telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>?,originTimeGte: freezed == originTimeGte ? _self.originTimeGte : originTimeGte // ignore: cast_nullable_to_non_nullable
as Date?,originTimeLte: freezed == originTimeLte ? _self.originTimeLte : originTimeLte // ignore: cast_nullable_to_non_nullable
as Date?,maxLpgmIntensityGte: freezed == maxLpgmIntensityGte ? _self.maxLpgmIntensityGte : maxLpgmIntensityGte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,maxLpgmIntensityLte: freezed == maxLpgmIntensityLte ? _self.maxLpgmIntensityLte : maxLpgmIntensityLte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,latitudeGte: freezed == latitudeGte ? _self.latitudeGte : latitudeGte // ignore: cast_nullable_to_non_nullable
as double?,latitudeLte: freezed == latitudeLte ? _self.latitudeLte : latitudeLte // ignore: cast_nullable_to_non_nullable
as double?,longitudeGte: freezed == longitudeGte ? _self.longitudeGte : longitudeGte // ignore: cast_nullable_to_non_nullable
as double?,longitudeLte: freezed == longitudeLte ? _self.longitudeLte : longitudeLte // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeGte {
    if (_self.originTimeGte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeGte!, (value) {
    return _then(_self.copyWith(originTimeGte: value));
  });
}/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeLte {
    if (_self.originTimeLte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeLte!, (value) {
    return _then(_self.copyWith(originTimeLte: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class EarthquakeHistoryParameterRegion implements EarthquakeHistoryParameter {
  const EarthquakeHistoryParameterRegion({required this.sortBy, required this.sortOrder, required this.regionCode, this.limit, this.cursor, this.magnitudeGte, this.magnitudeLte, this.depthGte, this.depthLte, this.intensityGte, this.intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes, this.earthquakeType, this.datasource,  List<EarthquakeTelegramType>? telegramTypes, this.originTimeGte, this.originTimeLte, this.maxLpgmIntensityGte, this.maxLpgmIntensityLte, this.latitudeGte, this.latitudeLte, this.longitudeGte, this.longitudeLte,  String? $type}): _statuses = statuses,_epicenterCodes = epicenterCodes,_telegramTypes = telegramTypes,$type = $type ?? 'region';
  factory EarthquakeHistoryParameterRegion.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryParameterRegionFromJson(json);

@override final  EarthquakeSortBy sortBy;
@override final  SortOrder sortOrder;
 final  String regionCode;
 final  int? limit;
 final  String? cursor;
@override final  double? magnitudeGte;
@override final  double? magnitudeLte;
@override final  int? depthGte;
@override final  int? depthLte;
@override final  JmaIntensity? intensityGte;
@override final  JmaIntensity? intensityLte;
 final  List<TelegramStatus>? _statuses;
@override List<TelegramStatus>? get statuses {
  final value = _statuses;
  if (value == null) return null;
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<int>? _epicenterCodes;
@override List<int>? get epicenterCodes {
  final value = _epicenterCodes;
  if (value == null) return null;
  if (_epicenterCodes is EqualUnmodifiableListView) return _epicenterCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  EarthquakeType? earthquakeType;
@override final  EarthquakeDataSource? datasource;
 final  List<EarthquakeTelegramType>? _telegramTypes;
@override List<EarthquakeTelegramType>? get telegramTypes {
  final value = _telegramTypes;
  if (value == null) return null;
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Date? originTimeGte;
@override final  Date? originTimeLte;
@override final  JmaLpgmIntensity? maxLpgmIntensityGte;
@override final  JmaLpgmIntensity? maxLpgmIntensityLte;
@override final  double? latitudeGte;
@override final  double? latitudeLte;
@override final  double? longitudeGte;
@override final  double? longitudeLte;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryParameterRegionCopyWith<EarthquakeHistoryParameterRegion> get copyWith => _$EarthquakeHistoryParameterRegionCopyWithImpl<EarthquakeHistoryParameterRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryParameterRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryParameterRegion&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&const DeepCollectionEquality().equals(other._statuses, _statuses)&&const DeepCollectionEquality().equals(other._epicenterCodes, _epicenterCodes)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.datasource, datasource) || other.datasource == datasource)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes)&&(identical(other.originTimeGte, originTimeGte) || other.originTimeGte == originTimeGte)&&(identical(other.originTimeLte, originTimeLte) || other.originTimeLte == originTimeLte)&&(identical(other.maxLpgmIntensityGte, maxLpgmIntensityGte) || other.maxLpgmIntensityGte == maxLpgmIntensityGte)&&(identical(other.maxLpgmIntensityLte, maxLpgmIntensityLte) || other.maxLpgmIntensityLte == maxLpgmIntensityLte)&&(identical(other.latitudeGte, latitudeGte) || other.latitudeGte == latitudeGte)&&(identical(other.latitudeLte, latitudeLte) || other.latitudeLte == latitudeLte)&&(identical(other.longitudeGte, longitudeGte) || other.longitudeGte == longitudeGte)&&(identical(other.longitudeLte, longitudeLte) || other.longitudeLte == longitudeLte));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sortBy,sortOrder,regionCode,limit,cursor,magnitudeGte,magnitudeLte,depthGte,depthLte,intensityGte,intensityLte,const DeepCollectionEquality().hash(_statuses),const DeepCollectionEquality().hash(_epicenterCodes),earthquakeType,datasource,const DeepCollectionEquality().hash(_telegramTypes),originTimeGte,originTimeLte,maxLpgmIntensityGte,maxLpgmIntensityLte,latitudeGte,latitudeLte,longitudeGte,longitudeLte]);

@override
String toString() {
  return 'EarthquakeHistoryParameter.region(sortBy: $sortBy, sortOrder: $sortOrder, regionCode: $regionCode, limit: $limit, cursor: $cursor, magnitudeGte: $magnitudeGte, magnitudeLte: $magnitudeLte, depthGte: $depthGte, depthLte: $depthLte, intensityGte: $intensityGte, intensityLte: $intensityLte, statuses: $statuses, epicenterCodes: $epicenterCodes, earthquakeType: $earthquakeType, datasource: $datasource, telegramTypes: $telegramTypes, originTimeGte: $originTimeGte, originTimeLte: $originTimeLte, maxLpgmIntensityGte: $maxLpgmIntensityGte, maxLpgmIntensityLte: $maxLpgmIntensityLte, latitudeGte: $latitudeGte, latitudeLte: $latitudeLte, longitudeGte: $longitudeGte, longitudeLte: $longitudeLte)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryParameterRegionCopyWith<$Res> implements $EarthquakeHistoryParameterCopyWith<$Res> {
  factory $EarthquakeHistoryParameterRegionCopyWith(EarthquakeHistoryParameterRegion value, $Res Function(EarthquakeHistoryParameterRegion) _then) = _$EarthquakeHistoryParameterRegionCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeSortBy sortBy, SortOrder sortOrder, String regionCode, int? limit, String? cursor, double? magnitudeGte, double? magnitudeLte, int? depthGte, int? depthLte, JmaIntensity? intensityGte, JmaIntensity? intensityLte, List<TelegramStatus>? statuses, List<int>? epicenterCodes, EarthquakeType? earthquakeType, EarthquakeDataSource? datasource, List<EarthquakeTelegramType>? telegramTypes, Date? originTimeGte, Date? originTimeLte, JmaLpgmIntensity? maxLpgmIntensityGte, JmaLpgmIntensity? maxLpgmIntensityLte, double? latitudeGte, double? latitudeLte, double? longitudeGte, double? longitudeLte
});


@override $DateCopyWith<$Res>? get originTimeGte;@override $DateCopyWith<$Res>? get originTimeLte;

}
/// @nodoc
class _$EarthquakeHistoryParameterRegionCopyWithImpl<$Res>
    implements $EarthquakeHistoryParameterRegionCopyWith<$Res> {
  _$EarthquakeHistoryParameterRegionCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryParameterRegion _self;
  final $Res Function(EarthquakeHistoryParameterRegion) _then;

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortBy = null,Object? sortOrder = null,Object? regionCode = null,Object? limit = freezed,Object? cursor = freezed,Object? magnitudeGte = freezed,Object? magnitudeLte = freezed,Object? depthGte = freezed,Object? depthLte = freezed,Object? intensityGte = freezed,Object? intensityLte = freezed,Object? statuses = freezed,Object? epicenterCodes = freezed,Object? earthquakeType = freezed,Object? datasource = freezed,Object? telegramTypes = freezed,Object? originTimeGte = freezed,Object? originTimeLte = freezed,Object? maxLpgmIntensityGte = freezed,Object? maxLpgmIntensityLte = freezed,Object? latitudeGte = freezed,Object? latitudeLte = freezed,Object? longitudeGte = freezed,Object? longitudeLte = freezed,}) {
  return _then(EarthquakeHistoryParameterRegion(
sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as EarthquakeSortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,statuses: freezed == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TelegramStatus>?,epicenterCodes: freezed == epicenterCodes ? _self._epicenterCodes : epicenterCodes // ignore: cast_nullable_to_non_nullable
as List<int>?,earthquakeType: freezed == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType?,datasource: freezed == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDataSource?,telegramTypes: freezed == telegramTypes ? _self._telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>?,originTimeGte: freezed == originTimeGte ? _self.originTimeGte : originTimeGte // ignore: cast_nullable_to_non_nullable
as Date?,originTimeLte: freezed == originTimeLte ? _self.originTimeLte : originTimeLte // ignore: cast_nullable_to_non_nullable
as Date?,maxLpgmIntensityGte: freezed == maxLpgmIntensityGte ? _self.maxLpgmIntensityGte : maxLpgmIntensityGte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,maxLpgmIntensityLte: freezed == maxLpgmIntensityLte ? _self.maxLpgmIntensityLte : maxLpgmIntensityLte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,latitudeGte: freezed == latitudeGte ? _self.latitudeGte : latitudeGte // ignore: cast_nullable_to_non_nullable
as double?,latitudeLte: freezed == latitudeLte ? _self.latitudeLte : latitudeLte // ignore: cast_nullable_to_non_nullable
as double?,longitudeGte: freezed == longitudeGte ? _self.longitudeGte : longitudeGte // ignore: cast_nullable_to_non_nullable
as double?,longitudeLte: freezed == longitudeLte ? _self.longitudeLte : longitudeLte // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeGte {
    if (_self.originTimeGte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeGte!, (value) {
    return _then(_self.copyWith(originTimeGte: value));
  });
}/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeLte {
    if (_self.originTimeLte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeLte!, (value) {
    return _then(_self.copyWith(originTimeLte: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class EarthquakeHistoryParameterCity implements EarthquakeHistoryParameter {
  const EarthquakeHistoryParameterCity({required this.sortBy, required this.sortOrder, required this.cityCode, this.limit, this.cursor, this.magnitudeGte, this.magnitudeLte, this.depthGte, this.depthLte, this.intensityGte, this.intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes, this.earthquakeType, this.datasource,  List<EarthquakeTelegramType>? telegramTypes, this.originTimeGte, this.originTimeLte, this.maxLpgmIntensityGte, this.maxLpgmIntensityLte, this.latitudeGte, this.latitudeLte, this.longitudeGte, this.longitudeLte,  String? $type}): _statuses = statuses,_epicenterCodes = epicenterCodes,_telegramTypes = telegramTypes,$type = $type ?? 'city';
  factory EarthquakeHistoryParameterCity.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryParameterCityFromJson(json);

@override final  EarthquakeSortBy sortBy;
@override final  SortOrder sortOrder;
 final  String cityCode;
 final  int? limit;
 final  String? cursor;
@override final  double? magnitudeGte;
@override final  double? magnitudeLte;
@override final  int? depthGte;
@override final  int? depthLte;
@override final  JmaIntensity? intensityGte;
@override final  JmaIntensity? intensityLte;
 final  List<TelegramStatus>? _statuses;
@override List<TelegramStatus>? get statuses {
  final value = _statuses;
  if (value == null) return null;
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<int>? _epicenterCodes;
@override List<int>? get epicenterCodes {
  final value = _epicenterCodes;
  if (value == null) return null;
  if (_epicenterCodes is EqualUnmodifiableListView) return _epicenterCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  EarthquakeType? earthquakeType;
@override final  EarthquakeDataSource? datasource;
 final  List<EarthquakeTelegramType>? _telegramTypes;
@override List<EarthquakeTelegramType>? get telegramTypes {
  final value = _telegramTypes;
  if (value == null) return null;
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Date? originTimeGte;
@override final  Date? originTimeLte;
@override final  JmaLpgmIntensity? maxLpgmIntensityGte;
@override final  JmaLpgmIntensity? maxLpgmIntensityLte;
@override final  double? latitudeGte;
@override final  double? latitudeLte;
@override final  double? longitudeGte;
@override final  double? longitudeLte;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryParameterCityCopyWith<EarthquakeHistoryParameterCity> get copyWith => _$EarthquakeHistoryParameterCityCopyWithImpl<EarthquakeHistoryParameterCity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryParameterCityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryParameterCity&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&const DeepCollectionEquality().equals(other._statuses, _statuses)&&const DeepCollectionEquality().equals(other._epicenterCodes, _epicenterCodes)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.datasource, datasource) || other.datasource == datasource)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes)&&(identical(other.originTimeGte, originTimeGte) || other.originTimeGte == originTimeGte)&&(identical(other.originTimeLte, originTimeLte) || other.originTimeLte == originTimeLte)&&(identical(other.maxLpgmIntensityGte, maxLpgmIntensityGte) || other.maxLpgmIntensityGte == maxLpgmIntensityGte)&&(identical(other.maxLpgmIntensityLte, maxLpgmIntensityLte) || other.maxLpgmIntensityLte == maxLpgmIntensityLte)&&(identical(other.latitudeGte, latitudeGte) || other.latitudeGte == latitudeGte)&&(identical(other.latitudeLte, latitudeLte) || other.latitudeLte == latitudeLte)&&(identical(other.longitudeGte, longitudeGte) || other.longitudeGte == longitudeGte)&&(identical(other.longitudeLte, longitudeLte) || other.longitudeLte == longitudeLte));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sortBy,sortOrder,cityCode,limit,cursor,magnitudeGte,magnitudeLte,depthGte,depthLte,intensityGte,intensityLte,const DeepCollectionEquality().hash(_statuses),const DeepCollectionEquality().hash(_epicenterCodes),earthquakeType,datasource,const DeepCollectionEquality().hash(_telegramTypes),originTimeGte,originTimeLte,maxLpgmIntensityGte,maxLpgmIntensityLte,latitudeGte,latitudeLte,longitudeGte,longitudeLte]);

@override
String toString() {
  return 'EarthquakeHistoryParameter.city(sortBy: $sortBy, sortOrder: $sortOrder, cityCode: $cityCode, limit: $limit, cursor: $cursor, magnitudeGte: $magnitudeGte, magnitudeLte: $magnitudeLte, depthGte: $depthGte, depthLte: $depthLte, intensityGte: $intensityGte, intensityLte: $intensityLte, statuses: $statuses, epicenterCodes: $epicenterCodes, earthquakeType: $earthquakeType, datasource: $datasource, telegramTypes: $telegramTypes, originTimeGte: $originTimeGte, originTimeLte: $originTimeLte, maxLpgmIntensityGte: $maxLpgmIntensityGte, maxLpgmIntensityLte: $maxLpgmIntensityLte, latitudeGte: $latitudeGte, latitudeLte: $latitudeLte, longitudeGte: $longitudeGte, longitudeLte: $longitudeLte)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryParameterCityCopyWith<$Res> implements $EarthquakeHistoryParameterCopyWith<$Res> {
  factory $EarthquakeHistoryParameterCityCopyWith(EarthquakeHistoryParameterCity value, $Res Function(EarthquakeHistoryParameterCity) _then) = _$EarthquakeHistoryParameterCityCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeSortBy sortBy, SortOrder sortOrder, String cityCode, int? limit, String? cursor, double? magnitudeGte, double? magnitudeLte, int? depthGte, int? depthLte, JmaIntensity? intensityGte, JmaIntensity? intensityLte, List<TelegramStatus>? statuses, List<int>? epicenterCodes, EarthquakeType? earthquakeType, EarthquakeDataSource? datasource, List<EarthquakeTelegramType>? telegramTypes, Date? originTimeGte, Date? originTimeLte, JmaLpgmIntensity? maxLpgmIntensityGte, JmaLpgmIntensity? maxLpgmIntensityLte, double? latitudeGte, double? latitudeLte, double? longitudeGte, double? longitudeLte
});


@override $DateCopyWith<$Res>? get originTimeGte;@override $DateCopyWith<$Res>? get originTimeLte;

}
/// @nodoc
class _$EarthquakeHistoryParameterCityCopyWithImpl<$Res>
    implements $EarthquakeHistoryParameterCityCopyWith<$Res> {
  _$EarthquakeHistoryParameterCityCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryParameterCity _self;
  final $Res Function(EarthquakeHistoryParameterCity) _then;

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortBy = null,Object? sortOrder = null,Object? cityCode = null,Object? limit = freezed,Object? cursor = freezed,Object? magnitudeGte = freezed,Object? magnitudeLte = freezed,Object? depthGte = freezed,Object? depthLte = freezed,Object? intensityGte = freezed,Object? intensityLte = freezed,Object? statuses = freezed,Object? epicenterCodes = freezed,Object? earthquakeType = freezed,Object? datasource = freezed,Object? telegramTypes = freezed,Object? originTimeGte = freezed,Object? originTimeLte = freezed,Object? maxLpgmIntensityGte = freezed,Object? maxLpgmIntensityLte = freezed,Object? latitudeGte = freezed,Object? latitudeLte = freezed,Object? longitudeGte = freezed,Object? longitudeLte = freezed,}) {
  return _then(EarthquakeHistoryParameterCity(
sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as EarthquakeSortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,cityCode: null == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,statuses: freezed == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TelegramStatus>?,epicenterCodes: freezed == epicenterCodes ? _self._epicenterCodes : epicenterCodes // ignore: cast_nullable_to_non_nullable
as List<int>?,earthquakeType: freezed == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType?,datasource: freezed == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDataSource?,telegramTypes: freezed == telegramTypes ? _self._telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>?,originTimeGte: freezed == originTimeGte ? _self.originTimeGte : originTimeGte // ignore: cast_nullable_to_non_nullable
as Date?,originTimeLte: freezed == originTimeLte ? _self.originTimeLte : originTimeLte // ignore: cast_nullable_to_non_nullable
as Date?,maxLpgmIntensityGte: freezed == maxLpgmIntensityGte ? _self.maxLpgmIntensityGte : maxLpgmIntensityGte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,maxLpgmIntensityLte: freezed == maxLpgmIntensityLte ? _self.maxLpgmIntensityLte : maxLpgmIntensityLte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,latitudeGte: freezed == latitudeGte ? _self.latitudeGte : latitudeGte // ignore: cast_nullable_to_non_nullable
as double?,latitudeLte: freezed == latitudeLte ? _self.latitudeLte : latitudeLte // ignore: cast_nullable_to_non_nullable
as double?,longitudeGte: freezed == longitudeGte ? _self.longitudeGte : longitudeGte // ignore: cast_nullable_to_non_nullable
as double?,longitudeLte: freezed == longitudeLte ? _self.longitudeLte : longitudeLte // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeGte {
    if (_self.originTimeGte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeGte!, (value) {
    return _then(_self.copyWith(originTimeGte: value));
  });
}/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeLte {
    if (_self.originTimeLte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeLte!, (value) {
    return _then(_self.copyWith(originTimeLte: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class EarthquakeHistoryParameterStation implements EarthquakeHistoryParameter {
  const EarthquakeHistoryParameterStation({required this.sortBy, required this.sortOrder, required this.stationCode, this.limit, this.cursor, this.magnitudeGte, this.magnitudeLte, this.depthGte, this.depthLte, this.intensityGte, this.intensityLte,  List<TelegramStatus>? statuses,  List<int>? epicenterCodes, this.earthquakeType, this.datasource,  List<EarthquakeTelegramType>? telegramTypes, this.originTimeGte, this.originTimeLte, this.maxLpgmIntensityGte, this.maxLpgmIntensityLte, this.latitudeGte, this.latitudeLte, this.longitudeGte, this.longitudeLte,  String? $type}): _statuses = statuses,_epicenterCodes = epicenterCodes,_telegramTypes = telegramTypes,$type = $type ?? 'station';
  factory EarthquakeHistoryParameterStation.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryParameterStationFromJson(json);

@override final  EarthquakeSortBy sortBy;
@override final  SortOrder sortOrder;
 final  String stationCode;
 final  int? limit;
 final  String? cursor;
@override final  double? magnitudeGte;
@override final  double? magnitudeLte;
@override final  int? depthGte;
@override final  int? depthLte;
@override final  JmaIntensity? intensityGte;
@override final  JmaIntensity? intensityLte;
 final  List<TelegramStatus>? _statuses;
@override List<TelegramStatus>? get statuses {
  final value = _statuses;
  if (value == null) return null;
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<int>? _epicenterCodes;
@override List<int>? get epicenterCodes {
  final value = _epicenterCodes;
  if (value == null) return null;
  if (_epicenterCodes is EqualUnmodifiableListView) return _epicenterCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  EarthquakeType? earthquakeType;
@override final  EarthquakeDataSource? datasource;
 final  List<EarthquakeTelegramType>? _telegramTypes;
@override List<EarthquakeTelegramType>? get telegramTypes {
  final value = _telegramTypes;
  if (value == null) return null;
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Date? originTimeGte;
@override final  Date? originTimeLte;
@override final  JmaLpgmIntensity? maxLpgmIntensityGte;
@override final  JmaLpgmIntensity? maxLpgmIntensityLte;
@override final  double? latitudeGte;
@override final  double? latitudeLte;
@override final  double? longitudeGte;
@override final  double? longitudeLte;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryParameterStationCopyWith<EarthquakeHistoryParameterStation> get copyWith => _$EarthquakeHistoryParameterStationCopyWithImpl<EarthquakeHistoryParameterStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryParameterStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryParameterStation&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&const DeepCollectionEquality().equals(other._statuses, _statuses)&&const DeepCollectionEquality().equals(other._epicenterCodes, _epicenterCodes)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.datasource, datasource) || other.datasource == datasource)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes)&&(identical(other.originTimeGte, originTimeGte) || other.originTimeGte == originTimeGte)&&(identical(other.originTimeLte, originTimeLte) || other.originTimeLte == originTimeLte)&&(identical(other.maxLpgmIntensityGte, maxLpgmIntensityGte) || other.maxLpgmIntensityGte == maxLpgmIntensityGte)&&(identical(other.maxLpgmIntensityLte, maxLpgmIntensityLte) || other.maxLpgmIntensityLte == maxLpgmIntensityLte)&&(identical(other.latitudeGte, latitudeGte) || other.latitudeGte == latitudeGte)&&(identical(other.latitudeLte, latitudeLte) || other.latitudeLte == latitudeLte)&&(identical(other.longitudeGte, longitudeGte) || other.longitudeGte == longitudeGte)&&(identical(other.longitudeLte, longitudeLte) || other.longitudeLte == longitudeLte));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sortBy,sortOrder,stationCode,limit,cursor,magnitudeGte,magnitudeLte,depthGte,depthLte,intensityGte,intensityLte,const DeepCollectionEquality().hash(_statuses),const DeepCollectionEquality().hash(_epicenterCodes),earthquakeType,datasource,const DeepCollectionEquality().hash(_telegramTypes),originTimeGte,originTimeLte,maxLpgmIntensityGte,maxLpgmIntensityLte,latitudeGte,latitudeLte,longitudeGte,longitudeLte]);

@override
String toString() {
  return 'EarthquakeHistoryParameter.station(sortBy: $sortBy, sortOrder: $sortOrder, stationCode: $stationCode, limit: $limit, cursor: $cursor, magnitudeGte: $magnitudeGte, magnitudeLte: $magnitudeLte, depthGte: $depthGte, depthLte: $depthLte, intensityGte: $intensityGte, intensityLte: $intensityLte, statuses: $statuses, epicenterCodes: $epicenterCodes, earthquakeType: $earthquakeType, datasource: $datasource, telegramTypes: $telegramTypes, originTimeGte: $originTimeGte, originTimeLte: $originTimeLte, maxLpgmIntensityGte: $maxLpgmIntensityGte, maxLpgmIntensityLte: $maxLpgmIntensityLte, latitudeGte: $latitudeGte, latitudeLte: $latitudeLte, longitudeGte: $longitudeGte, longitudeLte: $longitudeLte)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryParameterStationCopyWith<$Res> implements $EarthquakeHistoryParameterCopyWith<$Res> {
  factory $EarthquakeHistoryParameterStationCopyWith(EarthquakeHistoryParameterStation value, $Res Function(EarthquakeHistoryParameterStation) _then) = _$EarthquakeHistoryParameterStationCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeSortBy sortBy, SortOrder sortOrder, String stationCode, int? limit, String? cursor, double? magnitudeGte, double? magnitudeLte, int? depthGte, int? depthLte, JmaIntensity? intensityGte, JmaIntensity? intensityLte, List<TelegramStatus>? statuses, List<int>? epicenterCodes, EarthquakeType? earthquakeType, EarthquakeDataSource? datasource, List<EarthquakeTelegramType>? telegramTypes, Date? originTimeGte, Date? originTimeLte, JmaLpgmIntensity? maxLpgmIntensityGte, JmaLpgmIntensity? maxLpgmIntensityLte, double? latitudeGte, double? latitudeLte, double? longitudeGte, double? longitudeLte
});


@override $DateCopyWith<$Res>? get originTimeGte;@override $DateCopyWith<$Res>? get originTimeLte;

}
/// @nodoc
class _$EarthquakeHistoryParameterStationCopyWithImpl<$Res>
    implements $EarthquakeHistoryParameterStationCopyWith<$Res> {
  _$EarthquakeHistoryParameterStationCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryParameterStation _self;
  final $Res Function(EarthquakeHistoryParameterStation) _then;

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortBy = null,Object? sortOrder = null,Object? stationCode = null,Object? limit = freezed,Object? cursor = freezed,Object? magnitudeGte = freezed,Object? magnitudeLte = freezed,Object? depthGte = freezed,Object? depthLte = freezed,Object? intensityGte = freezed,Object? intensityLte = freezed,Object? statuses = freezed,Object? epicenterCodes = freezed,Object? earthquakeType = freezed,Object? datasource = freezed,Object? telegramTypes = freezed,Object? originTimeGte = freezed,Object? originTimeLte = freezed,Object? maxLpgmIntensityGte = freezed,Object? maxLpgmIntensityLte = freezed,Object? latitudeGte = freezed,Object? latitudeLte = freezed,Object? longitudeGte = freezed,Object? longitudeLte = freezed,}) {
  return _then(EarthquakeHistoryParameterStation(
sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as EarthquakeSortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,statuses: freezed == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TelegramStatus>?,epicenterCodes: freezed == epicenterCodes ? _self._epicenterCodes : epicenterCodes // ignore: cast_nullable_to_non_nullable
as List<int>?,earthquakeType: freezed == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType?,datasource: freezed == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as EarthquakeDataSource?,telegramTypes: freezed == telegramTypes ? _self._telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>?,originTimeGte: freezed == originTimeGte ? _self.originTimeGte : originTimeGte // ignore: cast_nullable_to_non_nullable
as Date?,originTimeLte: freezed == originTimeLte ? _self.originTimeLte : originTimeLte // ignore: cast_nullable_to_non_nullable
as Date?,maxLpgmIntensityGte: freezed == maxLpgmIntensityGte ? _self.maxLpgmIntensityGte : maxLpgmIntensityGte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,maxLpgmIntensityLte: freezed == maxLpgmIntensityLte ? _self.maxLpgmIntensityLte : maxLpgmIntensityLte // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,latitudeGte: freezed == latitudeGte ? _self.latitudeGte : latitudeGte // ignore: cast_nullable_to_non_nullable
as double?,latitudeLte: freezed == latitudeLte ? _self.latitudeLte : latitudeLte // ignore: cast_nullable_to_non_nullable
as double?,longitudeGte: freezed == longitudeGte ? _self.longitudeGte : longitudeGte // ignore: cast_nullable_to_non_nullable
as double?,longitudeLte: freezed == longitudeLte ? _self.longitudeLte : longitudeLte // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeGte {
    if (_self.originTimeGte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeGte!, (value) {
    return _then(_self.copyWith(originTimeGte: value));
  });
}/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeLte {
    if (_self.originTimeLte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeLte!, (value) {
    return _then(_self.copyWith(originTimeLte: value));
  });
}
}

// dart format on
