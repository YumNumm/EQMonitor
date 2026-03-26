// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_item_with_relations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewItemWithRelations {

/// yyyyMMddHHmmss形式のイベントID
@JsonKey(name: 'event_id') String get eventId; TelegramType get type; TelegramStatus get status;@JsonKey(name: 'info_type') EewItemWithRelationsInfoType get infoType;@JsonKey(name: 'serial_no') num get serialNo;@JsonKey(includeIfNull: true) String? get headline;@JsonKey(name: 'is_canceled') bool get isCanceled;@JsonKey(includeIfNull: true, name: 'is_warning') bool? get isWarning;@JsonKey(name: 'is_last_info') bool get isLastInfo;@JsonKey(includeIfNull: true, name: 'origin_time') DateTime? get originTime;@JsonKey(includeIfNull: true, name: 'arrival_time') DateTime? get arrivalTime;@JsonKey(includeIfNull: true) EewAccuracy? get accuracy;@JsonKey(name: 'is_plum') bool get isPlum;@JsonKey(includeIfNull: true, name: 'editorial_office') String? get editorialOffice;@JsonKey(name: 'report_time') DateTime get reportTime;@JsonKey(includeIfNull: false) EewHypocenter? get hypocenter;@JsonKey(includeIfNull: false, name: 'forecast_intensity') EewIntensity? get forecastIntensity;@JsonKey(includeIfNull: false) EewWarning? get warning;
/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewItemWithRelationsCopyWith<EewItemWithRelations> get copyWith => _$EewItemWithRelationsCopyWithImpl<EewItemWithRelations>(this as EewItemWithRelations, _$identity);

  /// Serializes this EewItemWithRelations to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewItemWithRelations&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.forecastIntensity, forecastIntensity) || other.forecastIntensity == forecastIntensity)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,type,status,infoType,serialNo,headline,isCanceled,isWarning,isLastInfo,originTime,arrivalTime,accuracy,isPlum,editorialOffice,reportTime,hypocenter,forecastIntensity,warning);

@override
String toString() {
  return 'EewItemWithRelations(eventId: $eventId, type: $type, status: $status, infoType: $infoType, serialNo: $serialNo, headline: $headline, isCanceled: $isCanceled, isWarning: $isWarning, isLastInfo: $isLastInfo, originTime: $originTime, arrivalTime: $arrivalTime, accuracy: $accuracy, isPlum: $isPlum, editorialOffice: $editorialOffice, reportTime: $reportTime, hypocenter: $hypocenter, forecastIntensity: $forecastIntensity, warning: $warning)';
}


}

/// @nodoc
abstract mixin class $EewItemWithRelationsCopyWith<$Res>  {
  factory $EewItemWithRelationsCopyWith(EewItemWithRelations value, $Res Function(EewItemWithRelations) _then) = _$EewItemWithRelationsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, TelegramType type, TelegramStatus status,@JsonKey(name: 'info_type') EewItemWithRelationsInfoType infoType,@JsonKey(name: 'serial_no') num serialNo,@JsonKey(includeIfNull: true) String? headline,@JsonKey(name: 'is_canceled') bool isCanceled,@JsonKey(includeIfNull: true, name: 'is_warning') bool? isWarning,@JsonKey(name: 'is_last_info') bool isLastInfo,@JsonKey(includeIfNull: true, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: true, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: true) EewAccuracy? accuracy,@JsonKey(name: 'is_plum') bool isPlum,@JsonKey(includeIfNull: true, name: 'editorial_office') String? editorialOffice,@JsonKey(name: 'report_time') DateTime reportTime,@JsonKey(includeIfNull: false) EewHypocenter? hypocenter,@JsonKey(includeIfNull: false, name: 'forecast_intensity') EewIntensity? forecastIntensity,@JsonKey(includeIfNull: false) EewWarning? warning
});


