// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unified_eew.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UnifiedEewLocation {

 String get regionName; JmaIntensity? get forecastIntensity; JmaLpgmIntensity? get forecastLpgmIntensity; DateTime? get arrivalTime; bool? get isPlum; bool? get isWarning;
/// Create a copy of UnifiedEewLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnifiedEewLocationCopyWith<UnifiedEewLocation> get copyWith => _$UnifiedEewLocationCopyWithImpl<UnifiedEewLocation>(this as UnifiedEewLocation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnifiedEewLocation&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.forecastIntensity, forecastIntensity) || other.forecastIntensity == forecastIntensity)&&(identical(other.forecastLpgmIntensity, forecastLpgmIntensity) || other.forecastLpgmIntensity == forecastLpgmIntensity)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning));
}


@override
int get hashCode => Object.hash(runtimeType,regionName,forecastIntensity,forecastLpgmIntensity,arrivalTime,isPlum,isWarning);

@override
String toString() {
  return 'UnifiedEewLocation(regionName: $regionName, forecastIntensity: $forecastIntensity, forecastLpgmIntensity: $forecastLpgmIntensity, arrivalTime: $arrivalTime, isPlum: $isPlum, isWarning: $isWarning)';
}


}

/// @nodoc
abstract mixin class $UnifiedEewLocationCopyWith<$Res>  {
  factory $UnifiedEewLocationCopyWith(UnifiedEewLocation value, $Res Function(UnifiedEewLocation) _then) = _$UnifiedEewLocationCopyWithImpl;
@useResult
$Res call({
 String regionName, JmaIntensity? forecastIntensity, JmaLpgmIntensity? forecastLpgmIntensity, DateTime? arrivalTime, bool? isPlum, bool? isWarning
});




}
/// @nodoc
class _$UnifiedEewLocationCopyWithImpl<$Res>
    implements $UnifiedEewLocationCopyWith<$Res> {
  _$UnifiedEewLocationCopyWithImpl(this._self, this._then);

  final UnifiedEewLocation _self;
  final $Res Function(UnifiedEewLocation) _then;

/// Create a copy of UnifiedEewLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionName = null,Object? forecastIntensity = freezed,Object? forecastLpgmIntensity = freezed,Object? arrivalTime = freezed,Object? isPlum = freezed,Object? isWarning = freezed,}) {
  return _then(UnifiedEewLocation(
regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,forecastIntensity: freezed == forecastIntensity ? _self.forecastIntensity : forecastIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,forecastLpgmIntensity: freezed == forecastLpgmIntensity ? _self.forecastLpgmIntensity : forecastLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isPlum: freezed == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool?,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UnifiedEewLocation].
extension UnifiedEewLocationPatterns on UnifiedEewLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnifiedEewLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnifiedEewLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnifiedEewLocation value)  $default,){
final _that = this;
switch (_that) {
case _UnifiedEewLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnifiedEewLocation value)?  $default,){
final _that = this;
switch (_that) {
case _UnifiedEewLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String regionName,  JmaIntensity? forecastIntensity,  JmaLpgmIntensity? forecastLpgmIntensity,  DateTime? arrivalTime,  bool? isPlum,  bool? isWarning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnifiedEewLocation() when $default != null:
return $default(_that.regionName,_that.forecastIntensity,_that.forecastLpgmIntensity,_that.arrivalTime,_that.isPlum,_that.isWarning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String regionName,  JmaIntensity? forecastIntensity,  JmaLpgmIntensity? forecastLpgmIntensity,  DateTime? arrivalTime,  bool? isPlum,  bool? isWarning)  $default,) {final _that = this;
switch (_that) {
case _UnifiedEewLocation():
return $default(_that.regionName,_that.forecastIntensity,_that.forecastLpgmIntensity,_that.arrivalTime,_that.isPlum,_that.isWarning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String regionName,  JmaIntensity? forecastIntensity,  JmaLpgmIntensity? forecastLpgmIntensity,  DateTime? arrivalTime,  bool? isPlum,  bool? isWarning)?  $default,) {final _that = this;
switch (_that) {
case _UnifiedEewLocation() when $default != null:
return $default(_that.regionName,_that.forecastIntensity,_that.forecastLpgmIntensity,_that.arrivalTime,_that.isPlum,_that.isWarning);case _:
  return null;

}
}

}

/// @nodoc


class _UnifiedEewLocation extends UnifiedEewLocation {
  const _UnifiedEewLocation({required this.regionName, required this.forecastIntensity, required this.forecastLpgmIntensity, required this.arrivalTime, required this.isPlum, required this.isWarning}): super._();
  

@override final  String regionName;
@override final  JmaIntensity? forecastIntensity;
@override final  JmaLpgmIntensity? forecastLpgmIntensity;
@override final  DateTime? arrivalTime;
@override final  bool? isPlum;
@override final  bool? isWarning;

/// Create a copy of UnifiedEewLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnifiedEewLocationCopyWith<_UnifiedEewLocation> get copyWith => __$UnifiedEewLocationCopyWithImpl<_UnifiedEewLocation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnifiedEewLocation&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.forecastIntensity, forecastIntensity) || other.forecastIntensity == forecastIntensity)&&(identical(other.forecastLpgmIntensity, forecastLpgmIntensity) || other.forecastLpgmIntensity == forecastLpgmIntensity)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning));
}


@override
int get hashCode => Object.hash(runtimeType,regionName,forecastIntensity,forecastLpgmIntensity,arrivalTime,isPlum,isWarning);

@override
String toString() {
  return 'UnifiedEewLocation(regionName: $regionName, forecastIntensity: $forecastIntensity, forecastLpgmIntensity: $forecastLpgmIntensity, arrivalTime: $arrivalTime, isPlum: $isPlum, isWarning: $isWarning)';
}


}

