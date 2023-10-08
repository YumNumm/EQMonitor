// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PermissionStateModel _$PermissionStateModelFromJson(Map<String, dynamic> json) {
  return _PermissionStateModel.fromJson(json);
}

/// @nodoc
mixin _$PermissionStateModel {
  bool get notification => throw _privateConstructorUsedError;
  bool get isNotificationDeniedByUser => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PermissionStateModelCopyWith<PermissionStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionStateModelCopyWith<$Res> {
  factory $PermissionStateModelCopyWith(PermissionStateModel value,
          $Res Function(PermissionStateModel) then) =
      _$PermissionStateModelCopyWithImpl<$Res, PermissionStateModel>;
  @useResult
  $Res call({bool notification, bool isNotificationDeniedByUser});
}

/// @nodoc
class _$PermissionStateModelCopyWithImpl<$Res,
        $Val extends PermissionStateModel>
    implements $PermissionStateModelCopyWith<$Res> {
  _$PermissionStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notification = null,
    Object? isNotificationDeniedByUser = null,
  }) {
    return _then(_value.copyWith(
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotificationDeniedByUser: null == isNotificationDeniedByUser
          ? _value.isNotificationDeniedByUser
          : isNotificationDeniedByUser // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PermissionStateModelCopyWith<$Res>
    implements $PermissionStateModelCopyWith<$Res> {
  factory _$$_PermissionStateModelCopyWith(_$_PermissionStateModel value,
          $Res Function(_$_PermissionStateModel) then) =
      __$$_PermissionStateModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool notification, bool isNotificationDeniedByUser});
}

/// @nodoc
class __$$_PermissionStateModelCopyWithImpl<$Res>
    extends _$PermissionStateModelCopyWithImpl<$Res, _$_PermissionStateModel>
    implements _$$_PermissionStateModelCopyWith<$Res> {
  __$$_PermissionStateModelCopyWithImpl(_$_PermissionStateModel _value,
      $Res Function(_$_PermissionStateModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notification = null,
    Object? isNotificationDeniedByUser = null,
  }) {
    return _then(_$_PermissionStateModel(
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotificationDeniedByUser: null == isNotificationDeniedByUser
          ? _value.isNotificationDeniedByUser
          : isNotificationDeniedByUser // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PermissionStateModel implements _PermissionStateModel {
  const _$_PermissionStateModel(
      {this.notification = false, this.isNotificationDeniedByUser = false});

  factory _$_PermissionStateModel.fromJson(Map<String, dynamic> json) =>
      _$$_PermissionStateModelFromJson(json);

  @override
  @JsonKey()
  final bool notification;
  @override
  @JsonKey()
  final bool isNotificationDeniedByUser;

  @override
  String toString() {
    return 'PermissionStateModel(notification: $notification, isNotificationDeniedByUser: $isNotificationDeniedByUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PermissionStateModel &&
            (identical(other.notification, notification) ||
                other.notification == notification) &&
            (identical(other.isNotificationDeniedByUser,
                    isNotificationDeniedByUser) ||
                other.isNotificationDeniedByUser ==
                    isNotificationDeniedByUser));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, notification, isNotificationDeniedByUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PermissionStateModelCopyWith<_$_PermissionStateModel> get copyWith =>
      __$$_PermissionStateModelCopyWithImpl<_$_PermissionStateModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PermissionStateModelToJson(
      this,
    );
  }
}

abstract class _PermissionStateModel implements PermissionStateModel {
  const factory _PermissionStateModel(
      {final bool notification,
      final bool isNotificationDeniedByUser}) = _$_PermissionStateModel;

  factory _PermissionStateModel.fromJson(Map<String, dynamic> json) =
      _$_PermissionStateModel.fromJson;

  @override
  bool get notification;
  @override
  bool get isNotificationDeniedByUser;
  @override
  @JsonKey(ignore: true)
  _$$_PermissionStateModelCopyWith<_$_PermissionStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}
