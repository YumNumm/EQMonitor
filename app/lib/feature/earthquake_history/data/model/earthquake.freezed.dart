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

 String get eventId; TelegramStatus get status; DateTime? get originTime; OriginTimePrecision get originTimePrecision; DateTime? get arrivalTime; List<EarthquakeDataSource> get dataSources; List<EarthquakeTelegramType> get telegramTypes;/// 電文コメント（固定付加文・自由付加文）
 List<EarthquakeTelegramComment> get telegramComments; EarthquakeHypocenter? get hypocenter; EarthquakeIntensity? get intensity;/// 推計震度PMTilesのフルURL
 String? get estimatedIntensityTileUrl;@JsonKey(includeFromJson: false, includeToJson: false) EarthquakeCatalog? get catalog;
/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<Earthquake> get copyWith => _$EarthquakeCopyWithImpl<Earthquake>(this as Earthquake, _$identity);

  /// Serializes this Earthquake to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Earthquake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&const DeepCollectionEquality().equals(other.dataSources, dataSources)&&const DeepCollectionEquality().equals(other.telegramTypes, telegramTypes)&&const DeepCollectionEquality().equals(other.telegramComments, telegramComments)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.estimatedIntensityTileUrl, estimatedIntensityTileUrl) || other.estimatedIntensityTileUrl == estimatedIntensityTileUrl)&&(identical(other.catalog, catalog) || other.catalog == catalog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTime,originTimePrecision,arrivalTime,const DeepCollectionEquality().hash(dataSources),const DeepCollectionEquality().hash(telegramTypes),const DeepCollectionEquality().hash(telegramComments),hypocenter,intensity,estimatedIntensityTileUrl,catalog);

