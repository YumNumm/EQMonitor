// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_comments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelegramComments {

@JsonKey(includeIfNull: false) String? get text;@JsonKey(includeIfNull: false) String? get free;@JsonKey(includeIfNull: false) String? get warning;@JsonKey(includeIfNull: false) String? get forecast;/// 固定付加文, var
@JsonKey(includeIfNull: false) String? get additional;@JsonKey(includeIfNull: false) String? get uri;
/// Create a copy of TelegramComments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramCommentsCopyWith<TelegramComments> get copyWith => _$TelegramCommentsCopyWithImpl<TelegramComments>(this as TelegramComments, _$identity);

  /// Serializes this TelegramComments to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramComments&&(identical(other.text, text) || other.text == text)&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.forecast, forecast) || other.forecast == forecast)&&(identical(other.additional, additional) || other.additional == additional)&&(identical(other.uri, uri) || other.uri == uri));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,free,warning,forecast,additional,uri);

@override
String toString() {
  return 'TelegramComments(text: $text, free: $free, warning: $warning, forecast: $forecast, additional: $additional, uri: $uri)';
}


}

/// @nodoc
abstract mixin class $TelegramCommentsCopyWith<$Res>  {
  factory $TelegramCommentsCopyWith(TelegramComments value, $Res Function(TelegramComments) _then) = _$TelegramCommentsCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? text,@JsonKey(includeIfNull: false) String? free,@JsonKey(includeIfNull: false) String? warning,@JsonKey(includeIfNull: false) String? forecast,@JsonKey(includeIfNull: false) String? additional,@JsonKey(includeIfNull: false) String? uri
});




}
/// @nodoc
class _$TelegramCommentsCopyWithImpl<$Res>
    implements $TelegramCommentsCopyWith<$Res> {
  _$TelegramCommentsCopyWithImpl(this._self, this._then);

  final TelegramComments _self;
  final $Res Function(TelegramComments) _then;

/// Create a copy of TelegramComments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,Object? free = freezed,Object? warning = freezed,Object? forecast = freezed,Object? additional = freezed,Object? uri = freezed,}) {
  return _then(_self.copyWith(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as String?,forecast: freezed == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as String?,additional: freezed == additional ? _self.additional : additional // ignore: cast_nullable_to_non_nullable
as String?,uri: freezed == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TelegramComments].
extension TelegramCommentsPatterns on TelegramComments {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramComments value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramComments() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramComments value)  $default,){
final _that = this;
switch (_that) {
case _TelegramComments():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramComments value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramComments() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  String? free, @JsonKey(includeIfNull: false)  String? warning, @JsonKey(includeIfNull: false)  String? forecast, @JsonKey(includeIfNull: false)  String? additional, @JsonKey(includeIfNull: false)  String? uri)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramComments() when $default != null:
return $default(_that.text,_that.free,_that.warning,_that.forecast,_that.additional,_that.uri);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  String? free, @JsonKey(includeIfNull: false)  String? warning, @JsonKey(includeIfNull: false)  String? forecast, @JsonKey(includeIfNull: false)  String? additional, @JsonKey(includeIfNull: false)  String? uri)  $default,) {final _that = this;
switch (_that) {
case _TelegramComments():
return $default(_that.text,_that.free,_that.warning,_that.forecast,_that.additional,_that.uri);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  String? free, @JsonKey(includeIfNull: false)  String? warning, @JsonKey(includeIfNull: false)  String? forecast, @JsonKey(includeIfNull: false)  String? additional, @JsonKey(includeIfNull: false)  String? uri)?  $default,) {final _that = this;
switch (_that) {
case _TelegramComments() when $default != null:
return $default(_that.text,_that.free,_that.warning,_that.forecast,_that.additional,_that.uri);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelegramComments implements TelegramComments {
  const _TelegramComments({@JsonKey(includeIfNull: false) this.text, @JsonKey(includeIfNull: false) this.free, @JsonKey(includeIfNull: false) this.warning, @JsonKey(includeIfNull: false) this.forecast, @JsonKey(includeIfNull: false) this.additional, @JsonKey(includeIfNull: false) this.uri});
  factory _TelegramComments.fromJson(Map<String, dynamic> json) => _$TelegramCommentsFromJson(json);

@override@JsonKey(includeIfNull: false) final  String? text;
@override@JsonKey(includeIfNull: false) final  String? free;
@override@JsonKey(includeIfNull: false) final  String? warning;
@override@JsonKey(includeIfNull: false) final  String? forecast;
/// 固定付加文, var
@override@JsonKey(includeIfNull: false) final  String? additional;
@override@JsonKey(includeIfNull: false) final  String? uri;

/// Create a copy of TelegramComments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramCommentsCopyWith<_TelegramComments> get copyWith => __$TelegramCommentsCopyWithImpl<_TelegramComments>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramCommentsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramComments&&(identical(other.text, text) || other.text == text)&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.forecast, forecast) || other.forecast == forecast)&&(identical(other.additional, additional) || other.additional == additional)&&(identical(other.uri, uri) || other.uri == uri));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,free,warning,forecast,additional,uri);

@override
String toString() {
  return 'TelegramComments(text: $text, free: $free, warning: $warning, forecast: $forecast, additional: $additional, uri: $uri)';
}


}

/// @nodoc
abstract mixin class _$TelegramCommentsCopyWith<$Res> implements $TelegramCommentsCopyWith<$Res> {
  factory _$TelegramCommentsCopyWith(_TelegramComments value, $Res Function(_TelegramComments) _then) = __$TelegramCommentsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? text,@JsonKey(includeIfNull: false) String? free,@JsonKey(includeIfNull: false) String? warning,@JsonKey(includeIfNull: false) String? forecast,@JsonKey(includeIfNull: false) String? additional,@JsonKey(includeIfNull: false) String? uri
});




}
/// @nodoc
class __$TelegramCommentsCopyWithImpl<$Res>
    implements _$TelegramCommentsCopyWith<$Res> {
  __$TelegramCommentsCopyWithImpl(this._self, this._then);

  final _TelegramComments _self;
  final $Res Function(_TelegramComments) _then;

/// Create a copy of TelegramComments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,Object? free = freezed,Object? warning = freezed,Object? forecast = freezed,Object? additional = freezed,Object? uri = freezed,}) {
  return _then(_TelegramComments(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as String?,forecast: freezed == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as String?,additional: freezed == additional ? _self.additional : additional // ignore: cast_nullable_to_non_nullable
as String?,uri: freezed == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
