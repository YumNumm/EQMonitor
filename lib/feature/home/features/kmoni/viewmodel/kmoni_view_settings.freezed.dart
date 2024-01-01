// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kmoni_view_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KmoniSettingsState _$KmoniSettingsStateFromJson(Map<String, dynamic> json) {
  return _KmoniSettingsState.fromJson(json);
}

/// @nodoc
mixin _$KmoniSettingsState {
// 設定
  /// 震度0以上のみ表示するかどうか
  /// 震度0-1: グレーで表示
  /// 震度1-: isShowIntensityIcon が true の場合はアイコンを表示
  /// 震度1-: isShowIntensityIcon が false の場合は色で表示
  bool get isUpper0Only => throw _privateConstructorUsedError;

  /// 震度アイコンを表示するかどうか
  bool get isShowIntensityIcon => throw _privateConstructorUsedError;

  /// 強震モニタを使用するかどうか
  bool get useKmoni => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KmoniSettingsStateCopyWith<KmoniSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KmoniSettingsStateCopyWith<$Res> {
  factory $KmoniSettingsStateCopyWith(
          KmoniSettingsState value, $Res Function(KmoniSettingsState) then) =
      _$KmoniSettingsStateCopyWithImpl<$Res, KmoniSettingsState>;
  @useResult
  $Res call({bool isUpper0Only, bool isShowIntensityIcon, bool useKmoni});
}

/// @nodoc
class _$KmoniSettingsStateCopyWithImpl<$Res, $Val extends KmoniSettingsState>
    implements $KmoniSettingsStateCopyWith<$Res> {
  _$KmoniSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isUpper0Only = null,
    Object? isShowIntensityIcon = null,
    Object? useKmoni = null,
  }) {
    return _then(_value.copyWith(
      isUpper0Only: null == isUpper0Only
          ? _value.isUpper0Only
          : isUpper0Only // ignore: cast_nullable_to_non_nullable
              as bool,
      isShowIntensityIcon: null == isShowIntensityIcon
          ? _value.isShowIntensityIcon
          : isShowIntensityIcon // ignore: cast_nullable_to_non_nullable
              as bool,
      useKmoni: null == useKmoni
          ? _value.useKmoni
          : useKmoni // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KmoniSettingsStateImplCopyWith<$Res>
    implements $KmoniSettingsStateCopyWith<$Res> {
  factory _$$KmoniSettingsStateImplCopyWith(_$KmoniSettingsStateImpl value,
          $Res Function(_$KmoniSettingsStateImpl) then) =
      __$$KmoniSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isUpper0Only, bool isShowIntensityIcon, bool useKmoni});
}

/// @nodoc
class __$$KmoniSettingsStateImplCopyWithImpl<$Res>
    extends _$KmoniSettingsStateCopyWithImpl<$Res, _$KmoniSettingsStateImpl>
    implements _$$KmoniSettingsStateImplCopyWith<$Res> {
  __$$KmoniSettingsStateImplCopyWithImpl(_$KmoniSettingsStateImpl _value,
      $Res Function(_$KmoniSettingsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isUpper0Only = null,
    Object? isShowIntensityIcon = null,
    Object? useKmoni = null,
  }) {
    return _then(_$KmoniSettingsStateImpl(
      isUpper0Only: null == isUpper0Only
          ? _value.isUpper0Only
          : isUpper0Only // ignore: cast_nullable_to_non_nullable
              as bool,
      isShowIntensityIcon: null == isShowIntensityIcon
          ? _value.isShowIntensityIcon
          : isShowIntensityIcon // ignore: cast_nullable_to_non_nullable
              as bool,
      useKmoni: null == useKmoni
          ? _value.useKmoni
          : useKmoni // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KmoniSettingsStateImpl implements _KmoniSettingsState {
  const _$KmoniSettingsStateImpl(
      {this.isUpper0Only = false,
      this.isShowIntensityIcon = false,
      this.useKmoni = false});

  factory _$KmoniSettingsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$KmoniSettingsStateImplFromJson(json);

// 設定
  /// 震度0以上のみ表示するかどうか
  /// 震度0-1: グレーで表示
  /// 震度1-: isShowIntensityIcon が true の場合はアイコンを表示
  /// 震度1-: isShowIntensityIcon が false の場合は色で表示
  @override
  @JsonKey()
  final bool isUpper0Only;

  /// 震度アイコンを表示するかどうか
  @override
  @JsonKey()
  final bool isShowIntensityIcon;

  /// 強震モニタを使用するかどうか
  @override
  @JsonKey()
  final bool useKmoni;

  @override
  String toString() {
    return 'KmoniSettingsState(isUpper0Only: $isUpper0Only, isShowIntensityIcon: $isShowIntensityIcon, useKmoni: $useKmoni)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KmoniSettingsStateImpl &&
            (identical(other.isUpper0Only, isUpper0Only) ||
                other.isUpper0Only == isUpper0Only) &&
            (identical(other.isShowIntensityIcon, isShowIntensityIcon) ||
                other.isShowIntensityIcon == isShowIntensityIcon) &&
            (identical(other.useKmoni, useKmoni) ||
                other.useKmoni == useKmoni));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isUpper0Only, isShowIntensityIcon, useKmoni);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KmoniSettingsStateImplCopyWith<_$KmoniSettingsStateImpl> get copyWith =>
      __$$KmoniSettingsStateImplCopyWithImpl<_$KmoniSettingsStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KmoniSettingsStateImplToJson(
      this,
    );
  }
}

abstract class _KmoniSettingsState implements KmoniSettingsState {
  const factory _KmoniSettingsState(
      {final bool isUpper0Only,
      final bool isShowIntensityIcon,
      final bool useKmoni}) = _$KmoniSettingsStateImpl;

  factory _KmoniSettingsState.fromJson(Map<String, dynamic> json) =
      _$KmoniSettingsStateImpl.fromJson;

  @override // 設定
  /// 震度0以上のみ表示するかどうか
  /// 震度0-1: グレーで表示
  /// 震度1-: isShowIntensityIcon が true の場合はアイコンを表示
  /// 震度1-: isShowIntensityIcon が false の場合は色で表示
  bool get isUpper0Only;
  @override

  /// 震度アイコンを表示するかどうか
  bool get isShowIntensityIcon;
  @override

  /// 強震モニタを使用するかどうか
  bool get useKmoni;
  @override
  @JsonKey(ignore: true)
  _$$KmoniSettingsStateImplCopyWith<_$KmoniSettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
