// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_explanation_telegram_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeExplanationTelegramBody {

/// const: "EARTHQUAKE_EXPLANATION"
 String get type; String get text;
/// Create a copy of EarthquakeExplanationTelegramBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeExplanationTelegramBodyCopyWith<EarthquakeExplanationTelegramBody> get copyWith => _$EarthquakeExplanationTelegramBodyCopyWithImpl<EarthquakeExplanationTelegramBody>(this as EarthquakeExplanationTelegramBody, _$identity);

  /// Serializes this EarthquakeExplanationTelegramBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeExplanationTelegramBody&&(identical(other.type, type) || other.type == type)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,text);

@override
String toString() {
  return 'EarthquakeExplanationTelegramBody(type: $type, text: $text)';
}


}

/// @nodoc
abstract mixin class $EarthquakeExplanationTelegramBodyCopyWith<$Res>  {
  factory $EarthquakeExplanationTelegramBodyCopyWith(EarthquakeExplanationTelegramBody value, $Res Function(EarthquakeExplanationTelegramBody) _then) = _$EarthquakeExplanationTelegramBodyCopyWithImpl;
@useResult
$Res call({
 String type, String text
});




}
/// @nodoc
class _$EarthquakeExplanationTelegramBodyCopyWithImpl<$Res>
    implements $EarthquakeExplanationTelegramBodyCopyWith<$Res> {
  _$EarthquakeExplanationTelegramBodyCopyWithImpl(this._self, this._then);

  final EarthquakeExplanationTelegramBody _self;
  final $Res Function(EarthquakeExplanationTelegramBody) _then;

/// Create a copy of EarthquakeExplanationTelegramBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? text = null,}) {
  return _then(EarthquakeExplanationTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeExplanationTelegramBody].
extension EarthquakeExplanationTelegramBodyPatterns on EarthquakeExplanationTelegramBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeExplanationTelegramBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeExplanationTelegramBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeExplanationTelegramBody value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeExplanationTelegramBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeExplanationTelegramBody value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeExplanationTelegramBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeExplanationTelegramBody() when $default != null:
return $default(_that.type,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String text)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeExplanationTelegramBody():
return $default(_that.type,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String text)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeExplanationTelegramBody() when $default != null:
return $default(_that.type,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeExplanationTelegramBody implements EarthquakeExplanationTelegramBody {
  const _EarthquakeExplanationTelegramBody({required this.type, required this.text});
  factory _EarthquakeExplanationTelegramBody.fromJson(Map<String, dynamic> json) => _$EarthquakeExplanationTelegramBodyFromJson(json);

/// const: "EARTHQUAKE_EXPLANATION"
@override final  String type;
@override final  String text;

/// Create a copy of EarthquakeExplanationTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeExplanationTelegramBodyCopyWith<_EarthquakeExplanationTelegramBody> get copyWith => __$EarthquakeExplanationTelegramBodyCopyWithImpl<_EarthquakeExplanationTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeExplanationTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeExplanationTelegramBody&&(identical(other.type, type) || other.type == type)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,text);

@override
String toString() {
  return 'EarthquakeExplanationTelegramBody(type: $type, text: $text)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeExplanationTelegramBodyCopyWith<$Res> implements $EarthquakeExplanationTelegramBodyCopyWith<$Res> {
  factory _$EarthquakeExplanationTelegramBodyCopyWith(_EarthquakeExplanationTelegramBody value, $Res Function(_EarthquakeExplanationTelegramBody) _then) = __$EarthquakeExplanationTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type, String text
});




}
/// @nodoc
class __$EarthquakeExplanationTelegramBodyCopyWithImpl<$Res>
    implements _$EarthquakeExplanationTelegramBodyCopyWith<$Res> {
  __$EarthquakeExplanationTelegramBodyCopyWithImpl(this._self, this._then);

  final _EarthquakeExplanationTelegramBody _self;
  final $Res Function(_EarthquakeExplanationTelegramBody) _then;

/// Create a copy of EarthquakeExplanationTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? text = null,}) {
  return _then(_EarthquakeExplanationTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
