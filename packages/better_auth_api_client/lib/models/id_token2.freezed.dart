// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'id_token2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IdToken2 {

 String get token;@JsonKey(includeIfNull: false) String? get nonce;@JsonKey(includeIfNull: false) String? get accessToken;@JsonKey(includeIfNull: false) String? get refreshToken;@JsonKey(includeIfNull: false) List<dynamic>? get scopes;
/// Create a copy of IdToken2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IdToken2CopyWith<IdToken2> get copyWith => _$IdToken2CopyWithImpl<IdToken2>(this as IdToken2, _$identity);

  /// Serializes this IdToken2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IdToken2&&(identical(other.token, token) || other.token == token)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&const DeepCollectionEquality().equals(other.scopes, scopes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,nonce,accessToken,refreshToken,const DeepCollectionEquality().hash(scopes));

@override
String toString() {
  return 'IdToken2(token: $token, nonce: $nonce, accessToken: $accessToken, refreshToken: $refreshToken, scopes: $scopes)';
}


}

/// @nodoc
abstract mixin class $IdToken2CopyWith<$Res>  {
  factory $IdToken2CopyWith(IdToken2 value, $Res Function(IdToken2) _then) = _$IdToken2CopyWithImpl;
@useResult
$Res call({
 String token,@JsonKey(includeIfNull: false) String? nonce,@JsonKey(includeIfNull: false) String? accessToken,@JsonKey(includeIfNull: false) String? refreshToken,@JsonKey(includeIfNull: false) List<dynamic>? scopes
});




}
/// @nodoc
class _$IdToken2CopyWithImpl<$Res>
    implements $IdToken2CopyWith<$Res> {
  _$IdToken2CopyWithImpl(this._self, this._then);

  final IdToken2 _self;
  final $Res Function(IdToken2) _then;

/// Create a copy of IdToken2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? nonce = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? scopes = freezed,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,nonce: freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,scopes: freezed == scopes ? _self.scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [IdToken2].
extension IdToken2Patterns on IdToken2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IdToken2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IdToken2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IdToken2 value)  $default,){
final _that = this;
switch (_that) {
case _IdToken2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IdToken2 value)?  $default,){
final _that = this;
switch (_that) {
case _IdToken2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token, @JsonKey(includeIfNull: false)  String? nonce, @JsonKey(includeIfNull: false)  String? accessToken, @JsonKey(includeIfNull: false)  String? refreshToken, @JsonKey(includeIfNull: false)  List<dynamic>? scopes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IdToken2() when $default != null:
return $default(_that.token,_that.nonce,_that.accessToken,_that.refreshToken,_that.scopes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token, @JsonKey(includeIfNull: false)  String? nonce, @JsonKey(includeIfNull: false)  String? accessToken, @JsonKey(includeIfNull: false)  String? refreshToken, @JsonKey(includeIfNull: false)  List<dynamic>? scopes)  $default,) {final _that = this;
switch (_that) {
case _IdToken2():
return $default(_that.token,_that.nonce,_that.accessToken,_that.refreshToken,_that.scopes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token, @JsonKey(includeIfNull: false)  String? nonce, @JsonKey(includeIfNull: false)  String? accessToken, @JsonKey(includeIfNull: false)  String? refreshToken, @JsonKey(includeIfNull: false)  List<dynamic>? scopes)?  $default,) {final _that = this;
switch (_that) {
case _IdToken2() when $default != null:
return $default(_that.token,_that.nonce,_that.accessToken,_that.refreshToken,_that.scopes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IdToken2 implements IdToken2 {
  const _IdToken2({required this.token, @JsonKey(includeIfNull: false) this.nonce, @JsonKey(includeIfNull: false) this.accessToken, @JsonKey(includeIfNull: false) this.refreshToken, @JsonKey(includeIfNull: false) final  List<dynamic>? scopes}): _scopes = scopes;
  factory _IdToken2.fromJson(Map<String, dynamic> json) => _$IdToken2FromJson(json);

@override final  String token;
@override@JsonKey(includeIfNull: false) final  String? nonce;
@override@JsonKey(includeIfNull: false) final  String? accessToken;
@override@JsonKey(includeIfNull: false) final  String? refreshToken;
 final  List<dynamic>? _scopes;
@override@JsonKey(includeIfNull: false) List<dynamic>? get scopes {
  final value = _scopes;
  if (value == null) return null;
  if (_scopes is EqualUnmodifiableListView) return _scopes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of IdToken2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IdToken2CopyWith<_IdToken2> get copyWith => __$IdToken2CopyWithImpl<_IdToken2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IdToken2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IdToken2&&(identical(other.token, token) || other.token == token)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&const DeepCollectionEquality().equals(other._scopes, _scopes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,nonce,accessToken,refreshToken,const DeepCollectionEquality().hash(_scopes));

@override
String toString() {
  return 'IdToken2(token: $token, nonce: $nonce, accessToken: $accessToken, refreshToken: $refreshToken, scopes: $scopes)';
}


}

/// @nodoc
abstract mixin class _$IdToken2CopyWith<$Res> implements $IdToken2CopyWith<$Res> {
  factory _$IdToken2CopyWith(_IdToken2 value, $Res Function(_IdToken2) _then) = __$IdToken2CopyWithImpl;
@override @useResult
$Res call({
 String token,@JsonKey(includeIfNull: false) String? nonce,@JsonKey(includeIfNull: false) String? accessToken,@JsonKey(includeIfNull: false) String? refreshToken,@JsonKey(includeIfNull: false) List<dynamic>? scopes
});




}
/// @nodoc
class __$IdToken2CopyWithImpl<$Res>
    implements _$IdToken2CopyWith<$Res> {
  __$IdToken2CopyWithImpl(this._self, this._then);

  final _IdToken2 _self;
  final $Res Function(_IdToken2) _then;

/// Create a copy of IdToken2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? nonce = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? scopes = freezed,}) {
  return _then(_IdToken2(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,nonce: freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,scopes: freezed == scopes ? _self._scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}

// dart format on
