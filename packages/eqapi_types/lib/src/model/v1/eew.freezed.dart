// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewV1 {

 int get id; int get eventId; String get type; String get schemaType; String get status; String get infoType; DateTime get reportTime; bool get isCanceled; bool get isLastInfo; bool? get isPlum; EewAccuracy? get accuracy; int? get serialNo; String? get headline; bool? get isWarning; DateTime? get originTime; DateTime? get arrivalTime; String? get hypoName; int? get depth; double? get latitude; double? get longitude; double? get magnitude; JmaForecastIntensity? get forecastMaxIntensity; bool? get forecastMaxIntensityIsOver; JmaForecastLgIntensity? get forecastMaxLpgmIntensity; bool? get forecastMaxLpgmIntensityIsOver; List<EstimatedIntensityRegion>? get regions;
/// Create a copy of EewV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewV1CopyWith<EewV1> get copyWith => _$EewV1CopyWithImpl<EewV1>(this as EewV1, _$identity);

  /// Serializes this EewV1 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewV1&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.schemaType, schemaType) || other.schemaType == schemaType)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypoName, hypoName) || other.hypoName == hypoName)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.forecastMaxIntensity, forecastMaxIntensity) || other.forecastMaxIntensity == forecastMaxIntensity)&&(identical(other.forecastMaxIntensityIsOver, forecastMaxIntensityIsOver) || other.forecastMaxIntensityIsOver == forecastMaxIntensityIsOver)&&(identical(other.forecastMaxLpgmIntensity, forecastMaxLpgmIntensity) || other.forecastMaxLpgmIntensity == forecastMaxLpgmIntensity)&&(identical(other.forecastMaxLpgmIntensityIsOver, forecastMaxLpgmIntensityIsOver) || other.forecastMaxLpgmIntensityIsOver == forecastMaxLpgmIntensityIsOver)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,eventId,type,schemaType,status,infoType,reportTime,isCanceled,isLastInfo,isPlum,accuracy,serialNo,headline,isWarning,originTime,arrivalTime,hypoName,depth,latitude,longitude,magnitude,forecastMaxIntensity,forecastMaxIntensityIsOver,forecastMaxLpgmIntensity,forecastMaxLpgmIntensityIsOver,const DeepCollectionEquality().hash(regions)]);

