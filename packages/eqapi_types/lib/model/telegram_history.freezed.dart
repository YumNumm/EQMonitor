// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TelegramHistoryV3 _$TelegramHistoryV3FromJson(Map<String, dynamic> json) {
  return _TelegramHistoryV3.fromJson(json);
}

/// @nodoc
mixin _$TelegramHistoryV3 {
  @JsonKey(
      fromJson: _telegramHistoryV3DataFromJson,
      toJson: _telegramHistoryV3DataToJson)
  Map<String, List<TelegramV3>>? get results =>
      throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  D1DbExecutionResult get meta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramHistoryV3CopyWith<TelegramHistoryV3> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramHistoryV3CopyWith<$Res> {
  factory $TelegramHistoryV3CopyWith(
          TelegramHistoryV3 value, $Res Function(TelegramHistoryV3) then) =
      _$TelegramHistoryV3CopyWithImpl<$Res, TelegramHistoryV3>;
  @useResult
  $Res call(
      {@JsonKey(
          fromJson: _telegramHistoryV3DataFromJson,
          toJson: _telegramHistoryV3DataToJson)
      Map<String, List<TelegramV3>>? results,
      bool success,
      D1DbExecutionResult meta});

  $D1DbExecutionResultCopyWith<$Res> get meta;
}

/// @nodoc
class _$TelegramHistoryV3CopyWithImpl<$Res, $Val extends TelegramHistoryV3>
    implements $TelegramHistoryV3CopyWith<$Res> {
  _$TelegramHistoryV3CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = freezed,
    Object? success = null,
    Object? meta = null,
  }) {
    return _then(_value.copyWith(
      results: freezed == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TelegramV3>>?,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      meta: null == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as D1DbExecutionResult,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $D1DbExecutionResultCopyWith<$Res> get meta {
    return $D1DbExecutionResultCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TelegramHistoryV3ImplCopyWith<$Res>
    implements $TelegramHistoryV3CopyWith<$Res> {
  factory _$$TelegramHistoryV3ImplCopyWith(_$TelegramHistoryV3Impl value,
          $Res Function(_$TelegramHistoryV3Impl) then) =
      __$$TelegramHistoryV3ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          fromJson: _telegramHistoryV3DataFromJson,
          toJson: _telegramHistoryV3DataToJson)
      Map<String, List<TelegramV3>>? results,
      bool success,
      D1DbExecutionResult meta});

  @override
  $D1DbExecutionResultCopyWith<$Res> get meta;
}

/// @nodoc
class __$$TelegramHistoryV3ImplCopyWithImpl<$Res>
    extends _$TelegramHistoryV3CopyWithImpl<$Res, _$TelegramHistoryV3Impl>
    implements _$$TelegramHistoryV3ImplCopyWith<$Res> {
  __$$TelegramHistoryV3ImplCopyWithImpl(_$TelegramHistoryV3Impl _value,
      $Res Function(_$TelegramHistoryV3Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = freezed,
    Object? success = null,
    Object? meta = null,
  }) {
    return _then(_$TelegramHistoryV3Impl(
      results: freezed == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TelegramV3>>?,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      meta: null == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as D1DbExecutionResult,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TelegramHistoryV3Impl implements _TelegramHistoryV3 {
  const _$TelegramHistoryV3Impl(
      {@JsonKey(
          fromJson: _telegramHistoryV3DataFromJson,
          toJson: _telegramHistoryV3DataToJson)
      required final Map<String, List<TelegramV3>>? results,
      required this.success,
      required this.meta})
      : _results = results;

  factory _$TelegramHistoryV3Impl.fromJson(Map<String, dynamic> json) =>
      _$$TelegramHistoryV3ImplFromJson(json);

  final Map<String, List<TelegramV3>>? _results;
  @override
  @JsonKey(
      fromJson: _telegramHistoryV3DataFromJson,
      toJson: _telegramHistoryV3DataToJson)
  Map<String, List<TelegramV3>>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableMapView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool success;
  @override
  final D1DbExecutionResult meta;

  @override
  String toString() {
    return 'TelegramHistoryV3(results: $results, success: $success, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TelegramHistoryV3Impl &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_results), success, meta);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TelegramHistoryV3ImplCopyWith<_$TelegramHistoryV3Impl> get copyWith =>
      __$$TelegramHistoryV3ImplCopyWithImpl<_$TelegramHistoryV3Impl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TelegramHistoryV3ImplToJson(
      this,
    );
  }
}

abstract class _TelegramHistoryV3 implements TelegramHistoryV3 {
  const factory _TelegramHistoryV3(
      {@JsonKey(
          fromJson: _telegramHistoryV3DataFromJson,
          toJson: _telegramHistoryV3DataToJson)
      required final Map<String, List<TelegramV3>>? results,
      required final bool success,
      required final D1DbExecutionResult meta}) = _$TelegramHistoryV3Impl;

  factory _TelegramHistoryV3.fromJson(Map<String, dynamic> json) =
      _$TelegramHistoryV3Impl.fromJson;

  @override
  @JsonKey(
      fromJson: _telegramHistoryV3DataFromJson,
      toJson: _telegramHistoryV3DataToJson)
  Map<String, List<TelegramV3>>? get results;
  @override
  bool get success;
  @override
  D1DbExecutionResult get meta;
  @override
  @JsonKey(ignore: true)
  _$$TelegramHistoryV3ImplCopyWith<_$TelegramHistoryV3Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

D1DbExecutionResult _$D1DbExecutionResultFromJson(Map<String, dynamic> json) {
  return _D1DbExecutionResult.fromJson(json);
}

/// @nodoc
mixin _$D1DbExecutionResult {
  double get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $D1DbExecutionResultCopyWith<D1DbExecutionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $D1DbExecutionResultCopyWith<$Res> {
  factory $D1DbExecutionResultCopyWith(
          D1DbExecutionResult value, $Res Function(D1DbExecutionResult) then) =
      _$D1DbExecutionResultCopyWithImpl<$Res, D1DbExecutionResult>;
  @useResult
  $Res call({double duration});
}

/// @nodoc
class _$D1DbExecutionResultCopyWithImpl<$Res, $Val extends D1DbExecutionResult>
    implements $D1DbExecutionResultCopyWith<$Res> {
  _$D1DbExecutionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$D1DbExecutionResultImplCopyWith<$Res>
    implements $D1DbExecutionResultCopyWith<$Res> {
  factory _$$D1DbExecutionResultImplCopyWith(_$D1DbExecutionResultImpl value,
          $Res Function(_$D1DbExecutionResultImpl) then) =
      __$$D1DbExecutionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double duration});
}

/// @nodoc
class __$$D1DbExecutionResultImplCopyWithImpl<$Res>
    extends _$D1DbExecutionResultCopyWithImpl<$Res, _$D1DbExecutionResultImpl>
    implements _$$D1DbExecutionResultImplCopyWith<$Res> {
  __$$D1DbExecutionResultImplCopyWithImpl(_$D1DbExecutionResultImpl _value,
      $Res Function(_$D1DbExecutionResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = null,
  }) {
    return _then(_$D1DbExecutionResultImpl(
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$D1DbExecutionResultImpl implements _D1DbExecutionResult {
  const _$D1DbExecutionResultImpl({required this.duration});

  factory _$D1DbExecutionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$D1DbExecutionResultImplFromJson(json);

  @override
  final double duration;

  @override
  String toString() {
    return 'D1DbExecutionResult(duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$D1DbExecutionResultImpl &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$D1DbExecutionResultImplCopyWith<_$D1DbExecutionResultImpl> get copyWith =>
      __$$D1DbExecutionResultImplCopyWithImpl<_$D1DbExecutionResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$D1DbExecutionResultImplToJson(
      this,
    );
  }
}

abstract class _D1DbExecutionResult implements D1DbExecutionResult {
  const factory _D1DbExecutionResult({required final double duration}) =
      _$D1DbExecutionResultImpl;

  factory _D1DbExecutionResult.fromJson(Map<String, dynamic> json) =
      _$D1DbExecutionResultImpl.fromJson;

  @override
  double get duration;
  @override
  @JsonKey(ignore: true)
  _$$D1DbExecutionResultImplCopyWith<_$D1DbExecutionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
