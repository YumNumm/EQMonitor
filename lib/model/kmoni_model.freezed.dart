// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'kmoni_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KmoniModel {
  /// 観測点のリスト
  List<AnalyzedPoint> get analyzedPoint => throw _privateConstructorUsedError;

  /// 最新の更新時刻
  /// `Null`の時は、まだ更新されていません
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// 最終更新試行時
  /// デフォルトは 現在時刻
  DateTime get lastUpdateAttempt => throw _privateConstructorUsedError;

  /// 観測点の位置
  List<ObsPoint> get obsPoints => throw _privateConstructorUsedError;

  /// 観測点CSVがロードされたかどうか
  bool get isKansokutenLoaded => throw _privateConstructorUsedError;

  /// Kmoniの更新タイマー
  Timer? get updateTimer => throw _privateConstructorUsedError;

  /// Kmoniの更新頻度
  Duration get updateFrequency => throw _privateConstructorUsedError;

  /// Kmoniの更新中かどうか
  bool get isUpdating => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KmoniModelCopyWith<KmoniModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KmoniModelCopyWith<$Res> {
  factory $KmoniModelCopyWith(
          KmoniModel value, $Res Function(KmoniModel) then) =
      _$KmoniModelCopyWithImpl<$Res>;
  $Res call(
      {List<AnalyzedPoint> analyzedPoint,
      DateTime? lastUpdated,
      DateTime lastUpdateAttempt,
      List<ObsPoint> obsPoints,
      bool isKansokutenLoaded,
      Timer? updateTimer,
      Duration updateFrequency,
      bool isUpdating});
}

/// @nodoc
class _$KmoniModelCopyWithImpl<$Res> implements $KmoniModelCopyWith<$Res> {
  _$KmoniModelCopyWithImpl(this._value, this._then);

  final KmoniModel _value;
  // ignore: unused_field
  final $Res Function(KmoniModel) _then;

