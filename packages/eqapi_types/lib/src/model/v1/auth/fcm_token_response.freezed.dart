// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm_token_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FcmTokenUpdateResponse _$FcmTokenUpdateResponseFromJson(
    Map<String, dynamic> json) {
  return _FcmTokenUpdateResponse.fromJson(json);
}

/// @nodoc
mixin _$FcmTokenUpdateResponse {
  String? get token => throw _privateConstructorUsedError;
  String? get fcmVerify => throw _privateConstructorUsedError;

  /// Serializes this FcmTokenUpdateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FcmTokenUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FcmTokenUpdateResponseCopyWith<FcmTokenUpdateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FcmTokenUpdateResponseCopyWith<$Res> {
  factory $FcmTokenUpdateResponseCopyWith(FcmTokenUpdateResponse value,
          $Res Function(FcmTokenUpdateResponse) then) =
      _$FcmTokenUpdateResponseCopyWithImpl<$Res, FcmTokenUpdateResponse>;
  @useResult
  $Res call({String? token, String? fcmVerify});
}

/// @nodoc
class _$FcmTokenUpdateResponseCopyWithImpl<$Res,
        $Val extends FcmTokenUpdateResponse>
    implements $FcmTokenUpdateResponseCopyWith<$Res> {
  _$FcmTokenUpdateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FcmTokenUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? fcmVerify = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmVerify: freezed == fcmVerify
          ? _value.fcmVerify
          : fcmVerify // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FcmTokenUpdateResponseImplCopyWith<$Res>
    implements $FcmTokenUpdateResponseCopyWith<$Res> {
  factory _$$FcmTokenUpdateResponseImplCopyWith(
          _$FcmTokenUpdateResponseImpl value,
          $Res Function(_$FcmTokenUpdateResponseImpl) then) =
      __$$FcmTokenUpdateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? token, String? fcmVerify});
}

/// @nodoc
class __$$FcmTokenUpdateResponseImplCopyWithImpl<$Res>
    extends _$FcmTokenUpdateResponseCopyWithImpl<$Res,
        _$FcmTokenUpdateResponseImpl>
    implements _$$FcmTokenUpdateResponseImplCopyWith<$Res> {
  __$$FcmTokenUpdateResponseImplCopyWithImpl(
      _$FcmTokenUpdateResponseImpl _value,
      $Res Function(_$FcmTokenUpdateResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FcmTokenUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? fcmVerify = freezed,
  }) {
    return _then(_$FcmTokenUpdateResponseImpl(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmVerify: freezed == fcmVerify
          ? _value.fcmVerify
          : fcmVerify // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FcmTokenUpdateResponseImpl implements _FcmTokenUpdateResponse {
  const _$FcmTokenUpdateResponseImpl(
      {required this.token, required this.fcmVerify});

  factory _$FcmTokenUpdateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FcmTokenUpdateResponseImplFromJson(json);

  @override
  final String? token;
  @override
  final String? fcmVerify;

  @override
  String toString() {
    return 'FcmTokenUpdateResponse(token: $token, fcmVerify: $fcmVerify)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FcmTokenUpdateResponseImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.fcmVerify, fcmVerify) ||
                other.fcmVerify == fcmVerify));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, fcmVerify);

  /// Create a copy of FcmTokenUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FcmTokenUpdateResponseImplCopyWith<_$FcmTokenUpdateResponseImpl>
      get copyWith => __$$FcmTokenUpdateResponseImplCopyWithImpl<
          _$FcmTokenUpdateResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FcmTokenUpdateResponseImplToJson(
      this,
    );
  }
}

abstract class _FcmTokenUpdateResponse implements FcmTokenUpdateResponse {
  const factory _FcmTokenUpdateResponse(
      {required final String? token,
      required final String? fcmVerify}) = _$FcmTokenUpdateResponseImpl;

  factory _FcmTokenUpdateResponse.fromJson(Map<String, dynamic> json) =
      _$FcmTokenUpdateResponseImpl.fromJson;

  @override
  String? get token;
  @override
  String? get fcmVerify;

  /// Create a copy of FcmTokenUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FcmTokenUpdateResponseImplCopyWith<_$FcmTokenUpdateResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
