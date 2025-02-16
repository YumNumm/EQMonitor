// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Security _$SecurityFromJson(Map<String, dynamic> json) {
  return _Security.fromJson(json);
}

/// @nodoc
mixin _$Security {
  String? get realm => throw _privateConstructorUsedError;
  String? get hash => throw _privateConstructorUsedError;

  /// Serializes this Security to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of Security
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecurityCopyWith<Security> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityCopyWith<$Res> {
  factory $SecurityCopyWith(
    Security value,
    $Res Function(Security) then,
  ) = _$SecurityCopyWithImpl<$Res, Security>;
  @useResult
  $Res call({String? realm, String? hash});
}

/// @nodoc
class _$SecurityCopyWithImpl<$Res, $Val extends Security>
    implements $SecurityCopyWith<$Res> {
  _$SecurityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Security
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? realm = freezed,
    Object? hash = freezed,
  }) {
    return _then(
      _value.copyWith(
            realm:
                freezed == realm
                    ? _value.realm
                    : realm // ignore: cast_nullable_to_non_nullable
                        as String?,
            hash:
                freezed == hash
                    ? _value.hash
                    : hash // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SecurityImplCopyWith<$Res>
    implements $SecurityCopyWith<$Res> {
  factory _$$SecurityImplCopyWith(
    _$SecurityImpl value,
    $Res Function(_$SecurityImpl) then,
  ) = __$$SecurityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? realm, String? hash});
}

/// @nodoc
class __$$SecurityImplCopyWithImpl<$Res>
    extends _$SecurityCopyWithImpl<$Res, _$SecurityImpl>
    implements _$$SecurityImplCopyWith<$Res> {
  __$$SecurityImplCopyWithImpl(
    _$SecurityImpl _value,
    $Res Function(_$SecurityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Security
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? realm = freezed,
    Object? hash = freezed,
  }) {
    return _then(
      _$SecurityImpl(
        realm:
            freezed == realm
                ? _value.realm
                : realm // ignore: cast_nullable_to_non_nullable
                    as String?,
        hash:
            freezed == hash
                ? _value.hash
                : hash // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SecurityImpl implements _Security {
  const _$SecurityImpl({
    required this.realm,
    required this.hash,
  });

  factory _$SecurityImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$SecurityImplFromJson(json);

  @override
  final String? realm;
  @override
  final String? hash;

  @override
  String toString() {
    return 'Security(realm: $realm, hash: $hash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityImpl &&
            (identical(other.realm, realm) ||
                other.realm == realm) &&
            (identical(other.hash, hash) ||
                other.hash == hash));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, realm, hash);

  /// Create a copy of Security
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityImplCopyWith<_$SecurityImpl> get copyWith =>
      __$$SecurityImplCopyWithImpl<_$SecurityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SecurityImplToJson(this);
  }
}

abstract class _Security implements Security {
  const factory _Security({
    required final String? realm,
    required final String? hash,
  }) = _$SecurityImpl;

  factory _Security.fromJson(Map<String, dynamic> json) =
      _$SecurityImpl.fromJson;

  @override
  String? get realm;
  @override
  String? get hash;

  /// Create a copy of Security
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityImplCopyWith<_$SecurityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
