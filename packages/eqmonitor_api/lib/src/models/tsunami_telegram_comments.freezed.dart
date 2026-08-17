// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_telegram_comments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiTelegramComments {

@JsonKey(includeIfNull: false) String? get free;@JsonKey(includeIfNull: false) TsunamiTelegramCommentsWarning? get warning;
/// Create a copy of TsunamiTelegramComments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiTelegramCommentsCopyWith<TsunamiTelegramComments> get copyWith => _$TsunamiTelegramCommentsCopyWithImpl<TsunamiTelegramComments>(this as TsunamiTelegramComments, _$identity);

  /// Serializes this TsunamiTelegramComments to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiTelegramComments&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free,warning);

@override
String toString() {
  return 'TsunamiTelegramComments(free: $free, warning: $warning)';
}


}

/// @nodoc
abstract mixin class $TsunamiTelegramCommentsCopyWith<$Res>  {
  factory $TsunamiTelegramCommentsCopyWith(TsunamiTelegramComments value, $Res Function(TsunamiTelegramComments) _then) = _$TsunamiTelegramCommentsCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? free,@JsonKey(includeIfNull: false) TsunamiTelegramCommentsWarning? warning
});


$TsunamiTelegramCommentsWarningCopyWith<$Res>? get warning;

}
/// @nodoc
class _$TsunamiTelegramCommentsCopyWithImpl<$Res>
    implements $TsunamiTelegramCommentsCopyWith<$Res> {
  _$TsunamiTelegramCommentsCopyWithImpl(this._self, this._then);

  final TsunamiTelegramComments _self;
  final $Res Function(TsunamiTelegramComments) _then;

/// Create a copy of TsunamiTelegramComments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? free = freezed,Object? warning = freezed,}) {
  return _then(TsunamiTelegramComments(
free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as TsunamiTelegramCommentsWarning?,
  ));
}
/// Create a copy of TsunamiTelegramComments
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiTelegramCommentsWarningCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $TsunamiTelegramCommentsWarningCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiTelegramComments].
extension TsunamiTelegramCommentsPatterns on TsunamiTelegramComments {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiTelegramComments value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiTelegramComments() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiTelegramComments value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramComments():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiTelegramComments value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramComments() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? free, @JsonKey(includeIfNull: false)  TsunamiTelegramCommentsWarning? warning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiTelegramComments() when $default != null:
return $default(_that.free,_that.warning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? free, @JsonKey(includeIfNull: false)  TsunamiTelegramCommentsWarning? warning)  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramComments():
return $default(_that.free,_that.warning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? free, @JsonKey(includeIfNull: false)  TsunamiTelegramCommentsWarning? warning)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramComments() when $default != null:
return $default(_that.free,_that.warning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiTelegramComments implements TsunamiTelegramComments {
  const _TsunamiTelegramComments({@JsonKey(includeIfNull: false) this.free, @JsonKey(includeIfNull: false) this.warning});
  factory _TsunamiTelegramComments.fromJson(Map<String, dynamic> json) => _$TsunamiTelegramCommentsFromJson(json);

@override@JsonKey(includeIfNull: false) final  String? free;
@override@JsonKey(includeIfNull: false) final  TsunamiTelegramCommentsWarning? warning;

/// Create a copy of TsunamiTelegramComments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiTelegramCommentsCopyWith<_TsunamiTelegramComments> get copyWith => __$TsunamiTelegramCommentsCopyWithImpl<_TsunamiTelegramComments>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiTelegramCommentsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiTelegramComments&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free,warning);

@override
String toString() {
  return 'TsunamiTelegramComments(free: $free, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$TsunamiTelegramCommentsCopyWith<$Res> implements $TsunamiTelegramCommentsCopyWith<$Res> {
  factory _$TsunamiTelegramCommentsCopyWith(_TsunamiTelegramComments value, $Res Function(_TsunamiTelegramComments) _then) = __$TsunamiTelegramCommentsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? free,@JsonKey(includeIfNull: false) TsunamiTelegramCommentsWarning? warning
});


@override $TsunamiTelegramCommentsWarningCopyWith<$Res>? get warning;

}
/// @nodoc
class __$TsunamiTelegramCommentsCopyWithImpl<$Res>
    implements _$TsunamiTelegramCommentsCopyWith<$Res> {
  __$TsunamiTelegramCommentsCopyWithImpl(this._self, this._then);

  final _TsunamiTelegramComments _self;
  final $Res Function(_TsunamiTelegramComments) _then;

/// Create a copy of TsunamiTelegramComments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? free = freezed,Object? warning = freezed,}) {
  return _then(_TsunamiTelegramComments(
free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as TsunamiTelegramCommentsWarning?,
  ));
}

/// Create a copy of TsunamiTelegramComments
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiTelegramCommentsWarningCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $TsunamiTelegramCommentsWarningCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}

// dart format on
