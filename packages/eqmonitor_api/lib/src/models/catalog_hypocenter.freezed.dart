// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogHypocenter {

/// 0が代表震源
 int get seq;@JsonKey(name: 'record_type') CatalogHypocenterRecordType get recordType;/// 気象庁または他機関が計算したマグニチュード（0〜2件、magnitude1/magnitude2に対応）
 List<CatalogHypocenterMagnitude> get magnitudes;@JsonKey(name: 'epicenter_name') String get epicenterName;/// 震度1以上を観測した観測点の数
@JsonKey(name: 'station_count') int get stationCount;@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? get originTime;@JsonKey(includeIfNull: false, name: 'origin_time_stderr_seconds') num? get originTimeStderrSeconds;@JsonKey(includeIfNull: false) Coordinate? get coordinates;@JsonKey(includeIfNull: false) CatalogHypocenterDepth? get depth;@JsonKey(includeIfNull: false, name: 'max_intensity') CatalogIntensityClass? get maxIntensity;@JsonKey(includeIfNull: false, name: 'large_area_code') int? get largeAreaCode;@JsonKey(includeIfNull: false, name: 'small_area_code') int? get smallAreaCode;@JsonKey(includeIfNull: false, name: 'determination_flag') CatalogDeterminationFlag? get determinationFlag;@JsonKey(includeIfNull: false) CatalogHypocenterEvaluation? get evaluation;@JsonKey(includeIfNull: false, name: 'auxiliary_info') CatalogHypocenterAuxiliaryInfo? get auxiliaryInfo;@JsonKey(includeIfNull: false, name: 'travel_time_table') CatalogTravelTimeTable? get travelTimeTable;
/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogHypocenterCopyWith<CatalogHypocenter> get copyWith => _$CatalogHypocenterCopyWithImpl<CatalogHypocenter>(this as CatalogHypocenter, _$identity);

  /// Serializes this CatalogHypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogHypocenter&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.recordType, recordType) || other.recordType == recordType)&&const DeepCollectionEquality().equals(other.magnitudes, magnitudes)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.stationCount, stationCount) || other.stationCount == stationCount)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimeStderrSeconds, originTimeStderrSeconds) || other.originTimeStderrSeconds == originTimeStderrSeconds)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.largeAreaCode, largeAreaCode) || other.largeAreaCode == largeAreaCode)&&(identical(other.smallAreaCode, smallAreaCode) || other.smallAreaCode == smallAreaCode)&&(identical(other.determinationFlag, determinationFlag) || other.determinationFlag == determinationFlag)&&(identical(other.evaluation, evaluation) || other.evaluation == evaluation)&&(identical(other.auxiliaryInfo, auxiliaryInfo) || other.auxiliaryInfo == auxiliaryInfo)&&(identical(other.travelTimeTable, travelTimeTable) || other.travelTimeTable == travelTimeTable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seq,recordType,const DeepCollectionEquality().hash(magnitudes),epicenterName,stationCount,originTime,originTimeStderrSeconds,coordinates,depth,maxIntensity,largeAreaCode,smallAreaCode,determinationFlag,evaluation,auxiliaryInfo,travelTimeTable);

@override
String toString() {
  return 'CatalogHypocenter(seq: $seq, recordType: $recordType, magnitudes: $magnitudes, epicenterName: $epicenterName, stationCount: $stationCount, originTime: $originTime, originTimeStderrSeconds: $originTimeStderrSeconds, coordinates: $coordinates, depth: $depth, maxIntensity: $maxIntensity, largeAreaCode: $largeAreaCode, smallAreaCode: $smallAreaCode, determinationFlag: $determinationFlag, evaluation: $evaluation, auxiliaryInfo: $auxiliaryInfo, travelTimeTable: $travelTimeTable)';
}


}

