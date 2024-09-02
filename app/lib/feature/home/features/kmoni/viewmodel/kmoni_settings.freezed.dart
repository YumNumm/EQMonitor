// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kmoni_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KmoniSettingsState _$KmoniSettingsStateFromJson(Map<String, dynamic> json) {
  return _KmoniSettingsState.fromJson(json);
}

/// @nodoc
mixin _$KmoniSettingsState {
  /// 強震モニタの表示最低リアルタイム震度
  double? get minRealtimeShindo => throw _privateConstructorUsedError;

  /// スケールを表示するかどうか
  bool get showRealtimeShindoScale => throw _privateConstructorUsedError;

  /// 強震モニタを使用するかどうか
  bool get useKmoni => throw _privateConstructorUsedError;

  /// Serializes this KmoniSettingsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KmoniSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KmoniSettingsStateCopyWith<KmoniSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KmoniSettingsStateCopyWith<$Res> {
  factory $KmoniSettingsStateCopyWith(
          KmoniSettingsState value, $Res Function(KmoniSettingsState) then) =
      _$KmoniSettingsStateCopyWithImpl<$Res, KmoniSettingsState>;
  @useResult
  $Res call(
      {double? minRealtimeShindo, bool showRealtimeShindoScale, bool useKmoni});
}

/// @nodoc
class _$KmoniSettingsStateCopyWithImpl<$Res, $Val extends KmoniSettingsState>
    implements $KmoniSettingsStateCopyWith<$Res> {
  _$KmoniSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KmoniSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minRealtimeShindo = freezed,
    Object? showRealtimeShindoScale = null,
    Object? useKmoni = null,
  }) {
    return _then(_value.copyWith(
      minRealtimeShindo: freezed == minRealtimeShindo
          ? _value.minRealtimeShindo
          : minRealtimeShindo // ignore: cast_nullable_to_non_nullable
              as double?,
      showRealtimeShindoScale: null == showRealtimeShindoScale
          ? _value.showRealtimeShindoScale
          : showRealtimeShindoScale // ignore: cast_nullable_to_non_nullable
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
  $Res call(
      {double? minRealtimeShindo, bool showRealtimeShindoScale, bool useKmoni});
}

/// @nodoc
class __$$KmoniSettingsStateImplCopyWithImpl<$Res>
    extends _$KmoniSettingsStateCopyWithImpl<$Res, _$KmoniSettingsStateImpl>
    implements _$$KmoniSettingsStateImplCopyWith<$Res> {
  __$$KmoniSettingsStateImplCopyWithImpl(_$KmoniSettingsStateImpl _value,
      $Res Function(_$KmoniSettingsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of KmoniSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minRealtimeShindo = freezed,
    Object? showRealtimeShindoScale = null,
    Object? useKmoni = null,
  }) {
    return _then(_$KmoniSettingsStateImpl(
      minRealtimeShindo: freezed == minRealtimeShindo
          ? _value.minRealtimeShindo
          : minRealtimeShindo // ignore: cast_nullable_to_non_nullable
              as double?,
      showRealtimeShindoScale: null == showRealtimeShindoScale
          ? _value.showRealtimeShindoScale
          : showRealtimeShindoScale // ignore: cast_nullable_to_non_nullable
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
      {this.minRealtimeShindo = null,
      this.showRealtimeShindoScale = true,
      this.useKmoni = false});

  factory _$KmoniSettingsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$KmoniSettingsStateImplFromJson(json);

  /// 強震モニタの表示最低リアルタイム震度
  @override
  @JsonKey()
  final double? minRealtimeShindo;

  /// スケールを表示するかどうか
  @override
  @JsonKey()
  final bool showRealtimeShindoScale;

  /// 強震モニタを使用するかどうか
  @override
  @JsonKey()
  final bool useKmoni;

  @override
  String toString() {
    return 'KmoniSettingsState(minRealtimeShindo: $minRealtimeShindo, showRealtimeShindoScale: $showRealtimeShindoScale, useKmoni: $useKmoni)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KmoniSettingsStateImpl &&
            (identical(other.minRealtimeShindo, minRealtimeShindo) ||
                other.minRealtimeShindo == minRealtimeShindo) &&
            (identical(
                    other.showRealtimeShindoScale, showRealtimeShindoScale) ||
                other.showRealtimeShindoScale == showRealtimeShindoScale) &&
            (identical(other.useKmoni, useKmoni) ||
                other.useKmoni == useKmoni));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, minRealtimeShindo, showRealtimeShindoScale, useKmoni);

  /// Create a copy of KmoniSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {final double? minRealtimeShindo,
      final bool showRealtimeShindoScale,
      final bool useKmoni}) = _$KmoniSettingsStateImpl;

  factory _KmoniSettingsState.fromJson(Map<String, dynamic> json) =
      _$KmoniSettingsStateImpl.fromJson;

  /// 強震モニタの表示最低リアルタイム震度
  @override
  double? get minRealtimeShindo;

  /// スケールを表示するかどうか
  @override
  bool get showRealtimeShindoScale;

  /// 強震モニタを使用するかどうか
  @override
  bool get useKmoni;

  /// Create a copy of KmoniSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KmoniSettingsStateImplCopyWith<_$KmoniSettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
