// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accuracy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EewAccuracy _$EewAccuracyFromJson(Map<String, dynamic> json) {
  return _EewAccuracy.fromJson(json);
}

/// @nodoc
mixin _$EewAccuracy {
  List<String> get epicenters => throw _privateConstructorUsedError;
  String get depth => throw _privateConstructorUsedError;
  String get magnitudeCalculation => throw _privateConstructorUsedError;
  String get numberOfMagnitudeCalculation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EewAccuracyCopyWith<EewAccuracy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewAccuracyCopyWith<$Res> {
  factory $EewAccuracyCopyWith(
          EewAccuracy value, $Res Function(EewAccuracy) then) =
      _$EewAccuracyCopyWithImpl<$Res, EewAccuracy>;
  @useResult
  $Res call(
      {List<String> epicenters,
      String depth,
      String magnitudeCalculation,
      String numberOfMagnitudeCalculation});
}

/// @nodoc
class _$EewAccuracyCopyWithImpl<$Res, $Val extends EewAccuracy>
    implements $EewAccuracyCopyWith<$Res> {
  _$EewAccuracyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? epicenters = null,
    Object? depth = null,
    Object? magnitudeCalculation = null,
    Object? numberOfMagnitudeCalculation = null,
  }) {
    return _then(_value.copyWith(
      epicenters: null == epicenters
          ? _value.epicenters
          : epicenters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      depth: null == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as String,
      magnitudeCalculation: null == magnitudeCalculation
          ? _value.magnitudeCalculation
          : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation
          ? _value.numberOfMagnitudeCalculation
          : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EewAccuracyCopyWith<$Res>
    implements $EewAccuracyCopyWith<$Res> {
  factory _$$_EewAccuracyCopyWith(
          _$_EewAccuracy value, $Res Function(_$_EewAccuracy) then) =
      __$$_EewAccuracyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> epicenters,
      String depth,
      String magnitudeCalculation,
      String numberOfMagnitudeCalculation});
}

/// @nodoc
class __$$_EewAccuracyCopyWithImpl<$Res>
    extends _$EewAccuracyCopyWithImpl<$Res, _$_EewAccuracy>
    implements _$$_EewAccuracyCopyWith<$Res> {
  __$$_EewAccuracyCopyWithImpl(
      _$_EewAccuracy _value, $Res Function(_$_EewAccuracy) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? epicenters = null,
    Object? depth = null,
    Object? magnitudeCalculation = null,
    Object? numberOfMagnitudeCalculation = null,
  }) {
    return _then(_$_EewAccuracy(
      epicenters: null == epicenters
          ? _value._epicenters
          : epicenters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      depth: null == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as String,
      magnitudeCalculation: null == magnitudeCalculation
          ? _value.magnitudeCalculation
          : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation
          ? _value.numberOfMagnitudeCalculation
          : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EewAccuracy implements _EewAccuracy {
  const _$_EewAccuracy(
      {required final List<String> epicenters,
      required this.depth,
      required this.magnitudeCalculation,
      required this.numberOfMagnitudeCalculation})
      : _epicenters = epicenters;

  factory _$_EewAccuracy.fromJson(Map<String, dynamic> json) =>
      _$$_EewAccuracyFromJson(json);

  final List<String> _epicenters;
  @override
  List<String> get epicenters {
    if (_epicenters is EqualUnmodifiableListView) return _epicenters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_epicenters);
  }

  @override
  final String depth;
  @override
  final String magnitudeCalculation;
  @override
  final String numberOfMagnitudeCalculation;

  @override
  String toString() {
    return 'EewAccuracy(epicenters: $epicenters, depth: $depth, magnitudeCalculation: $magnitudeCalculation, numberOfMagnitudeCalculation: $numberOfMagnitudeCalculation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EewAccuracy &&
            const DeepCollectionEquality()
                .equals(other._epicenters, _epicenters) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.magnitudeCalculation, magnitudeCalculation) ||
                other.magnitudeCalculation == magnitudeCalculation) &&
            (identical(other.numberOfMagnitudeCalculation,
                    numberOfMagnitudeCalculation) ||
                other.numberOfMagnitudeCalculation ==
                    numberOfMagnitudeCalculation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_epicenters),
      depth,
      magnitudeCalculation,
      numberOfMagnitudeCalculation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EewAccuracyCopyWith<_$_EewAccuracy> get copyWith =>
      __$$_EewAccuracyCopyWithImpl<_$_EewAccuracy>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EewAccuracyToJson(
      this,
    );
  }
}

abstract class _EewAccuracy implements EewAccuracy {
  const factory _EewAccuracy(
      {required final List<String> epicenters,
      required final String depth,
      required final String magnitudeCalculation,
      required final String numberOfMagnitudeCalculation}) = _$_EewAccuracy;

  factory _EewAccuracy.fromJson(Map<String, dynamic> json) =
      _$_EewAccuracy.fromJson;

  @override
  List<String> get epicenters;
  @override
  String get depth;
  @override
  String get magnitudeCalculation;
  @override
  String get numberOfMagnitudeCalculation;
  @override
  @JsonKey(ignore: true)
  _$$_EewAccuracyCopyWith<_$_EewAccuracy> get copyWith =>
      throw _privateConstructorUsedError;
}