/// @nodoc
abstract mixin class $CatalogHypocenterCopyWith<$Res>  {
  factory $CatalogHypocenterCopyWith(CatalogHypocenter value, $Res Function(CatalogHypocenter) _then) = _$CatalogHypocenterCopyWithImpl;
@useResult
$Res call({
 int seq,@JsonKey(name: 'record_type') CatalogHypocenterRecordType recordType, List<CatalogHypocenterMagnitude> magnitudes,@JsonKey(name: 'epicenter_name') String epicenterName,@JsonKey(name: 'station_count') int stationCount,@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: false, name: 'origin_time_stderr_seconds') num? originTimeStderrSeconds,@JsonKey(includeIfNull: false) Coordinate? coordinates,@JsonKey(includeIfNull: false) CatalogHypocenterDepth? depth,@JsonKey(includeIfNull: false, name: 'max_intensity') CatalogIntensityClass? maxIntensity,@JsonKey(includeIfNull: false, name: 'large_area_code') int? largeAreaCode,@JsonKey(includeIfNull: false, name: 'small_area_code') int? smallAreaCode,@JsonKey(includeIfNull: false, name: 'determination_flag') CatalogDeterminationFlag? determinationFlag,@JsonKey(includeIfNull: false) CatalogHypocenterEvaluation? evaluation,@JsonKey(includeIfNull: false, name: 'auxiliary_info') CatalogHypocenterAuxiliaryInfo? auxiliaryInfo,@JsonKey(includeIfNull: false, name: 'travel_time_table') CatalogTravelTimeTable? travelTimeTable
});


