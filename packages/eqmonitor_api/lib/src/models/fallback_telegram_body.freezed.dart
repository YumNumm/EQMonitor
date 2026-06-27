// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fallback_telegram_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FallbackTelegramBody {

 String get type;
/// Create a copy of FallbackTelegramBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FallbackTelegramBodyCopyWith<FallbackTelegramBody> get copyWith => _$FallbackTelegramBodyCopyWithImpl<FallbackTelegramBody>(this as FallbackTelegramBody, _$identity);

  /// Serializes this FallbackTelegramBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FallbackTelegramBody&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'FallbackTelegramBody(type: $type)';
}


}

/// @nodoc
abstract mixin class $FallbackTelegramBodyCopyWith<$Res>  {
  factory $FallbackTelegramBodyCopyWith(FallbackTelegramBody value, $Res Function(FallbackTelegramBody) _then) = _$FallbackTelegramBodyCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$FallbackTelegramBodyCopyWithImpl<$Res>
    implements $FallbackTelegramBodyCopyWith<$Res> {
  _$FallbackTelegramBodyCopyWithImpl(this._self, this._then);

  final FallbackTelegramBody _self;
  final $Res Function(FallbackTelegramBody) _then;

/// Create a copy of FallbackTelegramBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FallbackTelegramBody].
extension FallbackTelegramBodyPatterns on FallbackTelegramBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FallbackTelegramBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FallbackTelegramBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FallbackTelegramBody value)  $default,){
final _that = this;
switch (_that) {
case _FallbackTelegramBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FallbackTelegramBody value)?  $default,){
final _that = this;
switch (_that) {
case _FallbackTelegramBody() when $default != null:
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
case _FallbackTelegramBody() when $default != null:
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
case _FallbackTelegramBody():
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
case _FallbackTelegramBody() when $default != null:
return $default(_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FallbackTelegramBody implements FallbackTelegramBody {
  const _FallbackTelegramBody({required this.type});
  factory _FallbackTelegramBody.fromJson(Map<String, dynamic> json) => _$FallbackTelegramBodyFromJson(json);

@override final  String type;

/// Create a copy of FallbackTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FallbackTelegramBodyCopyWith<_FallbackTelegramBody> get copyWith => __$FallbackTelegramBodyCopyWithImpl<_FallbackTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FallbackTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FallbackTelegramBody&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'FallbackTelegramBody(type: $type)';
}


}

/// @nodoc
abstract mixin class _$FallbackTelegramBodyCopyWith<$Res> implements $FallbackTelegramBodyCopyWith<$Res> {
  factory _$FallbackTelegramBodyCopyWith(_FallbackTelegramBody value, $Res Function(_FallbackTelegramBody) _then) = __$FallbackTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type
});




}
/// @nodoc
class __$FallbackTelegramBodyCopyWithImpl<$Res>
    implements _$FallbackTelegramBodyCopyWith<$Res> {
  __$FallbackTelegramBodyCopyWithImpl(this._self, this._then);

  final _FallbackTelegramBody _self;
  final $Res Function(_FallbackTelegramBody) _then;

/// Create a copy of FallbackTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(_FallbackTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
