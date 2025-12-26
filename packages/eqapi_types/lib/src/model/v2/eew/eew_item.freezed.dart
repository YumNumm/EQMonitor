// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewItem {

/// yyyyMMddHHmmss形式のイベントID
 String get eventId; TelegramType get type; TelegramStatus get status; TelegramInfoType get infoType; int get serialNo; String? get headline; bool get isCanceled; bool? get isWarning; bool get isLastInfo; DateTime? get originTime; DateTime? get arrivalTime; EewHypocenter? get hypocenter; EewIntensity? get forecastIntensity; EewAccuracy? get accuracy; bool get isPlum; String? get editorialOffice; DateTime get reportTime;
/// Create a copy of EewItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewItemCopyWith<EewItem> get copyWith => _$EewItemCopyWithImpl<EewItem>(this as EewItem, _$identity);

  /// Serializes this EewItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.forecastIntensity, forecastIntensity) || other.forecastIntensity == forecastIntensity)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,type,status,infoType,serialNo,headline,isCanceled,isWarning,isLastInfo,originTime,arrivalTime,hypocenter,forecastIntensity,accuracy,isPlum,editorialOffice,reportTime);

@override
String toString() {
  return 'EewItem(eventId: $eventId, type: $type, status: $status, infoType: $infoType, serialNo: $serialNo, headline: $headline, isCanceled: $isCanceled, isWarning: $isWarning, isLastInfo: $isLastInfo, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, forecastIntensity: $forecastIntensity, accuracy: $accuracy, isPlum: $isPlum, editorialOffice: $editorialOffice, reportTime: $reportTime)';
}


}

/// @nodoc
abstract mixin class $EewItemCopyWith<$Res>  {
  factory $EewItemCopyWith(EewItem value, $Res Function(EewItem) _then) = _$EewItemCopyWithImpl;
@useResult
$Res call({
 String eventId, TelegramType type, TelegramStatus status, TelegramInfoType infoType, int serialNo, String? headline, bool isCanceled, bool? isWarning, bool isLastInfo, DateTime? originTime, DateTime? arrivalTime, EewHypocenter? hypocenter, EewIntensity? forecastIntensity, EewAccuracy? accuracy, bool isPlum, String? editorialOffice, DateTime reportTime
});


$EewHypocenterCopyWith<$Res>? get hypocenter;$EewIntensityCopyWith<$Res>? get forecastIntensity;$EewAccuracyCopyWith<$Res>? get accuracy;

}
/// @nodoc
class _$EewItemCopyWithImpl<$Res>
    implements $EewItemCopyWith<$Res> {
  _$EewItemCopyWithImpl(this._self, this._then);

  final EewItem _self;
  final $Res Function(EewItem) _then;

/// Create a copy of EewItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? type = null,Object? status = null,Object? infoType = null,Object? serialNo = null,Object? headline = freezed,Object? isCanceled = null,Object? isWarning = freezed,Object? isLastInfo = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? forecastIntensity = freezed,Object? accuracy = freezed,Object? isPlum = null,Object? editorialOffice = freezed,Object? reportTime = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,isLastInfo: null == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EewHypocenter?,forecastIntensity: freezed == forecastIntensity ? _self.forecastIntensity : forecastIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensity?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as EewAccuracy?,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,editorialOffice: freezed == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String?,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of EewItem
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
}/// Create a copy of EewItem
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
}/// Create a copy of EewItem
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


