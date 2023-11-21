// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_ws_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TelegramWsModel _$TelegramWsModelFromJson(Map<String, dynamic> json) {
  return _TelegramWsModel.fromJson(json);
}

/// @nodoc
mixin _$TelegramWsModel {
  @JsonKey(fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
  Stream<TelegramV3> get telegramStream => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramWsModelCopyWith<TelegramWsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramWsModelCopyWith<$Res> {
  factory $TelegramWsModelCopyWith(
          TelegramWsModel value, $Res Function(TelegramWsModel) then) =
      _$TelegramWsModelCopyWithImpl<$Res, TelegramWsModel>;
  @useResult
  $Res call(
      {@JsonKey(
          fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
      Stream<TelegramV3> telegramStream});
}

/// @nodoc
class _$TelegramWsModelCopyWithImpl<$Res, $Val extends TelegramWsModel>
    implements $TelegramWsModelCopyWith<$Res> {
  _$TelegramWsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telegramStream = null,
  }) {
    return _then(_value.copyWith(
      telegramStream: null == telegramStream
          ? _value.telegramStream
          : telegramStream // ignore: cast_nullable_to_non_nullable
              as Stream<TelegramV3>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TelegramWsModelImplCopyWith<$Res>
    implements $TelegramWsModelCopyWith<$Res> {
  factory _$$TelegramWsModelImplCopyWith(_$TelegramWsModelImpl value,
          $Res Function(_$TelegramWsModelImpl) then) =
      __$$TelegramWsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
      Stream<TelegramV3> telegramStream});
}

/// @nodoc
class __$$TelegramWsModelImplCopyWithImpl<$Res>
    extends _$TelegramWsModelCopyWithImpl<$Res, _$TelegramWsModelImpl>
    implements _$$TelegramWsModelImplCopyWith<$Res> {
  __$$TelegramWsModelImplCopyWithImpl(
      _$TelegramWsModelImpl _value, $Res Function(_$TelegramWsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telegramStream = null,
  }) {
    return _then(_$TelegramWsModelImpl(
      telegramStream: null == telegramStream
          ? _value.telegramStream
          : telegramStream // ignore: cast_nullable_to_non_nullable
              as Stream<TelegramV3>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TelegramWsModelImpl implements _TelegramWsModel {
  const _$TelegramWsModelImpl(
      {@JsonKey(
          fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
      required this.telegramStream});

  factory _$TelegramWsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TelegramWsModelImplFromJson(json);

  @override
  @JsonKey(fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
  final Stream<TelegramV3> telegramStream;

  @override
  String toString() {
    return 'TelegramWsModel(telegramStream: $telegramStream)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TelegramWsModelImpl &&
            (identical(other.telegramStream, telegramStream) ||
                other.telegramStream == telegramStream));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, telegramStream);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TelegramWsModelImplCopyWith<_$TelegramWsModelImpl> get copyWith =>
      __$$TelegramWsModelImplCopyWithImpl<_$TelegramWsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TelegramWsModelImplToJson(
      this,
    );
  }
}

abstract class _TelegramWsModel implements TelegramWsModel {
  const factory _TelegramWsModel(
          {@JsonKey(
              fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
          required final Stream<TelegramV3> telegramStream}) =
      _$TelegramWsModelImpl;

  factory _TelegramWsModel.fromJson(Map<String, dynamic> json) =
      _$TelegramWsModelImpl.fromJson;

  @override
  @JsonKey(fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
  Stream<TelegramV3> get telegramStream;
  @override
  @JsonKey(ignore: true)
  _$$TelegramWsModelImplCopyWith<_$TelegramWsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
