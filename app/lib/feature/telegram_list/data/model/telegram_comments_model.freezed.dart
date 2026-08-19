// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_comments_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TelegramCommentsModel {

 String? get text; String? get free; String? get warning; String? get forecast; String? get additional; String? get uri;
/// Create a copy of TelegramCommentsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramCommentsModelCopyWith<TelegramCommentsModel> get copyWith => _$TelegramCommentsModelCopyWithImpl<TelegramCommentsModel>(this as TelegramCommentsModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramCommentsModel&&(identical(other.text, text) || other.text == text)&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.forecast, forecast) || other.forecast == forecast)&&(identical(other.additional, additional) || other.additional == additional)&&(identical(other.uri, uri) || other.uri == uri));
}


@override
int get hashCode => Object.hash(runtimeType,text,free,warning,forecast,additional,uri);

@override
String toString() {
  return 'TelegramCommentsModel(text: $text, free: $free, warning: $warning, forecast: $forecast, additional: $additional, uri: $uri)';
}


}

/// @nodoc
abstract mixin class $TelegramCommentsModelCopyWith<$Res>  {
  factory $TelegramCommentsModelCopyWith(TelegramCommentsModel value, $Res Function(TelegramCommentsModel) _then) = _$TelegramCommentsModelCopyWithImpl;
@useResult
$Res call({
 String? text, String? free, String? warning, String? forecast, String? additional, String? uri
});




}
/// @nodoc
class _$TelegramCommentsModelCopyWithImpl<$Res>
    implements $TelegramCommentsModelCopyWith<$Res> {
  _$TelegramCommentsModelCopyWithImpl(this._self, this._then);

  final TelegramCommentsModel _self;
  final $Res Function(TelegramCommentsModel) _then;

/// Create a copy of TelegramCommentsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,Object? free = freezed,Object? warning = freezed,Object? forecast = freezed,Object? additional = freezed,Object? uri = freezed,}) {
  return _then(TelegramCommentsModel(
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


/// Adds pattern-matching-related methods to [TelegramCommentsModel].
extension TelegramCommentsModelPatterns on TelegramCommentsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramCommentsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramCommentsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramCommentsModel value)  $default,){
final _that = this;
switch (_that) {
case _TelegramCommentsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramCommentsModel value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramCommentsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? text,  String? free,  String? warning,  String? forecast,  String? additional,  String? uri)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramCommentsModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? text,  String? free,  String? warning,  String? forecast,  String? additional,  String? uri)  $default,) {final _that = this;
switch (_that) {
case _TelegramCommentsModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? text,  String? free,  String? warning,  String? forecast,  String? additional,  String? uri)?  $default,) {final _that = this;
switch (_that) {
case _TelegramCommentsModel() when $default != null:
return $default(_that.text,_that.free,_that.warning,_that.forecast,_that.additional,_that.uri);case _:
  return null;

}
}

}

/// @nodoc


class _TelegramCommentsModel implements TelegramCommentsModel {
  const _TelegramCommentsModel({this.text, this.free, this.warning, this.forecast, this.additional, this.uri});
  

@override final  String? text;
@override final  String? free;
@override final  String? warning;
@override final  String? forecast;
@override final  String? additional;
@override final  String? uri;

/// Create a copy of TelegramCommentsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramCommentsModelCopyWith<_TelegramCommentsModel> get copyWith => __$TelegramCommentsModelCopyWithImpl<_TelegramCommentsModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramCommentsModel&&(identical(other.text, text) || other.text == text)&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.forecast, forecast) || other.forecast == forecast)&&(identical(other.additional, additional) || other.additional == additional)&&(identical(other.uri, uri) || other.uri == uri));
}


@override
int get hashCode => Object.hash(runtimeType,text,free,warning,forecast,additional,uri);

@override
String toString() {
  return 'TelegramCommentsModel(text: $text, free: $free, warning: $warning, forecast: $forecast, additional: $additional, uri: $uri)';
}


}

/// @nodoc
abstract mixin class _$TelegramCommentsModelCopyWith<$Res> implements $TelegramCommentsModelCopyWith<$Res> {
  factory _$TelegramCommentsModelCopyWith(_TelegramCommentsModel value, $Res Function(_TelegramCommentsModel) _then) = __$TelegramCommentsModelCopyWithImpl;
@override @useResult
$Res call({
 String? text, String? free, String? warning, String? forecast, String? additional, String? uri
});




}
/// @nodoc
class __$TelegramCommentsModelCopyWithImpl<$Res>
    implements _$TelegramCommentsModelCopyWith<$Res> {
  __$TelegramCommentsModelCopyWithImpl(this._self, this._then);

  final _TelegramCommentsModel _self;
  final $Res Function(_TelegramCommentsModel) _then;

/// Create a copy of TelegramCommentsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,Object? free = freezed,Object? warning = freezed,Object? forecast = freezed,Object? additional = freezed,Object? uri = freezed,}) {
  return _then(_TelegramCommentsModel(
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
