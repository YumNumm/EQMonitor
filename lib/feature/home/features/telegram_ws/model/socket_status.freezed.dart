// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'socket_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SocketStatusModel _$SocketStatusModelFromJson(Map<String, dynamic> json) {
  return _SocketStatusModel.fromJson(json);
}

/// @nodoc
mixin _$SocketStatusModel {
  bool get connected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SocketStatusModelCopyWith<SocketStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocketStatusModelCopyWith<$Res> {
  factory $SocketStatusModelCopyWith(
          SocketStatusModel value, $Res Function(SocketStatusModel) then) =
      _$SocketStatusModelCopyWithImpl<$Res, SocketStatusModel>;
  @useResult
  $Res call({bool connected});
}

/// @nodoc
class _$SocketStatusModelCopyWithImpl<$Res, $Val extends SocketStatusModel>
    implements $SocketStatusModelCopyWith<$Res> {
  _$SocketStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connected = null,
  }) {
    return _then(_value.copyWith(
      connected: null == connected
          ? _value.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SocketStatusModelImplCopyWith<$Res>
    implements $SocketStatusModelCopyWith<$Res> {
  factory _$$SocketStatusModelImplCopyWith(_$SocketStatusModelImpl value,
          $Res Function(_$SocketStatusModelImpl) then) =
      __$$SocketStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool connected});
}

/// @nodoc
class __$$SocketStatusModelImplCopyWithImpl<$Res>
    extends _$SocketStatusModelCopyWithImpl<$Res, _$SocketStatusModelImpl>
    implements _$$SocketStatusModelImplCopyWith<$Res> {
  __$$SocketStatusModelImplCopyWithImpl(_$SocketStatusModelImpl _value,
      $Res Function(_$SocketStatusModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connected = null,
  }) {
    return _then(_$SocketStatusModelImpl(
      connected: null == connected
          ? _value.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SocketStatusModelImpl implements _SocketStatusModel {
  const _$SocketStatusModelImpl({this.connected = false});

  factory _$SocketStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocketStatusModelImplFromJson(json);

  @override
  @JsonKey()
  final bool connected;

  @override
  String toString() {
    return 'SocketStatusModel(connected: $connected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocketStatusModelImpl &&
            (identical(other.connected, connected) ||
                other.connected == connected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, connected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocketStatusModelImplCopyWith<_$SocketStatusModelImpl> get copyWith =>
      __$$SocketStatusModelImplCopyWithImpl<_$SocketStatusModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SocketStatusModelImplToJson(
      this,
    );
  }
}

abstract class _SocketStatusModel implements SocketStatusModel {
  const factory _SocketStatusModel({final bool connected}) =
      _$SocketStatusModelImpl;

  factory _SocketStatusModel.fromJson(Map<String, dynamic> json) =
      _$SocketStatusModelImpl.fromJson;

  @override
  bool get connected;
  @override
  @JsonKey(ignore: true)
  _$$SocketStatusModelImplCopyWith<_$SocketStatusModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
