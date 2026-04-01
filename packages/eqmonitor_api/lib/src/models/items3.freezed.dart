// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'items3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Items3 {

 String get correlationKey; String get eventType; String get eventId; num get serialNo; String get jmaReportTime; num get targetDevices; num get enqueuedFcm; num get enqueuedApns; num get enqueuedBroadcast; num get successFcm; num get failedFcm; num get successApns; num get failedApns; String get createdAt; String get updatedAt;@JsonKey(includeIfNull: false) String? get headline;@JsonKey(includeIfNull: false) num? get resolverDelayMs;
/// Create a copy of Items3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Items3CopyWith<Items3> get copyWith => _$Items3CopyWithImpl<Items3>(this as Items3, _$identity);

  /// Serializes this Items3 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Items3&&(identical(other.correlationKey, correlationKey) || other.correlationKey == correlationKey)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.jmaReportTime, jmaReportTime) || other.jmaReportTime == jmaReportTime)&&(identical(other.targetDevices, targetDevices) || other.targetDevices == targetDevices)&&(identical(other.enqueuedFcm, enqueuedFcm) || other.enqueuedFcm == enqueuedFcm)&&(identical(other.enqueuedApns, enqueuedApns) || other.enqueuedApns == enqueuedApns)&&(identical(other.enqueuedBroadcast, enqueuedBroadcast) || other.enqueuedBroadcast == enqueuedBroadcast)&&(identical(other.successFcm, successFcm) || other.successFcm == successFcm)&&(identical(other.failedFcm, failedFcm) || other.failedFcm == failedFcm)&&(identical(other.successApns, successApns) || other.successApns == successApns)&&(identical(other.failedApns, failedApns) || other.failedApns == failedApns)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.resolverDelayMs, resolverDelayMs) || other.resolverDelayMs == resolverDelayMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,correlationKey,eventType,eventId,serialNo,jmaReportTime,targetDevices,enqueuedFcm,enqueuedApns,enqueuedBroadcast,successFcm,failedFcm,successApns,failedApns,createdAt,updatedAt,headline,resolverDelayMs);

@override
String toString() {
  return 'Items3(correlationKey: $correlationKey, eventType: $eventType, eventId: $eventId, serialNo: $serialNo, jmaReportTime: $jmaReportTime, targetDevices: $targetDevices, enqueuedFcm: $enqueuedFcm, enqueuedApns: $enqueuedApns, enqueuedBroadcast: $enqueuedBroadcast, successFcm: $successFcm, failedFcm: $failedFcm, successApns: $successApns, failedApns: $failedApns, createdAt: $createdAt, updatedAt: $updatedAt, headline: $headline, resolverDelayMs: $resolverDelayMs)';
}


}

