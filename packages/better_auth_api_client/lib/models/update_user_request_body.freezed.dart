// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_user_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateUserRequestBody {

/// The name of the user
 String get name;/// The image of the user
@JsonKey(includeIfNull: false) String? get image;
/// Create a copy of UpdateUserRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserRequestBodyCopyWith<UpdateUserRequestBody> get copyWith => _$UpdateUserRequestBodyCopyWithImpl<UpdateUserRequestBody>(this as UpdateUserRequestBody, _$identity);

  /// Serializes this UpdateUserRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserRequestBody&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,image);

@override
String toString() {
  return 'UpdateUserRequestBody(name: $name, image: $image)';
}


}

/// @nodoc
abstract mixin class $UpdateUserRequestBodyCopyWith<$Res>  {
  factory $UpdateUserRequestBodyCopyWith(UpdateUserRequestBody value, $Res Function(UpdateUserRequestBody) _then) = _$UpdateUserRequestBodyCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(includeIfNull: false) String? image
});




}
/// @nodoc
class _$UpdateUserRequestBodyCopyWithImpl<$Res>
    implements $UpdateUserRequestBodyCopyWith<$Res> {
  _$UpdateUserRequestBodyCopyWithImpl(this._self, this._then);

  final UpdateUserRequestBody _self;
  final $Res Function(UpdateUserRequestBody) _then;

/// Create a copy of UpdateUserRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? image = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateUserRequestBody].
extension UpdateUserRequestBodyPatterns on UpdateUserRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateUserRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateUserRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateUserRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _UpdateUserRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateUserRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateUserRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(includeIfNull: false)  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateUserRequestBody() when $default != null:
return $default(_that.name,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(includeIfNull: false)  String? image)  $default,) {final _that = this;
switch (_that) {
case _UpdateUserRequestBody():
return $default(_that.name,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(includeIfNull: false)  String? image)?  $default,) {final _that = this;
switch (_that) {
case _UpdateUserRequestBody() when $default != null:
return $default(_that.name,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateUserRequestBody implements UpdateUserRequestBody {
  const _UpdateUserRequestBody({required this.name, @JsonKey(includeIfNull: false) this.image});
  factory _UpdateUserRequestBody.fromJson(Map<String, dynamic> json) => _$UpdateUserRequestBodyFromJson(json);

/// The name of the user
@override final  String name;
/// The image of the user
@override@JsonKey(includeIfNull: false) final  String? image;

/// Create a copy of UpdateUserRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUserRequestBodyCopyWith<_UpdateUserRequestBody> get copyWith => __$UpdateUserRequestBodyCopyWithImpl<_UpdateUserRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateUserRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserRequestBody&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,image);

@override
String toString() {
  return 'UpdateUserRequestBody(name: $name, image: $image)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserRequestBodyCopyWith<$Res> implements $UpdateUserRequestBodyCopyWith<$Res> {
  factory _$UpdateUserRequestBodyCopyWith(_UpdateUserRequestBody value, $Res Function(_UpdateUserRequestBody) _then) = __$UpdateUserRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(includeIfNull: false) String? image
});




}
/// @nodoc
class __$UpdateUserRequestBodyCopyWithImpl<$Res>
    implements _$UpdateUserRequestBodyCopyWith<$Res> {
  __$UpdateUserRequestBodyCopyWithImpl(this._self, this._then);

  final _UpdateUserRequestBody _self;
  final $Res Function(_UpdateUserRequestBody) _then;

/// Create a copy of UpdateUserRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? image = freezed,}) {
  return _then(_UpdateUserRequestBody(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
