// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'real_time_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RealTimeData _$RealTimeDataFromJson(Map<String, dynamic> json) {
  return _RealTimeData.fromJson(json);
}

/// @nodoc
mixin _$RealTimeData {
  DateTime? get dateTime => throw _privateConstructorUsedError;
  String? get packetType => throw _privateConstructorUsedError;
  String? get kyoshinType => throw _privateConstructorUsedError;
  String? get baseData => throw _privateConstructorUsedError;
  String? get baseSerialNo => throw _privateConstructorUsedError;
  List<double?>? get items => throw _privateConstructorUsedError;
  Result? get result => throw _privateConstructorUsedError;
  Security? get security => throw _privateConstructorUsedError;

  /// Serializes this RealTimeData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RealTimeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RealTimeDataCopyWith<RealTimeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RealTimeDataCopyWith<$Res> {
  factory $RealTimeDataCopyWith(
          RealTimeData value, $Res Function(RealTimeData) then) =
      _$RealTimeDataCopyWithImpl<$Res, RealTimeData>;
  @useResult
  $Res call(
      {DateTime? dateTime,
      String? packetType,
      String? kyoshinType,
      String? baseData,
      String? baseSerialNo,
      List<double?>? items,
      Result? result,
      Security? security});

  $ResultCopyWith<$Res>? get result;
  $SecurityCopyWith<$Res>? get security;
}

/// @nodoc
class _$RealTimeDataCopyWithImpl<$Res, $Val extends RealTimeData>
    implements $RealTimeDataCopyWith<$Res> {
  _$RealTimeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RealTimeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = freezed,
    Object? packetType = freezed,
    Object? kyoshinType = freezed,
    Object? baseData = freezed,
    Object? baseSerialNo = freezed,
    Object? items = freezed,
    Object? result = freezed,
    Object? security = freezed,
  }) {
    return _then(_value.copyWith(
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      packetType: freezed == packetType
          ? _value.packetType
          : packetType // ignore: cast_nullable_to_non_nullable
              as String?,
      kyoshinType: freezed == kyoshinType
          ? _value.kyoshinType
          : kyoshinType // ignore: cast_nullable_to_non_nullable
              as String?,
      baseData: freezed == baseData
          ? _value.baseData
          : baseData // ignore: cast_nullable_to_non_nullable
              as String?,
      baseSerialNo: freezed == baseSerialNo
          ? _value.baseSerialNo
          : baseSerialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<double?>?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      security: freezed == security
          ? _value.security
          : security // ignore: cast_nullable_to_non_nullable
              as Security?,
    ) as $Val);
  }

  /// Create a copy of RealTimeData
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

  /// Create a copy of RealTimeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SecurityCopyWith<$Res>? get security {
    if (_value.security == null) {
      return null;
    }

    return $SecurityCopyWith<$Res>(_value.security!, (value) {
      return _then(_value.copyWith(security: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RealTimeDataImplCopyWith<$Res>
    implements $RealTimeDataCopyWith<$Res> {
  factory _$$RealTimeDataImplCopyWith(
          _$RealTimeDataImpl value, $Res Function(_$RealTimeDataImpl) then) =
      __$$RealTimeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? dateTime,
      String? packetType,
      String? kyoshinType,
      String? baseData,
      String? baseSerialNo,
      List<double?>? items,
      Result? result,
      Security? security});

  @override
  $ResultCopyWith<$Res>? get result;
  @override
  $SecurityCopyWith<$Res>? get security;
}

/// @nodoc
class __$$RealTimeDataImplCopyWithImpl<$Res>
    extends _$RealTimeDataCopyWithImpl<$Res, _$RealTimeDataImpl>
    implements _$$RealTimeDataImplCopyWith<$Res> {
  __$$RealTimeDataImplCopyWithImpl(
      _$RealTimeDataImpl _value, $Res Function(_$RealTimeDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of RealTimeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = freezed,
    Object? packetType = freezed,
    Object? kyoshinType = freezed,
    Object? baseData = freezed,
    Object? baseSerialNo = freezed,
    Object? items = freezed,
    Object? result = freezed,
    Object? security = freezed,
  }) {
    return _then(_$RealTimeDataImpl(
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      packetType: freezed == packetType
          ? _value.packetType
          : packetType // ignore: cast_nullable_to_non_nullable
              as String?,
      kyoshinType: freezed == kyoshinType
          ? _value.kyoshinType
          : kyoshinType // ignore: cast_nullable_to_non_nullable
              as String?,
      baseData: freezed == baseData
          ? _value.baseData
          : baseData // ignore: cast_nullable_to_non_nullable
              as String?,
      baseSerialNo: freezed == baseSerialNo
          ? _value.baseSerialNo
          : baseSerialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<double?>?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      security: freezed == security
          ? _value.security
          : security // ignore: cast_nullable_to_non_nullable
              as Security?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RealTimeDataImpl implements _RealTimeData {
  const _$RealTimeDataImpl(
      {required this.dateTime,
      required this.packetType,
      required this.kyoshinType,
      required this.baseData,
      required this.baseSerialNo,
      required final List<double?>? items,
      required this.result,
      required this.security})
      : _items = items;

  factory _$RealTimeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$RealTimeDataImplFromJson(json);

  @override
  final DateTime? dateTime;
  @override
  final String? packetType;
  @override
  final String? kyoshinType;
  @override
  final String? baseData;
  @override
  final String? baseSerialNo;
  final List<double?>? _items;
  @override
  List<double?>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Result? result;
  @override
  final Security? security;

  @override
  String toString() {
    return 'RealTimeData(dateTime: $dateTime, packetType: $packetType, kyoshinType: $kyoshinType, baseData: $baseData, baseSerialNo: $baseSerialNo, items: $items, result: $result, security: $security)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RealTimeDataImpl &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.packetType, packetType) ||
                other.packetType == packetType) &&
            (identical(other.kyoshinType, kyoshinType) ||
                other.kyoshinType == kyoshinType) &&
            (identical(other.baseData, baseData) ||
                other.baseData == baseData) &&
            (identical(other.baseSerialNo, baseSerialNo) ||
                other.baseSerialNo == baseSerialNo) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.security, security) ||
                other.security == security));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dateTime,
      packetType,
      kyoshinType,
      baseData,
      baseSerialNo,
      const DeepCollectionEquality().hash(_items),
      result,
      security);

  /// Create a copy of RealTimeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RealTimeDataImplCopyWith<_$RealTimeDataImpl> get copyWith =>
      __$$RealTimeDataImplCopyWithImpl<_$RealTimeDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RealTimeDataImplToJson(
      this,
    );
  }
}

abstract class _RealTimeData implements RealTimeData {
  const factory _RealTimeData(
      {required final DateTime? dateTime,
      required final String? packetType,
      required final String? kyoshinType,
      required final String? baseData,
      required final String? baseSerialNo,
      required final List<double?>? items,
      required final Result? result,
      required final Security? security}) = _$RealTimeDataImpl;

  factory _RealTimeData.fromJson(Map<String, dynamic> json) =
      _$RealTimeDataImpl.fromJson;

  @override
  DateTime? get dateTime;
  @override
  String? get packetType;
  @override
  String? get kyoshinType;
  @override
  String? get baseData;
  @override
  String? get baseSerialNo;
  @override
  List<double?>? get items;
  @override
  Result? get result;
  @override
  Security? get security;

  /// Create a copy of RealTimeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RealTimeDataImplCopyWith<_$RealTimeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