@override
String toString() {
  return 'Earthquake(eventId: $eventId, status: $status, originTime: $originTime, originTimePrecision: $originTimePrecision, arrivalTime: $arrivalTime, dataSources: $dataSources, telegramTypes: $telegramTypes, telegramComments: $telegramComments, hypocenter: $hypocenter, intensity: $intensity, estimatedIntensityTileUrl: $estimatedIntensityTileUrl, catalog: $catalog)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCopyWith<$Res>  {
  factory $EarthquakeCopyWith(Earthquake value, $Res Function(Earthquake) _then) = _$EarthquakeCopyWithImpl;
@useResult
$Res call({
 String eventId, TelegramStatus status, DateTime? originTime, OriginTimePrecision originTimePrecision, DateTime? arrivalTime, List<EarthquakeDataSource> dataSources, List<EarthquakeTelegramType> telegramTypes, List<EarthquakeTelegramComment> telegramComments, EarthquakeHypocenter? hypocenter, EarthquakeIntensity? intensity, String? estimatedIntensityTileUrl,@JsonKey(includeFromJson: false, includeToJson: false) EarthquakeCatalog? catalog
});


$EarthquakeHypocenterCopyWith<$Res>? get hypocenter;$EarthquakeIntensityCopyWith<$Res>? get intensity;$EarthquakeCatalogCopyWith<$Res>? get catalog;

}
/// @nodoc
class _$EarthquakeCopyWithImpl<$Res>
    implements $EarthquakeCopyWith<$Res> {
  _$EarthquakeCopyWithImpl(this._self, this._then);

  final Earthquake _self;
  final $Res Function(Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? originTime = freezed,Object? originTimePrecision = null,Object? arrivalTime = freezed,Object? dataSources = null,Object? telegramTypes = null,Object? telegramComments = null,Object? hypocenter = freezed,Object? intensity = freezed,Object? estimatedIntensityTileUrl = freezed,Object? catalog = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,dataSources: null == dataSources ? _self.dataSources : dataSources // ignore: cast_nullable_to_non_nullable
as List<EarthquakeDataSource>,telegramTypes: null == telegramTypes ? _self.telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>,telegramComments: null == telegramComments ? _self.telegramComments : telegramComments // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramComment>,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as EarthquakeIntensity?,estimatedIntensityTileUrl: freezed == estimatedIntensityTileUrl ? _self.estimatedIntensityTileUrl : estimatedIntensityTileUrl // ignore: cast_nullable_to_non_nullable
as String?,catalog: freezed == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalog?,
  ));
}
/// Create a copy of Earthquake
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
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeIntensityCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $EarthquakeIntensityCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogCopyWith<$Res>? get catalog {
    if (_self.catalog == null) {
    return null;
  }

  return $EarthquakeCatalogCopyWith<$Res>(_self.catalog!, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  TelegramStatus status,  DateTime? originTime,  OriginTimePrecision originTimePrecision,  DateTime? arrivalTime,  List<EarthquakeDataSource> dataSources,  List<EarthquakeTelegramType> telegramTypes,  List<EarthquakeTelegramComment> telegramComments,  EarthquakeHypocenter? hypocenter,  EarthquakeIntensity? intensity,  String? estimatedIntensityTileUrl, @JsonKey(includeFromJson: false, includeToJson: false)  EarthquakeCatalog? catalog)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
return $default(_that.eventId,_that.status,_that.originTime,_that.originTimePrecision,_that.arrivalTime,_that.dataSources,_that.telegramTypes,_that.telegramComments,_that.hypocenter,_that.intensity,_that.estimatedIntensityTileUrl,_that.catalog);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  TelegramStatus status,  DateTime? originTime,  OriginTimePrecision originTimePrecision,  DateTime? arrivalTime,  List<EarthquakeDataSource> dataSources,  List<EarthquakeTelegramType> telegramTypes,  List<EarthquakeTelegramComment> telegramComments,  EarthquakeHypocenter? hypocenter,  EarthquakeIntensity? intensity,  String? estimatedIntensityTileUrl, @JsonKey(includeFromJson: false, includeToJson: false)  EarthquakeCatalog? catalog)  $default,) {final _that = this;
switch (_that) {
case _Earthquake():
return $default(_that.eventId,_that.status,_that.originTime,_that.originTimePrecision,_that.arrivalTime,_that.dataSources,_that.telegramTypes,_that.telegramComments,_that.hypocenter,_that.intensity,_that.estimatedIntensityTileUrl,_that.catalog);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  TelegramStatus status,  DateTime? originTime,  OriginTimePrecision originTimePrecision,  DateTime? arrivalTime,  List<EarthquakeDataSource> dataSources,  List<EarthquakeTelegramType> telegramTypes,  List<EarthquakeTelegramComment> telegramComments,  EarthquakeHypocenter? hypocenter,  EarthquakeIntensity? intensity,  String? estimatedIntensityTileUrl, @JsonKey(includeFromJson: false, includeToJson: false)  EarthquakeCatalog? catalog)?  $default,) {final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
return $default(_that.eventId,_that.status,_that.originTime,_that.originTimePrecision,_that.arrivalTime,_that.dataSources,_that.telegramTypes,_that.telegramComments,_that.hypocenter,_that.intensity,_that.estimatedIntensityTileUrl,_that.catalog);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Earthquake implements Earthquake {
  const _Earthquake({required this.eventId, required this.status, required this.originTime, required this.originTimePrecision, required this.arrivalTime, required final  List<EarthquakeDataSource> dataSources, required final  List<EarthquakeTelegramType> telegramTypes, final  List<EarthquakeTelegramComment> telegramComments = const [], required this.hypocenter, required this.intensity, required this.estimatedIntensityTileUrl, @JsonKey(includeFromJson: false, includeToJson: false) this.catalog}): _dataSources = dataSources,_telegramTypes = telegramTypes,_telegramComments = telegramComments;
  factory _Earthquake.fromJson(Map<String, dynamic> json) => _$EarthquakeFromJson(json);

@override final  String eventId;
@override final  TelegramStatus status;
@override final  DateTime? originTime;
@override final  OriginTimePrecision originTimePrecision;
@override final  DateTime? arrivalTime;
 final  List<EarthquakeDataSource> _dataSources;
@override List<EarthquakeDataSource> get dataSources {
  if (_dataSources is EqualUnmodifiableListView) return _dataSources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dataSources);
}

 final  List<EarthquakeTelegramType> _telegramTypes;
@override List<EarthquakeTelegramType> get telegramTypes {
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegramTypes);
}

/// 電文コメント（固定付加文・自由付加文）
 final  List<EarthquakeTelegramComment> _telegramComments;