@override
String toString() {
  return 'EewV1(id: $id, eventId: $eventId, type: $type, schemaType: $schemaType, status: $status, infoType: $infoType, reportTime: $reportTime, isCanceled: $isCanceled, isLastInfo: $isLastInfo, isPlum: $isPlum, accuracy: $accuracy, serialNo: $serialNo, headline: $headline, isWarning: $isWarning, originTime: $originTime, arrivalTime: $arrivalTime, hypoName: $hypoName, depth: $depth, latitude: $latitude, longitude: $longitude, magnitude: $magnitude, forecastMaxIntensity: $forecastMaxIntensity, forecastMaxIntensityIsOver: $forecastMaxIntensityIsOver, forecastMaxLpgmIntensity: $forecastMaxLpgmIntensity, forecastMaxLpgmIntensityIsOver: $forecastMaxLpgmIntensityIsOver, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $EewV1CopyWith<$Res>  {
  factory $EewV1CopyWith(EewV1 value, $Res Function(EewV1) _then) = _$EewV1CopyWithImpl;
@useResult
$Res call({
 int id, int eventId, String type, String schemaType, String status, String infoType, DateTime reportTime, bool isCanceled, bool isLastInfo, bool? isPlum, EewAccuracy? accuracy, int? serialNo, String? headline, bool? isWarning, DateTime? originTime, DateTime? arrivalTime, String? hypoName, int? depth, double? latitude, double? longitude, double? magnitude, JmaForecastIntensity? forecastMaxIntensity, bool? forecastMaxIntensityIsOver, JmaForecastLgIntensity? forecastMaxLpgmIntensity, bool? forecastMaxLpgmIntensityIsOver, List<EstimatedIntensityRegion>? regions
});


$EewAccuracyCopyWith<$Res>? get accuracy;

}
/// @nodoc
class _$EewV1CopyWithImpl<$Res>
    implements $EewV1CopyWith<$Res> {
  _$EewV1CopyWithImpl(this._self, this._then);

  final EewV1 _self;
  final $Res Function(EewV1) _then;

/// Create a copy of EewV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? type = null,Object? schemaType = null,Object? status = null,Object? infoType = null,Object? reportTime = null,Object? isCanceled = null,Object? isLastInfo = null,Object? isPlum = freezed,Object? accuracy = freezed,Object? serialNo = freezed,Object? headline = freezed,Object? isWarning = freezed,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypoName = freezed,Object? depth = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? magnitude = freezed,Object? forecastMaxIntensity = freezed,Object? forecastMaxIntensityIsOver = freezed,Object? forecastMaxLpgmIntensity = freezed,Object? forecastMaxLpgmIntensityIsOver = freezed,Object? regions = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,schemaType: null == schemaType ? _self.schemaType : schemaType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as String,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isLastInfo: null == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool,isPlum: freezed == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as EewAccuracy?,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypoName: freezed == hypoName ? _self.hypoName : hypoName // ignore: cast_nullable_to_non_nullable
as String?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,forecastMaxIntensity: freezed == forecastMaxIntensity ? _self.forecastMaxIntensity : forecastMaxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity?,forecastMaxIntensityIsOver: freezed == forecastMaxIntensityIsOver ? _self.forecastMaxIntensityIsOver : forecastMaxIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool?,forecastMaxLpgmIntensity: freezed == forecastMaxLpgmIntensity ? _self.forecastMaxLpgmIntensity : forecastMaxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastLgIntensity?,forecastMaxLpgmIntensityIsOver: freezed == forecastMaxLpgmIntensityIsOver ? _self.forecastMaxLpgmIntensityIsOver : forecastMaxLpgmIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool?,regions: freezed == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<EstimatedIntensityRegion>?,
  ));
}
/// Create a copy of EewV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewAccuracyCopyWith<$Res>? get accuracy {
    if (_self.accuracy == null) {
    return null;
  }

  return $EewAccuracyCopyWith<$Res>(_self.accuracy!, (value) {
    return _then(_self.copyWith(accuracy: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _EewV1 extends EewV1 {
  const _EewV1({required this.id, required this.eventId, required this.type, required this.schemaType, required this.status, required this.infoType, required this.reportTime, required this.isCanceled, required this.isLastInfo, required this.isPlum, required this.accuracy, this.serialNo, this.headline, this.isWarning, this.originTime, this.arrivalTime, this.hypoName, this.depth, this.latitude, this.longitude, this.magnitude, this.forecastMaxIntensity, this.forecastMaxIntensityIsOver, this.forecastMaxLpgmIntensity, this.forecastMaxLpgmIntensityIsOver, final  List<EstimatedIntensityRegion>? regions}): _regions = regions,super._();
  factory _EewV1.fromJson(Map<String, dynamic> json) => _$EewV1FromJson(json);

@override final  int id;
@override final  int eventId;
@override final  String type;
@override final  String schemaType;
@override final  String status;
@override final  String infoType;
@override final  DateTime reportTime;
@override final  bool isCanceled;
@override final  bool isLastInfo;
@override final  bool? isPlum;
@override final  EewAccuracy? accuracy;
@override final  int? serialNo;
@override final  String? headline;
@override final  bool? isWarning;
@override final  DateTime? originTime;
@override final  DateTime? arrivalTime;
@override final  String? hypoName;
@override final  int? depth;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? magnitude;
@override final  JmaForecastIntensity? forecastMaxIntensity;
@override final  bool? forecastMaxIntensityIsOver;
@override final  JmaForecastLgIntensity? forecastMaxLpgmIntensity;
@override final  bool? forecastMaxLpgmIntensityIsOver;
 final  List<EstimatedIntensityRegion>? _regions;
@override List<EstimatedIntensityRegion>? get regions {
  final value = _regions;
  if (value == null) return null;
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EewV1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewV1CopyWith<_EewV1> get copyWith => __$EewV1CopyWithImpl<_EewV1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewV1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewV1&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.schemaType, schemaType) || other.schemaType == schemaType)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypoName, hypoName) || other.hypoName == hypoName)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.forecastMaxIntensity, forecastMaxIntensity) || other.forecastMaxIntensity == forecastMaxIntensity)&&(identical(other.forecastMaxIntensityIsOver, forecastMaxIntensityIsOver) || other.forecastMaxIntensityIsOver == forecastMaxIntensityIsOver)&&(identical(other.forecastMaxLpgmIntensity, forecastMaxLpgmIntensity) || other.forecastMaxLpgmIntensity == forecastMaxLpgmIntensity)&&(identical(other.forecastMaxLpgmIntensityIsOver, forecastMaxLpgmIntensityIsOver) || other.forecastMaxLpgmIntensityIsOver == forecastMaxLpgmIntensityIsOver)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,eventId,type,schemaType,status,infoType,reportTime,isCanceled,isLastInfo,isPlum,accuracy,serialNo,headline,isWarning,originTime,arrivalTime,hypoName,depth,latitude,longitude,magnitude,forecastMaxIntensity,forecastMaxIntensityIsOver,forecastMaxLpgmIntensity,forecastMaxLpgmIntensityIsOver,const DeepCollectionEquality().hash(_regions)]);

