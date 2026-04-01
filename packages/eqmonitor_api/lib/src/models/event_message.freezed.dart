// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventMessage {

 String get eventId; EventType get type; num get serialNo; List<Regions> get regions; String get reportTime;@JsonKey(includeIfNull: false) String? get maxIntensity;@JsonKey(includeIfNull: false) String? get headline;@JsonKey(includeIfNull: false) String? get originTime;@JsonKey(includeIfNull: false) String? get arrivalTime;@JsonKey(includeIfNull: false) EventHypocenter? get hypocenter;@JsonKey(includeIfNull: false) num? get magnitude;@JsonKey(includeIfNull: false) bool? get isWarning;@JsonKey(includeIfNull: false) bool? get isLastInfo;@JsonKey(includeIfNull: false) bool? get isCancel;@JsonKey(includeIfNull: false) String? get hypocenterReduceName;@JsonKey(includeIfNull: false) bool? get hasWarningZones;@JsonKey(includeIfNull: false) bool? get isPlum;@JsonKey(includeIfNull: false) bool? get isLevel;@JsonKey(includeIfNull: false) bool? get isOnePoint;@JsonKey(includeIfNull: false) String? get comment;@JsonKey(includeIfNull: false) List<Prefectures>? get prefectures;
/// Create a copy of EventMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventMessageCopyWith<EventMessage> get copyWith => _$EventMessageCopyWithImpl<EventMessage>(this as EventMessage, _$identity);

  /// Serializes this EventMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventMessage&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&const DeepCollectionEquality().equals(other.regions, regions)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.isCancel, isCancel) || other.isCancel == isCancel)&&(identical(other.hypocenterReduceName, hypocenterReduceName) || other.hypocenterReduceName == hypocenterReduceName)&&(identical(other.hasWarningZones, hasWarningZones) || other.hasWarningZones == hasWarningZones)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isLevel, isLevel) || other.isLevel == isLevel)&&(identical(other.isOnePoint, isOnePoint) || other.isOnePoint == isOnePoint)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other.prefectures, prefectures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,eventId,type,serialNo,const DeepCollectionEquality().hash(regions),reportTime,maxIntensity,headline,originTime,arrivalTime,hypocenter,magnitude,isWarning,isLastInfo,isCancel,hypocenterReduceName,hasWarningZones,isPlum,isLevel,isOnePoint,comment,const DeepCollectionEquality().hash(prefectures)]);

@override
String toString() {
  return 'EventMessage(eventId: $eventId, type: $type, serialNo: $serialNo, regions: $regions, reportTime: $reportTime, maxIntensity: $maxIntensity, headline: $headline, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, magnitude: $magnitude, isWarning: $isWarning, isLastInfo: $isLastInfo, isCancel: $isCancel, hypocenterReduceName: $hypocenterReduceName, hasWarningZones: $hasWarningZones, isPlum: $isPlum, isLevel: $isLevel, isOnePoint: $isOnePoint, comment: $comment, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class $EventMessageCopyWith<$Res>  {
  factory $EventMessageCopyWith(EventMessage value, $Res Function(EventMessage) _then) = _$EventMessageCopyWithImpl;
@useResult
$Res call({
 String eventId, EventType type, num serialNo, List<Regions> regions, String reportTime,@JsonKey(includeIfNull: false) String? maxIntensity,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false) String? originTime,@JsonKey(includeIfNull: false) String? arrivalTime,@JsonKey(includeIfNull: false) EventHypocenter? hypocenter,@JsonKey(includeIfNull: false) num? magnitude,@JsonKey(includeIfNull: false) bool? isWarning,@JsonKey(includeIfNull: false) bool? isLastInfo,@JsonKey(includeIfNull: false) bool? isCancel,@JsonKey(includeIfNull: false) String? hypocenterReduceName,@JsonKey(includeIfNull: false) bool? hasWarningZones,@JsonKey(includeIfNull: false) bool? isPlum,@JsonKey(includeIfNull: false) bool? isLevel,@JsonKey(includeIfNull: false) bool? isOnePoint,@JsonKey(includeIfNull: false) String? comment,@JsonKey(includeIfNull: false) List<Prefectures>? prefectures
});


