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
abstract class _$$DoubleVectorImplCopyWith<$Res>
    implements $DoubleVectorCopyWith<$Res> {
  factory _$$DoubleVectorImplCopyWith(
          _$DoubleVectorImpl value, $Res Function(_$DoubleVectorImpl) then) =
      __$$DoubleVectorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y});
}

/// @nodoc
class __$$DoubleVectorImplCopyWithImpl<$Res>
    extends _$DoubleVectorCopyWithImpl<$Res, _$DoubleVectorImpl>
    implements _$$DoubleVectorImplCopyWith<$Res> {
  __$$DoubleVectorImplCopyWithImpl(
      _$DoubleVectorImpl _value, $Res Function(_$DoubleVectorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$DoubleVectorImpl(
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
class _$DoubleVectorImpl implements _DoubleVector {
  const _$DoubleVectorImpl({required this.x, required this.y});

  factory _$DoubleVectorImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoubleVectorImplFromJson(json);

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
            other is _$DoubleVectorImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DoubleVectorImplCopyWith<_$DoubleVectorImpl> get copyWith =>
      __$$DoubleVectorImplCopyWithImpl<_$DoubleVectorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoubleVectorImplToJson(
      this,
    );
  }
}

abstract class _DoubleVector implements DoubleVector {
  const factory _DoubleVector(
      {required final double x, required final double y}) = _$DoubleVectorImpl;

  factory _DoubleVector.fromJson(Map<String, dynamic> json) =
      _$DoubleVectorImpl.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  @JsonKey(ignore: true)
  _$$DoubleVectorImplCopyWith<_$DoubleVectorImpl> get copyWith =>
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
abstract class _$$IntVectorImplCopyWith<$Res>
    implements $IntVectorCopyWith<$Res> {
  factory _$$IntVectorImplCopyWith(
          _$IntVectorImpl value, $Res Function(_$IntVectorImpl) then) =
      __$$IntVectorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class __$$IntVectorImplCopyWithImpl<$Res>
    extends _$IntVectorCopyWithImpl<$Res, _$IntVectorImpl>
    implements _$$IntVectorImplCopyWith<$Res> {
  __$$IntVectorImplCopyWithImpl(
      _$IntVectorImpl _value, $Res Function(_$IntVectorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$IntVectorImpl(
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
class _$IntVectorImpl implements _IntVector {
  const _$IntVectorImpl({required this.x, required this.y});

  factory _$IntVectorImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntVectorImplFromJson(json);

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
            other is _$IntVectorImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntVectorImplCopyWith<_$IntVectorImpl> get copyWith =>
      __$$IntVectorImplCopyWithImpl<_$IntVectorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntVectorImplToJson(
      this,
    );
  }
}

abstract class _IntVector implements IntVector {
  const factory _IntVector({required final int x, required final int y}) =
      _$IntVectorImpl;

  factory _IntVector.fromJson(Map<String, dynamic> json) =
      _$IntVectorImpl.fromJson;

  @override
  int get x;
  @override
  int get y;
  @override
  @JsonKey(ignore: true)
  _$$IntVectorImplCopyWith<_$IntVectorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
