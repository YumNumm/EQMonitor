// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationTokenModel _$NotificationTokenModelFromJson(
    Map<String, dynamic> json) {
  return _NotificationTokenModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationTokenModel {
  String? get fcmToken => throw _privateConstructorUsedError;
  String? get apnsToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationTokenModelCopyWith<NotificationTokenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationTokenModelCopyWith<$Res> {
  factory $NotificationTokenModelCopyWith(NotificationTokenModel value,
          $Res Function(NotificationTokenModel) then) =
      _$NotificationTokenModelCopyWithImpl<$Res, NotificationTokenModel>;
  @useResult
  $Res call({String? fcmToken, String? apnsToken});
}

/// @nodoc
class _$NotificationTokenModelCopyWithImpl<$Res,
        $Val extends NotificationTokenModel>
    implements $NotificationTokenModelCopyWith<$Res> {
  _$NotificationTokenModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fcmToken = freezed,
    Object? apnsToken = freezed,
  }) {
    return _then(_value.copyWith(
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      apnsToken: freezed == apnsToken
          ? _value.apnsToken
          : apnsToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationTokenModelImplCopyWith<$Res>
    implements $NotificationTokenModelCopyWith<$Res> {
  factory _$$NotificationTokenModelImplCopyWith(
          _$NotificationTokenModelImpl value,
          $Res Function(_$NotificationTokenModelImpl) then) =
      __$$NotificationTokenModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? fcmToken, String? apnsToken});
}

/// @nodoc
class __$$NotificationTokenModelImplCopyWithImpl<$Res>
    extends _$NotificationTokenModelCopyWithImpl<$Res,
        _$NotificationTokenModelImpl>
    implements _$$NotificationTokenModelImplCopyWith<$Res> {
  __$$NotificationTokenModelImplCopyWithImpl(
      _$NotificationTokenModelImpl _value,
      $Res Function(_$NotificationTokenModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fcmToken = freezed,
    Object? apnsToken = freezed,
  }) {
    return _then(_$NotificationTokenModelImpl(
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      apnsToken: freezed == apnsToken
          ? _value.apnsToken
          : apnsToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationTokenModelImpl
    with DiagnosticableTreeMixin
    implements _NotificationTokenModel {
  const _$NotificationTokenModelImpl(
      {required this.fcmToken, required this.apnsToken});

  factory _$NotificationTokenModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationTokenModelImplFromJson(json);

  @override
  final String? fcmToken;
  @override
  final String? apnsToken;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationTokenModel(fcmToken: $fcmToken, apnsToken: $apnsToken)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationTokenModel'))
      ..add(DiagnosticsProperty('fcmToken', fcmToken))
      ..add(DiagnosticsProperty('apnsToken', apnsToken));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationTokenModelImpl &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.apnsToken, apnsToken) ||
                other.apnsToken == apnsToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fcmToken, apnsToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationTokenModelImplCopyWith<_$NotificationTokenModelImpl>
      get copyWith => __$$NotificationTokenModelImplCopyWithImpl<
          _$NotificationTokenModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationTokenModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationTokenModel implements NotificationTokenModel {
  const factory _NotificationTokenModel(
      {required final String? fcmToken,
      required final String? apnsToken}) = _$NotificationTokenModelImpl;

  factory _NotificationTokenModel.fromJson(Map<String, dynamic> json) =
      _$NotificationTokenModelImpl.fromJson;

  @override
  String? get fcmToken;
  @override
  String? get apnsToken;
  @override
  @JsonKey(ignore: true)
  _$$NotificationTokenModelImplCopyWith<_$NotificationTokenModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
