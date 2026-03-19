// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_telegram_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EewTelegramItem {

 String get eventId; TelegramStatus get status; TelegramInfoType get infoType; int get serialNo; bool get isCanceled; bool get isLastInfo; DateTime get reportTime; bool get isPlum; String? get headline; bool? get isWarning; DateTime? get originTime; DateTime? get arrivalTime; String? get editorialOffice; EewHypocenterInfo? get hypocenter; EewForecastIntensityInfo? get forecastIntensity; EewWarningInfo? get warning; EewAccuracyInfo? get accuracy;
/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewTelegramItemCopyWith<EewTelegramItem> get copyWith => _$EewTelegramItemCopyWithImpl<EewTelegramItem>(this as EewTelegramItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewTelegramItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.forecastIntensity, forecastIntensity) || other.forecastIntensity == forecastIntensity)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,status,infoType,serialNo,isCanceled,isLastInfo,reportTime,isPlum,headline,isWarning,originTime,arrivalTime,editorialOffice,hypocenter,forecastIntensity,warning,accuracy);

@override
String toString() {
  return 'EewTelegramItem(eventId: $eventId, status: $status, infoType: $infoType, serialNo: $serialNo, isCanceled: $isCanceled, isLastInfo: $isLastInfo, reportTime: $reportTime, isPlum: $isPlum, headline: $headline, isWarning: $isWarning, originTime: $originTime, arrivalTime: $arrivalTime, editorialOffice: $editorialOffice, hypocenter: $hypocenter, forecastIntensity: $forecastIntensity, warning: $warning, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class $EewTelegramItemCopyWith<$Res>  {
  factory $EewTelegramItemCopyWith(EewTelegramItem value, $Res Function(EewTelegramItem) _then) = _$EewTelegramItemCopyWithImpl;
@useResult
$Res call({
 String eventId, TelegramStatus status, TelegramInfoType infoType, int serialNo, bool isCanceled, bool isLastInfo, DateTime reportTime, bool isPlum, String? headline, bool? isWarning, DateTime? originTime, DateTime? arrivalTime, String? editorialOffice, EewHypocenterInfo? hypocenter, EewForecastIntensityInfo? forecastIntensity, EewWarningInfo? warning, EewAccuracyInfo? accuracy
});


$EewHypocenterInfoCopyWith<$Res>? get hypocenter;$EewForecastIntensityInfoCopyWith<$Res>? get forecastIntensity;$EewWarningInfoCopyWith<$Res>? get warning;$EewAccuracyInfoCopyWith<$Res>? get accuracy;

}
/// @nodoc
class _$EewTelegramItemCopyWithImpl<$Res>
    implements $EewTelegramItemCopyWith<$Res> {
  _$EewTelegramItemCopyWithImpl(this._self, this._then);

  final EewTelegramItem _self;
  final $Res Function(EewTelegramItem) _then;

/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? infoType = null,Object? serialNo = null,Object? isCanceled = null,Object? isLastInfo = null,Object? reportTime = null,Object? isPlum = null,Object? headline = freezed,Object? isWarning = freezed,Object? originTime = freezed,Object? arrivalTime = freezed,Object? editorialOffice = freezed,Object? hypocenter = freezed,Object? forecastIntensity = freezed,Object? warning = freezed,Object? accuracy = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isLastInfo: null == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,editorialOffice: freezed == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EewHypocenterInfo?,forecastIntensity: freezed == forecastIntensity ? _self.forecastIntensity : forecastIntensity // ignore: cast_nullable_to_non_nullable
as EewForecastIntensityInfo?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as EewWarningInfo?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as EewAccuracyInfo?,
  ));
}
/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewHypocenterInfoCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $EewHypocenterInfoCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewForecastIntensityInfoCopyWith<$Res>? get forecastIntensity {
    if (_self.forecastIntensity == null) {
    return null;
  }

  return $EewForecastIntensityInfoCopyWith<$Res>(_self.forecastIntensity!, (value) {
    return _then(_self.copyWith(forecastIntensity: value));
  });
}/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewWarningInfoCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $EewWarningInfoCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewAccuracyInfoCopyWith<$Res>? get accuracy {
    if (_self.accuracy == null) {
    return null;
  }

  return $EewAccuracyInfoCopyWith<$Res>(_self.accuracy!, (value) {
    return _then(_self.copyWith(accuracy: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewTelegramItem].
extension EewTelegramItemPatterns on EewTelegramItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewTelegramItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewTelegramItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewTelegramItem value)  $default,){
final _that = this;
switch (_that) {
case _EewTelegramItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewTelegramItem value)?  $default,){
final _that = this;
switch (_that) {
case _EewTelegramItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  TelegramStatus status,  TelegramInfoType infoType,  int serialNo,  bool isCanceled,  bool isLastInfo,  DateTime reportTime,  bool isPlum,  String? headline,  bool? isWarning,  DateTime? originTime,  DateTime? arrivalTime,  String? editorialOffice,  EewHypocenterInfo? hypocenter,  EewForecastIntensityInfo? forecastIntensity,  EewWarningInfo? warning,  EewAccuracyInfo? accuracy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewTelegramItem() when $default != null:
return $default(_that.eventId,_that.status,_that.infoType,_that.serialNo,_that.isCanceled,_that.isLastInfo,_that.reportTime,_that.isPlum,_that.headline,_that.isWarning,_that.originTime,_that.arrivalTime,_that.editorialOffice,_that.hypocenter,_that.forecastIntensity,_that.warning,_that.accuracy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  TelegramStatus status,  TelegramInfoType infoType,  int serialNo,  bool isCanceled,  bool isLastInfo,  DateTime reportTime,  bool isPlum,  String? headline,  bool? isWarning,  DateTime? originTime,  DateTime? arrivalTime,  String? editorialOffice,  EewHypocenterInfo? hypocenter,  EewForecastIntensityInfo? forecastIntensity,  EewWarningInfo? warning,  EewAccuracyInfo? accuracy)  $default,) {final _that = this;
switch (_that) {
case _EewTelegramItem():
return $default(_that.eventId,_that.status,_that.infoType,_that.serialNo,_that.isCanceled,_that.isLastInfo,_that.reportTime,_that.isPlum,_that.headline,_that.isWarning,_that.originTime,_that.arrivalTime,_that.editorialOffice,_that.hypocenter,_that.forecastIntensity,_that.warning,_that.accuracy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  TelegramStatus status,  TelegramInfoType infoType,  int serialNo,  bool isCanceled,  bool isLastInfo,  DateTime reportTime,  bool isPlum,  String? headline,  bool? isWarning,  DateTime? originTime,  DateTime? arrivalTime,  String? editorialOffice,  EewHypocenterInfo? hypocenter,  EewForecastIntensityInfo? forecastIntensity,  EewWarningInfo? warning,  EewAccuracyInfo? accuracy)?  $default,) {final _that = this;
switch (_that) {
case _EewTelegramItem() when $default != null:
return $default(_that.eventId,_that.status,_that.infoType,_that.serialNo,_that.isCanceled,_that.isLastInfo,_that.reportTime,_that.isPlum,_that.headline,_that.isWarning,_that.originTime,_that.arrivalTime,_that.editorialOffice,_that.hypocenter,_that.forecastIntensity,_that.warning,_that.accuracy);case _:
  return null;

}
}

}

/// @nodoc


class _EewTelegramItem extends EewTelegramItem {
  const _EewTelegramItem({required this.eventId, required this.status, required this.infoType, required this.serialNo, required this.isCanceled, required this.isLastInfo, required this.reportTime, required this.isPlum, this.headline, this.isWarning, this.originTime, this.arrivalTime, this.editorialOffice, this.hypocenter, this.forecastIntensity, this.warning, this.accuracy}): super._();
  

@override final  String eventId;
@override final  TelegramStatus status;
@override final  TelegramInfoType infoType;
@override final  int serialNo;
@override final  bool isCanceled;
@override final  bool isLastInfo;
@override final  DateTime reportTime;
@override final  bool isPlum;
@override final  String? headline;
@override final  bool? isWarning;
@override final  DateTime? originTime;
@override final  DateTime? arrivalTime;
@override final  String? editorialOffice;
@override final  EewHypocenterInfo? hypocenter;
@override final  EewForecastIntensityInfo? forecastIntensity;
@override final  EewWarningInfo? warning;
@override final  EewAccuracyInfo? accuracy;

/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewTelegramItemCopyWith<_EewTelegramItem> get copyWith => __$EewTelegramItemCopyWithImpl<_EewTelegramItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewTelegramItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.forecastIntensity, forecastIntensity) || other.forecastIntensity == forecastIntensity)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,status,infoType,serialNo,isCanceled,isLastInfo,reportTime,isPlum,headline,isWarning,originTime,arrivalTime,editorialOffice,hypocenter,forecastIntensity,warning,accuracy);

@override
String toString() {
  return 'EewTelegramItem(eventId: $eventId, status: $status, infoType: $infoType, serialNo: $serialNo, isCanceled: $isCanceled, isLastInfo: $isLastInfo, reportTime: $reportTime, isPlum: $isPlum, headline: $headline, isWarning: $isWarning, originTime: $originTime, arrivalTime: $arrivalTime, editorialOffice: $editorialOffice, hypocenter: $hypocenter, forecastIntensity: $forecastIntensity, warning: $warning, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class _$EewTelegramItemCopyWith<$Res> implements $EewTelegramItemCopyWith<$Res> {
  factory _$EewTelegramItemCopyWith(_EewTelegramItem value, $Res Function(_EewTelegramItem) _then) = __$EewTelegramItemCopyWithImpl;
@override @useResult
$Res call({
 String eventId, TelegramStatus status, TelegramInfoType infoType, int serialNo, bool isCanceled, bool isLastInfo, DateTime reportTime, bool isPlum, String? headline, bool? isWarning, DateTime? originTime, DateTime? arrivalTime, String? editorialOffice, EewHypocenterInfo? hypocenter, EewForecastIntensityInfo? forecastIntensity, EewWarningInfo? warning, EewAccuracyInfo? accuracy
});


@override $EewHypocenterInfoCopyWith<$Res>? get hypocenter;@override $EewForecastIntensityInfoCopyWith<$Res>? get forecastIntensity;@override $EewWarningInfoCopyWith<$Res>? get warning;@override $EewAccuracyInfoCopyWith<$Res>? get accuracy;

}
/// @nodoc
class __$EewTelegramItemCopyWithImpl<$Res>
    implements _$EewTelegramItemCopyWith<$Res> {
  __$EewTelegramItemCopyWithImpl(this._self, this._then);

  final _EewTelegramItem _self;
  final $Res Function(_EewTelegramItem) _then;

/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? infoType = null,Object? serialNo = null,Object? isCanceled = null,Object? isLastInfo = null,Object? reportTime = null,Object? isPlum = null,Object? headline = freezed,Object? isWarning = freezed,Object? originTime = freezed,Object? arrivalTime = freezed,Object? editorialOffice = freezed,Object? hypocenter = freezed,Object? forecastIntensity = freezed,Object? warning = freezed,Object? accuracy = freezed,}) {
  return _then(_EewTelegramItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isLastInfo: null == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,editorialOffice: freezed == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EewHypocenterInfo?,forecastIntensity: freezed == forecastIntensity ? _self.forecastIntensity : forecastIntensity // ignore: cast_nullable_to_non_nullable
as EewForecastIntensityInfo?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as EewWarningInfo?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as EewAccuracyInfo?,
  ));
}