/// @nodoc
abstract mixin class _$UnifiedEewLocationCopyWith<$Res> implements $UnifiedEewLocationCopyWith<$Res> {
  factory _$UnifiedEewLocationCopyWith(_UnifiedEewLocation value, $Res Function(_UnifiedEewLocation) _then) = __$UnifiedEewLocationCopyWithImpl;
@override @useResult
$Res call({
 String regionName, JmaIntensity? forecastIntensity, JmaLpgmIntensity? forecastLpgmIntensity, DateTime? arrivalTime, bool? isPlum, bool? isWarning
});




}
/// @nodoc
class __$UnifiedEewLocationCopyWithImpl<$Res>
    implements _$UnifiedEewLocationCopyWith<$Res> {
  __$UnifiedEewLocationCopyWithImpl(this._self, this._then);

  final _UnifiedEewLocation _self;
  final $Res Function(_UnifiedEewLocation) _then;

/// Create a copy of UnifiedEewLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionName = null,Object? forecastIntensity = freezed,Object? forecastLpgmIntensity = freezed,Object? arrivalTime = freezed,Object? isPlum = freezed,Object? isWarning = freezed,}) {
  return _then(_UnifiedEewLocation(
regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,forecastIntensity: freezed == forecastIntensity ? _self.forecastIntensity : forecastIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,forecastLpgmIntensity: freezed == forecastLpgmIntensity ? _self.forecastLpgmIntensity : forecastLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isPlum: freezed == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool?,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc
mixin _$UnifiedEew {

 String get eventId; String get headline; String? get hypocenterName; double? get magnitude; double? get depth; DateTime? get time; bool get isOriginTime; JmaIntensity? get maxIntensity; int get serialNo; bool get isFinal; bool get isWarning; bool get isCanceled; bool get isPlum; bool get isLevel; bool get isOnePoint; DateTime get issuedAt; UnifiedEewLocation? get location;
/// Create a copy of UnifiedEew
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnifiedEewCopyWith<UnifiedEew> get copyWith => _$UnifiedEewCopyWithImpl<UnifiedEew>(this as UnifiedEew, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnifiedEew&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.hypocenterName, hypocenterName) || other.hypocenterName == hypocenterName)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.time, time) || other.time == time)&&(identical(other.isOriginTime, isOriginTime) || other.isOriginTime == isOriginTime)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isLevel, isLevel) || other.isLevel == isLevel)&&(identical(other.isOnePoint, isOnePoint) || other.isOnePoint == isOnePoint)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,headline,hypocenterName,magnitude,depth,time,isOriginTime,maxIntensity,serialNo,isFinal,isWarning,isCanceled,isPlum,isLevel,isOnePoint,issuedAt,location);

@override
String toString() {
  return 'UnifiedEew(eventId: $eventId, headline: $headline, hypocenterName: $hypocenterName, magnitude: $magnitude, depth: $depth, time: $time, isOriginTime: $isOriginTime, maxIntensity: $maxIntensity, serialNo: $serialNo, isFinal: $isFinal, isWarning: $isWarning, isCanceled: $isCanceled, isPlum: $isPlum, isLevel: $isLevel, isOnePoint: $isOnePoint, issuedAt: $issuedAt, location: $location)';
}


}

