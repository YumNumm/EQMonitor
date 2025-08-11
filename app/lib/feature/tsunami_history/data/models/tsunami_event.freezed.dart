// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiEvent {

 String get eventId; DateTime get pressAt; DateTime get reportAt; String get status; String get infoType; String? get headline; DateTime? get validAt;/// 津波警報・注意報・予報 + 津波情報（VTSE41 + VTSE51をマージ）
 TsunamiInfo? get info;/// 沖合の津波観測（VTSE52）
 TsunamiObservationInfo? get observationInfo;
/// Create a copy of TsunamiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiEventCopyWith<TsunamiEvent> get copyWith => _$TsunamiEventCopyWithImpl<TsunamiEvent>(this as TsunamiEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.validAt, validAt) || other.validAt == validAt)&&(identical(other.info, info) || other.info == info)&&(identical(other.observationInfo, observationInfo) || other.observationInfo == observationInfo));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,pressAt,reportAt,status,infoType,headline,validAt,info,observationInfo);

@override
String toString() {
  return 'TsunamiEvent(eventId: $eventId, pressAt: $pressAt, reportAt: $reportAt, status: $status, infoType: $infoType, headline: $headline, validAt: $validAt, info: $info, observationInfo: $observationInfo)';
}


}

/// @nodoc
abstract mixin class $TsunamiEventCopyWith<$Res>  {
  factory $TsunamiEventCopyWith(TsunamiEvent value, $Res Function(TsunamiEvent) _then) = _$TsunamiEventCopyWithImpl;
@useResult
$Res call({
 String eventId, DateTime pressAt, DateTime reportAt, String status, String infoType, String? headline, DateTime? validAt, TsunamiInfo? info, TsunamiObservationInfo? observationInfo
});


$TsunamiInfoCopyWith<$Res>? get info;$TsunamiObservationInfoCopyWith<$Res>? get observationInfo;

}
/// @nodoc
class _$TsunamiEventCopyWithImpl<$Res>
    implements $TsunamiEventCopyWith<$Res> {
  _$TsunamiEventCopyWithImpl(this._self, this._then);

  final TsunamiEvent _self;
  final $Res Function(TsunamiEvent) _then;

/// Create a copy of TsunamiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? pressAt = null,Object? reportAt = null,Object? status = null,Object? infoType = null,Object? headline = freezed,Object? validAt = freezed,Object? info = freezed,Object? observationInfo = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,validAt: freezed == validAt ? _self.validAt : validAt // ignore: cast_nullable_to_non_nullable
as DateTime?,info: freezed == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as TsunamiInfo?,observationInfo: freezed == observationInfo ? _self.observationInfo : observationInfo // ignore: cast_nullable_to_non_nullable
as TsunamiObservationInfo?,
  ));
}
/// Create a copy of TsunamiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiInfoCopyWith<$Res>? get info {
    if (_self.info == null) {
    return null;
  }

  return $TsunamiInfoCopyWith<$Res>(_self.info!, (value) {
    return _then(_self.copyWith(info: value));
  });
}/// Create a copy of TsunamiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiObservationInfoCopyWith<$Res>? get observationInfo {
    if (_self.observationInfo == null) {
    return null;
  }

  return $TsunamiObservationInfoCopyWith<$Res>(_self.observationInfo!, (value) {
    return _then(_self.copyWith(observationInfo: value));
  });
}
}


/// @nodoc


class _TsunamiEvent extends TsunamiEvent {
  const _TsunamiEvent({required this.eventId, required this.pressAt, required this.reportAt, required this.status, required this.infoType, this.headline, this.validAt, this.info, this.observationInfo}): super._();
  

@override final  String eventId;
@override final  DateTime pressAt;
@override final  DateTime reportAt;
@override final  String status;
@override final  String infoType;
@override final  String? headline;
@override final  DateTime? validAt;
/// 津波警報・注意報・予報 + 津波情報（VTSE41 + VTSE51をマージ）
@override final  TsunamiInfo? info;
/// 沖合の津波観測（VTSE52）
@override final  TsunamiObservationInfo? observationInfo;

/// Create a copy of TsunamiEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiEventCopyWith<_TsunamiEvent> get copyWith => __$TsunamiEventCopyWithImpl<_TsunamiEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.validAt, validAt) || other.validAt == validAt)&&(identical(other.info, info) || other.info == info)&&(identical(other.observationInfo, observationInfo) || other.observationInfo == observationInfo));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,pressAt,reportAt,status,infoType,headline,validAt,info,observationInfo);

@override
String toString() {
  return 'TsunamiEvent(eventId: $eventId, pressAt: $pressAt, reportAt: $reportAt, status: $status, infoType: $infoType, headline: $headline, validAt: $validAt, info: $info, observationInfo: $observationInfo)';
}


}

/// @nodoc
abstract mixin class _$TsunamiEventCopyWith<$Res> implements $TsunamiEventCopyWith<$Res> {
  factory _$TsunamiEventCopyWith(_TsunamiEvent value, $Res Function(_TsunamiEvent) _then) = __$TsunamiEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime pressAt, DateTime reportAt, String status, String infoType, String? headline, DateTime? validAt, TsunamiInfo? info, TsunamiObservationInfo? observationInfo
});


@override $TsunamiInfoCopyWith<$Res>? get info;@override $TsunamiObservationInfoCopyWith<$Res>? get observationInfo;

}
/// @nodoc
class __$TsunamiEventCopyWithImpl<$Res>
    implements _$TsunamiEventCopyWith<$Res> {
  __$TsunamiEventCopyWithImpl(this._self, this._then);

  final _TsunamiEvent _self;
  final $Res Function(_TsunamiEvent) _then;

/// Create a copy of TsunamiEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? pressAt = null,Object? reportAt = null,Object? status = null,Object? infoType = null,Object? headline = freezed,Object? validAt = freezed,Object? info = freezed,Object? observationInfo = freezed,}) {
  return _then(_TsunamiEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,validAt: freezed == validAt ? _self.validAt : validAt // ignore: cast_nullable_to_non_nullable
as DateTime?,info: freezed == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as TsunamiInfo?,observationInfo: freezed == observationInfo ? _self.observationInfo : observationInfo // ignore: cast_nullable_to_non_nullable
as TsunamiObservationInfo?,
  ));
}

/// Create a copy of TsunamiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiInfoCopyWith<$Res>? get info {
    if (_self.info == null) {
    return null;
  }

  return $TsunamiInfoCopyWith<$Res>(_self.info!, (value) {
    return _then(_self.copyWith(info: value));
  });
}/// Create a copy of TsunamiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiObservationInfoCopyWith<$Res>? get observationInfo {
    if (_self.observationInfo == null) {
    return null;
  }

  return $TsunamiObservationInfoCopyWith<$Res>(_self.observationInfo!, (value) {
    return _then(_self.copyWith(observationInfo: value));
  });
}
}

// dart format on
