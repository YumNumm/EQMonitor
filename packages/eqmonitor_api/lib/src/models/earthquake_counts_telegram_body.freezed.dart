// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_counts_telegram_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeCountsTelegramBody {

/// const: "EARTHQUAKE_COUNTS"
 String get type;
/// Create a copy of EarthquakeCountsTelegramBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCountsTelegramBodyCopyWith<EarthquakeCountsTelegramBody> get copyWith => _$EarthquakeCountsTelegramBodyCopyWithImpl<EarthquakeCountsTelegramBody>(this as EarthquakeCountsTelegramBody, _$identity);

  /// Serializes this EarthquakeCountsTelegramBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeCountsTelegramBody&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'EarthquakeCountsTelegramBody(type: $type)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCountsTelegramBodyCopyWith<$Res>  {
  factory $EarthquakeCountsTelegramBodyCopyWith(EarthquakeCountsTelegramBody value, $Res Function(EarthquakeCountsTelegramBody) _then) = _$EarthquakeCountsTelegramBodyCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$EarthquakeCountsTelegramBodyCopyWithImpl<$Res>
    implements $EarthquakeCountsTelegramBodyCopyWith<$Res> {
  _$EarthquakeCountsTelegramBodyCopyWithImpl(this._self, this._then);

  final EarthquakeCountsTelegramBody _self;
  final $Res Function(EarthquakeCountsTelegramBody) _then;

/// Create a copy of EarthquakeCountsTelegramBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeCountsTelegramBody].
extension EarthquakeCountsTelegramBodyPatterns on EarthquakeCountsTelegramBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeCountsTelegramBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeCountsTelegramBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeCountsTelegramBody value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCountsTelegramBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeCountsTelegramBody value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeCountsTelegramBody() when $default != null:
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
case _EarthquakeCountsTelegramBody() when $default != null:
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
case _EarthquakeCountsTelegramBody():
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
case _EarthquakeCountsTelegramBody() when $default != null:
return $default(_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeCountsTelegramBody implements EarthquakeCountsTelegramBody {
  const _EarthquakeCountsTelegramBody({required this.type});
  factory _EarthquakeCountsTelegramBody.fromJson(Map<String, dynamic> json) => _$EarthquakeCountsTelegramBodyFromJson(json);

/// const: "EARTHQUAKE_COUNTS"
@override final  String type;

/// Create a copy of EarthquakeCountsTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCountsTelegramBodyCopyWith<_EarthquakeCountsTelegramBody> get copyWith => __$EarthquakeCountsTelegramBodyCopyWithImpl<_EarthquakeCountsTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeCountsTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeCountsTelegramBody&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'EarthquakeCountsTelegramBody(type: $type)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCountsTelegramBodyCopyWith<$Res> implements $EarthquakeCountsTelegramBodyCopyWith<$Res> {
  factory _$EarthquakeCountsTelegramBodyCopyWith(_EarthquakeCountsTelegramBody value, $Res Function(_EarthquakeCountsTelegramBody) _then) = __$EarthquakeCountsTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type
});




}
/// @nodoc
class __$EarthquakeCountsTelegramBodyCopyWithImpl<$Res>
    implements _$EarthquakeCountsTelegramBodyCopyWith<$Res> {
  __$EarthquakeCountsTelegramBodyCopyWithImpl(this._self, this._then);

  final _EarthquakeCountsTelegramBody _self;
  final $Res Function(_EarthquakeCountsTelegramBody) _then;

/// Create a copy of EarthquakeCountsTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(_EarthquakeCountsTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
