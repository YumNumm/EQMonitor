// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qzss_dc_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
QzssDcReport _$QzssDcReportFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'earthquakeEarlyWarning':
          return QzssDcReportEarthquakeEarlyWarning.fromJson(
            json
          );
                case 'hypocenter':
          return QzssDcReportHypocenter.fromJson(
            json
          );
                case 'seismicIntensity':
          return QzssDcReportSeismicIntensity.fromJson(
            json
          );
                case 'tsunami':
          return QzssDcReportTsunami.fromJson(
            json
          );
                case 'nankaiTroughEarthquake':
          return QzssDcReportNankaiTroughEarthquake.fromJson(
            json
          );
                case 'northwestPacificTsunami':
          return QzssDcReportNorthwestPacificTsunami.fromJson(
            json
          );
                case 'flood':
          return QzssDcReportFlood.fromJson(
            json
          );
                case 'marine':
          return QzssDcReportMarine.fromJson(
            json
          );
                case 'weather':
          return QzssDcReportWeather.fromJson(
            json
          );
                case 'volcano':
          return QzssDcReportVolcano.fromJson(
            json
          );
                case 'ashFall':
          return QzssDcReportAshFall.fromJson(
            json
          );
                case 'typhoon':
          return QzssDcReportTyphoon.fromJson(
            json
          );
                case 'dcxNull':
          return QzssDcReportDcxNull.fromJson(
            json
          );
                case 'dcxOutsideJapan':
          return QzssDcReportDcxOutsideJapan.fromJson(
            json
          );
                case 'dcxLAlert':
          return QzssDcReportDcxLAlert.fromJson(
            json
          );
                case 'dcxJAlert':
          return QzssDcReportDcxJAlert.fromJson(
            json
          );
                case 'dcxMTInfo':
          return QzssDcReportDcxMTInfo.fromJson(
            json
          );
                case 'dcxUnknown':
          return QzssDcReportDcxUnknown.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'QzssDcReport',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$QzssDcReport {

 String get sentence;@Uint8ListConverter() Uint8List get message; String get nmea;@Uint8ListConverter() Uint8List get raw; String get preamble; String get messageType; String? get messageHeader; int? get satelliteId; int? get satellitePrn;
/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportCopyWith<QzssDcReport> get copyWith => _$QzssDcReportCopyWithImpl<QzssDcReport>(this as QzssDcReport, _$identity);

  /// Serializes this QzssDcReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReport&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,messageHeader,satelliteId,satellitePrn);

@override
String toString() {
  return 'QzssDcReport(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportCopyWith<$Res>  {
  factory $QzssDcReportCopyWith(QzssDcReport value, $Res Function(QzssDcReport) _then) = _$QzssDcReportCopyWithImpl;
@useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportCopyWithImpl<$Res>
    implements $QzssDcReportCopyWith<$Res> {
  _$QzssDcReportCopyWithImpl(this._self, this._then);

  final QzssDcReport _self;
  final $Res Function(QzssDcReport) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(_self.copyWith(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [QzssDcReport].
extension QzssDcReportPatterns on QzssDcReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( QzssDcReportEarthquakeEarlyWarning value)?  earthquakeEarlyWarning,TResult Function( QzssDcReportHypocenter value)?  hypocenter,TResult Function( QzssDcReportSeismicIntensity value)?  seismicIntensity,TResult Function( QzssDcReportTsunami value)?  tsunami,TResult Function( QzssDcReportNankaiTroughEarthquake value)?  nankaiTroughEarthquake,TResult Function( QzssDcReportNorthwestPacificTsunami value)?  northwestPacificTsunami,TResult Function( QzssDcReportFlood value)?  flood,TResult Function( QzssDcReportMarine value)?  marine,TResult Function( QzssDcReportWeather value)?  weather,TResult Function( QzssDcReportVolcano value)?  volcano,TResult Function( QzssDcReportAshFall value)?  ashFall,TResult Function( QzssDcReportTyphoon value)?  typhoon,TResult Function( QzssDcReportDcxNull value)?  dcxNull,TResult Function( QzssDcReportDcxOutsideJapan value)?  dcxOutsideJapan,TResult Function( QzssDcReportDcxLAlert value)?  dcxLAlert,TResult Function( QzssDcReportDcxJAlert value)?  dcxJAlert,TResult Function( QzssDcReportDcxMTInfo value)?  dcxMTInfo,TResult Function( QzssDcReportDcxUnknown value)?  dcxUnknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case QzssDcReportEarthquakeEarlyWarning() when earthquakeEarlyWarning != null:
return earthquakeEarlyWarning(_that);case QzssDcReportHypocenter() when hypocenter != null:
return hypocenter(_that);case QzssDcReportSeismicIntensity() when seismicIntensity != null:
return seismicIntensity(_that);case QzssDcReportTsunami() when tsunami != null:
return tsunami(_that);case QzssDcReportNankaiTroughEarthquake() when nankaiTroughEarthquake != null:
return nankaiTroughEarthquake(_that);case QzssDcReportNorthwestPacificTsunami() when northwestPacificTsunami != null:
return northwestPacificTsunami(_that);case QzssDcReportFlood() when flood != null:
return flood(_that);case QzssDcReportMarine() when marine != null:
return marine(_that);case QzssDcReportWeather() when weather != null:
return weather(_that);case QzssDcReportVolcano() when volcano != null:
return volcano(_that);case QzssDcReportAshFall() when ashFall != null:
return ashFall(_that);case QzssDcReportTyphoon() when typhoon != null:
return typhoon(_that);case QzssDcReportDcxNull() when dcxNull != null:
return dcxNull(_that);case QzssDcReportDcxOutsideJapan() when dcxOutsideJapan != null:
return dcxOutsideJapan(_that);case QzssDcReportDcxLAlert() when dcxLAlert != null:
return dcxLAlert(_that);case QzssDcReportDcxJAlert() when dcxJAlert != null:
return dcxJAlert(_that);case QzssDcReportDcxMTInfo() when dcxMTInfo != null:
return dcxMTInfo(_that);case QzssDcReportDcxUnknown() when dcxUnknown != null:
return dcxUnknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( QzssDcReportEarthquakeEarlyWarning value)  earthquakeEarlyWarning,required TResult Function( QzssDcReportHypocenter value)  hypocenter,required TResult Function( QzssDcReportSeismicIntensity value)  seismicIntensity,required TResult Function( QzssDcReportTsunami value)  tsunami,required TResult Function( QzssDcReportNankaiTroughEarthquake value)  nankaiTroughEarthquake,required TResult Function( QzssDcReportNorthwestPacificTsunami value)  northwestPacificTsunami,required TResult Function( QzssDcReportFlood value)  flood,required TResult Function( QzssDcReportMarine value)  marine,required TResult Function( QzssDcReportWeather value)  weather,required TResult Function( QzssDcReportVolcano value)  volcano,required TResult Function( QzssDcReportAshFall value)  ashFall,required TResult Function( QzssDcReportTyphoon value)  typhoon,required TResult Function( QzssDcReportDcxNull value)  dcxNull,required TResult Function( QzssDcReportDcxOutsideJapan value)  dcxOutsideJapan,required TResult Function( QzssDcReportDcxLAlert value)  dcxLAlert,required TResult Function( QzssDcReportDcxJAlert value)  dcxJAlert,required TResult Function( QzssDcReportDcxMTInfo value)  dcxMTInfo,required TResult Function( QzssDcReportDcxUnknown value)  dcxUnknown,}){
final _that = this;
switch (_that) {
case QzssDcReportEarthquakeEarlyWarning():
return earthquakeEarlyWarning(_that);case QzssDcReportHypocenter():
return hypocenter(_that);case QzssDcReportSeismicIntensity():
return seismicIntensity(_that);case QzssDcReportTsunami():
return tsunami(_that);case QzssDcReportNankaiTroughEarthquake():
return nankaiTroughEarthquake(_that);case QzssDcReportNorthwestPacificTsunami():
return northwestPacificTsunami(_that);case QzssDcReportFlood():
return flood(_that);case QzssDcReportMarine():
return marine(_that);case QzssDcReportWeather():
return weather(_that);case QzssDcReportVolcano():
return volcano(_that);case QzssDcReportAshFall():
return ashFall(_that);case QzssDcReportTyphoon():
return typhoon(_that);case QzssDcReportDcxNull():
return dcxNull(_that);case QzssDcReportDcxOutsideJapan():
return dcxOutsideJapan(_that);case QzssDcReportDcxLAlert():
return dcxLAlert(_that);case QzssDcReportDcxJAlert():
return dcxJAlert(_that);case QzssDcReportDcxMTInfo():
return dcxMTInfo(_that);case QzssDcReportDcxUnknown():
return dcxUnknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( QzssDcReportEarthquakeEarlyWarning value)?  earthquakeEarlyWarning,TResult? Function( QzssDcReportHypocenter value)?  hypocenter,TResult? Function( QzssDcReportSeismicIntensity value)?  seismicIntensity,TResult? Function( QzssDcReportTsunami value)?  tsunami,TResult? Function( QzssDcReportNankaiTroughEarthquake value)?  nankaiTroughEarthquake,TResult? Function( QzssDcReportNorthwestPacificTsunami value)?  northwestPacificTsunami,TResult? Function( QzssDcReportFlood value)?  flood,TResult? Function( QzssDcReportMarine value)?  marine,TResult? Function( QzssDcReportWeather value)?  weather,TResult? Function( QzssDcReportVolcano value)?  volcano,TResult? Function( QzssDcReportAshFall value)?  ashFall,TResult? Function( QzssDcReportTyphoon value)?  typhoon,TResult? Function( QzssDcReportDcxNull value)?  dcxNull,TResult? Function( QzssDcReportDcxOutsideJapan value)?  dcxOutsideJapan,TResult? Function( QzssDcReportDcxLAlert value)?  dcxLAlert,TResult? Function( QzssDcReportDcxJAlert value)?  dcxJAlert,TResult? Function( QzssDcReportDcxMTInfo value)?  dcxMTInfo,TResult? Function( QzssDcReportDcxUnknown value)?  dcxUnknown,}){
final _that = this;
switch (_that) {
case QzssDcReportEarthquakeEarlyWarning() when earthquakeEarlyWarning != null:
return earthquakeEarlyWarning(_that);case QzssDcReportHypocenter() when hypocenter != null:
return hypocenter(_that);case QzssDcReportSeismicIntensity() when seismicIntensity != null:
return seismicIntensity(_that);case QzssDcReportTsunami() when tsunami != null:
return tsunami(_that);case QzssDcReportNankaiTroughEarthquake() when nankaiTroughEarthquake != null:
return nankaiTroughEarthquake(_that);case QzssDcReportNorthwestPacificTsunami() when northwestPacificTsunami != null:
return northwestPacificTsunami(_that);case QzssDcReportFlood() when flood != null:
return flood(_that);case QzssDcReportMarine() when marine != null:
return marine(_that);case QzssDcReportWeather() when weather != null:
return weather(_that);case QzssDcReportVolcano() when volcano != null:
return volcano(_that);case QzssDcReportAshFall() when ashFall != null:
return ashFall(_that);case QzssDcReportTyphoon() when typhoon != null:
return typhoon(_that);case QzssDcReportDcxNull() when dcxNull != null:
return dcxNull(_that);case QzssDcReportDcxOutsideJapan() when dcxOutsideJapan != null:
return dcxOutsideJapan(_that);case QzssDcReportDcxLAlert() when dcxLAlert != null:
return dcxLAlert(_that);case QzssDcReportDcxJAlert() when dcxJAlert != null:
return dcxJAlert(_that);case QzssDcReportDcxMTInfo() when dcxMTInfo != null:
return dcxMTInfo(_that);case QzssDcReportDcxUnknown() when dcxUnknown != null:
return dcxUnknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String? longPeriodGroundMotionLowerLimit,  int longPeriodGroundMotionLowerLimitRaw,  String? longPeriodGroundMotionUpperLimit,  int longPeriodGroundMotionUpperLimitRaw,  List<String> notificationsOnDisasterPrevention,  List<int> notificationsOnDisasterPreventionRaw,  DateTime occurrenceTimeOfEarthquake,  String depthOfHypocenter,  int depthOfHypocenterRaw,  String magnitude,  int magnitudeRaw,  bool assumptive,  String seismicEpicenter,  int seismicEpicenterRaw,  String seismicIntensityLowerLimit,  int seismicIntensityLowerLimitRaw,  String seismicIntensityUpperLimit,  int seismicIntensityUpperLimitRaw,  List<String> eewForecastRegions,  List<int> eewForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  earthquakeEarlyWarning,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> notificationsOnDisasterPrevention,  List<int> notificationsOnDisasterPreventionRaw,  DateTime occurrenceTimeOfEarthquake,  String depthOfHypocenter,  int depthOfHypocenterRaw,  String magnitude,  int magnitudeRaw,  String seismicEpicenter,  int seismicEpicenterRaw,  HypocenterCoordinates coordinatesOfHypocenter,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  hypocenter,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  DateTime occurrenceTimeOfEarthquake,  List<String> seismicIntensities,  List<int> seismicIntensitiesRaw,  List<String> prefectures,  List<int> prefecturesRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  seismicIntensity,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> notificationsOnDisasterPrevention,  List<int> notificationsOnDisasterPreventionRaw,  String tsunamiWarningCode,  int tsunamiWarningCodeRaw,  List<DateTime?> expectedTsunamiArrivalTimes,  List<String> tsunamiHeights,  List<int> tsunamiHeightsRaw,  List<String> tsunamiForecastRegions,  List<int> tsunamiForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  tsunami,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String informationSerialCode,  int informationSerialCodeRaw, @Uint8ListConverter()  Uint8List textInformation,  int pageNumber,  int totalPage,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  nankaiTroughEarthquake,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String tsunamigenicPotentialEn,  int tsunamigenicPotentialRaw,  List<DateTime?> expectedTsunamiArrivalTimes,  List<String> tsunamiHeightsEn,  List<int> tsunamiHeightsRaw,  List<String> coastalRegionsEn,  List<int> coastalRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  northwestPacificTsunami,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> floodWarningLevels,  List<int> floodWarningLevelsRaw,  List<String> floodForecastRegions,  List<int> floodForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  flood,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> marineWarningCodes,  List<int> marineWarningCodesRaw,  List<String> marineForecastRegions,  List<int> marineForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  marine,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String weatherWarningState,  int weatherWarningStateRaw,  List<String> weatherRelatedDisasterSubCategories,  List<int> weatherRelatedDisasterSubCategoriesRaw,  List<String> weatherForecastRegions,  List<int> weatherForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  weather,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  int ambiguityOfActivityTimeNo,  DateTime activityTime,  String volcanicWarningCode,  int volcanicWarningCodeRaw,  String volcanoName,  int volcanoNameRaw,  List<String> localGovernments,  List<int> localGovernmentsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  volcano,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  DateTime activityTime,  String ashFallWarningType,  int ashFallWarningTypeRaw,  String volcanoName,  int volcanoNameRaw,  List<int> expectedAshFallTimes,  List<String> ashFallWarningCodes,  List<int> ashFallWarningCodesRaw,  List<String> localGovernments,  List<int> localGovernmentsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  ashFall,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  DateTime referenceTime,  String referenceTimeType,  int referenceTimeTypeRaw,  int elapsedTimeFromReferenceTime,  String typhoonNumber,  int typhoonNumberRaw,  String typhoonScaleCategory,  int typhoonScaleCategoryRaw,  String typhoonIntensityCategory,  int typhoonIntensityCategoryRaw,  HypocenterCoordinates coordinatesOfTyphoon,  String centralPressure,  int centralPressureRaw,  String maximumWindSpeed,  int maximumWindSpeedRaw,  String maximumGustWindSpeed,  int maximumGustWindSpeedRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  typhoon,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxNull,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxOutsideJapan,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxLAlert,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxJAlert,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxMTInfo,TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxUnknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case QzssDcReportEarthquakeEarlyWarning() when earthquakeEarlyWarning != null:
return earthquakeEarlyWarning(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.longPeriodGroundMotionLowerLimit,_that.longPeriodGroundMotionLowerLimitRaw,_that.longPeriodGroundMotionUpperLimit,_that.longPeriodGroundMotionUpperLimitRaw,_that.notificationsOnDisasterPrevention,_that.notificationsOnDisasterPreventionRaw,_that.occurrenceTimeOfEarthquake,_that.depthOfHypocenter,_that.depthOfHypocenterRaw,_that.magnitude,_that.magnitudeRaw,_that.assumptive,_that.seismicEpicenter,_that.seismicEpicenterRaw,_that.seismicIntensityLowerLimit,_that.seismicIntensityLowerLimitRaw,_that.seismicIntensityUpperLimit,_that.seismicIntensityUpperLimitRaw,_that.eewForecastRegions,_that.eewForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportHypocenter() when hypocenter != null:
return hypocenter(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.notificationsOnDisasterPrevention,_that.notificationsOnDisasterPreventionRaw,_that.occurrenceTimeOfEarthquake,_that.depthOfHypocenter,_that.depthOfHypocenterRaw,_that.magnitude,_that.magnitudeRaw,_that.seismicEpicenter,_that.seismicEpicenterRaw,_that.coordinatesOfHypocenter,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportSeismicIntensity() when seismicIntensity != null:
return seismicIntensity(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.occurrenceTimeOfEarthquake,_that.seismicIntensities,_that.seismicIntensitiesRaw,_that.prefectures,_that.prefecturesRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportTsunami() when tsunami != null:
return tsunami(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.notificationsOnDisasterPrevention,_that.notificationsOnDisasterPreventionRaw,_that.tsunamiWarningCode,_that.tsunamiWarningCodeRaw,_that.expectedTsunamiArrivalTimes,_that.tsunamiHeights,_that.tsunamiHeightsRaw,_that.tsunamiForecastRegions,_that.tsunamiForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportNankaiTroughEarthquake() when nankaiTroughEarthquake != null:
return nankaiTroughEarthquake(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.informationSerialCode,_that.informationSerialCodeRaw,_that.textInformation,_that.pageNumber,_that.totalPage,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportNorthwestPacificTsunami() when northwestPacificTsunami != null:
return northwestPacificTsunami(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.tsunamigenicPotentialEn,_that.tsunamigenicPotentialRaw,_that.expectedTsunamiArrivalTimes,_that.tsunamiHeightsEn,_that.tsunamiHeightsRaw,_that.coastalRegionsEn,_that.coastalRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportFlood() when flood != null:
return flood(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.floodWarningLevels,_that.floodWarningLevelsRaw,_that.floodForecastRegions,_that.floodForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportMarine() when marine != null:
return marine(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.marineWarningCodes,_that.marineWarningCodesRaw,_that.marineForecastRegions,_that.marineForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportWeather() when weather != null:
return weather(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.weatherWarningState,_that.weatherWarningStateRaw,_that.weatherRelatedDisasterSubCategories,_that.weatherRelatedDisasterSubCategoriesRaw,_that.weatherForecastRegions,_that.weatherForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportVolcano() when volcano != null:
return volcano(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.ambiguityOfActivityTimeNo,_that.activityTime,_that.volcanicWarningCode,_that.volcanicWarningCodeRaw,_that.volcanoName,_that.volcanoNameRaw,_that.localGovernments,_that.localGovernmentsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportAshFall() when ashFall != null:
return ashFall(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.activityTime,_that.ashFallWarningType,_that.ashFallWarningTypeRaw,_that.volcanoName,_that.volcanoNameRaw,_that.expectedAshFallTimes,_that.ashFallWarningCodes,_that.ashFallWarningCodesRaw,_that.localGovernments,_that.localGovernmentsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportTyphoon() when typhoon != null:
return typhoon(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.referenceTime,_that.referenceTimeType,_that.referenceTimeTypeRaw,_that.elapsedTimeFromReferenceTime,_that.typhoonNumber,_that.typhoonNumberRaw,_that.typhoonScaleCategory,_that.typhoonScaleCategoryRaw,_that.typhoonIntensityCategory,_that.typhoonIntensityCategoryRaw,_that.coordinatesOfTyphoon,_that.centralPressure,_that.centralPressureRaw,_that.maximumWindSpeed,_that.maximumWindSpeedRaw,_that.maximumGustWindSpeed,_that.maximumGustWindSpeedRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxNull() when dcxNull != null:
return dcxNull(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxOutsideJapan() when dcxOutsideJapan != null:
return dcxOutsideJapan(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxLAlert() when dcxLAlert != null:
return dcxLAlert(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxJAlert() when dcxJAlert != null:
return dcxJAlert(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxMTInfo() when dcxMTInfo != null:
return dcxMTInfo(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxUnknown() when dcxUnknown != null:
return dcxUnknown(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String? longPeriodGroundMotionLowerLimit,  int longPeriodGroundMotionLowerLimitRaw,  String? longPeriodGroundMotionUpperLimit,  int longPeriodGroundMotionUpperLimitRaw,  List<String> notificationsOnDisasterPrevention,  List<int> notificationsOnDisasterPreventionRaw,  DateTime occurrenceTimeOfEarthquake,  String depthOfHypocenter,  int depthOfHypocenterRaw,  String magnitude,  int magnitudeRaw,  bool assumptive,  String seismicEpicenter,  int seismicEpicenterRaw,  String seismicIntensityLowerLimit,  int seismicIntensityLowerLimitRaw,  String seismicIntensityUpperLimit,  int seismicIntensityUpperLimitRaw,  List<String> eewForecastRegions,  List<int> eewForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  earthquakeEarlyWarning,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> notificationsOnDisasterPrevention,  List<int> notificationsOnDisasterPreventionRaw,  DateTime occurrenceTimeOfEarthquake,  String depthOfHypocenter,  int depthOfHypocenterRaw,  String magnitude,  int magnitudeRaw,  String seismicEpicenter,  int seismicEpicenterRaw,  HypocenterCoordinates coordinatesOfHypocenter,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  hypocenter,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  DateTime occurrenceTimeOfEarthquake,  List<String> seismicIntensities,  List<int> seismicIntensitiesRaw,  List<String> prefectures,  List<int> prefecturesRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  seismicIntensity,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> notificationsOnDisasterPrevention,  List<int> notificationsOnDisasterPreventionRaw,  String tsunamiWarningCode,  int tsunamiWarningCodeRaw,  List<DateTime?> expectedTsunamiArrivalTimes,  List<String> tsunamiHeights,  List<int> tsunamiHeightsRaw,  List<String> tsunamiForecastRegions,  List<int> tsunamiForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  tsunami,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String informationSerialCode,  int informationSerialCodeRaw, @Uint8ListConverter()  Uint8List textInformation,  int pageNumber,  int totalPage,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  nankaiTroughEarthquake,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String tsunamigenicPotentialEn,  int tsunamigenicPotentialRaw,  List<DateTime?> expectedTsunamiArrivalTimes,  List<String> tsunamiHeightsEn,  List<int> tsunamiHeightsRaw,  List<String> coastalRegionsEn,  List<int> coastalRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  northwestPacificTsunami,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> floodWarningLevels,  List<int> floodWarningLevelsRaw,  List<String> floodForecastRegions,  List<int> floodForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  flood,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> marineWarningCodes,  List<int> marineWarningCodesRaw,  List<String> marineForecastRegions,  List<int> marineForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  marine,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String weatherWarningState,  int weatherWarningStateRaw,  List<String> weatherRelatedDisasterSubCategories,  List<int> weatherRelatedDisasterSubCategoriesRaw,  List<String> weatherForecastRegions,  List<int> weatherForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  weather,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  int ambiguityOfActivityTimeNo,  DateTime activityTime,  String volcanicWarningCode,  int volcanicWarningCodeRaw,  String volcanoName,  int volcanoNameRaw,  List<String> localGovernments,  List<int> localGovernmentsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  volcano,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  DateTime activityTime,  String ashFallWarningType,  int ashFallWarningTypeRaw,  String volcanoName,  int volcanoNameRaw,  List<int> expectedAshFallTimes,  List<String> ashFallWarningCodes,  List<int> ashFallWarningCodesRaw,  List<String> localGovernments,  List<int> localGovernmentsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  ashFall,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  DateTime referenceTime,  String referenceTimeType,  int referenceTimeTypeRaw,  int elapsedTimeFromReferenceTime,  String typhoonNumber,  int typhoonNumberRaw,  String typhoonScaleCategory,  int typhoonScaleCategoryRaw,  String typhoonIntensityCategory,  int typhoonIntensityCategoryRaw,  HypocenterCoordinates coordinatesOfTyphoon,  String centralPressure,  int centralPressureRaw,  String maximumWindSpeed,  int maximumWindSpeedRaw,  String maximumGustWindSpeed,  int maximumGustWindSpeedRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  typhoon,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  dcxNull,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  dcxOutsideJapan,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  dcxLAlert,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  dcxJAlert,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  dcxMTInfo,required TResult Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)  dcxUnknown,}) {final _that = this;
switch (_that) {
case QzssDcReportEarthquakeEarlyWarning():
return earthquakeEarlyWarning(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.longPeriodGroundMotionLowerLimit,_that.longPeriodGroundMotionLowerLimitRaw,_that.longPeriodGroundMotionUpperLimit,_that.longPeriodGroundMotionUpperLimitRaw,_that.notificationsOnDisasterPrevention,_that.notificationsOnDisasterPreventionRaw,_that.occurrenceTimeOfEarthquake,_that.depthOfHypocenter,_that.depthOfHypocenterRaw,_that.magnitude,_that.magnitudeRaw,_that.assumptive,_that.seismicEpicenter,_that.seismicEpicenterRaw,_that.seismicIntensityLowerLimit,_that.seismicIntensityLowerLimitRaw,_that.seismicIntensityUpperLimit,_that.seismicIntensityUpperLimitRaw,_that.eewForecastRegions,_that.eewForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportHypocenter():
return hypocenter(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.notificationsOnDisasterPrevention,_that.notificationsOnDisasterPreventionRaw,_that.occurrenceTimeOfEarthquake,_that.depthOfHypocenter,_that.depthOfHypocenterRaw,_that.magnitude,_that.magnitudeRaw,_that.seismicEpicenter,_that.seismicEpicenterRaw,_that.coordinatesOfHypocenter,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportSeismicIntensity():
return seismicIntensity(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.occurrenceTimeOfEarthquake,_that.seismicIntensities,_that.seismicIntensitiesRaw,_that.prefectures,_that.prefecturesRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportTsunami():
return tsunami(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.notificationsOnDisasterPrevention,_that.notificationsOnDisasterPreventionRaw,_that.tsunamiWarningCode,_that.tsunamiWarningCodeRaw,_that.expectedTsunamiArrivalTimes,_that.tsunamiHeights,_that.tsunamiHeightsRaw,_that.tsunamiForecastRegions,_that.tsunamiForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportNankaiTroughEarthquake():
return nankaiTroughEarthquake(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.informationSerialCode,_that.informationSerialCodeRaw,_that.textInformation,_that.pageNumber,_that.totalPage,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportNorthwestPacificTsunami():
return northwestPacificTsunami(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.tsunamigenicPotentialEn,_that.tsunamigenicPotentialRaw,_that.expectedTsunamiArrivalTimes,_that.tsunamiHeightsEn,_that.tsunamiHeightsRaw,_that.coastalRegionsEn,_that.coastalRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportFlood():
return flood(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.floodWarningLevels,_that.floodWarningLevelsRaw,_that.floodForecastRegions,_that.floodForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportMarine():
return marine(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.marineWarningCodes,_that.marineWarningCodesRaw,_that.marineForecastRegions,_that.marineForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportWeather():
return weather(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.weatherWarningState,_that.weatherWarningStateRaw,_that.weatherRelatedDisasterSubCategories,_that.weatherRelatedDisasterSubCategoriesRaw,_that.weatherForecastRegions,_that.weatherForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportVolcano():
return volcano(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.ambiguityOfActivityTimeNo,_that.activityTime,_that.volcanicWarningCode,_that.volcanicWarningCodeRaw,_that.volcanoName,_that.volcanoNameRaw,_that.localGovernments,_that.localGovernmentsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportAshFall():
return ashFall(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.activityTime,_that.ashFallWarningType,_that.ashFallWarningTypeRaw,_that.volcanoName,_that.volcanoNameRaw,_that.expectedAshFallTimes,_that.ashFallWarningCodes,_that.ashFallWarningCodesRaw,_that.localGovernments,_that.localGovernmentsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportTyphoon():
return typhoon(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.referenceTime,_that.referenceTimeType,_that.referenceTimeTypeRaw,_that.elapsedTimeFromReferenceTime,_that.typhoonNumber,_that.typhoonNumberRaw,_that.typhoonScaleCategory,_that.typhoonScaleCategoryRaw,_that.typhoonIntensityCategory,_that.typhoonIntensityCategoryRaw,_that.coordinatesOfTyphoon,_that.centralPressure,_that.centralPressureRaw,_that.maximumWindSpeed,_that.maximumWindSpeedRaw,_that.maximumGustWindSpeed,_that.maximumGustWindSpeedRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxNull():
return dcxNull(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxOutsideJapan():
return dcxOutsideJapan(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxLAlert():
return dcxLAlert(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxJAlert():
return dcxJAlert(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxMTInfo():
return dcxMTInfo(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxUnknown():
return dcxUnknown(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String? longPeriodGroundMotionLowerLimit,  int longPeriodGroundMotionLowerLimitRaw,  String? longPeriodGroundMotionUpperLimit,  int longPeriodGroundMotionUpperLimitRaw,  List<String> notificationsOnDisasterPrevention,  List<int> notificationsOnDisasterPreventionRaw,  DateTime occurrenceTimeOfEarthquake,  String depthOfHypocenter,  int depthOfHypocenterRaw,  String magnitude,  int magnitudeRaw,  bool assumptive,  String seismicEpicenter,  int seismicEpicenterRaw,  String seismicIntensityLowerLimit,  int seismicIntensityLowerLimitRaw,  String seismicIntensityUpperLimit,  int seismicIntensityUpperLimitRaw,  List<String> eewForecastRegions,  List<int> eewForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  earthquakeEarlyWarning,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> notificationsOnDisasterPrevention,  List<int> notificationsOnDisasterPreventionRaw,  DateTime occurrenceTimeOfEarthquake,  String depthOfHypocenter,  int depthOfHypocenterRaw,  String magnitude,  int magnitudeRaw,  String seismicEpicenter,  int seismicEpicenterRaw,  HypocenterCoordinates coordinatesOfHypocenter,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  hypocenter,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  DateTime occurrenceTimeOfEarthquake,  List<String> seismicIntensities,  List<int> seismicIntensitiesRaw,  List<String> prefectures,  List<int> prefecturesRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  seismicIntensity,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> notificationsOnDisasterPrevention,  List<int> notificationsOnDisasterPreventionRaw,  String tsunamiWarningCode,  int tsunamiWarningCodeRaw,  List<DateTime?> expectedTsunamiArrivalTimes,  List<String> tsunamiHeights,  List<int> tsunamiHeightsRaw,  List<String> tsunamiForecastRegions,  List<int> tsunamiForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  tsunami,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String informationSerialCode,  int informationSerialCodeRaw, @Uint8ListConverter()  Uint8List textInformation,  int pageNumber,  int totalPage,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  nankaiTroughEarthquake,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String tsunamigenicPotentialEn,  int tsunamigenicPotentialRaw,  List<DateTime?> expectedTsunamiArrivalTimes,  List<String> tsunamiHeightsEn,  List<int> tsunamiHeightsRaw,  List<String> coastalRegionsEn,  List<int> coastalRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  northwestPacificTsunami,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> floodWarningLevels,  List<int> floodWarningLevelsRaw,  List<String> floodForecastRegions,  List<int> floodForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  flood,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  List<String> marineWarningCodes,  List<int> marineWarningCodesRaw,  List<String> marineForecastRegions,  List<int> marineForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  marine,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  String weatherWarningState,  int weatherWarningStateRaw,  List<String> weatherRelatedDisasterSubCategories,  List<int> weatherRelatedDisasterSubCategoriesRaw,  List<String> weatherForecastRegions,  List<int> weatherForecastRegionsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  weather,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  int ambiguityOfActivityTimeNo,  DateTime activityTime,  String volcanicWarningCode,  int volcanicWarningCodeRaw,  String volcanoName,  int volcanoNameRaw,  List<String> localGovernments,  List<int> localGovernmentsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  volcano,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  DateTime activityTime,  String ashFallWarningType,  int ashFallWarningTypeRaw,  String volcanoName,  int volcanoNameRaw,  List<int> expectedAshFallTimes,  List<String> ashFallWarningCodes,  List<int> ashFallWarningCodesRaw,  List<String> localGovernments,  List<int> localGovernmentsRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  ashFall,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  int version,  String reportClassification,  String reportClassificationEn,  int reportClassificationNo,  String disasterCategory,  String disasterCategoryEn,  int disasterCategoryNo,  DateTime reportTime,  String informationType,  String informationTypeEn,  int informationTypeNo,  DateTime referenceTime,  String referenceTimeType,  int referenceTimeTypeRaw,  int elapsedTimeFromReferenceTime,  String typhoonNumber,  int typhoonNumberRaw,  String typhoonScaleCategory,  int typhoonScaleCategoryRaw,  String typhoonIntensityCategory,  int typhoonIntensityCategoryRaw,  HypocenterCoordinates coordinatesOfTyphoon,  String centralPressure,  int centralPressureRaw,  String maximumWindSpeed,  int maximumWindSpeedRaw,  String maximumGustWindSpeed,  int maximumGustWindSpeedRaw,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  typhoon,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxNull,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxOutsideJapan,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxLAlert,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxJAlert,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxMTInfo,TResult? Function( String sentence, @Uint8ListConverter()  Uint8List message,  String nmea, @Uint8ListConverter()  Uint8List raw,  String preamble,  String messageType,  String dcxMessageType,  String? messageHeader,  int? satelliteId,  int? satellitePrn)?  dcxUnknown,}) {final _that = this;
switch (_that) {
case QzssDcReportEarthquakeEarlyWarning() when earthquakeEarlyWarning != null:
return earthquakeEarlyWarning(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.longPeriodGroundMotionLowerLimit,_that.longPeriodGroundMotionLowerLimitRaw,_that.longPeriodGroundMotionUpperLimit,_that.longPeriodGroundMotionUpperLimitRaw,_that.notificationsOnDisasterPrevention,_that.notificationsOnDisasterPreventionRaw,_that.occurrenceTimeOfEarthquake,_that.depthOfHypocenter,_that.depthOfHypocenterRaw,_that.magnitude,_that.magnitudeRaw,_that.assumptive,_that.seismicEpicenter,_that.seismicEpicenterRaw,_that.seismicIntensityLowerLimit,_that.seismicIntensityLowerLimitRaw,_that.seismicIntensityUpperLimit,_that.seismicIntensityUpperLimitRaw,_that.eewForecastRegions,_that.eewForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportHypocenter() when hypocenter != null:
return hypocenter(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.notificationsOnDisasterPrevention,_that.notificationsOnDisasterPreventionRaw,_that.occurrenceTimeOfEarthquake,_that.depthOfHypocenter,_that.depthOfHypocenterRaw,_that.magnitude,_that.magnitudeRaw,_that.seismicEpicenter,_that.seismicEpicenterRaw,_that.coordinatesOfHypocenter,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportSeismicIntensity() when seismicIntensity != null:
return seismicIntensity(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.occurrenceTimeOfEarthquake,_that.seismicIntensities,_that.seismicIntensitiesRaw,_that.prefectures,_that.prefecturesRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportTsunami() when tsunami != null:
return tsunami(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.notificationsOnDisasterPrevention,_that.notificationsOnDisasterPreventionRaw,_that.tsunamiWarningCode,_that.tsunamiWarningCodeRaw,_that.expectedTsunamiArrivalTimes,_that.tsunamiHeights,_that.tsunamiHeightsRaw,_that.tsunamiForecastRegions,_that.tsunamiForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportNankaiTroughEarthquake() when nankaiTroughEarthquake != null:
return nankaiTroughEarthquake(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.informationSerialCode,_that.informationSerialCodeRaw,_that.textInformation,_that.pageNumber,_that.totalPage,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportNorthwestPacificTsunami() when northwestPacificTsunami != null:
return northwestPacificTsunami(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.tsunamigenicPotentialEn,_that.tsunamigenicPotentialRaw,_that.expectedTsunamiArrivalTimes,_that.tsunamiHeightsEn,_that.tsunamiHeightsRaw,_that.coastalRegionsEn,_that.coastalRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportFlood() when flood != null:
return flood(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.floodWarningLevels,_that.floodWarningLevelsRaw,_that.floodForecastRegions,_that.floodForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportMarine() when marine != null:
return marine(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.marineWarningCodes,_that.marineWarningCodesRaw,_that.marineForecastRegions,_that.marineForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportWeather() when weather != null:
return weather(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.weatherWarningState,_that.weatherWarningStateRaw,_that.weatherRelatedDisasterSubCategories,_that.weatherRelatedDisasterSubCategoriesRaw,_that.weatherForecastRegions,_that.weatherForecastRegionsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportVolcano() when volcano != null:
return volcano(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.ambiguityOfActivityTimeNo,_that.activityTime,_that.volcanicWarningCode,_that.volcanicWarningCodeRaw,_that.volcanoName,_that.volcanoNameRaw,_that.localGovernments,_that.localGovernmentsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportAshFall() when ashFall != null:
return ashFall(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.activityTime,_that.ashFallWarningType,_that.ashFallWarningTypeRaw,_that.volcanoName,_that.volcanoNameRaw,_that.expectedAshFallTimes,_that.ashFallWarningCodes,_that.ashFallWarningCodesRaw,_that.localGovernments,_that.localGovernmentsRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportTyphoon() when typhoon != null:
return typhoon(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.version,_that.reportClassification,_that.reportClassificationEn,_that.reportClassificationNo,_that.disasterCategory,_that.disasterCategoryEn,_that.disasterCategoryNo,_that.reportTime,_that.informationType,_that.informationTypeEn,_that.informationTypeNo,_that.referenceTime,_that.referenceTimeType,_that.referenceTimeTypeRaw,_that.elapsedTimeFromReferenceTime,_that.typhoonNumber,_that.typhoonNumberRaw,_that.typhoonScaleCategory,_that.typhoonScaleCategoryRaw,_that.typhoonIntensityCategory,_that.typhoonIntensityCategoryRaw,_that.coordinatesOfTyphoon,_that.centralPressure,_that.centralPressureRaw,_that.maximumWindSpeed,_that.maximumWindSpeedRaw,_that.maximumGustWindSpeed,_that.maximumGustWindSpeedRaw,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxNull() when dcxNull != null:
return dcxNull(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxOutsideJapan() when dcxOutsideJapan != null:
return dcxOutsideJapan(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxLAlert() when dcxLAlert != null:
return dcxLAlert(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxJAlert() when dcxJAlert != null:
return dcxJAlert(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxMTInfo() when dcxMTInfo != null:
return dcxMTInfo(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case QzssDcReportDcxUnknown() when dcxUnknown != null:
return dcxUnknown(_that.sentence,_that.message,_that.nmea,_that.raw,_that.preamble,_that.messageType,_that.dcxMessageType,_that.messageHeader,_that.satelliteId,_that.satellitePrn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class QzssDcReportEarthquakeEarlyWarning extends QzssDcReport {
  const QzssDcReportEarthquakeEarlyWarning({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required this.longPeriodGroundMotionLowerLimit, required this.longPeriodGroundMotionLowerLimitRaw, required this.longPeriodGroundMotionUpperLimit, required this.longPeriodGroundMotionUpperLimitRaw, required  List<String> notificationsOnDisasterPrevention, required  List<int> notificationsOnDisasterPreventionRaw, required this.occurrenceTimeOfEarthquake, required this.depthOfHypocenter, required this.depthOfHypocenterRaw, required this.magnitude, required this.magnitudeRaw, required this.assumptive, required this.seismicEpicenter, required this.seismicEpicenterRaw, required this.seismicIntensityLowerLimit, required this.seismicIntensityLowerLimitRaw, required this.seismicIntensityUpperLimit, required this.seismicIntensityUpperLimitRaw, required  List<String> eewForecastRegions, required  List<int> eewForecastRegionsRaw, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): _notificationsOnDisasterPrevention = notificationsOnDisasterPrevention,_notificationsOnDisasterPreventionRaw = notificationsOnDisasterPreventionRaw,_eewForecastRegions = eewForecastRegions,_eewForecastRegionsRaw = eewForecastRegionsRaw,$type = $type ?? 'earthquakeEarlyWarning',super._();
  factory QzssDcReportEarthquakeEarlyWarning.fromJson(Map<String, dynamic> json) => _$QzssDcReportEarthquakeEarlyWarningFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  String? longPeriodGroundMotionLowerLimit;
 final  int longPeriodGroundMotionLowerLimitRaw;
 final  String? longPeriodGroundMotionUpperLimit;
 final  int longPeriodGroundMotionUpperLimitRaw;
 final  List<String> _notificationsOnDisasterPrevention;
 List<String> get notificationsOnDisasterPrevention {
  if (_notificationsOnDisasterPrevention is EqualUnmodifiableListView) return _notificationsOnDisasterPrevention;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationsOnDisasterPrevention);
}

 final  List<int> _notificationsOnDisasterPreventionRaw;
 List<int> get notificationsOnDisasterPreventionRaw {
  if (_notificationsOnDisasterPreventionRaw is EqualUnmodifiableListView) return _notificationsOnDisasterPreventionRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationsOnDisasterPreventionRaw);
}

 final  DateTime occurrenceTimeOfEarthquake;
 final  String depthOfHypocenter;
 final  int depthOfHypocenterRaw;
 final  String magnitude;
 final  int magnitudeRaw;
 final  bool assumptive;
 final  String seismicEpicenter;
 final  int seismicEpicenterRaw;
 final  String seismicIntensityLowerLimit;
 final  int seismicIntensityLowerLimitRaw;
 final  String seismicIntensityUpperLimit;
 final  int seismicIntensityUpperLimitRaw;
 final  List<String> _eewForecastRegions;
 List<String> get eewForecastRegions {
  if (_eewForecastRegions is EqualUnmodifiableListView) return _eewForecastRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewForecastRegions);
}

 final  List<int> _eewForecastRegionsRaw;
 List<int> get eewForecastRegionsRaw {
  if (_eewForecastRegionsRaw is EqualUnmodifiableListView) return _eewForecastRegionsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewForecastRegionsRaw);
}

@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportEarthquakeEarlyWarningCopyWith<QzssDcReportEarthquakeEarlyWarning> get copyWith => _$QzssDcReportEarthquakeEarlyWarningCopyWithImpl<QzssDcReportEarthquakeEarlyWarning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportEarthquakeEarlyWarningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportEarthquakeEarlyWarning&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&(identical(other.longPeriodGroundMotionLowerLimit, longPeriodGroundMotionLowerLimit) || other.longPeriodGroundMotionLowerLimit == longPeriodGroundMotionLowerLimit)&&(identical(other.longPeriodGroundMotionLowerLimitRaw, longPeriodGroundMotionLowerLimitRaw) || other.longPeriodGroundMotionLowerLimitRaw == longPeriodGroundMotionLowerLimitRaw)&&(identical(other.longPeriodGroundMotionUpperLimit, longPeriodGroundMotionUpperLimit) || other.longPeriodGroundMotionUpperLimit == longPeriodGroundMotionUpperLimit)&&(identical(other.longPeriodGroundMotionUpperLimitRaw, longPeriodGroundMotionUpperLimitRaw) || other.longPeriodGroundMotionUpperLimitRaw == longPeriodGroundMotionUpperLimitRaw)&&const DeepCollectionEquality().equals(other._notificationsOnDisasterPrevention, _notificationsOnDisasterPrevention)&&const DeepCollectionEquality().equals(other._notificationsOnDisasterPreventionRaw, _notificationsOnDisasterPreventionRaw)&&(identical(other.occurrenceTimeOfEarthquake, occurrenceTimeOfEarthquake) || other.occurrenceTimeOfEarthquake == occurrenceTimeOfEarthquake)&&(identical(other.depthOfHypocenter, depthOfHypocenter) || other.depthOfHypocenter == depthOfHypocenter)&&(identical(other.depthOfHypocenterRaw, depthOfHypocenterRaw) || other.depthOfHypocenterRaw == depthOfHypocenterRaw)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.magnitudeRaw, magnitudeRaw) || other.magnitudeRaw == magnitudeRaw)&&(identical(other.assumptive, assumptive) || other.assumptive == assumptive)&&(identical(other.seismicEpicenter, seismicEpicenter) || other.seismicEpicenter == seismicEpicenter)&&(identical(other.seismicEpicenterRaw, seismicEpicenterRaw) || other.seismicEpicenterRaw == seismicEpicenterRaw)&&(identical(other.seismicIntensityLowerLimit, seismicIntensityLowerLimit) || other.seismicIntensityLowerLimit == seismicIntensityLowerLimit)&&(identical(other.seismicIntensityLowerLimitRaw, seismicIntensityLowerLimitRaw) || other.seismicIntensityLowerLimitRaw == seismicIntensityLowerLimitRaw)&&(identical(other.seismicIntensityUpperLimit, seismicIntensityUpperLimit) || other.seismicIntensityUpperLimit == seismicIntensityUpperLimit)&&(identical(other.seismicIntensityUpperLimitRaw, seismicIntensityUpperLimitRaw) || other.seismicIntensityUpperLimitRaw == seismicIntensityUpperLimitRaw)&&const DeepCollectionEquality().equals(other._eewForecastRegions, _eewForecastRegions)&&const DeepCollectionEquality().equals(other._eewForecastRegionsRaw, _eewForecastRegionsRaw)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,longPeriodGroundMotionLowerLimit,longPeriodGroundMotionLowerLimitRaw,longPeriodGroundMotionUpperLimit,longPeriodGroundMotionUpperLimitRaw,const DeepCollectionEquality().hash(_notificationsOnDisasterPrevention),const DeepCollectionEquality().hash(_notificationsOnDisasterPreventionRaw),occurrenceTimeOfEarthquake,depthOfHypocenter,depthOfHypocenterRaw,magnitude,magnitudeRaw,assumptive,seismicEpicenter,seismicEpicenterRaw,seismicIntensityLowerLimit,seismicIntensityLowerLimitRaw,seismicIntensityUpperLimit,seismicIntensityUpperLimitRaw,const DeepCollectionEquality().hash(_eewForecastRegions),const DeepCollectionEquality().hash(_eewForecastRegionsRaw),messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.earthquakeEarlyWarning(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, longPeriodGroundMotionLowerLimit: $longPeriodGroundMotionLowerLimit, longPeriodGroundMotionLowerLimitRaw: $longPeriodGroundMotionLowerLimitRaw, longPeriodGroundMotionUpperLimit: $longPeriodGroundMotionUpperLimit, longPeriodGroundMotionUpperLimitRaw: $longPeriodGroundMotionUpperLimitRaw, notificationsOnDisasterPrevention: $notificationsOnDisasterPrevention, notificationsOnDisasterPreventionRaw: $notificationsOnDisasterPreventionRaw, occurrenceTimeOfEarthquake: $occurrenceTimeOfEarthquake, depthOfHypocenter: $depthOfHypocenter, depthOfHypocenterRaw: $depthOfHypocenterRaw, magnitude: $magnitude, magnitudeRaw: $magnitudeRaw, assumptive: $assumptive, seismicEpicenter: $seismicEpicenter, seismicEpicenterRaw: $seismicEpicenterRaw, seismicIntensityLowerLimit: $seismicIntensityLowerLimit, seismicIntensityLowerLimitRaw: $seismicIntensityLowerLimitRaw, seismicIntensityUpperLimit: $seismicIntensityUpperLimit, seismicIntensityUpperLimitRaw: $seismicIntensityUpperLimitRaw, eewForecastRegions: $eewForecastRegions, eewForecastRegionsRaw: $eewForecastRegionsRaw, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportEarthquakeEarlyWarningCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportEarthquakeEarlyWarningCopyWith(QzssDcReportEarthquakeEarlyWarning value, $Res Function(QzssDcReportEarthquakeEarlyWarning) _then) = _$QzssDcReportEarthquakeEarlyWarningCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, String? longPeriodGroundMotionLowerLimit, int longPeriodGroundMotionLowerLimitRaw, String? longPeriodGroundMotionUpperLimit, int longPeriodGroundMotionUpperLimitRaw, List<String> notificationsOnDisasterPrevention, List<int> notificationsOnDisasterPreventionRaw, DateTime occurrenceTimeOfEarthquake, String depthOfHypocenter, int depthOfHypocenterRaw, String magnitude, int magnitudeRaw, bool assumptive, String seismicEpicenter, int seismicEpicenterRaw, String seismicIntensityLowerLimit, int seismicIntensityLowerLimitRaw, String seismicIntensityUpperLimit, int seismicIntensityUpperLimitRaw, List<String> eewForecastRegions, List<int> eewForecastRegionsRaw, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportEarthquakeEarlyWarningCopyWithImpl<$Res>
    implements $QzssDcReportEarthquakeEarlyWarningCopyWith<$Res> {
  _$QzssDcReportEarthquakeEarlyWarningCopyWithImpl(this._self, this._then);

  final QzssDcReportEarthquakeEarlyWarning _self;
  final $Res Function(QzssDcReportEarthquakeEarlyWarning) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? longPeriodGroundMotionLowerLimit = freezed,Object? longPeriodGroundMotionLowerLimitRaw = null,Object? longPeriodGroundMotionUpperLimit = freezed,Object? longPeriodGroundMotionUpperLimitRaw = null,Object? notificationsOnDisasterPrevention = null,Object? notificationsOnDisasterPreventionRaw = null,Object? occurrenceTimeOfEarthquake = null,Object? depthOfHypocenter = null,Object? depthOfHypocenterRaw = null,Object? magnitude = null,Object? magnitudeRaw = null,Object? assumptive = null,Object? seismicEpicenter = null,Object? seismicEpicenterRaw = null,Object? seismicIntensityLowerLimit = null,Object? seismicIntensityLowerLimitRaw = null,Object? seismicIntensityUpperLimit = null,Object? seismicIntensityUpperLimitRaw = null,Object? eewForecastRegions = null,Object? eewForecastRegionsRaw = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportEarthquakeEarlyWarning(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,longPeriodGroundMotionLowerLimit: freezed == longPeriodGroundMotionLowerLimit ? _self.longPeriodGroundMotionLowerLimit : longPeriodGroundMotionLowerLimit // ignore: cast_nullable_to_non_nullable
as String?,longPeriodGroundMotionLowerLimitRaw: null == longPeriodGroundMotionLowerLimitRaw ? _self.longPeriodGroundMotionLowerLimitRaw : longPeriodGroundMotionLowerLimitRaw // ignore: cast_nullable_to_non_nullable
as int,longPeriodGroundMotionUpperLimit: freezed == longPeriodGroundMotionUpperLimit ? _self.longPeriodGroundMotionUpperLimit : longPeriodGroundMotionUpperLimit // ignore: cast_nullable_to_non_nullable
as String?,longPeriodGroundMotionUpperLimitRaw: null == longPeriodGroundMotionUpperLimitRaw ? _self.longPeriodGroundMotionUpperLimitRaw : longPeriodGroundMotionUpperLimitRaw // ignore: cast_nullable_to_non_nullable
as int,notificationsOnDisasterPrevention: null == notificationsOnDisasterPrevention ? _self._notificationsOnDisasterPrevention : notificationsOnDisasterPrevention // ignore: cast_nullable_to_non_nullable
as List<String>,notificationsOnDisasterPreventionRaw: null == notificationsOnDisasterPreventionRaw ? _self._notificationsOnDisasterPreventionRaw : notificationsOnDisasterPreventionRaw // ignore: cast_nullable_to_non_nullable
as List<int>,occurrenceTimeOfEarthquake: null == occurrenceTimeOfEarthquake ? _self.occurrenceTimeOfEarthquake : occurrenceTimeOfEarthquake // ignore: cast_nullable_to_non_nullable
as DateTime,depthOfHypocenter: null == depthOfHypocenter ? _self.depthOfHypocenter : depthOfHypocenter // ignore: cast_nullable_to_non_nullable
as String,depthOfHypocenterRaw: null == depthOfHypocenterRaw ? _self.depthOfHypocenterRaw : depthOfHypocenterRaw // ignore: cast_nullable_to_non_nullable
as int,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as String,magnitudeRaw: null == magnitudeRaw ? _self.magnitudeRaw : magnitudeRaw // ignore: cast_nullable_to_non_nullable
as int,assumptive: null == assumptive ? _self.assumptive : assumptive // ignore: cast_nullable_to_non_nullable
as bool,seismicEpicenter: null == seismicEpicenter ? _self.seismicEpicenter : seismicEpicenter // ignore: cast_nullable_to_non_nullable
as String,seismicEpicenterRaw: null == seismicEpicenterRaw ? _self.seismicEpicenterRaw : seismicEpicenterRaw // ignore: cast_nullable_to_non_nullable
as int,seismicIntensityLowerLimit: null == seismicIntensityLowerLimit ? _self.seismicIntensityLowerLimit : seismicIntensityLowerLimit // ignore: cast_nullable_to_non_nullable
as String,seismicIntensityLowerLimitRaw: null == seismicIntensityLowerLimitRaw ? _self.seismicIntensityLowerLimitRaw : seismicIntensityLowerLimitRaw // ignore: cast_nullable_to_non_nullable
as int,seismicIntensityUpperLimit: null == seismicIntensityUpperLimit ? _self.seismicIntensityUpperLimit : seismicIntensityUpperLimit // ignore: cast_nullable_to_non_nullable
as String,seismicIntensityUpperLimitRaw: null == seismicIntensityUpperLimitRaw ? _self.seismicIntensityUpperLimitRaw : seismicIntensityUpperLimitRaw // ignore: cast_nullable_to_non_nullable
as int,eewForecastRegions: null == eewForecastRegions ? _self._eewForecastRegions : eewForecastRegions // ignore: cast_nullable_to_non_nullable
as List<String>,eewForecastRegionsRaw: null == eewForecastRegionsRaw ? _self._eewForecastRegionsRaw : eewForecastRegionsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportHypocenter extends QzssDcReport {
  const QzssDcReportHypocenter({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required  List<String> notificationsOnDisasterPrevention, required  List<int> notificationsOnDisasterPreventionRaw, required this.occurrenceTimeOfEarthquake, required this.depthOfHypocenter, required this.depthOfHypocenterRaw, required this.magnitude, required this.magnitudeRaw, required this.seismicEpicenter, required this.seismicEpicenterRaw, required this.coordinatesOfHypocenter, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): _notificationsOnDisasterPrevention = notificationsOnDisasterPrevention,_notificationsOnDisasterPreventionRaw = notificationsOnDisasterPreventionRaw,$type = $type ?? 'hypocenter',super._();
  factory QzssDcReportHypocenter.fromJson(Map<String, dynamic> json) => _$QzssDcReportHypocenterFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  List<String> _notificationsOnDisasterPrevention;
 List<String> get notificationsOnDisasterPrevention {
  if (_notificationsOnDisasterPrevention is EqualUnmodifiableListView) return _notificationsOnDisasterPrevention;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationsOnDisasterPrevention);
}

 final  List<int> _notificationsOnDisasterPreventionRaw;
 List<int> get notificationsOnDisasterPreventionRaw {
  if (_notificationsOnDisasterPreventionRaw is EqualUnmodifiableListView) return _notificationsOnDisasterPreventionRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationsOnDisasterPreventionRaw);
}

 final  DateTime occurrenceTimeOfEarthquake;
 final  String depthOfHypocenter;
 final  int depthOfHypocenterRaw;
 final  String magnitude;
 final  int magnitudeRaw;
 final  String seismicEpicenter;
 final  int seismicEpicenterRaw;
 final  HypocenterCoordinates coordinatesOfHypocenter;
@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportHypocenterCopyWith<QzssDcReportHypocenter> get copyWith => _$QzssDcReportHypocenterCopyWithImpl<QzssDcReportHypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportHypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportHypocenter&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&const DeepCollectionEquality().equals(other._notificationsOnDisasterPrevention, _notificationsOnDisasterPrevention)&&const DeepCollectionEquality().equals(other._notificationsOnDisasterPreventionRaw, _notificationsOnDisasterPreventionRaw)&&(identical(other.occurrenceTimeOfEarthquake, occurrenceTimeOfEarthquake) || other.occurrenceTimeOfEarthquake == occurrenceTimeOfEarthquake)&&(identical(other.depthOfHypocenter, depthOfHypocenter) || other.depthOfHypocenter == depthOfHypocenter)&&(identical(other.depthOfHypocenterRaw, depthOfHypocenterRaw) || other.depthOfHypocenterRaw == depthOfHypocenterRaw)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.magnitudeRaw, magnitudeRaw) || other.magnitudeRaw == magnitudeRaw)&&(identical(other.seismicEpicenter, seismicEpicenter) || other.seismicEpicenter == seismicEpicenter)&&(identical(other.seismicEpicenterRaw, seismicEpicenterRaw) || other.seismicEpicenterRaw == seismicEpicenterRaw)&&(identical(other.coordinatesOfHypocenter, coordinatesOfHypocenter) || other.coordinatesOfHypocenter == coordinatesOfHypocenter)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,const DeepCollectionEquality().hash(_notificationsOnDisasterPrevention),const DeepCollectionEquality().hash(_notificationsOnDisasterPreventionRaw),occurrenceTimeOfEarthquake,depthOfHypocenter,depthOfHypocenterRaw,magnitude,magnitudeRaw,seismicEpicenter,seismicEpicenterRaw,coordinatesOfHypocenter,messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.hypocenter(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, notificationsOnDisasterPrevention: $notificationsOnDisasterPrevention, notificationsOnDisasterPreventionRaw: $notificationsOnDisasterPreventionRaw, occurrenceTimeOfEarthquake: $occurrenceTimeOfEarthquake, depthOfHypocenter: $depthOfHypocenter, depthOfHypocenterRaw: $depthOfHypocenterRaw, magnitude: $magnitude, magnitudeRaw: $magnitudeRaw, seismicEpicenter: $seismicEpicenter, seismicEpicenterRaw: $seismicEpicenterRaw, coordinatesOfHypocenter: $coordinatesOfHypocenter, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportHypocenterCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportHypocenterCopyWith(QzssDcReportHypocenter value, $Res Function(QzssDcReportHypocenter) _then) = _$QzssDcReportHypocenterCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, List<String> notificationsOnDisasterPrevention, List<int> notificationsOnDisasterPreventionRaw, DateTime occurrenceTimeOfEarthquake, String depthOfHypocenter, int depthOfHypocenterRaw, String magnitude, int magnitudeRaw, String seismicEpicenter, int seismicEpicenterRaw, HypocenterCoordinates coordinatesOfHypocenter, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportHypocenterCopyWithImpl<$Res>
    implements $QzssDcReportHypocenterCopyWith<$Res> {
  _$QzssDcReportHypocenterCopyWithImpl(this._self, this._then);

  final QzssDcReportHypocenter _self;
  final $Res Function(QzssDcReportHypocenter) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? notificationsOnDisasterPrevention = null,Object? notificationsOnDisasterPreventionRaw = null,Object? occurrenceTimeOfEarthquake = null,Object? depthOfHypocenter = null,Object? depthOfHypocenterRaw = null,Object? magnitude = null,Object? magnitudeRaw = null,Object? seismicEpicenter = null,Object? seismicEpicenterRaw = null,Object? coordinatesOfHypocenter = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportHypocenter(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,notificationsOnDisasterPrevention: null == notificationsOnDisasterPrevention ? _self._notificationsOnDisasterPrevention : notificationsOnDisasterPrevention // ignore: cast_nullable_to_non_nullable
as List<String>,notificationsOnDisasterPreventionRaw: null == notificationsOnDisasterPreventionRaw ? _self._notificationsOnDisasterPreventionRaw : notificationsOnDisasterPreventionRaw // ignore: cast_nullable_to_non_nullable
as List<int>,occurrenceTimeOfEarthquake: null == occurrenceTimeOfEarthquake ? _self.occurrenceTimeOfEarthquake : occurrenceTimeOfEarthquake // ignore: cast_nullable_to_non_nullable
as DateTime,depthOfHypocenter: null == depthOfHypocenter ? _self.depthOfHypocenter : depthOfHypocenter // ignore: cast_nullable_to_non_nullable
as String,depthOfHypocenterRaw: null == depthOfHypocenterRaw ? _self.depthOfHypocenterRaw : depthOfHypocenterRaw // ignore: cast_nullable_to_non_nullable
as int,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as String,magnitudeRaw: null == magnitudeRaw ? _self.magnitudeRaw : magnitudeRaw // ignore: cast_nullable_to_non_nullable
as int,seismicEpicenter: null == seismicEpicenter ? _self.seismicEpicenter : seismicEpicenter // ignore: cast_nullable_to_non_nullable
as String,seismicEpicenterRaw: null == seismicEpicenterRaw ? _self.seismicEpicenterRaw : seismicEpicenterRaw // ignore: cast_nullable_to_non_nullable
as int,coordinatesOfHypocenter: null == coordinatesOfHypocenter ? _self.coordinatesOfHypocenter : coordinatesOfHypocenter // ignore: cast_nullable_to_non_nullable
as HypocenterCoordinates,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportSeismicIntensity extends QzssDcReport {
  const QzssDcReportSeismicIntensity({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required this.occurrenceTimeOfEarthquake, required  List<String> seismicIntensities, required  List<int> seismicIntensitiesRaw, required  List<String> prefectures, required  List<int> prefecturesRaw, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): _seismicIntensities = seismicIntensities,_seismicIntensitiesRaw = seismicIntensitiesRaw,_prefectures = prefectures,_prefecturesRaw = prefecturesRaw,$type = $type ?? 'seismicIntensity',super._();
  factory QzssDcReportSeismicIntensity.fromJson(Map<String, dynamic> json) => _$QzssDcReportSeismicIntensityFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  DateTime occurrenceTimeOfEarthquake;
 final  List<String> _seismicIntensities;
 List<String> get seismicIntensities {
  if (_seismicIntensities is EqualUnmodifiableListView) return _seismicIntensities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seismicIntensities);
}

 final  List<int> _seismicIntensitiesRaw;
 List<int> get seismicIntensitiesRaw {
  if (_seismicIntensitiesRaw is EqualUnmodifiableListView) return _seismicIntensitiesRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seismicIntensitiesRaw);
}

 final  List<String> _prefectures;
 List<String> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}

 final  List<int> _prefecturesRaw;
 List<int> get prefecturesRaw {
  if (_prefecturesRaw is EqualUnmodifiableListView) return _prefecturesRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefecturesRaw);
}

@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportSeismicIntensityCopyWith<QzssDcReportSeismicIntensity> get copyWith => _$QzssDcReportSeismicIntensityCopyWithImpl<QzssDcReportSeismicIntensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportSeismicIntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportSeismicIntensity&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&(identical(other.occurrenceTimeOfEarthquake, occurrenceTimeOfEarthquake) || other.occurrenceTimeOfEarthquake == occurrenceTimeOfEarthquake)&&const DeepCollectionEquality().equals(other._seismicIntensities, _seismicIntensities)&&const DeepCollectionEquality().equals(other._seismicIntensitiesRaw, _seismicIntensitiesRaw)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures)&&const DeepCollectionEquality().equals(other._prefecturesRaw, _prefecturesRaw)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,occurrenceTimeOfEarthquake,const DeepCollectionEquality().hash(_seismicIntensities),const DeepCollectionEquality().hash(_seismicIntensitiesRaw),const DeepCollectionEquality().hash(_prefectures),const DeepCollectionEquality().hash(_prefecturesRaw),messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.seismicIntensity(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, occurrenceTimeOfEarthquake: $occurrenceTimeOfEarthquake, seismicIntensities: $seismicIntensities, seismicIntensitiesRaw: $seismicIntensitiesRaw, prefectures: $prefectures, prefecturesRaw: $prefecturesRaw, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportSeismicIntensityCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportSeismicIntensityCopyWith(QzssDcReportSeismicIntensity value, $Res Function(QzssDcReportSeismicIntensity) _then) = _$QzssDcReportSeismicIntensityCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, DateTime occurrenceTimeOfEarthquake, List<String> seismicIntensities, List<int> seismicIntensitiesRaw, List<String> prefectures, List<int> prefecturesRaw, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportSeismicIntensityCopyWithImpl<$Res>
    implements $QzssDcReportSeismicIntensityCopyWith<$Res> {
  _$QzssDcReportSeismicIntensityCopyWithImpl(this._self, this._then);

  final QzssDcReportSeismicIntensity _self;
  final $Res Function(QzssDcReportSeismicIntensity) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? occurrenceTimeOfEarthquake = null,Object? seismicIntensities = null,Object? seismicIntensitiesRaw = null,Object? prefectures = null,Object? prefecturesRaw = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportSeismicIntensity(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,occurrenceTimeOfEarthquake: null == occurrenceTimeOfEarthquake ? _self.occurrenceTimeOfEarthquake : occurrenceTimeOfEarthquake // ignore: cast_nullable_to_non_nullable
as DateTime,seismicIntensities: null == seismicIntensities ? _self._seismicIntensities : seismicIntensities // ignore: cast_nullable_to_non_nullable
as List<String>,seismicIntensitiesRaw: null == seismicIntensitiesRaw ? _self._seismicIntensitiesRaw : seismicIntensitiesRaw // ignore: cast_nullable_to_non_nullable
as List<int>,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<String>,prefecturesRaw: null == prefecturesRaw ? _self._prefecturesRaw : prefecturesRaw // ignore: cast_nullable_to_non_nullable
as List<int>,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportTsunami extends QzssDcReport {
  const QzssDcReportTsunami({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required  List<String> notificationsOnDisasterPrevention, required  List<int> notificationsOnDisasterPreventionRaw, required this.tsunamiWarningCode, required this.tsunamiWarningCodeRaw, required  List<DateTime?> expectedTsunamiArrivalTimes, required  List<String> tsunamiHeights, required  List<int> tsunamiHeightsRaw, required  List<String> tsunamiForecastRegions, required  List<int> tsunamiForecastRegionsRaw, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): _notificationsOnDisasterPrevention = notificationsOnDisasterPrevention,_notificationsOnDisasterPreventionRaw = notificationsOnDisasterPreventionRaw,_expectedTsunamiArrivalTimes = expectedTsunamiArrivalTimes,_tsunamiHeights = tsunamiHeights,_tsunamiHeightsRaw = tsunamiHeightsRaw,_tsunamiForecastRegions = tsunamiForecastRegions,_tsunamiForecastRegionsRaw = tsunamiForecastRegionsRaw,$type = $type ?? 'tsunami',super._();
  factory QzssDcReportTsunami.fromJson(Map<String, dynamic> json) => _$QzssDcReportTsunamiFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  List<String> _notificationsOnDisasterPrevention;
 List<String> get notificationsOnDisasterPrevention {
  if (_notificationsOnDisasterPrevention is EqualUnmodifiableListView) return _notificationsOnDisasterPrevention;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationsOnDisasterPrevention);
}

 final  List<int> _notificationsOnDisasterPreventionRaw;
 List<int> get notificationsOnDisasterPreventionRaw {
  if (_notificationsOnDisasterPreventionRaw is EqualUnmodifiableListView) return _notificationsOnDisasterPreventionRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationsOnDisasterPreventionRaw);
}

 final  String tsunamiWarningCode;
 final  int tsunamiWarningCodeRaw;
 final  List<DateTime?> _expectedTsunamiArrivalTimes;
 List<DateTime?> get expectedTsunamiArrivalTimes {
  if (_expectedTsunamiArrivalTimes is EqualUnmodifiableListView) return _expectedTsunamiArrivalTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expectedTsunamiArrivalTimes);
}

 final  List<String> _tsunamiHeights;
 List<String> get tsunamiHeights {
  if (_tsunamiHeights is EqualUnmodifiableListView) return _tsunamiHeights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tsunamiHeights);
}

 final  List<int> _tsunamiHeightsRaw;
 List<int> get tsunamiHeightsRaw {
  if (_tsunamiHeightsRaw is EqualUnmodifiableListView) return _tsunamiHeightsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tsunamiHeightsRaw);
}

 final  List<String> _tsunamiForecastRegions;
 List<String> get tsunamiForecastRegions {
  if (_tsunamiForecastRegions is EqualUnmodifiableListView) return _tsunamiForecastRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tsunamiForecastRegions);
}

 final  List<int> _tsunamiForecastRegionsRaw;
 List<int> get tsunamiForecastRegionsRaw {
  if (_tsunamiForecastRegionsRaw is EqualUnmodifiableListView) return _tsunamiForecastRegionsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tsunamiForecastRegionsRaw);
}

@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportTsunamiCopyWith<QzssDcReportTsunami> get copyWith => _$QzssDcReportTsunamiCopyWithImpl<QzssDcReportTsunami>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportTsunamiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportTsunami&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&const DeepCollectionEquality().equals(other._notificationsOnDisasterPrevention, _notificationsOnDisasterPrevention)&&const DeepCollectionEquality().equals(other._notificationsOnDisasterPreventionRaw, _notificationsOnDisasterPreventionRaw)&&(identical(other.tsunamiWarningCode, tsunamiWarningCode) || other.tsunamiWarningCode == tsunamiWarningCode)&&(identical(other.tsunamiWarningCodeRaw, tsunamiWarningCodeRaw) || other.tsunamiWarningCodeRaw == tsunamiWarningCodeRaw)&&const DeepCollectionEquality().equals(other._expectedTsunamiArrivalTimes, _expectedTsunamiArrivalTimes)&&const DeepCollectionEquality().equals(other._tsunamiHeights, _tsunamiHeights)&&const DeepCollectionEquality().equals(other._tsunamiHeightsRaw, _tsunamiHeightsRaw)&&const DeepCollectionEquality().equals(other._tsunamiForecastRegions, _tsunamiForecastRegions)&&const DeepCollectionEquality().equals(other._tsunamiForecastRegionsRaw, _tsunamiForecastRegionsRaw)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,const DeepCollectionEquality().hash(_notificationsOnDisasterPrevention),const DeepCollectionEquality().hash(_notificationsOnDisasterPreventionRaw),tsunamiWarningCode,tsunamiWarningCodeRaw,const DeepCollectionEquality().hash(_expectedTsunamiArrivalTimes),const DeepCollectionEquality().hash(_tsunamiHeights),const DeepCollectionEquality().hash(_tsunamiHeightsRaw),const DeepCollectionEquality().hash(_tsunamiForecastRegions),const DeepCollectionEquality().hash(_tsunamiForecastRegionsRaw),messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.tsunami(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, notificationsOnDisasterPrevention: $notificationsOnDisasterPrevention, notificationsOnDisasterPreventionRaw: $notificationsOnDisasterPreventionRaw, tsunamiWarningCode: $tsunamiWarningCode, tsunamiWarningCodeRaw: $tsunamiWarningCodeRaw, expectedTsunamiArrivalTimes: $expectedTsunamiArrivalTimes, tsunamiHeights: $tsunamiHeights, tsunamiHeightsRaw: $tsunamiHeightsRaw, tsunamiForecastRegions: $tsunamiForecastRegions, tsunamiForecastRegionsRaw: $tsunamiForecastRegionsRaw, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportTsunamiCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportTsunamiCopyWith(QzssDcReportTsunami value, $Res Function(QzssDcReportTsunami) _then) = _$QzssDcReportTsunamiCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, List<String> notificationsOnDisasterPrevention, List<int> notificationsOnDisasterPreventionRaw, String tsunamiWarningCode, int tsunamiWarningCodeRaw, List<DateTime?> expectedTsunamiArrivalTimes, List<String> tsunamiHeights, List<int> tsunamiHeightsRaw, List<String> tsunamiForecastRegions, List<int> tsunamiForecastRegionsRaw, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportTsunamiCopyWithImpl<$Res>
    implements $QzssDcReportTsunamiCopyWith<$Res> {
  _$QzssDcReportTsunamiCopyWithImpl(this._self, this._then);

  final QzssDcReportTsunami _self;
  final $Res Function(QzssDcReportTsunami) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? notificationsOnDisasterPrevention = null,Object? notificationsOnDisasterPreventionRaw = null,Object? tsunamiWarningCode = null,Object? tsunamiWarningCodeRaw = null,Object? expectedTsunamiArrivalTimes = null,Object? tsunamiHeights = null,Object? tsunamiHeightsRaw = null,Object? tsunamiForecastRegions = null,Object? tsunamiForecastRegionsRaw = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportTsunami(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,notificationsOnDisasterPrevention: null == notificationsOnDisasterPrevention ? _self._notificationsOnDisasterPrevention : notificationsOnDisasterPrevention // ignore: cast_nullable_to_non_nullable
as List<String>,notificationsOnDisasterPreventionRaw: null == notificationsOnDisasterPreventionRaw ? _self._notificationsOnDisasterPreventionRaw : notificationsOnDisasterPreventionRaw // ignore: cast_nullable_to_non_nullable
as List<int>,tsunamiWarningCode: null == tsunamiWarningCode ? _self.tsunamiWarningCode : tsunamiWarningCode // ignore: cast_nullable_to_non_nullable
as String,tsunamiWarningCodeRaw: null == tsunamiWarningCodeRaw ? _self.tsunamiWarningCodeRaw : tsunamiWarningCodeRaw // ignore: cast_nullable_to_non_nullable
as int,expectedTsunamiArrivalTimes: null == expectedTsunamiArrivalTimes ? _self._expectedTsunamiArrivalTimes : expectedTsunamiArrivalTimes // ignore: cast_nullable_to_non_nullable
as List<DateTime?>,tsunamiHeights: null == tsunamiHeights ? _self._tsunamiHeights : tsunamiHeights // ignore: cast_nullable_to_non_nullable
as List<String>,tsunamiHeightsRaw: null == tsunamiHeightsRaw ? _self._tsunamiHeightsRaw : tsunamiHeightsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,tsunamiForecastRegions: null == tsunamiForecastRegions ? _self._tsunamiForecastRegions : tsunamiForecastRegions // ignore: cast_nullable_to_non_nullable
as List<String>,tsunamiForecastRegionsRaw: null == tsunamiForecastRegionsRaw ? _self._tsunamiForecastRegionsRaw : tsunamiForecastRegionsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportNankaiTroughEarthquake extends QzssDcReport {
  const QzssDcReportNankaiTroughEarthquake({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required this.informationSerialCode, required this.informationSerialCodeRaw, @Uint8ListConverter() required this.textInformation, required this.pageNumber, required this.totalPage, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): $type = $type ?? 'nankaiTroughEarthquake',super._();
  factory QzssDcReportNankaiTroughEarthquake.fromJson(Map<String, dynamic> json) => _$QzssDcReportNankaiTroughEarthquakeFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  String informationSerialCode;
 final  int informationSerialCodeRaw;
@Uint8ListConverter() final  Uint8List textInformation;
 final  int pageNumber;
 final  int totalPage;
@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportNankaiTroughEarthquakeCopyWith<QzssDcReportNankaiTroughEarthquake> get copyWith => _$QzssDcReportNankaiTroughEarthquakeCopyWithImpl<QzssDcReportNankaiTroughEarthquake>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportNankaiTroughEarthquakeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportNankaiTroughEarthquake&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&(identical(other.informationSerialCode, informationSerialCode) || other.informationSerialCode == informationSerialCode)&&(identical(other.informationSerialCodeRaw, informationSerialCodeRaw) || other.informationSerialCodeRaw == informationSerialCodeRaw)&&const DeepCollectionEquality().equals(other.textInformation, textInformation)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.totalPage, totalPage) || other.totalPage == totalPage)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,informationSerialCode,informationSerialCodeRaw,const DeepCollectionEquality().hash(textInformation),pageNumber,totalPage,messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.nankaiTroughEarthquake(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, informationSerialCode: $informationSerialCode, informationSerialCodeRaw: $informationSerialCodeRaw, textInformation: $textInformation, pageNumber: $pageNumber, totalPage: $totalPage, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportNankaiTroughEarthquakeCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportNankaiTroughEarthquakeCopyWith(QzssDcReportNankaiTroughEarthquake value, $Res Function(QzssDcReportNankaiTroughEarthquake) _then) = _$QzssDcReportNankaiTroughEarthquakeCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, String informationSerialCode, int informationSerialCodeRaw,@Uint8ListConverter() Uint8List textInformation, int pageNumber, int totalPage, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportNankaiTroughEarthquakeCopyWithImpl<$Res>
    implements $QzssDcReportNankaiTroughEarthquakeCopyWith<$Res> {
  _$QzssDcReportNankaiTroughEarthquakeCopyWithImpl(this._self, this._then);

  final QzssDcReportNankaiTroughEarthquake _self;
  final $Res Function(QzssDcReportNankaiTroughEarthquake) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? informationSerialCode = null,Object? informationSerialCodeRaw = null,Object? textInformation = null,Object? pageNumber = null,Object? totalPage = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportNankaiTroughEarthquake(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,informationSerialCode: null == informationSerialCode ? _self.informationSerialCode : informationSerialCode // ignore: cast_nullable_to_non_nullable
as String,informationSerialCodeRaw: null == informationSerialCodeRaw ? _self.informationSerialCodeRaw : informationSerialCodeRaw // ignore: cast_nullable_to_non_nullable
as int,textInformation: null == textInformation ? _self.textInformation : textInformation // ignore: cast_nullable_to_non_nullable
as Uint8List,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,totalPage: null == totalPage ? _self.totalPage : totalPage // ignore: cast_nullable_to_non_nullable
as int,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportNorthwestPacificTsunami extends QzssDcReport {
  const QzssDcReportNorthwestPacificTsunami({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required this.tsunamigenicPotentialEn, required this.tsunamigenicPotentialRaw, required  List<DateTime?> expectedTsunamiArrivalTimes, required  List<String> tsunamiHeightsEn, required  List<int> tsunamiHeightsRaw, required  List<String> coastalRegionsEn, required  List<int> coastalRegionsRaw, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): _expectedTsunamiArrivalTimes = expectedTsunamiArrivalTimes,_tsunamiHeightsEn = tsunamiHeightsEn,_tsunamiHeightsRaw = tsunamiHeightsRaw,_coastalRegionsEn = coastalRegionsEn,_coastalRegionsRaw = coastalRegionsRaw,$type = $type ?? 'northwestPacificTsunami',super._();
  factory QzssDcReportNorthwestPacificTsunami.fromJson(Map<String, dynamic> json) => _$QzssDcReportNorthwestPacificTsunamiFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  String tsunamigenicPotentialEn;
 final  int tsunamigenicPotentialRaw;
 final  List<DateTime?> _expectedTsunamiArrivalTimes;
 List<DateTime?> get expectedTsunamiArrivalTimes {
  if (_expectedTsunamiArrivalTimes is EqualUnmodifiableListView) return _expectedTsunamiArrivalTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expectedTsunamiArrivalTimes);
}

 final  List<String> _tsunamiHeightsEn;
 List<String> get tsunamiHeightsEn {
  if (_tsunamiHeightsEn is EqualUnmodifiableListView) return _tsunamiHeightsEn;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tsunamiHeightsEn);
}

 final  List<int> _tsunamiHeightsRaw;
 List<int> get tsunamiHeightsRaw {
  if (_tsunamiHeightsRaw is EqualUnmodifiableListView) return _tsunamiHeightsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tsunamiHeightsRaw);
}

 final  List<String> _coastalRegionsEn;
 List<String> get coastalRegionsEn {
  if (_coastalRegionsEn is EqualUnmodifiableListView) return _coastalRegionsEn;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coastalRegionsEn);
}

 final  List<int> _coastalRegionsRaw;
 List<int> get coastalRegionsRaw {
  if (_coastalRegionsRaw is EqualUnmodifiableListView) return _coastalRegionsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coastalRegionsRaw);
}

@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportNorthwestPacificTsunamiCopyWith<QzssDcReportNorthwestPacificTsunami> get copyWith => _$QzssDcReportNorthwestPacificTsunamiCopyWithImpl<QzssDcReportNorthwestPacificTsunami>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportNorthwestPacificTsunamiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportNorthwestPacificTsunami&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&(identical(other.tsunamigenicPotentialEn, tsunamigenicPotentialEn) || other.tsunamigenicPotentialEn == tsunamigenicPotentialEn)&&(identical(other.tsunamigenicPotentialRaw, tsunamigenicPotentialRaw) || other.tsunamigenicPotentialRaw == tsunamigenicPotentialRaw)&&const DeepCollectionEquality().equals(other._expectedTsunamiArrivalTimes, _expectedTsunamiArrivalTimes)&&const DeepCollectionEquality().equals(other._tsunamiHeightsEn, _tsunamiHeightsEn)&&const DeepCollectionEquality().equals(other._tsunamiHeightsRaw, _tsunamiHeightsRaw)&&const DeepCollectionEquality().equals(other._coastalRegionsEn, _coastalRegionsEn)&&const DeepCollectionEquality().equals(other._coastalRegionsRaw, _coastalRegionsRaw)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,tsunamigenicPotentialEn,tsunamigenicPotentialRaw,const DeepCollectionEquality().hash(_expectedTsunamiArrivalTimes),const DeepCollectionEquality().hash(_tsunamiHeightsEn),const DeepCollectionEquality().hash(_tsunamiHeightsRaw),const DeepCollectionEquality().hash(_coastalRegionsEn),const DeepCollectionEquality().hash(_coastalRegionsRaw),messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.northwestPacificTsunami(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, tsunamigenicPotentialEn: $tsunamigenicPotentialEn, tsunamigenicPotentialRaw: $tsunamigenicPotentialRaw, expectedTsunamiArrivalTimes: $expectedTsunamiArrivalTimes, tsunamiHeightsEn: $tsunamiHeightsEn, tsunamiHeightsRaw: $tsunamiHeightsRaw, coastalRegionsEn: $coastalRegionsEn, coastalRegionsRaw: $coastalRegionsRaw, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportNorthwestPacificTsunamiCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportNorthwestPacificTsunamiCopyWith(QzssDcReportNorthwestPacificTsunami value, $Res Function(QzssDcReportNorthwestPacificTsunami) _then) = _$QzssDcReportNorthwestPacificTsunamiCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, String tsunamigenicPotentialEn, int tsunamigenicPotentialRaw, List<DateTime?> expectedTsunamiArrivalTimes, List<String> tsunamiHeightsEn, List<int> tsunamiHeightsRaw, List<String> coastalRegionsEn, List<int> coastalRegionsRaw, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportNorthwestPacificTsunamiCopyWithImpl<$Res>
    implements $QzssDcReportNorthwestPacificTsunamiCopyWith<$Res> {
  _$QzssDcReportNorthwestPacificTsunamiCopyWithImpl(this._self, this._then);

  final QzssDcReportNorthwestPacificTsunami _self;
  final $Res Function(QzssDcReportNorthwestPacificTsunami) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? tsunamigenicPotentialEn = null,Object? tsunamigenicPotentialRaw = null,Object? expectedTsunamiArrivalTimes = null,Object? tsunamiHeightsEn = null,Object? tsunamiHeightsRaw = null,Object? coastalRegionsEn = null,Object? coastalRegionsRaw = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportNorthwestPacificTsunami(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,tsunamigenicPotentialEn: null == tsunamigenicPotentialEn ? _self.tsunamigenicPotentialEn : tsunamigenicPotentialEn // ignore: cast_nullable_to_non_nullable
as String,tsunamigenicPotentialRaw: null == tsunamigenicPotentialRaw ? _self.tsunamigenicPotentialRaw : tsunamigenicPotentialRaw // ignore: cast_nullable_to_non_nullable
as int,expectedTsunamiArrivalTimes: null == expectedTsunamiArrivalTimes ? _self._expectedTsunamiArrivalTimes : expectedTsunamiArrivalTimes // ignore: cast_nullable_to_non_nullable
as List<DateTime?>,tsunamiHeightsEn: null == tsunamiHeightsEn ? _self._tsunamiHeightsEn : tsunamiHeightsEn // ignore: cast_nullable_to_non_nullable
as List<String>,tsunamiHeightsRaw: null == tsunamiHeightsRaw ? _self._tsunamiHeightsRaw : tsunamiHeightsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,coastalRegionsEn: null == coastalRegionsEn ? _self._coastalRegionsEn : coastalRegionsEn // ignore: cast_nullable_to_non_nullable
as List<String>,coastalRegionsRaw: null == coastalRegionsRaw ? _self._coastalRegionsRaw : coastalRegionsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportFlood extends QzssDcReport {
  const QzssDcReportFlood({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required  List<String> floodWarningLevels, required  List<int> floodWarningLevelsRaw, required  List<String> floodForecastRegions, required  List<int> floodForecastRegionsRaw, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): _floodWarningLevels = floodWarningLevels,_floodWarningLevelsRaw = floodWarningLevelsRaw,_floodForecastRegions = floodForecastRegions,_floodForecastRegionsRaw = floodForecastRegionsRaw,$type = $type ?? 'flood',super._();
  factory QzssDcReportFlood.fromJson(Map<String, dynamic> json) => _$QzssDcReportFloodFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  List<String> _floodWarningLevels;
 List<String> get floodWarningLevels {
  if (_floodWarningLevels is EqualUnmodifiableListView) return _floodWarningLevels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_floodWarningLevels);
}

 final  List<int> _floodWarningLevelsRaw;
 List<int> get floodWarningLevelsRaw {
  if (_floodWarningLevelsRaw is EqualUnmodifiableListView) return _floodWarningLevelsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_floodWarningLevelsRaw);
}

 final  List<String> _floodForecastRegions;
 List<String> get floodForecastRegions {
  if (_floodForecastRegions is EqualUnmodifiableListView) return _floodForecastRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_floodForecastRegions);
}

 final  List<int> _floodForecastRegionsRaw;
 List<int> get floodForecastRegionsRaw {
  if (_floodForecastRegionsRaw is EqualUnmodifiableListView) return _floodForecastRegionsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_floodForecastRegionsRaw);
}

@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportFloodCopyWith<QzssDcReportFlood> get copyWith => _$QzssDcReportFloodCopyWithImpl<QzssDcReportFlood>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportFloodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportFlood&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&const DeepCollectionEquality().equals(other._floodWarningLevels, _floodWarningLevels)&&const DeepCollectionEquality().equals(other._floodWarningLevelsRaw, _floodWarningLevelsRaw)&&const DeepCollectionEquality().equals(other._floodForecastRegions, _floodForecastRegions)&&const DeepCollectionEquality().equals(other._floodForecastRegionsRaw, _floodForecastRegionsRaw)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,const DeepCollectionEquality().hash(_floodWarningLevels),const DeepCollectionEquality().hash(_floodWarningLevelsRaw),const DeepCollectionEquality().hash(_floodForecastRegions),const DeepCollectionEquality().hash(_floodForecastRegionsRaw),messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.flood(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, floodWarningLevels: $floodWarningLevels, floodWarningLevelsRaw: $floodWarningLevelsRaw, floodForecastRegions: $floodForecastRegions, floodForecastRegionsRaw: $floodForecastRegionsRaw, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportFloodCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportFloodCopyWith(QzssDcReportFlood value, $Res Function(QzssDcReportFlood) _then) = _$QzssDcReportFloodCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, List<String> floodWarningLevels, List<int> floodWarningLevelsRaw, List<String> floodForecastRegions, List<int> floodForecastRegionsRaw, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportFloodCopyWithImpl<$Res>
    implements $QzssDcReportFloodCopyWith<$Res> {
  _$QzssDcReportFloodCopyWithImpl(this._self, this._then);

  final QzssDcReportFlood _self;
  final $Res Function(QzssDcReportFlood) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? floodWarningLevels = null,Object? floodWarningLevelsRaw = null,Object? floodForecastRegions = null,Object? floodForecastRegionsRaw = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportFlood(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,floodWarningLevels: null == floodWarningLevels ? _self._floodWarningLevels : floodWarningLevels // ignore: cast_nullable_to_non_nullable
as List<String>,floodWarningLevelsRaw: null == floodWarningLevelsRaw ? _self._floodWarningLevelsRaw : floodWarningLevelsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,floodForecastRegions: null == floodForecastRegions ? _self._floodForecastRegions : floodForecastRegions // ignore: cast_nullable_to_non_nullable
as List<String>,floodForecastRegionsRaw: null == floodForecastRegionsRaw ? _self._floodForecastRegionsRaw : floodForecastRegionsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportMarine extends QzssDcReport {
  const QzssDcReportMarine({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required  List<String> marineWarningCodes, required  List<int> marineWarningCodesRaw, required  List<String> marineForecastRegions, required  List<int> marineForecastRegionsRaw, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): _marineWarningCodes = marineWarningCodes,_marineWarningCodesRaw = marineWarningCodesRaw,_marineForecastRegions = marineForecastRegions,_marineForecastRegionsRaw = marineForecastRegionsRaw,$type = $type ?? 'marine',super._();
  factory QzssDcReportMarine.fromJson(Map<String, dynamic> json) => _$QzssDcReportMarineFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  List<String> _marineWarningCodes;
 List<String> get marineWarningCodes {
  if (_marineWarningCodes is EqualUnmodifiableListView) return _marineWarningCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_marineWarningCodes);
}

 final  List<int> _marineWarningCodesRaw;
 List<int> get marineWarningCodesRaw {
  if (_marineWarningCodesRaw is EqualUnmodifiableListView) return _marineWarningCodesRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_marineWarningCodesRaw);
}

 final  List<String> _marineForecastRegions;
 List<String> get marineForecastRegions {
  if (_marineForecastRegions is EqualUnmodifiableListView) return _marineForecastRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_marineForecastRegions);
}

 final  List<int> _marineForecastRegionsRaw;
 List<int> get marineForecastRegionsRaw {
  if (_marineForecastRegionsRaw is EqualUnmodifiableListView) return _marineForecastRegionsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_marineForecastRegionsRaw);
}

@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportMarineCopyWith<QzssDcReportMarine> get copyWith => _$QzssDcReportMarineCopyWithImpl<QzssDcReportMarine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportMarineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportMarine&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&const DeepCollectionEquality().equals(other._marineWarningCodes, _marineWarningCodes)&&const DeepCollectionEquality().equals(other._marineWarningCodesRaw, _marineWarningCodesRaw)&&const DeepCollectionEquality().equals(other._marineForecastRegions, _marineForecastRegions)&&const DeepCollectionEquality().equals(other._marineForecastRegionsRaw, _marineForecastRegionsRaw)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,const DeepCollectionEquality().hash(_marineWarningCodes),const DeepCollectionEquality().hash(_marineWarningCodesRaw),const DeepCollectionEquality().hash(_marineForecastRegions),const DeepCollectionEquality().hash(_marineForecastRegionsRaw),messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.marine(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, marineWarningCodes: $marineWarningCodes, marineWarningCodesRaw: $marineWarningCodesRaw, marineForecastRegions: $marineForecastRegions, marineForecastRegionsRaw: $marineForecastRegionsRaw, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportMarineCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportMarineCopyWith(QzssDcReportMarine value, $Res Function(QzssDcReportMarine) _then) = _$QzssDcReportMarineCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, List<String> marineWarningCodes, List<int> marineWarningCodesRaw, List<String> marineForecastRegions, List<int> marineForecastRegionsRaw, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportMarineCopyWithImpl<$Res>
    implements $QzssDcReportMarineCopyWith<$Res> {
  _$QzssDcReportMarineCopyWithImpl(this._self, this._then);

  final QzssDcReportMarine _self;
  final $Res Function(QzssDcReportMarine) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? marineWarningCodes = null,Object? marineWarningCodesRaw = null,Object? marineForecastRegions = null,Object? marineForecastRegionsRaw = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportMarine(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,marineWarningCodes: null == marineWarningCodes ? _self._marineWarningCodes : marineWarningCodes // ignore: cast_nullable_to_non_nullable
as List<String>,marineWarningCodesRaw: null == marineWarningCodesRaw ? _self._marineWarningCodesRaw : marineWarningCodesRaw // ignore: cast_nullable_to_non_nullable
as List<int>,marineForecastRegions: null == marineForecastRegions ? _self._marineForecastRegions : marineForecastRegions // ignore: cast_nullable_to_non_nullable
as List<String>,marineForecastRegionsRaw: null == marineForecastRegionsRaw ? _self._marineForecastRegionsRaw : marineForecastRegionsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportWeather extends QzssDcReport {
  const QzssDcReportWeather({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required this.weatherWarningState, required this.weatherWarningStateRaw, required  List<String> weatherRelatedDisasterSubCategories, required  List<int> weatherRelatedDisasterSubCategoriesRaw, required  List<String> weatherForecastRegions, required  List<int> weatherForecastRegionsRaw, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): _weatherRelatedDisasterSubCategories = weatherRelatedDisasterSubCategories,_weatherRelatedDisasterSubCategoriesRaw = weatherRelatedDisasterSubCategoriesRaw,_weatherForecastRegions = weatherForecastRegions,_weatherForecastRegionsRaw = weatherForecastRegionsRaw,$type = $type ?? 'weather',super._();
  factory QzssDcReportWeather.fromJson(Map<String, dynamic> json) => _$QzssDcReportWeatherFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  String weatherWarningState;
 final  int weatherWarningStateRaw;
 final  List<String> _weatherRelatedDisasterSubCategories;
 List<String> get weatherRelatedDisasterSubCategories {
  if (_weatherRelatedDisasterSubCategories is EqualUnmodifiableListView) return _weatherRelatedDisasterSubCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weatherRelatedDisasterSubCategories);
}

 final  List<int> _weatherRelatedDisasterSubCategoriesRaw;
 List<int> get weatherRelatedDisasterSubCategoriesRaw {
  if (_weatherRelatedDisasterSubCategoriesRaw is EqualUnmodifiableListView) return _weatherRelatedDisasterSubCategoriesRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weatherRelatedDisasterSubCategoriesRaw);
}

 final  List<String> _weatherForecastRegions;
 List<String> get weatherForecastRegions {
  if (_weatherForecastRegions is EqualUnmodifiableListView) return _weatherForecastRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weatherForecastRegions);
}

 final  List<int> _weatherForecastRegionsRaw;
 List<int> get weatherForecastRegionsRaw {
  if (_weatherForecastRegionsRaw is EqualUnmodifiableListView) return _weatherForecastRegionsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weatherForecastRegionsRaw);
}

@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportWeatherCopyWith<QzssDcReportWeather> get copyWith => _$QzssDcReportWeatherCopyWithImpl<QzssDcReportWeather>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportWeatherToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportWeather&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&(identical(other.weatherWarningState, weatherWarningState) || other.weatherWarningState == weatherWarningState)&&(identical(other.weatherWarningStateRaw, weatherWarningStateRaw) || other.weatherWarningStateRaw == weatherWarningStateRaw)&&const DeepCollectionEquality().equals(other._weatherRelatedDisasterSubCategories, _weatherRelatedDisasterSubCategories)&&const DeepCollectionEquality().equals(other._weatherRelatedDisasterSubCategoriesRaw, _weatherRelatedDisasterSubCategoriesRaw)&&const DeepCollectionEquality().equals(other._weatherForecastRegions, _weatherForecastRegions)&&const DeepCollectionEquality().equals(other._weatherForecastRegionsRaw, _weatherForecastRegionsRaw)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,weatherWarningState,weatherWarningStateRaw,const DeepCollectionEquality().hash(_weatherRelatedDisasterSubCategories),const DeepCollectionEquality().hash(_weatherRelatedDisasterSubCategoriesRaw),const DeepCollectionEquality().hash(_weatherForecastRegions),const DeepCollectionEquality().hash(_weatherForecastRegionsRaw),messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.weather(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, weatherWarningState: $weatherWarningState, weatherWarningStateRaw: $weatherWarningStateRaw, weatherRelatedDisasterSubCategories: $weatherRelatedDisasterSubCategories, weatherRelatedDisasterSubCategoriesRaw: $weatherRelatedDisasterSubCategoriesRaw, weatherForecastRegions: $weatherForecastRegions, weatherForecastRegionsRaw: $weatherForecastRegionsRaw, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportWeatherCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportWeatherCopyWith(QzssDcReportWeather value, $Res Function(QzssDcReportWeather) _then) = _$QzssDcReportWeatherCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, String weatherWarningState, int weatherWarningStateRaw, List<String> weatherRelatedDisasterSubCategories, List<int> weatherRelatedDisasterSubCategoriesRaw, List<String> weatherForecastRegions, List<int> weatherForecastRegionsRaw, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportWeatherCopyWithImpl<$Res>
    implements $QzssDcReportWeatherCopyWith<$Res> {
  _$QzssDcReportWeatherCopyWithImpl(this._self, this._then);

  final QzssDcReportWeather _self;
  final $Res Function(QzssDcReportWeather) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? weatherWarningState = null,Object? weatherWarningStateRaw = null,Object? weatherRelatedDisasterSubCategories = null,Object? weatherRelatedDisasterSubCategoriesRaw = null,Object? weatherForecastRegions = null,Object? weatherForecastRegionsRaw = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportWeather(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,weatherWarningState: null == weatherWarningState ? _self.weatherWarningState : weatherWarningState // ignore: cast_nullable_to_non_nullable
as String,weatherWarningStateRaw: null == weatherWarningStateRaw ? _self.weatherWarningStateRaw : weatherWarningStateRaw // ignore: cast_nullable_to_non_nullable
as int,weatherRelatedDisasterSubCategories: null == weatherRelatedDisasterSubCategories ? _self._weatherRelatedDisasterSubCategories : weatherRelatedDisasterSubCategories // ignore: cast_nullable_to_non_nullable
as List<String>,weatherRelatedDisasterSubCategoriesRaw: null == weatherRelatedDisasterSubCategoriesRaw ? _self._weatherRelatedDisasterSubCategoriesRaw : weatherRelatedDisasterSubCategoriesRaw // ignore: cast_nullable_to_non_nullable
as List<int>,weatherForecastRegions: null == weatherForecastRegions ? _self._weatherForecastRegions : weatherForecastRegions // ignore: cast_nullable_to_non_nullable
as List<String>,weatherForecastRegionsRaw: null == weatherForecastRegionsRaw ? _self._weatherForecastRegionsRaw : weatherForecastRegionsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportVolcano extends QzssDcReport {
  const QzssDcReportVolcano({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required this.ambiguityOfActivityTimeNo, required this.activityTime, required this.volcanicWarningCode, required this.volcanicWarningCodeRaw, required this.volcanoName, required this.volcanoNameRaw, required  List<String> localGovernments, required  List<int> localGovernmentsRaw, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): _localGovernments = localGovernments,_localGovernmentsRaw = localGovernmentsRaw,$type = $type ?? 'volcano',super._();
  factory QzssDcReportVolcano.fromJson(Map<String, dynamic> json) => _$QzssDcReportVolcanoFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  int ambiguityOfActivityTimeNo;
 final  DateTime activityTime;
 final  String volcanicWarningCode;
 final  int volcanicWarningCodeRaw;
 final  String volcanoName;
 final  int volcanoNameRaw;
 final  List<String> _localGovernments;
 List<String> get localGovernments {
  if (_localGovernments is EqualUnmodifiableListView) return _localGovernments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_localGovernments);
}

 final  List<int> _localGovernmentsRaw;
 List<int> get localGovernmentsRaw {
  if (_localGovernmentsRaw is EqualUnmodifiableListView) return _localGovernmentsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_localGovernmentsRaw);
}

@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportVolcanoCopyWith<QzssDcReportVolcano> get copyWith => _$QzssDcReportVolcanoCopyWithImpl<QzssDcReportVolcano>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportVolcanoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportVolcano&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&(identical(other.ambiguityOfActivityTimeNo, ambiguityOfActivityTimeNo) || other.ambiguityOfActivityTimeNo == ambiguityOfActivityTimeNo)&&(identical(other.activityTime, activityTime) || other.activityTime == activityTime)&&(identical(other.volcanicWarningCode, volcanicWarningCode) || other.volcanicWarningCode == volcanicWarningCode)&&(identical(other.volcanicWarningCodeRaw, volcanicWarningCodeRaw) || other.volcanicWarningCodeRaw == volcanicWarningCodeRaw)&&(identical(other.volcanoName, volcanoName) || other.volcanoName == volcanoName)&&(identical(other.volcanoNameRaw, volcanoNameRaw) || other.volcanoNameRaw == volcanoNameRaw)&&const DeepCollectionEquality().equals(other._localGovernments, _localGovernments)&&const DeepCollectionEquality().equals(other._localGovernmentsRaw, _localGovernmentsRaw)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,ambiguityOfActivityTimeNo,activityTime,volcanicWarningCode,volcanicWarningCodeRaw,volcanoName,volcanoNameRaw,const DeepCollectionEquality().hash(_localGovernments),const DeepCollectionEquality().hash(_localGovernmentsRaw),messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.volcano(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, ambiguityOfActivityTimeNo: $ambiguityOfActivityTimeNo, activityTime: $activityTime, volcanicWarningCode: $volcanicWarningCode, volcanicWarningCodeRaw: $volcanicWarningCodeRaw, volcanoName: $volcanoName, volcanoNameRaw: $volcanoNameRaw, localGovernments: $localGovernments, localGovernmentsRaw: $localGovernmentsRaw, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportVolcanoCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportVolcanoCopyWith(QzssDcReportVolcano value, $Res Function(QzssDcReportVolcano) _then) = _$QzssDcReportVolcanoCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, int ambiguityOfActivityTimeNo, DateTime activityTime, String volcanicWarningCode, int volcanicWarningCodeRaw, String volcanoName, int volcanoNameRaw, List<String> localGovernments, List<int> localGovernmentsRaw, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportVolcanoCopyWithImpl<$Res>
    implements $QzssDcReportVolcanoCopyWith<$Res> {
  _$QzssDcReportVolcanoCopyWithImpl(this._self, this._then);

  final QzssDcReportVolcano _self;
  final $Res Function(QzssDcReportVolcano) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? ambiguityOfActivityTimeNo = null,Object? activityTime = null,Object? volcanicWarningCode = null,Object? volcanicWarningCodeRaw = null,Object? volcanoName = null,Object? volcanoNameRaw = null,Object? localGovernments = null,Object? localGovernmentsRaw = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportVolcano(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,ambiguityOfActivityTimeNo: null == ambiguityOfActivityTimeNo ? _self.ambiguityOfActivityTimeNo : ambiguityOfActivityTimeNo // ignore: cast_nullable_to_non_nullable
as int,activityTime: null == activityTime ? _self.activityTime : activityTime // ignore: cast_nullable_to_non_nullable
as DateTime,volcanicWarningCode: null == volcanicWarningCode ? _self.volcanicWarningCode : volcanicWarningCode // ignore: cast_nullable_to_non_nullable
as String,volcanicWarningCodeRaw: null == volcanicWarningCodeRaw ? _self.volcanicWarningCodeRaw : volcanicWarningCodeRaw // ignore: cast_nullable_to_non_nullable
as int,volcanoName: null == volcanoName ? _self.volcanoName : volcanoName // ignore: cast_nullable_to_non_nullable
as String,volcanoNameRaw: null == volcanoNameRaw ? _self.volcanoNameRaw : volcanoNameRaw // ignore: cast_nullable_to_non_nullable
as int,localGovernments: null == localGovernments ? _self._localGovernments : localGovernments // ignore: cast_nullable_to_non_nullable
as List<String>,localGovernmentsRaw: null == localGovernmentsRaw ? _self._localGovernmentsRaw : localGovernmentsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportAshFall extends QzssDcReport {
  const QzssDcReportAshFall({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required this.activityTime, required this.ashFallWarningType, required this.ashFallWarningTypeRaw, required this.volcanoName, required this.volcanoNameRaw, required  List<int> expectedAshFallTimes, required  List<String> ashFallWarningCodes, required  List<int> ashFallWarningCodesRaw, required  List<String> localGovernments, required  List<int> localGovernmentsRaw, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): _expectedAshFallTimes = expectedAshFallTimes,_ashFallWarningCodes = ashFallWarningCodes,_ashFallWarningCodesRaw = ashFallWarningCodesRaw,_localGovernments = localGovernments,_localGovernmentsRaw = localGovernmentsRaw,$type = $type ?? 'ashFall',super._();
  factory QzssDcReportAshFall.fromJson(Map<String, dynamic> json) => _$QzssDcReportAshFallFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  DateTime activityTime;
 final  String ashFallWarningType;
 final  int ashFallWarningTypeRaw;
 final  String volcanoName;
 final  int volcanoNameRaw;
 final  List<int> _expectedAshFallTimes;
 List<int> get expectedAshFallTimes {
  if (_expectedAshFallTimes is EqualUnmodifiableListView) return _expectedAshFallTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expectedAshFallTimes);
}

 final  List<String> _ashFallWarningCodes;
 List<String> get ashFallWarningCodes {
  if (_ashFallWarningCodes is EqualUnmodifiableListView) return _ashFallWarningCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ashFallWarningCodes);
}

 final  List<int> _ashFallWarningCodesRaw;
 List<int> get ashFallWarningCodesRaw {
  if (_ashFallWarningCodesRaw is EqualUnmodifiableListView) return _ashFallWarningCodesRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ashFallWarningCodesRaw);
}

 final  List<String> _localGovernments;
 List<String> get localGovernments {
  if (_localGovernments is EqualUnmodifiableListView) return _localGovernments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_localGovernments);
}

 final  List<int> _localGovernmentsRaw;
 List<int> get localGovernmentsRaw {
  if (_localGovernmentsRaw is EqualUnmodifiableListView) return _localGovernmentsRaw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_localGovernmentsRaw);
}

@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportAshFallCopyWith<QzssDcReportAshFall> get copyWith => _$QzssDcReportAshFallCopyWithImpl<QzssDcReportAshFall>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportAshFallToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportAshFall&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&(identical(other.activityTime, activityTime) || other.activityTime == activityTime)&&(identical(other.ashFallWarningType, ashFallWarningType) || other.ashFallWarningType == ashFallWarningType)&&(identical(other.ashFallWarningTypeRaw, ashFallWarningTypeRaw) || other.ashFallWarningTypeRaw == ashFallWarningTypeRaw)&&(identical(other.volcanoName, volcanoName) || other.volcanoName == volcanoName)&&(identical(other.volcanoNameRaw, volcanoNameRaw) || other.volcanoNameRaw == volcanoNameRaw)&&const DeepCollectionEquality().equals(other._expectedAshFallTimes, _expectedAshFallTimes)&&const DeepCollectionEquality().equals(other._ashFallWarningCodes, _ashFallWarningCodes)&&const DeepCollectionEquality().equals(other._ashFallWarningCodesRaw, _ashFallWarningCodesRaw)&&const DeepCollectionEquality().equals(other._localGovernments, _localGovernments)&&const DeepCollectionEquality().equals(other._localGovernmentsRaw, _localGovernmentsRaw)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,activityTime,ashFallWarningType,ashFallWarningTypeRaw,volcanoName,volcanoNameRaw,const DeepCollectionEquality().hash(_expectedAshFallTimes),const DeepCollectionEquality().hash(_ashFallWarningCodes),const DeepCollectionEquality().hash(_ashFallWarningCodesRaw),const DeepCollectionEquality().hash(_localGovernments),const DeepCollectionEquality().hash(_localGovernmentsRaw),messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.ashFall(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, activityTime: $activityTime, ashFallWarningType: $ashFallWarningType, ashFallWarningTypeRaw: $ashFallWarningTypeRaw, volcanoName: $volcanoName, volcanoNameRaw: $volcanoNameRaw, expectedAshFallTimes: $expectedAshFallTimes, ashFallWarningCodes: $ashFallWarningCodes, ashFallWarningCodesRaw: $ashFallWarningCodesRaw, localGovernments: $localGovernments, localGovernmentsRaw: $localGovernmentsRaw, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportAshFallCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportAshFallCopyWith(QzssDcReportAshFall value, $Res Function(QzssDcReportAshFall) _then) = _$QzssDcReportAshFallCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, DateTime activityTime, String ashFallWarningType, int ashFallWarningTypeRaw, String volcanoName, int volcanoNameRaw, List<int> expectedAshFallTimes, List<String> ashFallWarningCodes, List<int> ashFallWarningCodesRaw, List<String> localGovernments, List<int> localGovernmentsRaw, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportAshFallCopyWithImpl<$Res>
    implements $QzssDcReportAshFallCopyWith<$Res> {
  _$QzssDcReportAshFallCopyWithImpl(this._self, this._then);

  final QzssDcReportAshFall _self;
  final $Res Function(QzssDcReportAshFall) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? activityTime = null,Object? ashFallWarningType = null,Object? ashFallWarningTypeRaw = null,Object? volcanoName = null,Object? volcanoNameRaw = null,Object? expectedAshFallTimes = null,Object? ashFallWarningCodes = null,Object? ashFallWarningCodesRaw = null,Object? localGovernments = null,Object? localGovernmentsRaw = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportAshFall(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,activityTime: null == activityTime ? _self.activityTime : activityTime // ignore: cast_nullable_to_non_nullable
as DateTime,ashFallWarningType: null == ashFallWarningType ? _self.ashFallWarningType : ashFallWarningType // ignore: cast_nullable_to_non_nullable
as String,ashFallWarningTypeRaw: null == ashFallWarningTypeRaw ? _self.ashFallWarningTypeRaw : ashFallWarningTypeRaw // ignore: cast_nullable_to_non_nullable
as int,volcanoName: null == volcanoName ? _self.volcanoName : volcanoName // ignore: cast_nullable_to_non_nullable
as String,volcanoNameRaw: null == volcanoNameRaw ? _self.volcanoNameRaw : volcanoNameRaw // ignore: cast_nullable_to_non_nullable
as int,expectedAshFallTimes: null == expectedAshFallTimes ? _self._expectedAshFallTimes : expectedAshFallTimes // ignore: cast_nullable_to_non_nullable
as List<int>,ashFallWarningCodes: null == ashFallWarningCodes ? _self._ashFallWarningCodes : ashFallWarningCodes // ignore: cast_nullable_to_non_nullable
as List<String>,ashFallWarningCodesRaw: null == ashFallWarningCodesRaw ? _self._ashFallWarningCodesRaw : ashFallWarningCodesRaw // ignore: cast_nullable_to_non_nullable
as List<int>,localGovernments: null == localGovernments ? _self._localGovernments : localGovernments // ignore: cast_nullable_to_non_nullable
as List<String>,localGovernmentsRaw: null == localGovernmentsRaw ? _self._localGovernmentsRaw : localGovernmentsRaw // ignore: cast_nullable_to_non_nullable
as List<int>,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportTyphoon extends QzssDcReport {
  const QzssDcReportTyphoon({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.version, required this.reportClassification, required this.reportClassificationEn, required this.reportClassificationNo, required this.disasterCategory, required this.disasterCategoryEn, required this.disasterCategoryNo, required this.reportTime, required this.informationType, required this.informationTypeEn, required this.informationTypeNo, required this.referenceTime, required this.referenceTimeType, required this.referenceTimeTypeRaw, required this.elapsedTimeFromReferenceTime, required this.typhoonNumber, required this.typhoonNumberRaw, required this.typhoonScaleCategory, required this.typhoonScaleCategoryRaw, required this.typhoonIntensityCategory, required this.typhoonIntensityCategoryRaw, required this.coordinatesOfTyphoon, required this.centralPressure, required this.centralPressureRaw, required this.maximumWindSpeed, required this.maximumWindSpeedRaw, required this.maximumGustWindSpeed, required this.maximumGustWindSpeedRaw, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): $type = $type ?? 'typhoon',super._();
  factory QzssDcReportTyphoon.fromJson(Map<String, dynamic> json) => _$QzssDcReportTyphoonFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  int version;
 final  String reportClassification;
 final  String reportClassificationEn;
 final  int reportClassificationNo;
 final  String disasterCategory;
 final  String disasterCategoryEn;
 final  int disasterCategoryNo;
 final  DateTime reportTime;
 final  String informationType;
 final  String informationTypeEn;
 final  int informationTypeNo;
 final  DateTime referenceTime;
 final  String referenceTimeType;
 final  int referenceTimeTypeRaw;
 final  int elapsedTimeFromReferenceTime;
 final  String typhoonNumber;
 final  int typhoonNumberRaw;
 final  String typhoonScaleCategory;
 final  int typhoonScaleCategoryRaw;
 final  String typhoonIntensityCategory;
 final  int typhoonIntensityCategoryRaw;
 final  HypocenterCoordinates coordinatesOfTyphoon;
 final  String centralPressure;
 final  int centralPressureRaw;
 final  String maximumWindSpeed;
 final  int maximumWindSpeedRaw;
 final  String maximumGustWindSpeed;
 final  int maximumGustWindSpeedRaw;
@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportTyphoonCopyWith<QzssDcReportTyphoon> get copyWith => _$QzssDcReportTyphoonCopyWithImpl<QzssDcReportTyphoon>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportTyphoonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportTyphoon&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.version, version) || other.version == version)&&(identical(other.reportClassification, reportClassification) || other.reportClassification == reportClassification)&&(identical(other.reportClassificationEn, reportClassificationEn) || other.reportClassificationEn == reportClassificationEn)&&(identical(other.reportClassificationNo, reportClassificationNo) || other.reportClassificationNo == reportClassificationNo)&&(identical(other.disasterCategory, disasterCategory) || other.disasterCategory == disasterCategory)&&(identical(other.disasterCategoryEn, disasterCategoryEn) || other.disasterCategoryEn == disasterCategoryEn)&&(identical(other.disasterCategoryNo, disasterCategoryNo) || other.disasterCategoryNo == disasterCategoryNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.informationType, informationType) || other.informationType == informationType)&&(identical(other.informationTypeEn, informationTypeEn) || other.informationTypeEn == informationTypeEn)&&(identical(other.informationTypeNo, informationTypeNo) || other.informationTypeNo == informationTypeNo)&&(identical(other.referenceTime, referenceTime) || other.referenceTime == referenceTime)&&(identical(other.referenceTimeType, referenceTimeType) || other.referenceTimeType == referenceTimeType)&&(identical(other.referenceTimeTypeRaw, referenceTimeTypeRaw) || other.referenceTimeTypeRaw == referenceTimeTypeRaw)&&(identical(other.elapsedTimeFromReferenceTime, elapsedTimeFromReferenceTime) || other.elapsedTimeFromReferenceTime == elapsedTimeFromReferenceTime)&&(identical(other.typhoonNumber, typhoonNumber) || other.typhoonNumber == typhoonNumber)&&(identical(other.typhoonNumberRaw, typhoonNumberRaw) || other.typhoonNumberRaw == typhoonNumberRaw)&&(identical(other.typhoonScaleCategory, typhoonScaleCategory) || other.typhoonScaleCategory == typhoonScaleCategory)&&(identical(other.typhoonScaleCategoryRaw, typhoonScaleCategoryRaw) || other.typhoonScaleCategoryRaw == typhoonScaleCategoryRaw)&&(identical(other.typhoonIntensityCategory, typhoonIntensityCategory) || other.typhoonIntensityCategory == typhoonIntensityCategory)&&(identical(other.typhoonIntensityCategoryRaw, typhoonIntensityCategoryRaw) || other.typhoonIntensityCategoryRaw == typhoonIntensityCategoryRaw)&&(identical(other.coordinatesOfTyphoon, coordinatesOfTyphoon) || other.coordinatesOfTyphoon == coordinatesOfTyphoon)&&(identical(other.centralPressure, centralPressure) || other.centralPressure == centralPressure)&&(identical(other.centralPressureRaw, centralPressureRaw) || other.centralPressureRaw == centralPressureRaw)&&(identical(other.maximumWindSpeed, maximumWindSpeed) || other.maximumWindSpeed == maximumWindSpeed)&&(identical(other.maximumWindSpeedRaw, maximumWindSpeedRaw) || other.maximumWindSpeedRaw == maximumWindSpeedRaw)&&(identical(other.maximumGustWindSpeed, maximumGustWindSpeed) || other.maximumGustWindSpeed == maximumGustWindSpeed)&&(identical(other.maximumGustWindSpeedRaw, maximumGustWindSpeedRaw) || other.maximumGustWindSpeedRaw == maximumGustWindSpeedRaw)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,version,reportClassification,reportClassificationEn,reportClassificationNo,disasterCategory,disasterCategoryEn,disasterCategoryNo,reportTime,informationType,informationTypeEn,informationTypeNo,referenceTime,referenceTimeType,referenceTimeTypeRaw,elapsedTimeFromReferenceTime,typhoonNumber,typhoonNumberRaw,typhoonScaleCategory,typhoonScaleCategoryRaw,typhoonIntensityCategory,typhoonIntensityCategoryRaw,coordinatesOfTyphoon,centralPressure,centralPressureRaw,maximumWindSpeed,maximumWindSpeedRaw,maximumGustWindSpeed,maximumGustWindSpeedRaw,messageHeader,satelliteId,satellitePrn]);

@override
String toString() {
  return 'QzssDcReport.typhoon(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, version: $version, reportClassification: $reportClassification, reportClassificationEn: $reportClassificationEn, reportClassificationNo: $reportClassificationNo, disasterCategory: $disasterCategory, disasterCategoryEn: $disasterCategoryEn, disasterCategoryNo: $disasterCategoryNo, reportTime: $reportTime, informationType: $informationType, informationTypeEn: $informationTypeEn, informationTypeNo: $informationTypeNo, referenceTime: $referenceTime, referenceTimeType: $referenceTimeType, referenceTimeTypeRaw: $referenceTimeTypeRaw, elapsedTimeFromReferenceTime: $elapsedTimeFromReferenceTime, typhoonNumber: $typhoonNumber, typhoonNumberRaw: $typhoonNumberRaw, typhoonScaleCategory: $typhoonScaleCategory, typhoonScaleCategoryRaw: $typhoonScaleCategoryRaw, typhoonIntensityCategory: $typhoonIntensityCategory, typhoonIntensityCategoryRaw: $typhoonIntensityCategoryRaw, coordinatesOfTyphoon: $coordinatesOfTyphoon, centralPressure: $centralPressure, centralPressureRaw: $centralPressureRaw, maximumWindSpeed: $maximumWindSpeed, maximumWindSpeedRaw: $maximumWindSpeedRaw, maximumGustWindSpeed: $maximumGustWindSpeed, maximumGustWindSpeedRaw: $maximumGustWindSpeedRaw, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportTyphoonCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportTyphoonCopyWith(QzssDcReportTyphoon value, $Res Function(QzssDcReportTyphoon) _then) = _$QzssDcReportTyphoonCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, int version, String reportClassification, String reportClassificationEn, int reportClassificationNo, String disasterCategory, String disasterCategoryEn, int disasterCategoryNo, DateTime reportTime, String informationType, String informationTypeEn, int informationTypeNo, DateTime referenceTime, String referenceTimeType, int referenceTimeTypeRaw, int elapsedTimeFromReferenceTime, String typhoonNumber, int typhoonNumberRaw, String typhoonScaleCategory, int typhoonScaleCategoryRaw, String typhoonIntensityCategory, int typhoonIntensityCategoryRaw, HypocenterCoordinates coordinatesOfTyphoon, String centralPressure, int centralPressureRaw, String maximumWindSpeed, int maximumWindSpeedRaw, String maximumGustWindSpeed, int maximumGustWindSpeedRaw, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportTyphoonCopyWithImpl<$Res>
    implements $QzssDcReportTyphoonCopyWith<$Res> {
  _$QzssDcReportTyphoonCopyWithImpl(this._self, this._then);

  final QzssDcReportTyphoon _self;
  final $Res Function(QzssDcReportTyphoon) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? version = null,Object? reportClassification = null,Object? reportClassificationEn = null,Object? reportClassificationNo = null,Object? disasterCategory = null,Object? disasterCategoryEn = null,Object? disasterCategoryNo = null,Object? reportTime = null,Object? informationType = null,Object? informationTypeEn = null,Object? informationTypeNo = null,Object? referenceTime = null,Object? referenceTimeType = null,Object? referenceTimeTypeRaw = null,Object? elapsedTimeFromReferenceTime = null,Object? typhoonNumber = null,Object? typhoonNumberRaw = null,Object? typhoonScaleCategory = null,Object? typhoonScaleCategoryRaw = null,Object? typhoonIntensityCategory = null,Object? typhoonIntensityCategoryRaw = null,Object? coordinatesOfTyphoon = null,Object? centralPressure = null,Object? centralPressureRaw = null,Object? maximumWindSpeed = null,Object? maximumWindSpeedRaw = null,Object? maximumGustWindSpeed = null,Object? maximumGustWindSpeedRaw = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportTyphoon(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,reportClassification: null == reportClassification ? _self.reportClassification : reportClassification // ignore: cast_nullable_to_non_nullable
as String,reportClassificationEn: null == reportClassificationEn ? _self.reportClassificationEn : reportClassificationEn // ignore: cast_nullable_to_non_nullable
as String,reportClassificationNo: null == reportClassificationNo ? _self.reportClassificationNo : reportClassificationNo // ignore: cast_nullable_to_non_nullable
as int,disasterCategory: null == disasterCategory ? _self.disasterCategory : disasterCategory // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryEn: null == disasterCategoryEn ? _self.disasterCategoryEn : disasterCategoryEn // ignore: cast_nullable_to_non_nullable
as String,disasterCategoryNo: null == disasterCategoryNo ? _self.disasterCategoryNo : disasterCategoryNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as String,informationTypeEn: null == informationTypeEn ? _self.informationTypeEn : informationTypeEn // ignore: cast_nullable_to_non_nullable
as String,informationTypeNo: null == informationTypeNo ? _self.informationTypeNo : informationTypeNo // ignore: cast_nullable_to_non_nullable
as int,referenceTime: null == referenceTime ? _self.referenceTime : referenceTime // ignore: cast_nullable_to_non_nullable
as DateTime,referenceTimeType: null == referenceTimeType ? _self.referenceTimeType : referenceTimeType // ignore: cast_nullable_to_non_nullable
as String,referenceTimeTypeRaw: null == referenceTimeTypeRaw ? _self.referenceTimeTypeRaw : referenceTimeTypeRaw // ignore: cast_nullable_to_non_nullable
as int,elapsedTimeFromReferenceTime: null == elapsedTimeFromReferenceTime ? _self.elapsedTimeFromReferenceTime : elapsedTimeFromReferenceTime // ignore: cast_nullable_to_non_nullable
as int,typhoonNumber: null == typhoonNumber ? _self.typhoonNumber : typhoonNumber // ignore: cast_nullable_to_non_nullable
as String,typhoonNumberRaw: null == typhoonNumberRaw ? _self.typhoonNumberRaw : typhoonNumberRaw // ignore: cast_nullable_to_non_nullable
as int,typhoonScaleCategory: null == typhoonScaleCategory ? _self.typhoonScaleCategory : typhoonScaleCategory // ignore: cast_nullable_to_non_nullable
as String,typhoonScaleCategoryRaw: null == typhoonScaleCategoryRaw ? _self.typhoonScaleCategoryRaw : typhoonScaleCategoryRaw // ignore: cast_nullable_to_non_nullable
as int,typhoonIntensityCategory: null == typhoonIntensityCategory ? _self.typhoonIntensityCategory : typhoonIntensityCategory // ignore: cast_nullable_to_non_nullable
as String,typhoonIntensityCategoryRaw: null == typhoonIntensityCategoryRaw ? _self.typhoonIntensityCategoryRaw : typhoonIntensityCategoryRaw // ignore: cast_nullable_to_non_nullable
as int,coordinatesOfTyphoon: null == coordinatesOfTyphoon ? _self.coordinatesOfTyphoon : coordinatesOfTyphoon // ignore: cast_nullable_to_non_nullable
as HypocenterCoordinates,centralPressure: null == centralPressure ? _self.centralPressure : centralPressure // ignore: cast_nullable_to_non_nullable
as String,centralPressureRaw: null == centralPressureRaw ? _self.centralPressureRaw : centralPressureRaw // ignore: cast_nullable_to_non_nullable
as int,maximumWindSpeed: null == maximumWindSpeed ? _self.maximumWindSpeed : maximumWindSpeed // ignore: cast_nullable_to_non_nullable
as String,maximumWindSpeedRaw: null == maximumWindSpeedRaw ? _self.maximumWindSpeedRaw : maximumWindSpeedRaw // ignore: cast_nullable_to_non_nullable
as int,maximumGustWindSpeed: null == maximumGustWindSpeed ? _self.maximumGustWindSpeed : maximumGustWindSpeed // ignore: cast_nullable_to_non_nullable
as String,maximumGustWindSpeedRaw: null == maximumGustWindSpeedRaw ? _self.maximumGustWindSpeedRaw : maximumGustWindSpeedRaw // ignore: cast_nullable_to_non_nullable
as int,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportDcxNull extends QzssDcReport {
  const QzssDcReportDcxNull({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.dcxMessageType, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): $type = $type ?? 'dcxNull',super._();
  factory QzssDcReportDcxNull.fromJson(Map<String, dynamic> json) => _$QzssDcReportDcxNullFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  String dcxMessageType;
@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportDcxNullCopyWith<QzssDcReportDcxNull> get copyWith => _$QzssDcReportDcxNullCopyWithImpl<QzssDcReportDcxNull>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportDcxNullToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportDcxNull&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.dcxMessageType, dcxMessageType) || other.dcxMessageType == dcxMessageType)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,dcxMessageType,messageHeader,satelliteId,satellitePrn);

@override
String toString() {
  return 'QzssDcReport.dcxNull(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, dcxMessageType: $dcxMessageType, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportDcxNullCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportDcxNullCopyWith(QzssDcReportDcxNull value, $Res Function(QzssDcReportDcxNull) _then) = _$QzssDcReportDcxNullCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, String dcxMessageType, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportDcxNullCopyWithImpl<$Res>
    implements $QzssDcReportDcxNullCopyWith<$Res> {
  _$QzssDcReportDcxNullCopyWithImpl(this._self, this._then);

  final QzssDcReportDcxNull _self;
  final $Res Function(QzssDcReportDcxNull) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? dcxMessageType = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportDcxNull(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,dcxMessageType: null == dcxMessageType ? _self.dcxMessageType : dcxMessageType // ignore: cast_nullable_to_non_nullable
as String,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportDcxOutsideJapan extends QzssDcReport {
  const QzssDcReportDcxOutsideJapan({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.dcxMessageType, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): $type = $type ?? 'dcxOutsideJapan',super._();
  factory QzssDcReportDcxOutsideJapan.fromJson(Map<String, dynamic> json) => _$QzssDcReportDcxOutsideJapanFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  String dcxMessageType;
@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportDcxOutsideJapanCopyWith<QzssDcReportDcxOutsideJapan> get copyWith => _$QzssDcReportDcxOutsideJapanCopyWithImpl<QzssDcReportDcxOutsideJapan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportDcxOutsideJapanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportDcxOutsideJapan&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.dcxMessageType, dcxMessageType) || other.dcxMessageType == dcxMessageType)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,dcxMessageType,messageHeader,satelliteId,satellitePrn);

@override
String toString() {
  return 'QzssDcReport.dcxOutsideJapan(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, dcxMessageType: $dcxMessageType, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportDcxOutsideJapanCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportDcxOutsideJapanCopyWith(QzssDcReportDcxOutsideJapan value, $Res Function(QzssDcReportDcxOutsideJapan) _then) = _$QzssDcReportDcxOutsideJapanCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, String dcxMessageType, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportDcxOutsideJapanCopyWithImpl<$Res>
    implements $QzssDcReportDcxOutsideJapanCopyWith<$Res> {
  _$QzssDcReportDcxOutsideJapanCopyWithImpl(this._self, this._then);

  final QzssDcReportDcxOutsideJapan _self;
  final $Res Function(QzssDcReportDcxOutsideJapan) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? dcxMessageType = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportDcxOutsideJapan(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,dcxMessageType: null == dcxMessageType ? _self.dcxMessageType : dcxMessageType // ignore: cast_nullable_to_non_nullable
as String,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportDcxLAlert extends QzssDcReport {
  const QzssDcReportDcxLAlert({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.dcxMessageType, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): $type = $type ?? 'dcxLAlert',super._();
  factory QzssDcReportDcxLAlert.fromJson(Map<String, dynamic> json) => _$QzssDcReportDcxLAlertFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  String dcxMessageType;
@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportDcxLAlertCopyWith<QzssDcReportDcxLAlert> get copyWith => _$QzssDcReportDcxLAlertCopyWithImpl<QzssDcReportDcxLAlert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportDcxLAlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportDcxLAlert&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.dcxMessageType, dcxMessageType) || other.dcxMessageType == dcxMessageType)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,dcxMessageType,messageHeader,satelliteId,satellitePrn);

@override
String toString() {
  return 'QzssDcReport.dcxLAlert(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, dcxMessageType: $dcxMessageType, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportDcxLAlertCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportDcxLAlertCopyWith(QzssDcReportDcxLAlert value, $Res Function(QzssDcReportDcxLAlert) _then) = _$QzssDcReportDcxLAlertCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, String dcxMessageType, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportDcxLAlertCopyWithImpl<$Res>
    implements $QzssDcReportDcxLAlertCopyWith<$Res> {
  _$QzssDcReportDcxLAlertCopyWithImpl(this._self, this._then);

  final QzssDcReportDcxLAlert _self;
  final $Res Function(QzssDcReportDcxLAlert) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? dcxMessageType = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportDcxLAlert(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,dcxMessageType: null == dcxMessageType ? _self.dcxMessageType : dcxMessageType // ignore: cast_nullable_to_non_nullable
as String,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportDcxJAlert extends QzssDcReport {
  const QzssDcReportDcxJAlert({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.dcxMessageType, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): $type = $type ?? 'dcxJAlert',super._();
  factory QzssDcReportDcxJAlert.fromJson(Map<String, dynamic> json) => _$QzssDcReportDcxJAlertFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  String dcxMessageType;
@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportDcxJAlertCopyWith<QzssDcReportDcxJAlert> get copyWith => _$QzssDcReportDcxJAlertCopyWithImpl<QzssDcReportDcxJAlert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportDcxJAlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportDcxJAlert&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.dcxMessageType, dcxMessageType) || other.dcxMessageType == dcxMessageType)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,dcxMessageType,messageHeader,satelliteId,satellitePrn);

@override
String toString() {
  return 'QzssDcReport.dcxJAlert(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, dcxMessageType: $dcxMessageType, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportDcxJAlertCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportDcxJAlertCopyWith(QzssDcReportDcxJAlert value, $Res Function(QzssDcReportDcxJAlert) _then) = _$QzssDcReportDcxJAlertCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, String dcxMessageType, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportDcxJAlertCopyWithImpl<$Res>
    implements $QzssDcReportDcxJAlertCopyWith<$Res> {
  _$QzssDcReportDcxJAlertCopyWithImpl(this._self, this._then);

  final QzssDcReportDcxJAlert _self;
  final $Res Function(QzssDcReportDcxJAlert) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? dcxMessageType = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportDcxJAlert(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,dcxMessageType: null == dcxMessageType ? _self.dcxMessageType : dcxMessageType // ignore: cast_nullable_to_non_nullable
as String,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportDcxMTInfo extends QzssDcReport {
  const QzssDcReportDcxMTInfo({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.dcxMessageType, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): $type = $type ?? 'dcxMTInfo',super._();
  factory QzssDcReportDcxMTInfo.fromJson(Map<String, dynamic> json) => _$QzssDcReportDcxMTInfoFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  String dcxMessageType;
@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportDcxMTInfoCopyWith<QzssDcReportDcxMTInfo> get copyWith => _$QzssDcReportDcxMTInfoCopyWithImpl<QzssDcReportDcxMTInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportDcxMTInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportDcxMTInfo&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.dcxMessageType, dcxMessageType) || other.dcxMessageType == dcxMessageType)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,dcxMessageType,messageHeader,satelliteId,satellitePrn);

@override
String toString() {
  return 'QzssDcReport.dcxMTInfo(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, dcxMessageType: $dcxMessageType, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportDcxMTInfoCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportDcxMTInfoCopyWith(QzssDcReportDcxMTInfo value, $Res Function(QzssDcReportDcxMTInfo) _then) = _$QzssDcReportDcxMTInfoCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, String dcxMessageType, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportDcxMTInfoCopyWithImpl<$Res>
    implements $QzssDcReportDcxMTInfoCopyWith<$Res> {
  _$QzssDcReportDcxMTInfoCopyWithImpl(this._self, this._then);

  final QzssDcReportDcxMTInfo _self;
  final $Res Function(QzssDcReportDcxMTInfo) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? dcxMessageType = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportDcxMTInfo(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,dcxMessageType: null == dcxMessageType ? _self.dcxMessageType : dcxMessageType // ignore: cast_nullable_to_non_nullable
as String,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class QzssDcReportDcxUnknown extends QzssDcReport {
  const QzssDcReportDcxUnknown({required this.sentence, @Uint8ListConverter() required this.message, required this.nmea, @Uint8ListConverter() required this.raw, required this.preamble, required this.messageType, required this.dcxMessageType, this.messageHeader, this.satelliteId, this.satellitePrn,  String? $type}): $type = $type ?? 'dcxUnknown',super._();
  factory QzssDcReportDcxUnknown.fromJson(Map<String, dynamic> json) => _$QzssDcReportDcxUnknownFromJson(json);

@override final  String sentence;
@override@Uint8ListConverter() final  Uint8List message;
@override final  String nmea;
@override@Uint8ListConverter() final  Uint8List raw;
@override final  String preamble;
@override final  String messageType;
 final  String dcxMessageType;
@override final  String? messageHeader;
@override final  int? satelliteId;
@override final  int? satellitePrn;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzssDcReportDcxUnknownCopyWith<QzssDcReportDcxUnknown> get copyWith => _$QzssDcReportDcxUnknownCopyWithImpl<QzssDcReportDcxUnknown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QzssDcReportDcxUnknownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzssDcReportDcxUnknown&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.nmea, nmea) || other.nmea == nmea)&&const DeepCollectionEquality().equals(other.raw, raw)&&(identical(other.preamble, preamble) || other.preamble == preamble)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.dcxMessageType, dcxMessageType) || other.dcxMessageType == dcxMessageType)&&(identical(other.messageHeader, messageHeader) || other.messageHeader == messageHeader)&&(identical(other.satelliteId, satelliteId) || other.satelliteId == satelliteId)&&(identical(other.satellitePrn, satellitePrn) || other.satellitePrn == satellitePrn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sentence,const DeepCollectionEquality().hash(message),nmea,const DeepCollectionEquality().hash(raw),preamble,messageType,dcxMessageType,messageHeader,satelliteId,satellitePrn);

@override
String toString() {
  return 'QzssDcReport.dcxUnknown(sentence: $sentence, message: $message, nmea: $nmea, raw: $raw, preamble: $preamble, messageType: $messageType, dcxMessageType: $dcxMessageType, messageHeader: $messageHeader, satelliteId: $satelliteId, satellitePrn: $satellitePrn)';
}


}

/// @nodoc
abstract mixin class $QzssDcReportDcxUnknownCopyWith<$Res> implements $QzssDcReportCopyWith<$Res> {
  factory $QzssDcReportDcxUnknownCopyWith(QzssDcReportDcxUnknown value, $Res Function(QzssDcReportDcxUnknown) _then) = _$QzssDcReportDcxUnknownCopyWithImpl;
@override @useResult
$Res call({
 String sentence,@Uint8ListConverter() Uint8List message, String nmea,@Uint8ListConverter() Uint8List raw, String preamble, String messageType, String dcxMessageType, String? messageHeader, int? satelliteId, int? satellitePrn
});




}
/// @nodoc
class _$QzssDcReportDcxUnknownCopyWithImpl<$Res>
    implements $QzssDcReportDcxUnknownCopyWith<$Res> {
  _$QzssDcReportDcxUnknownCopyWithImpl(this._self, this._then);

  final QzssDcReportDcxUnknown _self;
  final $Res Function(QzssDcReportDcxUnknown) _then;

/// Create a copy of QzssDcReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentence = null,Object? message = null,Object? nmea = null,Object? raw = null,Object? preamble = null,Object? messageType = null,Object? dcxMessageType = null,Object? messageHeader = freezed,Object? satelliteId = freezed,Object? satellitePrn = freezed,}) {
  return _then(QzssDcReportDcxUnknown(
sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Uint8List,nmea: null == nmea ? _self.nmea : nmea // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Uint8List,preamble: null == preamble ? _self.preamble : preamble // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,dcxMessageType: null == dcxMessageType ? _self.dcxMessageType : dcxMessageType // ignore: cast_nullable_to_non_nullable
as String,messageHeader: freezed == messageHeader ? _self.messageHeader : messageHeader // ignore: cast_nullable_to_non_nullable
as String?,satelliteId: freezed == satelliteId ? _self.satelliteId : satelliteId // ignore: cast_nullable_to_non_nullable
as int?,satellitePrn: freezed == satellitePrn ? _self.satellitePrn : satellitePrn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
