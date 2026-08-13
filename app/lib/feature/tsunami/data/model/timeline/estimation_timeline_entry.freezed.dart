// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimation_timeline_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EstimationFirstHeightTimelineEntry {

 DateTime? get arrivalTime; bool? get isAlreadyArrived; Revise? get revise; String get telegramId; String? get headline; String get title; DateTime get publishedAt; DateTime? get revokedAt;
/// Create a copy of EstimationFirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimationFirstHeightTimelineEntryCopyWith<EstimationFirstHeightTimelineEntry> get copyWith => _$EstimationFirstHeightTimelineEntryCopyWithImpl<EstimationFirstHeightTimelineEntry>(this as EstimationFirstHeightTimelineEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimationFirstHeightTimelineEntry&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.isAlreadyArrived, isAlreadyArrived) || other.isAlreadyArrived == isAlreadyArrived)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,isAlreadyArrived,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'EstimationFirstHeightTimelineEntry(arrivalTime: $arrivalTime, isAlreadyArrived: $isAlreadyArrived, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class $EstimationFirstHeightTimelineEntryCopyWith<$Res>  {
  factory $EstimationFirstHeightTimelineEntryCopyWith(EstimationFirstHeightTimelineEntry value, $Res Function(EstimationFirstHeightTimelineEntry) _then) = _$EstimationFirstHeightTimelineEntryCopyWithImpl;
