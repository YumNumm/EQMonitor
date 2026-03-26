// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user4.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User4 {

 String get id; bool get emailVerified;@JsonKey(includeIfNull: false) String? get name;@JsonKey(includeIfNull: false) String? get email;@JsonKey(includeIfNull: false) String? get image;
/// Create a copy of User4
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$User4CopyWith<User4> get copyWith => _$User4CopyWithImpl<User4>(this as User4, _$identity);

  /// Serializes this User4 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User4&&(identical(other.id, id) || other.id == id)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,emailVerified,name,email,image);

@override
String toString() {
  return 'User4(id: $id, emailVerified: $emailVerified, name: $name, email: $email, image: $image)';
}


}

/// @nodoc
abstract mixin class $User4CopyWith<$Res>  {
  factory $User4CopyWith(User4 value, $Res Function(User4) _then) = _$User4CopyWithImpl;
@useResult
$Res call({
 String id, bool emailVerified,@JsonKey(includeIfNull: false) String? name,@JsonKey(includeIfNull: false) String? email,@JsonKey(includeIfNull: false) String? image
});




}
/// @nodoc
class _$User4CopyWithImpl<$Res>
    implements $User4CopyWith<$Res> {
  _$User4CopyWithImpl(this._self, this._then);

  final User4 _self;
  final $Res Function(User4) _then;

/// Create a copy of User4
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? emailVerified = null,Object? name = freezed,Object? email = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,emailVerified: null == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [User4].
extension User4Patterns on User4 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User4 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User4() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User4 value)  $default,){
final _that = this;
switch (_that) {
case _User4():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User4 value)?  $default,){
final _that = this;
switch (_that) {
case _User4() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  bool emailVerified, @JsonKey(includeIfNull: false)  String? name, @JsonKey(includeIfNull: false)  String? email, @JsonKey(includeIfNull: false)  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User4() when $default != null:
return $default(_that.id,_that.emailVerified,_that.name,_that.email,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  bool emailVerified, @JsonKey(includeIfNull: false)  String? name, @JsonKey(includeIfNull: false)  String? email, @JsonKey(includeIfNull: false)  String? image)  $default,) {final _that = this;
switch (_that) {
case _User4():
return $default(_that.id,_that.emailVerified,_that.name,_that.email,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  bool emailVerified, @JsonKey(includeIfNull: false)  String? name, @JsonKey(includeIfNull: false)  String? email, @JsonKey(includeIfNull: false)  String? image)?  $default,) {final _that = this;
switch (_that) {
case _User4() when $default != null:
return $default(_that.id,_that.emailVerified,_that.name,_that.email,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User4 implements User4 {
  const _User4({required this.id, required this.emailVerified, @JsonKey(includeIfNull: false) this.name, @JsonKey(includeIfNull: false) this.email, @JsonKey(includeIfNull: false) this.image});
  factory _User4.fromJson(Map<String, dynamic> json) => _$User4FromJson(json);

@override final  String id;
@override final  bool emailVerified;
@override@JsonKey(includeIfNull: false) final  String? name;
@override@JsonKey(includeIfNull: false) final  String? email;
@override@JsonKey(includeIfNull: false) final  String? image;

/// Create a copy of User4
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$User4CopyWith<_User4> get copyWith => __$User4CopyWithImpl<_User4>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$User4ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User4&&(identical(other.id, id) || other.id == id)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,emailVerified,name,email,image);

@override
String toString() {
  return 'User4(id: $id, emailVerified: $emailVerified, name: $name, email: $email, image: $image)';
}


}

/// @nodoc
abstract mixin class _$User4CopyWith<$Res> implements $User4CopyWith<$Res> {
  factory _$User4CopyWith(_User4 value, $Res Function(_User4) _then) = __$User4CopyWithImpl;
@override @useResult
$Res call({
 String id, bool emailVerified,@JsonKey(includeIfNull: false) String? name,@JsonKey(includeIfNull: false) String? email,@JsonKey(includeIfNull: false) String? image
});




}
/// @nodoc
class __$User4CopyWithImpl<$Res>
    implements _$User4CopyWith<$Res> {
  __$User4CopyWithImpl(this._self, this._then);

  final _User4 _self;
  final $Res Function(_User4) _then;

/// Create a copy of User4
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? emailVerified = null,Object? name = freezed,Object? email = freezed,Object? image = freezed,}) {
  return _then(_User4(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,emailVerified: null == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
