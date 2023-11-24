// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifiication_settings_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationSettingsState _$NotificationSettingsStateFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsState.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsState {
  bool get isNotificatioonPermissionAllowed =>
      throw _privateConstructorUsedError;

  /// 地震・津波に関するお知らせ
  bool get isVzse40Subscribed => throw _privateConstructorUsedError;

  /// お知らせ
  bool get isNoticeSubscribed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationSettingsStateCopyWith<NotificationSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsStateCopyWith<$Res> {
  factory $NotificationSettingsStateCopyWith(NotificationSettingsState value,
          $Res Function(NotificationSettingsState) then) =
      _$NotificationSettingsStateCopyWithImpl<$Res, NotificationSettingsState>;
  @useResult
  $Res call(
      {bool isNotificatioonPermissionAllowed,
      bool isVzse40Subscribed,
      bool isNoticeSubscribed});
}

/// @nodoc
class _$NotificationSettingsStateCopyWithImpl<$Res,
        $Val extends NotificationSettingsState>
    implements $NotificationSettingsStateCopyWith<$Res> {
  _$NotificationSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isNotificatioonPermissionAllowed = null,
    Object? isVzse40Subscribed = null,
    Object? isNoticeSubscribed = null,
  }) {
    return _then(_value.copyWith(
      isNotificatioonPermissionAllowed: null == isNotificatioonPermissionAllowed
          ? _value.isNotificatioonPermissionAllowed
          : isNotificatioonPermissionAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      isVzse40Subscribed: null == isVzse40Subscribed
          ? _value.isVzse40Subscribed
          : isVzse40Subscribed // ignore: cast_nullable_to_non_nullable
              as bool,
      isNoticeSubscribed: null == isNoticeSubscribed
          ? _value.isNoticeSubscribed
          : isNoticeSubscribed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsStateImplCopyWith<$Res>
    implements $NotificationSettingsStateCopyWith<$Res> {
  factory _$$NotificationSettingsStateImplCopyWith(
          _$NotificationSettingsStateImpl value,
          $Res Function(_$NotificationSettingsStateImpl) then) =
      __$$NotificationSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isNotificatioonPermissionAllowed,
      bool isVzse40Subscribed,
      bool isNoticeSubscribed});
}

/// @nodoc
class __$$NotificationSettingsStateImplCopyWithImpl<$Res>
    extends _$NotificationSettingsStateCopyWithImpl<$Res,
        _$NotificationSettingsStateImpl>
    implements _$$NotificationSettingsStateImplCopyWith<$Res> {
  __$$NotificationSettingsStateImplCopyWithImpl(
      _$NotificationSettingsStateImpl _value,
      $Res Function(_$NotificationSettingsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isNotificatioonPermissionAllowed = null,
    Object? isVzse40Subscribed = null,
    Object? isNoticeSubscribed = null,
  }) {
    return _then(_$NotificationSettingsStateImpl(
      isNotificatioonPermissionAllowed: null == isNotificatioonPermissionAllowed
          ? _value.isNotificatioonPermissionAllowed
          : isNotificatioonPermissionAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      isVzse40Subscribed: null == isVzse40Subscribed
          ? _value.isVzse40Subscribed
          : isVzse40Subscribed // ignore: cast_nullable_to_non_nullable
              as bool,
      isNoticeSubscribed: null == isNoticeSubscribed
          ? _value.isNoticeSubscribed
          : isNoticeSubscribed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsStateImpl implements _NotificationSettingsState {
  const _$NotificationSettingsStateImpl(
      {required this.isNotificatioonPermissionAllowed,
      required this.isVzse40Subscribed,
      required this.isNoticeSubscribed});

  factory _$NotificationSettingsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsStateImplFromJson(json);

  @override
  final bool isNotificatioonPermissionAllowed;

  /// 地震・津波に関するお知らせ
  @override
  final bool isVzse40Subscribed;

  /// お知らせ
  @override
  final bool isNoticeSubscribed;

  @override
  String toString() {
    return 'NotificationSettingsState(isNotificatioonPermissionAllowed: $isNotificatioonPermissionAllowed, isVzse40Subscribed: $isVzse40Subscribed, isNoticeSubscribed: $isNoticeSubscribed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsStateImpl &&
            (identical(other.isNotificatioonPermissionAllowed,
                    isNotificatioonPermissionAllowed) ||
                other.isNotificatioonPermissionAllowed ==
                    isNotificatioonPermissionAllowed) &&
            (identical(other.isVzse40Subscribed, isVzse40Subscribed) ||
                other.isVzse40Subscribed == isVzse40Subscribed) &&
            (identical(other.isNoticeSubscribed, isNoticeSubscribed) ||
                other.isNoticeSubscribed == isNoticeSubscribed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isNotificatioonPermissionAllowed,
      isVzse40Subscribed, isNoticeSubscribed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsStateImplCopyWith<_$NotificationSettingsStateImpl>
      get copyWith => __$$NotificationSettingsStateImplCopyWithImpl<
          _$NotificationSettingsStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsStateImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsState implements NotificationSettingsState {
  const factory _NotificationSettingsState(
          {required final bool isNotificatioonPermissionAllowed,
          required final bool isVzse40Subscribed,
          required final bool isNoticeSubscribed}) =
      _$NotificationSettingsStateImpl;

  factory _NotificationSettingsState.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsStateImpl.fromJson;

  @override
  bool get isNotificatioonPermissionAllowed;
  @override

  /// 地震・津波に関するお知らせ
  bool get isVzse40Subscribed;
  @override

  /// お知らせ
  bool get isNoticeSubscribed;
  @override
  @JsonKey(ignore: true)
  _$$NotificationSettingsStateImplCopyWith<_$NotificationSettingsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
