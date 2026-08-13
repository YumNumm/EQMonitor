// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'max_height_timeline_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MaxHeightTimelineEntry {

 double? get value; bool? get isOver; QualitativeHeight? get qualitative; bool? get isImportant; Revise? get revise; String get telegramId; String? get headline; String get title; DateTime get publishedAt; DateTime? get revokedAt;
/// Create a copy of MaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaxHeightTimelineEntryCopyWith<MaxHeightTimelineEntry> get copyWith => _$MaxHeightTimelineEntryCopyWithImpl<MaxHeightTimelineEntry>(this as MaxHeightTimelineEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaxHeightTimelineEntry&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,value,isOver,qualitative,isImportant,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'MaxHeightTimelineEntry(value: $value, isOver: $isOver, qualitative: $qualitative, isImportant: $isImportant, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class $MaxHeightTimelineEntryCopyWith<$Res>  {
  factory $MaxHeightTimelineEntryCopyWith(MaxHeightTimelineEntry value, $Res Function(MaxHeightTimelineEntry) _then) = _$MaxHeightTimelineEntryCopyWithImpl;
@useResult
$Res call({
 double? value, bool? isOver, QualitativeHeight? qualitative, bool? isImportant, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class _$MaxHeightTimelineEntryCopyWithImpl<$Res>
    implements $MaxHeightTimelineEntryCopyWith<$Res> {
  _$MaxHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final MaxHeightTimelineEntry _self;
  final $Res Function(MaxHeightTimelineEntry) _then;

/// Create a copy of MaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? isOver = freezed,Object? qualitative = freezed,Object? isImportant = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(MaxHeightTimelineEntry(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,isImportant: freezed == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [MaxHeightTimelineEntry].
extension MaxHeightTimelineEntryPatterns on MaxHeightTimelineEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaxHeightTimelineEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaxHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaxHeightTimelineEntry value)  $default,){
final _that = this;
switch (_that) {
case _MaxHeightTimelineEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaxHeightTimelineEntry value)?  $default,){
final _that = this;
switch (_that) {
case _MaxHeightTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? value,  bool? isOver,  QualitativeHeight? qualitative,  bool? isImportant,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaxHeightTimelineEntry() when $default != null:
return $default(_that.value,_that.isOver,_that.qualitative,_that.isImportant,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? value,  bool? isOver,  QualitativeHeight? qualitative,  bool? isImportant,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)  $default,) {final _that = this;
switch (_that) {
case _MaxHeightTimelineEntry():
return $default(_that.value,_that.isOver,_that.qualitative,_that.isImportant,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? value,  bool? isOver,  QualitativeHeight? qualitative,  bool? isImportant,  Revise? revise,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,) {final _that = this;
switch (_that) {
case _MaxHeightTimelineEntry() when $default != null:
return $default(_that.value,_that.isOver,_that.qualitative,_that.isImportant,_that.revise,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
  return null;

}
}

}

/// @nodoc


class _MaxHeightTimelineEntry implements MaxHeightTimelineEntry {
  const _MaxHeightTimelineEntry({required this.value, required this.isOver, required this.qualitative, required this.isImportant, required this.revise, required this.telegramId, required this.headline, required this.title, required this.publishedAt, required this.revokedAt});
  

@override final  double? value;
@override final  bool? isOver;
@override final  QualitativeHeight? qualitative;
@override final  bool? isImportant;
@override final  Revise? revise;
@override final  String telegramId;
@override final  String? headline;
@override final  String title;
@override final  DateTime publishedAt;
@override final  DateTime? revokedAt;

/// Create a copy of MaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaxHeightTimelineEntryCopyWith<_MaxHeightTimelineEntry> get copyWith => __$MaxHeightTimelineEntryCopyWithImpl<_MaxHeightTimelineEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaxHeightTimelineEntry&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.revise, revise) || other.revise == revise)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,value,isOver,qualitative,isImportant,revise,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'MaxHeightTimelineEntry(value: $value, isOver: $isOver, qualitative: $qualitative, isImportant: $isImportant, revise: $revise, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class _$MaxHeightTimelineEntryCopyWith<$Res> implements $MaxHeightTimelineEntryCopyWith<$Res> {
  factory _$MaxHeightTimelineEntryCopyWith(_MaxHeightTimelineEntry value, $Res Function(_MaxHeightTimelineEntry) _then) = __$MaxHeightTimelineEntryCopyWithImpl;
@override @useResult
$Res call({
 double? value, bool? isOver, QualitativeHeight? qualitative, bool? isImportant, Revise? revise, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class __$MaxHeightTimelineEntryCopyWithImpl<$Res>
    implements _$MaxHeightTimelineEntryCopyWith<$Res> {
  __$MaxHeightTimelineEntryCopyWithImpl(this._self, this._then);

  final _MaxHeightTimelineEntry _self;
  final $Res Function(_MaxHeightTimelineEntry) _then;

/// Create a copy of MaxHeightTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? isOver = freezed,Object? qualitative = freezed,Object? isImportant = freezed,Object? revise = freezed,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_MaxHeightTimelineEntry(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,isImportant: freezed == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
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
