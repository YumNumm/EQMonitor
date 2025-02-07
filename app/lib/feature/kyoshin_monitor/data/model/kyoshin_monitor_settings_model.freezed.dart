// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KyoshinMonitorSettingsModel _$KyoshinMonitorSettingsModelFromJson(
    Map<String, dynamic> json) {
  return _KyoshinMonitorSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$KyoshinMonitorSettingsModel {
  /// 強震モニタの表示最低リアルタイム震度
  double? get minRealtimeShindo => throw _privateConstructorUsedError;

  /// スケールを表示するかどうか
  bool get showScale => throw _privateConstructorUsedError;

  /// 強震モニタを使用するかどうか
  bool get useKmoni => throw _privateConstructorUsedError;

  /// 強震モニタ観測点のマーカーの種類
  KyoshinMonitorMarkerType get kmoniMarkerType =>
      throw _privateConstructorUsedError;

  /// 強震モニタのリアルタイムデータの種類
  RealtimeDataType get realtimeDataType => throw _privateConstructorUsedError;

  /// 強震モニタのリアルタイムデータのレイヤー
  RealtimeLayer get realtimeLayer => throw _privateConstructorUsedError;

  /// 強震モニタ API関連の設定
  KyoshinMonitorSettingsApiModel get api => throw _privateConstructorUsedError;

  /// Serializes this KyoshinMonitorSettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorSettingsModelCopyWith<KyoshinMonitorSettingsModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorSettingsModelCopyWith<$Res> {
  factory $KyoshinMonitorSettingsModelCopyWith(
          KyoshinMonitorSettingsModel value,
          $Res Function(KyoshinMonitorSettingsModel) then) =
      _$KyoshinMonitorSettingsModelCopyWithImpl<$Res,
          KyoshinMonitorSettingsModel>;
  @useResult
  $Res call(
      {double? minRealtimeShindo,
      bool showScale,
      bool useKmoni,
      KyoshinMonitorMarkerType kmoniMarkerType,
      RealtimeDataType realtimeDataType,
      RealtimeLayer realtimeLayer,
      KyoshinMonitorSettingsApiModel api});

  $KyoshinMonitorSettingsApiModelCopyWith<$Res> get api;
}

/// @nodoc
class _$KyoshinMonitorSettingsModelCopyWithImpl<$Res,
        $Val extends KyoshinMonitorSettingsModel>
    implements $KyoshinMonitorSettingsModelCopyWith<$Res> {
  _$KyoshinMonitorSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minRealtimeShindo = freezed,
    Object? showScale = null,
    Object? useKmoni = null,
    Object? kmoniMarkerType = null,
    Object? realtimeDataType = null,
    Object? realtimeLayer = null,
    Object? api = null,
  }) {
    return _then(_value.copyWith(
      minRealtimeShindo: freezed == minRealtimeShindo
          ? _value.minRealtimeShindo
          : minRealtimeShindo // ignore: cast_nullable_to_non_nullable
              as double?,
      showScale: null == showScale
          ? _value.showScale
          : showScale // ignore: cast_nullable_to_non_nullable
              as bool,
      useKmoni: null == useKmoni
          ? _value.useKmoni
          : useKmoni // ignore: cast_nullable_to_non_nullable
              as bool,
      kmoniMarkerType: null == kmoniMarkerType
          ? _value.kmoniMarkerType
          : kmoniMarkerType // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorMarkerType,
      realtimeDataType: null == realtimeDataType
          ? _value.realtimeDataType
          : realtimeDataType // ignore: cast_nullable_to_non_nullable
              as RealtimeDataType,
      realtimeLayer: null == realtimeLayer
          ? _value.realtimeLayer
          : realtimeLayer // ignore: cast_nullable_to_non_nullable
              as RealtimeLayer,
      api: null == api
          ? _value.api
          : api // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorSettingsApiModel,
    ) as $Val);
  }

  /// Create a copy of KyoshinMonitorSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KyoshinMonitorSettingsApiModelCopyWith<$Res> get api {
    return $KyoshinMonitorSettingsApiModelCopyWith<$Res>(_value.api, (value) {
      return _then(_value.copyWith(api: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorSettingsModelImplCopyWith<$Res>
    implements $KyoshinMonitorSettingsModelCopyWith<$Res> {
  factory _$$KyoshinMonitorSettingsModelImplCopyWith(
          _$KyoshinMonitorSettingsModelImpl value,
          $Res Function(_$KyoshinMonitorSettingsModelImpl) then) =
      __$$KyoshinMonitorSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? minRealtimeShindo,
      bool showScale,
      bool useKmoni,
      KyoshinMonitorMarkerType kmoniMarkerType,
      RealtimeDataType realtimeDataType,
      RealtimeLayer realtimeLayer,
      KyoshinMonitorSettingsApiModel api});

  @override
  $KyoshinMonitorSettingsApiModelCopyWith<$Res> get api;
}

/// @nodoc
class __$$KyoshinMonitorSettingsModelImplCopyWithImpl<$Res>
    extends _$KyoshinMonitorSettingsModelCopyWithImpl<$Res,
        _$KyoshinMonitorSettingsModelImpl>
    implements _$$KyoshinMonitorSettingsModelImplCopyWith<$Res> {
  __$$KyoshinMonitorSettingsModelImplCopyWithImpl(
      _$KyoshinMonitorSettingsModelImpl _value,
      $Res Function(_$KyoshinMonitorSettingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of KyoshinMonitorSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minRealtimeShindo = freezed,
    Object? showScale = null,
    Object? useKmoni = null,
    Object? kmoniMarkerType = null,
    Object? realtimeDataType = null,
    Object? realtimeLayer = null,
    Object? api = null,
  }) {
    return _then(_$KyoshinMonitorSettingsModelImpl(
      minRealtimeShindo: freezed == minRealtimeShindo
          ? _value.minRealtimeShindo
          : minRealtimeShindo // ignore: cast_nullable_to_non_nullable
              as double?,
      showScale: null == showScale
          ? _value.showScale
          : showScale // ignore: cast_nullable_to_non_nullable
              as bool,
      useKmoni: null == useKmoni
          ? _value.useKmoni
          : useKmoni // ignore: cast_nullable_to_non_nullable
              as bool,
      kmoniMarkerType: null == kmoniMarkerType
          ? _value.kmoniMarkerType
          : kmoniMarkerType // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorMarkerType,
      realtimeDataType: null == realtimeDataType
          ? _value.realtimeDataType
          : realtimeDataType // ignore: cast_nullable_to_non_nullable
              as RealtimeDataType,
      realtimeLayer: null == realtimeLayer
          ? _value.realtimeLayer
          : realtimeLayer // ignore: cast_nullable_to_non_nullable
              as RealtimeLayer,
      api: null == api
          ? _value.api
          : api // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorSettingsApiModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinMonitorSettingsModelImpl
    implements _KyoshinMonitorSettingsModel {
  const _$KyoshinMonitorSettingsModelImpl(
      {this.minRealtimeShindo = null,
      this.showScale = true,
      this.useKmoni = true,
      this.kmoniMarkerType = KyoshinMonitorMarkerType.onlyEew,
      this.realtimeDataType = RealtimeDataType.shindo,
      this.realtimeLayer = RealtimeLayer.surface,
      this.api = const KyoshinMonitorSettingsApiModel()});

  factory _$KyoshinMonitorSettingsModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$KyoshinMonitorSettingsModelImplFromJson(json);

  /// 強震モニタの表示最低リアルタイム震度
  @override
  @JsonKey()
  final double? minRealtimeShindo;

  /// スケールを表示するかどうか
  @override
  @JsonKey()
  final bool showScale;

  /// 強震モニタを使用するかどうか
  @override
  @JsonKey()
  final bool useKmoni;

  /// 強震モニタ観測点のマーカーの種類
  @override
  @JsonKey()
  final KyoshinMonitorMarkerType kmoniMarkerType;

  /// 強震モニタのリアルタイムデータの種類
  @override
  @JsonKey()
  final RealtimeDataType realtimeDataType;

  /// 強震モニタのリアルタイムデータのレイヤー
  @override
  @JsonKey()
  final RealtimeLayer realtimeLayer;

  /// 強震モニタ API関連の設定
  @override
  @JsonKey()
  final KyoshinMonitorSettingsApiModel api;

  @override
  String toString() {
    return 'KyoshinMonitorSettingsModel(minRealtimeShindo: $minRealtimeShindo, showScale: $showScale, useKmoni: $useKmoni, kmoniMarkerType: $kmoniMarkerType, realtimeDataType: $realtimeDataType, realtimeLayer: $realtimeLayer, api: $api)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinMonitorSettingsModelImpl &&
            (identical(other.minRealtimeShindo, minRealtimeShindo) ||
                other.minRealtimeShindo == minRealtimeShindo) &&
            (identical(other.showScale, showScale) ||
                other.showScale == showScale) &&
            (identical(other.useKmoni, useKmoni) ||
                other.useKmoni == useKmoni) &&
            (identical(other.kmoniMarkerType, kmoniMarkerType) ||
                other.kmoniMarkerType == kmoniMarkerType) &&
            (identical(other.realtimeDataType, realtimeDataType) ||
                other.realtimeDataType == realtimeDataType) &&
            (identical(other.realtimeLayer, realtimeLayer) ||
                other.realtimeLayer == realtimeLayer) &&
            (identical(other.api, api) || other.api == api));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minRealtimeShindo, showScale,
      useKmoni, kmoniMarkerType, realtimeDataType, realtimeLayer, api);

  /// Create a copy of KyoshinMonitorSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorSettingsModelImplCopyWith<_$KyoshinMonitorSettingsModelImpl>
      get copyWith => __$$KyoshinMonitorSettingsModelImplCopyWithImpl<
          _$KyoshinMonitorSettingsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinMonitorSettingsModelImplToJson(
      this,
    );
  }
}

abstract class _KyoshinMonitorSettingsModel
    implements KyoshinMonitorSettingsModel {
  const factory _KyoshinMonitorSettingsModel(
          {final double? minRealtimeShindo,
          final bool showScale,
          final bool useKmoni,
          final KyoshinMonitorMarkerType kmoniMarkerType,
          final RealtimeDataType realtimeDataType,
          final RealtimeLayer realtimeLayer,
          final KyoshinMonitorSettingsApiModel api}) =
      _$KyoshinMonitorSettingsModelImpl;

  factory _KyoshinMonitorSettingsModel.fromJson(Map<String, dynamic> json) =
      _$KyoshinMonitorSettingsModelImpl.fromJson;

  /// 強震モニタの表示最低リアルタイム震度
  @override
  double? get minRealtimeShindo;

  /// スケールを表示するかどうか
  @override
  bool get showScale;

  /// 強震モニタを使用するかどうか
  @override
  bool get useKmoni;

  /// 強震モニタ観測点のマーカーの種類
  @override
  KyoshinMonitorMarkerType get kmoniMarkerType;

  /// 強震モニタのリアルタイムデータの種類
  @override
  RealtimeDataType get realtimeDataType;

  /// 強震モニタのリアルタイムデータのレイヤー
  @override
  RealtimeLayer get realtimeLayer;

  /// 強震モニタ API関連の設定
  @override
  KyoshinMonitorSettingsApiModel get api;

  /// Create a copy of KyoshinMonitorSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorSettingsModelImplCopyWith<_$KyoshinMonitorSettingsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

KyoshinMonitorSettingsApiModel _$KyoshinMonitorSettingsApiModelFromJson(
    Map<String, dynamic> json) {
  return _KyoshinMonitorSettingsApiModel.fromJson(json);
}

/// @nodoc
mixin _$KyoshinMonitorSettingsApiModel {
  /// 強震モニタ APIのベースURL
  @JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni)
  KyoshinMonitorEndpoint get endpoint => throw _privateConstructorUsedError;

  /// 画像取得頻度
  @Assert('imageFetchInterval.inSeconds > 1',
      'imageFetchInterval must be greater than 1 second')
  Duration get imageFetchInterval => throw _privateConstructorUsedError;

  /// 遅延調整間隔
  Duration get delayAdjustInterval => throw _privateConstructorUsedError;

  /// Serializes this KyoshinMonitorSettingsApiModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorSettingsApiModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorSettingsApiModelCopyWith<KyoshinMonitorSettingsApiModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorSettingsApiModelCopyWith<$Res> {
  factory $KyoshinMonitorSettingsApiModelCopyWith(
          KyoshinMonitorSettingsApiModel value,
          $Res Function(KyoshinMonitorSettingsApiModel) then) =
      _$KyoshinMonitorSettingsApiModelCopyWithImpl<$Res,
          KyoshinMonitorSettingsApiModel>;
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni)
      KyoshinMonitorEndpoint endpoint,
      @Assert('imageFetchInterval.inSeconds > 1',
          'imageFetchInterval must be greater than 1 second')
      Duration imageFetchInterval,
      Duration delayAdjustInterval});
}

/// @nodoc
class _$KyoshinMonitorSettingsApiModelCopyWithImpl<$Res,
        $Val extends KyoshinMonitorSettingsApiModel>
    implements $KyoshinMonitorSettingsApiModelCopyWith<$Res> {
  _$KyoshinMonitorSettingsApiModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorSettingsApiModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpoint = null,
    Object? imageFetchInterval = null,
    Object? delayAdjustInterval = null,
  }) {
    return _then(_value.copyWith(
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorEndpoint,
      imageFetchInterval: null == imageFetchInterval
          ? _value.imageFetchInterval
          : imageFetchInterval // ignore: cast_nullable_to_non_nullable
              as Duration,
      delayAdjustInterval: null == delayAdjustInterval
          ? _value.delayAdjustInterval
          : delayAdjustInterval // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorSettingsApiModelImplCopyWith<$Res>
    implements $KyoshinMonitorSettingsApiModelCopyWith<$Res> {
  factory _$$KyoshinMonitorSettingsApiModelImplCopyWith(
          _$KyoshinMonitorSettingsApiModelImpl value,
          $Res Function(_$KyoshinMonitorSettingsApiModelImpl) then) =
      __$$KyoshinMonitorSettingsApiModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni)
      KyoshinMonitorEndpoint endpoint,
      @Assert('imageFetchInterval.inSeconds > 1',
          'imageFetchInterval must be greater than 1 second')
      Duration imageFetchInterval,
      Duration delayAdjustInterval});
}

