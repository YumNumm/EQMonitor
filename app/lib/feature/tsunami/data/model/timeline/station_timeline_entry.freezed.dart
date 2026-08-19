// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'station_timeline_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StationForecastTimelineEntry {

 DateTime? get highTideAt; DateTime? get firstHeightArrivalTime; FirstHeightCondition? get firstHeightCondition; Revise? get firstHeightRevise; String get telegramId; String? get headline; String get title; DateTime get publishedAt; DateTime? get revokedAt;
/// Create a copy of StationForecastTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationForecastTimelineEntryCopyWith<StationForecastTimelineEntry> get copyWith => _$StationForecastTimelineEntryCopyWithImpl<StationForecastTimelineEntry>(this as StationForecastTimelineEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationForecastTimelineEntry&&(identical(other.highTideAt, highTideAt) || other.highTideAt == highTideAt)&&(identical(other.firstHeightArrivalTime, firstHeightArrivalTime) || other.firstHeightArrivalTime == firstHeightArrivalTime)&&(identical(other.firstHeightCondition, firstHeightCondition) || other.firstHeightCondition == firstHeightCondition)&&(identical(other.firstHeightRevise, firstHeightRevise) || other.firstHeightRevise == firstHeightRevise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,highTideAt,firstHeightArrivalTime,firstHeightCondition,firstHeightRevise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'StationForecastTimelineEntry(highTideAt: $highTideAt, firstHeightArrivalTime: $firstHeightArrivalTime, firstHeightCondition: $firstHeightCondition, firstHeightRevise: $firstHeightRevise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class $StationForecastTimelineEntryCopyWith<$Res>  {
  factory $StationForecastTimelineEntryCopyWith(StationForecastTimelineEntry value, $Res Function(StationForecastTimelineEntry) _then) = _$StationForecastTimelineEntryCopyWithImpl;