/// @nodoc
abstract mixin class $Items3CopyWith<$Res>  {
  factory $Items3CopyWith(Items3 value, $Res Function(Items3) _then) = _$Items3CopyWithImpl;
@useResult
$Res call({
 String correlationKey, String eventType, String eventId, num serialNo, String jmaReportTime, num targetDevices, num enqueuedFcm, num enqueuedApns, num enqueuedBroadcast, num successFcm, num failedFcm, num successApns, num failedApns, String createdAt, String updatedAt,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false) num? resolverDelayMs
});




}
/// @nodoc
class _$Items3CopyWithImpl<$Res>
    implements $Items3CopyWith<$Res> {
  _$Items3CopyWithImpl(this._self, this._then);

  final Items3 _self;
  final $Res Function(Items3) _then;

/// Create a copy of Items3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? correlationKey = null,Object? eventType = null,Object? eventId = null,Object? serialNo = null,Object? jmaReportTime = null,Object? targetDevices = null,Object? enqueuedFcm = null,Object? enqueuedApns = null,Object? enqueuedBroadcast = null,Object? successFcm = null,Object? failedFcm = null,Object? successApns = null,Object? failedApns = null,Object? createdAt = null,Object? updatedAt = null,Object? headline = freezed,Object? resolverDelayMs = freezed,}) {
  return _then(_self.copyWith(
correlationKey: null == correlationKey ? _self.correlationKey : correlationKey // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,jmaReportTime: null == jmaReportTime ? _self.jmaReportTime : jmaReportTime // ignore: cast_nullable_to_non_nullable
as String,targetDevices: null == targetDevices ? _self.targetDevices : targetDevices // ignore: cast_nullable_to_non_nullable
as num,enqueuedFcm: null == enqueuedFcm ? _self.enqueuedFcm : enqueuedFcm // ignore: cast_nullable_to_non_nullable
as num,enqueuedApns: null == enqueuedApns ? _self.enqueuedApns : enqueuedApns // ignore: cast_nullable_to_non_nullable
as num,enqueuedBroadcast: null == enqueuedBroadcast ? _self.enqueuedBroadcast : enqueuedBroadcast // ignore: cast_nullable_to_non_nullable
as num,successFcm: null == successFcm ? _self.successFcm : successFcm // ignore: cast_nullable_to_non_nullable
as num,failedFcm: null == failedFcm ? _self.failedFcm : failedFcm // ignore: cast_nullable_to_non_nullable
as num,successApns: null == successApns ? _self.successApns : successApns // ignore: cast_nullable_to_non_nullable
as num,failedApns: null == failedApns ? _self.failedApns : failedApns // ignore: cast_nullable_to_non_nullable
as num,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,resolverDelayMs: freezed == resolverDelayMs ? _self.resolverDelayMs : resolverDelayMs // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [Items3].
extension Items3Patterns on Items3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Items3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Items3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Items3 value)  $default,){
final _that = this;
switch (_that) {
case _Items3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Items3 value)?  $default,){
final _that = this;
switch (_that) {
case _Items3() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String correlationKey,  String eventType,  String eventId,  num serialNo,  String jmaReportTime,  num targetDevices,  num enqueuedFcm,  num enqueuedApns,  num enqueuedBroadcast,  num successFcm,  num failedFcm,  num successApns,  num failedApns,  String createdAt,  String updatedAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  num? resolverDelayMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Items3() when $default != null:
return $default(_that.correlationKey,_that.eventType,_that.eventId,_that.serialNo,_that.jmaReportTime,_that.targetDevices,_that.enqueuedFcm,_that.enqueuedApns,_that.enqueuedBroadcast,_that.successFcm,_that.failedFcm,_that.successApns,_that.failedApns,_that.createdAt,_that.updatedAt,_that.headline,_that.resolverDelayMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String correlationKey,  String eventType,  String eventId,  num serialNo,  String jmaReportTime,  num targetDevices,  num enqueuedFcm,  num enqueuedApns,  num enqueuedBroadcast,  num successFcm,  num failedFcm,  num successApns,  num failedApns,  String createdAt,  String updatedAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  num? resolverDelayMs)  $default,) {final _that = this;
switch (_that) {
case _Items3():
return $default(_that.correlationKey,_that.eventType,_that.eventId,_that.serialNo,_that.jmaReportTime,_that.targetDevices,_that.enqueuedFcm,_that.enqueuedApns,_that.enqueuedBroadcast,_that.successFcm,_that.failedFcm,_that.successApns,_that.failedApns,_that.createdAt,_that.updatedAt,_that.headline,_that.resolverDelayMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String correlationKey,  String eventType,  String eventId,  num serialNo,  String jmaReportTime,  num targetDevices,  num enqueuedFcm,  num enqueuedApns,  num enqueuedBroadcast,  num successFcm,  num failedFcm,  num successApns,  num failedApns,  String createdAt,  String updatedAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  num? resolverDelayMs)?  $default,) {final _that = this;
switch (_that) {
case _Items3() when $default != null:
return $default(_that.correlationKey,_that.eventType,_that.eventId,_that.serialNo,_that.jmaReportTime,_that.targetDevices,_that.enqueuedFcm,_that.enqueuedApns,_that.enqueuedBroadcast,_that.successFcm,_that.failedFcm,_that.successApns,_that.failedApns,_that.createdAt,_that.updatedAt,_that.headline,_that.resolverDelayMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Items3 implements Items3 {
  const _Items3({required this.correlationKey, required this.eventType, required this.eventId, required this.serialNo, required this.jmaReportTime, required this.targetDevices, required this.enqueuedFcm, required this.enqueuedApns, required this.enqueuedBroadcast, required this.successFcm, required this.failedFcm, required this.successApns, required this.failedApns, required this.createdAt, required this.updatedAt, @JsonKey(includeIfNull: false) this.headline, @JsonKey(includeIfNull: false) this.resolverDelayMs});
  factory _Items3.fromJson(Map<String, dynamic> json) => _$Items3FromJson(json);

@override final  String correlationKey;
@override final  String eventType;
@override final  String eventId;
@override final  num serialNo;
@override final  String jmaReportTime;
@override final  num targetDevices;
@override final  num enqueuedFcm;
@override final  num enqueuedApns;
@override final  num enqueuedBroadcast;
@override final  num successFcm;
@override final  num failedFcm;
@override final  num successApns;
@override final  num failedApns;
@override final  String createdAt;
@override final  String updatedAt;
@override@JsonKey(includeIfNull: false) final  String? headline;
@override@JsonKey(includeIfNull: false) final  num? resolverDelayMs;

/// Create a copy of Items3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Items3CopyWith<_Items3> get copyWith => __$Items3CopyWithImpl<_Items3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Items3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Items3&&(identical(other.correlationKey, correlationKey) || other.correlationKey == correlationKey)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.jmaReportTime, jmaReportTime) || other.jmaReportTime == jmaReportTime)&&(identical(other.targetDevices, targetDevices) || other.targetDevices == targetDevices)&&(identical(other.enqueuedFcm, enqueuedFcm) || other.enqueuedFcm == enqueuedFcm)&&(identical(other.enqueuedApns, enqueuedApns) || other.enqueuedApns == enqueuedApns)&&(identical(other.enqueuedBroadcast, enqueuedBroadcast) || other.enqueuedBroadcast == enqueuedBroadcast)&&(identical(other.successFcm, successFcm) || other.successFcm == successFcm)&&(identical(other.failedFcm, failedFcm) || other.failedFcm == failedFcm)&&(identical(other.successApns, successApns) || other.successApns == successApns)&&(identical(other.failedApns, failedApns) || other.failedApns == failedApns)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.resolverDelayMs, resolverDelayMs) || other.resolverDelayMs == resolverDelayMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,correlationKey,eventType,eventId,serialNo,jmaReportTime,targetDevices,enqueuedFcm,enqueuedApns,enqueuedBroadcast,successFcm,failedFcm,successApns,failedApns,createdAt,updatedAt,headline,resolverDelayMs);

@override
String toString() {
  return 'Items3(correlationKey: $correlationKey, eventType: $eventType, eventId: $eventId, serialNo: $serialNo, jmaReportTime: $jmaReportTime, targetDevices: $targetDevices, enqueuedFcm: $enqueuedFcm, enqueuedApns: $enqueuedApns, enqueuedBroadcast: $enqueuedBroadcast, successFcm: $successFcm, failedFcm: $failedFcm, successApns: $successApns, failedApns: $failedApns, createdAt: $createdAt, updatedAt: $updatedAt, headline: $headline, resolverDelayMs: $resolverDelayMs)';
}


}

/// @nodoc
abstract mixin class _$Items3CopyWith<$Res> implements $Items3CopyWith<$Res> {
  factory _$Items3CopyWith(_Items3 value, $Res Function(_Items3) _then) = __$Items3CopyWithImpl;
@override @useResult
$Res call({
 String correlationKey, String eventType, String eventId, num serialNo, String jmaReportTime, num targetDevices, num enqueuedFcm, num enqueuedApns, num enqueuedBroadcast, num successFcm, num failedFcm, num successApns, num failedApns, String createdAt, String updatedAt,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false) num? resolverDelayMs
});




}
/// @nodoc
class __$Items3CopyWithImpl<$Res>
    implements _$Items3CopyWith<$Res> {
  __$Items3CopyWithImpl(this._self, this._then);

  final _Items3 _self;
  final $Res Function(_Items3) _then;

/// Create a copy of Items3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? correlationKey = null,Object? eventType = null,Object? eventId = null,Object? serialNo = null,Object? jmaReportTime = null,Object? targetDevices = null,Object? enqueuedFcm = null,Object? enqueuedApns = null,Object? enqueuedBroadcast = null,Object? successFcm = null,Object? failedFcm = null,Object? successApns = null,Object? failedApns = null,Object? createdAt = null,Object? updatedAt = null,Object? headline = freezed,Object? resolverDelayMs = freezed,}) {
  return _then(_Items3(
correlationKey: null == correlationKey ? _self.correlationKey : correlationKey // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,jmaReportTime: null == jmaReportTime ? _self.jmaReportTime : jmaReportTime // ignore: cast_nullable_to_non_nullable
as String,targetDevices: null == targetDevices ? _self.targetDevices : targetDevices // ignore: cast_nullable_to_non_nullable
as num,enqueuedFcm: null == enqueuedFcm ? _self.enqueuedFcm : enqueuedFcm // ignore: cast_nullable_to_non_nullable
as num,enqueuedApns: null == enqueuedApns ? _self.enqueuedApns : enqueuedApns // ignore: cast_nullable_to_non_nullable
as num,enqueuedBroadcast: null == enqueuedBroadcast ? _self.enqueuedBroadcast : enqueuedBroadcast // ignore: cast_nullable_to_non_nullable
as num,successFcm: null == successFcm ? _self.successFcm : successFcm // ignore: cast_nullable_to_non_nullable
as num,failedFcm: null == failedFcm ? _self.failedFcm : failedFcm // ignore: cast_nullable_to_non_nullable
as num,successApns: null == successApns ? _self.successApns : successApns // ignore: cast_nullable_to_non_nullable
as num,failedApns: null == failedApns ? _self.failedApns : failedApns // ignore: cast_nullable_to_non_nullable
as num,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,resolverDelayMs: freezed == resolverDelayMs ? _self.resolverDelayMs : resolverDelayMs // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