/// @nodoc
class __$$KyoshinMonitorSettingsApiModelImplCopyWithImpl<$Res>
    extends _$KyoshinMonitorSettingsApiModelCopyWithImpl<$Res,
        _$KyoshinMonitorSettingsApiModelImpl>
    implements _$$KyoshinMonitorSettingsApiModelImplCopyWith<$Res> {
  __$$KyoshinMonitorSettingsApiModelImplCopyWithImpl(
      _$KyoshinMonitorSettingsApiModelImpl _value,
      $Res Function(_$KyoshinMonitorSettingsApiModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of KyoshinMonitorSettingsApiModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpoint = null,
    Object? imageFetchInterval = null,
    Object? delayAdjustInterval = null,
  }) {
    return _then(_$KyoshinMonitorSettingsApiModelImpl(
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorEndpoint,
      imageFetchInterval: null == imageFetchInterval
          ? _value.imageFetchInterval
          : imageFetchInterval // ignore: cast_nullable_to_non_nullable
              as Duration,
      delayAdjustInterval: null == delayAdjustInterval
          ? _value.delayAdjustInterval
          : delayAdjustInterval // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinMonitorSettingsApiModelImpl
    implements _KyoshinMonitorSettingsApiModel {
  const _$KyoshinMonitorSettingsApiModelImpl(
      {@JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni)
      this.endpoint = KyoshinMonitorEndpoint.kmoni,
      @Assert('imageFetchInterval.inSeconds > 1',
          'imageFetchInterval must be greater than 1 second')
      this.imageFetchInterval = const Duration(seconds: 1),
      this.delayAdjustInterval = const Duration(minutes: 10)});

  factory _$KyoshinMonitorSettingsApiModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$KyoshinMonitorSettingsApiModelImplFromJson(json);

  /// 強震モニタ APIのベースURL
  @override
  @JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni)
  final KyoshinMonitorEndpoint endpoint;

  /// 画像取得頻度
  @override
  @JsonKey()
  @Assert('imageFetchInterval.inSeconds > 1',
      'imageFetchInterval must be greater than 1 second')
  final Duration imageFetchInterval;

  /// 遅延調整間隔
  @override
  @JsonKey()
  final Duration delayAdjustInterval;

  @override
  String toString() {
    return 'KyoshinMonitorSettingsApiModel(endpoint: $endpoint, imageFetchInterval: $imageFetchInterval, delayAdjustInterval: $delayAdjustInterval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinMonitorSettingsApiModelImpl &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint) &&
            (identical(other.imageFetchInterval, imageFetchInterval) ||
                other.imageFetchInterval == imageFetchInterval) &&
            (identical(other.delayAdjustInterval, delayAdjustInterval) ||
                other.delayAdjustInterval == delayAdjustInterval));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, endpoint, imageFetchInterval, delayAdjustInterval);

  /// Create a copy of KyoshinMonitorSettingsApiModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorSettingsApiModelImplCopyWith<
          _$KyoshinMonitorSettingsApiModelImpl>
      get copyWith => __$$KyoshinMonitorSettingsApiModelImplCopyWithImpl<
          _$KyoshinMonitorSettingsApiModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinMonitorSettingsApiModelImplToJson(
      this,
    );
  }
}

abstract class _KyoshinMonitorSettingsApiModel
    implements KyoshinMonitorSettingsApiModel {
  const factory _KyoshinMonitorSettingsApiModel(
          {@JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni)
          final KyoshinMonitorEndpoint endpoint,
          @Assert('imageFetchInterval.inSeconds > 1',
              'imageFetchInterval must be greater than 1 second')
          final Duration imageFetchInterval,
          final Duration delayAdjustInterval}) =
      _$KyoshinMonitorSettingsApiModelImpl;

  factory _KyoshinMonitorSettingsApiModel.fromJson(Map<String, dynamic> json) =
      _$KyoshinMonitorSettingsApiModelImpl.fromJson;

  /// 強震モニタ APIのベースURL
  @override
  @JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni)
  KyoshinMonitorEndpoint get endpoint;

  /// 画像取得頻度
  @override
  @Assert('imageFetchInterval.inSeconds > 1',
      'imageFetchInterval must be greater than 1 second')
  Duration get imageFetchInterval;

  /// 遅延調整間隔
  @override
  Duration get delayAdjustInterval;

  /// Create a copy of KyoshinMonitorSettingsApiModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorSettingsApiModelImplCopyWith<
          _$KyoshinMonitorSettingsApiModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
