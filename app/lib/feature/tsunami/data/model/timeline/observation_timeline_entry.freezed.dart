// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation_timeline_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ObservationFirstHeightTimelineEntry {

// 追跡項目のフィールド
 DateTime? get arrivalTime; WaveInitial? get initial; bool? get isUnidentifiable; bool? get isMissing; Revise? get revise;// 電文メタ
 String get telegramId; String? get headline; String get title; DateTime get publishedAt; DateTime? get revokedAt;
/// Create a copy of ObservationFirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationFirstHeightTimelineEntryCopyWith<ObservationFirstHeightTimelineEntry> get copyWith => _$ObservationFirstHeightTimelineEntryCopyWithImpl<ObservationFirstHeightTimelineEntry>(this as ObservationFirstHeightTimelineEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObservationFirstHeightTimelineEntry&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.isUnidentifiable, isUnidentifiable) || other.isUnidentifiable == isUnidentifiable)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,initial,isUnidentifiable,isMissing,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'ObservationFirstHeightTimelineEntry(arrivalTime: $arrivalTime, initial: $initial, isUnidentifiable: $isUnidentifiable, isMissing: $isMissing, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class $ObservationFirstHeightTimelineEntryCopyWith<$Res>  {
  factory $ObservationFirstHeightTimelineEntryCopyWith(ObservationFirstHeightTimelineEntry value, $Res Function(ObservationFirstHeightTimelineEntry) _then) = _$ObservationFirstHeightTimelineEntryCopyWithImpl;