@useResult
$Res call({
 DateTime? arrivalTime, bool? isAlreadyArrived, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class _$EstimationFirstHeightTimelineEntryCopyWithImpl<$Res>
    implements $EstimationFirstHeightTimelineEntryCopyWith<$Res> {
  _$EstimationFirstHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final EstimationFirstHeightTimelineEntry _self;
  final $Res Function(EstimationFirstHeightTimelineEntry) _then;

/// Create a copy of EstimationFirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? isAlreadyArrived = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(EstimationFirstHeightTimelineEntry(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isAlreadyArrived: freezed == isAlreadyArrived ? _self.isAlreadyArrived : isAlreadyArrived // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [EstimationFirstHeightTimelineEntry].
extension EstimationFirstHeightTimelineEntryPatterns on EstimationFirstHeightTimelineEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimationFirstHeightTimelineEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimationFirstHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimationFirstHeightTimelineEntry value)  $default,){
final _that = this;
switch (_that) {
case _EstimationFirstHeightTimelineEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimationFirstHeightTimelineEntry value)?  $default,){
final _that = this;
switch (_that) {
case _EstimationFirstHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? arrivalTime,  bool? isAlreadyArrived,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimationFirstHeightTimelineEntry() when $default != null:
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? arrivalTime,  bool? isAlreadyArrived,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)  $default,) {final _that = this;
switch (_that) {
case _EstimationFirstHeightTimelineEntry():
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? arrivalTime,  bool? isAlreadyArrived,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,) {final _that = this;
switch (_that) {
case _EstimationFirstHeightTimelineEntry() when $default != null:
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
  return null;

}
}

}

/// @nodoc


class _EstimationFirstHeightTimelineEntry implements EstimationFirstHeightTimelineEntry {
  const _EstimationFirstHeightTimelineEntry({required this.arrivalTime, required this.isAlreadyArrived, required this.revise, required this.telegramId, required this.headline, required this.title, required this.publishedAt, required this.revokedAt});
  

@override final  DateTime? arrivalTime;
@override final  bool? isAlreadyArrived;
@override final  Revise? revise;
@override final  String telegramId;
@override final  String? headline;
@override final  String title;
@override final  DateTime publishedAt;
@override final  DateTime? revokedAt;

/// Create a copy of EstimationFirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimationFirstHeightTimelineEntryCopyWith<_EstimationFirstHeightTimelineEntry> get copyWith => __$EstimationFirstHeightTimelineEntryCopyWithImpl<_EstimationFirstHeightTimelineEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimationFirstHeightTimelineEntry&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.isAlreadyArrived, isAlreadyArrived) || other.isAlreadyArrived == isAlreadyArrived)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,isAlreadyArrived,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'EstimationFirstHeightTimelineEntry(arrivalTime: $arrivalTime, isAlreadyArrived: $isAlreadyArrived, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class _$EstimationFirstHeightTimelineEntryCopyWith<$Res> implements $EstimationFirstHeightTimelineEntryCopyWith<$Res> {
  factory _$EstimationFirstHeightTimelineEntryCopyWith(_EstimationFirstHeightTimelineEntry value, $Res Function(_EstimationFirstHeightTimelineEntry) _then) = __$EstimationFirstHeightTimelineEntryCopyWithImpl;
@override @useResult
$Res call({
 DateTime? arrivalTime, bool? isAlreadyArrived, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class __$EstimationFirstHeightTimelineEntryCopyWithImpl<$Res>
    implements _$EstimationFirstHeightTimelineEntryCopyWith<$Res> {
  __$EstimationFirstHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final _EstimationFirstHeightTimelineEntry _self;
  final $Res Function(_EstimationFirstHeightTimelineEntry) _then;

/// Create a copy of EstimationFirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? isAlreadyArrived = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_EstimationFirstHeightTimelineEntry(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isAlreadyArrived: freezed == isAlreadyArrived ? _self.isAlreadyArrived : isAlreadyArrived // ignore: cast_nullable_to_non_nullable
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
mixin _$EstimationMaxHeightTimelineEntry {

 DateTime? get dateTime; double? get value; bool? get isOver; QualitativeHeight? get qualitative; bool? get isObserving; Revise? get revise; String get telegramId; String? get headline; String get title; DateTime get publishedAt; DateTime? get revokedAt;
/// Create a copy of EstimationMaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimationMaxHeightTimelineEntryCopyWith<EstimationMaxHeightTimelineEntry> get copyWith => _$EstimationMaxHeightTimelineEntryCopyWithImpl<EstimationMaxHeightTimelineEntry>(this as EstimationMaxHeightTimelineEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimationMaxHeightTimelineEntry&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isObserving, isObserving) || other.isObserving == isObserving)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,value,isOver,qualitative,isObserving,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'EstimationMaxHeightTimelineEntry(dateTime: $dateTime, value: $value, isOver: $isOver, qualitative: $qualitative, isObserving: $isObserving, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class $EstimationMaxHeightTimelineEntryCopyWith<$Res>  {
  factory $EstimationMaxHeightTimelineEntryCopyWith(EstimationMaxHeightTimelineEntry value, $Res Function(EstimationMaxHeightTimelineEntry) _then) = _$EstimationMaxHeightTimelineEntryCopyWithImpl;
@useResult
$Res call({
 DateTime? dateTime, double? value, bool? isOver, QualitativeHeight? qualitative, bool? isObserving, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class _$EstimationMaxHeightTimelineEntryCopyWithImpl<$Res>
    implements $EstimationMaxHeightTimelineEntryCopyWith<$Res> {
  _$EstimationMaxHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final EstimationMaxHeightTimelineEntry _self;
  final $Res Function(EstimationMaxHeightTimelineEntry) _then;

/// Create a copy of EstimationMaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = freezed,Object? value = freezed,Object? isOver = freezed,Object? qualitative = freezed,Object? isObserving = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(EstimationMaxHeightTimelineEntry(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,isObserving: freezed == isObserving ? _self.isObserving : isObserving // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [EstimationMaxHeightTimelineEntry].
extension EstimationMaxHeightTimelineEntryPatterns on EstimationMaxHeightTimelineEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimationMaxHeightTimelineEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimationMaxHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimationMaxHeightTimelineEntry value)  $default,){
final _that = this;
switch (_that) {
case _EstimationMaxHeightTimelineEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimationMaxHeightTimelineEntry value)?  $default,){
final _that = this;
switch (_that) {
case _EstimationMaxHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? dateTime,  double? value,  bool? isOver,  QualitativeHeight? qualitative,  bool? isObserving,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimationMaxHeightTimelineEntry() when $default != null:
return $default(_that.dateTime,_that.value,_that.isOver,_that.qualitative,_that.isObserving,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? dateTime,  double? value,  bool? isOver,  QualitativeHeight? qualitative,  bool? isObserving,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)  $default,) {final _that = this;
switch (_that) {
case _EstimationMaxHeightTimelineEntry():
return $default(_that.dateTime,_that.value,_that.isOver,_that.qualitative,_that.isObserving,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? dateTime,  double? value,  bool? isOver,  QualitativeHeight? qualitative,  bool? isObserving,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,) {final _that = this;
switch (_that) {
case _EstimationMaxHeightTimelineEntry() when $default != null:
return $default(_that.dateTime,_that.value,_that.isOver,_that.qualitative,_that.isObserving,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
  return null;

}
}

}

/// @nodoc


class _EstimationMaxHeightTimelineEntry implements EstimationMaxHeightTimelineEntry {
  const _EstimationMaxHeightTimelineEntry({required this.dateTime, required this.value, required this.isOver, required this.qualitative, required this.isObserving, required this.revise, required this.telegramId, required this.headline, required this.title, required this.publishedAt, required this.revokedAt});
  

@override final  DateTime? dateTime;
@override final  double? value;
@override final  bool? isOver;
@override final  QualitativeHeight? qualitative;
@override final  bool? isObserving;
@override final  Revise? revise;
@override final  String telegramId;
@override final  String? headline;
@override final  String title;
@override final  DateTime publishedAt;
@override final  DateTime? revokedAt;

/// Create a copy of EstimationMaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimationMaxHeightTimelineEntryCopyWith<_EstimationMaxHeightTimelineEntry> get copyWith => __$EstimationMaxHeightTimelineEntryCopyWithImpl<_EstimationMaxHeightTimelineEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimationMaxHeightTimelineEntry&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isObserving, isObserving) || other.isObserving == isObserving)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,value,isOver,qualitative,isObserving,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'EstimationMaxHeightTimelineEntry(dateTime: $dateTime, value: $value, isOver: $isOver, qualitative: $qualitative, isObserving: $isObserving, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class _$EstimationMaxHeightTimelineEntryCopyWith<$Res> implements $EstimationMaxHeightTimelineEntryCopyWith<$Res> {
  factory _$EstimationMaxHeightTimelineEntryCopyWith(_EstimationMaxHeightTimelineEntry value, $Res Function(_EstimationMaxHeightTimelineEntry) _then) = __$EstimationMaxHeightTimelineEntryCopyWithImpl;
@override @useResult
$Res call({
 DateTime? dateTime, double? value, bool? isOver, QualitativeHeight? qualitative, bool? isObserving, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class __$EstimationMaxHeightTimelineEntryCopyWithImpl<$Res>
    implements _$EstimationMaxHeightTimelineEntryCopyWith<$Res> {
  __$EstimationMaxHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final _EstimationMaxHeightTimelineEntry _self;
  final $Res Function(_EstimationMaxHeightTimelineEntry) _then;

/// Create a copy of EstimationMaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = freezed,Object? value = freezed,Object? isOver = freezed,Object? qualitative = freezed,Object? isObserving = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_EstimationMaxHeightTimelineEntry(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,isObserving: freezed == isObserving ? _self.isObserving : isObserving // ignore: cast_nullable_to_non_nullable
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
