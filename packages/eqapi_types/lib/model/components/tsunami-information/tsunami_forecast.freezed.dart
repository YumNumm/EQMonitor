// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TsunamiForecast _$TsunamiForecastFromJson(Map<String, dynamic> json) {
  return _TsunamiForecast.fromJson(json);
}

/// @nodoc
mixin _$TsunamiForecast {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// 種別コードを用いる
  String get kind => throw _privateConstructorUsedError;
  String get lastKind => throw _privateConstructorUsedError;
  TsunamiForecastFirstHeight? get firstHeight =>
      throw _privateConstructorUsedError;
  TsunamiForecastMaxHeight? get maxHeight => throw _privateConstructorUsedError;
  List<TsunamiForecastStation>? get stations =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TsunamiForecastCopyWith<TsunamiForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiForecastCopyWith<$Res> {
  factory $TsunamiForecastCopyWith(
          TsunamiForecast value, $Res Function(TsunamiForecast) then) =
      _$TsunamiForecastCopyWithImpl<$Res, TsunamiForecast>;
  @useResult
  $Res call(
      {String code,
      String name,
      String kind,
      String lastKind,
      TsunamiForecastFirstHeight? firstHeight,
      TsunamiForecastMaxHeight? maxHeight,
      List<TsunamiForecastStation>? stations});

  $TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;
  $TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight;
}

/// @nodoc
class _$TsunamiForecastCopyWithImpl<$Res, $Val extends TsunamiForecast>
    implements $TsunamiForecastCopyWith<$Res> {
  _$TsunamiForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? kind = null,
    Object? lastKind = null,
    Object? firstHeight = freezed,
    Object? maxHeight = freezed,
    Object? stations = freezed,
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
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
      lastKind: null == lastKind
          ? _value.lastKind
          : lastKind // ignore: cast_nullable_to_non_nullable
              as String,
      firstHeight: freezed == firstHeight
          ? _value.firstHeight
          : firstHeight // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastFirstHeight?,
      maxHeight: freezed == maxHeight
          ? _value.maxHeight
          : maxHeight // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastMaxHeight?,
      stations: freezed == stations
          ? _value.stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiForecastStation>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_value.firstHeight == null) {
      return null;
    }

    return $TsunamiForecastFirstHeightCopyWith<$Res>(_value.firstHeight!,
        (value) {
      return _then(_value.copyWith(firstHeight: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight {
    if (_value.maxHeight == null) {
      return null;
    }

    return $TsunamiForecastMaxHeightCopyWith<$Res>(_value.maxHeight!, (value) {
      return _then(_value.copyWith(maxHeight: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TsunamiForecastImplCopyWith<$Res>
    implements $TsunamiForecastCopyWith<$Res> {
  factory _$$TsunamiForecastImplCopyWith(_$TsunamiForecastImpl value,
          $Res Function(_$TsunamiForecastImpl) then) =
      __$$TsunamiForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String name,
      String kind,
      String lastKind,
      TsunamiForecastFirstHeight? firstHeight,
      TsunamiForecastMaxHeight? maxHeight,
      List<TsunamiForecastStation>? stations});

  @override
  $TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;
  @override
  $TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight;
}

/// @nodoc
class __$$TsunamiForecastImplCopyWithImpl<$Res>
    extends _$TsunamiForecastCopyWithImpl<$Res, _$TsunamiForecastImpl>
    implements _$$TsunamiForecastImplCopyWith<$Res> {
  __$$TsunamiForecastImplCopyWithImpl(
      _$TsunamiForecastImpl _value, $Res Function(_$TsunamiForecastImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? kind = null,
    Object? lastKind = null,
    Object? firstHeight = freezed,
    Object? maxHeight = freezed,
    Object? stations = freezed,
  }) {
    return _then(_$TsunamiForecastImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
      lastKind: null == lastKind
          ? _value.lastKind
          : lastKind // ignore: cast_nullable_to_non_nullable
              as String,
      firstHeight: freezed == firstHeight
          ? _value.firstHeight
          : firstHeight // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastFirstHeight?,
      maxHeight: freezed == maxHeight
          ? _value.maxHeight
          : maxHeight // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastMaxHeight?,
      stations: freezed == stations
          ? _value._stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiForecastStation>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TsunamiForecastImpl implements _TsunamiForecast {
  const _$TsunamiForecastImpl(
      {required this.code,
      required this.name,
      required this.kind,
      required this.lastKind,
      required this.firstHeight,
      required this.maxHeight,
      required final List<TsunamiForecastStation>? stations})
      : _stations = stations;

  factory _$TsunamiForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$TsunamiForecastImplFromJson(json);

  @override
  final String code;
  @override
  final String name;

  /// 種別コードを用いる
  @override
  final String kind;
  @override
  final String lastKind;
  @override
  final TsunamiForecastFirstHeight? firstHeight;
  @override
  final TsunamiForecastMaxHeight? maxHeight;
  final List<TsunamiForecastStation>? _stations;
  @override
  List<TsunamiForecastStation>? get stations {
    final value = _stations;
    if (value == null) return null;
    if (_stations is EqualUnmodifiableListView) return _stations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TsunamiForecast(code: $code, name: $name, kind: $kind, lastKind: $lastKind, firstHeight: $firstHeight, maxHeight: $maxHeight, stations: $stations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiForecastImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.lastKind, lastKind) ||
                other.lastKind == lastKind) &&
            (identical(other.firstHeight, firstHeight) ||
                other.firstHeight == firstHeight) &&
            (identical(other.maxHeight, maxHeight) ||
                other.maxHeight == maxHeight) &&
            const DeepCollectionEquality().equals(other._stations, _stations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, kind, lastKind,
      firstHeight, maxHeight, const DeepCollectionEquality().hash(_stations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TsunamiForecastImplCopyWith<_$TsunamiForecastImpl> get copyWith =>
      __$$TsunamiForecastImplCopyWithImpl<_$TsunamiForecastImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiForecastImplToJson(
      this,
    );
  }
}

abstract class _TsunamiForecast implements TsunamiForecast {
  const factory _TsunamiForecast(
          {required final String code,
          required final String name,
          required final String kind,
          required final String lastKind,
          required final TsunamiForecastFirstHeight? firstHeight,
          required final TsunamiForecastMaxHeight? maxHeight,
          required final List<TsunamiForecastStation>? stations}) =
      _$TsunamiForecastImpl;

  factory _TsunamiForecast.fromJson(Map<String, dynamic> json) =
      _$TsunamiForecastImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override

  /// 種別コードを用いる
  String get kind;
  @override
  String get lastKind;
  @override
  TsunamiForecastFirstHeight? get firstHeight;
  @override
  TsunamiForecastMaxHeight? get maxHeight;
  @override
  List<TsunamiForecastStation>? get stations;
  @override
  @JsonKey(ignore: true)
  _$$TsunamiForecastImplCopyWith<_$TsunamiForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TsunamiForecastFirstHeight _$TsunamiForecastFirstHeightFromJson(
    Map<String, dynamic> json) {
  return _TsunamiForecastFirstHeight.fromJson(json);
}

/// @nodoc
mixin _$TsunamiForecastFirstHeight {
  DateTime? get arrivalTime => throw _privateConstructorUsedError;
  TsunamiForecastCondition? get condition => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TsunamiForecastFirstHeightCopyWith<TsunamiForecastFirstHeight>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiForecastFirstHeightCopyWith<$Res> {
  factory $TsunamiForecastFirstHeightCopyWith(TsunamiForecastFirstHeight value,
          $Res Function(TsunamiForecastFirstHeight) then) =
      _$TsunamiForecastFirstHeightCopyWithImpl<$Res,
          TsunamiForecastFirstHeight>;
  @useResult
  $Res call({DateTime? arrivalTime, TsunamiForecastCondition? condition});
}

/// @nodoc
class _$TsunamiForecastFirstHeightCopyWithImpl<$Res,
        $Val extends TsunamiForecastFirstHeight>
    implements $TsunamiForecastFirstHeightCopyWith<$Res> {
  _$TsunamiForecastFirstHeightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arrivalTime = freezed,
    Object? condition = freezed,
  }) {
    return _then(_value.copyWith(
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastCondition?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TsunamiForecastFirstHeightImplCopyWith<$Res>
    implements $TsunamiForecastFirstHeightCopyWith<$Res> {
  factory _$$TsunamiForecastFirstHeightImplCopyWith(
          _$TsunamiForecastFirstHeightImpl value,
          $Res Function(_$TsunamiForecastFirstHeightImpl) then) =
      __$$TsunamiForecastFirstHeightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? arrivalTime, TsunamiForecastCondition? condition});
}

/// @nodoc
class __$$TsunamiForecastFirstHeightImplCopyWithImpl<$Res>
    extends _$TsunamiForecastFirstHeightCopyWithImpl<$Res,
        _$TsunamiForecastFirstHeightImpl>
    implements _$$TsunamiForecastFirstHeightImplCopyWith<$Res> {
  __$$TsunamiForecastFirstHeightImplCopyWithImpl(
      _$TsunamiForecastFirstHeightImpl _value,
      $Res Function(_$TsunamiForecastFirstHeightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arrivalTime = freezed,
    Object? condition = freezed,
  }) {
    return _then(_$TsunamiForecastFirstHeightImpl(
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastCondition?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TsunamiForecastFirstHeightImpl implements _TsunamiForecastFirstHeight {
  const _$TsunamiForecastFirstHeightImpl(
      {required this.arrivalTime, required this.condition});

  factory _$TsunamiForecastFirstHeightImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$TsunamiForecastFirstHeightImplFromJson(json);

  @override
  final DateTime? arrivalTime;
  @override
  final TsunamiForecastCondition? condition;

  @override
  String toString() {
    return 'TsunamiForecastFirstHeight(arrivalTime: $arrivalTime, condition: $condition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiForecastFirstHeightImpl &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime) &&
            (identical(other.condition, condition) ||
                other.condition == condition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, arrivalTime, condition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TsunamiForecastFirstHeightImplCopyWith<_$TsunamiForecastFirstHeightImpl>
      get copyWith => __$$TsunamiForecastFirstHeightImplCopyWithImpl<
          _$TsunamiForecastFirstHeightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiForecastFirstHeightImplToJson(
      this,
    );
  }
}

abstract class _TsunamiForecastFirstHeight
    implements TsunamiForecastFirstHeight {
  const factory _TsunamiForecastFirstHeight(
          {required final DateTime? arrivalTime,
          required final TsunamiForecastCondition? condition}) =
      _$TsunamiForecastFirstHeightImpl;

  factory _TsunamiForecastFirstHeight.fromJson(Map<String, dynamic> json) =
      _$TsunamiForecastFirstHeightImpl.fromJson;

  @override
  DateTime? get arrivalTime;
  @override
  TsunamiForecastCondition? get condition;
  @override
  @JsonKey(ignore: true)
  _$$TsunamiForecastFirstHeightImplCopyWith<_$TsunamiForecastFirstHeightImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TsunamiForecastMaxHeight _$TsunamiForecastMaxHeightFromJson(
    Map<String, dynamic> json) {
  return _TsunamiForecastMaxHeight.fromJson(json);
}

/// @nodoc
mixin _$TsunamiForecastMaxHeight {
  double? get value => throw _privateConstructorUsedError;
  bool? get isOver => throw _privateConstructorUsedError;
  TsunamiForecastMaxHeightCondition? get condition =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TsunamiForecastMaxHeightCopyWith<TsunamiForecastMaxHeight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiForecastMaxHeightCopyWith<$Res> {
  factory $TsunamiForecastMaxHeightCopyWith(TsunamiForecastMaxHeight value,
          $Res Function(TsunamiForecastMaxHeight) then) =
      _$TsunamiForecastMaxHeightCopyWithImpl<$Res, TsunamiForecastMaxHeight>;
  @useResult
  $Res call(
      {double? value,
      bool? isOver,
      TsunamiForecastMaxHeightCondition? condition});
}

/// @nodoc
class _$TsunamiForecastMaxHeightCopyWithImpl<$Res,
        $Val extends TsunamiForecastMaxHeight>
    implements $TsunamiForecastMaxHeightCopyWith<$Res> {
  _$TsunamiForecastMaxHeightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? isOver = freezed,
    Object? condition = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      isOver: freezed == isOver
          ? _value.isOver
          : isOver // ignore: cast_nullable_to_non_nullable
              as bool?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastMaxHeightCondition?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TsunamiForecastMaxHeightImplCopyWith<$Res>
    implements $TsunamiForecastMaxHeightCopyWith<$Res> {
  factory _$$TsunamiForecastMaxHeightImplCopyWith(
          _$TsunamiForecastMaxHeightImpl value,
          $Res Function(_$TsunamiForecastMaxHeightImpl) then) =
      __$$TsunamiForecastMaxHeightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? value,
      bool? isOver,
      TsunamiForecastMaxHeightCondition? condition});
}

/// @nodoc
class __$$TsunamiForecastMaxHeightImplCopyWithImpl<$Res>
    extends _$TsunamiForecastMaxHeightCopyWithImpl<$Res,
        _$TsunamiForecastMaxHeightImpl>
    implements _$$TsunamiForecastMaxHeightImplCopyWith<$Res> {
  __$$TsunamiForecastMaxHeightImplCopyWithImpl(
      _$TsunamiForecastMaxHeightImpl _value,
      $Res Function(_$TsunamiForecastMaxHeightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? isOver = freezed,
    Object? condition = freezed,
  }) {
    return _then(_$TsunamiForecastMaxHeightImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      isOver: freezed == isOver
          ? _value.isOver
          : isOver // ignore: cast_nullable_to_non_nullable
              as bool?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastMaxHeightCondition?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TsunamiForecastMaxHeightImpl implements _TsunamiForecastMaxHeight {
  const _$TsunamiForecastMaxHeightImpl(
      {required this.value, required this.isOver, required this.condition});

  factory _$TsunamiForecastMaxHeightImpl.fromJson(Map<String, dynamic> json) =>
      _$$TsunamiForecastMaxHeightImplFromJson(json);

  @override
  final double? value;
  @override
  final bool? isOver;
  @override
  final TsunamiForecastMaxHeightCondition? condition;

  @override
  String toString() {
    return 'TsunamiForecastMaxHeight(value: $value, isOver: $isOver, condition: $condition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiForecastMaxHeightImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.isOver, isOver) || other.isOver == isOver) &&
            (identical(other.condition, condition) ||
                other.condition == condition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, isOver, condition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TsunamiForecastMaxHeightImplCopyWith<_$TsunamiForecastMaxHeightImpl>
      get copyWith => __$$TsunamiForecastMaxHeightImplCopyWithImpl<
          _$TsunamiForecastMaxHeightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiForecastMaxHeightImplToJson(
      this,
    );
  }
}

abstract class _TsunamiForecastMaxHeight implements TsunamiForecastMaxHeight {
  const factory _TsunamiForecastMaxHeight(
          {required final double? value,
          required final bool? isOver,
          required final TsunamiForecastMaxHeightCondition? condition}) =
      _$TsunamiForecastMaxHeightImpl;

  factory _TsunamiForecastMaxHeight.fromJson(Map<String, dynamic> json) =
      _$TsunamiForecastMaxHeightImpl.fromJson;

  @override
  double? get value;
  @override
  bool? get isOver;
  @override
  TsunamiForecastMaxHeightCondition? get condition;
  @override
  @JsonKey(ignore: true)
  _$$TsunamiForecastMaxHeightImplCopyWith<_$TsunamiForecastMaxHeightImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TsunamiForecastStation _$TsunamiForecastStationFromJson(
    Map<String, dynamic> json) {
  return _TsunamiForecastStation.fromJson(json);
}

/// @nodoc
mixin _$TsunamiForecastStation {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get highTideTime => throw _privateConstructorUsedError;
  DateTime? get firstHeightTime => throw _privateConstructorUsedError;
  TsunamiForecastStationCondition? get condition =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TsunamiForecastStationCopyWith<TsunamiForecastStation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiForecastStationCopyWith<$Res> {
  factory $TsunamiForecastStationCopyWith(TsunamiForecastStation value,
          $Res Function(TsunamiForecastStation) then) =
      _$TsunamiForecastStationCopyWithImpl<$Res, TsunamiForecastStation>;
  @useResult
  $Res call(
      {String code,
      String name,
      DateTime highTideTime,
      DateTime? firstHeightTime,
      TsunamiForecastStationCondition? condition});
}

/// @nodoc
class _$TsunamiForecastStationCopyWithImpl<$Res,
        $Val extends TsunamiForecastStation>
    implements $TsunamiForecastStationCopyWith<$Res> {
  _$TsunamiForecastStationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? highTideTime = null,
    Object? firstHeightTime = freezed,
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
      highTideTime: null == highTideTime
          ? _value.highTideTime
          : highTideTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      firstHeightTime: freezed == firstHeightTime
          ? _value.firstHeightTime
          : firstHeightTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastStationCondition?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TsunamiForecastStationImplCopyWith<$Res>
    implements $TsunamiForecastStationCopyWith<$Res> {
  factory _$$TsunamiForecastStationImplCopyWith(
          _$TsunamiForecastStationImpl value,
          $Res Function(_$TsunamiForecastStationImpl) then) =
      __$$TsunamiForecastStationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String name,
      DateTime highTideTime,
      DateTime? firstHeightTime,
      TsunamiForecastStationCondition? condition});
}

/// @nodoc
class __$$TsunamiForecastStationImplCopyWithImpl<$Res>
    extends _$TsunamiForecastStationCopyWithImpl<$Res,
        _$TsunamiForecastStationImpl>
    implements _$$TsunamiForecastStationImplCopyWith<$Res> {
  __$$TsunamiForecastStationImplCopyWithImpl(
      _$TsunamiForecastStationImpl _value,
      $Res Function(_$TsunamiForecastStationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? highTideTime = null,
    Object? firstHeightTime = freezed,
    Object? condition = freezed,
  }) {
    return _then(_$TsunamiForecastStationImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      highTideTime: null == highTideTime
          ? _value.highTideTime
          : highTideTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      firstHeightTime: freezed == firstHeightTime
          ? _value.firstHeightTime
          : firstHeightTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastStationCondition?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TsunamiForecastStationImpl implements _TsunamiForecastStation {
  const _$TsunamiForecastStationImpl(
      {required this.code,
      required this.name,
      required this.highTideTime,
      required this.firstHeightTime,
      required this.condition});

  factory _$TsunamiForecastStationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TsunamiForecastStationImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final DateTime highTideTime;
  @override
  final DateTime? firstHeightTime;
  @override
  final TsunamiForecastStationCondition? condition;

  @override
  String toString() {
    return 'TsunamiForecastStation(code: $code, name: $name, highTideTime: $highTideTime, firstHeightTime: $firstHeightTime, condition: $condition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiForecastStationImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.highTideTime, highTideTime) ||
                other.highTideTime == highTideTime) &&
            (identical(other.firstHeightTime, firstHeightTime) ||
                other.firstHeightTime == firstHeightTime) &&
            (identical(other.condition, condition) ||
                other.condition == condition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, name, highTideTime, firstHeightTime, condition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TsunamiForecastStationImplCopyWith<_$TsunamiForecastStationImpl>
      get copyWith => __$$TsunamiForecastStationImplCopyWithImpl<
          _$TsunamiForecastStationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiForecastStationImplToJson(
      this,
    );
  }
}

abstract class _TsunamiForecastStation implements TsunamiForecastStation {
  const factory _TsunamiForecastStation(
          {required final String code,
          required final String name,
          required final DateTime highTideTime,
          required final DateTime? firstHeightTime,
          required final TsunamiForecastStationCondition? condition}) =
      _$TsunamiForecastStationImpl;

  factory _TsunamiForecastStation.fromJson(Map<String, dynamic> json) =
      _$TsunamiForecastStationImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  DateTime get highTideTime;
  @override
  DateTime? get firstHeightTime;
  @override
  TsunamiForecastStationCondition? get condition;
  @override
  @JsonKey(ignore: true)
  _$$TsunamiForecastStationImplCopyWith<_$TsunamiForecastStationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
