// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_telegram.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeTelegram {

 Telegram get telegram;@JsonKey(includeIfNull: true) TelegramComments? get comments;
/// Create a copy of EarthquakeTelegram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeTelegramCopyWith<EarthquakeTelegram> get copyWith => _$EarthquakeTelegramCopyWithImpl<EarthquakeTelegram>(this as EarthquakeTelegram, _$identity);

  /// Serializes this EarthquakeTelegram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeTelegram&&(identical(other.telegram, telegram) || other.telegram == telegram)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegram,comments);

@override
String toString() {
  return 'EarthquakeTelegram(telegram: $telegram, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $EarthquakeTelegramCopyWith<$Res>  {
  factory $EarthquakeTelegramCopyWith(EarthquakeTelegram value, $Res Function(EarthquakeTelegram) _then) = _$EarthquakeTelegramCopyWithImpl;
@useResult
$Res call({
 Telegram telegram,@JsonKey(includeIfNull: true) TelegramComments? comments
});


$TelegramCopyWith<$Res> get telegram;$TelegramCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$EarthquakeTelegramCopyWithImpl<$Res>
    implements $EarthquakeTelegramCopyWith<$Res> {
  _$EarthquakeTelegramCopyWithImpl(this._self, this._then);

  final EarthquakeTelegram _self;
  final $Res Function(EarthquakeTelegram) _then;

/// Create a copy of EarthquakeTelegram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? telegram = null,Object? comments = freezed,}) {
  return _then(EarthquakeTelegram(
telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as Telegram,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TelegramComments?,
  ));
}
/// Create a copy of EarthquakeTelegram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramCopyWith<$Res> get telegram {
  
  return $TelegramCopyWith<$Res>(_self.telegram, (value) {
    return _then(_self.copyWith(telegram: value));
  });
}/// Create a copy of EarthquakeTelegram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TelegramCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeTelegram].
extension EarthquakeTelegramPatterns on EarthquakeTelegram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeTelegram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeTelegram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeTelegram value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeTelegram value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Telegram telegram, @JsonKey(includeIfNull: true)  TelegramComments? comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeTelegram() when $default != null:
return $default(_that.telegram,_that.comments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Telegram telegram, @JsonKey(includeIfNull: true)  TelegramComments? comments)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegram():
return $default(_that.telegram,_that.comments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Telegram telegram, @JsonKey(includeIfNull: true)  TelegramComments? comments)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegram() when $default != null:
return $default(_that.telegram,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeTelegram implements EarthquakeTelegram {
  const _EarthquakeTelegram({required this.telegram, @JsonKey(includeIfNull: true) required this.comments});
  factory _EarthquakeTelegram.fromJson(Map<String, dynamic> json) => _$EarthquakeTelegramFromJson(json);

@override final  Telegram telegram;
@override@JsonKey(includeIfNull: true) final  TelegramComments? comments;

/// Create a copy of EarthquakeTelegram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeTelegramCopyWith<_EarthquakeTelegram> get copyWith => __$EarthquakeTelegramCopyWithImpl<_EarthquakeTelegram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeTelegramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeTelegram&&(identical(other.telegram, telegram) || other.telegram == telegram)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegram,comments);

@override
String toString() {
  return 'EarthquakeTelegram(telegram: $telegram, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeTelegramCopyWith<$Res> implements $EarthquakeTelegramCopyWith<$Res> {
  factory _$EarthquakeTelegramCopyWith(_EarthquakeTelegram value, $Res Function(_EarthquakeTelegram) _then) = __$EarthquakeTelegramCopyWithImpl;
@override @useResult
$Res call({
 Telegram telegram,@JsonKey(includeIfNull: true) TelegramComments? comments
});


@override $TelegramCopyWith<$Res> get telegram;@override $TelegramCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class __$EarthquakeTelegramCopyWithImpl<$Res>
    implements _$EarthquakeTelegramCopyWith<$Res> {
  __$EarthquakeTelegramCopyWithImpl(this._self, this._then);

  final _EarthquakeTelegram _self;
  final $Res Function(_EarthquakeTelegram) _then;

/// Create a copy of EarthquakeTelegram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? telegram = null,Object? comments = freezed,}) {
  return _then(_EarthquakeTelegram(
telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as Telegram,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TelegramComments?,
  ));
}

/// Create a copy of EarthquakeTelegram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramCopyWith<$Res> get telegram {
  
  return $TelegramCopyWith<$Res>(_self.telegram, (value) {
    return _then(_self.copyWith(telegram: value));
  });
}/// Create a copy of EarthquakeTelegram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TelegramCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

// dart format on
