// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_telegram_comments_warning.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiTelegramCommentsWarning {

 String get text; List<String> get codes;
/// Create a copy of TsunamiTelegramCommentsWarning
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiTelegramCommentsWarningCopyWith<TsunamiTelegramCommentsWarning> get copyWith => _$TsunamiTelegramCommentsWarningCopyWithImpl<TsunamiTelegramCommentsWarning>(this as TsunamiTelegramCommentsWarning, _$identity);

  /// Serializes this TsunamiTelegramCommentsWarning to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiTelegramCommentsWarning&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.codes, codes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(codes));

@override
String toString() {
  return 'TsunamiTelegramCommentsWarning(text: $text, codes: $codes)';
}


}

/// @nodoc
abstract mixin class $TsunamiTelegramCommentsWarningCopyWith<$Res>  {
  factory $TsunamiTelegramCommentsWarningCopyWith(TsunamiTelegramCommentsWarning value, $Res Function(TsunamiTelegramCommentsWarning) _then) = _$TsunamiTelegramCommentsWarningCopyWithImpl;
@useResult
$Res call({
 String text, List<String> codes
});




}
/// @nodoc
class _$TsunamiTelegramCommentsWarningCopyWithImpl<$Res>
    implements $TsunamiTelegramCommentsWarningCopyWith<$Res> {
  _$TsunamiTelegramCommentsWarningCopyWithImpl(this._self, this._then);

  final TsunamiTelegramCommentsWarning _self;
  final $Res Function(TsunamiTelegramCommentsWarning) _then;

/// Create a copy of TsunamiTelegramCommentsWarning
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? codes = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,codes: null == codes ? _self.codes : codes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiTelegramCommentsWarning].
extension TsunamiTelegramCommentsWarningPatterns on TsunamiTelegramCommentsWarning {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiTelegramCommentsWarning value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiTelegramCommentsWarning() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiTelegramCommentsWarning value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramCommentsWarning():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiTelegramCommentsWarning value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramCommentsWarning() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  List<String> codes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiTelegramCommentsWarning() when $default != null:
return $default(_that.text,_that.codes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  List<String> codes)  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramCommentsWarning():
return $default(_that.text,_that.codes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  List<String> codes)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramCommentsWarning() when $default != null:
return $default(_that.text,_that.codes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiTelegramCommentsWarning implements TsunamiTelegramCommentsWarning {
  const _TsunamiTelegramCommentsWarning({required this.text, required final  List<String> codes}): _codes = codes;
  factory _TsunamiTelegramCommentsWarning.fromJson(Map<String, dynamic> json) => _$TsunamiTelegramCommentsWarningFromJson(json);

@override final  String text;
 final  List<String> _codes;
@override List<String> get codes {
  if (_codes is EqualUnmodifiableListView) return _codes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_codes);
}


/// Create a copy of TsunamiTelegramCommentsWarning
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiTelegramCommentsWarningCopyWith<_TsunamiTelegramCommentsWarning> get copyWith => __$TsunamiTelegramCommentsWarningCopyWithImpl<_TsunamiTelegramCommentsWarning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiTelegramCommentsWarningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiTelegramCommentsWarning&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._codes, _codes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_codes));

@override
String toString() {
  return 'TsunamiTelegramCommentsWarning(text: $text, codes: $codes)';
}


}

/// @nodoc
abstract mixin class _$TsunamiTelegramCommentsWarningCopyWith<$Res> implements $TsunamiTelegramCommentsWarningCopyWith<$Res> {
  factory _$TsunamiTelegramCommentsWarningCopyWith(_TsunamiTelegramCommentsWarning value, $Res Function(_TsunamiTelegramCommentsWarning) _then) = __$TsunamiTelegramCommentsWarningCopyWithImpl;
@override @useResult
$Res call({
 String text, List<String> codes
});




}
/// @nodoc
class __$TsunamiTelegramCommentsWarningCopyWithImpl<$Res>
    implements _$TsunamiTelegramCommentsWarningCopyWith<$Res> {
  __$TsunamiTelegramCommentsWarningCopyWithImpl(this._self, this._then);

  final _TsunamiTelegramCommentsWarning _self;
  final $Res Function(_TsunamiTelegramCommentsWarning) _then;

/// Create a copy of TsunamiTelegramCommentsWarning
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? codes = null,}) {
  return _then(_TsunamiTelegramCommentsWarning(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,codes: null == codes ? _self._codes : codes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
