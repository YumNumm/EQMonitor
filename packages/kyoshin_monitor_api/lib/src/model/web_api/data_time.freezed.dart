// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DataTime _$DataTimeFromJson(Map<String, dynamic> json) {
  return _DataTime.fromJson(json);
}

/// @nodoc
mixin _$DataTime {
  Security? get security =>
      throw _privateConstructorUsedError;
  Result? get result => throw _privateConstructorUsedError;
  @JsonKey(
    fromJson: dateTimeFromString,
    toJson: dateTimeToString,
  )
  DateTime get latestTime =>
      throw _privateConstructorUsedError;
  @JsonKey(
    fromJson: dateTimeFromString,
    toJson: dateTimeToString,
  )
  DateTime get requestTime =>
      throw _privateConstructorUsedError;

  /// Serializes this DataTime to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of DataTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DataTimeCopyWith<DataTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataTimeCopyWith<$Res> {
  factory $DataTimeCopyWith(
    DataTime value,
    $Res Function(DataTime) then,
  ) = _$DataTimeCopyWithImpl<$Res, DataTime>;
  @useResult
  $Res call({
    Security? security,
    Result? result,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    DateTime latestTime,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    DateTime requestTime,
  });

  $SecurityCopyWith<$Res>? get security;
  $ResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$DataTimeCopyWithImpl<$Res, $Val extends DataTime>
    implements $DataTimeCopyWith<$Res> {
  _$DataTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DataTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? security = freezed,
    Object? result = freezed,
    Object? latestTime = null,
    Object? requestTime = null,
  }) {
    return _then(
      _value.copyWith(
            security:
                freezed == security
                    ? _value.security
                    : security // ignore: cast_nullable_to_non_nullable
                        as Security?,
            result:
                freezed == result
                    ? _value.result
                    : result // ignore: cast_nullable_to_non_nullable
                        as Result?,
            latestTime:
                null == latestTime
                    ? _value.latestTime
                    : latestTime // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            requestTime:
                null == requestTime
                    ? _value.requestTime
                    : requestTime // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of DataTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SecurityCopyWith<$Res>? get security {
    if (_value.security == null) {
      return null;
    }

    return $SecurityCopyWith<$Res>(_value.security!, (
      value,
    ) {
      return _then(
        _value.copyWith(security: value) as $Val,
      );
    });
  }

  /// Create a copy of DataTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $ResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DataTimeImplCopyWith<$Res>
    implements $DataTimeCopyWith<$Res> {
  factory _$$DataTimeImplCopyWith(
    _$DataTimeImpl value,
    $Res Function(_$DataTimeImpl) then,
  ) = __$$DataTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Security? security,
    Result? result,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    DateTime latestTime,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    DateTime requestTime,
  });

  @override
  $SecurityCopyWith<$Res>? get security;
  @override
  $ResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$DataTimeImplCopyWithImpl<$Res>
    extends _$DataTimeCopyWithImpl<$Res, _$DataTimeImpl>
    implements _$$DataTimeImplCopyWith<$Res> {
  __$$DataTimeImplCopyWithImpl(
    _$DataTimeImpl _value,
    $Res Function(_$DataTimeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DataTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? security = freezed,
    Object? result = freezed,
    Object? latestTime = null,
    Object? requestTime = null,
  }) {
    return _then(
      _$DataTimeImpl(
        security:
            freezed == security
                ? _value.security
                : security // ignore: cast_nullable_to_non_nullable
                    as Security?,
        result:
            freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                    as Result?,
        latestTime:
            null == latestTime
                ? _value.latestTime
                : latestTime // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        requestTime:
            null == requestTime
                ? _value.requestTime
                : requestTime // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DataTimeImpl implements _DataTime {
  const _$DataTimeImpl({
    required this.security,
    required this.result,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    required this.latestTime,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    required this.requestTime,
  });

  factory _$DataTimeImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DataTimeImplFromJson(json);

  @override
  final Security? security;
  @override
  final Result? result;
  @override
  @JsonKey(
    fromJson: dateTimeFromString,
    toJson: dateTimeToString,
  )
  final DateTime latestTime;
  @override
  @JsonKey(
    fromJson: dateTimeFromString,
    toJson: dateTimeToString,
  )
  final DateTime requestTime;

  @override
  String toString() {
    return 'DataTime(security: $security, result: $result, latestTime: $latestTime, requestTime: $requestTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataTimeImpl &&
            (identical(other.security, security) ||
                other.security == security) &&
            (identical(other.result, result) ||
                other.result == result) &&
            (identical(other.latestTime, latestTime) ||
                other.latestTime == latestTime) &&
            (identical(other.requestTime, requestTime) ||
                other.requestTime == requestTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    security,
    result,
    latestTime,
    requestTime,
  );

  /// Create a copy of DataTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataTimeImplCopyWith<_$DataTimeImpl> get copyWith =>
      __$$DataTimeImplCopyWithImpl<_$DataTimeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DataTimeImplToJson(this);
  }
}

abstract class _DataTime implements DataTime {
  const factory _DataTime({
    required final Security? security,
    required final Result? result,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    required final DateTime latestTime,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    required final DateTime requestTime,
  }) = _$DataTimeImpl;

  factory _DataTime.fromJson(Map<String, dynamic> json) =
      _$DataTimeImpl.fromJson;

  @override
  Security? get security;
  @override
  Result? get result;
  @override
  @JsonKey(
    fromJson: dateTimeFromString,
    toJson: dateTimeToString,
  )
  DateTime get latestTime;
  @override
  @JsonKey(
    fromJson: dateTimeFromString,
    toJson: dateTimeToString,
  )
  DateTime get requestTime;

  /// Create a copy of DataTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataTimeImplCopyWith<_$DataTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