$EewAccuracyCopyWith<$Res>? get accuracy;$EewHypocenterCopyWith<$Res>? get hypocenter;$EewIntensityCopyWith<$Res>? get forecastIntensity;$EewWarningCopyWith<$Res>? get warning;

}
/// @nodoc
class _$EewItemWithRelationsCopyWithImpl<$Res>
    implements $EewItemWithRelationsCopyWith<$Res> {
  _$EewItemWithRelationsCopyWithImpl(this._self, this._then);

  final EewItemWithRelations _self;
  final $Res Function(EewItemWithRelations) _then;

/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? type = null,Object? status = null,Object? infoType = null,Object? serialNo = null,Object? headline = freezed,Object? isCanceled = null,Object? isWarning = freezed,Object? isLastInfo = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? accuracy = freezed,Object? isPlum = null,Object? editorialOffice = freezed,Object? reportTime = null,Object? hypocenter = freezed,Object? forecastIntensity = freezed,Object? warning = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as EewItemWithRelationsInfoType,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,isLastInfo: null == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as EewAccuracy?,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,editorialOffice: freezed == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String?,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EewHypocenter?,forecastIntensity: freezed == forecastIntensity ? _self.forecastIntensity : forecastIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensity?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as EewWarning?,
  ));
}
/// Create a copy of EewItemWithRelations
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
}/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $EewHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityCopyWith<$Res>? get forecastIntensity {
    if (_self.forecastIntensity == null) {
    return null;
  }

  return $EewIntensityCopyWith<$Res>(_self.forecastIntensity!, (value) {
    return _then(_self.copyWith(forecastIntensity: value));
  });
}/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewWarningCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $EewWarningCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewItemWithRelations].
extension EewItemWithRelationsPatterns on EewItemWithRelations {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewItemWithRelations value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewItemWithRelations() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewItemWithRelations value)  $default,){
final _that = this;
switch (_that) {
case _EewItemWithRelations():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewItemWithRelations value)?  $default,){
final _that = this;
switch (_that) {
case _EewItemWithRelations() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  TelegramType type,  TelegramStatus status, @JsonKey(name: 'info_type')  EewItemWithRelationsInfoType infoType, @JsonKey(name: 'serial_no')  num serialNo, @JsonKey(includeIfNull: true)  String? headline, @JsonKey(name: 'is_canceled')  bool isCanceled, @JsonKey(includeIfNull: true, name: 'is_warning')  bool? isWarning, @JsonKey(name: 'is_last_info')  bool isLastInfo, @JsonKey(includeIfNull: true, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: true, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: true)  EewAccuracy? accuracy, @JsonKey(name: 'is_plum')  bool isPlum, @JsonKey(includeIfNull: true, name: 'editorial_office')  String? editorialOffice, @JsonKey(name: 'report_time')  DateTime reportTime, @JsonKey(includeIfNull: false)  EewHypocenter? hypocenter, @JsonKey(includeIfNull: false, name: 'forecast_intensity')  EewIntensity? forecastIntensity, @JsonKey(includeIfNull: false)  EewWarning? warning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewItemWithRelations() when $default != null:
return $default(_that.eventId,_that.type,_that.status,_that.infoType,_that.serialNo,_that.headline,_that.isCanceled,_that.isWarning,_that.isLastInfo,_that.originTime,_that.arrivalTime,_that.accuracy,_that.isPlum,_that.editorialOffice,_that.reportTime,_that.hypocenter,_that.forecastIntensity,_that.warning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  TelegramType type,  TelegramStatus status, @JsonKey(name: 'info_type')  EewItemWithRelationsInfoType infoType, @JsonKey(name: 'serial_no')  num serialNo, @JsonKey(includeIfNull: true)  String? headline, @JsonKey(name: 'is_canceled')  bool isCanceled, @JsonKey(includeIfNull: true, name: 'is_warning')  bool? isWarning, @JsonKey(name: 'is_last_info')  bool isLastInfo, @JsonKey(includeIfNull: true, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: true, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: true)  EewAccuracy? accuracy, @JsonKey(name: 'is_plum')  bool isPlum, @JsonKey(includeIfNull: true, name: 'editorial_office')  String? editorialOffice, @JsonKey(name: 'report_time')  DateTime reportTime, @JsonKey(includeIfNull: false)  EewHypocenter? hypocenter, @JsonKey(includeIfNull: false, name: 'forecast_intensity')  EewIntensity? forecastIntensity, @JsonKey(includeIfNull: false)  EewWarning? warning)  $default,) {final _that = this;
switch (_that) {
case _EewItemWithRelations():
return $default(_that.eventId,_that.type,_that.status,_that.infoType,_that.serialNo,_that.headline,_that.isCanceled,_that.isWarning,_that.isLastInfo,_that.originTime,_that.arrivalTime,_that.accuracy,_that.isPlum,_that.editorialOffice,_that.reportTime,_that.hypocenter,_that.forecastIntensity,_that.warning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId,  TelegramType type,  TelegramStatus status, @JsonKey(name: 'info_type')  EewItemWithRelationsInfoType infoType, @JsonKey(name: 'serial_no')  num serialNo, @JsonKey(includeIfNull: true)  String? headline, @JsonKey(name: 'is_canceled')  bool isCanceled, @JsonKey(includeIfNull: true, name: 'is_warning')  bool? isWarning, @JsonKey(name: 'is_last_info')  bool isLastInfo, @JsonKey(includeIfNull: true, name: 'origin_time')  DateTime? originTime, @JsonKey(includeIfNull: true, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: true)  EewAccuracy? accuracy, @JsonKey(name: 'is_plum')  bool isPlum, @JsonKey(includeIfNull: true, name: 'editorial_office')  String? editorialOffice, @JsonKey(name: 'report_time')  DateTime reportTime, @JsonKey(includeIfNull: false)  EewHypocenter? hypocenter, @JsonKey(includeIfNull: false, name: 'forecast_intensity')  EewIntensity? forecastIntensity, @JsonKey(includeIfNull: false)  EewWarning? warning)?  $default,) {final _that = this;
switch (_that) {
case _EewItemWithRelations() when $default != null:
return $default(_that.eventId,_that.type,_that.status,_that.infoType,_that.serialNo,_that.headline,_that.isCanceled,_that.isWarning,_that.isLastInfo,_that.originTime,_that.arrivalTime,_that.accuracy,_that.isPlum,_that.editorialOffice,_that.reportTime,_that.hypocenter,_that.forecastIntensity,_that.warning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewItemWithRelations implements EewItemWithRelations {
  const _EewItemWithRelations({@JsonKey(name: 'event_id') required this.eventId, required this.type, required this.status, @JsonKey(name: 'info_type') required this.infoType, @JsonKey(name: 'serial_no') required this.serialNo, @JsonKey(includeIfNull: true) required this.headline, @JsonKey(name: 'is_canceled') required this.isCanceled, @JsonKey(includeIfNull: true, name: 'is_warning') required this.isWarning, @JsonKey(name: 'is_last_info') required this.isLastInfo, @JsonKey(includeIfNull: true, name: 'origin_time') required this.originTime, @JsonKey(includeIfNull: true, name: 'arrival_time') required this.arrivalTime, @JsonKey(includeIfNull: true) required this.accuracy, @JsonKey(name: 'is_plum') required this.isPlum, @JsonKey(includeIfNull: true, name: 'editorial_office') required this.editorialOffice, @JsonKey(name: 'report_time') required this.reportTime, @JsonKey(includeIfNull: false) this.hypocenter, @JsonKey(includeIfNull: false, name: 'forecast_intensity') this.forecastIntensity, @JsonKey(includeIfNull: false) this.warning});
  factory _EewItemWithRelations.fromJson(Map<String, dynamic> json) => _$EewItemWithRelationsFromJson(json);

/// yyyyMMddHHmmss形式のイベントID
@override@JsonKey(name: 'event_id') final  String eventId;
@override final  TelegramType type;
@override final  TelegramStatus status;
@override@JsonKey(name: 'info_type') final  EewItemWithRelationsInfoType infoType;
@override@JsonKey(name: 'serial_no') final  num serialNo;
@override@JsonKey(includeIfNull: true) final  String? headline;
@override@JsonKey(name: 'is_canceled') final  bool isCanceled;
@override@JsonKey(includeIfNull: true, name: 'is_warning') final  bool? isWarning;
@override@JsonKey(name: 'is_last_info') final  bool isLastInfo;
@override@JsonKey(includeIfNull: true, name: 'origin_time') final  DateTime? originTime;
@override@JsonKey(includeIfNull: true, name: 'arrival_time') final  DateTime? arrivalTime;
@override@JsonKey(includeIfNull: true) final  EewAccuracy? accuracy;
@override@JsonKey(name: 'is_plum') final  bool isPlum;
@override@JsonKey(includeIfNull: true, name: 'editorial_office') final  String? editorialOffice;
@override@JsonKey(name: 'report_time') final  DateTime reportTime;
@override@JsonKey(includeIfNull: false) final  EewHypocenter? hypocenter;
@override@JsonKey(includeIfNull: false, name: 'forecast_intensity') final  EewIntensity? forecastIntensity;
@override@JsonKey(includeIfNull: false) final  EewWarning? warning;

/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewItemWithRelationsCopyWith<_EewItemWithRelations> get copyWith => __$EewItemWithRelationsCopyWithImpl<_EewItemWithRelations>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewItemWithRelationsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewItemWithRelations&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.forecastIntensity, forecastIntensity) || other.forecastIntensity == forecastIntensity)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,type,status,infoType,serialNo,headline,isCanceled,isWarning,isLastInfo,originTime,arrivalTime,accuracy,isPlum,editorialOffice,reportTime,hypocenter,forecastIntensity,warning);

@override
String toString() {
  return 'EewItemWithRelations(eventId: $eventId, type: $type, status: $status, infoType: $infoType, serialNo: $serialNo, headline: $headline, isCanceled: $isCanceled, isWarning: $isWarning, isLastInfo: $isLastInfo, originTime: $originTime, arrivalTime: $arrivalTime, accuracy: $accuracy, isPlum: $isPlum, editorialOffice: $editorialOffice, reportTime: $reportTime, hypocenter: $hypocenter, forecastIntensity: $forecastIntensity, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$EewItemWithRelationsCopyWith<$Res> implements $EewItemWithRelationsCopyWith<$Res> {
  factory _$EewItemWithRelationsCopyWith(_EewItemWithRelations value, $Res Function(_EewItemWithRelations) _then) = __$EewItemWithRelationsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId, TelegramType type, TelegramStatus status,@JsonKey(name: 'info_type') EewItemWithRelationsInfoType infoType,@JsonKey(name: 'serial_no') num serialNo,@JsonKey(includeIfNull: true) String? headline,@JsonKey(name: 'is_canceled') bool isCanceled,@JsonKey(includeIfNull: true, name: 'is_warning') bool? isWarning,@JsonKey(name: 'is_last_info') bool isLastInfo,@JsonKey(includeIfNull: true, name: 'origin_time') DateTime? originTime,@JsonKey(includeIfNull: true, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: true) EewAccuracy? accuracy,@JsonKey(name: 'is_plum') bool isPlum,@JsonKey(includeIfNull: true, name: 'editorial_office') String? editorialOffice,@JsonKey(name: 'report_time') DateTime reportTime,@JsonKey(includeIfNull: false) EewHypocenter? hypocenter,@JsonKey(includeIfNull: false, name: 'forecast_intensity') EewIntensity? forecastIntensity,@JsonKey(includeIfNull: false) EewWarning? warning
});


@override $EewAccuracyCopyWith<$Res>? get accuracy;@override $EewHypocenterCopyWith<$Res>? get hypocenter;@override $EewIntensityCopyWith<$Res>? get forecastIntensity;@override $EewWarningCopyWith<$Res>? get warning;

}
/// @nodoc
class __$EewItemWithRelationsCopyWithImpl<$Res>
    implements _$EewItemWithRelationsCopyWith<$Res> {
  __$EewItemWithRelationsCopyWithImpl(this._self, this._then);

  final _EewItemWithRelations _self;
  final $Res Function(_EewItemWithRelations) _then;

/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? type = null,Object? status = null,Object? infoType = null,Object? serialNo = null,Object? headline = freezed,Object? isCanceled = null,Object? isWarning = freezed,Object? isLastInfo = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? accuracy = freezed,Object? isPlum = null,Object? editorialOffice = freezed,Object? reportTime = null,Object? hypocenter = freezed,Object? forecastIntensity = freezed,Object? warning = freezed,}) {
  return _then(_EewItemWithRelations(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as EewItemWithRelationsInfoType,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,isLastInfo: null == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as EewAccuracy?,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,editorialOffice: freezed == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String?,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EewHypocenter?,forecastIntensity: freezed == forecastIntensity ? _self.forecastIntensity : forecastIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensity?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as EewWarning?,
  ));
}

/// Create a copy of EewItemWithRelations
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
}/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $EewHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityCopyWith<$Res>? get forecastIntensity {
    if (_self.forecastIntensity == null) {
    return null;
  }

  return $EewIntensityCopyWith<$Res>(_self.forecastIntensity!, (value) {
    return _then(_self.copyWith(forecastIntensity: value));
  });
}/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewWarningCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $EewWarningCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}

// dart format on
