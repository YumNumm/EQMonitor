// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ntp_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NtpStateModel _$NtpStateModelFromJson(Map<String, dynamic> json) {
  return _NtpStateModel.fromJson(json);
}

/// @nodoc
mixin _$NtpStateModel {
  int? get offset => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NtpStateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NtpStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NtpStateModelCopyWith<NtpStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NtpStateModelCopyWith<$Res> {
  factory $NtpStateModelCopyWith(
          NtpStateModel value, $Res Function(NtpStateModel) then) =
      _$NtpStateModelCopyWithImpl<$Res, NtpStateModel>;
  @useResult
  $Res call({int? offset, DateTime? updatedAt});
}

/// @nodoc
class _$NtpStateModelCopyWithImpl<$Res, $Val extends NtpStateModel>
    implements $NtpStateModelCopyWith<$Res> {
  _$NtpStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NtpStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NtpStateModelImplCopyWith<$Res>
    implements $NtpStateModelCopyWith<$Res> {
  factory _$$NtpStateModelImplCopyWith(
          _$NtpStateModelImpl value, $Res Function(_$NtpStateModelImpl) then) =
      __$$NtpStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? offset, DateTime? updatedAt});
}

/// @nodoc
class __$$NtpStateModelImplCopyWithImpl<$Res>
    extends _$NtpStateModelCopyWithImpl<$Res, _$NtpStateModelImpl>
    implements _$$NtpStateModelImplCopyWith<$Res> {
  __$$NtpStateModelImplCopyWithImpl(
      _$NtpStateModelImpl _value, $Res Function(_$NtpStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NtpStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NtpStateModelImpl(
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NtpStateModelImpl implements _NtpStateModel {
  const _$NtpStateModelImpl({this.offset, this.updatedAt});

  factory _$NtpStateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NtpStateModelImplFromJson(json);

  @override
  final int? offset;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'NtpStateModel(offset: $offset, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NtpStateModelImpl &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, offset, updatedAt);

  /// Create a copy of NtpStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NtpStateModelImplCopyWith<_$NtpStateModelImpl> get copyWith =>
      __$$NtpStateModelImplCopyWithImpl<_$NtpStateModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NtpStateModelImplToJson(
      this,
    );
  }
}

abstract class _NtpStateModel implements NtpStateModel {
  const factory _NtpStateModel({final int? offset, final DateTime? updatedAt}) =
      _$NtpStateModelImpl;

  factory _NtpStateModel.fromJson(Map<String, dynamic> json) =
      _$NtpStateModelImpl.fromJson;

  @override
  int? get offset;
  @override
  DateTime? get updatedAt;

  /// Create a copy of NtpStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NtpStateModelImplCopyWith<_$NtpStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
