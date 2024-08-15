// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kmoni_view_model_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KmoniViewModelState {
  /// 初期化済みかどうか
  bool get isInitialized => throw _privateConstructorUsedError;
  DateTime? get lastUpdatedAt => throw _privateConstructorUsedError;

  /// 現在時刻からの遅延
  Duration? get delay => throw _privateConstructorUsedError;
  KmoniStatus get status => throw _privateConstructorUsedError;
  List<AnalyzedKmoniObservationPoint>? get analyzedPoints =>
      throw _privateConstructorUsedError;

  /// 遅延調整中かどうか
  bool get isDelayAdjusting => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KmoniViewModelStateCopyWith<KmoniViewModelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KmoniViewModelStateCopyWith<$Res> {
  factory $KmoniViewModelStateCopyWith(
          KmoniViewModelState value, $Res Function(KmoniViewModelState) then) =
      _$KmoniViewModelStateCopyWithImpl<$Res, KmoniViewModelState>;
  @useResult
  $Res call(
      {bool isInitialized,
      DateTime? lastUpdatedAt,
      Duration? delay,
      KmoniStatus status,
      List<AnalyzedKmoniObservationPoint>? analyzedPoints,
      bool isDelayAdjusting});
}

/// @nodoc
class _$KmoniViewModelStateCopyWithImpl<$Res, $Val extends KmoniViewModelState>
    implements $KmoniViewModelStateCopyWith<$Res> {
  _$KmoniViewModelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitialized = null,
    Object? lastUpdatedAt = freezed,
    Object? delay = freezed,
    Object? status = null,
    Object? analyzedPoints = freezed,
    Object? isDelayAdjusting = null,
  }) {
    return _then(_value.copyWith(
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdatedAt: freezed == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as Duration?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as KmoniStatus,
      analyzedPoints: freezed == analyzedPoints
          ? _value.analyzedPoints
          : analyzedPoints // ignore: cast_nullable_to_non_nullable
              as List<AnalyzedKmoniObservationPoint>?,
      isDelayAdjusting: null == isDelayAdjusting
          ? _value.isDelayAdjusting
          : isDelayAdjusting // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KmoniViewModelStateImplCopyWith<$Res>
    implements $KmoniViewModelStateCopyWith<$Res> {
  factory _$$KmoniViewModelStateImplCopyWith(_$KmoniViewModelStateImpl value,
          $Res Function(_$KmoniViewModelStateImpl) then) =
      __$$KmoniViewModelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isInitialized,
      DateTime? lastUpdatedAt,
      Duration? delay,
      KmoniStatus status,
      List<AnalyzedKmoniObservationPoint>? analyzedPoints,
      bool isDelayAdjusting});
}

/// @nodoc
class __$$KmoniViewModelStateImplCopyWithImpl<$Res>
    extends _$KmoniViewModelStateCopyWithImpl<$Res, _$KmoniViewModelStateImpl>
    implements _$$KmoniViewModelStateImplCopyWith<$Res> {
  __$$KmoniViewModelStateImplCopyWithImpl(_$KmoniViewModelStateImpl _value,
      $Res Function(_$KmoniViewModelStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitialized = null,
    Object? lastUpdatedAt = freezed,
    Object? delay = freezed,
    Object? status = null,
    Object? analyzedPoints = freezed,
    Object? isDelayAdjusting = null,
  }) {
    return _then(_$KmoniViewModelStateImpl(
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdatedAt: freezed == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as Duration?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as KmoniStatus,
      analyzedPoints: freezed == analyzedPoints
          ? _value._analyzedPoints
          : analyzedPoints // ignore: cast_nullable_to_non_nullable
              as List<AnalyzedKmoniObservationPoint>?,
      isDelayAdjusting: null == isDelayAdjusting
          ? _value.isDelayAdjusting
          : isDelayAdjusting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$KmoniViewModelStateImpl implements _KmoniViewModelState {
  const _$KmoniViewModelStateImpl(
      {required this.isInitialized,
      required this.lastUpdatedAt,
      required this.delay,
      required this.status,
      required final List<AnalyzedKmoniObservationPoint>? analyzedPoints,
      required this.isDelayAdjusting})
      : _analyzedPoints = analyzedPoints;

  /// 初期化済みかどうか
  @override
  final bool isInitialized;
  @override
  final DateTime? lastUpdatedAt;

  /// 現在時刻からの遅延
  @override
  final Duration? delay;
  @override
  final KmoniStatus status;
  final List<AnalyzedKmoniObservationPoint>? _analyzedPoints;
  @override
  List<AnalyzedKmoniObservationPoint>? get analyzedPoints {
    final value = _analyzedPoints;
    if (value == null) return null;
    if (_analyzedPoints is EqualUnmodifiableListView) return _analyzedPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// 遅延調整中かどうか
  @override
  final bool isDelayAdjusting;

  @override
  String toString() {
    return 'KmoniViewModelState(isInitialized: $isInitialized, lastUpdatedAt: $lastUpdatedAt, delay: $delay, status: $status, analyzedPoints: $analyzedPoints, isDelayAdjusting: $isDelayAdjusting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KmoniViewModelStateImpl &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._analyzedPoints, _analyzedPoints) &&
            (identical(other.isDelayAdjusting, isDelayAdjusting) ||
                other.isDelayAdjusting == isDelayAdjusting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isInitialized,
      lastUpdatedAt,
      delay,
      status,
      const DeepCollectionEquality().hash(_analyzedPoints),
      isDelayAdjusting);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KmoniViewModelStateImplCopyWith<_$KmoniViewModelStateImpl> get copyWith =>
      __$$KmoniViewModelStateImplCopyWithImpl<_$KmoniViewModelStateImpl>(
          this, _$identity);
}

abstract class _KmoniViewModelState implements KmoniViewModelState {
  const factory _KmoniViewModelState(
      {required final bool isInitialized,
      required final DateTime? lastUpdatedAt,
      required final Duration? delay,
      required final KmoniStatus status,
      required final List<AnalyzedKmoniObservationPoint>? analyzedPoints,
      required final bool isDelayAdjusting}) = _$KmoniViewModelStateImpl;

  @override

  /// 初期化済みかどうか
  bool get isInitialized;
  @override
  DateTime? get lastUpdatedAt;
  @override

  /// 現在時刻からの遅延
  Duration? get delay;
  @override
  KmoniStatus get status;
  @override
  List<AnalyzedKmoniObservationPoint>? get analyzedPoints;
  @override

  /// 遅延調整中かどうか
  bool get isDelayAdjusting;
  @override
  @JsonKey(ignore: true)
  _$$KmoniViewModelStateImplCopyWith<_$KmoniViewModelStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