$CoordinateCopyWith<$Res>? get coordinates;$CatalogHypocenterDepthCopyWith<$Res>? get depth;

}
/// @nodoc
class _$CatalogHypocenterCopyWithImpl<$Res>
    implements $CatalogHypocenterCopyWith<$Res> {
  _$CatalogHypocenterCopyWithImpl(this._self, this._then);

  final CatalogHypocenter _self;
  final $Res Function(CatalogHypocenter) _then;

/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seq = null,Object? recordType = null,Object? magnitudes = null,Object? epicenterName = null,Object? stationCount = null,Object? originTime = freezed,Object? originTimeStderrSeconds = freezed,Object? coordinates = freezed,Object? depth = freezed,Object? maxIntensity = freezed,Object? largeAreaCode = freezed,Object? smallAreaCode = freezed,Object? determinationFlag = freezed,Object? evaluation = freezed,Object? auxiliaryInfo = freezed,Object? travelTimeTable = freezed,}) {
  return _then(CatalogHypocenter(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,recordType: null == recordType ? _self.recordType : recordType // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterRecordType,magnitudes: null == magnitudes ? _self.magnitudes : magnitudes // ignore: cast_nullable_to_non_nullable
as List<CatalogHypocenterMagnitude>,epicenterName: null == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String,stationCount: null == stationCount ? _self.stationCount : stationCount // ignore: cast_nullable_to_non_nullable
as int,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimeStderrSeconds: freezed == originTimeStderrSeconds ? _self.originTimeStderrSeconds : originTimeStderrSeconds // ignore: cast_nullable_to_non_nullable
as num?,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterDepth?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as CatalogIntensityClass?,largeAreaCode: freezed == largeAreaCode ? _self.largeAreaCode : largeAreaCode // ignore: cast_nullable_to_non_nullable
as int?,smallAreaCode: freezed == smallAreaCode ? _self.smallAreaCode : smallAreaCode // ignore: cast_nullable_to_non_nullable
as int?,determinationFlag: freezed == determinationFlag ? _self.determinationFlag : determinationFlag // ignore: cast_nullable_to_non_nullable
as CatalogDeterminationFlag?,evaluation: freezed == evaluation ? _self.evaluation : evaluation // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterEvaluation?,auxiliaryInfo: freezed == auxiliaryInfo ? _self.auxiliaryInfo : auxiliaryInfo // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterAuxiliaryInfo?,travelTimeTable: freezed == travelTimeTable ? _self.travelTimeTable : travelTimeTable // ignore: cast_nullable_to_non_nullable
as CatalogTravelTimeTable?,
  ));
}
/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinateCopyWith<$Res>? get coordinates {
    if (_self.coordinates == null) {
    return null;
  }

  return $CoordinateCopyWith<$Res>(_self.coordinates!, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogHypocenterDepthCopyWith<$Res>? get depth {
    if (_self.depth == null) {
    return null;
  }

  return $CatalogHypocenterDepthCopyWith<$Res>(_self.depth!, (value) {
    return _then(_self.copyWith(depth: value));
  });
}
}


/// Adds pattern-matching-related methods to [CatalogHypocenter].
extension CatalogHypocenterPatterns on CatalogHypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogHypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogHypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogHypocenter value)  $default,){
final _that = this;
switch (_that) {
case _CatalogHypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogHypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogHypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seq, @JsonKey(name: 'record_type')  CatalogHypocenterRecordType recordType,  List<CatalogHypocenterMagnitude> magnitudes, @JsonKey(name: 'epicenter_name')  String epicenterName, @JsonKey(name: 'station_count')  int stationCount, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'origin_time_stderr_seconds')  num? originTimeStderrSeconds, @JsonKey(includeIfNull: false)  Coordinate? coordinates, @JsonKey(includeIfNull: false)  CatalogHypocenterDepth? depth, @JsonKey(includeIfNull: false, name: 'max_intensity')  CatalogIntensityClass? maxIntensity, @JsonKey(includeIfNull: false, name: 'large_area_code')  int? largeAreaCode, @JsonKey(includeIfNull: false, name: 'small_area_code')  int? smallAreaCode, @JsonKey(includeIfNull: false, name: 'determination_flag')  CatalogDeterminationFlag? determinationFlag, @JsonKey(includeIfNull: false)  CatalogHypocenterEvaluation? evaluation, @JsonKey(includeIfNull: false, name: 'auxiliary_info')  CatalogHypocenterAuxiliaryInfo? auxiliaryInfo, @JsonKey(includeIfNull: false, name: 'travel_time_table')  CatalogTravelTimeTable? travelTimeTable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogHypocenter() when $default != null:
return $default(_that.seq,_that.recordType,_that.magnitudes,_that.epicenterName,_that.stationCount,_that.originTime,_that.originTimeStderrSeconds,_that.coordinates,_that.depth,_that.maxIntensity,_that.largeAreaCode,_that.smallAreaCode,_that.determinationFlag,_that.evaluation,_that.auxiliaryInfo,_that.travelTimeTable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seq, @JsonKey(name: 'record_type')  CatalogHypocenterRecordType recordType,  List<CatalogHypocenterMagnitude> magnitudes, @JsonKey(name: 'epicenter_name')  String epicenterName, @JsonKey(name: 'station_count')  int stationCount, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'origin_time_stderr_seconds')  num? originTimeStderrSeconds, @JsonKey(includeIfNull: false)  Coordinate? coordinates, @JsonKey(includeIfNull: false)  CatalogHypocenterDepth? depth, @JsonKey(includeIfNull: false, name: 'max_intensity')  CatalogIntensityClass? maxIntensity, @JsonKey(includeIfNull: false, name: 'large_area_code')  int? largeAreaCode, @JsonKey(includeIfNull: false, name: 'small_area_code')  int? smallAreaCode, @JsonKey(includeIfNull: false, name: 'determination_flag')  CatalogDeterminationFlag? determinationFlag, @JsonKey(includeIfNull: false)  CatalogHypocenterEvaluation? evaluation, @JsonKey(includeIfNull: false, name: 'auxiliary_info')  CatalogHypocenterAuxiliaryInfo? auxiliaryInfo, @JsonKey(includeIfNull: false, name: 'travel_time_table')  CatalogTravelTimeTable? travelTimeTable)  $default,) {final _that = this;
switch (_that) {
case _CatalogHypocenter():
return $default(_that.seq,_that.recordType,_that.magnitudes,_that.epicenterName,_that.stationCount,_that.originTime,_that.originTimeStderrSeconds,_that.coordinates,_that.depth,_that.maxIntensity,_that.largeAreaCode,_that.smallAreaCode,_that.determinationFlag,_that.evaluation,_that.auxiliaryInfo,_that.travelTimeTable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seq, @JsonKey(name: 'record_type')  CatalogHypocenterRecordType recordType,  List<CatalogHypocenterMagnitude> magnitudes, @JsonKey(name: 'epicenter_name')  String epicenterName, @JsonKey(name: 'station_count')  int stationCount, @JsonKey(includeIfNull: false, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: false, name: 'origin_time_stderr_seconds')  num? originTimeStderrSeconds, @JsonKey(includeIfNull: false)  Coordinate? coordinates, @JsonKey(includeIfNull: false)  CatalogHypocenterDepth? depth, @JsonKey(includeIfNull: false, name: 'max_intensity')  CatalogIntensityClass? maxIntensity, @JsonKey(includeIfNull: false, name: 'large_area_code')  int? largeAreaCode, @JsonKey(includeIfNull: false, name: 'small_area_code')  int? smallAreaCode, @JsonKey(includeIfNull: false, name: 'determination_flag')  CatalogDeterminationFlag? determinationFlag, @JsonKey(includeIfNull: false)  CatalogHypocenterEvaluation? evaluation, @JsonKey(includeIfNull: false, name: 'auxiliary_info')  CatalogHypocenterAuxiliaryInfo? auxiliaryInfo, @JsonKey(includeIfNull: false, name: 'travel_time_table')  CatalogTravelTimeTable? travelTimeTable)?  $default,) {final _that = this;
switch (_that) {
case _CatalogHypocenter() when $default != null:
return $default(_that.seq,_that.recordType,_that.magnitudes,_that.epicenterName,_that.stationCount,_that.originTime,_that.originTimeStderrSeconds,_that.coordinates,_that.depth,_that.maxIntensity,_that.largeAreaCode,_that.smallAreaCode,_that.determinationFlag,_that.evaluation,_that.auxiliaryInfo,_that.travelTimeTable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogHypocenter implements CatalogHypocenter {
  const _CatalogHypocenter({required this.seq, @JsonKey(name: 'record_type') required this.recordType, required  List<CatalogHypocenterMagnitude> magnitudes, @JsonKey(name: 'epicenter_name') required this.epicenterName, @JsonKey(name: 'station_count') required this.stationCount, @JsonKey(includeIfNull: false, name: 'origin_time') this.originTime, @JsonKey(includeIfNull: false, name: 'origin_time_stderr_seconds') this.originTimeStderrSeconds, @JsonKey(includeIfNull: false) this.coordinates, @JsonKey(includeIfNull: false) this.depth, @JsonKey(includeIfNull: false, name: 'max_intensity') this.maxIntensity, @JsonKey(includeIfNull: false, name: 'large_area_code') this.largeAreaCode, @JsonKey(includeIfNull: false, name: 'small_area_code') this.smallAreaCode, @JsonKey(includeIfNull: false, name: 'determination_flag') this.determinationFlag, @JsonKey(includeIfNull: false) this.evaluation, @JsonKey(includeIfNull: false, name: 'auxiliary_info') this.auxiliaryInfo, @JsonKey(includeIfNull: false, name: 'travel_time_table') this.travelTimeTable}): _magnitudes = magnitudes;
  factory _CatalogHypocenter.fromJson(Map<String, dynamic> json) => _$CatalogHypocenterFromJson(json);

/// 0が代表震源
@override final  int seq;
@override@JsonKey(name: 'record_type') final  CatalogHypocenterRecordType recordType;
/// 気象庁または他機関が計算したマグニチュード（0〜2件、magnitude1/magnitude2に対応）
 final  List<CatalogHypocenterMagnitude> _magnitudes;
/// 気象庁または他機関が計算したマグニチュード（0〜2件、magnitude1/magnitude2に対応）
@override List<CatalogHypocenterMagnitude> get magnitudes {
  if (_magnitudes is EqualUnmodifiableListView) return _magnitudes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_magnitudes);
}

@override@JsonKey(name: 'epicenter_name') final  String epicenterName;
/// 震度1以上を観測した観測点の数
@override@JsonKey(name: 'station_count') final  int stationCount;
@override@JsonKey(includeIfNull: false, name: 'origin_time') final  DateTime? originTime;
@override@JsonKey(includeIfNull: false, name: 'origin_time_stderr_seconds') final  num? originTimeStderrSeconds;
@override@JsonKey(includeIfNull: false) final  Coordinate? coordinates;
@override@JsonKey(includeIfNull: false) final  CatalogHypocenterDepth? depth;
@override@JsonKey(includeIfNull: false, name: 'max_intensity') final  CatalogIntensityClass? maxIntensity;
@override@JsonKey(includeIfNull: false, name: 'large_area_code') final  int? largeAreaCode;
@override@JsonKey(includeIfNull: false, name: 'small_area_code') final  int? smallAreaCode;
@override@JsonKey(includeIfNull: false, name: 'determination_flag') final  CatalogDeterminationFlag? determinationFlag;
@override@JsonKey(includeIfNull: false) final  CatalogHypocenterEvaluation? evaluation;
@override@JsonKey(includeIfNull: false, name: 'auxiliary_info') final  CatalogHypocenterAuxiliaryInfo? auxiliaryInfo;
@override@JsonKey(includeIfNull: false, name: 'travel_time_table') final  CatalogTravelTimeTable? travelTimeTable;

/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogHypocenterCopyWith<_CatalogHypocenter> get copyWith => __$CatalogHypocenterCopyWithImpl<_CatalogHypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogHypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogHypocenter&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.recordType, recordType) || other.recordType == recordType)&&const DeepCollectionEquality().equals(other._magnitudes, _magnitudes)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.stationCount, stationCount) || other.stationCount == stationCount)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimeStderrSeconds, originTimeStderrSeconds) || other.originTimeStderrSeconds == originTimeStderrSeconds)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.largeAreaCode, largeAreaCode) || other.largeAreaCode == largeAreaCode)&&(identical(other.smallAreaCode, smallAreaCode) || other.smallAreaCode == smallAreaCode)&&(identical(other.determinationFlag, determinationFlag) || other.determinationFlag == determinationFlag)&&(identical(other.evaluation, evaluation) || other.evaluation == evaluation)&&(identical(other.auxiliaryInfo, auxiliaryInfo) || other.auxiliaryInfo == auxiliaryInfo)&&(identical(other.travelTimeTable, travelTimeTable) || other.travelTimeTable == travelTimeTable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seq,recordType,const DeepCollectionEquality().hash(_magnitudes),epicenterName,stationCount,originTime,originTimeStderrSeconds,coordinates,depth,maxIntensity,largeAreaCode,smallAreaCode,determinationFlag,evaluation,auxiliaryInfo,travelTimeTable);

