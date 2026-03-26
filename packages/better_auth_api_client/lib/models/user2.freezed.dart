// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User2 {

/// The unique identifier of the user
 String get id;/// The email address of the user
 String get email;/// The name of the user
 String get name;/// Whether the email has been verified
 bool get emailVerified;/// When the user was created
 DateTime get createdAt;/// When the user was last updated
 DateTime get updatedAt;/// The profile image URL of the user
@JsonKey(includeIfNull: false) String? get image;
/// Create a copy of User2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$User2CopyWith<User2> get copyWith => _$User2CopyWithImpl<User2>(this as User2, _$identity);

  /// Serializes this User2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User2&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,name,emailVerified,createdAt,updatedAt,image);

@override
String toString() {
  return 'User2(id: $id, email: $email, name: $name, emailVerified: $emailVerified, createdAt: $createdAt, updatedAt: $updatedAt, image: $image)';
}


}

/// @nodoc
abstract mixin class $User2CopyWith<$Res>  {
  factory $User2CopyWith(User2 value, $Res Function(User2) _then) = _$User2CopyWithImpl;
@useResult
$Res call({
 String id, String email, String name, bool emailVerified, DateTime createdAt, DateTime updatedAt,@JsonKey(includeIfNull: false) String? image
});




}
/// @nodoc
class _$User2CopyWithImpl<$Res>
    implements $User2CopyWith<$Res> {
  _$User2CopyWithImpl(this._self, this._then);

  final User2 _self;
  final $Res Function(User2) _then;

/// Create a copy of User2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? name = null,Object? emailVerified = null,Object? createdAt = null,Object? updatedAt = null,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emailVerified: null == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [User2].
extension User2Patterns on User2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User2 value)  $default,){
final _that = this;
switch (_that) {
case _User2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User2 value)?  $default,){
final _that = this;
switch (_that) {
case _User2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String name,  bool emailVerified,  DateTime createdAt,  DateTime updatedAt, @JsonKey(includeIfNull: false)  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User2() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.emailVerified,_that.createdAt,_that.updatedAt,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String name,  bool emailVerified,  DateTime createdAt,  DateTime updatedAt, @JsonKey(includeIfNull: false)  String? image)  $default,) {final _that = this;
switch (_that) {
case _User2():
return $default(_that.id,_that.email,_that.name,_that.emailVerified,_that.createdAt,_that.updatedAt,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String name,  bool emailVerified,  DateTime createdAt,  DateTime updatedAt, @JsonKey(includeIfNull: false)  String? image)?  $default,) {final _that = this;
switch (_that) {
case _User2() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.emailVerified,_that.createdAt,_that.updatedAt,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User2 implements User2 {
  const _User2({required this.id, required this.email, required this.name, required this.emailVerified, required this.createdAt, required this.updatedAt, @JsonKey(includeIfNull: false) this.image});
  factory _User2.fromJson(Map<String, dynamic> json) => _$User2FromJson(json);

/// The unique identifier of the user
@override final  String id;
/// The email address of the user
@override final  String email;
/// The name of the user
@override final  String name;
/// Whether the email has been verified
@override final  bool emailVerified;
/// When the user was created
@override final  DateTime createdAt;
/// When the user was last updated
@override final  DateTime updatedAt;
/// The profile image URL of the user
@override@JsonKey(includeIfNull: false) final  String? image;

/// Create a copy of User2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$User2CopyWith<_User2> get copyWith => __$User2CopyWithImpl<_User2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$User2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User2&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,name,emailVerified,createdAt,updatedAt,image);

@override
String toString() {
  return 'User2(id: $id, email: $email, name: $name, emailVerified: $emailVerified, createdAt: $createdAt, updatedAt: $updatedAt, image: $image)';
}


}

/// @nodoc
abstract mixin class _$User2CopyWith<$Res> implements $User2CopyWith<$Res> {
  factory _$User2CopyWith(_User2 value, $Res Function(_User2) _then) = __$User2CopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String name, bool emailVerified, DateTime createdAt, DateTime updatedAt,@JsonKey(includeIfNull: false) String? image
});




}
/// @nodoc
class __$User2CopyWithImpl<$Res>
    implements _$User2CopyWith<$Res> {
  __$User2CopyWithImpl(this._self, this._then);

  final _User2 _self;
  final $Res Function(_User2) _then;

/// Create a copy of User2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? name = null,Object? emailVerified = null,Object? createdAt = null,Object? updatedAt = null,Object? image = freezed,}) {
  return _then(_User2(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emailVerified: null == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