/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewHypocenterInfoCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $EewHypocenterInfoCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewForecastIntensityInfoCopyWith<$Res>? get forecastIntensity {
    if (_self.forecastIntensity == null) {
    return null;
  }

  return $EewForecastIntensityInfoCopyWith<$Res>(_self.forecastIntensity!, (value) {
    return _then(_self.copyWith(forecastIntensity: value));
  });
}/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewWarningInfoCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $EewWarningInfoCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}/// Create a copy of EewTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewAccuracyInfoCopyWith<$Res>? get accuracy {
    if (_self.accuracy == null) {
    return null;
  }

  return $EewAccuracyInfoCopyWith<$Res>(_self.accuracy!, (value) {
    return _then(_self.copyWith(accuracy: value));
  });
}
}

/// @nodoc
mixin _$EewHypocenterInfo {

 String get code; String get name; bool get hasLatLng; String? get detailedCode; String? get detailedName; double? get latitude; double? get longitude; String? get coordinateCondition; double? get magnitude; int? get depth;
/// Create a copy of EewHypocenterInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewHypocenterInfoCopyWith<EewHypocenterInfo> get copyWith => _$EewHypocenterInfoCopyWithImpl<EewHypocenterInfo>(this as EewHypocenterInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewHypocenterInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.hasLatLng, hasLatLng) || other.hasLatLng == hasLatLng)&&(identical(other.detailedCode, detailedCode) || other.detailedCode == detailedCode)&&(identical(other.detailedName, detailedName) || other.detailedName == detailedName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.coordinateCondition, coordinateCondition) || other.coordinateCondition == coordinateCondition)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,hasLatLng,detailedCode,detailedName,latitude,longitude,coordinateCondition,magnitude,depth);

@override
String toString() {
  return 'EewHypocenterInfo(code: $code, name: $name, hasLatLng: $hasLatLng, detailedCode: $detailedCode, detailedName: $detailedName, latitude: $latitude, longitude: $longitude, coordinateCondition: $coordinateCondition, magnitude: $magnitude, depth: $depth)';
}


}