/// 電文コメント（固定付加文・自由付加文）
@override@JsonKey() List<EarthquakeTelegramComment> get telegramComments {
  if (_telegramComments is EqualUnmodifiableListView) return _telegramComments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegramComments);
}

@override final  EarthquakeHypocenter? hypocenter;
@override final  EarthquakeIntensity? intensity;
/// 推計震度PMTilesのフルURL
@override final  String? estimatedIntensityTileUrl;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  EarthquakeCatalog? catalog;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Earthquake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&const DeepCollectionEquality().equals(other._dataSources, _dataSources)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes)&&const DeepCollectionEquality().equals(other._telegramComments, _telegramComments)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.estimatedIntensityTileUrl, estimatedIntensityTileUrl) || other.estimatedIntensityTileUrl == estimatedIntensityTileUrl)&&(identical(other.catalog, catalog) || other.catalog == catalog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTime,originTimePrecision,arrivalTime,const DeepCollectionEquality().hash(_dataSources),const DeepCollectionEquality().hash(_telegramTypes),const DeepCollectionEquality().hash(_telegramComments),hypocenter,intensity,estimatedIntensityTileUrl,catalog);

@override
String toString() {
  return 'Earthquake(eventId: $eventId, status: $status, originTime: $originTime, originTimePrecision: $originTimePrecision, arrivalTime: $arrivalTime, dataSources: $dataSources, telegramTypes: $telegramTypes, telegramComments: $telegramComments, hypocenter: $hypocenter, intensity: $intensity, estimatedIntensityTileUrl: $estimatedIntensityTileUrl, catalog: $catalog)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCopyWith<$Res> implements $EarthquakeCopyWith<$Res> {
  factory _$EarthquakeCopyWith(_Earthquake value, $Res Function(_Earthquake) _then) = __$EarthquakeCopyWithImpl;
@override @useResult
$Res call({
 String eventId, TelegramStatus status, DateTime? originTime, OriginTimePrecision originTimePrecision, DateTime? arrivalTime, List<EarthquakeDataSource> dataSources, List<EarthquakeTelegramType> telegramTypes, List<EarthquakeTelegramComment> telegramComments, EarthquakeHypocenter? hypocenter, EarthquakeIntensity? intensity, String? estimatedIntensityTileUrl,@JsonKey(includeFromJson: false, includeToJson: false) EarthquakeCatalog? catalog
});


@override $EarthquakeHypocenterCopyWith<$Res>? get hypocenter;@override $EarthquakeIntensityCopyWith<$Res>? get intensity;@override $EarthquakeCatalogCopyWith<$Res>? get catalog;

}
/// @nodoc
class __$EarthquakeCopyWithImpl<$Res>
    implements _$EarthquakeCopyWith<$Res> {
  __$EarthquakeCopyWithImpl(this._self, this._then);

  final _Earthquake _self;
  final $Res Function(_Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? originTime = freezed,Object? originTimePrecision = null,Object? arrivalTime = freezed,Object? dataSources = null,Object? telegramTypes = null,Object? telegramComments = null,Object? hypocenter = freezed,Object? intensity = freezed,Object? estimatedIntensityTileUrl = freezed,Object? catalog = freezed,}) {
  return _then(_Earthquake(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,dataSources: null == dataSources ? _self._dataSources : dataSources // ignore: cast_nullable_to_non_nullable
as List<EarthquakeDataSource>,telegramTypes: null == telegramTypes ? _self._telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramType>,telegramComments: null == telegramComments ? _self._telegramComments : telegramComments // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramComment>,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as EarthquakeIntensity?,estimatedIntensityTileUrl: freezed == estimatedIntensityTileUrl ? _self.estimatedIntensityTileUrl : estimatedIntensityTileUrl // ignore: cast_nullable_to_non_nullable
as String?,catalog: freezed == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalog?,
  ));
}

/// Create a copy of Earthquake
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
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeIntensityCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $EarthquakeIntensityCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogCopyWith<$Res>? get catalog {
    if (_self.catalog == null) {
    return null;
  }

  return $EarthquakeCatalogCopyWith<$Res>(_self.catalog!, (value) {
    return _then(_self.copyWith(catalog: value));
  });
}
}

// dart format on
