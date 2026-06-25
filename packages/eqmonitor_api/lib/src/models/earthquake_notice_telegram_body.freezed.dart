// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_notice_telegram_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeNoticeTelegramBody {

 String get type;
/// Create a copy of EarthquakeNoticeTelegramBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeNoticeTelegramBodyCopyWith<EarthquakeNoticeTelegramBody> get copyWith => _$EarthquakeNoticeTelegramBodyCopyWithImpl<EarthquakeNoticeTelegramBody>(this as EarthquakeNoticeTelegramBody, _$identity);

  /// Serializes this EarthquakeNoticeTelegramBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeNoticeTelegramBody&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'EarthquakeNoticeTelegramBody(type: $type)';
}


}

/// @nodoc
abstract mixin class $EarthquakeNoticeTelegramBodyCopyWith<$Res>  {
  factory $EarthquakeNoticeTelegramBodyCopyWith(EarthquakeNoticeTelegramBody value, $Res Function(EarthquakeNoticeTelegramBody) _then) = _$EarthquakeNoticeTelegramBodyCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$EarthquakeNoticeTelegramBodyCopyWithImpl<$Res>
    implements $EarthquakeNoticeTelegramBodyCopyWith<$Res> {
  _$EarthquakeNoticeTelegramBodyCopyWithImpl(this._self, this._then);

  final EarthquakeNoticeTelegramBody _self;
  final $Res Function(EarthquakeNoticeTelegramBody) _then;

/// Create a copy of EarthquakeNoticeTelegramBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeNoticeTelegramBody].
extension EarthquakeNoticeTelegramBodyPatterns on EarthquakeNoticeTelegramBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeNoticeTelegramBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeNoticeTelegramBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeNoticeTelegramBody value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeNoticeTelegramBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeNoticeTelegramBody value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeNoticeTelegramBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeNoticeTelegramBody() when $default != null:
return $default(_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeNoticeTelegramBody():
return $default(_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeNoticeTelegramBody() when $default != null:
return $default(_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeNoticeTelegramBody implements EarthquakeNoticeTelegramBody {
  const _EarthquakeNoticeTelegramBody({required this.type});
  factory _EarthquakeNoticeTelegramBody.fromJson(Map<String, dynamic> json) => _$EarthquakeNoticeTelegramBodyFromJson(json);

@override final  String type;

/// Create a copy of EarthquakeNoticeTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeNoticeTelegramBodyCopyWith<_EarthquakeNoticeTelegramBody> get copyWith => __$EarthquakeNoticeTelegramBodyCopyWithImpl<_EarthquakeNoticeTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeNoticeTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeNoticeTelegramBody&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'EarthquakeNoticeTelegramBody(type: $type)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeNoticeTelegramBodyCopyWith<$Res> implements $EarthquakeNoticeTelegramBodyCopyWith<$Res> {
  factory _$EarthquakeNoticeTelegramBodyCopyWith(_EarthquakeNoticeTelegramBody value, $Res Function(_EarthquakeNoticeTelegramBody) _then) = __$EarthquakeNoticeTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type
});




}
/// @nodoc
class __$EarthquakeNoticeTelegramBodyCopyWithImpl<$Res>
    implements _$EarthquakeNoticeTelegramBodyCopyWith<$Res> {
  __$EarthquakeNoticeTelegramBodyCopyWithImpl(this._self, this._then);

  final _EarthquakeNoticeTelegramBody _self;
  final $Res Function(_EarthquakeNoticeTelegramBody) _then;

/// Create a copy of EarthquakeNoticeTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(_EarthquakeNoticeTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