/// @nodoc
abstract mixin class $EewHypocenterInfoCopyWith<$Res>  {
  factory $EewHypocenterInfoCopyWith(EewHypocenterInfo value, $Res Function(EewHypocenterInfo) _then) = _$EewHypocenterInfoCopyWithImpl;
@useResult
$Res call({
 String code, String name, bool hasLatLng, String? detailedCode, String? detailedName, double? latitude, double? longitude, String? coordinateCondition, double? magnitude, int? depth
});




}
/// @nodoc
class _$EewHypocenterInfoCopyWithImpl<$Res>
    implements $EewHypocenterInfoCopyWith<$Res> {
  _$EewHypocenterInfoCopyWithImpl(this._self, this._then);

  final EewHypocenterInfo _self;
  final $Res Function(EewHypocenterInfo) _then;

/// Create a copy of EewHypocenterInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? hasLatLng = null,Object? detailedCode = freezed,Object? detailedName = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? coordinateCondition = freezed,Object? magnitude = freezed,Object? depth = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hasLatLng: null == hasLatLng ? _self.hasLatLng : hasLatLng // ignore: cast_nullable_to_non_nullable
as bool,detailedCode: freezed == detailedCode ? _self.detailedCode : detailedCode // ignore: cast_nullable_to_non_nullable
as String?,detailedName: freezed == detailedName ? _self.detailedName : detailedName // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,coordinateCondition: freezed == coordinateCondition ? _self.coordinateCondition : coordinateCondition // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [EewHypocenterInfo].
extension EewHypocenterInfoPatterns on EewHypocenterInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewHypocenterInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewHypocenterInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewHypocenterInfo value)  $default,){
final _that = this;
switch (_that) {
case _EewHypocenterInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewHypocenterInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EewHypocenterInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  bool hasLatLng,  String? detailedCode,  String? detailedName,  double? latitude,  double? longitude,  String? coordinateCondition,  double? magnitude,  int? depth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewHypocenterInfo() when $default != null:
return $default(_that.code,_that.name,_that.hasLatLng,_that.detailedCode,_that.detailedName,_that.latitude,_that.longitude,_that.coordinateCondition,_that.magnitude,_that.depth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  bool hasLatLng,  String? detailedCode,  String? detailedName,  double? latitude,  double? longitude,  String? coordinateCondition,  double? magnitude,  int? depth)  $default,) {final _that = this;
switch (_that) {
case _EewHypocenterInfo():
return $default(_that.code,_that.name,_that.hasLatLng,_that.detailedCode,_that.detailedName,_that.latitude,_that.longitude,_that.coordinateCondition,_that.magnitude,_that.depth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  bool hasLatLng,  String? detailedCode,  String? detailedName,  double? latitude,  double? longitude,  String? coordinateCondition,  double? magnitude,  int? depth)?  $default,) {final _that = this;
switch (_that) {
case _EewHypocenterInfo() when $default != null:
return $default(_that.code,_that.name,_that.hasLatLng,_that.detailedCode,_that.detailedName,_that.latitude,_that.longitude,_that.coordinateCondition,_that.magnitude,_that.depth);case _:
  return null;

}
}

}

/// @nodoc


class _EewHypocenterInfo implements EewHypocenterInfo {
  const _EewHypocenterInfo({required this.code, required this.name, required this.hasLatLng, this.detailedCode, this.detailedName, this.latitude, this.longitude, this.coordinateCondition, this.magnitude, this.depth});
  

@override final  String code;
@override final  String name;
@override final  bool hasLatLng;
@override final  String? detailedCode;
@override final  String? detailedName;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? coordinateCondition;
@override final  double? magnitude;
@override final  int? depth;

/// Create a copy of EewHypocenterInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewHypocenterInfoCopyWith<_EewHypocenterInfo> get copyWith => __$EewHypocenterInfoCopyWithImpl<_EewHypocenterInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewHypocenterInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.hasLatLng, hasLatLng) || other.hasLatLng == hasLatLng)&&(identical(other.detailedCode, detailedCode) || other.detailedCode == detailedCode)&&(identical(other.detailedName, detailedName) || other.detailedName == detailedName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.coordinateCondition, coordinateCondition) || other.coordinateCondition == coordinateCondition)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,hasLatLng,detailedCode,detailedName,latitude,longitude,coordinateCondition,magnitude,depth);

@override
String toString() {
  return 'EewHypocenterInfo(code: $code, name: $name, hasLatLng: $hasLatLng, detailedCode: $detailedCode, detailedName: $detailedName, latitude: $latitude, longitude: $longitude, coordinateCondition: $coordinateCondition, magnitude: $magnitude, depth: $depth)';
}


}

/// @nodoc
abstract mixin class _$EewHypocenterInfoCopyWith<$Res> implements $EewHypocenterInfoCopyWith<$Res> {
  factory _$EewHypocenterInfoCopyWith(_EewHypocenterInfo value, $Res Function(_EewHypocenterInfo) _then) = __$EewHypocenterInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, bool hasLatLng, String? detailedCode, String? detailedName, double? latitude, double? longitude, String? coordinateCondition, double? magnitude, int? depth
});




}
/// @nodoc
class __$EewHypocenterInfoCopyWithImpl<$Res>
    implements _$EewHypocenterInfoCopyWith<$Res> {
  __$EewHypocenterInfoCopyWithImpl(this._self, this._then);

  final _EewHypocenterInfo _self;
  final $Res Function(_EewHypocenterInfo) _then;

/// Create a copy of EewHypocenterInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? hasLatLng = null,Object? detailedCode = freezed,Object? detailedName = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? coordinateCondition = freezed,Object? magnitude = freezed,Object? depth = freezed,}) {
  return _then(_EewHypocenterInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hasLatLng: null == hasLatLng ? _self.hasLatLng : hasLatLng // ignore: cast_nullable_to_non_nullable
as bool,detailedCode: freezed == detailedCode ? _self.detailedCode : detailedCode // ignore: cast_nullable_to_non_nullable
as String?,detailedName: freezed == detailedName ? _self.detailedName : detailedName // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,coordinateCondition: freezed == coordinateCondition ? _self.coordinateCondition : coordinateCondition // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$EewForecastIntensityInfo {

 List<EewForecastRegionInfo> get regions;// TODO(eqmonitor_api): EewIntensityValue.value は Intensity 型（codegen バグ）
 JmaIntensity? get maxIntensity; bool get maxIntensityIsOver; JmaLpgmIntensity? get maxLpgmIntensity; bool get maxLpgmIntensityIsOver;
/// Create a copy of EewForecastIntensityInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewForecastIntensityInfoCopyWith<EewForecastIntensityInfo> get copyWith => _$EewForecastIntensityInfoCopyWithImpl<EewForecastIntensityInfo>(this as EewForecastIntensityInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewForecastIntensityInfo&&const DeepCollectionEquality().equals(other.regions, regions)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxIntensityIsOver, maxIntensityIsOver) || other.maxIntensityIsOver == maxIntensityIsOver)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.maxLpgmIntensityIsOver, maxLpgmIntensityIsOver) || other.maxLpgmIntensityIsOver == maxLpgmIntensityIsOver));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(regions),maxIntensity,maxIntensityIsOver,maxLpgmIntensity,maxLpgmIntensityIsOver);

@override
String toString() {
  return 'EewForecastIntensityInfo(regions: $regions, maxIntensity: $maxIntensity, maxIntensityIsOver: $maxIntensityIsOver, maxLpgmIntensity: $maxLpgmIntensity, maxLpgmIntensityIsOver: $maxLpgmIntensityIsOver)';
}


}

/// @nodoc
abstract mixin class $EewForecastIntensityInfoCopyWith<$Res>  {
  factory $EewForecastIntensityInfoCopyWith(EewForecastIntensityInfo value, $Res Function(EewForecastIntensityInfo) _then) = _$EewForecastIntensityInfoCopyWithImpl;
@useResult
$Res call({
 List<EewForecastRegionInfo> regions, JmaIntensity? maxIntensity, bool maxIntensityIsOver, JmaLpgmIntensity? maxLpgmIntensity, bool maxLpgmIntensityIsOver
});




}
/// @nodoc
class _$EewForecastIntensityInfoCopyWithImpl<$Res>
    implements $EewForecastIntensityInfoCopyWith<$Res> {
  _$EewForecastIntensityInfoCopyWithImpl(this._self, this._then);

  final EewForecastIntensityInfo _self;
  final $Res Function(EewForecastIntensityInfo) _then;

/// Create a copy of EewForecastIntensityInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regions = null,Object? maxIntensity = freezed,Object? maxIntensityIsOver = null,Object? maxLpgmIntensity = freezed,Object? maxLpgmIntensityIsOver = null,}) {
  return _then(_self.copyWith(
regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<EewForecastRegionInfo>,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxIntensityIsOver: null == maxIntensityIsOver ? _self.maxIntensityIsOver : maxIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,maxLpgmIntensityIsOver: null == maxLpgmIntensityIsOver ? _self.maxLpgmIntensityIsOver : maxLpgmIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewForecastIntensityInfo].
extension EewForecastIntensityInfoPatterns on EewForecastIntensityInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewForecastIntensityInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewForecastIntensityInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewForecastIntensityInfo value)  $default,){
final _that = this;
switch (_that) {
case _EewForecastIntensityInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewForecastIntensityInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EewForecastIntensityInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EewForecastRegionInfo> regions,  JmaIntensity? maxIntensity,  bool maxIntensityIsOver,  JmaLpgmIntensity? maxLpgmIntensity,  bool maxLpgmIntensityIsOver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewForecastIntensityInfo() when $default != null:
return $default(_that.regions,_that.maxIntensity,_that.maxIntensityIsOver,_that.maxLpgmIntensity,_that.maxLpgmIntensityIsOver);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EewForecastRegionInfo> regions,  JmaIntensity? maxIntensity,  bool maxIntensityIsOver,  JmaLpgmIntensity? maxLpgmIntensity,  bool maxLpgmIntensityIsOver)  $default,) {final _that = this;
switch (_that) {
case _EewForecastIntensityInfo():
return $default(_that.regions,_that.maxIntensity,_that.maxIntensityIsOver,_that.maxLpgmIntensity,_that.maxLpgmIntensityIsOver);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EewForecastRegionInfo> regions,  JmaIntensity? maxIntensity,  bool maxIntensityIsOver,  JmaLpgmIntensity? maxLpgmIntensity,  bool maxLpgmIntensityIsOver)?  $default,) {final _that = this;
switch (_that) {
case _EewForecastIntensityInfo() when $default != null:
return $default(_that.regions,_that.maxIntensity,_that.maxIntensityIsOver,_that.maxLpgmIntensity,_that.maxLpgmIntensityIsOver);case _:
  return null;

}
}

}

