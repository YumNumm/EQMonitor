// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_history_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EarthquakeHistoryConfigModel _$EarthquakeHistoryConfigModelFromJson(
    Map<String, dynamic> json) {
  return _EarthquakeHistoryConfigModel.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeHistoryConfigModel {
  EarthquakeHistoryListConfig get list => throw _privateConstructorUsedError;
  EarthquakeHistoryDetailConfig get detail =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeHistoryConfigModelCopyWith<EarthquakeHistoryConfigModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeHistoryConfigModelCopyWith<$Res> {
  factory $EarthquakeHistoryConfigModelCopyWith(
          EarthquakeHistoryConfigModel value,
          $Res Function(EarthquakeHistoryConfigModel) then) =
      _$EarthquakeHistoryConfigModelCopyWithImpl<$Res,
          EarthquakeHistoryConfigModel>;
  @useResult
  $Res call(
      {EarthquakeHistoryListConfig list, EarthquakeHistoryDetailConfig detail});

  $EarthquakeHistoryListConfigCopyWith<$Res> get list;
  $EarthquakeHistoryDetailConfigCopyWith<$Res> get detail;
}

/// @nodoc
class _$EarthquakeHistoryConfigModelCopyWithImpl<$Res,
        $Val extends EarthquakeHistoryConfigModel>
    implements $EarthquakeHistoryConfigModelCopyWith<$Res> {
  _$EarthquakeHistoryConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? detail = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as EarthquakeHistoryListConfig,
      detail: null == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as EarthquakeHistoryDetailConfig,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeHistoryListConfigCopyWith<$Res> get list {
    return $EarthquakeHistoryListConfigCopyWith<$Res>(_value.list, (value) {
      return _then(_value.copyWith(list: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeHistoryDetailConfigCopyWith<$Res> get detail {
    return $EarthquakeHistoryDetailConfigCopyWith<$Res>(_value.detail, (value) {
      return _then(_value.copyWith(detail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EarthquakeHistoryConfigModelImplCopyWith<$Res>
    implements $EarthquakeHistoryConfigModelCopyWith<$Res> {
  factory _$$EarthquakeHistoryConfigModelImplCopyWith(
          _$EarthquakeHistoryConfigModelImpl value,
          $Res Function(_$EarthquakeHistoryConfigModelImpl) then) =
      __$$EarthquakeHistoryConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EarthquakeHistoryListConfig list, EarthquakeHistoryDetailConfig detail});

  @override
  $EarthquakeHistoryListConfigCopyWith<$Res> get list;
  @override
  $EarthquakeHistoryDetailConfigCopyWith<$Res> get detail;
}

/// @nodoc
class __$$EarthquakeHistoryConfigModelImplCopyWithImpl<$Res>
    extends _$EarthquakeHistoryConfigModelCopyWithImpl<$Res,
        _$EarthquakeHistoryConfigModelImpl>
    implements _$$EarthquakeHistoryConfigModelImplCopyWith<$Res> {
  __$$EarthquakeHistoryConfigModelImplCopyWithImpl(
      _$EarthquakeHistoryConfigModelImpl _value,
      $Res Function(_$EarthquakeHistoryConfigModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? detail = null,
  }) {
    return _then(_$EarthquakeHistoryConfigModelImpl(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as EarthquakeHistoryListConfig,
      detail: null == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as EarthquakeHistoryDetailConfig,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeHistoryConfigModelImpl
    implements _EarthquakeHistoryConfigModel {
  const _$EarthquakeHistoryConfigModelImpl(
      {required this.list, required this.detail});

  factory _$EarthquakeHistoryConfigModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EarthquakeHistoryConfigModelImplFromJson(json);

  @override
  final EarthquakeHistoryListConfig list;
  @override
  final EarthquakeHistoryDetailConfig detail;

  @override
  String toString() {
    return 'EarthquakeHistoryConfigModel(list: $list, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeHistoryConfigModelImpl &&
            (identical(other.list, list) || other.list == list) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, list, detail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeHistoryConfigModelImplCopyWith<
          _$EarthquakeHistoryConfigModelImpl>
      get copyWith => __$$EarthquakeHistoryConfigModelImplCopyWithImpl<
          _$EarthquakeHistoryConfigModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeHistoryConfigModelImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeHistoryConfigModel
    implements EarthquakeHistoryConfigModel {
  const factory _EarthquakeHistoryConfigModel(
          {required final EarthquakeHistoryListConfig list,
          required final EarthquakeHistoryDetailConfig detail}) =
      _$EarthquakeHistoryConfigModelImpl;

  factory _EarthquakeHistoryConfigModel.fromJson(Map<String, dynamic> json) =
      _$EarthquakeHistoryConfigModelImpl.fromJson;

  @override
  EarthquakeHistoryListConfig get list;
  @override
  EarthquakeHistoryDetailConfig get detail;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeHistoryConfigModelImplCopyWith<
          _$EarthquakeHistoryConfigModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EarthquakeHistoryListConfig _$EarthquakeHistoryListConfigFromJson(
    Map<String, dynamic> json) {
  return _EarthquakeHistoryListConfig.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeHistoryListConfig {
  /// 背景塗りつぶしの有無
  bool get isFillBackground => throw _privateConstructorUsedError;

  /// 訓練・試験用の電文を含めるかどうか
  bool get includeTestTelegrams => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeHistoryListConfigCopyWith<EarthquakeHistoryListConfig>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeHistoryListConfigCopyWith<$Res> {
  factory $EarthquakeHistoryListConfigCopyWith(
          EarthquakeHistoryListConfig value,
          $Res Function(EarthquakeHistoryListConfig) then) =
      _$EarthquakeHistoryListConfigCopyWithImpl<$Res,
          EarthquakeHistoryListConfig>;
  @useResult
  $Res call({bool isFillBackground, bool includeTestTelegrams});
}

/// @nodoc
class _$EarthquakeHistoryListConfigCopyWithImpl<$Res,
        $Val extends EarthquakeHistoryListConfig>
    implements $EarthquakeHistoryListConfigCopyWith<$Res> {
  _$EarthquakeHistoryListConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFillBackground = null,
    Object? includeTestTelegrams = null,
  }) {
    return _then(_value.copyWith(
      isFillBackground: null == isFillBackground
          ? _value.isFillBackground
          : isFillBackground // ignore: cast_nullable_to_non_nullable
              as bool,
      includeTestTelegrams: null == includeTestTelegrams
          ? _value.includeTestTelegrams
          : includeTestTelegrams // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeHistoryListConfigImplCopyWith<$Res>
    implements $EarthquakeHistoryListConfigCopyWith<$Res> {
  factory _$$EarthquakeHistoryListConfigImplCopyWith(
          _$EarthquakeHistoryListConfigImpl value,
          $Res Function(_$EarthquakeHistoryListConfigImpl) then) =
      __$$EarthquakeHistoryListConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFillBackground, bool includeTestTelegrams});
}

/// @nodoc
class __$$EarthquakeHistoryListConfigImplCopyWithImpl<$Res>
    extends _$EarthquakeHistoryListConfigCopyWithImpl<$Res,
        _$EarthquakeHistoryListConfigImpl>
    implements _$$EarthquakeHistoryListConfigImplCopyWith<$Res> {
  __$$EarthquakeHistoryListConfigImplCopyWithImpl(
      _$EarthquakeHistoryListConfigImpl _value,
      $Res Function(_$EarthquakeHistoryListConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFillBackground = null,
    Object? includeTestTelegrams = null,
  }) {
    return _then(_$EarthquakeHistoryListConfigImpl(
      isFillBackground: null == isFillBackground
          ? _value.isFillBackground
          : isFillBackground // ignore: cast_nullable_to_non_nullable
              as bool,
      includeTestTelegrams: null == includeTestTelegrams
          ? _value.includeTestTelegrams
          : includeTestTelegrams // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeHistoryListConfigImpl
    implements _EarthquakeHistoryListConfig {
  const _$EarthquakeHistoryListConfigImpl(
      {this.isFillBackground = true, this.includeTestTelegrams = false});

  factory _$EarthquakeHistoryListConfigImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EarthquakeHistoryListConfigImplFromJson(json);

  /// 背景塗りつぶしの有無
  @override
  @JsonKey()
  final bool isFillBackground;

  /// 訓練・試験用の電文を含めるかどうか
  @override
  @JsonKey()
  final bool includeTestTelegrams;

  @override
  String toString() {
    return 'EarthquakeHistoryListConfig(isFillBackground: $isFillBackground, includeTestTelegrams: $includeTestTelegrams)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeHistoryListConfigImpl &&
            (identical(other.isFillBackground, isFillBackground) ||
                other.isFillBackground == isFillBackground) &&
            (identical(other.includeTestTelegrams, includeTestTelegrams) ||
                other.includeTestTelegrams == includeTestTelegrams));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isFillBackground, includeTestTelegrams);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeHistoryListConfigImplCopyWith<_$EarthquakeHistoryListConfigImpl>
      get copyWith => __$$EarthquakeHistoryListConfigImplCopyWithImpl<
          _$EarthquakeHistoryListConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeHistoryListConfigImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeHistoryListConfig
    implements EarthquakeHistoryListConfig {
  const factory _EarthquakeHistoryListConfig(
      {final bool isFillBackground,
      final bool includeTestTelegrams}) = _$EarthquakeHistoryListConfigImpl;

  factory _EarthquakeHistoryListConfig.fromJson(Map<String, dynamic> json) =
      _$EarthquakeHistoryListConfigImpl.fromJson;

  @override

  /// 背景塗りつぶしの有無
  bool get isFillBackground;
  @override

  /// 訓練・試験用の電文を含めるかどうか
  bool get includeTestTelegrams;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeHistoryListConfigImplCopyWith<_$EarthquakeHistoryListConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EarthquakeHistoryDetailConfig _$EarthquakeHistoryDetailConfigFromJson(
    Map<String, dynamic> json) {
  return _EarthquakeHistoryDetailConfig.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeHistoryDetailConfig {
  /// 震度の表示方法
  IntensityDisplayMode get intensityDisplayMode =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeHistoryDetailConfigCopyWith<EarthquakeHistoryDetailConfig>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeHistoryDetailConfigCopyWith<$Res> {
  factory $EarthquakeHistoryDetailConfigCopyWith(
          EarthquakeHistoryDetailConfig value,
          $Res Function(EarthquakeHistoryDetailConfig) then) =
      _$EarthquakeHistoryDetailConfigCopyWithImpl<$Res,
          EarthquakeHistoryDetailConfig>;
  @useResult
  $Res call({IntensityDisplayMode intensityDisplayMode});
}

/// @nodoc
class _$EarthquakeHistoryDetailConfigCopyWithImpl<$Res,
        $Val extends EarthquakeHistoryDetailConfig>
    implements $EarthquakeHistoryDetailConfigCopyWith<$Res> {
  _$EarthquakeHistoryDetailConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensityDisplayMode = null,
  }) {
    return _then(_value.copyWith(
      intensityDisplayMode: null == intensityDisplayMode
          ? _value.intensityDisplayMode
          : intensityDisplayMode // ignore: cast_nullable_to_non_nullable
              as IntensityDisplayMode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeHistoryDetailConfigImplCopyWith<$Res>
    implements $EarthquakeHistoryDetailConfigCopyWith<$Res> {
  factory _$$EarthquakeHistoryDetailConfigImplCopyWith(
          _$EarthquakeHistoryDetailConfigImpl value,
          $Res Function(_$EarthquakeHistoryDetailConfigImpl) then) =
      __$$EarthquakeHistoryDetailConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IntensityDisplayMode intensityDisplayMode});
}

/// @nodoc
class __$$EarthquakeHistoryDetailConfigImplCopyWithImpl<$Res>
    extends _$EarthquakeHistoryDetailConfigCopyWithImpl<$Res,
        _$EarthquakeHistoryDetailConfigImpl>
    implements _$$EarthquakeHistoryDetailConfigImplCopyWith<$Res> {
  __$$EarthquakeHistoryDetailConfigImplCopyWithImpl(
      _$EarthquakeHistoryDetailConfigImpl _value,
      $Res Function(_$EarthquakeHistoryDetailConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensityDisplayMode = null,
  }) {
    return _then(_$EarthquakeHistoryDetailConfigImpl(
      intensityDisplayMode: null == intensityDisplayMode
          ? _value.intensityDisplayMode
          : intensityDisplayMode // ignore: cast_nullable_to_non_nullable
              as IntensityDisplayMode,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeHistoryDetailConfigImpl
    implements _EarthquakeHistoryDetailConfig {
  const _$EarthquakeHistoryDetailConfigImpl(
      {this.intensityDisplayMode = IntensityDisplayMode.fillCity});

  factory _$EarthquakeHistoryDetailConfigImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EarthquakeHistoryDetailConfigImplFromJson(json);

  /// 震度の表示方法
  @override
  @JsonKey()
  final IntensityDisplayMode intensityDisplayMode;

  @override
  String toString() {
    return 'EarthquakeHistoryDetailConfig(intensityDisplayMode: $intensityDisplayMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeHistoryDetailConfigImpl &&
            (identical(other.intensityDisplayMode, intensityDisplayMode) ||
                other.intensityDisplayMode == intensityDisplayMode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, intensityDisplayMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeHistoryDetailConfigImplCopyWith<
          _$EarthquakeHistoryDetailConfigImpl>
      get copyWith => __$$EarthquakeHistoryDetailConfigImplCopyWithImpl<
          _$EarthquakeHistoryDetailConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeHistoryDetailConfigImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeHistoryDetailConfig
    implements EarthquakeHistoryDetailConfig {
  const factory _EarthquakeHistoryDetailConfig(
          {final IntensityDisplayMode intensityDisplayMode}) =
      _$EarthquakeHistoryDetailConfigImpl;

  factory _EarthquakeHistoryDetailConfig.fromJson(Map<String, dynamic> json) =
      _$EarthquakeHistoryDetailConfigImpl.fromJson;

  @override

  /// 震度の表示方法
  IntensityDisplayMode get intensityDisplayMode;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeHistoryDetailConfigImplCopyWith<
          _$EarthquakeHistoryDetailConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}
