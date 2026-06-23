// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_telegram_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiTelegramMeta {

 String get telegramId; int? get serialNo; String get title; String? get headline; DateTime get publishedAt; DateTime get reportedAt; DateTime? get targetedAt; DateTime? get revokedAt; String get infoKind;
/// Create a copy of TsunamiTelegramMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiTelegramMetaCopyWith<TsunamiTelegramMeta> get copyWith => _$TsunamiTelegramMetaCopyWithImpl<TsunamiTelegramMeta>(this as TsunamiTelegramMeta, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiTelegramMeta&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.title, title) || other.title == title)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.targetedAt, targetedAt) || other.targetedAt == targetedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind));
}


@override
int get hashCode => Object.hash(runtimeType,telegramId,serialNo,title,headline,publishedAt,reportedAt,targetedAt,revokedAt,infoKind);

@override
String toString() {
  return 'TsunamiTelegramMeta(telegramId: $telegramId, serialNo: $serialNo, title: $title, headline: $headline, publishedAt: $publishedAt, reportedAt: $reportedAt, targetedAt: $targetedAt, revokedAt: $revokedAt, infoKind: $infoKind)';
}


}

/// @nodoc
abstract mixin class $TsunamiTelegramMetaCopyWith<$Res>  {
  factory $TsunamiTelegramMetaCopyWith(TsunamiTelegramMeta value, $Res Function(TsunamiTelegramMeta) _then) = _$TsunamiTelegramMetaCopyWithImpl;
@useResult
$Res call({
 String telegramId, int? serialNo, String title, String? headline, DateTime publishedAt, DateTime reportedAt, DateTime? targetedAt, DateTime? revokedAt, String infoKind
});




}
/// @nodoc
class _$TsunamiTelegramMetaCopyWithImpl<$Res>
    implements $TsunamiTelegramMetaCopyWith<$Res> {
  _$TsunamiTelegramMetaCopyWithImpl(this._self, this._then);

  final TsunamiTelegramMeta _self;
  final $Res Function(TsunamiTelegramMeta) _then;

/// Create a copy of TsunamiTelegramMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? telegramId = null,Object? serialNo = freezed,Object? title = null,Object? headline = freezed,Object? publishedAt = null,Object? reportedAt = null,Object? targetedAt = freezed,Object? revokedAt = freezed,Object? infoKind = null,}) {
  return _then(_self.copyWith(
telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,targetedAt: freezed == targetedAt ? _self.targetedAt : targetedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiTelegramMeta].
extension TsunamiTelegramMetaPatterns on TsunamiTelegramMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiTelegramMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiTelegramMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiTelegramMeta value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiTelegramMeta value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String telegramId,  int? serialNo,  String title,  String? headline,  DateTime publishedAt,  DateTime reportedAt,  DateTime? targetedAt,  DateTime? revokedAt,  String infoKind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiTelegramMeta() when $default != null:
return $default(_that.telegramId,_that.serialNo,_that.title,_that.headline,_that.publishedAt,_that.reportedAt,_that.targetedAt,_that.revokedAt,_that.infoKind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String telegramId,  int? serialNo,  String title,  String? headline,  DateTime publishedAt,  DateTime reportedAt,  DateTime? targetedAt,  DateTime? revokedAt,  String infoKind)  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramMeta():
return $default(_that.telegramId,_that.serialNo,_that.title,_that.headline,_that.publishedAt,_that.reportedAt,_that.targetedAt,_that.revokedAt,_that.infoKind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String telegramId,  int? serialNo,  String title,  String? headline,  DateTime publishedAt,  DateTime reportedAt,  DateTime? targetedAt,  DateTime? revokedAt,  String infoKind)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramMeta() when $default != null:
return $default(_that.telegramId,_that.serialNo,_that.title,_that.headline,_that.publishedAt,_that.reportedAt,_that.targetedAt,_that.revokedAt,_that.infoKind);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiTelegramMeta implements TsunamiTelegramMeta {
  const _TsunamiTelegramMeta({required this.telegramId, required this.serialNo, required this.title, required this.headline, required this.publishedAt, required this.reportedAt, required this.targetedAt, required this.revokedAt, required this.infoKind});
  

@override final  String telegramId;
@override final  int? serialNo;
@override final  String title;
@override final  String? headline;
@override final  DateTime publishedAt;
@override final  DateTime reportedAt;
@override final  DateTime? targetedAt;
@override final  DateTime? revokedAt;
@override final  String infoKind;

/// Create a copy of TsunamiTelegramMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiTelegramMetaCopyWith<_TsunamiTelegramMeta> get copyWith => __$TsunamiTelegramMetaCopyWithImpl<_TsunamiTelegramMeta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiTelegramMeta&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.title, title) || other.title == title)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.targetedAt, targetedAt) || other.targetedAt == targetedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind));
}


@override
int get hashCode => Object.hash(runtimeType,telegramId,serialNo,title,headline,publishedAt,reportedAt,targetedAt,revokedAt,infoKind);

@override
String toString() {
  return 'TsunamiTelegramMeta(telegramId: $telegramId, serialNo: $serialNo, title: $title, headline: $headline, publishedAt: $publishedAt, reportedAt: $reportedAt, targetedAt: $targetedAt, revokedAt: $revokedAt, infoKind: $infoKind)';
}


}

/// @nodoc
abstract mixin class _$TsunamiTelegramMetaCopyWith<$Res> implements $TsunamiTelegramMetaCopyWith<$Res> {
  factory _$TsunamiTelegramMetaCopyWith(_TsunamiTelegramMeta value, $Res Function(_TsunamiTelegramMeta) _then) = __$TsunamiTelegramMetaCopyWithImpl;
@override @useResult
$Res call({
 String telegramId, int? serialNo, String title, String? headline, DateTime publishedAt, DateTime reportedAt, DateTime? targetedAt, DateTime? revokedAt, String infoKind
});




}
/// @nodoc
class __$TsunamiTelegramMetaCopyWithImpl<$Res>
    implements _$TsunamiTelegramMetaCopyWith<$Res> {
  __$TsunamiTelegramMetaCopyWithImpl(this._self, this._then);

  final _TsunamiTelegramMeta _self;
  final $Res Function(_TsunamiTelegramMeta) _then;

/// Create a copy of TsunamiTelegramMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? telegramId = null,Object? serialNo = freezed,Object? title = null,Object? headline = freezed,Object? publishedAt = null,Object? reportedAt = null,Object? targetedAt = freezed,Object? revokedAt = freezed,Object? infoKind = null,}) {
  return _then(_TsunamiTelegramMeta(
telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,targetedAt: freezed == targetedAt ? _self.targetedAt : targetedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
