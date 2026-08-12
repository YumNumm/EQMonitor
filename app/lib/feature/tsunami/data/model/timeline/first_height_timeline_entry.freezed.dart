// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'first_height_timeline_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FirstHeightTimelineEntry {

 DateTime? get arrivalTime; FirstHeightCondition? get condition; Revise? get revise; String get telegramId; String? get headline; String get title; DateTime get publishedAt; DateTime? get revokedAt;
/// Create a copy of FirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FirstHeightTimelineEntryCopyWith<FirstHeightTimelineEntry> get copyWith => _$FirstHeightTimelineEntryCopyWithImpl<FirstHeightTimelineEntry>(this as FirstHeightTimelineEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FirstHeightTimelineEntry&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,condition,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'FirstHeightTimelineEntry(arrivalTime: $arrivalTime, condition: $condition, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class $FirstHeightTimelineEntryCopyWith<$Res>  {
  factory $FirstHeightTimelineEntryCopyWith(FirstHeightTimelineEntry value, $Res Function(FirstHeightTimelineEntry) _then) = _$FirstHeightTimelineEntryCopyWithImpl;
@useResult
$Res call({
 DateTime? arrivalTime, FirstHeightCondition? condition, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class _$FirstHeightTimelineEntryCopyWithImpl<$Res>
    implements $FirstHeightTimelineEntryCopyWith<$Res> {
  _$FirstHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final FirstHeightTimelineEntry _self;
  final $Res Function(FirstHeightTimelineEntry) _then;

/// Create a copy of FirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? condition = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(FirstHeightTimelineEntry(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as FirstHeightCondition?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FirstHeightTimelineEntry].
extension FirstHeightTimelineEntryPatterns on FirstHeightTimelineEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FirstHeightTimelineEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FirstHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FirstHeightTimelineEntry value)  $default,){
final _that = this;
switch (_that) {
case _FirstHeightTimelineEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FirstHeightTimelineEntry value)?  $default,){
final _that = this;
switch (_that) {
case _FirstHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? arrivalTime,  FirstHeightCondition? condition,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FirstHeightTimelineEntry() when $default != null:
return $default(_that.arrivalTime,_that.condition,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? arrivalTime,  FirstHeightCondition? condition,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)  $default,) {final _that = this;
switch (_that) {
case _FirstHeightTimelineEntry():
return $default(_that.arrivalTime,_that.condition,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? arrivalTime,  FirstHeightCondition? condition,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,) {final _that = this;
switch (_that) {
case _FirstHeightTimelineEntry() when $default != null:
return $default(_that.arrivalTime,_that.condition,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FirstHeightTimelineEntry implements FirstHeightTimelineEntry {
  const _FirstHeightTimelineEntry({required this.arrivalTime, required this.condition, required this.revise, required this.telegramId, required this.headline, required this.title, required this.publishedAt, required this.revokedAt});
  

@override final  DateTime? arrivalTime;
@override final  FirstHeightCondition? condition;
@override final  Revise? revise;
@override final  String telegramId;
@override final  String? headline;
@override final  String title;
@override final  DateTime publishedAt;
@override final  DateTime? revokedAt;

/// Create a copy of FirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirstHeightTimelineEntryCopyWith<_FirstHeightTimelineEntry> get copyWith => __$FirstHeightTimelineEntryCopyWithImpl<_FirstHeightTimelineEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirstHeightTimelineEntry&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,condition,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'FirstHeightTimelineEntry(arrivalTime: $arrivalTime, condition: $condition, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class _$FirstHeightTimelineEntryCopyWith<$Res> implements $FirstHeightTimelineEntryCopyWith<$Res> {
  factory _$FirstHeightTimelineEntryCopyWith(_FirstHeightTimelineEntry value, $Res Function(_FirstHeightTimelineEntry) _then) = __$FirstHeightTimelineEntryCopyWithImpl;
@override @useResult
$Res call({
 DateTime? arrivalTime, FirstHeightCondition? condition, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class __$FirstHeightTimelineEntryCopyWithImpl<$Res>
    implements _$FirstHeightTimelineEntryCopyWith<$Res> {
  __$FirstHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final _FirstHeightTimelineEntry _self;
  final $Res Function(_FirstHeightTimelineEntry) _then;

/// Create a copy of FirstHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? condition = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_FirstHeightTimelineEntry(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as FirstHeightCondition?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
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
