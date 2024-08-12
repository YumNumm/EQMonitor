// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_observations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TsunamiObservation _$TsunamiObservationFromJson(Map<String, dynamic> json) {
  return _TsunamiObservation.fromJson(json);
}

/// @nodoc
mixin _$TsunamiObservation {
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  List<TsunamiObservationStation> get stations =>
      throw _privateConstructorUsedError;

  /// Serializes this TsunamiObservation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TsunamiObservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TsunamiObservationCopyWith<TsunamiObservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiObservationCopyWith<$Res> {
  factory $TsunamiObservationCopyWith(
          TsunamiObservation value, $Res Function(TsunamiObservation) then) =
      _$TsunamiObservationCopyWithImpl<$Res, TsunamiObservation>;
  @useResult
  $Res call(
      {String? code, String? name, List<TsunamiObservationStation> stations});
}

/// @nodoc
class _$TsunamiObservationCopyWithImpl<$Res, $Val extends TsunamiObservation>
    implements $TsunamiObservationCopyWith<$Res> {
  _$TsunamiObservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TsunamiObservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? stations = null,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      stations: null == stations
          ? _value.stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiObservationStation>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TsunamiObservationImplCopyWith<$Res>
    implements $TsunamiObservationCopyWith<$Res> {
  factory _$$TsunamiObservationImplCopyWith(_$TsunamiObservationImpl value,
          $Res Function(_$TsunamiObservationImpl) then) =
      __$$TsunamiObservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code, String? name, List<TsunamiObservationStation> stations});
}

/// @nodoc
class __$$TsunamiObservationImplCopyWithImpl<$Res>
    extends _$TsunamiObservationCopyWithImpl<$Res, _$TsunamiObservationImpl>
    implements _$$TsunamiObservationImplCopyWith<$Res> {
  __$$TsunamiObservationImplCopyWithImpl(_$TsunamiObservationImpl _value,
      $Res Function(_$TsunamiObservationImpl) _then)
      : super(_value, _then);

  /// Create a copy of TsunamiObservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? stations = null,
  }) {
    return _then(_$TsunamiObservationImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      stations: null == stations
          ? _value._stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiObservationStation>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TsunamiObservationImpl implements _TsunamiObservation {
  const _$TsunamiObservationImpl(
      {required this.code,
      required this.name,
      required final List<TsunamiObservationStation> stations})
      : _stations = stations;

  factory _$TsunamiObservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TsunamiObservationImplFromJson(json);

  @override
  final String? code;
  @override
  final String? name;
  final List<TsunamiObservationStation> _stations;
  @override
  List<TsunamiObservationStation> get stations {
    if (_stations is EqualUnmodifiableListView) return _stations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stations);
  }

  @override
  String toString() {
    return 'TsunamiObservation(code: $code, name: $name, stations: $stations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiObservationImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._stations, _stations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, name, const DeepCollectionEquality().hash(_stations));

  /// Create a copy of TsunamiObservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TsunamiObservationImplCopyWith<_$TsunamiObservationImpl> get copyWith =>
      __$$TsunamiObservationImplCopyWithImpl<_$TsunamiObservationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiObservationImplToJson(
      this,
    );
  }
}

abstract class _TsunamiObservation implements TsunamiObservation {
  const factory _TsunamiObservation(
          {required final String? code,
          required final String? name,
          required final List<TsunamiObservationStation> stations}) =
      _$TsunamiObservationImpl;

  factory _TsunamiObservation.fromJson(Map<String, dynamic> json) =
      _$TsunamiObservationImpl.fromJson;

  @override
  String? get code;
  @override
  String? get name;
  @override
  List<TsunamiObservationStation> get stations;

  /// Create a copy of TsunamiObservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TsunamiObservationImplCopyWith<_$TsunamiObservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TsunamiObservationStation _$TsunamiObservationStationFromJson(
    Map<String, dynamic> json) {
  return _TsunamiObservationStation.fromJson(json);
}

/// @nodoc
mixin _$TsunamiObservationStation {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// nullの時は`識別不能`
  DateTime? get firstHeightArrivalTime => throw _privateConstructorUsedError;
  TsunamiObservationFirstHeightInitial? get firstHeightInitial =>
      throw _privateConstructorUsedError;
  DateTime? get maxHeightTime => throw _privateConstructorUsedError;
  double? get maxHeightValue => throw _privateConstructorUsedError;

  /// `maxHeightValue`「以上」かどうか
  bool? get maxHeightIsOver => throw _privateConstructorUsedError;

  ///  上昇中かどうか
  bool? get maxHeightIsRising => throw _privateConstructorUsedError;
  TsunamiObservationStationCondition? get condition =>
      throw _privateConstructorUsedError;

  /// Serializes this TsunamiObservationStation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TsunamiObservationStation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TsunamiObservationStationCopyWith<TsunamiObservationStation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiObservationStationCopyWith<$Res> {
  factory $TsunamiObservationStationCopyWith(TsunamiObservationStation value,
          $Res Function(TsunamiObservationStation) then) =
      _$TsunamiObservationStationCopyWithImpl<$Res, TsunamiObservationStation>;
  @useResult
  $Res call(
      {String code,
      String name,
      DateTime? firstHeightArrivalTime,
      TsunamiObservationFirstHeightInitial? firstHeightInitial,
      DateTime? maxHeightTime,
      double? maxHeightValue,
      bool? maxHeightIsOver,
      bool? maxHeightIsRising,
      TsunamiObservationStationCondition? condition});
}

/// @nodoc
class _$TsunamiObservationStationCopyWithImpl<$Res,
        $Val extends TsunamiObservationStation>
    implements $TsunamiObservationStationCopyWith<$Res> {
  _$TsunamiObservationStationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TsunamiObservationStation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? firstHeightArrivalTime = freezed,
    Object? firstHeightInitial = freezed,
    Object? maxHeightTime = freezed,
    Object? maxHeightValue = freezed,
    Object? maxHeightIsOver = freezed,
    Object? maxHeightIsRising = freezed,
    Object? condition = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      firstHeightArrivalTime: freezed == firstHeightArrivalTime
          ? _value.firstHeightArrivalTime
          : firstHeightArrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      firstHeightInitial: freezed == firstHeightInitial
          ? _value.firstHeightInitial
          : firstHeightInitial // ignore: cast_nullable_to_non_nullable
              as TsunamiObservationFirstHeightInitial?,
      maxHeightTime: freezed == maxHeightTime
          ? _value.maxHeightTime
          : maxHeightTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      maxHeightValue: freezed == maxHeightValue
          ? _value.maxHeightValue
          : maxHeightValue // ignore: cast_nullable_to_non_nullable
              as double?,
      maxHeightIsOver: freezed == maxHeightIsOver
          ? _value.maxHeightIsOver
          : maxHeightIsOver // ignore: cast_nullable_to_non_nullable
              as bool?,
      maxHeightIsRising: freezed == maxHeightIsRising
          ? _value.maxHeightIsRising
          : maxHeightIsRising // ignore: cast_nullable_to_non_nullable
              as bool?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as TsunamiObservationStationCondition?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TsunamiObservationStationImplCopyWith<$Res>
    implements $TsunamiObservationStationCopyWith<$Res> {
  factory _$$TsunamiObservationStationImplCopyWith(
          _$TsunamiObservationStationImpl value,
          $Res Function(_$TsunamiObservationStationImpl) then) =
      __$$TsunamiObservationStationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String name,
      DateTime? firstHeightArrivalTime,
      TsunamiObservationFirstHeightInitial? firstHeightInitial,
      DateTime? maxHeightTime,
      double? maxHeightValue,
      bool? maxHeightIsOver,
      bool? maxHeightIsRising,
      TsunamiObservationStationCondition? condition});
}

