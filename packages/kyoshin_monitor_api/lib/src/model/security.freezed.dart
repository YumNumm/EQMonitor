// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

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
  return _then(_self.copyWith(
realm: freezed == realm ? _self.realm : realm // ignore: cast_nullable_to_non_nullable
as String?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
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
