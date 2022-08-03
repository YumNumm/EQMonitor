// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'firebase_notification_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FirebaseCloudMessagingModel {
  /// FCM Token
  String? get token =>
      throw _privateConstructorUsedError; // FCM Tokenが取得できたかどうか
  bool get hasToken => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FirebaseCloudMessagingModelCopyWith<FirebaseCloudMessagingModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseCloudMessagingModelCopyWith<$Res> {
  factory $FirebaseCloudMessagingModelCopyWith(
          FirebaseCloudMessagingModel value,
          $Res Function(FirebaseCloudMessagingModel) then) =
      _$FirebaseCloudMessagingModelCopyWithImpl<$Res>;
  $Res call({String? token, bool hasToken});
}

/// @nodoc
class _$FirebaseCloudMessagingModelCopyWithImpl<$Res>
    implements $FirebaseCloudMessagingModelCopyWith<$Res> {
  _$FirebaseCloudMessagingModelCopyWithImpl(this._value, this._then);

  final FirebaseCloudMessagingModel _value;
  // ignore: unused_field
  final $Res Function(FirebaseCloudMessagingModel) _then;

  @override
  $Res call({
    Object? token = freezed,
    Object? hasToken = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      hasToken: hasToken == freezed
          ? _value.hasToken
          : hasToken // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_FirebaseCloudMessagingModelCopyWith<$Res>
    implements $FirebaseCloudMessagingModelCopyWith<$Res> {
  factory _$$_FirebaseCloudMessagingModelCopyWith(
          _$_FirebaseCloudMessagingModel value,
          $Res Function(_$_FirebaseCloudMessagingModel) then) =
      __$$_FirebaseCloudMessagingModelCopyWithImpl<$Res>;
  @override
  $Res call({String? token, bool hasToken});
}

/// @nodoc
class __$$_FirebaseCloudMessagingModelCopyWithImpl<$Res>
    extends _$FirebaseCloudMessagingModelCopyWithImpl<$Res>
    implements _$$_FirebaseCloudMessagingModelCopyWith<$Res> {
  __$$_FirebaseCloudMessagingModelCopyWithImpl(
      _$_FirebaseCloudMessagingModel _value,
      $Res Function(_$_FirebaseCloudMessagingModel) _then)
      : super(_value, (v) => _then(v as _$_FirebaseCloudMessagingModel));

  @override
  _$_FirebaseCloudMessagingModel get _value =>
      super._value as _$_FirebaseCloudMessagingModel;

  @override
  $Res call({
    Object? token = freezed,
    Object? hasToken = freezed,
  }) {
    return _then(_$_FirebaseCloudMessagingModel(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      hasToken: hasToken == freezed
          ? _value.hasToken
          : hasToken // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_FirebaseCloudMessagingModel implements _FirebaseCloudMessagingModel {
  const _$_FirebaseCloudMessagingModel(
      {required this.token, required this.hasToken});

  /// FCM Token
  @override
  final String? token;
// FCM Tokenが取得できたかどうか
  @override
  final bool hasToken;

  @override
  String toString() {
    return 'FirebaseCloudMessagingModel(token: $token, hasToken: $hasToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirebaseCloudMessagingModel &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality().equals(other.hasToken, hasToken));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(hasToken));

  @JsonKey(ignore: true)
  @override
  _$$_FirebaseCloudMessagingModelCopyWith<_$_FirebaseCloudMessagingModel>
      get copyWith => __$$_FirebaseCloudMessagingModelCopyWithImpl<
          _$_FirebaseCloudMessagingModel>(this, _$identity);
}

abstract class _FirebaseCloudMessagingModel
    implements FirebaseCloudMessagingModel {
  const factory _FirebaseCloudMessagingModel(
      {required final String? token,
      required final bool hasToken}) = _$_FirebaseCloudMessagingModel;

  @override

  /// FCM Token
  String? get token;
  @override // FCM Tokenが取得できたかどうか
  bool get hasToken;
  @override
  @JsonKey(ignore: true)
  _$$_FirebaseCloudMessagingModelCopyWith<_$_FirebaseCloudMessagingModel>
      get copyWith => throw _privateConstructorUsedError;
}
