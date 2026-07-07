// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeCatalog {

 List<EarthquakeCatalogHypocenter> get hypocenters; List<EarthquakeCatalogStationRecord> get stationRecords; String? get damageScaleLabel; String? get tsunamiScaleLabel; double? get linkMatchConfidence;
/// Create a copy of EarthquakeCatalog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCatalogCopyWith<EarthquakeCatalog> get copyWith => _$EarthquakeCatalogCopyWithImpl<EarthquakeCatalog>(this as EarthquakeCatalog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeCatalog&&const DeepCollectionEquality().equals(other.hypocenters, hypocenters)&&const DeepCollectionEquality().equals(other.stationRecords, stationRecords)&&(identical(other.damageScaleLabel, damageScaleLabel) || other.damageScaleLabel == damageScaleLabel)&&(identical(other.tsunamiScaleLabel, tsunamiScaleLabel) || other.tsunamiScaleLabel == tsunamiScaleLabel)&&(identical(other.linkMatchConfidence, linkMatchConfidence) || other.linkMatchConfidence == linkMatchConfidence));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(hypocenters),const DeepCollectionEquality().hash(stationRecords),damageScaleLabel,tsunamiScaleLabel,linkMatchConfidence);

@override
String toString() {
  return 'EarthquakeCatalog(hypocenters: $hypocenters, stationRecords: $stationRecords, damageScaleLabel: $damageScaleLabel, tsunamiScaleLabel: $tsunamiScaleLabel, linkMatchConfidence: $linkMatchConfidence)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCatalogCopyWith<$Res>  {
  factory $EarthquakeCatalogCopyWith(EarthquakeCatalog value, $Res Function(EarthquakeCatalog) _then) = _$EarthquakeCatalogCopyWithImpl;
@useResult
$Res call({
 List<EarthquakeCatalogHypocenter> hypocenters, List<EarthquakeCatalogStationRecord> stationRecords, String? damageScaleLabel, String? tsunamiScaleLabel, double? linkMatchConfidence
});




}
/// @nodoc
class _$EarthquakeCatalogCopyWithImpl<$Res>
    implements $EarthquakeCatalogCopyWith<$Res> {
  _$EarthquakeCatalogCopyWithImpl(this._self, this._then);

  final EarthquakeCatalog _self;
  final $Res Function(EarthquakeCatalog) _then;

/// Create a copy of EarthquakeCatalog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hypocenters = null,Object? stationRecords = null,Object? damageScaleLabel = freezed,Object? tsunamiScaleLabel = freezed,Object? linkMatchConfidence = freezed,}) {
  return _then(_self.copyWith(
hypocenters: null == hypocenters ? _self.hypocenters : hypocenters // ignore: cast_nullable_to_non_nullable
as List<EarthquakeCatalogHypocenter>,stationRecords: null == stationRecords ? _self.stationRecords : stationRecords // ignore: cast_nullable_to_non_nullable
as List<EarthquakeCatalogStationRecord>,damageScaleLabel: freezed == damageScaleLabel ? _self.damageScaleLabel : damageScaleLabel // ignore: cast_nullable_to_non_nullable
as String?,tsunamiScaleLabel: freezed == tsunamiScaleLabel ? _self.tsunamiScaleLabel : tsunamiScaleLabel // ignore: cast_nullable_to_non_nullable
as String?,linkMatchConfidence: freezed == linkMatchConfidence ? _self.linkMatchConfidence : linkMatchConfidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeCatalog].
extension EarthquakeCatalogPatterns on EarthquakeCatalog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeCatalog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeCatalog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeCatalog value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeCatalog value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EarthquakeCatalogHypocenter> hypocenters,  List<EarthquakeCatalogStationRecord> stationRecords,  String? damageScaleLabel,  String? tsunamiScaleLabel,  double? linkMatchConfidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeCatalog() when $default != null:
return $default(_that.hypocenters,_that.stationRecords,_that.damageScaleLabel,_that.tsunamiScaleLabel,_that.linkMatchConfidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EarthquakeCatalogHypocenter> hypocenters,  List<EarthquakeCatalogStationRecord> stationRecords,  String? damageScaleLabel,  String? tsunamiScaleLabel,  double? linkMatchConfidence)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalog():
return $default(_that.hypocenters,_that.stationRecords,_that.damageScaleLabel,_that.tsunamiScaleLabel,_that.linkMatchConfidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EarthquakeCatalogHypocenter> hypocenters,  List<EarthquakeCatalogStationRecord> stationRecords,  String? damageScaleLabel,  String? tsunamiScaleLabel,  double? linkMatchConfidence)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalog() when $default != null:
return $default(_that.hypocenters,_that.stationRecords,_that.damageScaleLabel,_that.tsunamiScaleLabel,_that.linkMatchConfidence);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeCatalog implements EarthquakeCatalog {
  const _EarthquakeCatalog({required final  List<EarthquakeCatalogHypocenter> hypocenters, required final  List<EarthquakeCatalogStationRecord> stationRecords, required this.damageScaleLabel, required this.tsunamiScaleLabel, required this.linkMatchConfidence}): _hypocenters = hypocenters,_stationRecords = stationRecords;
  

 final  List<EarthquakeCatalogHypocenter> _hypocenters;
@override List<EarthquakeCatalogHypocenter> get hypocenters {
  if (_hypocenters is EqualUnmodifiableListView) return _hypocenters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hypocenters);
}

 final  List<EarthquakeCatalogStationRecord> _stationRecords;
@override List<EarthquakeCatalogStationRecord> get stationRecords {
  if (_stationRecords is EqualUnmodifiableListView) return _stationRecords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stationRecords);
}

@override final  String? damageScaleLabel;
@override final  String? tsunamiScaleLabel;
@override final  double? linkMatchConfidence;

/// Create a copy of EarthquakeCatalog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCatalogCopyWith<_EarthquakeCatalog> get copyWith => __$EarthquakeCatalogCopyWithImpl<_EarthquakeCatalog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeCatalog&&const DeepCollectionEquality().equals(other._hypocenters, _hypocenters)&&const DeepCollectionEquality().equals(other._stationRecords, _stationRecords)&&(identical(other.damageScaleLabel, damageScaleLabel) || other.damageScaleLabel == damageScaleLabel)&&(identical(other.tsunamiScaleLabel, tsunamiScaleLabel) || other.tsunamiScaleLabel == tsunamiScaleLabel)&&(identical(other.linkMatchConfidence, linkMatchConfidence) || other.linkMatchConfidence == linkMatchConfidence));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_hypocenters),const DeepCollectionEquality().hash(_stationRecords),damageScaleLabel,tsunamiScaleLabel,linkMatchConfidence);

@override
String toString() {
  return 'EarthquakeCatalog(hypocenters: $hypocenters, stationRecords: $stationRecords, damageScaleLabel: $damageScaleLabel, tsunamiScaleLabel: $tsunamiScaleLabel, linkMatchConfidence: $linkMatchConfidence)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCatalogCopyWith<$Res> implements $EarthquakeCatalogCopyWith<$Res> {
  factory _$EarthquakeCatalogCopyWith(_EarthquakeCatalog value, $Res Function(_EarthquakeCatalog) _then) = __$EarthquakeCatalogCopyWithImpl;
@override @useResult
$Res call({
 List<EarthquakeCatalogHypocenter> hypocenters, List<EarthquakeCatalogStationRecord> stationRecords, String? damageScaleLabel, String? tsunamiScaleLabel, double? linkMatchConfidence
});




}
/// @nodoc
class __$EarthquakeCatalogCopyWithImpl<$Res>
    implements _$EarthquakeCatalogCopyWith<$Res> {
  __$EarthquakeCatalogCopyWithImpl(this._self, this._then);

  final _EarthquakeCatalog _self;
  final $Res Function(_EarthquakeCatalog) _then;

/// Create a copy of EarthquakeCatalog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hypocenters = null,Object? stationRecords = null,Object? damageScaleLabel = freezed,Object? tsunamiScaleLabel = freezed,Object? linkMatchConfidence = freezed,}) {
  return _then(_EarthquakeCatalog(
hypocenters: null == hypocenters ? _self._hypocenters : hypocenters // ignore: cast_nullable_to_non_nullable
as List<EarthquakeCatalogHypocenter>,stationRecords: null == stationRecords ? _self._stationRecords : stationRecords // ignore: cast_nullable_to_non_nullable
as List<EarthquakeCatalogStationRecord>,damageScaleLabel: freezed == damageScaleLabel ? _self.damageScaleLabel : damageScaleLabel // ignore: cast_nullable_to_non_nullable
as String?,tsunamiScaleLabel: freezed == tsunamiScaleLabel ? _self.tsunamiScaleLabel : tsunamiScaleLabel // ignore: cast_nullable_to_non_nullable
as String?,linkMatchConfidence: freezed == linkMatchConfidence ? _self.linkMatchConfidence : linkMatchConfidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$EarthquakeCatalogHypocenter {

 int get seq; String get epicenterName; int get stationCount; String get recordTypeLabel; DateTime? get originTime; double? get originTimeStderrSeconds; double? get latitude; double? get longitude; double? get depthKm; bool get depthIsFree; double? get depthStderrKm; ShindoDbIntensityClass? get maxIntensity; String? get determinationFlagLabel; String? get evaluationLabel; List<EarthquakeCatalogMagnitude> get magnitudes;
/// Create a copy of EarthquakeCatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCatalogHypocenterCopyWith<EarthquakeCatalogHypocenter> get copyWith => _$EarthquakeCatalogHypocenterCopyWithImpl<EarthquakeCatalogHypocenter>(this as EarthquakeCatalogHypocenter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeCatalogHypocenter&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.stationCount, stationCount) || other.stationCount == stationCount)&&(identical(other.recordTypeLabel, recordTypeLabel) || other.recordTypeLabel == recordTypeLabel)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimeStderrSeconds, originTimeStderrSeconds) || other.originTimeStderrSeconds == originTimeStderrSeconds)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.depthIsFree, depthIsFree) || other.depthIsFree == depthIsFree)&&(identical(other.depthStderrKm, depthStderrKm) || other.depthStderrKm == depthStderrKm)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.determinationFlagLabel, determinationFlagLabel) || other.determinationFlagLabel == determinationFlagLabel)&&(identical(other.evaluationLabel, evaluationLabel) || other.evaluationLabel == evaluationLabel)&&const DeepCollectionEquality().equals(other.magnitudes, magnitudes));
}


@override
int get hashCode => Object.hash(runtimeType,seq,epicenterName,stationCount,recordTypeLabel,originTime,originTimeStderrSeconds,latitude,longitude,depthKm,depthIsFree,depthStderrKm,maxIntensity,determinationFlagLabel,evaluationLabel,const DeepCollectionEquality().hash(magnitudes));

@override
String toString() {
  return 'EarthquakeCatalogHypocenter(seq: $seq, epicenterName: $epicenterName, stationCount: $stationCount, recordTypeLabel: $recordTypeLabel, originTime: $originTime, originTimeStderrSeconds: $originTimeStderrSeconds, latitude: $latitude, longitude: $longitude, depthKm: $depthKm, depthIsFree: $depthIsFree, depthStderrKm: $depthStderrKm, maxIntensity: $maxIntensity, determinationFlagLabel: $determinationFlagLabel, evaluationLabel: $evaluationLabel, magnitudes: $magnitudes)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCatalogHypocenterCopyWith<$Res>  {
  factory $EarthquakeCatalogHypocenterCopyWith(EarthquakeCatalogHypocenter value, $Res Function(EarthquakeCatalogHypocenter) _then) = _$EarthquakeCatalogHypocenterCopyWithImpl;
@useResult
$Res call({
 int seq, String epicenterName, int stationCount, String recordTypeLabel, DateTime? originTime, double? originTimeStderrSeconds, double? latitude, double? longitude, double? depthKm, bool depthIsFree, double? depthStderrKm, ShindoDbIntensityClass? maxIntensity, String? determinationFlagLabel, String? evaluationLabel, List<EarthquakeCatalogMagnitude> magnitudes
});




}
/// @nodoc
class _$EarthquakeCatalogHypocenterCopyWithImpl<$Res>
    implements $EarthquakeCatalogHypocenterCopyWith<$Res> {
  _$EarthquakeCatalogHypocenterCopyWithImpl(this._self, this._then);

  final EarthquakeCatalogHypocenter _self;
  final $Res Function(EarthquakeCatalogHypocenter) _then;

/// Create a copy of EarthquakeCatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seq = null,Object? epicenterName = null,Object? stationCount = null,Object? recordTypeLabel = null,Object? originTime = freezed,Object? originTimeStderrSeconds = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? depthKm = freezed,Object? depthIsFree = null,Object? depthStderrKm = freezed,Object? maxIntensity = freezed,Object? determinationFlagLabel = freezed,Object? evaluationLabel = freezed,Object? magnitudes = null,}) {
  return _then(_self.copyWith(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,epicenterName: null == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String,stationCount: null == stationCount ? _self.stationCount : stationCount // ignore: cast_nullable_to_non_nullable
as int,recordTypeLabel: null == recordTypeLabel ? _self.recordTypeLabel : recordTypeLabel // ignore: cast_nullable_to_non_nullable
as String,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimeStderrSeconds: freezed == originTimeStderrSeconds ? _self.originTimeStderrSeconds : originTimeStderrSeconds // ignore: cast_nullable_to_non_nullable
as double?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double?,depthIsFree: null == depthIsFree ? _self.depthIsFree : depthIsFree // ignore: cast_nullable_to_non_nullable
as bool,depthStderrKm: freezed == depthStderrKm ? _self.depthStderrKm : depthStderrKm // ignore: cast_nullable_to_non_nullable
as double?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as ShindoDbIntensityClass?,determinationFlagLabel: freezed == determinationFlagLabel ? _self.determinationFlagLabel : determinationFlagLabel // ignore: cast_nullable_to_non_nullable
as String?,evaluationLabel: freezed == evaluationLabel ? _self.evaluationLabel : evaluationLabel // ignore: cast_nullable_to_non_nullable
as String?,magnitudes: null == magnitudes ? _self.magnitudes : magnitudes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeCatalogMagnitude>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeCatalogHypocenter].
extension EarthquakeCatalogHypocenterPatterns on EarthquakeCatalogHypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeCatalogHypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeCatalogHypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeCatalogHypocenter value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogHypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeCatalogHypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogHypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seq,  String epicenterName,  int stationCount,  String recordTypeLabel,  DateTime? originTime,  double? originTimeStderrSeconds,  double? latitude,  double? longitude,  double? depthKm,  bool depthIsFree,  double? depthStderrKm,  ShindoDbIntensityClass? maxIntensity,  String? determinationFlagLabel,  String? evaluationLabel,  List<EarthquakeCatalogMagnitude> magnitudes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeCatalogHypocenter() when $default != null:
return $default(_that.seq,_that.epicenterName,_that.stationCount,_that.recordTypeLabel,_that.originTime,_that.originTimeStderrSeconds,_that.latitude,_that.longitude,_that.depthKm,_that.depthIsFree,_that.depthStderrKm,_that.maxIntensity,_that.determinationFlagLabel,_that.evaluationLabel,_that.magnitudes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seq,  String epicenterName,  int stationCount,  String recordTypeLabel,  DateTime? originTime,  double? originTimeStderrSeconds,  double? latitude,  double? longitude,  double? depthKm,  bool depthIsFree,  double? depthStderrKm,  ShindoDbIntensityClass? maxIntensity,  String? determinationFlagLabel,  String? evaluationLabel,  List<EarthquakeCatalogMagnitude> magnitudes)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogHypocenter():
return $default(_that.seq,_that.epicenterName,_that.stationCount,_that.recordTypeLabel,_that.originTime,_that.originTimeStderrSeconds,_that.latitude,_that.longitude,_that.depthKm,_that.depthIsFree,_that.depthStderrKm,_that.maxIntensity,_that.determinationFlagLabel,_that.evaluationLabel,_that.magnitudes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seq,  String epicenterName,  int stationCount,  String recordTypeLabel,  DateTime? originTime,  double? originTimeStderrSeconds,  double? latitude,  double? longitude,  double? depthKm,  bool depthIsFree,  double? depthStderrKm,  ShindoDbIntensityClass? maxIntensity,  String? determinationFlagLabel,  String? evaluationLabel,  List<EarthquakeCatalogMagnitude> magnitudes)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogHypocenter() when $default != null:
return $default(_that.seq,_that.epicenterName,_that.stationCount,_that.recordTypeLabel,_that.originTime,_that.originTimeStderrSeconds,_that.latitude,_that.longitude,_that.depthKm,_that.depthIsFree,_that.depthStderrKm,_that.maxIntensity,_that.determinationFlagLabel,_that.evaluationLabel,_that.magnitudes);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeCatalogHypocenter implements EarthquakeCatalogHypocenter {
  const _EarthquakeCatalogHypocenter({required this.seq, required this.epicenterName, required this.stationCount, required this.recordTypeLabel, required this.originTime, required this.originTimeStderrSeconds, required this.latitude, required this.longitude, required this.depthKm, required this.depthIsFree, required this.depthStderrKm, required this.maxIntensity, required this.determinationFlagLabel, required this.evaluationLabel, required final  List<EarthquakeCatalogMagnitude> magnitudes}): _magnitudes = magnitudes;
  

@override final  int seq;
@override final  String epicenterName;
@override final  int stationCount;
@override final  String recordTypeLabel;
@override final  DateTime? originTime;
@override final  double? originTimeStderrSeconds;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? depthKm;
@override final  bool depthIsFree;
@override final  double? depthStderrKm;
@override final  ShindoDbIntensityClass? maxIntensity;
@override final  String? determinationFlagLabel;
@override final  String? evaluationLabel;
 final  List<EarthquakeCatalogMagnitude> _magnitudes;
@override List<EarthquakeCatalogMagnitude> get magnitudes {
  if (_magnitudes is EqualUnmodifiableListView) return _magnitudes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_magnitudes);
}


/// Create a copy of EarthquakeCatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCatalogHypocenterCopyWith<_EarthquakeCatalogHypocenter> get copyWith => __$EarthquakeCatalogHypocenterCopyWithImpl<_EarthquakeCatalogHypocenter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeCatalogHypocenter&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.stationCount, stationCount) || other.stationCount == stationCount)&&(identical(other.recordTypeLabel, recordTypeLabel) || other.recordTypeLabel == recordTypeLabel)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimeStderrSeconds, originTimeStderrSeconds) || other.originTimeStderrSeconds == originTimeStderrSeconds)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.depthIsFree, depthIsFree) || other.depthIsFree == depthIsFree)&&(identical(other.depthStderrKm, depthStderrKm) || other.depthStderrKm == depthStderrKm)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.determinationFlagLabel, determinationFlagLabel) || other.determinationFlagLabel == determinationFlagLabel)&&(identical(other.evaluationLabel, evaluationLabel) || other.evaluationLabel == evaluationLabel)&&const DeepCollectionEquality().equals(other._magnitudes, _magnitudes));
}


@override
int get hashCode => Object.hash(runtimeType,seq,epicenterName,stationCount,recordTypeLabel,originTime,originTimeStderrSeconds,latitude,longitude,depthKm,depthIsFree,depthStderrKm,maxIntensity,determinationFlagLabel,evaluationLabel,const DeepCollectionEquality().hash(_magnitudes));

@override
String toString() {
  return 'EarthquakeCatalogHypocenter(seq: $seq, epicenterName: $epicenterName, stationCount: $stationCount, recordTypeLabel: $recordTypeLabel, originTime: $originTime, originTimeStderrSeconds: $originTimeStderrSeconds, latitude: $latitude, longitude: $longitude, depthKm: $depthKm, depthIsFree: $depthIsFree, depthStderrKm: $depthStderrKm, maxIntensity: $maxIntensity, determinationFlagLabel: $determinationFlagLabel, evaluationLabel: $evaluationLabel, magnitudes: $magnitudes)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCatalogHypocenterCopyWith<$Res> implements $EarthquakeCatalogHypocenterCopyWith<$Res> {
  factory _$EarthquakeCatalogHypocenterCopyWith(_EarthquakeCatalogHypocenter value, $Res Function(_EarthquakeCatalogHypocenter) _then) = __$EarthquakeCatalogHypocenterCopyWithImpl;
@override @useResult
$Res call({
 int seq, String epicenterName, int stationCount, String recordTypeLabel, DateTime? originTime, double? originTimeStderrSeconds, double? latitude, double? longitude, double? depthKm, bool depthIsFree, double? depthStderrKm, ShindoDbIntensityClass? maxIntensity, String? determinationFlagLabel, String? evaluationLabel, List<EarthquakeCatalogMagnitude> magnitudes
});




}
/// @nodoc
class __$EarthquakeCatalogHypocenterCopyWithImpl<$Res>
    implements _$EarthquakeCatalogHypocenterCopyWith<$Res> {
  __$EarthquakeCatalogHypocenterCopyWithImpl(this._self, this._then);

  final _EarthquakeCatalogHypocenter _self;
  final $Res Function(_EarthquakeCatalogHypocenter) _then;

/// Create a copy of EarthquakeCatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? epicenterName = null,Object? stationCount = null,Object? recordTypeLabel = null,Object? originTime = freezed,Object? originTimeStderrSeconds = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? depthKm = freezed,Object? depthIsFree = null,Object? depthStderrKm = freezed,Object? maxIntensity = freezed,Object? determinationFlagLabel = freezed,Object? evaluationLabel = freezed,Object? magnitudes = null,}) {
  return _then(_EarthquakeCatalogHypocenter(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,epicenterName: null == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String,stationCount: null == stationCount ? _self.stationCount : stationCount // ignore: cast_nullable_to_non_nullable
as int,recordTypeLabel: null == recordTypeLabel ? _self.recordTypeLabel : recordTypeLabel // ignore: cast_nullable_to_non_nullable
as String,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimeStderrSeconds: freezed == originTimeStderrSeconds ? _self.originTimeStderrSeconds : originTimeStderrSeconds // ignore: cast_nullable_to_non_nullable
as double?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double?,depthIsFree: null == depthIsFree ? _self.depthIsFree : depthIsFree // ignore: cast_nullable_to_non_nullable
as bool,depthStderrKm: freezed == depthStderrKm ? _self.depthStderrKm : depthStderrKm // ignore: cast_nullable_to_non_nullable
as double?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as ShindoDbIntensityClass?,determinationFlagLabel: freezed == determinationFlagLabel ? _self.determinationFlagLabel : determinationFlagLabel // ignore: cast_nullable_to_non_nullable
as String?,evaluationLabel: freezed == evaluationLabel ? _self.evaluationLabel : evaluationLabel // ignore: cast_nullable_to_non_nullable
as String?,magnitudes: null == magnitudes ? _self._magnitudes : magnitudes // ignore: cast_nullable_to_non_nullable
as List<EarthquakeCatalogMagnitude>,
  ));
}


}

/// @nodoc
mixin _$EarthquakeCatalogMagnitude {

 String get typeLabel; double get value;
/// Create a copy of EarthquakeCatalogMagnitude
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCatalogMagnitudeCopyWith<EarthquakeCatalogMagnitude> get copyWith => _$EarthquakeCatalogMagnitudeCopyWithImpl<EarthquakeCatalogMagnitude>(this as EarthquakeCatalogMagnitude, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeCatalogMagnitude&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,typeLabel,value);

@override
String toString() {
  return 'EarthquakeCatalogMagnitude(typeLabel: $typeLabel, value: $value)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCatalogMagnitudeCopyWith<$Res>  {
  factory $EarthquakeCatalogMagnitudeCopyWith(EarthquakeCatalogMagnitude value, $Res Function(EarthquakeCatalogMagnitude) _then) = _$EarthquakeCatalogMagnitudeCopyWithImpl;
@useResult
$Res call({
 String typeLabel, double value
});




}
/// @nodoc
class _$EarthquakeCatalogMagnitudeCopyWithImpl<$Res>
    implements $EarthquakeCatalogMagnitudeCopyWith<$Res> {
  _$EarthquakeCatalogMagnitudeCopyWithImpl(this._self, this._then);

  final EarthquakeCatalogMagnitude _self;
  final $Res Function(EarthquakeCatalogMagnitude) _then;

/// Create a copy of EarthquakeCatalogMagnitude
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? typeLabel = null,Object? value = null,}) {
  return _then(_self.copyWith(
typeLabel: null == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeCatalogMagnitude].
extension EarthquakeCatalogMagnitudePatterns on EarthquakeCatalogMagnitude {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeCatalogMagnitude value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeCatalogMagnitude() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeCatalogMagnitude value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogMagnitude():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeCatalogMagnitude value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogMagnitude() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String typeLabel,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeCatalogMagnitude() when $default != null:
return $default(_that.typeLabel,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String typeLabel,  double value)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogMagnitude():
return $default(_that.typeLabel,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String typeLabel,  double value)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogMagnitude() when $default != null:
return $default(_that.typeLabel,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeCatalogMagnitude implements EarthquakeCatalogMagnitude {
  const _EarthquakeCatalogMagnitude({required this.typeLabel, required this.value});
  

@override final  String typeLabel;
@override final  double value;

/// Create a copy of EarthquakeCatalogMagnitude
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCatalogMagnitudeCopyWith<_EarthquakeCatalogMagnitude> get copyWith => __$EarthquakeCatalogMagnitudeCopyWithImpl<_EarthquakeCatalogMagnitude>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeCatalogMagnitude&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,typeLabel,value);

@override
String toString() {
  return 'EarthquakeCatalogMagnitude(typeLabel: $typeLabel, value: $value)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCatalogMagnitudeCopyWith<$Res> implements $EarthquakeCatalogMagnitudeCopyWith<$Res> {
  factory _$EarthquakeCatalogMagnitudeCopyWith(_EarthquakeCatalogMagnitude value, $Res Function(_EarthquakeCatalogMagnitude) _then) = __$EarthquakeCatalogMagnitudeCopyWithImpl;
@override @useResult
$Res call({
 String typeLabel, double value
});




}
/// @nodoc
class __$EarthquakeCatalogMagnitudeCopyWithImpl<$Res>
    implements _$EarthquakeCatalogMagnitudeCopyWith<$Res> {
  __$EarthquakeCatalogMagnitudeCopyWithImpl(this._self, this._then);

  final _EarthquakeCatalogMagnitude _self;
  final $Res Function(_EarthquakeCatalogMagnitude) _then;

/// Create a copy of EarthquakeCatalogMagnitude
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? typeLabel = null,Object? value = null,}) {
  return _then(_EarthquakeCatalogMagnitude(
typeLabel: null == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$EarthquakeCatalogStationRecord {

 String get stationCode; ShindoDbIntensityClass get intensityClass; double? get instrumentalIntensity; DateTime? get observedAt; EarthquakeCatalogMaxAcceleration? get maxAcceleration; DateTime? get maxAccelTime; EarthquakeCatalogPeriods? get periods; int? get observationCount;
/// Create a copy of EarthquakeCatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCatalogStationRecordCopyWith<EarthquakeCatalogStationRecord> get copyWith => _$EarthquakeCatalogStationRecordCopyWithImpl<EarthquakeCatalogStationRecord>(this as EarthquakeCatalogStationRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeCatalogStationRecord&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.intensityClass, intensityClass) || other.intensityClass == intensityClass)&&(identical(other.instrumentalIntensity, instrumentalIntensity) || other.instrumentalIntensity == instrumentalIntensity)&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.maxAcceleration, maxAcceleration) || other.maxAcceleration == maxAcceleration)&&(identical(other.maxAccelTime, maxAccelTime) || other.maxAccelTime == maxAccelTime)&&(identical(other.periods, periods) || other.periods == periods)&&(identical(other.observationCount, observationCount) || other.observationCount == observationCount));
}


@override
int get hashCode => Object.hash(runtimeType,stationCode,intensityClass,instrumentalIntensity,observedAt,maxAcceleration,maxAccelTime,periods,observationCount);

@override
String toString() {
  return 'EarthquakeCatalogStationRecord(stationCode: $stationCode, intensityClass: $intensityClass, instrumentalIntensity: $instrumentalIntensity, observedAt: $observedAt, maxAcceleration: $maxAcceleration, maxAccelTime: $maxAccelTime, periods: $periods, observationCount: $observationCount)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCatalogStationRecordCopyWith<$Res>  {
  factory $EarthquakeCatalogStationRecordCopyWith(EarthquakeCatalogStationRecord value, $Res Function(EarthquakeCatalogStationRecord) _then) = _$EarthquakeCatalogStationRecordCopyWithImpl;
@useResult
$Res call({
 String stationCode, ShindoDbIntensityClass intensityClass, double? instrumentalIntensity, DateTime? observedAt, EarthquakeCatalogMaxAcceleration? maxAcceleration, DateTime? maxAccelTime, EarthquakeCatalogPeriods? periods, int? observationCount
});


$EarthquakeCatalogMaxAccelerationCopyWith<$Res>? get maxAcceleration;$EarthquakeCatalogPeriodsCopyWith<$Res>? get periods;

}
/// @nodoc
class _$EarthquakeCatalogStationRecordCopyWithImpl<$Res>
    implements $EarthquakeCatalogStationRecordCopyWith<$Res> {
  _$EarthquakeCatalogStationRecordCopyWithImpl(this._self, this._then);

  final EarthquakeCatalogStationRecord _self;
  final $Res Function(EarthquakeCatalogStationRecord) _then;

/// Create a copy of EarthquakeCatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stationCode = null,Object? intensityClass = null,Object? instrumentalIntensity = freezed,Object? observedAt = freezed,Object? maxAcceleration = freezed,Object? maxAccelTime = freezed,Object? periods = freezed,Object? observationCount = freezed,}) {
  return _then(_self.copyWith(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,intensityClass: null == intensityClass ? _self.intensityClass : intensityClass // ignore: cast_nullable_to_non_nullable
as ShindoDbIntensityClass,instrumentalIntensity: freezed == instrumentalIntensity ? _self.instrumentalIntensity : instrumentalIntensity // ignore: cast_nullable_to_non_nullable
as double?,observedAt: freezed == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxAcceleration: freezed == maxAcceleration ? _self.maxAcceleration : maxAcceleration // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogMaxAcceleration?,maxAccelTime: freezed == maxAccelTime ? _self.maxAccelTime : maxAccelTime // ignore: cast_nullable_to_non_nullable
as DateTime?,periods: freezed == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogPeriods?,observationCount: freezed == observationCount ? _self.observationCount : observationCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of EarthquakeCatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogMaxAccelerationCopyWith<$Res>? get maxAcceleration {
    if (_self.maxAcceleration == null) {
    return null;
  }

  return $EarthquakeCatalogMaxAccelerationCopyWith<$Res>(_self.maxAcceleration!, (value) {
    return _then(_self.copyWith(maxAcceleration: value));
  });
}/// Create a copy of EarthquakeCatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogPeriodsCopyWith<$Res>? get periods {
    if (_self.periods == null) {
    return null;
  }

  return $EarthquakeCatalogPeriodsCopyWith<$Res>(_self.periods!, (value) {
    return _then(_self.copyWith(periods: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeCatalogStationRecord].
extension EarthquakeCatalogStationRecordPatterns on EarthquakeCatalogStationRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeCatalogStationRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeCatalogStationRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeCatalogStationRecord value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogStationRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeCatalogStationRecord value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogStationRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stationCode,  ShindoDbIntensityClass intensityClass,  double? instrumentalIntensity,  DateTime? observedAt,  EarthquakeCatalogMaxAcceleration? maxAcceleration,  DateTime? maxAccelTime,  EarthquakeCatalogPeriods? periods,  int? observationCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeCatalogStationRecord() when $default != null:
return $default(_that.stationCode,_that.intensityClass,_that.instrumentalIntensity,_that.observedAt,_that.maxAcceleration,_that.maxAccelTime,_that.periods,_that.observationCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stationCode,  ShindoDbIntensityClass intensityClass,  double? instrumentalIntensity,  DateTime? observedAt,  EarthquakeCatalogMaxAcceleration? maxAcceleration,  DateTime? maxAccelTime,  EarthquakeCatalogPeriods? periods,  int? observationCount)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogStationRecord():
return $default(_that.stationCode,_that.intensityClass,_that.instrumentalIntensity,_that.observedAt,_that.maxAcceleration,_that.maxAccelTime,_that.periods,_that.observationCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stationCode,  ShindoDbIntensityClass intensityClass,  double? instrumentalIntensity,  DateTime? observedAt,  EarthquakeCatalogMaxAcceleration? maxAcceleration,  DateTime? maxAccelTime,  EarthquakeCatalogPeriods? periods,  int? observationCount)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogStationRecord() when $default != null:
return $default(_that.stationCode,_that.intensityClass,_that.instrumentalIntensity,_that.observedAt,_that.maxAcceleration,_that.maxAccelTime,_that.periods,_that.observationCount);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeCatalogStationRecord implements EarthquakeCatalogStationRecord {
  const _EarthquakeCatalogStationRecord({required this.stationCode, required this.intensityClass, required this.instrumentalIntensity, required this.observedAt, required this.maxAcceleration, required this.maxAccelTime, required this.periods, required this.observationCount});
  

@override final  String stationCode;
@override final  ShindoDbIntensityClass intensityClass;
@override final  double? instrumentalIntensity;
@override final  DateTime? observedAt;
@override final  EarthquakeCatalogMaxAcceleration? maxAcceleration;
@override final  DateTime? maxAccelTime;
@override final  EarthquakeCatalogPeriods? periods;
@override final  int? observationCount;

/// Create a copy of EarthquakeCatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCatalogStationRecordCopyWith<_EarthquakeCatalogStationRecord> get copyWith => __$EarthquakeCatalogStationRecordCopyWithImpl<_EarthquakeCatalogStationRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeCatalogStationRecord&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.intensityClass, intensityClass) || other.intensityClass == intensityClass)&&(identical(other.instrumentalIntensity, instrumentalIntensity) || other.instrumentalIntensity == instrumentalIntensity)&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.maxAcceleration, maxAcceleration) || other.maxAcceleration == maxAcceleration)&&(identical(other.maxAccelTime, maxAccelTime) || other.maxAccelTime == maxAccelTime)&&(identical(other.periods, periods) || other.periods == periods)&&(identical(other.observationCount, observationCount) || other.observationCount == observationCount));
}


@override
int get hashCode => Object.hash(runtimeType,stationCode,intensityClass,instrumentalIntensity,observedAt,maxAcceleration,maxAccelTime,periods,observationCount);

@override
String toString() {
  return 'EarthquakeCatalogStationRecord(stationCode: $stationCode, intensityClass: $intensityClass, instrumentalIntensity: $instrumentalIntensity, observedAt: $observedAt, maxAcceleration: $maxAcceleration, maxAccelTime: $maxAccelTime, periods: $periods, observationCount: $observationCount)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCatalogStationRecordCopyWith<$Res> implements $EarthquakeCatalogStationRecordCopyWith<$Res> {
  factory _$EarthquakeCatalogStationRecordCopyWith(_EarthquakeCatalogStationRecord value, $Res Function(_EarthquakeCatalogStationRecord) _then) = __$EarthquakeCatalogStationRecordCopyWithImpl;
@override @useResult
$Res call({
 String stationCode, ShindoDbIntensityClass intensityClass, double? instrumentalIntensity, DateTime? observedAt, EarthquakeCatalogMaxAcceleration? maxAcceleration, DateTime? maxAccelTime, EarthquakeCatalogPeriods? periods, int? observationCount
});


@override $EarthquakeCatalogMaxAccelerationCopyWith<$Res>? get maxAcceleration;@override $EarthquakeCatalogPeriodsCopyWith<$Res>? get periods;

}
/// @nodoc
class __$EarthquakeCatalogStationRecordCopyWithImpl<$Res>
    implements _$EarthquakeCatalogStationRecordCopyWith<$Res> {
  __$EarthquakeCatalogStationRecordCopyWithImpl(this._self, this._then);

  final _EarthquakeCatalogStationRecord _self;
  final $Res Function(_EarthquakeCatalogStationRecord) _then;

/// Create a copy of EarthquakeCatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stationCode = null,Object? intensityClass = null,Object? instrumentalIntensity = freezed,Object? observedAt = freezed,Object? maxAcceleration = freezed,Object? maxAccelTime = freezed,Object? periods = freezed,Object? observationCount = freezed,}) {
  return _then(_EarthquakeCatalogStationRecord(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,intensityClass: null == intensityClass ? _self.intensityClass : intensityClass // ignore: cast_nullable_to_non_nullable
as ShindoDbIntensityClass,instrumentalIntensity: freezed == instrumentalIntensity ? _self.instrumentalIntensity : instrumentalIntensity // ignore: cast_nullable_to_non_nullable
as double?,observedAt: freezed == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxAcceleration: freezed == maxAcceleration ? _self.maxAcceleration : maxAcceleration // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogMaxAcceleration?,maxAccelTime: freezed == maxAccelTime ? _self.maxAccelTime : maxAccelTime // ignore: cast_nullable_to_non_nullable
as DateTime?,periods: freezed == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogPeriods?,observationCount: freezed == observationCount ? _self.observationCount : observationCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of EarthquakeCatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogMaxAccelerationCopyWith<$Res>? get maxAcceleration {
    if (_self.maxAcceleration == null) {
    return null;
  }

  return $EarthquakeCatalogMaxAccelerationCopyWith<$Res>(_self.maxAcceleration!, (value) {
    return _then(_self.copyWith(maxAcceleration: value));
  });
}/// Create a copy of EarthquakeCatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogPeriodsCopyWith<$Res>? get periods {
    if (_self.periods == null) {
    return null;
  }

  return $EarthquakeCatalogPeriodsCopyWith<$Res>(_self.periods!, (value) {
    return _then(_self.copyWith(periods: value));
  });
}
}

/// @nodoc
mixin _$EarthquakeCatalogMaxAcceleration {

 double? get synthesizedGal; double? get nsGal; double? get ewGal; double? get udGal;
/// Create a copy of EarthquakeCatalogMaxAcceleration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCatalogMaxAccelerationCopyWith<EarthquakeCatalogMaxAcceleration> get copyWith => _$EarthquakeCatalogMaxAccelerationCopyWithImpl<EarthquakeCatalogMaxAcceleration>(this as EarthquakeCatalogMaxAcceleration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeCatalogMaxAcceleration&&(identical(other.synthesizedGal, synthesizedGal) || other.synthesizedGal == synthesizedGal)&&(identical(other.nsGal, nsGal) || other.nsGal == nsGal)&&(identical(other.ewGal, ewGal) || other.ewGal == ewGal)&&(identical(other.udGal, udGal) || other.udGal == udGal));
}


@override
int get hashCode => Object.hash(runtimeType,synthesizedGal,nsGal,ewGal,udGal);

@override
String toString() {
  return 'EarthquakeCatalogMaxAcceleration(synthesizedGal: $synthesizedGal, nsGal: $nsGal, ewGal: $ewGal, udGal: $udGal)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCatalogMaxAccelerationCopyWith<$Res>  {
  factory $EarthquakeCatalogMaxAccelerationCopyWith(EarthquakeCatalogMaxAcceleration value, $Res Function(EarthquakeCatalogMaxAcceleration) _then) = _$EarthquakeCatalogMaxAccelerationCopyWithImpl;
@useResult
$Res call({
 double? synthesizedGal, double? nsGal, double? ewGal, double? udGal
});




}
/// @nodoc
class _$EarthquakeCatalogMaxAccelerationCopyWithImpl<$Res>
    implements $EarthquakeCatalogMaxAccelerationCopyWith<$Res> {
  _$EarthquakeCatalogMaxAccelerationCopyWithImpl(this._self, this._then);

  final EarthquakeCatalogMaxAcceleration _self;
  final $Res Function(EarthquakeCatalogMaxAcceleration) _then;

/// Create a copy of EarthquakeCatalogMaxAcceleration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? synthesizedGal = freezed,Object? nsGal = freezed,Object? ewGal = freezed,Object? udGal = freezed,}) {
  return _then(_self.copyWith(
synthesizedGal: freezed == synthesizedGal ? _self.synthesizedGal : synthesizedGal // ignore: cast_nullable_to_non_nullable
as double?,nsGal: freezed == nsGal ? _self.nsGal : nsGal // ignore: cast_nullable_to_non_nullable
as double?,ewGal: freezed == ewGal ? _self.ewGal : ewGal // ignore: cast_nullable_to_non_nullable
as double?,udGal: freezed == udGal ? _self.udGal : udGal // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeCatalogMaxAcceleration].
extension EarthquakeCatalogMaxAccelerationPatterns on EarthquakeCatalogMaxAcceleration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeCatalogMaxAcceleration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeCatalogMaxAcceleration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeCatalogMaxAcceleration value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogMaxAcceleration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeCatalogMaxAcceleration value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogMaxAcceleration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? synthesizedGal,  double? nsGal,  double? ewGal,  double? udGal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeCatalogMaxAcceleration() when $default != null:
return $default(_that.synthesizedGal,_that.nsGal,_that.ewGal,_that.udGal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? synthesizedGal,  double? nsGal,  double? ewGal,  double? udGal)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogMaxAcceleration():
return $default(_that.synthesizedGal,_that.nsGal,_that.ewGal,_that.udGal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? synthesizedGal,  double? nsGal,  double? ewGal,  double? udGal)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogMaxAcceleration() when $default != null:
return $default(_that.synthesizedGal,_that.nsGal,_that.ewGal,_that.udGal);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeCatalogMaxAcceleration implements EarthquakeCatalogMaxAcceleration {
  const _EarthquakeCatalogMaxAcceleration({required this.synthesizedGal, required this.nsGal, required this.ewGal, required this.udGal});
  

@override final  double? synthesizedGal;
@override final  double? nsGal;
@override final  double? ewGal;
@override final  double? udGal;

/// Create a copy of EarthquakeCatalogMaxAcceleration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCatalogMaxAccelerationCopyWith<_EarthquakeCatalogMaxAcceleration> get copyWith => __$EarthquakeCatalogMaxAccelerationCopyWithImpl<_EarthquakeCatalogMaxAcceleration>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeCatalogMaxAcceleration&&(identical(other.synthesizedGal, synthesizedGal) || other.synthesizedGal == synthesizedGal)&&(identical(other.nsGal, nsGal) || other.nsGal == nsGal)&&(identical(other.ewGal, ewGal) || other.ewGal == ewGal)&&(identical(other.udGal, udGal) || other.udGal == udGal));
}


@override
int get hashCode => Object.hash(runtimeType,synthesizedGal,nsGal,ewGal,udGal);

@override
String toString() {
  return 'EarthquakeCatalogMaxAcceleration(synthesizedGal: $synthesizedGal, nsGal: $nsGal, ewGal: $ewGal, udGal: $udGal)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCatalogMaxAccelerationCopyWith<$Res> implements $EarthquakeCatalogMaxAccelerationCopyWith<$Res> {
  factory _$EarthquakeCatalogMaxAccelerationCopyWith(_EarthquakeCatalogMaxAcceleration value, $Res Function(_EarthquakeCatalogMaxAcceleration) _then) = __$EarthquakeCatalogMaxAccelerationCopyWithImpl;
@override @useResult
$Res call({
 double? synthesizedGal, double? nsGal, double? ewGal, double? udGal
});




}
/// @nodoc
class __$EarthquakeCatalogMaxAccelerationCopyWithImpl<$Res>
    implements _$EarthquakeCatalogMaxAccelerationCopyWith<$Res> {
  __$EarthquakeCatalogMaxAccelerationCopyWithImpl(this._self, this._then);

  final _EarthquakeCatalogMaxAcceleration _self;
  final $Res Function(_EarthquakeCatalogMaxAcceleration) _then;

/// Create a copy of EarthquakeCatalogMaxAcceleration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? synthesizedGal = freezed,Object? nsGal = freezed,Object? ewGal = freezed,Object? udGal = freezed,}) {
  return _then(_EarthquakeCatalogMaxAcceleration(
synthesizedGal: freezed == synthesizedGal ? _self.synthesizedGal : synthesizedGal // ignore: cast_nullable_to_non_nullable
as double?,nsGal: freezed == nsGal ? _self.nsGal : nsGal // ignore: cast_nullable_to_non_nullable
as double?,ewGal: freezed == ewGal ? _self.ewGal : ewGal // ignore: cast_nullable_to_non_nullable
as double?,udGal: freezed == udGal ? _self.udGal : udGal // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$EarthquakeCatalogPeriods {

 EarthquakeCatalogPeriodComponent? get ns; EarthquakeCatalogPeriodComponent? get ew; EarthquakeCatalogPeriodComponent? get ud;
/// Create a copy of EarthquakeCatalogPeriods
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCatalogPeriodsCopyWith<EarthquakeCatalogPeriods> get copyWith => _$EarthquakeCatalogPeriodsCopyWithImpl<EarthquakeCatalogPeriods>(this as EarthquakeCatalogPeriods, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeCatalogPeriods&&(identical(other.ns, ns) || other.ns == ns)&&(identical(other.ew, ew) || other.ew == ew)&&(identical(other.ud, ud) || other.ud == ud));
}


@override
int get hashCode => Object.hash(runtimeType,ns,ew,ud);

@override
String toString() {
  return 'EarthquakeCatalogPeriods(ns: $ns, ew: $ew, ud: $ud)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCatalogPeriodsCopyWith<$Res>  {
  factory $EarthquakeCatalogPeriodsCopyWith(EarthquakeCatalogPeriods value, $Res Function(EarthquakeCatalogPeriods) _then) = _$EarthquakeCatalogPeriodsCopyWithImpl;
@useResult
$Res call({
 EarthquakeCatalogPeriodComponent? ns, EarthquakeCatalogPeriodComponent? ew, EarthquakeCatalogPeriodComponent? ud
});


$EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ns;$EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ew;$EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ud;

}
/// @nodoc
class _$EarthquakeCatalogPeriodsCopyWithImpl<$Res>
    implements $EarthquakeCatalogPeriodsCopyWith<$Res> {
  _$EarthquakeCatalogPeriodsCopyWithImpl(this._self, this._then);

  final EarthquakeCatalogPeriods _self;
  final $Res Function(EarthquakeCatalogPeriods) _then;

/// Create a copy of EarthquakeCatalogPeriods
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ns = freezed,Object? ew = freezed,Object? ud = freezed,}) {
  return _then(_self.copyWith(
ns: freezed == ns ? _self.ns : ns // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogPeriodComponent?,ew: freezed == ew ? _self.ew : ew // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogPeriodComponent?,ud: freezed == ud ? _self.ud : ud // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogPeriodComponent?,
  ));
}
/// Create a copy of EarthquakeCatalogPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ns {
    if (_self.ns == null) {
    return null;
  }

  return $EarthquakeCatalogPeriodComponentCopyWith<$Res>(_self.ns!, (value) {
    return _then(_self.copyWith(ns: value));
  });
}/// Create a copy of EarthquakeCatalogPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ew {
    if (_self.ew == null) {
    return null;
  }

  return $EarthquakeCatalogPeriodComponentCopyWith<$Res>(_self.ew!, (value) {
    return _then(_self.copyWith(ew: value));
  });
}/// Create a copy of EarthquakeCatalogPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ud {
    if (_self.ud == null) {
    return null;
  }

  return $EarthquakeCatalogPeriodComponentCopyWith<$Res>(_self.ud!, (value) {
    return _then(_self.copyWith(ud: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeCatalogPeriods].
extension EarthquakeCatalogPeriodsPatterns on EarthquakeCatalogPeriods {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeCatalogPeriods value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriods() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeCatalogPeriods value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriods():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeCatalogPeriods value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriods() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeCatalogPeriodComponent? ns,  EarthquakeCatalogPeriodComponent? ew,  EarthquakeCatalogPeriodComponent? ud)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriods() when $default != null:
return $default(_that.ns,_that.ew,_that.ud);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeCatalogPeriodComponent? ns,  EarthquakeCatalogPeriodComponent? ew,  EarthquakeCatalogPeriodComponent? ud)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriods():
return $default(_that.ns,_that.ew,_that.ud);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeCatalogPeriodComponent? ns,  EarthquakeCatalogPeriodComponent? ew,  EarthquakeCatalogPeriodComponent? ud)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriods() when $default != null:
return $default(_that.ns,_that.ew,_that.ud);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeCatalogPeriods implements EarthquakeCatalogPeriods {
  const _EarthquakeCatalogPeriods({required this.ns, required this.ew, required this.ud});
  

@override final  EarthquakeCatalogPeriodComponent? ns;
@override final  EarthquakeCatalogPeriodComponent? ew;
@override final  EarthquakeCatalogPeriodComponent? ud;

/// Create a copy of EarthquakeCatalogPeriods
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCatalogPeriodsCopyWith<_EarthquakeCatalogPeriods> get copyWith => __$EarthquakeCatalogPeriodsCopyWithImpl<_EarthquakeCatalogPeriods>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeCatalogPeriods&&(identical(other.ns, ns) || other.ns == ns)&&(identical(other.ew, ew) || other.ew == ew)&&(identical(other.ud, ud) || other.ud == ud));
}


@override
int get hashCode => Object.hash(runtimeType,ns,ew,ud);

@override
String toString() {
  return 'EarthquakeCatalogPeriods(ns: $ns, ew: $ew, ud: $ud)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCatalogPeriodsCopyWith<$Res> implements $EarthquakeCatalogPeriodsCopyWith<$Res> {
  factory _$EarthquakeCatalogPeriodsCopyWith(_EarthquakeCatalogPeriods value, $Res Function(_EarthquakeCatalogPeriods) _then) = __$EarthquakeCatalogPeriodsCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeCatalogPeriodComponent? ns, EarthquakeCatalogPeriodComponent? ew, EarthquakeCatalogPeriodComponent? ud
});


@override $EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ns;@override $EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ew;@override $EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ud;

}
/// @nodoc
class __$EarthquakeCatalogPeriodsCopyWithImpl<$Res>
    implements _$EarthquakeCatalogPeriodsCopyWith<$Res> {
  __$EarthquakeCatalogPeriodsCopyWithImpl(this._self, this._then);

  final _EarthquakeCatalogPeriods _self;
  final $Res Function(_EarthquakeCatalogPeriods) _then;

/// Create a copy of EarthquakeCatalogPeriods
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ns = freezed,Object? ew = freezed,Object? ud = freezed,}) {
  return _then(_EarthquakeCatalogPeriods(
ns: freezed == ns ? _self.ns : ns // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogPeriodComponent?,ew: freezed == ew ? _self.ew : ew // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogPeriodComponent?,ud: freezed == ud ? _self.ud : ud // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogPeriodComponent?,
  ));
}

/// Create a copy of EarthquakeCatalogPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ns {
    if (_self.ns == null) {
    return null;
  }

  return $EarthquakeCatalogPeriodComponentCopyWith<$Res>(_self.ns!, (value) {
    return _then(_self.copyWith(ns: value));
  });
}/// Create a copy of EarthquakeCatalogPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ew {
    if (_self.ew == null) {
    return null;
  }

  return $EarthquakeCatalogPeriodComponentCopyWith<$Res>(_self.ew!, (value) {
    return _then(_self.copyWith(ew: value));
  });
}/// Create a copy of EarthquakeCatalogPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogPeriodComponentCopyWith<$Res>? get ud {
    if (_self.ud == null) {
    return null;
  }

  return $EarthquakeCatalogPeriodComponentCopyWith<$Res>(_self.ud!, (value) {
    return _then(_self.copyWith(ud: value));
  });
}
}

/// @nodoc
mixin _$EarthquakeCatalogPeriodComponent {

 String? get maxAccelPeriodText; String? get predominantPeriodText;
/// Create a copy of EarthquakeCatalogPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCatalogPeriodComponentCopyWith<EarthquakeCatalogPeriodComponent> get copyWith => _$EarthquakeCatalogPeriodComponentCopyWithImpl<EarthquakeCatalogPeriodComponent>(this as EarthquakeCatalogPeriodComponent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeCatalogPeriodComponent&&(identical(other.maxAccelPeriodText, maxAccelPeriodText) || other.maxAccelPeriodText == maxAccelPeriodText)&&(identical(other.predominantPeriodText, predominantPeriodText) || other.predominantPeriodText == predominantPeriodText));
}


@override
int get hashCode => Object.hash(runtimeType,maxAccelPeriodText,predominantPeriodText);

@override
String toString() {
  return 'EarthquakeCatalogPeriodComponent(maxAccelPeriodText: $maxAccelPeriodText, predominantPeriodText: $predominantPeriodText)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCatalogPeriodComponentCopyWith<$Res>  {
  factory $EarthquakeCatalogPeriodComponentCopyWith(EarthquakeCatalogPeriodComponent value, $Res Function(EarthquakeCatalogPeriodComponent) _then) = _$EarthquakeCatalogPeriodComponentCopyWithImpl;
@useResult
$Res call({
 String? maxAccelPeriodText, String? predominantPeriodText
});




}
/// @nodoc
class _$EarthquakeCatalogPeriodComponentCopyWithImpl<$Res>
    implements $EarthquakeCatalogPeriodComponentCopyWith<$Res> {
  _$EarthquakeCatalogPeriodComponentCopyWithImpl(this._self, this._then);

  final EarthquakeCatalogPeriodComponent _self;
  final $Res Function(EarthquakeCatalogPeriodComponent) _then;

/// Create a copy of EarthquakeCatalogPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxAccelPeriodText = freezed,Object? predominantPeriodText = freezed,}) {
  return _then(_self.copyWith(
maxAccelPeriodText: freezed == maxAccelPeriodText ? _self.maxAccelPeriodText : maxAccelPeriodText // ignore: cast_nullable_to_non_nullable
as String?,predominantPeriodText: freezed == predominantPeriodText ? _self.predominantPeriodText : predominantPeriodText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeCatalogPeriodComponent].
extension EarthquakeCatalogPeriodComponentPatterns on EarthquakeCatalogPeriodComponent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeCatalogPeriodComponent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriodComponent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeCatalogPeriodComponent value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriodComponent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeCatalogPeriodComponent value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriodComponent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? maxAccelPeriodText,  String? predominantPeriodText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriodComponent() when $default != null:
return $default(_that.maxAccelPeriodText,_that.predominantPeriodText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? maxAccelPeriodText,  String? predominantPeriodText)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriodComponent():
return $default(_that.maxAccelPeriodText,_that.predominantPeriodText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? maxAccelPeriodText,  String? predominantPeriodText)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeCatalogPeriodComponent() when $default != null:
return $default(_that.maxAccelPeriodText,_that.predominantPeriodText);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeCatalogPeriodComponent implements EarthquakeCatalogPeriodComponent {
  const _EarthquakeCatalogPeriodComponent({required this.maxAccelPeriodText, required this.predominantPeriodText});
  

@override final  String? maxAccelPeriodText;
@override final  String? predominantPeriodText;

/// Create a copy of EarthquakeCatalogPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCatalogPeriodComponentCopyWith<_EarthquakeCatalogPeriodComponent> get copyWith => __$EarthquakeCatalogPeriodComponentCopyWithImpl<_EarthquakeCatalogPeriodComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeCatalogPeriodComponent&&(identical(other.maxAccelPeriodText, maxAccelPeriodText) || other.maxAccelPeriodText == maxAccelPeriodText)&&(identical(other.predominantPeriodText, predominantPeriodText) || other.predominantPeriodText == predominantPeriodText));
}


@override
int get hashCode => Object.hash(runtimeType,maxAccelPeriodText,predominantPeriodText);

@override
String toString() {
  return 'EarthquakeCatalogPeriodComponent(maxAccelPeriodText: $maxAccelPeriodText, predominantPeriodText: $predominantPeriodText)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCatalogPeriodComponentCopyWith<$Res> implements $EarthquakeCatalogPeriodComponentCopyWith<$Res> {
  factory _$EarthquakeCatalogPeriodComponentCopyWith(_EarthquakeCatalogPeriodComponent value, $Res Function(_EarthquakeCatalogPeriodComponent) _then) = __$EarthquakeCatalogPeriodComponentCopyWithImpl;
@override @useResult
$Res call({
 String? maxAccelPeriodText, String? predominantPeriodText
});




}
/// @nodoc
class __$EarthquakeCatalogPeriodComponentCopyWithImpl<$Res>
    implements _$EarthquakeCatalogPeriodComponentCopyWith<$Res> {
  __$EarthquakeCatalogPeriodComponentCopyWithImpl(this._self, this._then);

  final _EarthquakeCatalogPeriodComponent _self;
  final $Res Function(_EarthquakeCatalogPeriodComponent) _then;

/// Create a copy of EarthquakeCatalogPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxAccelPeriodText = freezed,Object? predominantPeriodText = freezed,}) {
  return _then(_EarthquakeCatalogPeriodComponent(
maxAccelPeriodText: freezed == maxAccelPeriodText ? _self.maxAccelPeriodText : maxAccelPeriodText // ignore: cast_nullable_to_non_nullable
as String?,predominantPeriodText: freezed == predominantPeriodText ? _self.predominantPeriodText : predominantPeriodText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