@override
String toString() {
  return 'EewV1(id: $id, eventId: $eventId, type: $type, schemaType: $schemaType, status: $status, infoType: $infoType, reportTime: $reportTime, isCanceled: $isCanceled, isLastInfo: $isLastInfo, isPlum: $isPlum, accuracy: $accuracy, serialNo: $serialNo, headline: $headline, isWarning: $isWarning, originTime: $originTime, arrivalTime: $arrivalTime, hypoName: $hypoName, depth: $depth, latitude: $latitude, longitude: $longitude, magnitude: $magnitude, forecastMaxIntensity: $forecastMaxIntensity, forecastMaxIntensityIsOver: $forecastMaxIntensityIsOver, forecastMaxLpgmIntensity: $forecastMaxLpgmIntensity, forecastMaxLpgmIntensityIsOver: $forecastMaxLpgmIntensityIsOver, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$EewV1CopyWith<$Res> implements $EewV1CopyWith<$Res> {
  factory _$EewV1CopyWith(_EewV1 value, $Res Function(_EewV1) _then) = __$EewV1CopyWithImpl;
@override @useResult
$Res call({
 int id, int eventId, String type, String schemaType, String status, String infoType, DateTime reportTime, bool isCanceled, bool isLastInfo, bool? isPlum, EewAccuracy? accuracy, int? serialNo, String? headline, bool? isWarning, DateTime? originTime, DateTime? arrivalTime, String? hypoName, int? depth, double? latitude, double? longitude, double? magnitude, JmaForecastIntensity? forecastMaxIntensity, bool? forecastMaxIntensityIsOver, JmaForecastLgIntensity? forecastMaxLpgmIntensity, bool? forecastMaxLpgmIntensityIsOver, List<EstimatedIntensityRegion>? regions
});


@override $EewAccuracyCopyWith<$Res>? get accuracy;

}
/// @nodoc
class __$EewV1CopyWithImpl<$Res>
    implements _$EewV1CopyWith<$Res> {
  __$EewV1CopyWithImpl(this._self, this._then);

  final _EewV1 _self;
  final $Res Function(_EewV1) _then;

/// Create a copy of EewV1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? type = null,Object? schemaType = null,Object? status = null,Object? infoType = null,Object? reportTime = null,Object? isCanceled = null,Object? isLastInfo = null,Object? isPlum = freezed,Object? accuracy = freezed,Object? serialNo = freezed,Object? headline = freezed,Object? isWarning = freezed,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypoName = freezed,Object? depth = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? magnitude = freezed,Object? forecastMaxIntensity = freezed,Object? forecastMaxIntensityIsOver = freezed,Object? forecastMaxLpgmIntensity = freezed,Object? forecastMaxLpgmIntensityIsOver = freezed,Object? regions = freezed,}) {
  return _then(_EewV1(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,schemaType: null == schemaType ? _self.schemaType : schemaType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as String,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isLastInfo: null == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool,isPlum: freezed == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as EewAccuracy?,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypoName: freezed == hypoName ? _self.hypoName : hypoName // ignore: cast_nullable_to_non_nullable
as String?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,forecastMaxIntensity: freezed == forecastMaxIntensity ? _self.forecastMaxIntensity : forecastMaxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity?,forecastMaxIntensityIsOver: freezed == forecastMaxIntensityIsOver ? _self.forecastMaxIntensityIsOver : forecastMaxIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool?,forecastMaxLpgmIntensity: freezed == forecastMaxLpgmIntensity ? _self.forecastMaxLpgmIntensity : forecastMaxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastLgIntensity?,forecastMaxLpgmIntensityIsOver: freezed == forecastMaxLpgmIntensityIsOver ? _self.forecastMaxLpgmIntensityIsOver : forecastMaxLpgmIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool?,regions: freezed == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<EstimatedIntensityRegion>?,
  ));
}