$EventHypocenterCopyWith<$Res>? get hypocenter;

}
/// @nodoc
class _$EventMessageCopyWithImpl<$Res>
    implements $EventMessageCopyWith<$Res> {
  _$EventMessageCopyWithImpl(this._self, this._then);

  final EventMessage _self;
  final $Res Function(EventMessage) _then;

/// Create a copy of EventMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? type = null,Object? serialNo = null,Object? regions = null,Object? reportTime = null,Object? maxIntensity = freezed,Object? headline = freezed,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? magnitude = freezed,Object? isWarning = freezed,Object? isLastInfo = freezed,Object? isCancel = freezed,Object? hypocenterReduceName = freezed,Object? hasWarningZones = freezed,Object? isPlum = freezed,Object? isLevel = freezed,Object? isOnePoint = freezed,Object? comment = freezed,Object? prefectures = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<Regions>,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as String?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as String?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EventHypocenter?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as num?,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,isLastInfo: freezed == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool?,isCancel: freezed == isCancel ? _self.isCancel : isCancel // ignore: cast_nullable_to_non_nullable
as bool?,hypocenterReduceName: freezed == hypocenterReduceName ? _self.hypocenterReduceName : hypocenterReduceName // ignore: cast_nullable_to_non_nullable
as String?,hasWarningZones: freezed == hasWarningZones ? _self.hasWarningZones : hasWarningZones // ignore: cast_nullable_to_non_nullable
as bool?,isPlum: freezed == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool?,isLevel: freezed == isLevel ? _self.isLevel : isLevel // ignore: cast_nullable_to_non_nullable
as bool?,isOnePoint: freezed == isOnePoint ? _self.isOnePoint : isOnePoint // ignore: cast_nullable_to_non_nullable
as bool?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,prefectures: freezed == prefectures ? _self.prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<Prefectures>?,
  ));
}
/// Create a copy of EventMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $EventHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventMessage].
extension EventMessagePatterns on EventMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventMessage value)  $default,){
final _that = this;
switch (_that) {
case _EventMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventMessage value)?  $default,){
final _that = this;
switch (_that) {
case _EventMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  EventType type,  num serialNo,  List<Regions> regions,  String reportTime, @JsonKey(includeIfNull: false)  String? maxIntensity, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  String? originTime, @JsonKey(includeIfNull: false)  String? arrivalTime, @JsonKey(includeIfNull: false)  EventHypocenter? hypocenter, @JsonKey(includeIfNull: false)  num? magnitude, @JsonKey(includeIfNull: false)  bool? isWarning, @JsonKey(includeIfNull: false)  bool? isLastInfo, @JsonKey(includeIfNull: false)  bool? isCancel, @JsonKey(includeIfNull: false)  String? hypocenterReduceName, @JsonKey(includeIfNull: false)  bool? hasWarningZones, @JsonKey(includeIfNull: false)  bool? isPlum, @JsonKey(includeIfNull: false)  bool? isLevel, @JsonKey(includeIfNull: false)  bool? isOnePoint, @JsonKey(includeIfNull: false)  String? comment, @JsonKey(includeIfNull: false)  List<Prefectures>? prefectures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventMessage() when $default != null:
return $default(_that.eventId,_that.type,_that.serialNo,_that.regions,_that.reportTime,_that.maxIntensity,_that.headline,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.magnitude,_that.isWarning,_that.isLastInfo,_that.isCancel,_that.hypocenterReduceName,_that.hasWarningZones,_that.isPlum,_that.isLevel,_that.isOnePoint,_that.comment,_that.prefectures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  EventType type,  num serialNo,  List<Regions> regions,  String reportTime, @JsonKey(includeIfNull: false)  String? maxIntensity, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  String? originTime, @JsonKey(includeIfNull: false)  String? arrivalTime, @JsonKey(includeIfNull: false)  EventHypocenter? hypocenter, @JsonKey(includeIfNull: false)  num? magnitude, @JsonKey(includeIfNull: false)  bool? isWarning, @JsonKey(includeIfNull: false)  bool? isLastInfo, @JsonKey(includeIfNull: false)  bool? isCancel, @JsonKey(includeIfNull: false)  String? hypocenterReduceName, @JsonKey(includeIfNull: false)  bool? hasWarningZones, @JsonKey(includeIfNull: false)  bool? isPlum, @JsonKey(includeIfNull: false)  bool? isLevel, @JsonKey(includeIfNull: false)  bool? isOnePoint, @JsonKey(includeIfNull: false)  String? comment, @JsonKey(includeIfNull: false)  List<Prefectures>? prefectures)  $default,) {final _that = this;
switch (_that) {
case _EventMessage():
return $default(_that.eventId,_that.type,_that.serialNo,_that.regions,_that.reportTime,_that.maxIntensity,_that.headline,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.magnitude,_that.isWarning,_that.isLastInfo,_that.isCancel,_that.hypocenterReduceName,_that.hasWarningZones,_that.isPlum,_that.isLevel,_that.isOnePoint,_that.comment,_that.prefectures);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  EventType type,  num serialNo,  List<Regions> regions,  String reportTime, @JsonKey(includeIfNull: false)  String? maxIntensity, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  String? originTime, @JsonKey(includeIfNull: false)  String? arrivalTime, @JsonKey(includeIfNull: false)  EventHypocenter? hypocenter, @JsonKey(includeIfNull: false)  num? magnitude, @JsonKey(includeIfNull: false)  bool? isWarning, @JsonKey(includeIfNull: false)  bool? isLastInfo, @JsonKey(includeIfNull: false)  bool? isCancel, @JsonKey(includeIfNull: false)  String? hypocenterReduceName, @JsonKey(includeIfNull: false)  bool? hasWarningZones, @JsonKey(includeIfNull: false)  bool? isPlum, @JsonKey(includeIfNull: false)  bool? isLevel, @JsonKey(includeIfNull: false)  bool? isOnePoint, @JsonKey(includeIfNull: false)  String? comment, @JsonKey(includeIfNull: false)  List<Prefectures>? prefectures)?  $default,) {final _that = this;
switch (_that) {
case _EventMessage() when $default != null:
return $default(_that.eventId,_that.type,_that.serialNo,_that.regions,_that.reportTime,_that.maxIntensity,_that.headline,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.magnitude,_that.isWarning,_that.isLastInfo,_that.isCancel,_that.hypocenterReduceName,_that.hasWarningZones,_that.isPlum,_that.isLevel,_that.isOnePoint,_that.comment,_that.prefectures);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventMessage implements EventMessage {
  const _EventMessage({required this.eventId, required this.type, required this.serialNo, required final  List<Regions> regions, required this.reportTime, @JsonKey(includeIfNull: false) this.maxIntensity, @JsonKey(includeIfNull: false) this.headline, @JsonKey(includeIfNull: false) this.originTime, @JsonKey(includeIfNull: false) this.arrivalTime, @JsonKey(includeIfNull: false) this.hypocenter, @JsonKey(includeIfNull: false) this.magnitude, @JsonKey(includeIfNull: false) this.isWarning, @JsonKey(includeIfNull: false) this.isLastInfo, @JsonKey(includeIfNull: false) this.isCancel, @JsonKey(includeIfNull: false) this.hypocenterReduceName, @JsonKey(includeIfNull: false) this.hasWarningZones, @JsonKey(includeIfNull: false) this.isPlum, @JsonKey(includeIfNull: false) this.isLevel, @JsonKey(includeIfNull: false) this.isOnePoint, @JsonKey(includeIfNull: false) this.comment, @JsonKey(includeIfNull: false) final  List<Prefectures>? prefectures}): _regions = regions,_prefectures = prefectures;
  factory _EventMessage.fromJson(Map<String, dynamic> json) => _$EventMessageFromJson(json);

@override final  String eventId;
@override final  EventType type;
@override final  num serialNo;
 final  List<Regions> _regions;
@override List<Regions> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

@override final  String reportTime;
@override@JsonKey(includeIfNull: false) final  String? maxIntensity;
@override@JsonKey(includeIfNull: false) final  String? headline;
@override@JsonKey(includeIfNull: false) final  String? originTime;
@override@JsonKey(includeIfNull: false) final  String? arrivalTime;
@override@JsonKey(includeIfNull: false) final  EventHypocenter? hypocenter;
@override@JsonKey(includeIfNull: false) final  num? magnitude;
@override@JsonKey(includeIfNull: false) final  bool? isWarning;
@override@JsonKey(includeIfNull: false) final  bool? isLastInfo;
@override@JsonKey(includeIfNull: false) final  bool? isCancel;
@override@JsonKey(includeIfNull: false) final  String? hypocenterReduceName;
@override@JsonKey(includeIfNull: false) final  bool? hasWarningZones;
@override@JsonKey(includeIfNull: false) final  bool? isPlum;
@override@JsonKey(includeIfNull: false) final  bool? isLevel;
@override@JsonKey(includeIfNull: false) final  bool? isOnePoint;
@override@JsonKey(includeIfNull: false) final  String? comment;
 final  List<Prefectures>? _prefectures;
@override@JsonKey(includeIfNull: false) List<Prefectures>? get prefectures {
  final value = _prefectures;
  if (value == null) return null;
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EventMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventMessageCopyWith<_EventMessage> get copyWith => __$EventMessageCopyWithImpl<_EventMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventMessage&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&const DeepCollectionEquality().equals(other._regions, _regions)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isLastInfo, isLastInfo) || other.isLastInfo == isLastInfo)&&(identical(other.isCancel, isCancel) || other.isCancel == isCancel)&&(identical(other.hypocenterReduceName, hypocenterReduceName) || other.hypocenterReduceName == hypocenterReduceName)&&(identical(other.hasWarningZones, hasWarningZones) || other.hasWarningZones == hasWarningZones)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isLevel, isLevel) || other.isLevel == isLevel)&&(identical(other.isOnePoint, isOnePoint) || other.isOnePoint == isOnePoint)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,eventId,type,serialNo,const DeepCollectionEquality().hash(_regions),reportTime,maxIntensity,headline,originTime,arrivalTime,hypocenter,magnitude,isWarning,isLastInfo,isCancel,hypocenterReduceName,hasWarningZones,isPlum,isLevel,isOnePoint,comment,const DeepCollectionEquality().hash(_prefectures)]);

