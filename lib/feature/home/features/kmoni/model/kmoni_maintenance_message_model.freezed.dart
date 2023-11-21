// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kmoni_maintenance_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KmoniMaintenanceMessageModel _$KmoniMaintenanceMessageModelFromJson(
    Map<String, dynamic> json) {
  return _KmoniMaintenanceMessageModel.fromJson(json);
}

/// @nodoc
mixin _$KmoniMaintenanceMessageModel {
  String get message => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: kmoniMaintenanceMessageTypeFromJson,
      toJson: kmoniMaintenanceMessageTypeToJson)
  KmoniMaintenanceMessageType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KmoniMaintenanceMessageModelCopyWith<KmoniMaintenanceMessageModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KmoniMaintenanceMessageModelCopyWith<$Res> {
  factory $KmoniMaintenanceMessageModelCopyWith(
          KmoniMaintenanceMessageModel value,
          $Res Function(KmoniMaintenanceMessageModel) then) =
      _$KmoniMaintenanceMessageModelCopyWithImpl<$Res,
          KmoniMaintenanceMessageModel>;
  @useResult
  $Res call(
      {String message,
      @JsonKey(
          fromJson: kmoniMaintenanceMessageTypeFromJson,
          toJson: kmoniMaintenanceMessageTypeToJson)
      KmoniMaintenanceMessageType type});
}

/// @nodoc
class _$KmoniMaintenanceMessageModelCopyWithImpl<$Res,
        $Val extends KmoniMaintenanceMessageModel>
    implements $KmoniMaintenanceMessageModelCopyWith<$Res> {
  _$KmoniMaintenanceMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as KmoniMaintenanceMessageType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KmoniMaintenanceMessageModelImplCopyWith<$Res>
    implements $KmoniMaintenanceMessageModelCopyWith<$Res> {
  factory _$$KmoniMaintenanceMessageModelImplCopyWith(
          _$KmoniMaintenanceMessageModelImpl value,
          $Res Function(_$KmoniMaintenanceMessageModelImpl) then) =
      __$$KmoniMaintenanceMessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      @JsonKey(
          fromJson: kmoniMaintenanceMessageTypeFromJson,
          toJson: kmoniMaintenanceMessageTypeToJson)
      KmoniMaintenanceMessageType type});
}

/// @nodoc
class __$$KmoniMaintenanceMessageModelImplCopyWithImpl<$Res>
    extends _$KmoniMaintenanceMessageModelCopyWithImpl<$Res,
        _$KmoniMaintenanceMessageModelImpl>
    implements _$$KmoniMaintenanceMessageModelImplCopyWith<$Res> {
  __$$KmoniMaintenanceMessageModelImplCopyWithImpl(
      _$KmoniMaintenanceMessageModelImpl _value,
      $Res Function(_$KmoniMaintenanceMessageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
  }) {
    return _then(_$KmoniMaintenanceMessageModelImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as KmoniMaintenanceMessageType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KmoniMaintenanceMessageModelImpl
    implements _KmoniMaintenanceMessageModel {
  const _$KmoniMaintenanceMessageModelImpl(
      {this.message = '',
      @JsonKey(
          fromJson: kmoniMaintenanceMessageTypeFromJson,
          toJson: kmoniMaintenanceMessageTypeToJson)
      this.type = KmoniMaintenanceMessageType.non});

  factory _$KmoniMaintenanceMessageModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$KmoniMaintenanceMessageModelImplFromJson(json);

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey(
      fromJson: kmoniMaintenanceMessageTypeFromJson,
      toJson: kmoniMaintenanceMessageTypeToJson)
  final KmoniMaintenanceMessageType type;

  @override
  String toString() {
    return 'KmoniMaintenanceMessageModel(message: $message, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KmoniMaintenanceMessageModelImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KmoniMaintenanceMessageModelImplCopyWith<
          _$KmoniMaintenanceMessageModelImpl>
      get copyWith => __$$KmoniMaintenanceMessageModelImplCopyWithImpl<
          _$KmoniMaintenanceMessageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KmoniMaintenanceMessageModelImplToJson(
      this,
    );
  }
}

abstract class _KmoniMaintenanceMessageModel
    implements KmoniMaintenanceMessageModel {
  const factory _KmoniMaintenanceMessageModel(
          {final String message,
          @JsonKey(
              fromJson: kmoniMaintenanceMessageTypeFromJson,
              toJson: kmoniMaintenanceMessageTypeToJson)
          final KmoniMaintenanceMessageType type}) =
      _$KmoniMaintenanceMessageModelImpl;

  factory _KmoniMaintenanceMessageModel.fromJson(Map<String, dynamic> json) =
      _$KmoniMaintenanceMessageModelImpl.fromJson;

  @override
  String get message;
  @override
  @JsonKey(
      fromJson: kmoniMaintenanceMessageTypeFromJson,
      toJson: kmoniMaintenanceMessageTypeToJson)
  KmoniMaintenanceMessageType get type;
  @override
  @JsonKey(ignore: true)
  _$$KmoniMaintenanceMessageModelImplCopyWith<
          _$KmoniMaintenanceMessageModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