/// @nodoc


class _EewForecastIntensityInfo implements EewForecastIntensityInfo {
  const _EewForecastIntensityInfo({required final  List<EewForecastRegionInfo> regions, this.maxIntensity, this.maxIntensityIsOver = false, this.maxLpgmIntensity, this.maxLpgmIntensityIsOver = false}): _regions = regions;
  

 final  List<EewForecastRegionInfo> _regions;
@override List<EewForecastRegionInfo> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

// TODO(eqmonitor_api): EewIntensityValue.value は Intensity 型（codegen バグ）
@override final  JmaIntensity? maxIntensity;
@override@JsonKey() final  bool maxIntensityIsOver;
@override final  JmaLpgmIntensity? maxLpgmIntensity;
@override@JsonKey() final  bool maxLpgmIntensityIsOver;

/// Create a copy of EewForecastIntensityInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewForecastIntensityInfoCopyWith<_EewForecastIntensityInfo> get copyWith => __$EewForecastIntensityInfoCopyWithImpl<_EewForecastIntensityInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewForecastIntensityInfo&&const DeepCollectionEquality().equals(other._regions, _regions)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxIntensityIsOver, maxIntensityIsOver) || other.maxIntensityIsOver == maxIntensityIsOver)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.maxLpgmIntensityIsOver, maxLpgmIntensityIsOver) || other.maxLpgmIntensityIsOver == maxLpgmIntensityIsOver));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_regions),maxIntensity,maxIntensityIsOver,maxLpgmIntensity,maxLpgmIntensityIsOver);

@override
String toString() {
  return 'EewForecastIntensityInfo(regions: $regions, maxIntensity: $maxIntensity, maxIntensityIsOver: $maxIntensityIsOver, maxLpgmIntensity: $maxLpgmIntensity, maxLpgmIntensityIsOver: $maxLpgmIntensityIsOver)';
}


}