@useResult
$Res call({
 DateTime? highTideAt, DateTime? firstHeightArrivalTime, FirstHeightCondition? firstHeightCondition, Revise? firstHeightRevise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class _$StationForecastTimelineEntryCopyWithImpl<$Res>
    implements $StationForecastTimelineEntryCopyWith<$Res> {
  _$StationForecastTimelineEntryCopyWithImpl(this._self, this._then);

  final StationForecastTimelineEntry _self;
  final $Res Function(StationForecastTimelineEntry) _then;

/// Create a copy of StationForecastTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? highTideAt = freezed,Object? firstHeightArrivalTime = freezed,Object? firstHeightCondition = freezed,Object? firstHeightRevise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(StationForecastTimelineEntry(
highTideAt: freezed == highTideAt ? _self.highTideAt : highTideAt // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightArrivalTime: freezed == firstHeightArrivalTime ? _self.firstHeightArrivalTime : firstHeightArrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightCondition: freezed == firstHeightCondition ? _self.firstHeightCondition : firstHeightCondition // ignore: cast_nullable_to_non_nullable
as FirstHeightCondition?,firstHeightRevise: freezed == firstHeightRevise ? _self.firstHeightRevise : firstHeightRevise // ignore: cast_nullable_to_non_nullable
as Revise?,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StationForecastTimelineEntry].
extension StationForecastTimelineEntryPatterns on StationForecastTimelineEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationForecastTimelineEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationForecastTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationForecastTimelineEntry value)  $default,){
final _that = this;
switch (_that) {
case _StationForecastTimelineEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationForecastTimelineEntry value)?  $default,){
final _that = this;
switch (_that) {
case _StationForecastTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? highTideAt,  DateTime? firstHeightArrivalTime,  FirstHeightCondition? firstHeightCondition,  Revise? firstHeightRevise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationForecastTimelineEntry() when $default != null:
return $default(_that.highTideAt,_that.firstHeightArrivalTime,_that.firstHeightCondition,_that.firstHeightRevise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? highTideAt,  DateTime? firstHeightArrivalTime,  FirstHeightCondition? firstHeightCondition,  Revise? firstHeightRevise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)  $default,) {final _that = this;
switch (_that) {
case _StationForecastTimelineEntry():
return $default(_that.highTideAt,_that.firstHeightArrivalTime,_that.firstHeightCondition,_that.firstHeightRevise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? highTideAt,  DateTime? firstHeightArrivalTime,  FirstHeightCondition? firstHeightCondition,  Revise? firstHeightRevise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,) {final _that = this;
switch (_that) {
case _StationForecastTimelineEntry() when $default != null:
return $default(_that.highTideAt,_that.firstHeightArrivalTime,_that.firstHeightCondition,_that.firstHeightRevise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
  return null;

}
}

}

/// @nodoc


class _StationForecastTimelineEntry implements StationForecastTimelineEntry {
  const _StationForecastTimelineEntry({required this.highTideAt, required this.firstHeightArrivalTime, required this.firstHeightCondition, required this.firstHeightRevise, required this.telegramId, required this.headline, required this.title, required this.publishedAt, required this.revokedAt});
  

@override final  DateTime? highTideAt;
@override final  DateTime? firstHeightArrivalTime;
@override final  FirstHeightCondition? firstHeightCondition;
@override final  Revise? firstHeightRevise;
@override final  String telegramId;
@override final  String? headline;
@override final  String title;
@override final  DateTime publishedAt;
@override final  DateTime? revokedAt;

/// Create a copy of StationForecastTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationForecastTimelineEntryCopyWith<_StationForecastTimelineEntry> get copyWith => __$StationForecastTimelineEntryCopyWithImpl<_StationForecastTimelineEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationForecastTimelineEntry&&(identical(other.highTideAt, highTideAt) || other.highTideAt == highTideAt)&&(identical(other.firstHeightArrivalTime, firstHeightArrivalTime) || other.firstHeightArrivalTime == firstHeightArrivalTime)&&(identical(other.firstHeightCondition, firstHeightCondition) || other.firstHeightCondition == firstHeightCondition)&&(identical(other.firstHeightRevise, firstHeightRevise) || other.firstHeightRevise == firstHeightRevise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,highTideAt,firstHeightArrivalTime,firstHeightCondition,firstHeightRevise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'StationForecastTimelineEntry(highTideAt: $highTideAt, firstHeightArrivalTime: $firstHeightArrivalTime, firstHeightCondition: $firstHeightCondition, firstHeightRevise: $firstHeightRevise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class _$StationForecastTimelineEntryCopyWith<$Res> implements $StationForecastTimelineEntryCopyWith<$Res> {
  factory _$StationForecastTimelineEntryCopyWith(_StationForecastTimelineEntry value, $Res Function(_StationForecastTimelineEntry) _then) = __$StationForecastTimelineEntryCopyWithImpl;
@override @useResult
$Res call({
 DateTime? highTideAt, DateTime? firstHeightArrivalTime, FirstHeightCondition? firstHeightCondition, Revise? firstHeightRevise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class __$StationForecastTimelineEntryCopyWithImpl<$Res>
    implements _$StationForecastTimelineEntryCopyWith<$Res> {
  __$StationForecastTimelineEntryCopyWithImpl(this._self, this._then);

  final _StationForecastTimelineEntry _self;
  final $Res Function(_StationForecastTimelineEntry) _then;

/// Create a copy of StationForecastTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? highTideAt = freezed,Object? firstHeightArrivalTime = freezed,Object? firstHeightCondition = freezed,Object? firstHeightRevise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_StationForecastTimelineEntry(
highTideAt: freezed == highTideAt ? _self.highTideAt : highTideAt // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightArrivalTime: freezed == firstHeightArrivalTime ? _self.firstHeightArrivalTime : firstHeightArrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightCondition: freezed == firstHeightCondition ? _self.firstHeightCondition : firstHeightCondition // ignore: cast_nullable_to_non_nullable
as FirstHeightCondition?,firstHeightRevise: freezed == firstHeightRevise ? _self.firstHeightRevise : firstHeightRevise // ignore: cast_nullable_to_non_nullable
as Revise?,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$StationObservationTimelineEntry {

 String? get sensor; DateTime? get firstHeightArrivalTime; WaveInitial? get firstHeightInitial; bool? get firstHeightIsUnidentifiable; bool? get firstHeightIsMissing; Revise? get firstHeightRevise; DateTime? get maxHeightDateTime; double? get maxHeightValue; bool? get maxHeightIsOver; bool? get maxHeightIsRising; ObservationMaxHeightCondition? get maxHeightCondition; bool? get maxHeightIsMissing; Revise? get maxHeightRevise; String get telegramId; String? get headline; String get title; DateTime get publishedAt; DateTime? get revokedAt;
/// Create a copy of StationObservationTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationObservationTimelineEntryCopyWith<StationObservationTimelineEntry> get copyWith => _$StationObservationTimelineEntryCopyWithImpl<StationObservationTimelineEntry>(this as StationObservationTimelineEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationObservationTimelineEntry&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.firstHeightArrivalTime, firstHeightArrivalTime) || other.firstHeightArrivalTime == firstHeightArrivalTime)&&(identical(other.firstHeightInitial, firstHeightInitial) || other.firstHeightInitial == firstHeightInitial)&&(identical(other.firstHeightIsUnidentifiable, firstHeightIsUnidentifiable) || other.firstHeightIsUnidentifiable == firstHeightIsUnidentifiable)&&(identical(other.firstHeightIsMissing, firstHeightIsMissing) || other.firstHeightIsMissing == firstHeightIsMissing)&&(identical(other.firstHeightRevise, firstHeightRevise) || other.firstHeightRevise == firstHeightRevise)&&(identical(other.maxHeightDateTime, maxHeightDateTime) || other.maxHeightDateTime == maxHeightDateTime)&&(identical(other.maxHeightValue, maxHeightValue) || other.maxHeightValue == maxHeightValue)&&(identical(other.maxHeightIsOver, maxHeightIsOver) || other.maxHeightIsOver == maxHeightIsOver)&&(identical(other.maxHeightIsRising, maxHeightIsRising) || other.maxHeightIsRising == maxHeightIsRising)&&(identical(other.maxHeightCondition, maxHeightCondition) || other.maxHeightCondition == maxHeightCondition)&&(identical(other.maxHeightIsMissing, maxHeightIsMissing) || other.maxHeightIsMissing == maxHeightIsMissing)&&(identical(other.maxHeightRevise, maxHeightRevise) || other.maxHeightRevise == maxHeightRevise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,sensor,firstHeightArrivalTime,firstHeightInitial,firstHeightIsUnidentifiable,firstHeightIsMissing,firstHeightRevise,maxHeightDateTime,maxHeightValue,maxHeightIsOver,maxHeightIsRising,maxHeightCondition,maxHeightIsMissing,maxHeightRevise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'StationObservationTimelineEntry(sensor: $sensor, firstHeightArrivalTime: $firstHeightArrivalTime, firstHeightInitial: $firstHeightInitial, firstHeightIsUnidentifiable: $firstHeightIsUnidentifiable, firstHeightIsMissing: $firstHeightIsMissing, firstHeightRevise: $firstHeightRevise, maxHeightDateTime: $maxHeightDateTime, maxHeightValue: $maxHeightValue, maxHeightIsOver: $maxHeightIsOver, maxHeightIsRising: $maxHeightIsRising, maxHeightCondition: $maxHeightCondition, maxHeightIsMissing: $maxHeightIsMissing, maxHeightRevise: $maxHeightRevise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class $StationObservationTimelineEntryCopyWith<$Res>  {
  factory $StationObservationTimelineEntryCopyWith(StationObservationTimelineEntry value, $Res Function(StationObservationTimelineEntry) _then) = _$StationObservationTimelineEntryCopyWithImpl;
@useResult
$Res call({
 String? sensor, DateTime? firstHeightArrivalTime, WaveInitial? firstHeightInitial, bool? firstHeightIsUnidentifiable, bool? firstHeightIsMissing, Revise? firstHeightRevise, DateTime? maxHeightDateTime, double? maxHeightValue, bool? maxHeightIsOver, bool? maxHeightIsRising, ObservationMaxHeightCondition? maxHeightCondition, bool? maxHeightIsMissing, Revise? maxHeightRevise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class _$StationObservationTimelineEntryCopyWithImpl<$Res>
    implements $StationObservationTimelineEntryCopyWith<$Res> {
  _$StationObservationTimelineEntryCopyWithImpl(this._self, this._then);

  final StationObservationTimelineEntry _self;
  final $Res Function(StationObservationTimelineEntry) _then;

/// Create a copy of StationObservationTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sensor = freezed,Object? firstHeightArrivalTime = freezed,Object? firstHeightInitial = freezed,Object? firstHeightIsUnidentifiable = freezed,Object? firstHeightIsMissing = freezed,Object? firstHeightRevise = freezed,Object? maxHeightDateTime = freezed,Object? maxHeightValue = freezed,Object? maxHeightIsOver = freezed,Object? maxHeightIsRising = freezed,Object? maxHeightCondition = freezed,Object? maxHeightIsMissing = freezed,Object? maxHeightRevise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(StationObservationTimelineEntry(
sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as String?,firstHeightArrivalTime: freezed == firstHeightArrivalTime ? _self.firstHeightArrivalTime : firstHeightArrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightInitial: freezed == firstHeightInitial ? _self.firstHeightInitial : firstHeightInitial // ignore: cast_nullable_to_non_nullable
as WaveInitial?,firstHeightIsUnidentifiable: freezed == firstHeightIsUnidentifiable ? _self.firstHeightIsUnidentifiable : firstHeightIsUnidentifiable // ignore: cast_nullable_to_non_nullable
as bool?,firstHeightIsMissing: freezed == firstHeightIsMissing ? _self.firstHeightIsMissing : firstHeightIsMissing // ignore: cast_nullable_to_non_nullable
as bool?,firstHeightRevise: freezed == firstHeightRevise ? _self.firstHeightRevise : firstHeightRevise // ignore: cast_nullable_to_non_nullable
as Revise?,maxHeightDateTime: freezed == maxHeightDateTime ? _self.maxHeightDateTime : maxHeightDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,maxHeightValue: freezed == maxHeightValue ? _self.maxHeightValue : maxHeightValue // ignore: cast_nullable_to_non_nullable
as double?,maxHeightIsOver: freezed == maxHeightIsOver ? _self.maxHeightIsOver : maxHeightIsOver // ignore: cast_nullable_to_non_nullable
as bool?,maxHeightIsRising: freezed == maxHeightIsRising ? _self.maxHeightIsRising : maxHeightIsRising // ignore: cast_nullable_to_non_nullable
as bool?,maxHeightCondition: freezed == maxHeightCondition ? _self.maxHeightCondition : maxHeightCondition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition?,maxHeightIsMissing: freezed == maxHeightIsMissing ? _self.maxHeightIsMissing : maxHeightIsMissing // ignore: cast_nullable_to_non_nullable
as bool?,maxHeightRevise: freezed == maxHeightRevise ? _self.maxHeightRevise : maxHeightRevise // ignore: cast_nullable_to_non_nullable
as Revise?,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StationObservationTimelineEntry].
extension StationObservationTimelineEntryPatterns on StationObservationTimelineEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationObservationTimelineEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationObservationTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationObservationTimelineEntry value)  $default,){
final _that = this;
switch (_that) {
case _StationObservationTimelineEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationObservationTimelineEntry value)?  $default,){
final _that = this;
switch (_that) {
case _StationObservationTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? sensor,  DateTime? firstHeightArrivalTime,  WaveInitial? firstHeightInitial,  bool? firstHeightIsUnidentifiable,  bool? firstHeightIsMissing,  Revise? firstHeightRevise,  DateTime? maxHeightDateTime,  double? maxHeightValue,  bool? maxHeightIsOver,  bool? maxHeightIsRising,  ObservationMaxHeightCondition? maxHeightCondition,  bool? maxHeightIsMissing,  Revise? maxHeightRevise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationObservationTimelineEntry() when $default != null:
return $default(_that.sensor,_that.firstHeightArrivalTime,_that.firstHeightInitial,_that.firstHeightIsUnidentifiable,_that.firstHeightIsMissing,_that.firstHeightRevise,_that.maxHeightDateTime,_that.maxHeightValue,_that.maxHeightIsOver,_that.maxHeightIsRising,_that.maxHeightCondition,_that.maxHeightIsMissing,_that.maxHeightRevise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? sensor,  DateTime? firstHeightArrivalTime,  WaveInitial? firstHeightInitial,  bool? firstHeightIsUnidentifiable,  bool? firstHeightIsMissing,  Revise? firstHeightRevise,  DateTime? maxHeightDateTime,  double? maxHeightValue,  bool? maxHeightIsOver,  bool? maxHeightIsRising,  ObservationMaxHeightCondition? maxHeightCondition,  bool? maxHeightIsMissing,  Revise? maxHeightRevise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)  $default,) {final _that = this;
switch (_that) {
case _StationObservationTimelineEntry():
return $default(_that.sensor,_that.firstHeightArrivalTime,_that.firstHeightInitial,_that.firstHeightIsUnidentifiable,_that.firstHeightIsMissing,_that.firstHeightRevise,_that.maxHeightDateTime,_that.maxHeightValue,_that.maxHeightIsOver,_that.maxHeightIsRising,_that.maxHeightCondition,_that.maxHeightIsMissing,_that.maxHeightRevise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? sensor,  DateTime? firstHeightArrivalTime,  WaveInitial? firstHeightInitial,  bool? firstHeightIsUnidentifiable,  bool? firstHeightIsMissing,  Revise? firstHeightRevise,  DateTime? maxHeightDateTime,  double? maxHeightValue,  bool? maxHeightIsOver,  bool? maxHeightIsRising,  ObservationMaxHeightCondition? maxHeightCondition,  bool? maxHeightIsMissing,  Revise? maxHeightRevise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,) {final _that = this;
switch (_that) {
case _StationObservationTimelineEntry() when $default != null:
return $default(_that.sensor,_that.firstHeightArrivalTime,_that.firstHeightInitial,_that.firstHeightIsUnidentifiable,_that.firstHeightIsMissing,_that.firstHeightRevise,_that.maxHeightDateTime,_that.maxHeightValue,_that.maxHeightIsOver,_that.maxHeightIsRising,_that.maxHeightCondition,_that.maxHeightIsMissing,_that.maxHeightRevise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
  return null;

}
}

}

/// @nodoc


class _StationObservationTimelineEntry implements StationObservationTimelineEntry {
  const _StationObservationTimelineEntry({required this.sensor, required this.firstHeightArrivalTime, required this.firstHeightInitial, required this.firstHeightIsUnidentifiable, required this.firstHeightIsMissing, required this.firstHeightRevise, required this.maxHeightDateTime, required this.maxHeightValue, required this.maxHeightIsOver, required this.maxHeightIsRising, required this.maxHeightCondition, required this.maxHeightIsMissing, required this.maxHeightRevise, required this.telegramId, required this.headline, required this.title, required this.publishedAt, required this.revokedAt});
  

@override final  String? sensor;
@override final  DateTime? firstHeightArrivalTime;
@override final  WaveInitial? firstHeightInitial;
@override final  bool? firstHeightIsUnidentifiable;
@override final  bool? firstHeightIsMissing;
@override final  Revise? firstHeightRevise;
@override final  DateTime? maxHeightDateTime;
@override final  double? maxHeightValue;
@override final  bool? maxHeightIsOver;
@override final  bool? maxHeightIsRising;
@override final  ObservationMaxHeightCondition? maxHeightCondition;
@override final  bool? maxHeightIsMissing;
@override final  Revise? maxHeightRevise;
@override final  String telegramId;
@override final  String? headline;
@override final  String title;
@override final  DateTime publishedAt;
@override final  DateTime? revokedAt;

/// Create a copy of StationObservationTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationObservationTimelineEntryCopyWith<_StationObservationTimelineEntry> get copyWith => __$StationObservationTimelineEntryCopyWithImpl<_StationObservationTimelineEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationObservationTimelineEntry&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.firstHeightArrivalTime, firstHeightArrivalTime) || other.firstHeightArrivalTime == firstHeightArrivalTime)&&(identical(other.firstHeightInitial, firstHeightInitial) || other.firstHeightInitial == firstHeightInitial)&&(identical(other.firstHeightIsUnidentifiable, firstHeightIsUnidentifiable) || other.firstHeightIsUnidentifiable == firstHeightIsUnidentifiable)&&(identical(other.firstHeightIsMissing, firstHeightIsMissing) || other.firstHeightIsMissing == firstHeightIsMissing)&&(identical(other.firstHeightRevise, firstHeightRevise) || other.firstHeightRevise == firstHeightRevise)&&(identical(other.maxHeightDateTime, maxHeightDateTime) || other.maxHeightDateTime == maxHeightDateTime)&&(identical(other.maxHeightValue, maxHeightValue) || other.maxHeightValue == maxHeightValue)&&(identical(other.maxHeightIsOver, maxHeightIsOver) || other.maxHeightIsOver == maxHeightIsOver)&&(identical(other.maxHeightIsRising, maxHeightIsRising) || other.maxHeightIsRising == maxHeightIsRising)&&(identical(other.maxHeightCondition, maxHeightCondition) || other.maxHeightCondition == maxHeightCondition)&&(identical(other.maxHeightIsMissing, maxHeightIsMissing) || other.maxHeightIsMissing == maxHeightIsMissing)&&(identical(other.maxHeightRevise, maxHeightRevise) || other.maxHeightRevise == maxHeightRevise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,sensor,firstHeightArrivalTime,firstHeightInitial,firstHeightIsUnidentifiable,firstHeightIsMissing,firstHeightRevise,maxHeightDateTime,maxHeightValue,maxHeightIsOver,maxHeightIsRising,maxHeightCondition,maxHeightIsMissing,maxHeightRevise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'StationObservationTimelineEntry(sensor: $sensor, firstHeightArrivalTime: $firstHeightArrivalTime, firstHeightInitial: $firstHeightInitial, firstHeightIsUnidentifiable: $firstHeightIsUnidentifiable, firstHeightIsMissing: $firstHeightIsMissing, firstHeightRevise: $firstHeightRevise, maxHeightDateTime: $maxHeightDateTime, maxHeightValue: $maxHeightValue, maxHeightIsOver: $maxHeightIsOver, maxHeightIsRising: $maxHeightIsRising, maxHeightCondition: $maxHeightCondition, maxHeightIsMissing: $maxHeightIsMissing, maxHeightRevise: $maxHeightRevise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class _$StationObservationTimelineEntryCopyWith<$Res> implements $StationObservationTimelineEntryCopyWith<$Res> {
  factory _$StationObservationTimelineEntryCopyWith(_StationObservationTimelineEntry value, $Res Function(_StationObservationTimelineEntry) _then) = __$StationObservationTimelineEntryCopyWithImpl;
@override @useResult
$Res call({
 String? sensor, DateTime? firstHeightArrivalTime, WaveInitial? firstHeightInitial, bool? firstHeightIsUnidentifiable, bool? firstHeightIsMissing, Revise? firstHeightRevise, DateTime? maxHeightDateTime, double? maxHeightValue, bool? maxHeightIsOver, bool? maxHeightIsRising, ObservationMaxHeightCondition? maxHeightCondition, bool? maxHeightIsMissing, Revise? maxHeightRevise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class __$StationObservationTimelineEntryCopyWithImpl<$Res>
    implements _$StationObservationTimelineEntryCopyWith<$Res> {
  __$StationObservationTimelineEntryCopyWithImpl(this._self, this._then);

  final _StationObservationTimelineEntry _self;
  final $Res Function(_StationObservationTimelineEntry) _then;

/// Create a copy of StationObservationTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sensor = freezed,Object? firstHeightArrivalTime = freezed,Object? firstHeightInitial = freezed,Object? firstHeightIsUnidentifiable = freezed,Object? firstHeightIsMissing = freezed,Object? firstHeightRevise = freezed,Object? maxHeightDateTime = freezed,Object? maxHeightValue = freezed,Object? maxHeightIsOver = freezed,Object? maxHeightIsRising = freezed,Object? maxHeightCondition = freezed,Object? maxHeightIsMissing = freezed,Object? maxHeightRevise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_StationObservationTimelineEntry(
sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as String?,firstHeightArrivalTime: freezed == firstHeightArrivalTime ? _self.firstHeightArrivalTime : firstHeightArrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightInitial: freezed == firstHeightInitial ? _self.firstHeightInitial : firstHeightInitial // ignore: cast_nullable_to_non_nullable
as WaveInitial?,firstHeightIsUnidentifiable: freezed == firstHeightIsUnidentifiable ? _self.firstHeightIsUnidentifiable : firstHeightIsUnidentifiable // ignore: cast_nullable_to_non_nullable
as bool?,firstHeightIsMissing: freezed == firstHeightIsMissing ? _self.firstHeightIsMissing : firstHeightIsMissing // ignore: cast_nullable_to_non_nullable
as bool?,firstHeightRevise: freezed == firstHeightRevise ? _self.firstHeightRevise : firstHeightRevise // ignore: cast_nullable_to_non_nullable
as Revise?,maxHeightDateTime: freezed == maxHeightDateTime ? _self.maxHeightDateTime : maxHeightDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,maxHeightValue: freezed == maxHeightValue ? _self.maxHeightValue : maxHeightValue // ignore: cast_nullable_to_non_nullable
as double?,maxHeightIsOver: freezed == maxHeightIsOver ? _self.maxHeightIsOver : maxHeightIsOver // ignore: cast_nullable_to_non_nullable
as bool?,maxHeightIsRising: freezed == maxHeightIsRising ? _self.maxHeightIsRising : maxHeightIsRising // ignore: cast_nullable_to_non_nullable
as bool?,maxHeightCondition: freezed == maxHeightCondition ? _self.maxHeightCondition : maxHeightCondition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition?,maxHeightIsMissing: freezed == maxHeightIsMissing ? _self.maxHeightIsMissing : maxHeightIsMissing // ignore: cast_nullable_to_non_nullable
as bool?,maxHeightRevise: freezed == maxHeightRevise ? _self.maxHeightRevise : maxHeightRevise // ignore: cast_nullable_to_non_nullable
as Revise?,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