@override
String toString() {
  return 'EventMessage(eventId: $eventId, type: $type, serialNo: $serialNo, regions: $regions, reportTime: $reportTime, maxIntensity: $maxIntensity, headline: $headline, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, magnitude: $magnitude, isWarning: $isWarning, isLastInfo: $isLastInfo, isCancel: $isCancel, hypocenterReduceName: $hypocenterReduceName, hasWarningZones: $hasWarningZones, isPlum: $isPlum, isLevel: $isLevel, isOnePoint: $isOnePoint, comment: $comment, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class _$EventMessageCopyWith<$Res> implements $EventMessageCopyWith<$Res> {
  factory _$EventMessageCopyWith(_EventMessage value, $Res Function(_EventMessage) _then) = __$EventMessageCopyWithImpl;
@override @useResult
$Res call({
 String eventId, EventType type, num serialNo, List<Regions> regions, String reportTime,@JsonKey(includeIfNull: false) String? maxIntensity,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false) String? originTime,@JsonKey(includeIfNull: false) String? arrivalTime,@JsonKey(includeIfNull: false) EventHypocenter? hypocenter,@JsonKey(includeIfNull: false) num? magnitude,@JsonKey(includeIfNull: false) bool? isWarning,@JsonKey(includeIfNull: false) bool? isLastInfo,@JsonKey(includeIfNull: false) bool? isCancel,@JsonKey(includeIfNull: false) String? hypocenterReduceName,@JsonKey(includeIfNull: false) bool? hasWarningZones,@JsonKey(includeIfNull: false) bool? isPlum,@JsonKey(includeIfNull: false) bool? isLevel,@JsonKey(includeIfNull: false) bool? isOnePoint,@JsonKey(includeIfNull: false) String? comment,@JsonKey(includeIfNull: false) List<Prefectures>? prefectures
});