/// Adds pattern-matching-related methods to [EewItem].
extension EewItemPatterns on EewItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewItem value)  $default,){
final _that = this;
switch (_that) {
case _EewItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewItem value)?  $default,){
final _that = this;
switch (_that) {
case _EewItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  TelegramType type,  TelegramStatus status,  TelegramInfoType infoType,  int serialNo,  String? headline,  bool isCanceled,  bool? isWarning,  bool isLastInfo,  DateTime? originTime,  DateTime? arrivalTime,  EewHypocenter? hypocenter,  EewIntensity? forecastIntensity,  EewAccuracy? accuracy,  bool isPlum,  String? editorialOffice,  DateTime reportTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewItem() when $default != null:
return $default(_that.eventId,_that.type,_that.status,_that.infoType,_that.serialNo,_that.headline,_that.isCanceled,_that.isWarning,_that.isLastInfo,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.forecastIntensity,_that.accuracy,_that.isPlum,_that.editorialOffice,_that.reportTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  TelegramType type,  TelegramStatus status,  TelegramInfoType infoType,  int serialNo,  String? headline,  bool isCanceled,  bool? isWarning,  bool isLastInfo,  DateTime? originTime,  DateTime? arrivalTime,  EewHypocenter? hypocenter,  EewIntensity? forecastIntensity,  EewAccuracy? accuracy,  bool isPlum,  String? editorialOffice,  DateTime reportTime)  $default,) {final _that = this;
switch (_that) {
case _EewItem():
return $default(_that.eventId,_that.type,_that.status,_that.infoType,_that.serialNo,_that.headline,_that.isCanceled,_that.isWarning,_that.isLastInfo,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.forecastIntensity,_that.accuracy,_that.isPlum,_that.editorialOffice,_that.reportTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  TelegramType type,  TelegramStatus status,  TelegramInfoType infoType,  int serialNo,  String? headline,  bool isCanceled,  bool? isWarning,  bool isLastInfo,  DateTime? originTime,  DateTime? arrivalTime,  EewHypocenter? hypocenter,  EewIntensity? forecastIntensity,  EewAccuracy? accuracy,  bool isPlum,  String? editorialOffice,  DateTime reportTime)?  $default,) {final _that = this;
switch (_that) {
case _EewItem() when $default != null:
return $default(_that.eventId,_that.type,_that.status,_that.infoType,_that.serialNo,_that.headline,_that.isCanceled,_that.isWarning,_that.isLastInfo,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.forecastIntensity,_that.accuracy,_that.isPlum,_that.editorialOffice,_that.reportTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewItem implements EewItem {
  const _EewItem({required this.eventId, required this.type, required this.status, required this.infoType, required this.serialNo, this.headline, required this.isCanceled, this.isWarning, required this.isLastInfo, this.originTime, this.arrivalTime, this.hypocenter, this.forecastIntensity, this.accuracy, required this.isPlum, this.editorialOffice, required this.reportTime});
  factory _EewItem.fromJson(Map<String, dynamic> json) => _$EewItemFromJson(json);

/// yyyyMMddHHmmss形式のイベントID
@override final  String eventId;
@override final  TelegramType type;
@override final  TelegramStatus status;
@override final  TelegramInfoType infoType;
@override final  int serialNo;
@override final  String? headline;
@override final  bool isCanceled;
@override final  bool? isWarning;
@override final  bool isLastInfo;
@override final  DateTime? originTime;
@override final  DateTime? arrivalTime;
@override final  EewHypocenter? hypocenter;
@override final  EewIntensity? forecastIntensity;
@override final  EewAccuracy? accuracy;
@override final  bool isPlum;
@override final  String? editorialOffice;
@override final  DateTime reportTime;

/// Create a copy of EewItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewItemCopyWith<_EewItem> get copyWith => __$EewItemCopyWithImpl<_EewItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.forecastIntensity, forecastIntensity) || other.forecastIntensity == forecastIntensity)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,type,status,infoType,serialNo,headline,isCanceled,isWarning,isLastInfo,originTime,arrivalTime,hypocenter,forecastIntensity,accuracy,isPlum,editorialOffice,reportTime);

@override
String toString() {
  return 'EewItem(eventId: $eventId, type: $type, status: $status, infoType: $infoType, serialNo: $serialNo, headline: $headline, isCanceled: $isCanceled, isWarning: $isWarning, isLastInfo: $isLastInfo, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, forecastIntensity: $forecastIntensity, accuracy: $accuracy, isPlum: $isPlum, editorialOffice: $editorialOffice, reportTime: $reportTime)';
}


}

/// @nodoc
abstract mixin class _$EewItemCopyWith<$Res> implements $EewItemCopyWith<$Res> {
  factory _$EewItemCopyWith(_EewItem value, $Res Function(_EewItem) _then) = __$EewItemCopyWithImpl;
@override @useResult
$Res call({
 String eventId, TelegramType type, TelegramStatus status, TelegramInfoType infoType, int serialNo, String? headline, bool isCanceled, bool? isWarning, bool isLastInfo, DateTime? originTime, DateTime? arrivalTime, EewHypocenter? hypocenter, EewIntensity? forecastIntensity, EewAccuracy? accuracy, bool isPlum, String? editorialOffice, DateTime reportTime
});


@override $EewHypocenterCopyWith<$Res>? get hypocenter;@override $EewIntensityCopyWith<$Res>? get forecastIntensity;@override $EewAccuracyCopyWith<$Res>? get accuracy;

}
/// @nodoc
class __$EewItemCopyWithImpl<$Res>
    implements _$EewItemCopyWith<$Res> {
  __$EewItemCopyWithImpl(this._self, this._then);

  final _EewItem _self;
  final $Res Function(_EewItem) _then;

/// Create a copy of EewItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? type = null,Object? status = null,Object? infoType = null,Object? serialNo = null,Object? headline = freezed,Object? isCanceled = null,Object? isWarning = freezed,Object? isLastInfo = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? forecastIntensity = freezed,Object? accuracy = freezed,Object? isPlum = null,Object? editorialOffice = freezed,Object? reportTime = null,}) {
  return _then(_EewItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,isLastInfo: null == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EewHypocenter?,forecastIntensity: freezed == forecastIntensity ? _self.forecastIntensity : forecastIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensity?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as EewAccuracy?,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,editorialOffice: freezed == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String?,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of EewItem
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
}/// Create a copy of EewItem
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
}/// Create a copy of EewItem
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
mixin _$EewItemWithRelations {

/// yyyyMMddHHmmss形式のイベントID
 String get eventId; TelegramType get type; TelegramStatus get status; TelegramInfoType get infoType; int get serialNo; String? get headline; bool get isCanceled; bool? get isWarning; bool get isLastInfo; DateTime? get originTime; DateTime? get arrivalTime; EewHypocenter? get hypocenter; EewIntensity? get forecastIntensity; EewAccuracy? get accuracy; bool get isPlum; String? get editorialOffice; DateTime get reportTime; List<EewIntensityItem> get intensityRegions; EewWarning? get warning;
/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewItemWithRelationsCopyWith<EewItemWithRelations> get copyWith => _$EewItemWithRelationsCopyWithImpl<EewItemWithRelations>(this as EewItemWithRelations, _$identity);

  /// Serializes this EewItemWithRelations to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewItemWithRelations&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.forecastIntensity, forecastIntensity) || other.forecastIntensity == forecastIntensity)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&const DeepCollectionEquality().equals(other.intensityRegions, intensityRegions)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,eventId,type,status,infoType,serialNo,headline,isCanceled,isWarning,isLastInfo,originTime,arrivalTime,hypocenter,forecastIntensity,accuracy,isPlum,editorialOffice,reportTime,const DeepCollectionEquality().hash(intensityRegions),warning]);

@override
String toString() {
  return 'EewItemWithRelations(eventId: $eventId, type: $type, status: $status, infoType: $infoType, serialNo: $serialNo, headline: $headline, isCanceled: $isCanceled, isWarning: $isWarning, isLastInfo: $isLastInfo, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, forecastIntensity: $forecastIntensity, accuracy: $accuracy, isPlum: $isPlum, editorialOffice: $editorialOffice, reportTime: $reportTime, intensityRegions: $intensityRegions, warning: $warning)';
}


}

/// @nodoc
abstract mixin class $EewItemWithRelationsCopyWith<$Res>  {
  factory $EewItemWithRelationsCopyWith(EewItemWithRelations value, $Res Function(EewItemWithRelations) _then) = _$EewItemWithRelationsCopyWithImpl;
@useResult
$Res call({
 String eventId, TelegramType type, TelegramStatus status, TelegramInfoType infoType, int serialNo, String? headline, bool isCanceled, bool? isWarning, bool isLastInfo, DateTime? originTime, DateTime? arrivalTime, EewHypocenter? hypocenter, EewIntensity? forecastIntensity, EewAccuracy? accuracy, bool isPlum, String? editorialOffice, DateTime reportTime, List<EewIntensityItem> intensityRegions, EewWarning? warning
});


$EewHypocenterCopyWith<$Res>? get hypocenter;$EewIntensityCopyWith<$Res>? get forecastIntensity;$EewAccuracyCopyWith<$Res>? get accuracy;$EewWarningCopyWith<$Res>? get warning;

}
/// @nodoc
class _$EewItemWithRelationsCopyWithImpl<$Res>
    implements $EewItemWithRelationsCopyWith<$Res> {
  _$EewItemWithRelationsCopyWithImpl(this._self, this._then);

  final EewItemWithRelations _self;
  final $Res Function(EewItemWithRelations) _then;

/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? type = null,Object? status = null,Object? infoType = null,Object? serialNo = null,Object? headline = freezed,Object? isCanceled = null,Object? isWarning = freezed,Object? isLastInfo = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? forecastIntensity = freezed,Object? accuracy = freezed,Object? isPlum = null,Object? editorialOffice = freezed,Object? reportTime = null,Object? intensityRegions = null,Object? warning = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,isLastInfo: null == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EewHypocenter?,forecastIntensity: freezed == forecastIntensity ? _self.forecastIntensity : forecastIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensity?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as EewAccuracy?,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,editorialOffice: freezed == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String?,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,intensityRegions: null == intensityRegions ? _self.intensityRegions : intensityRegions // ignore: cast_nullable_to_non_nullable
as List<EewIntensityItem>,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as EewWarning?,
  ));
}
/// Create a copy of EewItemWithRelations
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  TelegramType type,  TelegramStatus status,  TelegramInfoType infoType,  int serialNo,  String? headline,  bool isCanceled,  bool? isWarning,  bool isLastInfo,  DateTime? originTime,  DateTime? arrivalTime,  EewHypocenter? hypocenter,  EewIntensity? forecastIntensity,  EewAccuracy? accuracy,  bool isPlum,  String? editorialOffice,  DateTime reportTime,  List<EewIntensityItem> intensityRegions,  EewWarning? warning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewItemWithRelations() when $default != null:
return $default(_that.eventId,_that.type,_that.status,_that.infoType,_that.serialNo,_that.headline,_that.isCanceled,_that.isWarning,_that.isLastInfo,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.forecastIntensity,_that.accuracy,_that.isPlum,_that.editorialOffice,_that.reportTime,_that.intensityRegions,_that.warning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  TelegramType type,  TelegramStatus status,  TelegramInfoType infoType,  int serialNo,  String? headline,  bool isCanceled,  bool? isWarning,  bool isLastInfo,  DateTime? originTime,  DateTime? arrivalTime,  EewHypocenter? hypocenter,  EewIntensity? forecastIntensity,  EewAccuracy? accuracy,  bool isPlum,  String? editorialOffice,  DateTime reportTime,  List<EewIntensityItem> intensityRegions,  EewWarning? warning)  $default,) {final _that = this;
switch (_that) {
case _EewItemWithRelations():
return $default(_that.eventId,_that.type,_that.status,_that.infoType,_that.serialNo,_that.headline,_that.isCanceled,_that.isWarning,_that.isLastInfo,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.forecastIntensity,_that.accuracy,_that.isPlum,_that.editorialOffice,_that.reportTime,_that.intensityRegions,_that.warning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  TelegramType type,  TelegramStatus status,  TelegramInfoType infoType,  int serialNo,  String? headline,  bool isCanceled,  bool? isWarning,  bool isLastInfo,  DateTime? originTime,  DateTime? arrivalTime,  EewHypocenter? hypocenter,  EewIntensity? forecastIntensity,  EewAccuracy? accuracy,  bool isPlum,  String? editorialOffice,  DateTime reportTime,  List<EewIntensityItem> intensityRegions,  EewWarning? warning)?  $default,) {final _that = this;
switch (_that) {
case _EewItemWithRelations() when $default != null:
return $default(_that.eventId,_that.type,_that.status,_that.infoType,_that.serialNo,_that.headline,_that.isCanceled,_that.isWarning,_that.isLastInfo,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.forecastIntensity,_that.accuracy,_that.isPlum,_that.editorialOffice,_that.reportTime,_that.intensityRegions,_that.warning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewItemWithRelations implements EewItemWithRelations {
  const _EewItemWithRelations({required this.eventId, required this.type, required this.status, required this.infoType, required this.serialNo, this.headline, required this.isCanceled, this.isWarning, required this.isLastInfo, this.originTime, this.arrivalTime, this.hypocenter, this.forecastIntensity, this.accuracy, required this.isPlum, this.editorialOffice, required this.reportTime, required final  List<EewIntensityItem> intensityRegions, this.warning}): _intensityRegions = intensityRegions;
  factory _EewItemWithRelations.fromJson(Map<String, dynamic> json) => _$EewItemWithRelationsFromJson(json);

/// yyyyMMddHHmmss形式のイベントID
@override final  String eventId;
@override final  TelegramType type;
@override final  TelegramStatus status;
@override final  TelegramInfoType infoType;
@override final  int serialNo;
@override final  String? headline;
@override final  bool isCanceled;
@override final  bool? isWarning;
@override final  bool isLastInfo;
@override final  DateTime? originTime;
@override final  DateTime? arrivalTime;
@override final  EewHypocenter? hypocenter;
@override final  EewIntensity? forecastIntensity;
@override final  EewAccuracy? accuracy;
@override final  bool isPlum;
@override final  String? editorialOffice;
@override final  DateTime reportTime;
 final  List<EewIntensityItem> _intensityRegions;
@override List<EewIntensityItem> get intensityRegions {
  if (_intensityRegions is EqualUnmodifiableListView) return _intensityRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_intensityRegions);
}

@override final  EewWarning? warning;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewItemWithRelations&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.forecastIntensity, forecastIntensity) || other.forecastIntensity == forecastIntensity)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&const DeepCollectionEquality().equals(other._intensityRegions, _intensityRegions)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,eventId,type,status,infoType,serialNo,headline,isCanceled,isWarning,isLastInfo,originTime,arrivalTime,hypocenter,forecastIntensity,accuracy,isPlum,editorialOffice,reportTime,const DeepCollectionEquality().hash(_intensityRegions),warning]);

@override
String toString() {
  return 'EewItemWithRelations(eventId: $eventId, type: $type, status: $status, infoType: $infoType, serialNo: $serialNo, headline: $headline, isCanceled: $isCanceled, isWarning: $isWarning, isLastInfo: $isLastInfo, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, forecastIntensity: $forecastIntensity, accuracy: $accuracy, isPlum: $isPlum, editorialOffice: $editorialOffice, reportTime: $reportTime, intensityRegions: $intensityRegions, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$EewItemWithRelationsCopyWith<$Res> implements $EewItemWithRelationsCopyWith<$Res> {
  factory _$EewItemWithRelationsCopyWith(_EewItemWithRelations value, $Res Function(_EewItemWithRelations) _then) = __$EewItemWithRelationsCopyWithImpl;
@override @useResult
$Res call({
 String eventId, TelegramType type, TelegramStatus status, TelegramInfoType infoType, int serialNo, String? headline, bool isCanceled, bool? isWarning, bool isLastInfo, DateTime? originTime, DateTime? arrivalTime, EewHypocenter? hypocenter, EewIntensity? forecastIntensity, EewAccuracy? accuracy, bool isPlum, String? editorialOffice, DateTime reportTime, List<EewIntensityItem> intensityRegions, EewWarning? warning
});


@override $EewHypocenterCopyWith<$Res>? get hypocenter;@override $EewIntensityCopyWith<$Res>? get forecastIntensity;@override $EewAccuracyCopyWith<$Res>? get accuracy;@override $EewWarningCopyWith<$Res>? get warning;

}
/// @nodoc
class __$EewItemWithRelationsCopyWithImpl<$Res>
    implements _$EewItemWithRelationsCopyWith<$Res> {
  __$EewItemWithRelationsCopyWithImpl(this._self, this._then);

  final _EewItemWithRelations _self;
  final $Res Function(_EewItemWithRelations) _then;

/// Create a copy of EewItemWithRelations
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? type = null,Object? status = null,Object? infoType = null,Object? serialNo = null,Object? headline = freezed,Object? isCanceled = null,Object? isWarning = freezed,Object? isLastInfo = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? forecastIntensity = freezed,Object? accuracy = freezed,Object? isPlum = null,Object? editorialOffice = freezed,Object? reportTime = null,Object? intensityRegions = null,Object? warning = freezed,}) {
  return _then(_EewItemWithRelations(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,isLastInfo: null == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EewHypocenter?,forecastIntensity: freezed == forecastIntensity ? _self.forecastIntensity : forecastIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensity?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as EewAccuracy?,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,editorialOffice: freezed == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String?,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,intensityRegions: null == intensityRegions ? _self._intensityRegions : intensityRegions // ignore: cast_nullable_to_non_nullable
as List<EewIntensityItem>,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as EewWarning?,
  ));
}

/// Create a copy of EewItemWithRelations
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
