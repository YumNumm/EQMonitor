// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm_token_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FcmTokenRequest _$FcmTokenRequestFromJson(Map<String, dynamic> json) {
  return _FcmTokenRequest.fromJson(json);
}

/// @nodoc
mixin _$FcmTokenRequest {
  String get fcmToken => throw _privateConstructorUsedError;

  /// Serializes this FcmTokenRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FcmTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FcmTokenRequestCopyWith<FcmTokenRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FcmTokenRequestCopyWith<$Res> {
  factory $FcmTokenRequestCopyWith(
          FcmTokenRequest value, $Res Function(FcmTokenRequest) then) =
      _$FcmTokenRequestCopyWithImpl<$Res, FcmTokenRequest>;
  @useResult
  $Res call({String fcmToken});
}

/// @nodoc
class _$FcmTokenRequestCopyWithImpl<$Res, $Val extends FcmTokenRequest>
    implements $FcmTokenRequestCopyWith<$Res> {
  _$FcmTokenRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FcmTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fcmToken = null,
  }) {
    return _then(_value.copyWith(
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FcmTokenRequestImplCopyWith<$Res>
    implements $FcmTokenRequestCopyWith<$Res> {
  factory _$$FcmTokenRequestImplCopyWith(_$FcmTokenRequestImpl value,
          $Res Function(_$FcmTokenRequestImpl) then) =
      __$$FcmTokenRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fcmToken});
}

/// @nodoc
class __$$FcmTokenRequestImplCopyWithImpl<$Res>
    extends _$FcmTokenRequestCopyWithImpl<$Res, _$FcmTokenRequestImpl>
    implements _$$FcmTokenRequestImplCopyWith<$Res> {
  __$$FcmTokenRequestImplCopyWithImpl(
      _$FcmTokenRequestImpl _value, $Res Function(_$FcmTokenRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of FcmTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fcmToken = null,
  }) {
    return _then(_$FcmTokenRequestImpl(
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FcmTokenRequestImpl implements _FcmTokenRequest {
  const _$FcmTokenRequestImpl({required this.fcmToken});

  factory _$FcmTokenRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$FcmTokenRequestImplFromJson(json);

  @override
  final String fcmToken;

  @override
  String toString() {
    return 'FcmTokenRequest(fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FcmTokenRequestImpl &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fcmToken);

  /// Create a copy of FcmTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FcmTokenRequestImplCopyWith<_$FcmTokenRequestImpl> get copyWith =>
      __$$FcmTokenRequestImplCopyWithImpl<_$FcmTokenRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FcmTokenRequestImplToJson(
      this,
    );
  }
}

abstract class _FcmTokenRequest implements FcmTokenRequest {
  const factory _FcmTokenRequest({required final String fcmToken}) =
      _$FcmTokenRequestImpl;

  factory _FcmTokenRequest.fromJson(Map<String, dynamic> json) =
      _$FcmTokenRequestImpl.fromJson;

  @override
  String get fcmToken;

  /// Create a copy of FcmTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FcmTokenRequestImplCopyWith<_$FcmTokenRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
