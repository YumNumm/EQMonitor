// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vector.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DoubleVector _$DoubleVectorFromJson(Map<String, dynamic> json) {
  return _DoubleVector.fromJson(json);
}

/// @nodoc
mixin _$DoubleVector {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoubleVectorCopyWith<DoubleVector> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoubleVectorCopyWith<$Res> {
  factory $DoubleVectorCopyWith(
          DoubleVector value, $Res Function(DoubleVector) then) =
      _$DoubleVectorCopyWithImpl<$Res, DoubleVector>;
  @useResult
  $Res call({double x, double y});
}

/// @nodoc
class _$DoubleVectorCopyWithImpl<$Res, $Val extends DoubleVector>
    implements $DoubleVectorCopyWith<$Res> {
  _$DoubleVectorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DoubleVectorCopyWith<$Res>
    implements $DoubleVectorCopyWith<$Res> {
  factory _$$_DoubleVectorCopyWith(
          _$_DoubleVector value, $Res Function(_$_DoubleVector) then) =
      __$$_DoubleVectorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y});
}

/// @nodoc
class __$$_DoubleVectorCopyWithImpl<$Res>
    extends _$DoubleVectorCopyWithImpl<$Res, _$_DoubleVector>
    implements _$$_DoubleVectorCopyWith<$Res> {
  __$$_DoubleVectorCopyWithImpl(
      _$_DoubleVector _value, $Res Function(_$_DoubleVector) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$_DoubleVector(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DoubleVector implements _DoubleVector {
  const _$_DoubleVector({required this.x, required this.y});

  factory _$_DoubleVector.fromJson(Map<String, dynamic> json) =>
      _$$_DoubleVectorFromJson(json);

  @override
  final double x;
  @override
  final double y;

  @override
  String toString() {
    return 'DoubleVector(x: $x, y: $y)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DoubleVector &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DoubleVectorCopyWith<_$_DoubleVector> get copyWith =>
      __$$_DoubleVectorCopyWithImpl<_$_DoubleVector>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DoubleVectorToJson(
      this,
    );
  }
}

abstract class _DoubleVector implements DoubleVector {
  const factory _DoubleVector(
      {required final double x, required final double y}) = _$_DoubleVector;

  factory _DoubleVector.fromJson(Map<String, dynamic> json) =
      _$_DoubleVector.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  @JsonKey(ignore: true)
  _$$_DoubleVectorCopyWith<_$_DoubleVector> get copyWith =>
      throw _privateConstructorUsedError;
}

IntVector _$IntVectorFromJson(Map<String, dynamic> json) {
  return _IntVector.fromJson(json);
}

/// @nodoc
mixin _$IntVector {
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntVectorCopyWith<IntVector> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntVectorCopyWith<$Res> {
  factory $IntVectorCopyWith(IntVector value, $Res Function(IntVector) then) =
      _$IntVectorCopyWithImpl<$Res, IntVector>;
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class _$IntVectorCopyWithImpl<$Res, $Val extends IntVector>
    implements $IntVectorCopyWith<$Res> {
  _$IntVectorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IntVectorCopyWith<$Res> implements $IntVectorCopyWith<$Res> {
  factory _$$_IntVectorCopyWith(
          _$_IntVector value, $Res Function(_$_IntVector) then) =
      __$$_IntVectorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class __$$_IntVectorCopyWithImpl<$Res>
    extends _$IntVectorCopyWithImpl<$Res, _$_IntVector>
    implements _$$_IntVectorCopyWith<$Res> {
  __$$_IntVectorCopyWithImpl(
      _$_IntVector _value, $Res Function(_$_IntVector) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$_IntVector(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IntVector implements _IntVector {
  const _$_IntVector({required this.x, required this.y});

  factory _$_IntVector.fromJson(Map<String, dynamic> json) =>
      _$$_IntVectorFromJson(json);

  @override
  final int x;
  @override
  final int y;

  @override
  String toString() {
    return 'IntVector(x: $x, y: $y)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IntVector &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IntVectorCopyWith<_$_IntVector> get copyWith =>
      __$$_IntVectorCopyWithImpl<_$_IntVector>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IntVectorToJson(
      this,
    );
  }
}

abstract class _IntVector implements IntVector {
  const factory _IntVector({required final int x, required final int y}) =
      _$_IntVector;

  factory _IntVector.fromJson(Map<String, dynamic> json) =
      _$_IntVector.fromJson;

  @override
  int get x;
  @override
  int get y;
  @override
  @JsonKey(ignore: true)
  _$$_IntVectorCopyWith<_$_IntVector> get copyWith =>
      throw _privateConstructorUsedError;
}