/// Create a copy of EewV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewAccuracyCopyWith<$Res>? get accuracy {
    if (_self.accuracy == null) {
    return null;
  }

  return $EewAccuracyCopyWith<$Res>(_self.accuracy!, (value) {
    return _then(_self.copyWith(accuracy: value));
  });
}
}


/// @nodoc
mixin _$EstimatedIntensityRegion {

 String get code; String get name;@JsonKey(name: 'isPlum') bool get isPlum;@JsonKey(name: 'isWarning') bool get isWarning;@JsonKey(name: 'forecastMaxInt') ForecastMaxInt get forecastMaxInt;@JsonKey(name: 'forecastMaxLgInt') ForecastMaxLgInt? get forecastMaxLgInt;/// nullの場合 `既に主要動到達と推測`
@JsonKey(name: 'arrivalTime') DateTime? get arrivalTime;
/// Create a copy of EstimatedIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimatedIntensityRegionCopyWith<EstimatedIntensityRegion> get copyWith => _$EstimatedIntensityRegionCopyWithImpl<EstimatedIntensityRegion>(this as EstimatedIntensityRegion, _$identity);

  /// Serializes this EstimatedIntensityRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimatedIntensityRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.forecastMaxInt, forecastMaxInt) || other.forecastMaxInt == forecastMaxInt)&&(identical(other.forecastMaxLgInt, forecastMaxLgInt) || other.forecastMaxLgInt == forecastMaxLgInt)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,isPlum,isWarning,forecastMaxInt,forecastMaxLgInt,arrivalTime);

@override
String toString() {
  return 'EstimatedIntensityRegion(code: $code, name: $name, isPlum: $isPlum, isWarning: $isWarning, forecastMaxInt: $forecastMaxInt, forecastMaxLgInt: $forecastMaxLgInt, arrivalTime: $arrivalTime)';
}


}

/// @nodoc
abstract mixin class $EstimatedIntensityRegionCopyWith<$Res>  {
  factory $EstimatedIntensityRegionCopyWith(EstimatedIntensityRegion value, $Res Function(EstimatedIntensityRegion) _then) = _$EstimatedIntensityRegionCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(name: 'isPlum') bool isPlum,@JsonKey(name: 'isWarning') bool isWarning,@JsonKey(name: 'forecastMaxInt') ForecastMaxInt forecastMaxInt,@JsonKey(name: 'forecastMaxLgInt') ForecastMaxLgInt? forecastMaxLgInt,@JsonKey(name: 'arrivalTime') DateTime? arrivalTime
});


