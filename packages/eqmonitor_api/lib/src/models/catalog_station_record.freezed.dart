// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_station_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogStationRecord {

@JsonKey(name: 'station_code') String get stationCode;@JsonKey(includeIfNull: true, name: 'intensity_raw') String? get intensityRaw;@JsonKey(includeIfNull: true, name: 'instrumental_intensity') num? get instrumentalIntensity;@JsonKey(includeIfNull: true, name: 'max_accel_synthesized_gal') num? get maxAccelSynthesizedGal;@JsonKey(includeIfNull: true, name: 'max_accel_ns_gal') num? get maxAccelNsGal;@JsonKey(includeIfNull: true, name: 'max_accel_ew_gal') num? get maxAccelEwGal;@JsonKey(includeIfNull: true, name: 'max_accel_ud_gal') num? get maxAccelUdGal;@JsonKey(includeIfNull: true, name: 'max_accel_period_ns') num? get maxAccelPeriodNs;@JsonKey(includeIfNull: true, name: 'predominant_period_ns') num? get predominantPeriodNs;@JsonKey(includeIfNull: true, name: 'max_accel_period_ew') num? get maxAccelPeriodEw;@JsonKey(includeIfNull: true, name: 'predominant_period_ew') num? get predominantPeriodEw;@JsonKey(includeIfNull: true, name: 'max_accel_period_ud') num? get maxAccelPeriodUd;@JsonKey(includeIfNull: true, name: 'predominant_period_ud') num? get predominantPeriodUd;@JsonKey(includeIfNull: false, name: 'occurrence_time') DateTime? get occurrenceTime;
/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogStationRecordCopyWith<CatalogStationRecord> get copyWith => _$CatalogStationRecordCopyWithImpl<CatalogStationRecord>(this as CatalogStationRecord, _$identity);

  /// Serializes this CatalogStationRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogStationRecord&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.intensityRaw, intensityRaw) || other.intensityRaw == intensityRaw)&&(identical(other.instrumentalIntensity, instrumentalIntensity) || other.instrumentalIntensity == instrumentalIntensity)&&(identical(other.maxAccelSynthesizedGal, maxAccelSynthesizedGal) || other.maxAccelSynthesizedGal == maxAccelSynthesizedGal)&&(identical(other.maxAccelNsGal, maxAccelNsGal) || other.maxAccelNsGal == maxAccelNsGal)&&(identical(other.maxAccelEwGal, maxAccelEwGal) || other.maxAccelEwGal == maxAccelEwGal)&&(identical(other.maxAccelUdGal, maxAccelUdGal) || other.maxAccelUdGal == maxAccelUdGal)&&(identical(other.maxAccelPeriodNs, maxAccelPeriodNs) || other.maxAccelPeriodNs == maxAccelPeriodNs)&&(identical(other.predominantPeriodNs, predominantPeriodNs) || other.predominantPeriodNs == predominantPeriodNs)&&(identical(other.maxAccelPeriodEw, maxAccelPeriodEw) || other.maxAccelPeriodEw == maxAccelPeriodEw)&&(identical(other.predominantPeriodEw, predominantPeriodEw) || other.predominantPeriodEw == predominantPeriodEw)&&(identical(other.maxAccelPeriodUd, maxAccelPeriodUd) || other.maxAccelPeriodUd == maxAccelPeriodUd)&&(identical(other.predominantPeriodUd, predominantPeriodUd) || other.predominantPeriodUd == predominantPeriodUd)&&(identical(other.occurrenceTime, occurrenceTime) || other.occurrenceTime == occurrenceTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationCode,intensityRaw,instrumentalIntensity,maxAccelSynthesizedGal,maxAccelNsGal,maxAccelEwGal,maxAccelUdGal,maxAccelPeriodNs,predominantPeriodNs,maxAccelPeriodEw,predominantPeriodEw,maxAccelPeriodUd,predominantPeriodUd,occurrenceTime);