/// @nodoc
abstract mixin class _$EewForecastIntensityInfoCopyWith<$Res> implements $EewForecastIntensityInfoCopyWith<$Res> {
  factory _$EewForecastIntensityInfoCopyWith(_EewForecastIntensityInfo value, $Res Function(_EewForecastIntensityInfo) _then) = __$EewForecastIntensityInfoCopyWithImpl;
@override @useResult
$Res call({
 List<EewForecastRegionInfo> regions, JmaIntensity? maxIntensity, bool maxIntensityIsOver, JmaLpgmIntensity? maxLpgmIntensity, bool maxLpgmIntensityIsOver
});




}
/// @nodoc
class __$EewForecastIntensityInfoCopyWithImpl<$Res>
    implements _$EewForecastIntensityInfoCopyWith<$Res> {
  __$EewForecastIntensityInfoCopyWithImpl(this._self, this._then);

  final _EewForecastIntensityInfo _self;
  final $Res Function(_EewForecastIntensityInfo) _then;

/// Create a copy of EewForecastIntensityInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regions = null,Object? maxIntensity = freezed,Object? maxIntensityIsOver = null,Object? maxLpgmIntensity = freezed,Object? maxLpgmIntensityIsOver = null,}) {
  return _then(_EewForecastIntensityInfo(
regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<EewForecastRegionInfo>,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxIntensityIsOver: null == maxIntensityIsOver ? _self.maxIntensityIsOver : maxIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,maxLpgmIntensityIsOver: null == maxLpgmIntensityIsOver ? _self.maxLpgmIntensityIsOver : maxLpgmIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$EewForecastRegionInfo {

 String get code; String get name; bool get isPlum; bool get isWarning;// TODO(eqmonitor_api): EewIntensityValue.value は Intensity 型（codegen バグ）
 JmaIntensity get intensity; bool get intensityIsOver; JmaLpgmIntensity? get lpgmIntensity; bool get lpgmIntensityIsOver;
/// Create a copy of EewForecastRegionInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewForecastRegionInfoCopyWith<EewForecastRegionInfo> get copyWith => _$EewForecastRegionInfoCopyWithImpl<EewForecastRegionInfo>(this as EewForecastRegionInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewForecastRegionInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.intensityIsOver, intensityIsOver) || other.intensityIsOver == intensityIsOver)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.lpgmIntensityIsOver, lpgmIntensityIsOver) || other.lpgmIntensityIsOver == lpgmIntensityIsOver));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,isPlum,isWarning,intensity,intensityIsOver,lpgmIntensity,lpgmIntensityIsOver);

@override
String toString() {
  return 'EewForecastRegionInfo(code: $code, name: $name, isPlum: $isPlum, isWarning: $isWarning, intensity: $intensity, intensityIsOver: $intensityIsOver, lpgmIntensity: $lpgmIntensity, lpgmIntensityIsOver: $lpgmIntensityIsOver)';
}


}

/// @nodoc
abstract mixin class $EewForecastRegionInfoCopyWith<$Res>  {
  factory $EewForecastRegionInfoCopyWith(EewForecastRegionInfo value, $Res Function(EewForecastRegionInfo) _then) = _$EewForecastRegionInfoCopyWithImpl;
@useResult
$Res call({
 String code, String name, bool isPlum, bool isWarning, JmaIntensity intensity, bool intensityIsOver, JmaLpgmIntensity? lpgmIntensity, bool lpgmIntensityIsOver
});




}
/// @nodoc
class _$EewForecastRegionInfoCopyWithImpl<$Res>
    implements $EewForecastRegionInfoCopyWith<$Res> {
  _$EewForecastRegionInfoCopyWithImpl(this._self, this._then);

  final EewForecastRegionInfo _self;
  final $Res Function(EewForecastRegionInfo) _then;

/// Create a copy of EewForecastRegionInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? isPlum = null,Object? isWarning = null,Object? intensity = null,Object? intensityIsOver = null,Object? lpgmIntensity = freezed,Object? lpgmIntensityIsOver = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,intensityIsOver: null == intensityIsOver ? _self.intensityIsOver : intensityIsOver // ignore: cast_nullable_to_non_nullable
as bool,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,lpgmIntensityIsOver: null == lpgmIntensityIsOver ? _self.lpgmIntensityIsOver : lpgmIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewForecastRegionInfo].
extension EewForecastRegionInfoPatterns on EewForecastRegionInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewForecastRegionInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewForecastRegionInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewForecastRegionInfo value)  $default,){
final _that = this;
switch (_that) {
case _EewForecastRegionInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewForecastRegionInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EewForecastRegionInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  bool isPlum,  bool isWarning,  JmaIntensity intensity,  bool intensityIsOver,  JmaLpgmIntensity? lpgmIntensity,  bool lpgmIntensityIsOver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewForecastRegionInfo() when $default != null:
return $default(_that.code,_that.name,_that.isPlum,_that.isWarning,_that.intensity,_that.intensityIsOver,_that.lpgmIntensity,_that.lpgmIntensityIsOver);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  bool isPlum,  bool isWarning,  JmaIntensity intensity,  bool intensityIsOver,  JmaLpgmIntensity? lpgmIntensity,  bool lpgmIntensityIsOver)  $default,) {final _that = this;
switch (_that) {
case _EewForecastRegionInfo():
return $default(_that.code,_that.name,_that.isPlum,_that.isWarning,_that.intensity,_that.intensityIsOver,_that.lpgmIntensity,_that.lpgmIntensityIsOver);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  bool isPlum,  bool isWarning,  JmaIntensity intensity,  bool intensityIsOver,  JmaLpgmIntensity? lpgmIntensity,  bool lpgmIntensityIsOver)?  $default,) {final _that = this;
switch (_that) {
case _EewForecastRegionInfo() when $default != null:
return $default(_that.code,_that.name,_that.isPlum,_that.isWarning,_that.intensity,_that.intensityIsOver,_that.lpgmIntensity,_that.lpgmIntensityIsOver);case _:
  return null;

}
}

}