$ForecastMaxIntCopyWith<$Res> get forecastMaxInt;$ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt;

}
/// @nodoc
class _$EstimatedIntensityRegionCopyWithImpl<$Res>
    implements $EstimatedIntensityRegionCopyWith<$Res> {
  _$EstimatedIntensityRegionCopyWithImpl(this._self, this._then);

  final EstimatedIntensityRegion _self;
  final $Res Function(EstimatedIntensityRegion) _then;

/// Create a copy of EstimatedIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? isPlum = null,Object? isWarning = null,Object? forecastMaxInt = null,Object? forecastMaxLgInt = freezed,Object? arrivalTime = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,forecastMaxInt: null == forecastMaxInt ? _self.forecastMaxInt : forecastMaxInt // ignore: cast_nullable_to_non_nullable
as ForecastMaxInt,forecastMaxLgInt: freezed == forecastMaxLgInt ? _self.forecastMaxLgInt : forecastMaxLgInt // ignore: cast_nullable_to_non_nullable
as ForecastMaxLgInt?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of EstimatedIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForecastMaxIntCopyWith<$Res> get forecastMaxInt {
  
  return $ForecastMaxIntCopyWith<$Res>(_self.forecastMaxInt, (value) {
    return _then(_self.copyWith(forecastMaxInt: value));
  });
}/// Create a copy of EstimatedIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt {
    if (_self.forecastMaxLgInt == null) {
    return null;
  }

  return $ForecastMaxLgIntCopyWith<$Res>(_self.forecastMaxLgInt!, (value) {
    return _then(_self.copyWith(forecastMaxLgInt: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _EstimatedIntensityRegion implements EstimatedIntensityRegion {
  const _EstimatedIntensityRegion({required this.code, required this.name, @JsonKey(name: 'isPlum') required this.isPlum, @JsonKey(name: 'isWarning') required this.isWarning, @JsonKey(name: 'forecastMaxInt') required this.forecastMaxInt, @JsonKey(name: 'forecastMaxLgInt') required this.forecastMaxLgInt, @JsonKey(name: 'arrivalTime') required this.arrivalTime});
  factory _EstimatedIntensityRegion.fromJson(Map<String, dynamic> json) => _$EstimatedIntensityRegionFromJson(json);

@override final  String code;
@override final  String name;
@override@JsonKey(name: 'isPlum') final  bool isPlum;
@override@JsonKey(name: 'isWarning') final  bool isWarning;
@override@JsonKey(name: 'forecastMaxInt') final  ForecastMaxInt forecastMaxInt;
@override@JsonKey(name: 'forecastMaxLgInt') final  ForecastMaxLgInt? forecastMaxLgInt;
/// nullの場合 `既に主要動到達と推測`
@override@JsonKey(name: 'arrivalTime') final  DateTime? arrivalTime;

/// Create a copy of EstimatedIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimatedIntensityRegionCopyWith<_EstimatedIntensityRegion> get copyWith => __$EstimatedIntensityRegionCopyWithImpl<_EstimatedIntensityRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimatedIntensityRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimatedIntensityRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.forecastMaxInt, forecastMaxInt) || other.forecastMaxInt == forecastMaxInt)&&(identical(other.forecastMaxLgInt, forecastMaxLgInt) || other.forecastMaxLgInt == forecastMaxLgInt)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,isPlum,isWarning,forecastMaxInt,forecastMaxLgInt,arrivalTime);

@override
String toString() {
  return 'EstimatedIntensityRegion(code: $code, name: $name, isPlum: $isPlum, isWarning: $isWarning, forecastMaxInt: $forecastMaxInt, forecastMaxLgInt: $forecastMaxLgInt, arrivalTime: $arrivalTime)';
}


}

/// @nodoc
abstract mixin class _$EstimatedIntensityRegionCopyWith<$Res> implements $EstimatedIntensityRegionCopyWith<$Res> {
  factory _$EstimatedIntensityRegionCopyWith(_EstimatedIntensityRegion value, $Res Function(_EstimatedIntensityRegion) _then) = __$EstimatedIntensityRegionCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(name: 'isPlum') bool isPlum,@JsonKey(name: 'isWarning') bool isWarning,@JsonKey(name: 'forecastMaxInt') ForecastMaxInt forecastMaxInt,@JsonKey(name: 'forecastMaxLgInt') ForecastMaxLgInt? forecastMaxLgInt,@JsonKey(name: 'arrivalTime') DateTime? arrivalTime
});


@override $ForecastMaxIntCopyWith<$Res> get forecastMaxInt;@override $ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt;

}
/// @nodoc
class __$EstimatedIntensityRegionCopyWithImpl<$Res>
    implements _$EstimatedIntensityRegionCopyWith<$Res> {
  __$EstimatedIntensityRegionCopyWithImpl(this._self, this._then);

  final _EstimatedIntensityRegion _self;
  final $Res Function(_EstimatedIntensityRegion) _then;

/// Create a copy of EstimatedIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? isPlum = null,Object? isWarning = null,Object? forecastMaxInt = null,Object? forecastMaxLgInt = freezed,Object? arrivalTime = freezed,}) {
  return _then(_EstimatedIntensityRegion(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,forecastMaxInt: null == forecastMaxInt ? _self.forecastMaxInt : forecastMaxInt // ignore: cast_nullable_to_non_nullable
as ForecastMaxInt,forecastMaxLgInt: freezed == forecastMaxLgInt ? _self.forecastMaxLgInt : forecastMaxLgInt // ignore: cast_nullable_to_non_nullable
as ForecastMaxLgInt?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of EstimatedIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForecastMaxIntCopyWith<$Res> get forecastMaxInt {
  
  return $ForecastMaxIntCopyWith<$Res>(_self.forecastMaxInt, (value) {
    return _then(_self.copyWith(forecastMaxInt: value));
  });
}/// Create a copy of EstimatedIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt {
    if (_self.forecastMaxLgInt == null) {
    return null;
  }

  return $ForecastMaxLgIntCopyWith<$Res>(_self.forecastMaxLgInt!, (value) {
    return _then(_self.copyWith(forecastMaxLgInt: value));
  });
}
}


/// @nodoc
mixin _$EewAccuracy {

/// ['0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8',
/// '0' | '1' | '2' | '3' | '4' | '9']
@JsonKey(fromJson: stringListToIntList, toJson: intListToStringList) List<int> get epicenters;@JsonKey(fromJson: int.parse, toJson: intToString) int get depth;@JsonKey(fromJson: int.parse, toJson: intToString) int get magnitudeCalculation;@JsonKey(fromJson: int.parse, toJson: intToString) int get numberOfMagnitudeCalculation;
/// Create a copy of EewAccuracy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewAccuracyCopyWith<EewAccuracy> get copyWith => _$EewAccuracyCopyWithImpl<EewAccuracy>(this as EewAccuracy, _$identity);

  /// Serializes this EewAccuracy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewAccuracy&&const DeepCollectionEquality().equals(other.epicenters, epicenters)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitudeCalculation, magnitudeCalculation) || other.magnitudeCalculation == magnitudeCalculation)&&(identical(other.numberOfMagnitudeCalculation, numberOfMagnitudeCalculation) || other.numberOfMagnitudeCalculation == numberOfMagnitudeCalculation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(epicenters),depth,magnitudeCalculation,numberOfMagnitudeCalculation);

@override
String toString() {
  return 'EewAccuracy(epicenters: $epicenters, depth: $depth, magnitudeCalculation: $magnitudeCalculation, numberOfMagnitudeCalculation: $numberOfMagnitudeCalculation)';
}


}

/// @nodoc
abstract mixin class $EewAccuracyCopyWith<$Res>  {
  factory $EewAccuracyCopyWith(EewAccuracy value, $Res Function(EewAccuracy) _then) = _$EewAccuracyCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: stringListToIntList, toJson: intListToStringList) List<int> epicenters,@JsonKey(fromJson: int.parse, toJson: intToString) int depth,@JsonKey(fromJson: int.parse, toJson: intToString) int magnitudeCalculation,@JsonKey(fromJson: int.parse, toJson: intToString) int numberOfMagnitudeCalculation
});




}
/// @nodoc
class _$EewAccuracyCopyWithImpl<$Res>
    implements $EewAccuracyCopyWith<$Res> {
  _$EewAccuracyCopyWithImpl(this._self, this._then);

  final EewAccuracy _self;
  final $Res Function(EewAccuracy) _then;

/// Create a copy of EewAccuracy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? epicenters = null,Object? depth = null,Object? magnitudeCalculation = null,Object? numberOfMagnitudeCalculation = null,}) {
  return _then(_self.copyWith(
epicenters: null == epicenters ? _self.epicenters : epicenters // ignore: cast_nullable_to_non_nullable
as List<int>,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,magnitudeCalculation: null == magnitudeCalculation ? _self.magnitudeCalculation : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation ? _self.numberOfMagnitudeCalculation : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _EewAccuracy implements EewAccuracy {
  const _EewAccuracy({@JsonKey(fromJson: stringListToIntList, toJson: intListToStringList) required final  List<int> epicenters, @JsonKey(fromJson: int.parse, toJson: intToString) required this.depth, @JsonKey(fromJson: int.parse, toJson: intToString) required this.magnitudeCalculation, @JsonKey(fromJson: int.parse, toJson: intToString) required this.numberOfMagnitudeCalculation}): _epicenters = epicenters;
  factory _EewAccuracy.fromJson(Map<String, dynamic> json) => _$EewAccuracyFromJson(json);

/// ['0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8',
/// '0' | '1' | '2' | '3' | '4' | '9']
 final  List<int> _epicenters;
/// ['0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8',
/// '0' | '1' | '2' | '3' | '4' | '9']
@override@JsonKey(fromJson: stringListToIntList, toJson: intListToStringList) List<int> get epicenters {
  if (_epicenters is EqualUnmodifiableListView) return _epicenters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_epicenters);
}

@override@JsonKey(fromJson: int.parse, toJson: intToString) final  int depth;
@override@JsonKey(fromJson: int.parse, toJson: intToString) final  int magnitudeCalculation;
@override@JsonKey(fromJson: int.parse, toJson: intToString) final  int numberOfMagnitudeCalculation;

/// Create a copy of EewAccuracy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewAccuracyCopyWith<_EewAccuracy> get copyWith => __$EewAccuracyCopyWithImpl<_EewAccuracy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewAccuracyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewAccuracy&&const DeepCollectionEquality().equals(other._epicenters, _epicenters)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitudeCalculation, magnitudeCalculation) || other.magnitudeCalculation == magnitudeCalculation)&&(identical(other.numberOfMagnitudeCalculation, numberOfMagnitudeCalculation) || other.numberOfMagnitudeCalculation == numberOfMagnitudeCalculation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_epicenters),depth,magnitudeCalculation,numberOfMagnitudeCalculation);

@override
String toString() {
  return 'EewAccuracy(epicenters: $epicenters, depth: $depth, magnitudeCalculation: $magnitudeCalculation, numberOfMagnitudeCalculation: $numberOfMagnitudeCalculation)';
}


}

/// @nodoc
abstract mixin class _$EewAccuracyCopyWith<$Res> implements $EewAccuracyCopyWith<$Res> {
  factory _$EewAccuracyCopyWith(_EewAccuracy value, $Res Function(_EewAccuracy) _then) = __$EewAccuracyCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: stringListToIntList, toJson: intListToStringList) List<int> epicenters,@JsonKey(fromJson: int.parse, toJson: intToString) int depth,@JsonKey(fromJson: int.parse, toJson: intToString) int magnitudeCalculation,@JsonKey(fromJson: int.parse, toJson: intToString) int numberOfMagnitudeCalculation
});




}
/// @nodoc
class __$EewAccuracyCopyWithImpl<$Res>
    implements _$EewAccuracyCopyWith<$Res> {
  __$EewAccuracyCopyWithImpl(this._self, this._then);

  final _EewAccuracy _self;
  final $Res Function(_EewAccuracy) _then;

/// Create a copy of EewAccuracy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? epicenters = null,Object? depth = null,Object? magnitudeCalculation = null,Object? numberOfMagnitudeCalculation = null,}) {
  return _then(_EewAccuracy(
epicenters: null == epicenters ? _self._epicenters : epicenters // ignore: cast_nullable_to_non_nullable
as List<int>,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,magnitudeCalculation: null == magnitudeCalculation ? _self.magnitudeCalculation : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation ? _self.numberOfMagnitudeCalculation : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ForecastMaxInt {

 JmaForecastIntensity get from; JmaForecastIntensityOver get to;
/// Create a copy of ForecastMaxInt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForecastMaxIntCopyWith<ForecastMaxInt> get copyWith => _$ForecastMaxIntCopyWithImpl<ForecastMaxInt>(this as ForecastMaxInt, _$identity);

  /// Serializes this ForecastMaxInt to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForecastMaxInt&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'ForecastMaxInt(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $ForecastMaxIntCopyWith<$Res>  {
  factory $ForecastMaxIntCopyWith(ForecastMaxInt value, $Res Function(ForecastMaxInt) _then) = _$ForecastMaxIntCopyWithImpl;
@useResult
$Res call({
 JmaForecastIntensity from, JmaForecastIntensityOver to
});




}
/// @nodoc
class _$ForecastMaxIntCopyWithImpl<$Res>
    implements $ForecastMaxIntCopyWith<$Res> {
  _$ForecastMaxIntCopyWithImpl(this._self, this._then);

  final ForecastMaxInt _self;
  final $Res Function(ForecastMaxInt) _then;

/// Create a copy of ForecastMaxInt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensityOver,
  ));
}

}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _ForecastMaxInt implements ForecastMaxInt {
  const _ForecastMaxInt({required this.from, required this.to});
  factory _ForecastMaxInt.fromJson(Map<String, dynamic> json) => _$ForecastMaxIntFromJson(json);

@override final  JmaForecastIntensity from;
@override final  JmaForecastIntensityOver to;

/// Create a copy of ForecastMaxInt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForecastMaxIntCopyWith<_ForecastMaxInt> get copyWith => __$ForecastMaxIntCopyWithImpl<_ForecastMaxInt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForecastMaxIntToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForecastMaxInt&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'ForecastMaxInt(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$ForecastMaxIntCopyWith<$Res> implements $ForecastMaxIntCopyWith<$Res> {
  factory _$ForecastMaxIntCopyWith(_ForecastMaxInt value, $Res Function(_ForecastMaxInt) _then) = __$ForecastMaxIntCopyWithImpl;
@override @useResult
$Res call({
 JmaForecastIntensity from, JmaForecastIntensityOver to
});




}
/// @nodoc
class __$ForecastMaxIntCopyWithImpl<$Res>
    implements _$ForecastMaxIntCopyWith<$Res> {
  __$ForecastMaxIntCopyWithImpl(this._self, this._then);

  final _ForecastMaxInt _self;
  final $Res Function(_ForecastMaxInt) _then;

/// Create a copy of ForecastMaxInt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,}) {
  return _then(_ForecastMaxInt(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensityOver,
  ));
}


}


