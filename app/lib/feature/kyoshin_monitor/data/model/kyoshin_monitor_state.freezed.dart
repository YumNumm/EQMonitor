// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KyoshinMonitorState _$KyoshinMonitorStateFromJson(Map<String, dynamic> json) {
  return _KyoshinMonitorState.fromJson(json);
}

/// @nodoc
mixin _$KyoshinMonitorState {
// 必要フィールドを定義
  String get title => throw _privateConstructorUsedError;

  /// Serializes this KyoshinMonitorState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorStateCopyWith<KyoshinMonitorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorStateCopyWith<$Res> {
  factory $KyoshinMonitorStateCopyWith(
          KyoshinMonitorState value, $Res Function(KyoshinMonitorState) then) =
      _$KyoshinMonitorStateCopyWithImpl<$Res, KyoshinMonitorState>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class _$KyoshinMonitorStateCopyWithImpl<$Res, $Val extends KyoshinMonitorState>
    implements $KyoshinMonitorStateCopyWith<$Res> {
  _$KyoshinMonitorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorStateImplCopyWith<$Res>
    implements $KyoshinMonitorStateCopyWith<$Res> {
  factory _$$KyoshinMonitorStateImplCopyWith(_$KyoshinMonitorStateImpl value,
          $Res Function(_$KyoshinMonitorStateImpl) then) =
      __$$KyoshinMonitorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title});
}

/// @nodoc
class __$$KyoshinMonitorStateImplCopyWithImpl<$Res>
    extends _$KyoshinMonitorStateCopyWithImpl<$Res, _$KyoshinMonitorStateImpl>
    implements _$$KyoshinMonitorStateImplCopyWith<$Res> {
  __$$KyoshinMonitorStateImplCopyWithImpl(_$KyoshinMonitorStateImpl _value,
      $Res Function(_$KyoshinMonitorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of KyoshinMonitorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_$KyoshinMonitorStateImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinMonitorStateImpl implements _KyoshinMonitorState {
  const _$KyoshinMonitorStateImpl({required this.title});

  factory _$KyoshinMonitorStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$KyoshinMonitorStateImplFromJson(json);

// 必要フィールドを定義
  @override
  final String title;

  @override
  String toString() {
    return 'KyoshinMonitorState(title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinMonitorStateImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  /// Create a copy of KyoshinMonitorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorStateImplCopyWith<_$KyoshinMonitorStateImpl> get copyWith =>
      __$$KyoshinMonitorStateImplCopyWithImpl<_$KyoshinMonitorStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinMonitorStateImplToJson(
      this,
    );
  }
}

abstract class _KyoshinMonitorState implements KyoshinMonitorState {
  const factory _KyoshinMonitorState({required final String title}) =
      _$KyoshinMonitorStateImpl;

  factory _KyoshinMonitorState.fromJson(Map<String, dynamic> json) =
      _$KyoshinMonitorStateImpl.fromJson;

// 必要フィールドを定義
  @override
  String get title;

  /// Create a copy of KyoshinMonitorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorStateImplCopyWith<_$KyoshinMonitorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
