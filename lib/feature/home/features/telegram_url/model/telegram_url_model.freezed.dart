// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_url_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TelegramUrlModel _$TelegramUrlModelFromJson(Map<String, dynamic> json) {
  return _TelegramUrlModel.fromJson(json);
}

/// @nodoc
mixin _$TelegramUrlModel {
  String get restApiUrl => throw _privateConstructorUsedError;
  String get wsApiUrl => throw _privateConstructorUsedError;
  String? get apiAuthorization => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramUrlModelCopyWith<TelegramUrlModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramUrlModelCopyWith<$Res> {
  factory $TelegramUrlModelCopyWith(
          TelegramUrlModel value, $Res Function(TelegramUrlModel) then) =
      _$TelegramUrlModelCopyWithImpl<$Res, TelegramUrlModel>;
  @useResult
  $Res call({String restApiUrl, String wsApiUrl, String? apiAuthorization});
}

/// @nodoc
class _$TelegramUrlModelCopyWithImpl<$Res, $Val extends TelegramUrlModel>
    implements $TelegramUrlModelCopyWith<$Res> {
  _$TelegramUrlModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restApiUrl = null,
    Object? wsApiUrl = null,
    Object? apiAuthorization = freezed,
  }) {
    return _then(_value.copyWith(
      restApiUrl: null == restApiUrl
          ? _value.restApiUrl
          : restApiUrl // ignore: cast_nullable_to_non_nullable
              as String,
      wsApiUrl: null == wsApiUrl
          ? _value.wsApiUrl
          : wsApiUrl // ignore: cast_nullable_to_non_nullable
              as String,
      apiAuthorization: freezed == apiAuthorization
          ? _value.apiAuthorization
          : apiAuthorization // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TelegramUrlModelCopyWith<$Res>
    implements $TelegramUrlModelCopyWith<$Res> {
  factory _$$_TelegramUrlModelCopyWith(
          _$_TelegramUrlModel value, $Res Function(_$_TelegramUrlModel) then) =
      __$$_TelegramUrlModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String restApiUrl, String wsApiUrl, String? apiAuthorization});
}

/// @nodoc
class __$$_TelegramUrlModelCopyWithImpl<$Res>
    extends _$TelegramUrlModelCopyWithImpl<$Res, _$_TelegramUrlModel>
    implements _$$_TelegramUrlModelCopyWith<$Res> {
  __$$_TelegramUrlModelCopyWithImpl(
      _$_TelegramUrlModel _value, $Res Function(_$_TelegramUrlModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restApiUrl = null,
    Object? wsApiUrl = null,
    Object? apiAuthorization = freezed,
  }) {
    return _then(_$_TelegramUrlModel(
      restApiUrl: null == restApiUrl
          ? _value.restApiUrl
          : restApiUrl // ignore: cast_nullable_to_non_nullable
              as String,
      wsApiUrl: null == wsApiUrl
          ? _value.wsApiUrl
          : wsApiUrl // ignore: cast_nullable_to_non_nullable
              as String,
      apiAuthorization: freezed == apiAuthorization
          ? _value.apiAuthorization
          : apiAuthorization // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramUrlModel implements _TelegramUrlModel {
  const _$_TelegramUrlModel(
      {required this.restApiUrl,
      required this.wsApiUrl,
      required this.apiAuthorization});

  factory _$_TelegramUrlModel.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramUrlModelFromJson(json);

  @override
  final String restApiUrl;
  @override
  final String wsApiUrl;
  @override
  final String? apiAuthorization;

  @override
  String toString() {
    return 'TelegramUrlModel(restApiUrl: $restApiUrl, wsApiUrl: $wsApiUrl, apiAuthorization: $apiAuthorization)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramUrlModel &&
            (identical(other.restApiUrl, restApiUrl) ||
                other.restApiUrl == restApiUrl) &&
            (identical(other.wsApiUrl, wsApiUrl) ||
                other.wsApiUrl == wsApiUrl) &&
            (identical(other.apiAuthorization, apiAuthorization) ||
                other.apiAuthorization == apiAuthorization));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, restApiUrl, wsApiUrl, apiAuthorization);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramUrlModelCopyWith<_$_TelegramUrlModel> get copyWith =>
      __$$_TelegramUrlModelCopyWithImpl<_$_TelegramUrlModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramUrlModelToJson(
      this,
    );
  }
}

abstract class _TelegramUrlModel implements TelegramUrlModel {
  const factory _TelegramUrlModel(
      {required final String restApiUrl,
      required final String wsApiUrl,
      required final String? apiAuthorization}) = _$_TelegramUrlModel;

  factory _TelegramUrlModel.fromJson(Map<String, dynamic> json) =
      _$_TelegramUrlModel.fromJson;

  @override
  String get restApiUrl;
  @override
  String get wsApiUrl;
  @override
  String? get apiAuthorization;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramUrlModelCopyWith<_$_TelegramUrlModel> get copyWith =>
      throw _privateConstructorUsedError;
}