@override
String toString() {
  return 'CatalogHypocenter(seq: $seq, recordType: $recordType, magnitudes: $magnitudes, epicenterName: $epicenterName, stationCount: $stationCount, originTime: $originTime, originTimeStderrSeconds: $originTimeStderrSeconds, coordinates: $coordinates, depth: $depth, maxIntensity: $maxIntensity, largeAreaCode: $largeAreaCode, smallAreaCode: $smallAreaCode, determinationFlag: $determinationFlag, evaluation: $evaluation, auxiliaryInfo: $auxiliaryInfo, travelTimeTable: $travelTimeTable)';
}


}

/// @nodoc
abstract mixin class _$CatalogHypocenterCopyWith<$Res> implements $CatalogHypocenterCopyWith<$Res> {
  factory _$CatalogHypocenterCopyWith(_CatalogHypocenter value, $Res Function(_CatalogHypocenter) _then) = __$CatalogHypocenterCopyWithImpl;
@override @useResult
$Res call({
 int seq,@JsonKey(name: 'record_type') CatalogHypocenterRecordType recordType, List<CatalogHypocenterMagnitude> magnitudes,@JsonKey(name: 'epicenter_name') String epicenterName,@JsonKey(name: 'station_count') int stationCount,@JsonKey(includeIfNull: false, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: false, name: 'origin_time_stderr_seconds') num? originTimeStderrSeconds,@JsonKey(includeIfNull: false) Coordinate? coordinates,@JsonKey(includeIfNull: false) CatalogHypocenterDepth? depth,@JsonKey(includeIfNull: false, name: 'max_intensity') CatalogIntensityClass? maxIntensity,@JsonKey(includeIfNull: false, name: 'large_area_code') int? largeAreaCode,@JsonKey(includeIfNull: false, name: 'small_area_code') int? smallAreaCode,@JsonKey(includeIfNull: false, name: 'determination_flag') CatalogDeterminationFlag? determinationFlag,@JsonKey(includeIfNull: false) CatalogHypocenterEvaluation? evaluation,@JsonKey(includeIfNull: false, name: 'auxiliary_info') CatalogHypocenterAuxiliaryInfo? auxiliaryInfo,@JsonKey(includeIfNull: false, name: 'travel_time_table') CatalogTravelTimeTable? travelTimeTable
});


@override $CoordinateCopyWith<$Res>? get coordinates;@override $CatalogHypocenterDepthCopyWith<$Res>? get depth;

}
/// @nodoc
class __$CatalogHypocenterCopyWithImpl<$Res>
    implements _$CatalogHypocenterCopyWith<$Res> {
  __$CatalogHypocenterCopyWithImpl(this._self, this._then);

  final _CatalogHypocenter _self;
  final $Res Function(_CatalogHypocenter) _then;

/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? recordType = null,Object? magnitudes = null,Object? epicenterName = null,Object? stationCount = null,Object? originTime = freezed,Object? originTimeStderrSeconds = freezed,Object? coordinates = freezed,Object? depth = freezed,Object? maxIntensity = freezed,Object? largeAreaCode = freezed,Object? smallAreaCode = freezed,Object? determinationFlag = freezed,Object? evaluation = freezed,Object? auxiliaryInfo = freezed,Object? travelTimeTable = freezed,}) {
  return _then(_CatalogHypocenter(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,recordType: null == recordType ? _self.recordType : recordType // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterRecordType,magnitudes: null == magnitudes ? _self._magnitudes : magnitudes // ignore: cast_nullable_to_non_nullable
as List<CatalogHypocenterMagnitude>,epicenterName: null == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String,stationCount: null == stationCount ? _self.stationCount : stationCount // ignore: cast_nullable_to_non_nullable
as int,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimeStderrSeconds: freezed == originTimeStderrSeconds ? _self.originTimeStderrSeconds : originTimeStderrSeconds // ignore: cast_nullable_to_non_nullable
as num?,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterDepth?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as CatalogIntensityClass?,largeAreaCode: freezed == largeAreaCode ? _self.largeAreaCode : largeAreaCode // ignore: cast_nullable_to_non_nullable
as int?,smallAreaCode: freezed == smallAreaCode ? _self.smallAreaCode : smallAreaCode // ignore: cast_nullable_to_non_nullable
as int?,determinationFlag: freezed == determinationFlag ? _self.determinationFlag : determinationFlag // ignore: cast_nullable_to_non_nullable
as CatalogDeterminationFlag?,evaluation: freezed == evaluation ? _self.evaluation : evaluation // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterEvaluation?,auxiliaryInfo: freezed == auxiliaryInfo ? _self.auxiliaryInfo : auxiliaryInfo // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterAuxiliaryInfo?,travelTimeTable: freezed == travelTimeTable ? _self.travelTimeTable : travelTimeTable // ignore: cast_nullable_to_non_nullable
as CatalogTravelTimeTable?,
  ));
}

/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinateCopyWith<$Res>? get coordinates {
    if (_self.coordinates == null) {
    return null;
  }

  return $CoordinateCopyWith<$Res>(_self.coordinates!, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}/// Create a copy of CatalogHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogHypocenterDepthCopyWith<$Res>? get depth {
    if (_self.depth == null) {
    return null;
  }

  return $CatalogHypocenterDepthCopyWith<$Res>(_self.depth!, (value) {
    return _then(_self.copyWith(depth: value));
  });
}
}

// dart format on
