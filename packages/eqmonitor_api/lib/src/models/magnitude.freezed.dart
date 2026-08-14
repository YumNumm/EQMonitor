// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'magnitude.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Magnitude {

 MagnitudeType get type;/// typeがNORMALのときのみ出現する
@JsonKey(includeIfNull: false) num? get value;
/// Create a copy of Magnitude
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MagnitudeCopyWith<Magnitude> get copyWith => _$MagnitudeCopyWithImpl<Magnitude>(this as Magnitude, _$identity);

  /// Serializes this Magnitude to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Magnitude&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,value);

@override
String toString() {
  return 'Magnitude(type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class $MagnitudeCopyWith<$Res>  {
  factory $MagnitudeCopyWith(Magnitude value, $Res Function(Magnitude) _then) = _$MagnitudeCopyWithImpl;
@useResult
$Res call({
 MagnitudeType type,@JsonKey(includeIfNull: false) num? value
});




}
/// @nodoc
class _$MagnitudeCopyWithImpl<$Res>
    implements $MagnitudeCopyWith<$Res> {
  _$MagnitudeCopyWithImpl(this._self, this._then);

  final Magnitude _self;
  final $Res Function(Magnitude) _then;

/// Create a copy of Magnitude
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? value = freezed,}) {
  return _then(Magnitude(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MagnitudeType,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [Magnitude].
extension MagnitudePatterns on Magnitude {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Magnitude value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Magnitude() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Magnitude value)  $default,){
final _that = this;
switch (_that) {
case _Magnitude():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Magnitude value)?  $default,){
final _that = this;
switch (_that) {
case _Magnitude() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MagnitudeType type, @JsonKey(includeIfNull: false)  num? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Magnitude() when $default != null:
return $default(_that.type,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MagnitudeType type, @JsonKey(includeIfNull: false)  num? value)  $default,) {final _that = this;
switch (_that) {
case _Magnitude():
return $default(_that.type,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MagnitudeType type, @JsonKey(includeIfNull: false)  num? value)?  $default,) {final _that = this;
switch (_that) {
case _Magnitude() when $default != null:
return $default(_that.type,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Magnitude implements Magnitude {
  const _Magnitude({required this.type, @JsonKey(includeIfNull: false) this.value});
  factory _Magnitude.fromJson(Map<String, dynamic> json) => _$MagnitudeFromJson(json);

@override final  MagnitudeType type;
/// typeがNORMALのときのみ出現する
@override@JsonKey(includeIfNull: false) final  num? value;

/// Create a copy of Magnitude
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MagnitudeCopyWith<_Magnitude> get copyWith => __$MagnitudeCopyWithImpl<_Magnitude>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MagnitudeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Magnitude&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,value);

@override
String toString() {
  return 'Magnitude(type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class _$MagnitudeCopyWith<$Res> implements $MagnitudeCopyWith<$Res> {
  factory _$MagnitudeCopyWith(_Magnitude value, $Res Function(_Magnitude) _then) = __$MagnitudeCopyWithImpl;
@override @useResult
$Res call({
 MagnitudeType type,@JsonKey(includeIfNull: false) num? value
});




}
/// @nodoc
class __$MagnitudeCopyWithImpl<$Res>
    implements _$MagnitudeCopyWith<$Res> {
  __$MagnitudeCopyWithImpl(this._self, this._then);

  final _Magnitude _self;
  final $Res Function(_Magnitude) _then;

/// Create a copy of Magnitude
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? value = freezed,}) {
  return _then(_Magnitude(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MagnitudeType,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
