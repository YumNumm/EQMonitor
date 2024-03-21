// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_map_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

_EewHypocenterProperties _$EewHypocenterPropertiesFromJson(
    Map<String, dynamic> json) {
  return __EewHypocenterProperties.fromJson(json);
}

/// @nodoc
mixin _$EewHypocenterProperties {
  int get depth => throw _privateConstructorUsedError;
  double get magnitude => throw _privateConstructorUsedError;
  bool get isLowPrecise => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$EewHypocenterPropertiesCopyWith<_EewHypocenterProperties> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$EewHypocenterPropertiesCopyWith<$Res> {
  factory _$EewHypocenterPropertiesCopyWith(_EewHypocenterProperties value,
          $Res Function(_EewHypocenterProperties) then) =
      __$EewHypocenterPropertiesCopyWithImpl<$Res, _EewHypocenterProperties>;
  @useResult
  $Res call({int depth, double magnitude, bool isLowPrecise});
}

/// @nodoc
class __$EewHypocenterPropertiesCopyWithImpl<$Res,
        $Val extends _EewHypocenterProperties>
    implements _$EewHypocenterPropertiesCopyWith<$Res> {
  __$EewHypocenterPropertiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? depth = null,
    Object? magnitude = null,
    Object? isLowPrecise = null,
  }) {
    return _then(_value.copyWith(
      depth: null == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int,
      magnitude: null == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double,
      isLowPrecise: null == isLowPrecise
          ? _value.isLowPrecise
          : isLowPrecise // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EewHypocenterPropertiesImplCopyWith<$Res>
    implements _$EewHypocenterPropertiesCopyWith<$Res> {
  factory _$$_EewHypocenterPropertiesImplCopyWith(
          _$_EewHypocenterPropertiesImpl value,
          $Res Function(_$_EewHypocenterPropertiesImpl) then) =
      __$$_EewHypocenterPropertiesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int depth, double magnitude, bool isLowPrecise});
}

/// @nodoc
class __$$_EewHypocenterPropertiesImplCopyWithImpl<$Res>
    extends __$EewHypocenterPropertiesCopyWithImpl<$Res,
        _$_EewHypocenterPropertiesImpl>
    implements _$$_EewHypocenterPropertiesImplCopyWith<$Res> {
  __$$_EewHypocenterPropertiesImplCopyWithImpl(
      _$_EewHypocenterPropertiesImpl _value,
      $Res Function(_$_EewHypocenterPropertiesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? depth = null,
    Object? magnitude = null,
    Object? isLowPrecise = null,
  }) {
    return _then(_$_EewHypocenterPropertiesImpl(
      depth: null == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int,
      magnitude: null == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double,
      isLowPrecise: null == isLowPrecise
          ? _value.isLowPrecise
          : isLowPrecise // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EewHypocenterPropertiesImpl implements __EewHypocenterProperties {
  const _$_EewHypocenterPropertiesImpl(
      {required this.depth,
      required this.magnitude,
      required this.isLowPrecise});

  factory _$_EewHypocenterPropertiesImpl.fromJson(Map<String, dynamic> json) =>
      _$$_EewHypocenterPropertiesImplFromJson(json);

  @override
  final int depth;
  @override
  final double magnitude;
  @override
  final bool isLowPrecise;

  @override
  String toString() {
    return '_EewHypocenterProperties(depth: $depth, magnitude: $magnitude, isLowPrecise: $isLowPrecise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EewHypocenterPropertiesImpl &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.isLowPrecise, isLowPrecise) ||
                other.isLowPrecise == isLowPrecise));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, depth, magnitude, isLowPrecise);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EewHypocenterPropertiesImplCopyWith<_$_EewHypocenterPropertiesImpl>
      get copyWith => __$$_EewHypocenterPropertiesImplCopyWithImpl<
          _$_EewHypocenterPropertiesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EewHypocenterPropertiesImplToJson(
      this,
    );
  }
}

abstract class __EewHypocenterProperties implements _EewHypocenterProperties {
  const factory __EewHypocenterProperties(
      {required final int depth,
      required final double magnitude,
      required final bool isLowPrecise}) = _$_EewHypocenterPropertiesImpl;

  factory __EewHypocenterProperties.fromJson(Map<String, dynamic> json) =
      _$_EewHypocenterPropertiesImpl.fromJson;

  @override
  int get depth;
  @override
  double get magnitude;
  @override
  bool get isLowPrecise;
  @override
  @JsonKey(ignore: true)
  _$$_EewHypocenterPropertiesImplCopyWith<_$_EewHypocenterPropertiesImpl>
      get copyWith => throw _privateConstructorUsedError;
}