/// @nodoc
abstract mixin class $UnifiedEewCopyWith<$Res>  {
  factory $UnifiedEewCopyWith(UnifiedEew value, $Res Function(UnifiedEew) _then) = _$UnifiedEewCopyWithImpl;
@useResult
$Res call({
 String eventId, String headline, String? hypocenterName, double? magnitude, double? depth, DateTime? time, bool isOriginTime, JmaIntensity? maxIntensity, int serialNo, bool isFinal, bool isWarning, bool isCanceled, bool isPlum, bool isLevel, bool isOnePoint, DateTime issuedAt, UnifiedEewLocation? location
});


$UnifiedEewLocationCopyWith<$Res>? get location;

}
/// @nodoc
class _$UnifiedEewCopyWithImpl<$Res>
    implements $UnifiedEewCopyWith<$Res> {
  _$UnifiedEewCopyWithImpl(this._self, this._then);

  final UnifiedEew _self;
  final $Res Function(UnifiedEew) _then;

/// Create a copy of UnifiedEew
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? headline = null,Object? hypocenterName = freezed,Object? magnitude = freezed,Object? depth = freezed,Object? time = freezed,Object? isOriginTime = null,Object? maxIntensity = freezed,Object? serialNo = null,Object? isFinal = null,Object? isWarning = null,Object? isCanceled = null,Object? isPlum = null,Object? isLevel = null,Object? isOnePoint = null,Object? issuedAt = null,Object? location = freezed,}) {
  return _then(UnifiedEew(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,hypocenterName: freezed == hypocenterName ? _self.hypocenterName : hypocenterName // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime?,isOriginTime: null == isOriginTime ? _self.isOriginTime : isOriginTime // ignore: cast_nullable_to_non_nullable
as bool,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,isFinal: null == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isLevel: null == isLevel ? _self.isLevel : isLevel // ignore: cast_nullable_to_non_nullable
as bool,isOnePoint: null == isOnePoint ? _self.isOnePoint : isOnePoint // ignore: cast_nullable_to_non_nullable
as bool,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as UnifiedEewLocation?,
  ));
}
/// Create a copy of UnifiedEew
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedEewLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $UnifiedEewLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [UnifiedEew].
extension UnifiedEewPatterns on UnifiedEew {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnifiedEew value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnifiedEew() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnifiedEew value)  $default,){
final _that = this;
switch (_that) {
case _UnifiedEew():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnifiedEew value)?  $default,){
final _that = this;
switch (_that) {
case _UnifiedEew() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String headline,  String? hypocenterName,  double? magnitude,  double? depth,  DateTime? time,  bool isOriginTime,  JmaIntensity? maxIntensity,  int serialNo,  bool isFinal,  bool isWarning,  bool isCanceled,  bool isPlum,  bool isLevel,  bool isOnePoint,  DateTime issuedAt,  UnifiedEewLocation? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnifiedEew() when $default != null:
return $default(_that.eventId,_that.headline,_that.hypocenterName,_that.magnitude,_that.depth,_that.time,_that.isOriginTime,_that.maxIntensity,_that.serialNo,_that.isFinal,_that.isWarning,_that.isCanceled,_that.isPlum,_that.isLevel,_that.isOnePoint,_that.issuedAt,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String headline,  String? hypocenterName,  double? magnitude,  double? depth,  DateTime? time,  bool isOriginTime,  JmaIntensity? maxIntensity,  int serialNo,  bool isFinal,  bool isWarning,  bool isCanceled,  bool isPlum,  bool isLevel,  bool isOnePoint,  DateTime issuedAt,  UnifiedEewLocation? location)  $default,) {final _that = this;
switch (_that) {
case _UnifiedEew():
return $default(_that.eventId,_that.headline,_that.hypocenterName,_that.magnitude,_that.depth,_that.time,_that.isOriginTime,_that.maxIntensity,_that.serialNo,_that.isFinal,_that.isWarning,_that.isCanceled,_that.isPlum,_that.isLevel,_that.isOnePoint,_that.issuedAt,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String headline,  String? hypocenterName,  double? magnitude,  double? depth,  DateTime? time,  bool isOriginTime,  JmaIntensity? maxIntensity,  int serialNo,  bool isFinal,  bool isWarning,  bool isCanceled,  bool isPlum,  bool isLevel,  bool isOnePoint,  DateTime issuedAt,  UnifiedEewLocation? location)?  $default,) {final _that = this;
switch (_that) {
case _UnifiedEew() when $default != null:
return $default(_that.eventId,_that.headline,_that.hypocenterName,_that.magnitude,_that.depth,_that.time,_that.isOriginTime,_that.maxIntensity,_that.serialNo,_that.isFinal,_that.isWarning,_that.isCanceled,_that.isPlum,_that.isLevel,_that.isOnePoint,_that.issuedAt,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _UnifiedEew extends UnifiedEew {
  const _UnifiedEew({required this.eventId, required this.headline, required this.hypocenterName, required this.magnitude, required this.depth, required this.time, required this.isOriginTime, required this.maxIntensity, required this.serialNo, required this.isFinal, required this.isWarning, required this.isCanceled, required this.isPlum, required this.isLevel, required this.isOnePoint, required this.issuedAt, required this.location}): super._();
  

@override final  String eventId;
@override final  String headline;
@override final  String? hypocenterName;
@override final  double? magnitude;
@override final  double? depth;
@override final  DateTime? time;
@override final  bool isOriginTime;
@override final  JmaIntensity? maxIntensity;
@override final  int serialNo;
@override final  bool isFinal;
@override final  bool isWarning;
@override final  bool isCanceled;
@override final  bool isPlum;
@override final  bool isLevel;
@override final  bool isOnePoint;
@override final  DateTime issuedAt;
@override final  UnifiedEewLocation? location;

/// Create a copy of UnifiedEew
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnifiedEewCopyWith<_UnifiedEew> get copyWith => __$UnifiedEewCopyWithImpl<_UnifiedEew>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnifiedEew&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.hypocenterName, hypocenterName) || other.hypocenterName == hypocenterName)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.time, time) || other.time == time)&&(identical(other.isOriginTime, isOriginTime) || other.isOriginTime == isOriginTime)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isLevel, isLevel) || other.isLevel == isLevel)&&(identical(other.isOnePoint, isOnePoint) || other.isOnePoint == isOnePoint)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,headline,hypocenterName,magnitude,depth,time,isOriginTime,maxIntensity,serialNo,isFinal,isWarning,isCanceled,isPlum,isLevel,isOnePoint,issuedAt,location);