/// @nodoc


class _EewForecastRegionInfo implements EewForecastRegionInfo {
  const _EewForecastRegionInfo({required this.code, required this.name, required this.isPlum, required this.isWarning, required this.intensity, required this.intensityIsOver, this.lpgmIntensity, this.lpgmIntensityIsOver = false});
  

@override final  String code;
@override final  String name;
@override final  bool isPlum;
@override final  bool isWarning;
// TODO(eqmonitor_api): EewIntensityValue.value は Intensity 型（codegen バグ）
@override final  JmaIntensity intensity;
@override final  bool intensityIsOver;
@override final  JmaLpgmIntensity? lpgmIntensity;
@override@JsonKey() final  bool lpgmIntensityIsOver;

/// Create a copy of EewForecastRegionInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewForecastRegionInfoCopyWith<_EewForecastRegionInfo> get copyWith => __$EewForecastRegionInfoCopyWithImpl<_EewForecastRegionInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewForecastRegionInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.intensityIsOver, intensityIsOver) || other.intensityIsOver == intensityIsOver)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.lpgmIntensityIsOver, lpgmIntensityIsOver) || other.lpgmIntensityIsOver == lpgmIntensityIsOver));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,isPlum,isWarning,intensity,intensityIsOver,lpgmIntensity,lpgmIntensityIsOver);

@override
String toString() {
  return 'EewForecastRegionInfo(code: $code, name: $name, isPlum: $isPlum, isWarning: $isWarning, intensity: $intensity, intensityIsOver: $intensityIsOver, lpgmIntensity: $lpgmIntensity, lpgmIntensityIsOver: $lpgmIntensityIsOver)';
}


}

/// @nodoc
abstract mixin class _$EewForecastRegionInfoCopyWith<$Res> implements $EewForecastRegionInfoCopyWith<$Res> {
  factory _$EewForecastRegionInfoCopyWith(_EewForecastRegionInfo value, $Res Function(_EewForecastRegionInfo) _then) = __$EewForecastRegionInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, bool isPlum, bool isWarning, JmaIntensity intensity, bool intensityIsOver, JmaLpgmIntensity? lpgmIntensity, bool lpgmIntensityIsOver
});




}
/// @nodoc
class __$EewForecastRegionInfoCopyWithImpl<$Res>
    implements _$EewForecastRegionInfoCopyWith<$Res> {
  __$EewForecastRegionInfoCopyWithImpl(this._self, this._then);

  final _EewForecastRegionInfo _self;
  final $Res Function(_EewForecastRegionInfo) _then;

/// Create a copy of EewForecastRegionInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? isPlum = null,Object? isWarning = null,Object? intensity = null,Object? intensityIsOver = null,Object? lpgmIntensity = freezed,Object? lpgmIntensityIsOver = null,}) {
  return _then(_EewForecastRegionInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,intensityIsOver: null == intensityIsOver ? _self.intensityIsOver : intensityIsOver // ignore: cast_nullable_to_non_nullable
as bool,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,lpgmIntensityIsOver: null == lpgmIntensityIsOver ? _self.lpgmIntensityIsOver : lpgmIntensityIsOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$EewWarningInfo {

 List<EewWarningZoneInfo> get zones; List<EewWarningZoneInfo> get prefectures; List<EewWarningZoneInfo> get regions;
/// Create a copy of EewWarningInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewWarningInfoCopyWith<EewWarningInfo> get copyWith => _$EewWarningInfoCopyWithImpl<EewWarningInfo>(this as EewWarningInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewWarningInfo&&const DeepCollectionEquality().equals(other.zones, zones)&&const DeepCollectionEquality().equals(other.prefectures, prefectures)&&const DeepCollectionEquality().equals(other.regions, regions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(zones),const DeepCollectionEquality().hash(prefectures),const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'EewWarningInfo(zones: $zones, prefectures: $prefectures, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $EewWarningInfoCopyWith<$Res>  {
  factory $EewWarningInfoCopyWith(EewWarningInfo value, $Res Function(EewWarningInfo) _then) = _$EewWarningInfoCopyWithImpl;
@useResult
$Res call({
 List<EewWarningZoneInfo> zones, List<EewWarningZoneInfo> prefectures, List<EewWarningZoneInfo> regions
});




}
/// @nodoc
class _$EewWarningInfoCopyWithImpl<$Res>
    implements $EewWarningInfoCopyWith<$Res> {
  _$EewWarningInfoCopyWithImpl(this._self, this._then);

  final EewWarningInfo _self;
  final $Res Function(EewWarningInfo) _then;

/// Create a copy of EewWarningInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? zones = null,Object? prefectures = null,Object? regions = null,}) {
  return _then(_self.copyWith(
zones: null == zones ? _self.zones : zones // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneInfo>,prefectures: null == prefectures ? _self.prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneInfo>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [EewWarningInfo].
extension EewWarningInfoPatterns on EewWarningInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewWarningInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewWarningInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewWarningInfo value)  $default,){
final _that = this;
switch (_that) {
case _EewWarningInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewWarningInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EewWarningInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EewWarningZoneInfo> zones,  List<EewWarningZoneInfo> prefectures,  List<EewWarningZoneInfo> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewWarningInfo() when $default != null:
return $default(_that.zones,_that.prefectures,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EewWarningZoneInfo> zones,  List<EewWarningZoneInfo> prefectures,  List<EewWarningZoneInfo> regions)  $default,) {final _that = this;
switch (_that) {
case _EewWarningInfo():
return $default(_that.zones,_that.prefectures,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EewWarningZoneInfo> zones,  List<EewWarningZoneInfo> prefectures,  List<EewWarningZoneInfo> regions)?  $default,) {final _that = this;
switch (_that) {
case _EewWarningInfo() when $default != null:
return $default(_that.zones,_that.prefectures,_that.regions);case _:
  return null;

}
}

}

/// @nodoc


class _EewWarningInfo implements EewWarningInfo {
  const _EewWarningInfo({required final  List<EewWarningZoneInfo> zones, required final  List<EewWarningZoneInfo> prefectures, required final  List<EewWarningZoneInfo> regions}): _zones = zones,_prefectures = prefectures,_regions = regions;
  

 final  List<EewWarningZoneInfo> _zones;
@override List<EewWarningZoneInfo> get zones {
  if (_zones is EqualUnmodifiableListView) return _zones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_zones);
}

 final  List<EewWarningZoneInfo> _prefectures;
@override List<EewWarningZoneInfo> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}

 final  List<EewWarningZoneInfo> _regions;
@override List<EewWarningZoneInfo> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of EewWarningInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewWarningInfoCopyWith<_EewWarningInfo> get copyWith => __$EewWarningInfoCopyWithImpl<_EewWarningInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewWarningInfo&&const DeepCollectionEquality().equals(other._zones, _zones)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures)&&const DeepCollectionEquality().equals(other._regions, _regions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_zones),const DeepCollectionEquality().hash(_prefectures),const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'EewWarningInfo(zones: $zones, prefectures: $prefectures, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$EewWarningInfoCopyWith<$Res> implements $EewWarningInfoCopyWith<$Res> {
  factory _$EewWarningInfoCopyWith(_EewWarningInfo value, $Res Function(_EewWarningInfo) _then) = __$EewWarningInfoCopyWithImpl;
@override @useResult
$Res call({
 List<EewWarningZoneInfo> zones, List<EewWarningZoneInfo> prefectures, List<EewWarningZoneInfo> regions
});




}
/// @nodoc
class __$EewWarningInfoCopyWithImpl<$Res>
    implements _$EewWarningInfoCopyWith<$Res> {
  __$EewWarningInfoCopyWithImpl(this._self, this._then);

  final _EewWarningInfo _self;
  final $Res Function(_EewWarningInfo) _then;

/// Create a copy of EewWarningInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? zones = null,Object? prefectures = null,Object? regions = null,}) {
  return _then(_EewWarningInfo(
zones: null == zones ? _self._zones : zones // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneInfo>,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneInfo>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneInfo>,
  ));
}


}

