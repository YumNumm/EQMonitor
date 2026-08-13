// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Security {

 String? get realm; String? get hash;
/// Create a copy of Security
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityCopyWith<Security> get copyWith => _$SecurityCopyWithImpl<Security>(this as Security, _$identity);

  /// Serializes this Security to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Security&&(identical(other.realm, realm) || other.realm == realm)&&(identical(other.hash, hash) || other.hash == hash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,realm,hash);

@override
String toString() {
  return 'Security(realm: $realm, hash: $hash)';
}


}

/// @nodoc
abstract mixin class $SecurityCopyWith<$Res>  {
  factory $SecurityCopyWith(Security value, $Res Function(Security) _then) = _$SecurityCopyWithImpl;
@useResult
$Res call({
 String? realm, String? hash
});




}
/// @nodoc
class _$SecurityCopyWithImpl<$Res>
    implements $SecurityCopyWith<$Res> {
  _$SecurityCopyWithImpl(this._self, this._then);

  final Security _self;
  final $Res Function(Security) _then;

/// Create a copy of Security
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? realm = freezed,Object? hash = freezed,}) {
  return _then(Security(
realm: freezed == realm ? _self.realm : realm // ignore: cast_nullable_to_non_nullable
as String?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Security].
extension SecurityPatterns on Security {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Security value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Security() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Security value)  $default,){
final _that = this;
switch (_that) {
case _Security():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Security value)?  $default,){
final _that = this;
switch (_that) {
case _Security() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? realm,  String? hash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Security() when $default != null:
return $default(_that.realm,_that.hash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? realm,  String? hash)  $default,) {final _that = this;
switch (_that) {
case _Security():
return $default(_that.realm,_that.hash);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? realm,  String? hash)?  $default,) {final _that = this;
switch (_that) {
case _Security() when $default != null:
return $default(_that.realm,_that.hash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Security implements Security {
  const _Security({required this.realm, required this.hash});
  factory _Security.fromJson(Map<String, dynamic> json) => _$SecurityFromJson(json);

@override final  String? realm;
@override final  String? hash;

/// Create a copy of Security
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecurityCopyWith<_Security> get copyWith => __$SecurityCopyWithImpl<_Security>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SecurityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Security&&(identical(other.realm, realm) || other.realm == realm)&&(identical(other.hash, hash) || other.hash == hash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,realm,hash);

@override
String toString() {
  return 'Security(realm: $realm, hash: $hash)';
}


}

/// @nodoc
abstract mixin class _$SecurityCopyWith<$Res> implements $SecurityCopyWith<$Res> {
  factory _$SecurityCopyWith(_Security value, $Res Function(_Security) _then) = __$SecurityCopyWithImpl;
@override @useResult
$Res call({
 String? realm, String? hash
});




}
/// @nodoc
class __$SecurityCopyWithImpl<$Res>
    implements _$SecurityCopyWith<$Res> {
  __$SecurityCopyWithImpl(this._self, this._then);

  final _Security _self;
  final $Res Function(_Security) _then;

/// Create a copy of Security
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? realm = freezed,Object? hash = freezed,}) {
  return _then(_Security(
realm: freezed == realm ? _self.realm : realm // ignore: cast_nullable_to_non_nullable
as String?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
