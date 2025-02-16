// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maintenance_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MaintenanceMessage _$MaintenanceMessageFromJson(
  Map<String, dynamic> json,
) {
  return _MaintenanceMessage.fromJson(json);
}

/// @nodoc
mixin _$MaintenanceMessage {
  String? get message => throw _privateConstructorUsedError;
  Security? get security =>
      throw _privateConstructorUsedError;
  MaintenanceMessageType? get type =>
      throw _privateConstructorUsedError;
  @JsonKey(
    fromJson: dateTimeFromString,
    toJson: dateTimeToString,
  )
  DateTime get requestTime =>
      throw _privateConstructorUsedError;
  Result? get result => throw _privateConstructorUsedError;

  /// Serializes this MaintenanceMessage to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of MaintenanceMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MaintenanceMessageCopyWith<MaintenanceMessage>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaintenanceMessageCopyWith<$Res> {
  factory $MaintenanceMessageCopyWith(
    MaintenanceMessage value,
    $Res Function(MaintenanceMessage) then,
  ) =
      _$MaintenanceMessageCopyWithImpl<
        $Res,
        MaintenanceMessage
      >;
  @useResult
  $Res call({
    String? message,
    Security? security,
    MaintenanceMessageType? type,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    DateTime requestTime,
    Result? result,
  });

  $SecurityCopyWith<$Res>? get security;
  $ResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$MaintenanceMessageCopyWithImpl<
  $Res,
  $Val extends MaintenanceMessage
>
    implements $MaintenanceMessageCopyWith<$Res> {
  _$MaintenanceMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MaintenanceMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? security = freezed,
    Object? type = freezed,
    Object? requestTime = null,
    Object? result = freezed,
  }) {
    return _then(
      _value.copyWith(
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            security:
                freezed == security
                    ? _value.security
                    : security // ignore: cast_nullable_to_non_nullable
                        as Security?,
            type:
                freezed == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as MaintenanceMessageType?,
            requestTime:
                null == requestTime
                    ? _value.requestTime
                    : requestTime // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            result:
                freezed == result
                    ? _value.result
                    : result // ignore: cast_nullable_to_non_nullable
                        as Result?,
          )
          as $Val,
    );
  }

  /// Create a copy of MaintenanceMessage
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

  /// Create a copy of MaintenanceMessage
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
abstract class _$$MaintenanceMessageImplCopyWith<$Res>
    implements $MaintenanceMessageCopyWith<$Res> {
  factory _$$MaintenanceMessageImplCopyWith(
    _$MaintenanceMessageImpl value,
    $Res Function(_$MaintenanceMessageImpl) then,
  ) = __$$MaintenanceMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? message,
    Security? security,
    MaintenanceMessageType? type,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    DateTime requestTime,
    Result? result,
  });

  @override
  $SecurityCopyWith<$Res>? get security;
  @override
  $ResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$MaintenanceMessageImplCopyWithImpl<$Res>
    extends
        _$MaintenanceMessageCopyWithImpl<
          $Res,
          _$MaintenanceMessageImpl
        >
    implements _$$MaintenanceMessageImplCopyWith<$Res> {
  __$$MaintenanceMessageImplCopyWithImpl(
    _$MaintenanceMessageImpl _value,
    $Res Function(_$MaintenanceMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MaintenanceMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? security = freezed,
    Object? type = freezed,
    Object? requestTime = null,
    Object? result = freezed,
  }) {
    return _then(
      _$MaintenanceMessageImpl(
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        security:
            freezed == security
                ? _value.security
                : security // ignore: cast_nullable_to_non_nullable
                    as Security?,
        type:
            freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as MaintenanceMessageType?,
        requestTime:
            null == requestTime
                ? _value.requestTime
                : requestTime // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        result:
            freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                    as Result?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MaintenanceMessageImpl
    implements _MaintenanceMessage {
  const _$MaintenanceMessageImpl({
    required this.message,
    required this.security,
    required this.type,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    required this.requestTime,
    required this.result,
  });

  factory _$MaintenanceMessageImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MaintenanceMessageImplFromJson(json);

  @override
  final String? message;
  @override
  final Security? security;
  @override
  final MaintenanceMessageType? type;
  @override
  @JsonKey(
    fromJson: dateTimeFromString,
    toJson: dateTimeToString,
  )
  final DateTime requestTime;
  @override
  final Result? result;

  @override
  String toString() {
    return 'MaintenanceMessage(message: $message, security: $security, type: $type, requestTime: $requestTime, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaintenanceMessageImpl &&
            (identical(other.message, message) ||
                other.message == message) &&
            (identical(other.security, security) ||
                other.security == security) &&
            (identical(other.type, type) ||
                other.type == type) &&
            (identical(other.requestTime, requestTime) ||
                other.requestTime == requestTime) &&
            (identical(other.result, result) ||
                other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    security,
    type,
    requestTime,
    result,
  );

  /// Create a copy of MaintenanceMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MaintenanceMessageImplCopyWith<
    _$MaintenanceMessageImpl
  >
  get copyWith => __$$MaintenanceMessageImplCopyWithImpl<
    _$MaintenanceMessageImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaintenanceMessageImplToJson(this);
  }
}

abstract class _MaintenanceMessage
    implements MaintenanceMessage {
  const factory _MaintenanceMessage({
    required final String? message,
    required final Security? security,
    required final MaintenanceMessageType? type,
    @JsonKey(
      fromJson: dateTimeFromString,
      toJson: dateTimeToString,
    )
    required final DateTime requestTime,
    required final Result? result,
  }) = _$MaintenanceMessageImpl;

  factory _MaintenanceMessage.fromJson(
    Map<String, dynamic> json,
  ) = _$MaintenanceMessageImpl.fromJson;

  @override
  String? get message;
  @override
  Security? get security;
  @override
  MaintenanceMessageType? get type;
  @override
  @JsonKey(
    fromJson: dateTimeFromString,
    toJson: dateTimeToString,
  )
  DateTime get requestTime;
  @override
  Result? get result;

  /// Create a copy of MaintenanceMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MaintenanceMessageImplCopyWith<
    _$MaintenanceMessageImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
