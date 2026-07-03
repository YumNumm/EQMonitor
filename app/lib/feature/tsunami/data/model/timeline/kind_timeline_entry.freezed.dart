// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kind_timeline_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KindTimelineEntry {

 TsunamiWarningKind get kind; String get telegramId; String? get headline; String get title; DateTime get publishedAt; DateTime? get revokedAt;
/// Create a copy of KindTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KindTimelineEntryCopyWith<KindTimelineEntry> get copyWith => _$KindTimelineEntryCopyWithImpl<KindTimelineEntry>(this as KindTimelineEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KindTimelineEntry&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,kind,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'KindTimelineEntry(kind: $kind, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class $KindTimelineEntryCopyWith<$Res>  {
  factory $KindTimelineEntryCopyWith(KindTimelineEntry value, $Res Function(KindTimelineEntry) _then) = _$KindTimelineEntryCopyWithImpl;
@useResult
$Res call({
 TsunamiWarningKind kind, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class _$KindTimelineEntryCopyWithImpl<$Res>
    implements $KindTimelineEntryCopyWith<$Res> {
  _$KindTimelineEntryCopyWithImpl(this._self, this._then);

  final KindTimelineEntry _self;
  final $Res Function(KindTimelineEntry) _then;

/// Create a copy of KindTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [KindTimelineEntry].
extension KindTimelineEntryPatterns on KindTimelineEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KindTimelineEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KindTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KindTimelineEntry value)  $default,){
final _that = this;
switch (_that) {
case _KindTimelineEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KindTimelineEntry value)?  $default,){
final _that = this;
switch (_that) {
case _KindTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TsunamiWarningKind kind,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KindTimelineEntry() when $default != null:
return $default(_that.kind,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TsunamiWarningKind kind,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)  $default,) {final _that = this;
switch (_that) {
case _KindTimelineEntry():
return $default(_that.kind,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TsunamiWarningKind kind,  String telegramId,  String? headline,  String title,  DateTime publishedAt,  DateTime? revokedAt)?  $default,) {final _that = this;
switch (_that) {
case _KindTimelineEntry() when $default != null:
return $default(_that.kind,_that.telegramId,_that.headline,_that.title,_that.publishedAt,_that.revokedAt);case _:
  return null;

}
}

}

/// @nodoc


class _KindTimelineEntry implements KindTimelineEntry {
  const _KindTimelineEntry({required this.kind, required this.telegramId, required this.headline, required this.title, required this.publishedAt, required this.revokedAt});
  

@override final  TsunamiWarningKind kind;
@override final  String telegramId;
@override final  String? headline;
@override final  String title;
@override final  DateTime publishedAt;
@override final  DateTime? revokedAt;

/// Create a copy of KindTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KindTimelineEntryCopyWith<_KindTimelineEntry> get copyWith => __$KindTimelineEntryCopyWithImpl<_KindTimelineEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KindTimelineEntry&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt));
}


@override
int get hashCode => Object.hash(runtimeType,kind,telegramId,headline,title,publishedAt,revokedAt);

@override
String toString() {
  return 'KindTimelineEntry(kind: $kind, telegramId: $telegramId, headline: $headline, title: $title, publishedAt: $publishedAt, revokedAt: $revokedAt)';
}


}

/// @nodoc
abstract mixin class _$KindTimelineEntryCopyWith<$Res> implements $KindTimelineEntryCopyWith<$Res> {
  factory _$KindTimelineEntryCopyWith(_KindTimelineEntry value, $Res Function(_KindTimelineEntry) _then) = __$KindTimelineEntryCopyWithImpl;
@override @useResult
$Res call({
 TsunamiWarningKind kind, String telegramId, String? headline, String title, DateTime publishedAt, DateTime? revokedAt
});




}
/// @nodoc
class __$KindTimelineEntryCopyWithImpl<$Res>
    implements _$KindTimelineEntryCopyWith<$Res> {
  __$KindTimelineEntryCopyWithImpl(this._self, this._then);

  final _KindTimelineEntry _self;
  final $Res Function(_KindTimelineEntry) _then;

/// Create a copy of KindTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? telegramId = null,Object? headline = freezed,Object? title = null,Object? publishedAt = null,Object? revokedAt = freezed,}) {
  return _then(_KindTimelineEntry(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