/// @nodoc
mixin _$EewWarningZoneInfo {

 String get code; String get name; bool get hadWarning;
/// Create a copy of EewWarningZoneInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewWarningZoneInfoCopyWith<EewWarningZoneInfo> get copyWith => _$EewWarningZoneInfoCopyWithImpl<EewWarningZoneInfo>(this as EewWarningZoneInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewWarningZoneInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.hadWarning, hadWarning) || other.hadWarning == hadWarning));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,hadWarning);

@override
String toString() {
  return 'EewWarningZoneInfo(code: $code, name: $name, hadWarning: $hadWarning)';
}


}

/// @nodoc
abstract mixin class $EewWarningZoneInfoCopyWith<$Res>  {
  factory $EewWarningZoneInfoCopyWith(EewWarningZoneInfo value, $Res Function(EewWarningZoneInfo) _then) = _$EewWarningZoneInfoCopyWithImpl;
@useResult
$Res call({
 String code, String name, bool hadWarning
});




}
/// @nodoc
class _$EewWarningZoneInfoCopyWithImpl<$Res>
    implements $EewWarningZoneInfoCopyWith<$Res> {
  _$EewWarningZoneInfoCopyWithImpl(this._self, this._then);

  final EewWarningZoneInfo _self;
  final $Res Function(EewWarningZoneInfo) _then;

/// Create a copy of EewWarningZoneInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? hadWarning = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hadWarning: null == hadWarning ? _self.hadWarning : hadWarning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewWarningZoneInfo].
extension EewWarningZoneInfoPatterns on EewWarningZoneInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewWarningZoneInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewWarningZoneInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewWarningZoneInfo value)  $default,){
final _that = this;
switch (_that) {
case _EewWarningZoneInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewWarningZoneInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EewWarningZoneInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  bool hadWarning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewWarningZoneInfo() when $default != null:
return $default(_that.code,_that.name,_that.hadWarning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  bool hadWarning)  $default,) {final _that = this;
switch (_that) {
case _EewWarningZoneInfo():
return $default(_that.code,_that.name,_that.hadWarning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  bool hadWarning)?  $default,) {final _that = this;
switch (_that) {
case _EewWarningZoneInfo() when $default != null:
return $default(_that.code,_that.name,_that.hadWarning);case _:
  return null;

}
}

}

/// @nodoc


class _EewWarningZoneInfo implements EewWarningZoneInfo {
  const _EewWarningZoneInfo({required this.code, required this.name, required this.hadWarning});
  

@override final  String code;
@override final  String name;
@override final  bool hadWarning;

/// Create a copy of EewWarningZoneInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewWarningZoneInfoCopyWith<_EewWarningZoneInfo> get copyWith => __$EewWarningZoneInfoCopyWithImpl<_EewWarningZoneInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewWarningZoneInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.hadWarning, hadWarning) || other.hadWarning == hadWarning));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,hadWarning);

@override
String toString() {
  return 'EewWarningZoneInfo(code: $code, name: $name, hadWarning: $hadWarning)';
}


}

/// @nodoc
abstract mixin class _$EewWarningZoneInfoCopyWith<$Res> implements $EewWarningZoneInfoCopyWith<$Res> {
  factory _$EewWarningZoneInfoCopyWith(_EewWarningZoneInfo value, $Res Function(_EewWarningZoneInfo) _then) = __$EewWarningZoneInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, bool hadWarning
});




}
/// @nodoc
class __$EewWarningZoneInfoCopyWithImpl<$Res>
    implements _$EewWarningZoneInfoCopyWith<$Res> {
  __$EewWarningZoneInfoCopyWithImpl(this._self, this._then);

  final _EewWarningZoneInfo _self;
  final $Res Function(_EewWarningZoneInfo) _then;

/// Create a copy of EewWarningZoneInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? hadWarning = null,}) {
  return _then(_EewWarningZoneInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hadWarning: null == hadWarning ? _self.hadWarning : hadWarning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$EewAccuracyInfo {

 int get epicenter; int get hypocenter; int get depth; int get magnitudeCalculation; int get numberOfMagnitudeCalculation;
/// Create a copy of EewAccuracyInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewAccuracyInfoCopyWith<EewAccuracyInfo> get copyWith => _$EewAccuracyInfoCopyWithImpl<EewAccuracyInfo>(this as EewAccuracyInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewAccuracyInfo&&(identical(other.epicenter, epicenter) || other.epicenter == epicenter)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitudeCalculation, magnitudeCalculation) || other.magnitudeCalculation == magnitudeCalculation)&&(identical(other.numberOfMagnitudeCalculation, numberOfMagnitudeCalculation) || other.numberOfMagnitudeCalculation == numberOfMagnitudeCalculation));
}


@override
int get hashCode => Object.hash(runtimeType,epicenter,hypocenter,depth,magnitudeCalculation,numberOfMagnitudeCalculation);

@override
String toString() {
  return 'EewAccuracyInfo(epicenter: $epicenter, hypocenter: $hypocenter, depth: $depth, magnitudeCalculation: $magnitudeCalculation, numberOfMagnitudeCalculation: $numberOfMagnitudeCalculation)';
}


}

/// @nodoc
abstract mixin class $EewAccuracyInfoCopyWith<$Res>  {
  factory $EewAccuracyInfoCopyWith(EewAccuracyInfo value, $Res Function(EewAccuracyInfo) _then) = _$EewAccuracyInfoCopyWithImpl;
@useResult
$Res call({
 int epicenter, int hypocenter, int depth, int magnitudeCalculation, int numberOfMagnitudeCalculation
});




}
/// @nodoc
class _$EewAccuracyInfoCopyWithImpl<$Res>
    implements $EewAccuracyInfoCopyWith<$Res> {
  _$EewAccuracyInfoCopyWithImpl(this._self, this._then);

  final EewAccuracyInfo _self;
  final $Res Function(EewAccuracyInfo) _then;

/// Create a copy of EewAccuracyInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? epicenter = null,Object? hypocenter = null,Object? depth = null,Object? magnitudeCalculation = null,Object? numberOfMagnitudeCalculation = null,}) {
  return _then(_self.copyWith(
epicenter: null == epicenter ? _self.epicenter : epicenter // ignore: cast_nullable_to_non_nullable
as int,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as int,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,magnitudeCalculation: null == magnitudeCalculation ? _self.magnitudeCalculation : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation ? _self.numberOfMagnitudeCalculation : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EewAccuracyInfo].
extension EewAccuracyInfoPatterns on EewAccuracyInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewAccuracyInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewAccuracyInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewAccuracyInfo value)  $default,){
final _that = this;
switch (_that) {
case _EewAccuracyInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewAccuracyInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EewAccuracyInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int epicenter,  int hypocenter,  int depth,  int magnitudeCalculation,  int numberOfMagnitudeCalculation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewAccuracyInfo() when $default != null:
return $default(_that.epicenter,_that.hypocenter,_that.depth,_that.magnitudeCalculation,_that.numberOfMagnitudeCalculation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int epicenter,  int hypocenter,  int depth,  int magnitudeCalculation,  int numberOfMagnitudeCalculation)  $default,) {final _that = this;
switch (_that) {
case _EewAccuracyInfo():
return $default(_that.epicenter,_that.hypocenter,_that.depth,_that.magnitudeCalculation,_that.numberOfMagnitudeCalculation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int epicenter,  int hypocenter,  int depth,  int magnitudeCalculation,  int numberOfMagnitudeCalculation)?  $default,) {final _that = this;
switch (_that) {
case _EewAccuracyInfo() when $default != null:
return $default(_that.epicenter,_that.hypocenter,_that.depth,_that.magnitudeCalculation,_that.numberOfMagnitudeCalculation);case _:
  return null;

}
}

}

/// @nodoc


class _EewAccuracyInfo implements EewAccuracyInfo {
  const _EewAccuracyInfo({required this.epicenter, required this.hypocenter, required this.depth, required this.magnitudeCalculation, required this.numberOfMagnitudeCalculation});
  

@override final  int epicenter;
@override final  int hypocenter;
@override final  int depth;
@override final  int magnitudeCalculation;
@override final  int numberOfMagnitudeCalculation;

/// Create a copy of EewAccuracyInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewAccuracyInfoCopyWith<_EewAccuracyInfo> get copyWith => __$EewAccuracyInfoCopyWithImpl<_EewAccuracyInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewAccuracyInfo&&(identical(other.epicenter, epicenter) || other.epicenter == epicenter)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitudeCalculation, magnitudeCalculation) || other.magnitudeCalculation == magnitudeCalculation)&&(identical(other.numberOfMagnitudeCalculation, numberOfMagnitudeCalculation) || other.numberOfMagnitudeCalculation == numberOfMagnitudeCalculation));
}


@override
int get hashCode => Object.hash(runtimeType,epicenter,hypocenter,depth,magnitudeCalculation,numberOfMagnitudeCalculation);

@override
String toString() {
  return 'EewAccuracyInfo(epicenter: $epicenter, hypocenter: $hypocenter, depth: $depth, magnitudeCalculation: $magnitudeCalculation, numberOfMagnitudeCalculation: $numberOfMagnitudeCalculation)';
}


}

/// @nodoc
abstract mixin class _$EewAccuracyInfoCopyWith<$Res> implements $EewAccuracyInfoCopyWith<$Res> {
  factory _$EewAccuracyInfoCopyWith(_EewAccuracyInfo value, $Res Function(_EewAccuracyInfo) _then) = __$EewAccuracyInfoCopyWithImpl;
@override @useResult
$Res call({
 int epicenter, int hypocenter, int depth, int magnitudeCalculation, int numberOfMagnitudeCalculation
});




}
/// @nodoc
class __$EewAccuracyInfoCopyWithImpl<$Res>
    implements _$EewAccuracyInfoCopyWith<$Res> {
  __$EewAccuracyInfoCopyWithImpl(this._self, this._then);

  final _EewAccuracyInfo _self;
  final $Res Function(_EewAccuracyInfo) _then;

/// Create a copy of EewAccuracyInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? epicenter = null,Object? hypocenter = null,Object? depth = null,Object? magnitudeCalculation = null,Object? numberOfMagnitudeCalculation = null,}) {
  return _then(_EewAccuracyInfo(
epicenter: null == epicenter ? _self.epicenter : epicenter // ignore: cast_nullable_to_non_nullable
as int,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as int,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,magnitudeCalculation: null == magnitudeCalculation ? _self.magnitudeCalculation : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation ? _self.numberOfMagnitudeCalculation : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