  @override
  $Res call({
    Object? analyzedPoint = freezed,
    Object? lastUpdated = freezed,
    Object? lastUpdateAttempt = freezed,
    Object? obsPoints = freezed,
    Object? isKansokutenLoaded = freezed,
    Object? updateTimer = freezed,
    Object? updateFrequency = freezed,
    Object? isUpdating = freezed,
  }) {
    return _then(_value.copyWith(
      analyzedPoint: analyzedPoint == freezed
          ? _value.analyzedPoint
          : analyzedPoint // ignore: cast_nullable_to_non_nullable
              as List<AnalyzedPoint>,
      lastUpdated: lastUpdated == freezed
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdateAttempt: lastUpdateAttempt == freezed
          ? _value.lastUpdateAttempt
          : lastUpdateAttempt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      obsPoints: obsPoints == freezed
          ? _value.obsPoints
          : obsPoints // ignore: cast_nullable_to_non_nullable
              as List<ObsPoint>,
      isKansokutenLoaded: isKansokutenLoaded == freezed
          ? _value.isKansokutenLoaded
          : isKansokutenLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      updateTimer: updateTimer == freezed
          ? _value.updateTimer
          : updateTimer // ignore: cast_nullable_to_non_nullable
              as Timer?,
      updateFrequency: updateFrequency == freezed
          ? _value.updateFrequency
          : updateFrequency // ignore: cast_nullable_to_non_nullable
              as Duration,
      isUpdating: isUpdating == freezed
          ? _value.isUpdating
          : isUpdating // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_KmoniModelCopyWith<$Res>
    implements $KmoniModelCopyWith<$Res> {
  factory _$$_KmoniModelCopyWith(
          _$_KmoniModel value, $Res Function(_$_KmoniModel) then) =
      __$$_KmoniModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<AnalyzedPoint> analyzedPoint,
      DateTime? lastUpdated,
      DateTime lastUpdateAttempt,
      List<ObsPoint> obsPoints,
      bool isKansokutenLoaded,
      Timer? updateTimer,
      Duration updateFrequency,
      bool isUpdating});
}

/// @nodoc
class __$$_KmoniModelCopyWithImpl<$Res> extends _$KmoniModelCopyWithImpl<$Res>
    implements _$$_KmoniModelCopyWith<$Res> {
  __$$_KmoniModelCopyWithImpl(
      _$_KmoniModel _value, $Res Function(_$_KmoniModel) _then)
      : super(_value, (v) => _then(v as _$_KmoniModel));

  @override
  _$_KmoniModel get _value => super._value as _$_KmoniModel;

  @override
  $Res call({
    Object? analyzedPoint = freezed,
    Object? lastUpdated = freezed,
    Object? lastUpdateAttempt = freezed,
    Object? obsPoints = freezed,
    Object? isKansokutenLoaded = freezed,
    Object? updateTimer = freezed,
    Object? updateFrequency = freezed,
    Object? isUpdating = freezed,
  }) {
    return _then(_$_KmoniModel(
      analyzedPoint: analyzedPoint == freezed
          ? _value._analyzedPoint
          : analyzedPoint // ignore: cast_nullable_to_non_nullable
              as List<AnalyzedPoint>,
      lastUpdated: lastUpdated == freezed
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdateAttempt: lastUpdateAttempt == freezed
          ? _value.lastUpdateAttempt
          : lastUpdateAttempt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      obsPoints: obsPoints == freezed
          ? _value._obsPoints
          : obsPoints // ignore: cast_nullable_to_non_nullable
              as List<ObsPoint>,
      isKansokutenLoaded: isKansokutenLoaded == freezed
          ? _value.isKansokutenLoaded
          : isKansokutenLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      updateTimer: updateTimer == freezed
          ? _value.updateTimer
          : updateTimer // ignore: cast_nullable_to_non_nullable
              as Timer?,
      updateFrequency: updateFrequency == freezed
          ? _value.updateFrequency
          : updateFrequency // ignore: cast_nullable_to_non_nullable
              as Duration,
      isUpdating: isUpdating == freezed
          ? _value.isUpdating
          : isUpdating // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_KmoniModel implements _KmoniModel {
  const _$_KmoniModel(
      {required final List<AnalyzedPoint> analyzedPoint,
      required this.lastUpdated,
      required this.lastUpdateAttempt,
      required final List<ObsPoint> obsPoints,
      required this.isKansokutenLoaded,
      required this.updateTimer,
      required this.updateFrequency,
      required this.isUpdating})
      : _analyzedPoint = analyzedPoint,
        _obsPoints = obsPoints;

  /// 観測点のリスト
  final List<AnalyzedPoint> _analyzedPoint;

  /// 観測点のリスト
  @override
  List<AnalyzedPoint> get analyzedPoint {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_analyzedPoint);
  }

  /// 最新の更新時刻
  /// `Null`の時は、まだ更新されていません
  @override
  final DateTime? lastUpdated;

  /// 最終更新試行時
  /// デフォルトは 現在時刻
  @override
  final DateTime lastUpdateAttempt;

  /// 観測点の位置
  final List<ObsPoint> _obsPoints;

  /// 観測点の位置
  @override
  List<ObsPoint> get obsPoints {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_obsPoints);
  }

  /// 観測点CSVがロードされたかどうか
  @override
  final bool isKansokutenLoaded;

  /// Kmoniの更新タイマー
  @override
  final Timer? updateTimer;

  /// Kmoniの更新頻度
  @override
  final Duration updateFrequency;

  /// Kmoniの更新中かどうか
  @override
  final bool isUpdating;

  @override
  String toString() {
    return 'KmoniModel(analyzedPoint: $analyzedPoint, lastUpdated: $lastUpdated, lastUpdateAttempt: $lastUpdateAttempt, obsPoints: $obsPoints, isKansokutenLoaded: $isKansokutenLoaded, updateTimer: $updateTimer, updateFrequency: $updateFrequency, isUpdating: $isUpdating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KmoniModel &&
            const DeepCollectionEquality()
                .equals(other._analyzedPoint, _analyzedPoint) &&
            const DeepCollectionEquality()
                .equals(other.lastUpdated, lastUpdated) &&
            const DeepCollectionEquality()
                .equals(other.lastUpdateAttempt, lastUpdateAttempt) &&
            const DeepCollectionEquality()
                .equals(other._obsPoints, _obsPoints) &&
            const DeepCollectionEquality()
                .equals(other.isKansokutenLoaded, isKansokutenLoaded) &&
            const DeepCollectionEquality()
                .equals(other.updateTimer, updateTimer) &&
            const DeepCollectionEquality()
                .equals(other.updateFrequency, updateFrequency) &&
            const DeepCollectionEquality()
                .equals(other.isUpdating, isUpdating));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_analyzedPoint),
      const DeepCollectionEquality().hash(lastUpdated),
      const DeepCollectionEquality().hash(lastUpdateAttempt),
      const DeepCollectionEquality().hash(_obsPoints),
      const DeepCollectionEquality().hash(isKansokutenLoaded),
      const DeepCollectionEquality().hash(updateTimer),
      const DeepCollectionEquality().hash(updateFrequency),
      const DeepCollectionEquality().hash(isUpdating));

  @JsonKey(ignore: true)
  @override
  _$$_KmoniModelCopyWith<_$_KmoniModel> get copyWith =>
      __$$_KmoniModelCopyWithImpl<_$_KmoniModel>(this, _$identity);
}

abstract class _KmoniModel implements KmoniModel {
  const factory _KmoniModel(
      {required final List<AnalyzedPoint> analyzedPoint,
      required final DateTime? lastUpdated,
      required final DateTime lastUpdateAttempt,
      required final List<ObsPoint> obsPoints,
      required final bool isKansokutenLoaded,
      required final Timer? updateTimer,
      required final Duration updateFrequency,
      required final bool isUpdating}) = _$_KmoniModel;

  @override

  /// 観測点のリスト
  List<AnalyzedPoint> get analyzedPoint => throw _privateConstructorUsedError;
  @override

  /// 最新の更新時刻
  /// `Null`の時は、まだ更新されていません
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  @override

  /// 最終更新試行時
  /// デフォルトは 現在時刻
  DateTime get lastUpdateAttempt => throw _privateConstructorUsedError;
  @override

  /// 観測点の位置
  List<ObsPoint> get obsPoints => throw _privateConstructorUsedError;
  @override

  /// 観測点CSVがロードされたかどうか
  bool get isKansokutenLoaded => throw _privateConstructorUsedError;
  @override

  /// Kmoniの更新タイマー
  Timer? get updateTimer => throw _privateConstructorUsedError;
  @override

  /// Kmoniの更新頻度
  Duration get updateFrequency => throw _privateConstructorUsedError;
  @override

  /// Kmoniの更新中かどうか
  bool get isUpdating => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_KmoniModelCopyWith<_$_KmoniModel> get copyWith =>
      throw _privateConstructorUsedError;
}