@override $EventHypocenterCopyWith<$Res>? get hypocenter;

}
/// @nodoc
class __$EventMessageCopyWithImpl<$Res>
    implements _$EventMessageCopyWith<$Res> {
  __$EventMessageCopyWithImpl(this._self, this._then);

  final _EventMessage _self;
  final $Res Function(_EventMessage) _then;

/// Create a copy of EventMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? type = null,Object? serialNo = null,Object? regions = null,Object? reportTime = null,Object? maxIntensity = freezed,Object? headline = freezed,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? magnitude = freezed,Object? isWarning = freezed,Object? isLastInfo = freezed,Object? isCancel = freezed,Object? hypocenterReduceName = freezed,Object? hasWarningZones = freezed,Object? isPlum = freezed,Object? isLevel = freezed,Object? isOnePoint = freezed,Object? comment = freezed,Object? prefectures = freezed,}) {
  return _then(_EventMessage(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<Regions>,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as String?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as String?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EventHypocenter?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as num?,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,isLastInfo: freezed == isLastInfo ? _self.isLastInfo : isLastInfo // ignore: cast_nullable_to_non_nullable
as bool?,isCancel: freezed == isCancel ? _self.isCancel : isCancel // ignore: cast_nullable_to_non_nullable
as bool?,hypocenterReduceName: freezed == hypocenterReduceName ? _self.hypocenterReduceName : hypocenterReduceName // ignore: cast_nullable_to_non_nullable
as String?,hasWarningZones: freezed == hasWarningZones ? _self.hasWarningZones : hasWarningZones // ignore: cast_nullable_to_non_nullable
as bool?,isPlum: freezed == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool?,isLevel: freezed == isLevel ? _self.isLevel : isLevel // ignore: cast_nullable_to_non_nullable
as bool?,isOnePoint: freezed == isOnePoint ? _self.isOnePoint : isOnePoint // ignore: cast_nullable_to_non_nullable
as bool?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,prefectures: freezed == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<Prefectures>?,
  ));
}

/// Create a copy of EventMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $EventHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}

// dart format on
