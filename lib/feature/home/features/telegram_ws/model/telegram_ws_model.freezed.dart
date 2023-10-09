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
abstract class _$$_TelegramWsModelCopyWith<$Res>
    implements $TelegramWsModelCopyWith<$Res> {
  factory _$$_TelegramWsModelCopyWith(
          _$_TelegramWsModel value, $Res Function(_$_TelegramWsModel) then) =
      __$$_TelegramWsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
      Stream<TelegramV3> telegramStream});
}

/// @nodoc
class __$$_TelegramWsModelCopyWithImpl<$Res>
    extends _$TelegramWsModelCopyWithImpl<$Res, _$_TelegramWsModel>
    implements _$$_TelegramWsModelCopyWith<$Res> {
  __$$_TelegramWsModelCopyWithImpl(
      _$_TelegramWsModel _value, $Res Function(_$_TelegramWsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telegramStream = null,
  }) {
    return _then(_$_TelegramWsModel(
      telegramStream: null == telegramStream
          ? _value.telegramStream
          : telegramStream // ignore: cast_nullable_to_non_nullable
              as Stream<TelegramV3>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramWsModel implements _TelegramWsModel {
  const _$_TelegramWsModel(
      {@JsonKey(
          fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
      required this.telegramStream});

  factory _$_TelegramWsModel.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramWsModelFromJson(json);

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
            other is _$_TelegramWsModel &&
            (identical(other.telegramStream, telegramStream) ||
                other.telegramStream == telegramStream));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, telegramStream);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramWsModelCopyWith<_$_TelegramWsModel> get copyWith =>
      __$$_TelegramWsModelCopyWithImpl<_$_TelegramWsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramWsModelToJson(
      this,
    );
  }
}

abstract class _TelegramWsModel implements TelegramWsModel {
  const factory _TelegramWsModel(
      {@JsonKey(
          fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
      required final Stream<TelegramV3> telegramStream}) = _$_TelegramWsModel;

  factory _TelegramWsModel.fromJson(Map<String, dynamic> json) =
      _$_TelegramWsModel.fromJson;

  @override
  @JsonKey(fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
  Stream<TelegramV3> get telegramStream;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramWsModelCopyWith<_$_TelegramWsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
