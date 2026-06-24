// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_history_map_layer_mode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeHistoryMapLayerAvailability {

 bool get region; bool get city; bool get station;
/// Create a copy of EarthquakeHistoryMapLayerAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryMapLayerAvailabilityCopyWith<EarthquakeHistoryMapLayerAvailability> get copyWith => _$EarthquakeHistoryMapLayerAvailabilityCopyWithImpl<EarthquakeHistoryMapLayerAvailability>(this as EarthquakeHistoryMapLayerAvailability, _$identity);

  /// Serializes this EarthquakeHistoryMapLayerAvailability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryMapLayerAvailability&&(identical(other.region, region) || other.region == region)&&(identical(other.city, city) || other.city == city)&&(identical(other.station, station) || other.station == station));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,city,station);

@override
String toString() {
  return 'EarthquakeHistoryMapLayerAvailability(region: $region, city: $city, station: $station)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryMapLayerAvailabilityCopyWith<$Res>  {
  factory $EarthquakeHistoryMapLayerAvailabilityCopyWith(EarthquakeHistoryMapLayerAvailability value, $Res Function(EarthquakeHistoryMapLayerAvailability) _then) = _$EarthquakeHistoryMapLayerAvailabilityCopyWithImpl;
@useResult
$Res call({
 bool region, bool city, bool station
});




}
/// @nodoc
class _$EarthquakeHistoryMapLayerAvailabilityCopyWithImpl<$Res>
    implements $EarthquakeHistoryMapLayerAvailabilityCopyWith<$Res> {
  _$EarthquakeHistoryMapLayerAvailabilityCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryMapLayerAvailability _self;
  final $Res Function(EarthquakeHistoryMapLayerAvailability) _then;

/// Create a copy of EarthquakeHistoryMapLayerAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? city = null,Object? station = null,}) {
  return _then(_self.copyWith(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as bool,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as bool,station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeHistoryMapLayerAvailability].
extension EarthquakeHistoryMapLayerAvailabilityPatterns on EarthquakeHistoryMapLayerAvailability {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeHistoryMapLayerAvailability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerAvailability() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeHistoryMapLayerAvailability value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerAvailability():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeHistoryMapLayerAvailability value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerAvailability() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool region,  bool city,  bool station)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerAvailability() when $default != null:
return $default(_that.region,_that.city,_that.station);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool region,  bool city,  bool station)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerAvailability():
return $default(_that.region,_that.city,_that.station);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool region,  bool city,  bool station)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerAvailability() when $default != null:
return $default(_that.region,_that.city,_that.station);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeHistoryMapLayerAvailability implements EarthquakeHistoryMapLayerAvailability {
  const _EarthquakeHistoryMapLayerAvailability({required this.region, required this.city, required this.station});
  factory _EarthquakeHistoryMapLayerAvailability.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryMapLayerAvailabilityFromJson(json);

@override final  bool region;
@override final  bool city;
@override final  bool station;

/// Create a copy of EarthquakeHistoryMapLayerAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHistoryMapLayerAvailabilityCopyWith<_EarthquakeHistoryMapLayerAvailability> get copyWith => __$EarthquakeHistoryMapLayerAvailabilityCopyWithImpl<_EarthquakeHistoryMapLayerAvailability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryMapLayerAvailabilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryMapLayerAvailability&&(identical(other.region, region) || other.region == region)&&(identical(other.city, city) || other.city == city)&&(identical(other.station, station) || other.station == station));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,city,station);

@override
String toString() {
  return 'EarthquakeHistoryMapLayerAvailability(region: $region, city: $city, station: $station)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryMapLayerAvailabilityCopyWith<$Res> implements $EarthquakeHistoryMapLayerAvailabilityCopyWith<$Res> {
  factory _$EarthquakeHistoryMapLayerAvailabilityCopyWith(_EarthquakeHistoryMapLayerAvailability value, $Res Function(_EarthquakeHistoryMapLayerAvailability) _then) = __$EarthquakeHistoryMapLayerAvailabilityCopyWithImpl;
@override @useResult
$Res call({
 bool region, bool city, bool station
});




}
/// @nodoc
class __$EarthquakeHistoryMapLayerAvailabilityCopyWithImpl<$Res>
    implements _$EarthquakeHistoryMapLayerAvailabilityCopyWith<$Res> {
  __$EarthquakeHistoryMapLayerAvailabilityCopyWithImpl(this._self, this._then);

  final _EarthquakeHistoryMapLayerAvailability _self;
  final $Res Function(_EarthquakeHistoryMapLayerAvailability) _then;

/// Create a copy of EarthquakeHistoryMapLayerAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? city = null,Object? station = null,}) {
  return _then(_EarthquakeHistoryMapLayerAvailability(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as bool,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as bool,station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EarthquakeHistoryMapLayerZoomThresholds {

/// 自動表示で地域→市区町村に切り替えるズーム
 double get regionToCity;/// 観測点（円・アイコン）の最小表示ズーム
 double get stationMinZoom;/// 観測点名ラベルの最小表示ズーム
 double get stationLabelMinZoom;/// 震央マーカーが半透明になるズーム（zoomFade モード用）
 double get hypocenterFadeZoom;/// 震央誤差矩形が表示されるズーム
 double get hypocenterErrorMinZoom;
/// Create a copy of EarthquakeHistoryMapLayerZoomThresholds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryMapLayerZoomThresholdsCopyWith<EarthquakeHistoryMapLayerZoomThresholds> get copyWith => _$EarthquakeHistoryMapLayerZoomThresholdsCopyWithImpl<EarthquakeHistoryMapLayerZoomThresholds>(this as EarthquakeHistoryMapLayerZoomThresholds, _$identity);

  /// Serializes this EarthquakeHistoryMapLayerZoomThresholds to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryMapLayerZoomThresholds&&(identical(other.regionToCity, regionToCity) || other.regionToCity == regionToCity)&&(identical(other.stationMinZoom, stationMinZoom) || other.stationMinZoom == stationMinZoom)&&(identical(other.stationLabelMinZoom, stationLabelMinZoom) || other.stationLabelMinZoom == stationLabelMinZoom)&&(identical(other.hypocenterFadeZoom, hypocenterFadeZoom) || other.hypocenterFadeZoom == hypocenterFadeZoom)&&(identical(other.hypocenterErrorMinZoom, hypocenterErrorMinZoom) || other.hypocenterErrorMinZoom == hypocenterErrorMinZoom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionToCity,stationMinZoom,stationLabelMinZoom,hypocenterFadeZoom,hypocenterErrorMinZoom);

@override
String toString() {
  return 'EarthquakeHistoryMapLayerZoomThresholds(regionToCity: $regionToCity, stationMinZoom: $stationMinZoom, stationLabelMinZoom: $stationLabelMinZoom, hypocenterFadeZoom: $hypocenterFadeZoom, hypocenterErrorMinZoom: $hypocenterErrorMinZoom)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryMapLayerZoomThresholdsCopyWith<$Res>  {
  factory $EarthquakeHistoryMapLayerZoomThresholdsCopyWith(EarthquakeHistoryMapLayerZoomThresholds value, $Res Function(EarthquakeHistoryMapLayerZoomThresholds) _then) = _$EarthquakeHistoryMapLayerZoomThresholdsCopyWithImpl;
@useResult
$Res call({
 double regionToCity, double stationMinZoom, double stationLabelMinZoom, double hypocenterFadeZoom, double hypocenterErrorMinZoom
});




}
/// @nodoc
class _$EarthquakeHistoryMapLayerZoomThresholdsCopyWithImpl<$Res>
    implements $EarthquakeHistoryMapLayerZoomThresholdsCopyWith<$Res> {
  _$EarthquakeHistoryMapLayerZoomThresholdsCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryMapLayerZoomThresholds _self;
  final $Res Function(EarthquakeHistoryMapLayerZoomThresholds) _then;

/// Create a copy of EarthquakeHistoryMapLayerZoomThresholds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionToCity = null,Object? stationMinZoom = null,Object? stationLabelMinZoom = null,Object? hypocenterFadeZoom = null,Object? hypocenterErrorMinZoom = null,}) {
  return _then(_self.copyWith(
regionToCity: null == regionToCity ? _self.regionToCity : regionToCity // ignore: cast_nullable_to_non_nullable
as double,stationMinZoom: null == stationMinZoom ? _self.stationMinZoom : stationMinZoom // ignore: cast_nullable_to_non_nullable
as double,stationLabelMinZoom: null == stationLabelMinZoom ? _self.stationLabelMinZoom : stationLabelMinZoom // ignore: cast_nullable_to_non_nullable
as double,hypocenterFadeZoom: null == hypocenterFadeZoom ? _self.hypocenterFadeZoom : hypocenterFadeZoom // ignore: cast_nullable_to_non_nullable
as double,hypocenterErrorMinZoom: null == hypocenterErrorMinZoom ? _self.hypocenterErrorMinZoom : hypocenterErrorMinZoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeHistoryMapLayerZoomThresholds].
extension EarthquakeHistoryMapLayerZoomThresholdsPatterns on EarthquakeHistoryMapLayerZoomThresholds {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeHistoryMapLayerZoomThresholds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerZoomThresholds() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeHistoryMapLayerZoomThresholds value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerZoomThresholds():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeHistoryMapLayerZoomThresholds value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerZoomThresholds() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double regionToCity,  double stationMinZoom,  double stationLabelMinZoom,  double hypocenterFadeZoom,  double hypocenterErrorMinZoom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerZoomThresholds() when $default != null:
return $default(_that.regionToCity,_that.stationMinZoom,_that.stationLabelMinZoom,_that.hypocenterFadeZoom,_that.hypocenterErrorMinZoom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double regionToCity,  double stationMinZoom,  double stationLabelMinZoom,  double hypocenterFadeZoom,  double hypocenterErrorMinZoom)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerZoomThresholds():
return $default(_that.regionToCity,_that.stationMinZoom,_that.stationLabelMinZoom,_that.hypocenterFadeZoom,_that.hypocenterErrorMinZoom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double regionToCity,  double stationMinZoom,  double stationLabelMinZoom,  double hypocenterFadeZoom,  double hypocenterErrorMinZoom)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryMapLayerZoomThresholds() when $default != null:
return $default(_that.regionToCity,_that.stationMinZoom,_that.stationLabelMinZoom,_that.hypocenterFadeZoom,_that.hypocenterErrorMinZoom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeHistoryMapLayerZoomThresholds implements EarthquakeHistoryMapLayerZoomThresholds {
  const _EarthquakeHistoryMapLayerZoomThresholds({this.regionToCity = 8, this.stationMinZoom = 8, this.stationLabelMinZoom = 9, this.hypocenterFadeZoom = 8, this.hypocenterErrorMinZoom = 8});
  factory _EarthquakeHistoryMapLayerZoomThresholds.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryMapLayerZoomThresholdsFromJson(json);

/// 自動表示で地域→市区町村に切り替えるズーム
@override@JsonKey() final  double regionToCity;
/// 観測点（円・アイコン）の最小表示ズーム
@override@JsonKey() final  double stationMinZoom;
/// 観測点名ラベルの最小表示ズーム
@override@JsonKey() final  double stationLabelMinZoom;
/// 震央マーカーが半透明になるズーム（zoomFade モード用）
@override@JsonKey() final  double hypocenterFadeZoom;
/// 震央誤差矩形が表示されるズーム
@override@JsonKey() final  double hypocenterErrorMinZoom;

/// Create a copy of EarthquakeHistoryMapLayerZoomThresholds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHistoryMapLayerZoomThresholdsCopyWith<_EarthquakeHistoryMapLayerZoomThresholds> get copyWith => __$EarthquakeHistoryMapLayerZoomThresholdsCopyWithImpl<_EarthquakeHistoryMapLayerZoomThresholds>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryMapLayerZoomThresholdsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryMapLayerZoomThresholds&&(identical(other.regionToCity, regionToCity) || other.regionToCity == regionToCity)&&(identical(other.stationMinZoom, stationMinZoom) || other.stationMinZoom == stationMinZoom)&&(identical(other.stationLabelMinZoom, stationLabelMinZoom) || other.stationLabelMinZoom == stationLabelMinZoom)&&(identical(other.hypocenterFadeZoom, hypocenterFadeZoom) || other.hypocenterFadeZoom == hypocenterFadeZoom)&&(identical(other.hypocenterErrorMinZoom, hypocenterErrorMinZoom) || other.hypocenterErrorMinZoom == hypocenterErrorMinZoom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionToCity,stationMinZoom,stationLabelMinZoom,hypocenterFadeZoom,hypocenterErrorMinZoom);

@override
String toString() {
  return 'EarthquakeHistoryMapLayerZoomThresholds(regionToCity: $regionToCity, stationMinZoom: $stationMinZoom, stationLabelMinZoom: $stationLabelMinZoom, hypocenterFadeZoom: $hypocenterFadeZoom, hypocenterErrorMinZoom: $hypocenterErrorMinZoom)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryMapLayerZoomThresholdsCopyWith<$Res> implements $EarthquakeHistoryMapLayerZoomThresholdsCopyWith<$Res> {
  factory _$EarthquakeHistoryMapLayerZoomThresholdsCopyWith(_EarthquakeHistoryMapLayerZoomThresholds value, $Res Function(_EarthquakeHistoryMapLayerZoomThresholds) _then) = __$EarthquakeHistoryMapLayerZoomThresholdsCopyWithImpl;
@override @useResult
$Res call({
 double regionToCity, double stationMinZoom, double stationLabelMinZoom, double hypocenterFadeZoom, double hypocenterErrorMinZoom
});




}
/// @nodoc
class __$EarthquakeHistoryMapLayerZoomThresholdsCopyWithImpl<$Res>
    implements _$EarthquakeHistoryMapLayerZoomThresholdsCopyWith<$Res> {
  __$EarthquakeHistoryMapLayerZoomThresholdsCopyWithImpl(this._self, this._then);

  final _EarthquakeHistoryMapLayerZoomThresholds _self;
  final $Res Function(_EarthquakeHistoryMapLayerZoomThresholds) _then;

/// Create a copy of EarthquakeHistoryMapLayerZoomThresholds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionToCity = null,Object? stationMinZoom = null,Object? stationLabelMinZoom = null,Object? hypocenterFadeZoom = null,Object? hypocenterErrorMinZoom = null,}) {
  return _then(_EarthquakeHistoryMapLayerZoomThresholds(
regionToCity: null == regionToCity ? _self.regionToCity : regionToCity // ignore: cast_nullable_to_non_nullable
as double,stationMinZoom: null == stationMinZoom ? _self.stationMinZoom : stationMinZoom // ignore: cast_nullable_to_non_nullable
as double,stationLabelMinZoom: null == stationLabelMinZoom ? _self.stationLabelMinZoom : stationLabelMinZoom // ignore: cast_nullable_to_non_nullable
as double,hypocenterFadeZoom: null == hypocenterFadeZoom ? _self.hypocenterFadeZoom : hypocenterFadeZoom // ignore: cast_nullable_to_non_nullable
as double,hypocenterErrorMinZoom: null == hypocenterErrorMinZoom ? _self.hypocenterErrorMinZoom : hypocenterErrorMinZoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