@override
String toString() {
  return 'UnifiedEew(eventId: $eventId, headline: $headline, hypocenterName: $hypocenterName, magnitude: $magnitude, depth: $depth, time: $time, isOriginTime: $isOriginTime, maxIntensity: $maxIntensity, serialNo: $serialNo, isFinal: $isFinal, isWarning: $isWarning, isCanceled: $isCanceled, isPlum: $isPlum, isLevel: $isLevel, isOnePoint: $isOnePoint, issuedAt: $issuedAt, location: $location)';
}


}

/// @nodoc
abstract mixin class _$UnifiedEewCopyWith<$Res> implements $UnifiedEewCopyWith<$Res> {
  factory _$UnifiedEewCopyWith(_UnifiedEew value, $Res Function(_UnifiedEew) _then) = __$UnifiedEewCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String headline, String? hypocenterName, double? magnitude, double? depth, DateTime? time, bool isOriginTime, JmaIntensity? maxIntensity, int serialNo, bool isFinal, bool isWarning, bool isCanceled, bool isPlum, bool isLevel, bool isOnePoint, DateTime issuedAt, UnifiedEewLocation? location
});


@override $UnifiedEewLocationCopyWith<$Res>? get location;

}
/// @nodoc
class __$UnifiedEewCopyWithImpl<$Res>
    implements _$UnifiedEewCopyWith<$Res> {
  __$UnifiedEewCopyWithImpl(this._self, this._then);

  final _UnifiedEew _self;
  final $Res Function(_UnifiedEew) _then;

/// Create a copy of UnifiedEew
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? headline = null,Object? hypocenterName = freezed,Object? magnitude = freezed,Object? depth = freezed,Object? time = freezed,Object? isOriginTime = null,Object? maxIntensity = freezed,Object? serialNo = null,Object? isFinal = null,Object? isWarning = null,Object? isCanceled = null,Object? isPlum = null,Object? isLevel = null,Object? isOnePoint = null,Object? issuedAt = null,Object? location = freezed,}) {
  return _then(_UnifiedEew(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,hypocenterName: freezed == hypocenterName ? _self.hypocenterName : hypocenterName // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime?,isOriginTime: null == isOriginTime ? _self.isOriginTime : isOriginTime // ignore: cast_nullable_to_non_nullable
as bool,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,isFinal: null == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isLevel: null == isLevel ? _self.isLevel : isLevel // ignore: cast_nullable_to_non_nullable
as bool,isOnePoint: null == isOnePoint ? _self.isOnePoint : isOnePoint // ignore: cast_nullable_to_non_nullable
as bool,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as UnifiedEewLocation?,
  ));
}

/// Create a copy of UnifiedEew
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedEewLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $UnifiedEewLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
