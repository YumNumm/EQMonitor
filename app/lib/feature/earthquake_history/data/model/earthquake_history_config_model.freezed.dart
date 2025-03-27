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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EarthquakeHistoryConfig _$EarthquakeHistoryConfigFromJson(
  Map<String, dynamic> json,
) {
  return _EarthquakeHistoryConfig.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeHistoryConfig {
  EarthquakeHistoryListConfig get list => throw _privateConstructorUsedError;
  EarthquakeHistoryDetailConfig get detail =>
      throw _privateConstructorUsedError;

  /// Serializes this EarthquakeHistoryConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarthquakeHistoryConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarthquakeHistoryConfigCopyWith<EarthquakeHistoryConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeHistoryConfigCopyWith<$Res> {
  factory $EarthquakeHistoryConfigCopyWith(
    EarthquakeHistoryConfig value,
    $Res Function(EarthquakeHistoryConfig) then,
  ) = _$EarthquakeHistoryConfigCopyWithImpl<$Res, EarthquakeHistoryConfig>;
  @useResult
  $Res call({
    EarthquakeHistoryListConfig list,
    EarthquakeHistoryDetailConfig detail,
  });

  $EarthquakeHistoryListConfigCopyWith<$Res> get list;
  $EarthquakeHistoryDetailConfigCopyWith<$Res> get detail;
}

/// @nodoc
class _$EarthquakeHistoryConfigCopyWithImpl<
  $Res,
  $Val extends EarthquakeHistoryConfig
>
    implements $EarthquakeHistoryConfigCopyWith<$Res> {
  _$EarthquakeHistoryConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarthquakeHistoryConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? list = null, Object? detail = null}) {
    return _then(
      _value.copyWith(
            list:
                null == list
                    ? _value.list
                    : list // ignore: cast_nullable_to_non_nullable
                        as EarthquakeHistoryListConfig,
            detail:
                null == detail
                    ? _value.detail
                    : detail // ignore: cast_nullable_to_non_nullable
                        as EarthquakeHistoryDetailConfig,
          )
          as $Val,
    );
  }

  /// Create a copy of EarthquakeHistoryConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EarthquakeHistoryListConfigCopyWith<$Res> get list {
    return $EarthquakeHistoryListConfigCopyWith<$Res>(_value.list, (value) {
      return _then(_value.copyWith(list: value) as $Val);
    });
  }

  /// Create a copy of EarthquakeHistoryConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EarthquakeHistoryDetailConfigCopyWith<$Res> get detail {
    return $EarthquakeHistoryDetailConfigCopyWith<$Res>(_value.detail, (value) {
      return _then(_value.copyWith(detail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EarthquakeHistoryConfigImplCopyWith<$Res>
    implements $EarthquakeHistoryConfigCopyWith<$Res> {
  factory _$$EarthquakeHistoryConfigImplCopyWith(
    _$EarthquakeHistoryConfigImpl value,
    $Res Function(_$EarthquakeHistoryConfigImpl) then,
  ) = __$$EarthquakeHistoryConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    EarthquakeHistoryListConfig list,
    EarthquakeHistoryDetailConfig detail,
  });

  @override
  $EarthquakeHistoryListConfigCopyWith<$Res> get list;
  @override
  $EarthquakeHistoryDetailConfigCopyWith<$Res> get detail;
}

/// @nodoc
class __$$EarthquakeHistoryConfigImplCopyWithImpl<$Res>
    extends
        _$EarthquakeHistoryConfigCopyWithImpl<
          $Res,
          _$EarthquakeHistoryConfigImpl
        >
    implements _$$EarthquakeHistoryConfigImplCopyWith<$Res> {
  __$$EarthquakeHistoryConfigImplCopyWithImpl(
    _$EarthquakeHistoryConfigImpl _value,
    $Res Function(_$EarthquakeHistoryConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarthquakeHistoryConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? list = null, Object? detail = null}) {
    return _then(
      _$EarthquakeHistoryConfigImpl(
        list:
            null == list
                ? _value.list
                : list // ignore: cast_nullable_to_non_nullable
                    as EarthquakeHistoryListConfig,
        detail:
            null == detail
                ? _value.detail
                : detail // ignore: cast_nullable_to_non_nullable
                    as EarthquakeHistoryDetailConfig,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeHistoryConfigImpl implements _EarthquakeHistoryConfig {
  const _$EarthquakeHistoryConfigImpl({
    required this.list,
    required this.detail,
  });

  factory _$EarthquakeHistoryConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeHistoryConfigImplFromJson(json);

  @override
  final EarthquakeHistoryListConfig list;
  @override
  final EarthquakeHistoryDetailConfig detail;

  @override
  String toString() {
    return 'EarthquakeHistoryConfig(list: $list, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeHistoryConfigImpl &&
            (identical(other.list, list) || other.list == list) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, list, detail);

  /// Create a copy of EarthquakeHistoryConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeHistoryConfigImplCopyWith<_$EarthquakeHistoryConfigImpl>
  get copyWith => __$$EarthquakeHistoryConfigImplCopyWithImpl<
    _$EarthquakeHistoryConfigImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeHistoryConfigImplToJson(this);
  }
}

abstract class _EarthquakeHistoryConfig implements EarthquakeHistoryConfig {
  const factory _EarthquakeHistoryConfig({
    required final EarthquakeHistoryListConfig list,
    required final EarthquakeHistoryDetailConfig detail,
  }) = _$EarthquakeHistoryConfigImpl;

  factory _EarthquakeHistoryConfig.fromJson(Map<String, dynamic> json) =
      _$EarthquakeHistoryConfigImpl.fromJson;

  @override
  EarthquakeHistoryListConfig get list;
  @override
  EarthquakeHistoryDetailConfig get detail;

  /// Create a copy of EarthquakeHistoryConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarthquakeHistoryConfigImplCopyWith<_$EarthquakeHistoryConfigImpl>
  get copyWith => throw _privateConstructorUsedError;
}

EarthquakeHistoryListConfig _$EarthquakeHistoryListConfigFromJson(
  Map<String, dynamic> json,
) {
  return _EarthquakeHistoryListConfig.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeHistoryListConfig {
  /// 背景塗りつぶしの有無
  bool get isFillBackground => throw _privateConstructorUsedError;

  /// Serializes this EarthquakeHistoryListConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarthquakeHistoryListConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarthquakeHistoryListConfigCopyWith<EarthquakeHistoryListConfig>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeHistoryListConfigCopyWith<$Res> {
  factory $EarthquakeHistoryListConfigCopyWith(
    EarthquakeHistoryListConfig value,
    $Res Function(EarthquakeHistoryListConfig) then,
  ) =
      _$EarthquakeHistoryListConfigCopyWithImpl<
        $Res,
        EarthquakeHistoryListConfig
      >;
  @useResult
  $Res call({bool isFillBackground});
}

/// @nodoc
class _$EarthquakeHistoryListConfigCopyWithImpl<
  $Res,
  $Val extends EarthquakeHistoryListConfig
>
    implements $EarthquakeHistoryListConfigCopyWith<$Res> {
  _$EarthquakeHistoryListConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarthquakeHistoryListConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isFillBackground = null}) {
    return _then(
      _value.copyWith(
            isFillBackground:
                null == isFillBackground
                    ? _value.isFillBackground
                    : isFillBackground // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EarthquakeHistoryListConfigImplCopyWith<$Res>
    implements $EarthquakeHistoryListConfigCopyWith<$Res> {
  factory _$$EarthquakeHistoryListConfigImplCopyWith(
    _$EarthquakeHistoryListConfigImpl value,
    $Res Function(_$EarthquakeHistoryListConfigImpl) then,
  ) = __$$EarthquakeHistoryListConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFillBackground});
}

/// @nodoc
class __$$EarthquakeHistoryListConfigImplCopyWithImpl<$Res>
    extends
        _$EarthquakeHistoryListConfigCopyWithImpl<
          $Res,
          _$EarthquakeHistoryListConfigImpl
        >
    implements _$$EarthquakeHistoryListConfigImplCopyWith<$Res> {
  __$$EarthquakeHistoryListConfigImplCopyWithImpl(
    _$EarthquakeHistoryListConfigImpl _value,
    $Res Function(_$EarthquakeHistoryListConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarthquakeHistoryListConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isFillBackground = null}) {
    return _then(
      _$EarthquakeHistoryListConfigImpl(
        isFillBackground:
            null == isFillBackground
                ? _value.isFillBackground
                : isFillBackground // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeHistoryListConfigImpl
    implements _EarthquakeHistoryListConfig {
  const _$EarthquakeHistoryListConfigImpl({this.isFillBackground = true});

  factory _$EarthquakeHistoryListConfigImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$EarthquakeHistoryListConfigImplFromJson(json);

  /// 背景塗りつぶしの有無
  @override
  @JsonKey()
  final bool isFillBackground;

  @override
  String toString() {
    return 'EarthquakeHistoryListConfig(isFillBackground: $isFillBackground)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeHistoryListConfigImpl &&
            (identical(other.isFillBackground, isFillBackground) ||
                other.isFillBackground == isFillBackground));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isFillBackground);

  /// Create a copy of EarthquakeHistoryListConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeHistoryListConfigImplCopyWith<_$EarthquakeHistoryListConfigImpl>
  get copyWith => __$$EarthquakeHistoryListConfigImplCopyWithImpl<
    _$EarthquakeHistoryListConfigImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeHistoryListConfigImplToJson(this);
  }
}

abstract class _EarthquakeHistoryListConfig
    implements EarthquakeHistoryListConfig {
  const factory _EarthquakeHistoryListConfig({final bool isFillBackground}) =
      _$EarthquakeHistoryListConfigImpl;

  factory _EarthquakeHistoryListConfig.fromJson(Map<String, dynamic> json) =
      _$EarthquakeHistoryListConfigImpl.fromJson;

  /// 背景塗りつぶしの有無
  @override
  bool get isFillBackground;

  /// Create a copy of EarthquakeHistoryListConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarthquakeHistoryListConfigImplCopyWith<_$EarthquakeHistoryListConfigImpl>
  get copyWith => throw _privateConstructorUsedError;
}

EarthquakeHistoryDetailConfig _$EarthquakeHistoryDetailConfigFromJson(
  Map<String, dynamic> json,
) {
  return _EarthquakeHistoryDetailConfig.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeHistoryDetailConfig {
  /// 震度の表示方法
  IntensityFillMode get intensityFillMode => throw _privateConstructorUsedError;

  /// 震度観測点のアイコン表示
  bool get showIntensityIcon => throw _privateConstructorUsedError;

  /// 長周期地震動階級を表示しているか
  bool get showingLpgmIntensity => throw _privateConstructorUsedError;

  /// Serializes this EarthquakeHistoryDetailConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarthquakeHistoryDetailConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarthquakeHistoryDetailConfigCopyWith<EarthquakeHistoryDetailConfig>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeHistoryDetailConfigCopyWith<$Res> {
  factory $EarthquakeHistoryDetailConfigCopyWith(
    EarthquakeHistoryDetailConfig value,
    $Res Function(EarthquakeHistoryDetailConfig) then,
  ) =
      _$EarthquakeHistoryDetailConfigCopyWithImpl<
        $Res,
        EarthquakeHistoryDetailConfig
      >;
  @useResult
  $Res call({
    IntensityFillMode intensityFillMode,
    bool showIntensityIcon,
    bool showingLpgmIntensity,
  });
}

/// @nodoc
class _$EarthquakeHistoryDetailConfigCopyWithImpl<
  $Res,
  $Val extends EarthquakeHistoryDetailConfig
>
    implements $EarthquakeHistoryDetailConfigCopyWith<$Res> {
  _$EarthquakeHistoryDetailConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarthquakeHistoryDetailConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensityFillMode = null,
    Object? showIntensityIcon = null,
    Object? showingLpgmIntensity = null,
  }) {
    return _then(
      _value.copyWith(
            intensityFillMode:
                null == intensityFillMode
                    ? _value.intensityFillMode
                    : intensityFillMode // ignore: cast_nullable_to_non_nullable
                        as IntensityFillMode,
            showIntensityIcon:
                null == showIntensityIcon
                    ? _value.showIntensityIcon
                    : showIntensityIcon // ignore: cast_nullable_to_non_nullable
                        as bool,
            showingLpgmIntensity:
                null == showingLpgmIntensity
                    ? _value.showingLpgmIntensity
                    : showingLpgmIntensity // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EarthquakeHistoryDetailConfigImplCopyWith<$Res>
    implements $EarthquakeHistoryDetailConfigCopyWith<$Res> {
  factory _$$EarthquakeHistoryDetailConfigImplCopyWith(
    _$EarthquakeHistoryDetailConfigImpl value,
    $Res Function(_$EarthquakeHistoryDetailConfigImpl) then,
  ) = __$$EarthquakeHistoryDetailConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    IntensityFillMode intensityFillMode,
    bool showIntensityIcon,
    bool showingLpgmIntensity,
  });
}

/// @nodoc
class __$$EarthquakeHistoryDetailConfigImplCopyWithImpl<$Res>
    extends
        _$EarthquakeHistoryDetailConfigCopyWithImpl<
          $Res,
          _$EarthquakeHistoryDetailConfigImpl
        >
    implements _$$EarthquakeHistoryDetailConfigImplCopyWith<$Res> {
  __$$EarthquakeHistoryDetailConfigImplCopyWithImpl(
    _$EarthquakeHistoryDetailConfigImpl _value,
    $Res Function(_$EarthquakeHistoryDetailConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarthquakeHistoryDetailConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensityFillMode = null,
    Object? showIntensityIcon = null,
    Object? showingLpgmIntensity = null,
  }) {
    return _then(
      _$EarthquakeHistoryDetailConfigImpl(
        intensityFillMode:
            null == intensityFillMode
                ? _value.intensityFillMode
                : intensityFillMode // ignore: cast_nullable_to_non_nullable
                    as IntensityFillMode,
        showIntensityIcon:
            null == showIntensityIcon
                ? _value.showIntensityIcon
                : showIntensityIcon // ignore: cast_nullable_to_non_nullable
                    as bool,
        showingLpgmIntensity:
            null == showingLpgmIntensity
                ? _value.showingLpgmIntensity
                : showingLpgmIntensity // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeHistoryDetailConfigImpl
    implements _EarthquakeHistoryDetailConfig {
  const _$EarthquakeHistoryDetailConfigImpl({
    this.intensityFillMode = IntensityFillMode.fillCity,
    this.showIntensityIcon = true,
    this.showingLpgmIntensity = false,
  });

  factory _$EarthquakeHistoryDetailConfigImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$EarthquakeHistoryDetailConfigImplFromJson(json);

  /// 震度の表示方法
  @override
  @JsonKey()
  final IntensityFillMode intensityFillMode;

  /// 震度観測点のアイコン表示
  @override
  @JsonKey()
  final bool showIntensityIcon;

  /// 長周期地震動階級を表示しているか
  @override
  @JsonKey()
  final bool showingLpgmIntensity;

  @override
  String toString() {
    return 'EarthquakeHistoryDetailConfig(intensityFillMode: $intensityFillMode, showIntensityIcon: $showIntensityIcon, showingLpgmIntensity: $showingLpgmIntensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeHistoryDetailConfigImpl &&
            (identical(other.intensityFillMode, intensityFillMode) ||
                other.intensityFillMode == intensityFillMode) &&
            (identical(other.showIntensityIcon, showIntensityIcon) ||
                other.showIntensityIcon == showIntensityIcon) &&
            (identical(other.showingLpgmIntensity, showingLpgmIntensity) ||
                other.showingLpgmIntensity == showingLpgmIntensity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    intensityFillMode,
    showIntensityIcon,
    showingLpgmIntensity,
  );

  /// Create a copy of EarthquakeHistoryDetailConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeHistoryDetailConfigImplCopyWith<
    _$EarthquakeHistoryDetailConfigImpl
  >
  get copyWith => __$$EarthquakeHistoryDetailConfigImplCopyWithImpl<
    _$EarthquakeHistoryDetailConfigImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeHistoryDetailConfigImplToJson(this);
  }
}

abstract class _EarthquakeHistoryDetailConfig
    implements EarthquakeHistoryDetailConfig {
  const factory _EarthquakeHistoryDetailConfig({
    final IntensityFillMode intensityFillMode,
    final bool showIntensityIcon,
    final bool showingLpgmIntensity,
  }) = _$EarthquakeHistoryDetailConfigImpl;

  factory _EarthquakeHistoryDetailConfig.fromJson(Map<String, dynamic> json) =
      _$EarthquakeHistoryDetailConfigImpl.fromJson;

  /// 震度の表示方法
  @override
  IntensityFillMode get intensityFillMode;

  /// 震度観測点のアイコン表示
  @override
  bool get showIntensityIcon;

  /// 長周期地震動階級を表示しているか
  @override
  bool get showingLpgmIntensity;

  /// Create a copy of EarthquakeHistoryDetailConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarthquakeHistoryDetailConfigImplCopyWith<
    _$EarthquakeHistoryDetailConfigImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
