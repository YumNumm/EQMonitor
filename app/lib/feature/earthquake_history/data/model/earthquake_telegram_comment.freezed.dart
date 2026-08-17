// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_telegram_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeTelegramComment {

 EarthquakeTelegramType get type; DateTime get reportedAt;/// 固定付加文
 String? get additional;/// 自由付加文
 String? get free;
/// Create a copy of EarthquakeTelegramComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeTelegramCommentCopyWith<EarthquakeTelegramComment> get copyWith => _$EarthquakeTelegramCommentCopyWithImpl<EarthquakeTelegramComment>(this as EarthquakeTelegramComment, _$identity);

  /// Serializes this EarthquakeTelegramComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeTelegramComment&&(identical(other.type, type) || other.type == type)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.additional, additional) || other.additional == additional)&&(identical(other.free, free) || other.free == free));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,reportedAt,additional,free);

@override
String toString() {
  return 'EarthquakeTelegramComment(type: $type, reportedAt: $reportedAt, additional: $additional, free: $free)';
}


}

/// @nodoc
abstract mixin class $EarthquakeTelegramCommentCopyWith<$Res>  {
  factory $EarthquakeTelegramCommentCopyWith(EarthquakeTelegramComment value, $Res Function(EarthquakeTelegramComment) _then) = _$EarthquakeTelegramCommentCopyWithImpl;
@useResult
$Res call({
 EarthquakeTelegramType type, DateTime reportedAt, String? additional, String? free
});




}
/// @nodoc
class _$EarthquakeTelegramCommentCopyWithImpl<$Res>
    implements $EarthquakeTelegramCommentCopyWith<$Res> {
  _$EarthquakeTelegramCommentCopyWithImpl(this._self, this._then);

  final EarthquakeTelegramComment _self;
  final $Res Function(EarthquakeTelegramComment) _then;

/// Create a copy of EarthquakeTelegramComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? reportedAt = null,Object? additional = freezed,Object? free = freezed,}) {
  return _then(EarthquakeTelegramComment(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramType,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,additional: freezed == additional ? _self.additional : additional // ignore: cast_nullable_to_non_nullable
as String?,free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeTelegramComment].
extension EarthquakeTelegramCommentPatterns on EarthquakeTelegramComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeTelegramComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeTelegramComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeTelegramComment value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeTelegramComment value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeTelegramType type,  DateTime reportedAt,  String? additional,  String? free)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeTelegramComment() when $default != null:
return $default(_that.type,_that.reportedAt,_that.additional,_that.free);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeTelegramType type,  DateTime reportedAt,  String? additional,  String? free)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramComment():
return $default(_that.type,_that.reportedAt,_that.additional,_that.free);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeTelegramType type,  DateTime reportedAt,  String? additional,  String? free)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramComment() when $default != null:
return $default(_that.type,_that.reportedAt,_that.additional,_that.free);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeTelegramComment implements EarthquakeTelegramComment {
  const _EarthquakeTelegramComment({required this.type, required this.reportedAt, required this.additional, required this.free});
  factory _EarthquakeTelegramComment.fromJson(Map<String, dynamic> json) => _$EarthquakeTelegramCommentFromJson(json);

@override final  EarthquakeTelegramType type;
@override final  DateTime reportedAt;
/// 固定付加文
@override final  String? additional;
/// 自由付加文
@override final  String? free;

/// Create a copy of EarthquakeTelegramComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeTelegramCommentCopyWith<_EarthquakeTelegramComment> get copyWith => __$EarthquakeTelegramCommentCopyWithImpl<_EarthquakeTelegramComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeTelegramCommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeTelegramComment&&(identical(other.type, type) || other.type == type)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.additional, additional) || other.additional == additional)&&(identical(other.free, free) || other.free == free));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,reportedAt,additional,free);

@override
String toString() {
  return 'EarthquakeTelegramComment(type: $type, reportedAt: $reportedAt, additional: $additional, free: $free)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeTelegramCommentCopyWith<$Res> implements $EarthquakeTelegramCommentCopyWith<$Res> {
  factory _$EarthquakeTelegramCommentCopyWith(_EarthquakeTelegramComment value, $Res Function(_EarthquakeTelegramComment) _then) = __$EarthquakeTelegramCommentCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeTelegramType type, DateTime reportedAt, String? additional, String? free
});




}
/// @nodoc
class __$EarthquakeTelegramCommentCopyWithImpl<$Res>
    implements _$EarthquakeTelegramCommentCopyWith<$Res> {
  __$EarthquakeTelegramCommentCopyWithImpl(this._self, this._then);

  final _EarthquakeTelegramComment _self;
  final $Res Function(_EarthquakeTelegramComment) _then;

/// Create a copy of EarthquakeTelegramComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? reportedAt = null,Object? additional = freezed,Object? free = freezed,}) {
  return _then(_EarthquakeTelegramComment(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramType,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,additional: freezed == additional ? _self.additional : additional // ignore: cast_nullable_to_non_nullable
as String?,free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
