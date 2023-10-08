// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crashlytics_setting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CrashlyticsSettingModel _$CrashlyticsSettingModelFromJson(
    Map<String, dynamic> json) {
  return _CrashlyticsSettingModel.fromJson(json);
}

/// @nodoc
mixin _$CrashlyticsSettingModel {
  bool get isEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CrashlyticsSettingModelCopyWith<CrashlyticsSettingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrashlyticsSettingModelCopyWith<$Res> {
  factory $CrashlyticsSettingModelCopyWith(CrashlyticsSettingModel value,
          $Res Function(CrashlyticsSettingModel) then) =
      _$CrashlyticsSettingModelCopyWithImpl<$Res, CrashlyticsSettingModel>;
  @useResult
  $Res call({bool isEnabled});
}

/// @nodoc
class _$CrashlyticsSettingModelCopyWithImpl<$Res,
        $Val extends CrashlyticsSettingModel>
    implements $CrashlyticsSettingModelCopyWith<$Res> {
  _$CrashlyticsSettingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
  }) {
    return _then(_value.copyWith(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CrashlyticsSettingModelCopyWith<$Res>
    implements $CrashlyticsSettingModelCopyWith<$Res> {
  factory _$$_CrashlyticsSettingModelCopyWith(_$_CrashlyticsSettingModel value,
          $Res Function(_$_CrashlyticsSettingModel) then) =
      __$$_CrashlyticsSettingModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isEnabled});
}

/// @nodoc
class __$$_CrashlyticsSettingModelCopyWithImpl<$Res>
    extends _$CrashlyticsSettingModelCopyWithImpl<$Res,
        _$_CrashlyticsSettingModel>
    implements _$$_CrashlyticsSettingModelCopyWith<$Res> {
  __$$_CrashlyticsSettingModelCopyWithImpl(_$_CrashlyticsSettingModel _value,
      $Res Function(_$_CrashlyticsSettingModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
  }) {
    return _then(_$_CrashlyticsSettingModel(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CrashlyticsSettingModel implements _CrashlyticsSettingModel {
  const _$_CrashlyticsSettingModel({this.isEnabled = true});

  factory _$_CrashlyticsSettingModel.fromJson(Map<String, dynamic> json) =>
      _$$_CrashlyticsSettingModelFromJson(json);

  @override
  @JsonKey()
  final bool isEnabled;

  @override
  String toString() {
    return 'CrashlyticsSettingModel(isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CrashlyticsSettingModel &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CrashlyticsSettingModelCopyWith<_$_CrashlyticsSettingModel>
      get copyWith =>
          __$$_CrashlyticsSettingModelCopyWithImpl<_$_CrashlyticsSettingModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CrashlyticsSettingModelToJson(
      this,
    );
  }
}

abstract class _CrashlyticsSettingModel implements CrashlyticsSettingModel {
  const factory _CrashlyticsSettingModel({final bool isEnabled}) =
      _$_CrashlyticsSettingModel;

  factory _CrashlyticsSettingModel.fromJson(Map<String, dynamic> json) =
      _$_CrashlyticsSettingModel.fromJson;

  @override
  bool get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$_CrashlyticsSettingModelCopyWith<_$_CrashlyticsSettingModel>
      get copyWith => throw _privateConstructorUsedError;
}