/// @nodoc
class __$$TsunamiObservationStationImplCopyWithImpl<$Res>
    extends _$TsunamiObservationStationCopyWithImpl<$Res,
        _$TsunamiObservationStationImpl>
    implements _$$TsunamiObservationStationImplCopyWith<$Res> {
  __$$TsunamiObservationStationImplCopyWithImpl(
      _$TsunamiObservationStationImpl _value,
      $Res Function(_$TsunamiObservationStationImpl) _then)
      : super(_value, _then);

  /// Create a copy of TsunamiObservationStation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? firstHeightArrivalTime = freezed,
    Object? firstHeightInitial = freezed,
    Object? maxHeightTime = freezed,
    Object? maxHeightValue = freezed,
    Object? maxHeightIsOver = freezed,
    Object? maxHeightIsRising = freezed,
    Object? condition = freezed,
  }) {
    return _then(_$TsunamiObservationStationImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      firstHeightArrivalTime: freezed == firstHeightArrivalTime
          ? _value.firstHeightArrivalTime
          : firstHeightArrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      firstHeightInitial: freezed == firstHeightInitial
          ? _value.firstHeightInitial
          : firstHeightInitial // ignore: cast_nullable_to_non_nullable
              as TsunamiObservationFirstHeightInitial?,
      maxHeightTime: freezed == maxHeightTime
          ? _value.maxHeightTime
          : maxHeightTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      maxHeightValue: freezed == maxHeightValue
          ? _value.maxHeightValue
          : maxHeightValue // ignore: cast_nullable_to_non_nullable
              as double?,
      maxHeightIsOver: freezed == maxHeightIsOver
          ? _value.maxHeightIsOver
          : maxHeightIsOver // ignore: cast_nullable_to_non_nullable
              as bool?,
      maxHeightIsRising: freezed == maxHeightIsRising
          ? _value.maxHeightIsRising
          : maxHeightIsRising // ignore: cast_nullable_to_non_nullable
              as bool?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as TsunamiObservationStationCondition?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TsunamiObservationStationImpl implements _TsunamiObservationStation {
  const _$TsunamiObservationStationImpl(
      {required this.code,
      required this.name,
      required this.firstHeightArrivalTime,
      required this.firstHeightInitial,
      required this.maxHeightTime,
      required this.maxHeightValue,
      required this.maxHeightIsOver,
      required this.maxHeightIsRising,
      required this.condition});

  factory _$TsunamiObservationStationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TsunamiObservationStationImplFromJson(json);

  @override
  final String code;
  @override
  final String name;

  /// nullの時は`識別不能`
  @override
  final DateTime? firstHeightArrivalTime;
  @override
  final TsunamiObservationFirstHeightInitial? firstHeightInitial;
  @override
  final DateTime? maxHeightTime;
  @override
  final double? maxHeightValue;

  /// `maxHeightValue`「以上」かどうか
  @override
  final bool? maxHeightIsOver;

  ///  上昇中かどうか
  @override
  final bool? maxHeightIsRising;
  @override
  final TsunamiObservationStationCondition? condition;

  @override
  String toString() {
    return 'TsunamiObservationStation(code: $code, name: $name, firstHeightArrivalTime: $firstHeightArrivalTime, firstHeightInitial: $firstHeightInitial, maxHeightTime: $maxHeightTime, maxHeightValue: $maxHeightValue, maxHeightIsOver: $maxHeightIsOver, maxHeightIsRising: $maxHeightIsRising, condition: $condition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiObservationStationImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.firstHeightArrivalTime, firstHeightArrivalTime) ||
                other.firstHeightArrivalTime == firstHeightArrivalTime) &&
            (identical(other.firstHeightInitial, firstHeightInitial) ||
                other.firstHeightInitial == firstHeightInitial) &&
            (identical(other.maxHeightTime, maxHeightTime) ||
                other.maxHeightTime == maxHeightTime) &&
            (identical(other.maxHeightValue, maxHeightValue) ||
                other.maxHeightValue == maxHeightValue) &&
            (identical(other.maxHeightIsOver, maxHeightIsOver) ||
                other.maxHeightIsOver == maxHeightIsOver) &&
            (identical(other.maxHeightIsRising, maxHeightIsRising) ||
                other.maxHeightIsRising == maxHeightIsRising) &&
            (identical(other.condition, condition) ||
                other.condition == condition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      code,
      name,
      firstHeightArrivalTime,
      firstHeightInitial,
      maxHeightTime,
      maxHeightValue,
      maxHeightIsOver,
      maxHeightIsRising,
      condition);

  /// Create a copy of TsunamiObservationStation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TsunamiObservationStationImplCopyWith<_$TsunamiObservationStationImpl>
      get copyWith => __$$TsunamiObservationStationImplCopyWithImpl<
          _$TsunamiObservationStationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiObservationStationImplToJson(
      this,
    );
  }
}

abstract class _TsunamiObservationStation implements TsunamiObservationStation {
  const factory _TsunamiObservationStation(
      {required final String code,
      required final String name,
      required final DateTime? firstHeightArrivalTime,
      required final TsunamiObservationFirstHeightInitial? firstHeightInitial,
      required final DateTime? maxHeightTime,
      required final double? maxHeightValue,
      required final bool? maxHeightIsOver,
      required final bool? maxHeightIsRising,
      required final TsunamiObservationStationCondition?
          condition}) = _$TsunamiObservationStationImpl;

  factory _TsunamiObservationStation.fromJson(Map<String, dynamic> json) =
      _$TsunamiObservationStationImpl.fromJson;

  @override
  String get code;
  @override
  String get name;

  /// nullの時は`識別不能`
  @override
  DateTime? get firstHeightArrivalTime;
  @override
  TsunamiObservationFirstHeightInitial? get firstHeightInitial;
  @override
  DateTime? get maxHeightTime;
  @override
  double? get maxHeightValue;

  /// `maxHeightValue`「以上」かどうか
  @override
  bool? get maxHeightIsOver;

  ///  上昇中かどうか
  @override
  bool? get maxHeightIsRising;
  @override
  TsunamiObservationStationCondition? get condition;

  /// Create a copy of TsunamiObservationStation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TsunamiObservationStationImplCopyWith<_$TsunamiObservationStationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