@useResult
$Res call({
 DateTime? arrivalTime, WaveInitial? initial, bool? isUnidentifiable, bool? isMissing, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class _$ObservationFirstHeightTimelineEntryCopyWithImpl<$Res>
    implements $ObservationFirstHeightTimelineEntryCopyWith<$Res> {
  _$ObservationFirstHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final ObservationFirstHeightTimelineEntry _self;
  final $Res Function(ObservationFirstHeightTimelineEntry) _then;

/// Create a copy of ObservationFirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? initial = freezed,Object? isUnidentifiable = freezed,Object? isMissing = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_self.copyWith(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,initial: freezed == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as WaveInitial?,isUnidentifiable: freezed == isUnidentifiable ? _self.isUnidentifiable : isUnidentifiable // ignore: cast_nullable_to_non_nullable
as bool?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ObservationFirstHeightTimelineEntry].
extension ObservationFirstHeightTimelineEntryPatterns on ObservationFirstHeightTimelineEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObservationFirstHeightTimelineEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObservationFirstHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObservationFirstHeightTimelineEntry value)  $default,){
final _that = this;
switch (_that) {
case _ObservationFirstHeightTimelineEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObservationFirstHeightTimelineEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ObservationFirstHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? arrivalTime,  WaveInitial? initial,  bool? isUnidentifiable,  bool? isMissing,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObservationFirstHeightTimelineEntry() when $default != null:
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? arrivalTime,  WaveInitial? initial,  bool? isUnidentifiable,  bool? isMissing,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)  $default,) {final _that = this;
switch (_that) {
case _ObservationFirstHeightTimelineEntry():
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? arrivalTime,  WaveInitial? initial,  bool? isUnidentifiable,  bool? isMissing,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,) {final _that = this;
switch (_that) {
case _ObservationFirstHeightTimelineEntry() when $default != null:
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ObservationFirstHeightTimelineEntry implements ObservationFirstHeightTimelineEntry {
  const _ObservationFirstHeightTimelineEntry({required this.arrivalTime, required this.initial, required this.isUnidentifiable, required this.isMissing, required this.revise, required this.telegramId, required this.headline, required this.title, required this.publishedAt, required this.revokedAt});
  

// 追跡項目のフィールド
@override final  DateTime? arrivalTime;
@override final  WaveInitial? initial;
@override final  bool? isUnidentifiable;
@override final  bool? isMissing;
@override final  Revise? revise;
// 電文メタ
@override final  String telegramId;
@override final  String? headline;
@override final  String title;
@override final  DateTime publishedAt;
@override final  DateTime? revokedAt;

/// Create a copy of ObservationFirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservationFirstHeightTimelineEntryCopyWith<_ObservationFirstHeightTimelineEntry> get copyWith => __$ObservationFirstHeightTimelineEntryCopyWithImpl<_ObservationFirstHeightTimelineEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObservationFirstHeightTimelineEntry&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.isUnidentifiable, isUnidentifiable) || other.isUnidentifiable == isUnidentifiable)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,initial,isUnidentifiable,isMissing,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'ObservationFirstHeightTimelineEntry(arrivalTime: $arrivalTime, initial: $initial, isUnidentifiable: $isUnidentifiable, isMissing: $isMissing, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class _$ObservationFirstHeightTimelineEntryCopyWith<$Res> implements $ObservationFirstHeightTimelineEntryCopyWith<$Res> {
  factory _$ObservationFirstHeightTimelineEntryCopyWith(_ObservationFirstHeightTimelineEntry value, $Res Function(_ObservationFirstHeightTimelineEntry) _then) = __$ObservationFirstHeightTimelineEntryCopyWithImpl;
@override @useResult
$Res call({
 DateTime? arrivalTime, WaveInitial? initial, bool? isUnidentifiable, bool? isMissing, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class __$ObservationFirstHeightTimelineEntryCopyWithImpl<$Res>
    implements _$ObservationFirstHeightTimelineEntryCopyWith<$Res> {
  __$ObservationFirstHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final _ObservationFirstHeightTimelineEntry _self;
  final $Res Function(_ObservationFirstHeightTimelineEntry) _then;

/// Create a copy of ObservationFirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? initial = freezed,Object? isUnidentifiable = freezed,Object? isMissing = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_ObservationFirstHeightTimelineEntry(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,initial: freezed == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as WaveInitial?,isUnidentifiable: freezed == isUnidentifiable ? _self.isUnidentifiable : isUnidentifiable // ignore: cast_nullable_to_non_nullable
as bool?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
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
mixin _$ObservationMaxHeightTimelineEntry {

// 追跡項目のフィールド
 DateTime? get dateTime; double? get value; bool? get isOver; bool? get isRising; ObservationMaxHeightCondition? get condition; bool? get isMissing; Revise? get revise;// 電文メタ
 String get telegramId; String? get headline; String get title; DateTime get publishedAt; DateTime? get revokedAt;
/// Create a copy of ObservationMaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationMaxHeightTimelineEntryCopyWith<ObservationMaxHeightTimelineEntry> get copyWith => _$ObservationMaxHeightTimelineEntryCopyWithImpl<ObservationMaxHeightTimelineEntry>(this as ObservationMaxHeightTimelineEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObservationMaxHeightTimelineEntry&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.isRising, isRising) || other.isRising == isRising)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,value,isOver,isRising,condition,isMissing,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'ObservationMaxHeightTimelineEntry(dateTime: $dateTime, value: $value, isOver: $isOver, isRising: $isRising, condition: $condition, isMissing: $isMissing, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class $ObservationMaxHeightTimelineEntryCopyWith<$Res>  {
  factory $ObservationMaxHeightTimelineEntryCopyWith(ObservationMaxHeightTimelineEntry value, $Res Function(ObservationMaxHeightTimelineEntry) _then) = _$ObservationMaxHeightTimelineEntryCopyWithImpl;
@useResult
$Res call({
 DateTime? dateTime, double? value, bool? isOver, bool? isRising, ObservationMaxHeightCondition? condition, bool? isMissing, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class _$ObservationMaxHeightTimelineEntryCopyWithImpl<$Res>
    implements $ObservationMaxHeightTimelineEntryCopyWith<$Res> {
  _$ObservationMaxHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final ObservationMaxHeightTimelineEntry _self;
  final $Res Function(ObservationMaxHeightTimelineEntry) _then;

/// Create a copy of ObservationMaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = freezed,Object? value = freezed,Object? isOver = freezed,Object? isRising = freezed,Object? condition = freezed,Object? isMissing = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_self.copyWith(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,isRising: freezed == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ObservationMaxHeightTimelineEntry].
extension ObservationMaxHeightTimelineEntryPatterns on ObservationMaxHeightTimelineEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObservationMaxHeightTimelineEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObservationMaxHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObservationMaxHeightTimelineEntry value)  $default,){
final _that = this;
switch (_that) {
case _ObservationMaxHeightTimelineEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObservationMaxHeightTimelineEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ObservationMaxHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? dateTime,  double? value,  bool? isOver,  bool? isRising,  ObservationMaxHeightCondition? condition,  bool? isMissing,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObservationMaxHeightTimelineEntry() when $default != null:
return $default(_that.dateTime,_that.value,_that.isOver,_that.isRising,_that.condition,_that.isMissing,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? dateTime,  double? value,  bool? isOver,  bool? isRising,  ObservationMaxHeightCondition? condition,  bool? isMissing,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)  $default,) {final _that = this;
switch (_that) {
case _ObservationMaxHeightTimelineEntry():
return $default(_that.dateTime,_that.value,_that.isOver,_that.isRising,_that.condition,_that.isMissing,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? dateTime,  double? value,  bool? isOver,  bool? isRising,  ObservationMaxHeightCondition? condition,  bool? isMissing,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,) {final _that = this;
switch (_that) {
case _ObservationMaxHeightTimelineEntry() when $default != null:
return $default(_that.dateTime,_that.value,_that.isOver,_that.isRising,_that.condition,_that.isMissing,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ObservationMaxHeightTimelineEntry implements ObservationMaxHeightTimelineEntry {
  const _ObservationMaxHeightTimelineEntry({required this.dateTime, required this.value, required this.isOver, required this.isRising, required this.condition, required this.isMissing, required this.revise, required this.telegramId, required this.headline, required this.title, required this.publishedAt, required this.revokedAt});
  

// 追跡項目のフィールド
@override final  DateTime? dateTime;
@override final  double? value;
@override final  bool? isOver;
@override final  bool? isRising;
@override final  ObservationMaxHeightCondition? condition;
@override final  bool? isMissing;
@override final  Revise? revise;
// 電文メタ
@override final  String telegramId;
@override final  String? headline;
@override final  String title;
@override final  DateTime publishedAt;
@override final  DateTime? revokedAt;

/// Create a copy of ObservationMaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservationMaxHeightTimelineEntryCopyWith<_ObservationMaxHeightTimelineEntry> get copyWith => __$ObservationMaxHeightTimelineEntryCopyWithImpl<_ObservationMaxHeightTimelineEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObservationMaxHeightTimelineEntry&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.isRising, isRising) || other.isRising == isRising)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,value,isOver,isRising,condition,isMissing,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'ObservationMaxHeightTimelineEntry(dateTime: $dateTime, value: $value, isOver: $isOver, isRising: $isRising, condition: $condition, isMissing: $isMissing, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class _$ObservationMaxHeightTimelineEntryCopyWith<$Res> implements $ObservationMaxHeightTimelineEntryCopyWith<$Res> {
  factory _$ObservationMaxHeightTimelineEntryCopyWith(_ObservationMaxHeightTimelineEntry value, $Res Function(_ObservationMaxHeightTimelineEntry) _then) = __$ObservationMaxHeightTimelineEntryCopyWithImpl;
@override @useResult
$Res call({
 DateTime? dateTime, double? value, bool? isOver, bool? isRising, ObservationMaxHeightCondition? condition, bool? isMissing, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class __$ObservationMaxHeightTimelineEntryCopyWithImpl<$Res>
    implements _$ObservationMaxHeightTimelineEntryCopyWith<$Res> {
  __$ObservationMaxHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final _ObservationMaxHeightTimelineEntry _self;
  final $Res Function(_ObservationMaxHeightTimelineEntry) _then;

/// Create a copy of ObservationMaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = freezed,Object? value = freezed,Object? isOver = freezed,Object? isRising = freezed,Object? condition = freezed,Object? isMissing = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_ObservationMaxHeightTimelineEntry(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,isRising: freezed == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
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
