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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$CrashlyticsSettingModelImplCopyWith<$Res>
    implements $CrashlyticsSettingModelCopyWith<$Res> {
  factory _$$CrashlyticsSettingModelImplCopyWith(
          _$CrashlyticsSettingModelImpl value,
          $Res Function(_$CrashlyticsSettingModelImpl) then) =
      __$$CrashlyticsSettingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isEnabled});
}

/// @nodoc
class __$$CrashlyticsSettingModelImplCopyWithImpl<$Res>
    extends _$CrashlyticsSettingModelCopyWithImpl<$Res,
        _$CrashlyticsSettingModelImpl>
    implements _$$CrashlyticsSettingModelImplCopyWith<$Res> {
  __$$CrashlyticsSettingModelImplCopyWithImpl(
      _$CrashlyticsSettingModelImpl _value,
      $Res Function(_$CrashlyticsSettingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
  }) {
    return _then(_$CrashlyticsSettingModelImpl(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CrashlyticsSettingModelImpl implements _CrashlyticsSettingModel {
  const _$CrashlyticsSettingModelImpl({this.isEnabled = true});

  factory _$CrashlyticsSettingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CrashlyticsSettingModelImplFromJson(json);

  @override
  @JsonKey()
  final bool isEnabled;

  @override
  String toString() {
    return 'CrashlyticsSettingModel(isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CrashlyticsSettingModelImpl &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CrashlyticsSettingModelImplCopyWith<_$CrashlyticsSettingModelImpl>
      get copyWith => __$$CrashlyticsSettingModelImplCopyWithImpl<
          _$CrashlyticsSettingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CrashlyticsSettingModelImplToJson(
      this,
    );
  }
}

abstract class _CrashlyticsSettingModel implements CrashlyticsSettingModel {
  const factory _CrashlyticsSettingModel({final bool isEnabled}) =
      _$CrashlyticsSettingModelImpl;

  factory _CrashlyticsSettingModel.fromJson(Map<String, dynamic> json) =
      _$CrashlyticsSettingModelImpl.fromJson;

  @override
  bool get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$CrashlyticsSettingModelImplCopyWith<_$CrashlyticsSettingModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