/// @nodoc
mixin _$ForecastMaxLgInt {

 JmaForecastLgIntensity get from; JmaForecastLgIntensityOver get to;
/// Create a copy of ForecastMaxLgInt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForecastMaxLgIntCopyWith<ForecastMaxLgInt> get copyWith => _$ForecastMaxLgIntCopyWithImpl<ForecastMaxLgInt>(this as ForecastMaxLgInt, _$identity);

  /// Serializes this ForecastMaxLgInt to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForecastMaxLgInt&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'ForecastMaxLgInt(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $ForecastMaxLgIntCopyWith<$Res>  {
  factory $ForecastMaxLgIntCopyWith(ForecastMaxLgInt value, $Res Function(ForecastMaxLgInt) _then) = _$ForecastMaxLgIntCopyWithImpl;
@useResult
$Res call({
 JmaForecastLgIntensity from, JmaForecastLgIntensityOver to
});




}
/// @nodoc
class _$ForecastMaxLgIntCopyWithImpl<$Res>
    implements $ForecastMaxLgIntCopyWith<$Res> {
  _$ForecastMaxLgIntCopyWithImpl(this._self, this._then);

  final ForecastMaxLgInt _self;
  final $Res Function(ForecastMaxLgInt) _then;

/// Create a copy of ForecastMaxLgInt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as JmaForecastLgIntensity,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as JmaForecastLgIntensityOver,
  ));
}

}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _ForecastMaxLgInt implements ForecastMaxLgInt {
  const _ForecastMaxLgInt({required this.from, required this.to});
  factory _ForecastMaxLgInt.fromJson(Map<String, dynamic> json) => _$ForecastMaxLgIntFromJson(json);

@override final  JmaForecastLgIntensity from;
@override final  JmaForecastLgIntensityOver to;

/// Create a copy of ForecastMaxLgInt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForecastMaxLgIntCopyWith<_ForecastMaxLgInt> get copyWith => __$ForecastMaxLgIntCopyWithImpl<_ForecastMaxLgInt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForecastMaxLgIntToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForecastMaxLgInt&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'ForecastMaxLgInt(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$ForecastMaxLgIntCopyWith<$Res> implements $ForecastMaxLgIntCopyWith<$Res> {
  factory _$ForecastMaxLgIntCopyWith(_ForecastMaxLgInt value, $Res Function(_ForecastMaxLgInt) _then) = __$ForecastMaxLgIntCopyWithImpl;
@override @useResult
$Res call({
 JmaForecastLgIntensity from, JmaForecastLgIntensityOver to
});




}
/// @nodoc
class __$ForecastMaxLgIntCopyWithImpl<$Res>
    implements _$ForecastMaxLgIntCopyWith<$Res> {
  __$ForecastMaxLgIntCopyWithImpl(this._self, this._then);

  final _ForecastMaxLgInt _self;
  final $Res Function(_ForecastMaxLgInt) _then;

/// Create a copy of ForecastMaxLgInt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,}) {
  return _then(_ForecastMaxLgInt(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as JmaForecastLgIntensity,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as JmaForecastLgIntensityOver,
  ));
}


}

// dart format on
