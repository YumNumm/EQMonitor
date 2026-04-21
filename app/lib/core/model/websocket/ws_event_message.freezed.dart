// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_event_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsEventMessage {

 String get eventId; String get type; int get serialNo; DateTime get reportTime; String? get maxIntensity; String? get headline; DateTime? get originTime; DateTime? get arrivalTime; WsHypocenter? get hypocenter;
/// Create a copy of WsEventMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsEventMessageCopyWith<WsEventMessage> get copyWith => _$WsEventMessageCopyWithImpl<WsEventMessage>(this as WsEventMessage, _$identity);

  /// Serializes this WsEventMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsEventMessage&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,type,serialNo,reportTime,maxIntensity,headline,originTime,arrivalTime,hypocenter);

@override
String toString() {
  return 'WsEventMessage(eventId: $eventId, type: $type, serialNo: $serialNo, reportTime: $reportTime, maxIntensity: $maxIntensity, headline: $headline, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter)';
}


}

/// @nodoc
abstract mixin class $WsEventMessageCopyWith<$Res>  {
  factory $WsEventMessageCopyWith(WsEventMessage value, $Res Function(WsEventMessage) _then) = _$WsEventMessageCopyWithImpl;
@useResult
$Res call({
 String eventId, String type, int serialNo, DateTime reportTime, String? maxIntensity, String? headline, DateTime? originTime, DateTime? arrivalTime, WsHypocenter? hypocenter
});


$WsHypocenterCopyWith<$Res>? get hypocenter;

}
/// @nodoc
class _$WsEventMessageCopyWithImpl<$Res>
    implements $WsEventMessageCopyWith<$Res> {
  _$WsEventMessageCopyWithImpl(this._self, this._then);

  final WsEventMessage _self;
  final $Res Function(WsEventMessage) _then;

/// Create a copy of WsEventMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? type = null,Object? serialNo = null,Object? reportTime = null,Object? maxIntensity = freezed,Object? headline = freezed,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as String?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as WsHypocenter?,
  ));
}
/// Create a copy of WsEventMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $WsHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}


/// Adds pattern-matching-related methods to [WsEventMessage].
extension WsEventMessagePatterns on WsEventMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsEventMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsEventMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsEventMessage value)  $default,){
final _that = this;
switch (_that) {
case _WsEventMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsEventMessage value)?  $default,){
final _that = this;
switch (_that) {
case _WsEventMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String type,  int serialNo,  DateTime reportTime,  String? maxIntensity,  String? headline,  DateTime? originTime,  DateTime? arrivalTime,  WsHypocenter? hypocenter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsEventMessage() when $default != null:
return $default(_that.eventId,_that.type,_that.serialNo,_that.reportTime,_that.maxIntensity,_that.headline,_that.originTime,_that.arrivalTime,_that.hypocenter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String type,  int serialNo,  DateTime reportTime,  String? maxIntensity,  String? headline,  DateTime? originTime,  DateTime? arrivalTime,  WsHypocenter? hypocenter)  $default,) {final _that = this;
switch (_that) {
case _WsEventMessage():
return $default(_that.eventId,_that.type,_that.serialNo,_that.reportTime,_that.maxIntensity,_that.headline,_that.originTime,_that.arrivalTime,_that.hypocenter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String type,  int serialNo,  DateTime reportTime,  String? maxIntensity,  String? headline,  DateTime? originTime,  DateTime? arrivalTime,  WsHypocenter? hypocenter)?  $default,) {final _that = this;
switch (_that) {
case _WsEventMessage() when $default != null:
return $default(_that.eventId,_that.type,_that.serialNo,_that.reportTime,_that.maxIntensity,_that.headline,_that.originTime,_that.arrivalTime,_that.hypocenter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsEventMessage implements WsEventMessage {
  const _WsEventMessage({required this.eventId, required this.type, required this.serialNo, required this.reportTime, this.maxIntensity, this.headline, this.originTime, this.arrivalTime, this.hypocenter});
  factory _WsEventMessage.fromJson(Map<String, dynamic> json) => _$WsEventMessageFromJson(json);

@override final  String eventId;
@override final  String type;
@override final  int serialNo;
@override final  DateTime reportTime;
@override final  String? maxIntensity;
@override final  String? headline;
@override final  DateTime? originTime;
@override final  DateTime? arrivalTime;
@override final  WsHypocenter? hypocenter;

/// Create a copy of WsEventMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsEventMessageCopyWith<_WsEventMessage> get copyWith => __$WsEventMessageCopyWithImpl<_WsEventMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsEventMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsEventMessage&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,type,serialNo,reportTime,maxIntensity,headline,originTime,arrivalTime,hypocenter);

@override
String toString() {
  return 'WsEventMessage(eventId: $eventId, type: $type, serialNo: $serialNo, reportTime: $reportTime, maxIntensity: $maxIntensity, headline: $headline, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter)';
}


}

/// @nodoc
abstract mixin class _$WsEventMessageCopyWith<$Res> implements $WsEventMessageCopyWith<$Res> {
  factory _$WsEventMessageCopyWith(_WsEventMessage value, $Res Function(_WsEventMessage) _then) = __$WsEventMessageCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String type, int serialNo, DateTime reportTime, String? maxIntensity, String? headline, DateTime? originTime, DateTime? arrivalTime, WsHypocenter? hypocenter
});


@override $WsHypocenterCopyWith<$Res>? get hypocenter;

}
/// @nodoc
class __$WsEventMessageCopyWithImpl<$Res>
    implements _$WsEventMessageCopyWith<$Res> {
  __$WsEventMessageCopyWithImpl(this._self, this._then);

  final _WsEventMessage _self;
  final $Res Function(_WsEventMessage) _then;

/// Create a copy of WsEventMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? type = null,Object? serialNo = null,Object? reportTime = null,Object? maxIntensity = freezed,Object? headline = freezed,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,}) {
  return _then(_WsEventMessage(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as String?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as WsHypocenter?,
  ));
}

/// Create a copy of WsEventMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsHypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $WsHypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}

// dart format on