@override
String toString() {
  return 'CatalogStationRecord(stationCode: $stationCode, intensityRaw: $intensityRaw, instrumentalIntensity: $instrumentalIntensity, maxAccelSynthesizedGal: $maxAccelSynthesizedGal, maxAccelNsGal: $maxAccelNsGal, maxAccelEwGal: $maxAccelEwGal, maxAccelUdGal: $maxAccelUdGal, maxAccelPeriodNs: $maxAccelPeriodNs, predominantPeriodNs: $predominantPeriodNs, maxAccelPeriodEw: $maxAccelPeriodEw, predominantPeriodEw: $predominantPeriodEw, maxAccelPeriodUd: $maxAccelPeriodUd, predominantPeriodUd: $predominantPeriodUd, occurrenceTime: $occurrenceTime)';
}


}

/// @nodoc
abstract mixin class $CatalogStationRecordCopyWith<$Res>  {
  factory $CatalogStationRecordCopyWith(CatalogStationRecord value, $Res Function(CatalogStationRecord) _then) = _$CatalogStationRecordCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'station_code') String stationCode,@JsonKey(includeIfNull: true, name: 'intensity_raw') String? intensityRaw,@JsonKey(includeIfNull: true, name: 'instrumental_intensity') num? instrumentalIntensity,@JsonKey(includeIfNull: true, name: 'max_accel_synthesized_gal') num? maxAccelSynthesizedGal,@JsonKey(includeIfNull: true, name: 'max_accel_ns_gal') num? maxAccelNsGal,@JsonKey(includeIfNull: true, name: 'max_accel_ew_gal') num? maxAccelEwGal,@JsonKey(includeIfNull: true, name: 'max_accel_ud_gal') num? maxAccelUdGal,@JsonKey(includeIfNull: true, name: 'max_accel_period_ns') num? maxAccelPeriodNs,@JsonKey(includeIfNull: true, name: 'predominant_period_ns') num? predominantPeriodNs,@JsonKey(includeIfNull: true, name: 'max_accel_period_ew') num? maxAccelPeriodEw,@JsonKey(includeIfNull: true, name: 'predominant_period_ew') num? predominantPeriodEw,@JsonKey(includeIfNull: true, name: 'max_accel_period_ud') num? maxAccelPeriodUd,@JsonKey(includeIfNull: true, name: 'predominant_period_ud') num? predominantPeriodUd,@JsonKey(includeIfNull: false, name: 'occurrence_time') DateTime? occurrenceTime
});




}
/// @nodoc
class _$CatalogStationRecordCopyWithImpl<$Res>
    implements $CatalogStationRecordCopyWith<$Res> {
  _$CatalogStationRecordCopyWithImpl(this._self, this._then);

  final CatalogStationRecord _self;
  final $Res Function(CatalogStationRecord) _then;

/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stationCode = null,Object? intensityRaw = freezed,Object? instrumentalIntensity = freezed,Object? maxAccelSynthesizedGal = freezed,Object? maxAccelNsGal = freezed,Object? maxAccelEwGal = freezed,Object? maxAccelUdGal = freezed,Object? maxAccelPeriodNs = freezed,Object? predominantPeriodNs = freezed,Object? maxAccelPeriodEw = freezed,Object? predominantPeriodEw = freezed,Object? maxAccelPeriodUd = freezed,Object? predominantPeriodUd = freezed,Object? occurrenceTime = freezed,}) {
  return _then(_self.copyWith(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,intensityRaw: freezed == intensityRaw ? _self.intensityRaw : intensityRaw // ignore: cast_nullable_to_non_nullable
as String?,instrumentalIntensity: freezed == instrumentalIntensity ? _self.instrumentalIntensity : instrumentalIntensity // ignore: cast_nullable_to_non_nullable
as num?,maxAccelSynthesizedGal: freezed == maxAccelSynthesizedGal ? _self.maxAccelSynthesizedGal : maxAccelSynthesizedGal // ignore: cast_nullable_to_non_nullable
as num?,maxAccelNsGal: freezed == maxAccelNsGal ? _self.maxAccelNsGal : maxAccelNsGal // ignore: cast_nullable_to_non_nullable
as num?,maxAccelEwGal: freezed == maxAccelEwGal ? _self.maxAccelEwGal : maxAccelEwGal // ignore: cast_nullable_to_non_nullable
as num?,maxAccelUdGal: freezed == maxAccelUdGal ? _self.maxAccelUdGal : maxAccelUdGal // ignore: cast_nullable_to_non_nullable
as num?,maxAccelPeriodNs: freezed == maxAccelPeriodNs ? _self.maxAccelPeriodNs : maxAccelPeriodNs // ignore: cast_nullable_to_non_nullable
as num?,predominantPeriodNs: freezed == predominantPeriodNs ? _self.predominantPeriodNs : predominantPeriodNs // ignore: cast_nullable_to_non_nullable
as num?,maxAccelPeriodEw: freezed == maxAccelPeriodEw ? _self.maxAccelPeriodEw : maxAccelPeriodEw // ignore: cast_nullable_to_non_nullable
as num?,predominantPeriodEw: freezed == predominantPeriodEw ? _self.predominantPeriodEw : predominantPeriodEw // ignore: cast_nullable_to_non_nullable
as num?,maxAccelPeriodUd: freezed == maxAccelPeriodUd ? _self.maxAccelPeriodUd : maxAccelPeriodUd // ignore: cast_nullable_to_non_nullable
as num?,predominantPeriodUd: freezed == predominantPeriodUd ? _self.predominantPeriodUd : predominantPeriodUd // ignore: cast_nullable_to_non_nullable
as num?,occurrenceTime: freezed == occurrenceTime ? _self.occurrenceTime : occurrenceTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogStationRecord].
extension CatalogStationRecordPatterns on CatalogStationRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogStationRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogStationRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogStationRecord value)  $default,){
final _that = this;
switch (_that) {
case _CatalogStationRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogStationRecord value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogStationRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'station_code')  String stationCode, @JsonKey(includeIfNull: true, name: 'intensity_raw')  String? intensityRaw, @JsonKey(includeIfNull: true, name: 'instrumental_intensity')  num? instrumentalIntensity, @JsonKey(includeIfNull: true, name: 'max_accel_synthesized_gal')  num? maxAccelSynthesizedGal, @JsonKey(includeIfNull: true, name: 'max_accel_ns_gal')  num? maxAccelNsGal, @JsonKey(includeIfNull: true, name: 'max_accel_ew_gal')  num? maxAccelEwGal, @JsonKey(includeIfNull: true, name: 'max_accel_ud_gal')  num? maxAccelUdGal, @JsonKey(includeIfNull: true, name: 'max_accel_period_ns')  num? maxAccelPeriodNs, @JsonKey(includeIfNull: true, name: 'predominant_period_ns')  num? predominantPeriodNs, @JsonKey(includeIfNull: true, name: 'max_accel_period_ew')  num? maxAccelPeriodEw, @JsonKey(includeIfNull: true, name: 'predominant_period_ew')  num? predominantPeriodEw, @JsonKey(includeIfNull: true, name: 'max_accel_period_ud')  num? maxAccelPeriodUd, @JsonKey(includeIfNull: true, name: 'predominant_period_ud')  num? predominantPeriodUd, @JsonKey(includeIfNull: false, name: 'occurrence_time')  DateTime? occurrenceTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogStationRecord() when $default != null:
return $default(_that.stationCode,_that.intensityRaw,_that.instrumentalIntensity,_that.maxAccelSynthesizedGal,_that.maxAccelNsGal,_that.maxAccelEwGal,_that.maxAccelUdGal,_that.maxAccelPeriodNs,_that.predominantPeriodNs,_that.maxAccelPeriodEw,_that.predominantPeriodEw,_that.maxAccelPeriodUd,_that.predominantPeriodUd,_that.occurrenceTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'station_code')  String stationCode, @JsonKey(includeIfNull: true, name: 'intensity_raw')  String? intensityRaw, @JsonKey(includeIfNull: true, name: 'instrumental_intensity')  num? instrumentalIntensity, @JsonKey(includeIfNull: true, name: 'max_accel_synthesized_gal')  num? maxAccelSynthesizedGal, @JsonKey(includeIfNull: true, name: 'max_accel_ns_gal')  num? maxAccelNsGal, @JsonKey(includeIfNull: true, name: 'max_accel_ew_gal')  num? maxAccelEwGal, @JsonKey(includeIfNull: true, name: 'max_accel_ud_gal')  num? maxAccelUdGal, @JsonKey(includeIfNull: true, name: 'max_accel_period_ns')  num? maxAccelPeriodNs, @JsonKey(includeIfNull: true, name: 'predominant_period_ns')  num? predominantPeriodNs, @JsonKey(includeIfNull: true, name: 'max_accel_period_ew')  num? maxAccelPeriodEw, @JsonKey(includeIfNull: true, name: 'predominant_period_ew')  num? predominantPeriodEw, @JsonKey(includeIfNull: true, name: 'max_accel_period_ud')  num? maxAccelPeriodUd, @JsonKey(includeIfNull: true, name: 'predominant_period_ud')  num? predominantPeriodUd, @JsonKey(includeIfNull: false, name: 'occurrence_time')  DateTime? occurrenceTime)  $default,) {final _that = this;
switch (_that) {
case _CatalogStationRecord():
return $default(_that.stationCode,_that.intensityRaw,_that.instrumentalIntensity,_that.maxAccelSynthesizedGal,_that.maxAccelNsGal,_that.maxAccelEwGal,_that.maxAccelUdGal,_that.maxAccelPeriodNs,_that.predominantPeriodNs,_that.maxAccelPeriodEw,_that.predominantPeriodEw,_that.maxAccelPeriodUd,_that.predominantPeriodUd,_that.occurrenceTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'station_code')  String stationCode, @JsonKey(includeIfNull: true, name: 'intensity_raw')  String? intensityRaw, @JsonKey(includeIfNull: true, name: 'instrumental_intensity')  num? instrumentalIntensity, @JsonKey(includeIfNull: true, name: 'max_accel_synthesized_gal')  num? maxAccelSynthesizedGal, @JsonKey(includeIfNull: true, name: 'max_accel_ns_gal')  num? maxAccelNsGal, @JsonKey(includeIfNull: true, name: 'max_accel_ew_gal')  num? maxAccelEwGal, @JsonKey(includeIfNull: true, name: 'max_accel_ud_gal')  num? maxAccelUdGal, @JsonKey(includeIfNull: true, name: 'max_accel_period_ns')  num? maxAccelPeriodNs, @JsonKey(includeIfNull: true, name: 'predominant_period_ns')  num? predominantPeriodNs, @JsonKey(includeIfNull: true, name: 'max_accel_period_ew')  num? maxAccelPeriodEw, @JsonKey(includeIfNull: true, name: 'predominant_period_ew')  num? predominantPeriodEw, @JsonKey(includeIfNull: true, name: 'max_accel_period_ud')  num? maxAccelPeriodUd, @JsonKey(includeIfNull: true, name: 'predominant_period_ud')  num? predominantPeriodUd, @JsonKey(includeIfNull: false, name: 'occurrence_time')  DateTime? occurrenceTime)?  $default,) {final _that = this;
switch (_that) {
case _CatalogStationRecord() when $default != null:
return $default(_that.stationCode,_that.intensityRaw,_that.instrumentalIntensity,_that.maxAccelSynthesizedGal,_that.maxAccelNsGal,_that.maxAccelEwGal,_that.maxAccelUdGal,_that.maxAccelPeriodNs,_that.predominantPeriodNs,_that.maxAccelPeriodEw,_that.predominantPeriodEw,_that.maxAccelPeriodUd,_that.predominantPeriodUd,_that.occurrenceTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogStationRecord implements CatalogStationRecord {
  const _CatalogStationRecord({@JsonKey(name: 'station_code') required this.stationCode, @JsonKey(includeIfNull: true, name: 'intensity_raw') required this.intensityRaw, @JsonKey(includeIfNull: true, name: 'instrumental_intensity') required this.instrumentalIntensity, @JsonKey(includeIfNull: true, name: 'max_accel_synthesized_gal') required this.maxAccelSynthesizedGal, @JsonKey(includeIfNull: true, name: 'max_accel_ns_gal') required this.maxAccelNsGal, @JsonKey(includeIfNull: true, name: 'max_accel_ew_gal') required this.maxAccelEwGal, @JsonKey(includeIfNull: true, name: 'max_accel_ud_gal') required this.maxAccelUdGal, @JsonKey(includeIfNull: true, name: 'max_accel_period_ns') required this.maxAccelPeriodNs, @JsonKey(includeIfNull: true, name: 'predominant_period_ns') required this.predominantPeriodNs, @JsonKey(includeIfNull: true, name: 'max_accel_period_ew') required this.maxAccelPeriodEw, @JsonKey(includeIfNull: true, name: 'predominant_period_ew') required this.predominantPeriodEw, @JsonKey(includeIfNull: true, name: 'max_accel_period_ud') required this.maxAccelPeriodUd, @JsonKey(includeIfNull: true, name: 'predominant_period_ud') required this.predominantPeriodUd, @JsonKey(includeIfNull: false, name: 'occurrence_time') this.occurrenceTime});
  factory _CatalogStationRecord.fromJson(Map<String, dynamic> json) => _$CatalogStationRecordFromJson(json);

@override@JsonKey(name: 'station_code') final  String stationCode;
@override@JsonKey(includeIfNull: true, name: 'intensity_raw') final  String? intensityRaw;
@override@JsonKey(includeIfNull: true, name: 'instrumental_intensity') final  num? instrumentalIntensity;
@override@JsonKey(includeIfNull: true, name: 'max_accel_synthesized_gal') final  num? maxAccelSynthesizedGal;
@override@JsonKey(includeIfNull: true, name: 'max_accel_ns_gal') final  num? maxAccelNsGal;
@override@JsonKey(includeIfNull: true, name: 'max_accel_ew_gal') final  num? maxAccelEwGal;
@override@JsonKey(includeIfNull: true, name: 'max_accel_ud_gal') final  num? maxAccelUdGal;
@override@JsonKey(includeIfNull: true, name: 'max_accel_period_ns') final  num? maxAccelPeriodNs;
@override@JsonKey(includeIfNull: true, name: 'predominant_period_ns') final  num? predominantPeriodNs;
@override@JsonKey(includeIfNull: true, name: 'max_accel_period_ew') final  num? maxAccelPeriodEw;
@override@JsonKey(includeIfNull: true, name: 'predominant_period_ew') final  num? predominantPeriodEw;
@override@JsonKey(includeIfNull: true, name: 'max_accel_period_ud') final  num? maxAccelPeriodUd;
@override@JsonKey(includeIfNull: true, name: 'predominant_period_ud') final  num? predominantPeriodUd;
@override@JsonKey(includeIfNull: false, name: 'occurrence_time') final  DateTime? occurrenceTime;

/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogStationRecordCopyWith<_CatalogStationRecord> get copyWith => __$CatalogStationRecordCopyWithImpl<_CatalogStationRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogStationRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogStationRecord&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.intensityRaw, intensityRaw) || other.intensityRaw == intensityRaw)&&(identical(other.instrumentalIntensity, instrumentalIntensity) || other.instrumentalIntensity == instrumentalIntensity)&&(identical(other.maxAccelSynthesizedGal, maxAccelSynthesizedGal) || other.maxAccelSynthesizedGal == maxAccelSynthesizedGal)&&(identical(other.maxAccelNsGal, maxAccelNsGal) || other.maxAccelNsGal == maxAccelNsGal)&&(identical(other.maxAccelEwGal, maxAccelEwGal) || other.maxAccelEwGal == maxAccelEwGal)&&(identical(other.maxAccelUdGal, maxAccelUdGal) || other.maxAccelUdGal == maxAccelUdGal)&&(identical(other.maxAccelPeriodNs, maxAccelPeriodNs) || other.maxAccelPeriodNs == maxAccelPeriodNs)&&(identical(other.predominantPeriodNs, predominantPeriodNs) || other.predominantPeriodNs == predominantPeriodNs)&&(identical(other.maxAccelPeriodEw, maxAccelPeriodEw) || other.maxAccelPeriodEw == maxAccelPeriodEw)&&(identical(other.predominantPeriodEw, predominantPeriodEw) || other.predominantPeriodEw == predominantPeriodEw)&&(identical(other.maxAccelPeriodUd, maxAccelPeriodUd) || other.maxAccelPeriodUd == maxAccelPeriodUd)&&(identical(other.predominantPeriodUd, predominantPeriodUd) || other.predominantPeriodUd == predominantPeriodUd)&&(identical(other.occurrenceTime, occurrenceTime) || other.occurrenceTime == occurrenceTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationCode,intensityRaw,instrumentalIntensity,maxAccelSynthesizedGal,maxAccelNsGal,maxAccelEwGal,maxAccelUdGal,maxAccelPeriodNs,predominantPeriodNs,maxAccelPeriodEw,predominantPeriodEw,maxAccelPeriodUd,predominantPeriodUd,occurrenceTime);

@override
String toString() {
  return 'CatalogStationRecord(stationCode: $stationCode, intensityRaw: $intensityRaw, instrumentalIntensity: $instrumentalIntensity, maxAccelSynthesizedGal: $maxAccelSynthesizedGal, maxAccelNsGal: $maxAccelNsGal, maxAccelEwGal: $maxAccelEwGal, maxAccelUdGal: $maxAccelUdGal, maxAccelPeriodNs: $maxAccelPeriodNs, predominantPeriodNs: $predominantPeriodNs, maxAccelPeriodEw: $maxAccelPeriodEw, predominantPeriodEw: $predominantPeriodEw, maxAccelPeriodUd: $maxAccelPeriodUd, predominantPeriodUd: $predominantPeriodUd, occurrenceTime: $occurrenceTime)';
}


}

/// @nodoc
abstract mixin class _$CatalogStationRecordCopyWith<$Res> implements $CatalogStationRecordCopyWith<$Res> {
  factory _$CatalogStationRecordCopyWith(_CatalogStationRecord value, $Res Function(_CatalogStationRecord) _then) = __$CatalogStationRecordCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'station_code') String stationCode,@JsonKey(includeIfNull: true, name: 'intensity_raw') String? intensityRaw,@JsonKey(includeIfNull: true, name: 'instrumental_intensity') num? instrumentalIntensity,@JsonKey(includeIfNull: true, name: 'max_accel_synthesized_gal') num? maxAccelSynthesizedGal,@JsonKey(includeIfNull: true, name: 'max_accel_ns_gal') num? maxAccelNsGal,@JsonKey(includeIfNull: true, name: 'max_accel_ew_gal') num? maxAccelEwGal,@JsonKey(includeIfNull: true, name: 'max_accel_ud_gal') num? maxAccelUdGal,@JsonKey(includeIfNull: true, name: 'max_accel_period_ns') num? maxAccelPeriodNs,@JsonKey(includeIfNull: true, name: 'predominant_period_ns') num? predominantPeriodNs,@JsonKey(includeIfNull: true, name: 'max_accel_period_ew') num? maxAccelPeriodEw,@JsonKey(includeIfNull: true, name: 'predominant_period_ew') num? predominantPeriodEw,@JsonKey(includeIfNull: true, name: 'max_accel_period_ud') num? maxAccelPeriodUd,@JsonKey(includeIfNull: true, name: 'predominant_period_ud') num? predominantPeriodUd,@JsonKey(includeIfNull: false, name: 'occurrence_time') DateTime? occurrenceTime
});




}
/// @nodoc
class __$CatalogStationRecordCopyWithImpl<$Res>
    implements _$CatalogStationRecordCopyWith<$Res> {
  __$CatalogStationRecordCopyWithImpl(this._self, this._then);

  final _CatalogStationRecord _self;
  final $Res Function(_CatalogStationRecord) _then;

/// Create a copy of CatalogStationRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stationCode = null,Object? intensityRaw = freezed,Object? instrumentalIntensity = freezed,Object? maxAccelSynthesizedGal = freezed,Object? maxAccelNsGal = freezed,Object? maxAccelEwGal = freezed,Object? maxAccelUdGal = freezed,Object? maxAccelPeriodNs = freezed,Object? predominantPeriodNs = freezed,Object? maxAccelPeriodEw = freezed,Object? predominantPeriodEw = freezed,Object? maxAccelPeriodUd = freezed,Object? predominantPeriodUd = freezed,Object? occurrenceTime = freezed,}) {
  return _then(_CatalogStationRecord(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,intensityRaw: freezed == intensityRaw ? _self.intensityRaw : intensityRaw // ignore: cast_nullable_to_non_nullable
as String?,instrumentalIntensity: freezed == instrumentalIntensity ? _self.instrumentalIntensity : instrumentalIntensity // ignore: cast_nullable_to_non_nullable
as num?,maxAccelSynthesizedGal: freezed == maxAccelSynthesizedGal ? _self.maxAccelSynthesizedGal : maxAccelSynthesizedGal // ignore: cast_nullable_to_non_nullable
as num?,maxAccelNsGal: freezed == maxAccelNsGal ? _self.maxAccelNsGal : maxAccelNsGal // ignore: cast_nullable_to_non_nullable
as num?,maxAccelEwGal: freezed == maxAccelEwGal ? _self.maxAccelEwGal : maxAccelEwGal // ignore: cast_nullable_to_non_nullable
as num?,maxAccelUdGal: freezed == maxAccelUdGal ? _self.maxAccelUdGal : maxAccelUdGal // ignore: cast_nullable_to_non_nullable
as num?,maxAccelPeriodNs: freezed == maxAccelPeriodNs ? _self.maxAccelPeriodNs : maxAccelPeriodNs // ignore: cast_nullable_to_non_nullable
as num?,predominantPeriodNs: freezed == predominantPeriodNs ? _self.predominantPeriodNs : predominantPeriodNs // ignore: cast_nullable_to_non_nullable
as num?,maxAccelPeriodEw: freezed == maxAccelPeriodEw ? _self.maxAccelPeriodEw : maxAccelPeriodEw // ignore: cast_nullable_to_non_nullable
as num?,predominantPeriodEw: freezed == predominantPeriodEw ? _self.predominantPeriodEw : predominantPeriodEw // ignore: cast_nullable_to_non_nullable
as num?,maxAccelPeriodUd: freezed == maxAccelPeriodUd ? _self.maxAccelPeriodUd : maxAccelPeriodUd // ignore: cast_nullable_to_non_nullable
as num?,predominantPeriodUd: freezed == predominantPeriodUd ? _self.predominantPeriodUd : predominantPeriodUd // ignore: cast_nullable_to_non_nullable
as num?,occurrenceTime: freezed == occurrenceTime ? _self.occurrenceTime : occurrenceTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
