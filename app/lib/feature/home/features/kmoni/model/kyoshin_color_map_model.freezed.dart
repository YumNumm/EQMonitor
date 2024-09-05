// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_color_map_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KyoshinColorMapModel _$KyoshinColorMapModelFromJson(Map<String, dynamic> json) {
  return _KyoshinColorMapModel.fromJson(json);
}

/// @nodoc
mixin _$KyoshinColorMapModel {
  double get intensity => throw _privateConstructorUsedError;
  int get r => throw _privateConstructorUsedError;
  int get g => throw _privateConstructorUsedError;
  int get b => throw _privateConstructorUsedError;

  /// Serializes this KyoshinColorMapModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KyoshinColorMapModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinColorMapModelCopyWith<KyoshinColorMapModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinColorMapModelCopyWith<$Res> {
  factory $KyoshinColorMapModelCopyWith(KyoshinColorMapModel value,
          $Res Function(KyoshinColorMapModel) then) =
      _$KyoshinColorMapModelCopyWithImpl<$Res, KyoshinColorMapModel>;
  @useResult
  $Res call({double intensity, int r, int g, int b});
}

/// @nodoc
class _$KyoshinColorMapModelCopyWithImpl<$Res,
        $Val extends KyoshinColorMapModel>
    implements $KyoshinColorMapModelCopyWith<$Res> {
  _$KyoshinColorMapModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinColorMapModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensity = null,
    Object? r = null,
    Object? g = null,
    Object? b = null,
  }) {
    return _then(_value.copyWith(
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as double,
      r: null == r
          ? _value.r
          : r // ignore: cast_nullable_to_non_nullable
              as int,
      g: null == g
          ? _value.g
          : g // ignore: cast_nullable_to_non_nullable
              as int,
      b: null == b
          ? _value.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KyoshinColorMapModelImplCopyWith<$Res>
    implements $KyoshinColorMapModelCopyWith<$Res> {
  factory _$$KyoshinColorMapModelImplCopyWith(_$KyoshinColorMapModelImpl value,
          $Res Function(_$KyoshinColorMapModelImpl) then) =
      __$$KyoshinColorMapModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double intensity, int r, int g, int b});
}

/// @nodoc
class __$$KyoshinColorMapModelImplCopyWithImpl<$Res>
    extends _$KyoshinColorMapModelCopyWithImpl<$Res, _$KyoshinColorMapModelImpl>
    implements _$$KyoshinColorMapModelImplCopyWith<$Res> {
  __$$KyoshinColorMapModelImplCopyWithImpl(_$KyoshinColorMapModelImpl _value,
      $Res Function(_$KyoshinColorMapModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of KyoshinColorMapModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensity = null,
    Object? r = null,
    Object? g = null,
    Object? b = null,
  }) {
    return _then(_$KyoshinColorMapModelImpl(
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as double,
      r: null == r
          ? _value.r
          : r // ignore: cast_nullable_to_non_nullable
              as int,
      g: null == g
          ? _value.g
          : g // ignore: cast_nullable_to_non_nullable
              as int,
      b: null == b
          ? _value.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinColorMapModelImpl implements _KyoshinColorMapModel {
  const _$KyoshinColorMapModelImpl(
      {required this.intensity,
      required this.r,
      required this.g,
      required this.b});

  factory _$KyoshinColorMapModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KyoshinColorMapModelImplFromJson(json);

  @override
  final double intensity;
  @override
  final int r;
  @override
  final int g;
  @override
  final int b;

  @override
  String toString() {
    return 'KyoshinColorMapModel(intensity: $intensity, r: $r, g: $g, b: $b)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinColorMapModelImpl &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.r, r) || other.r == r) &&
            (identical(other.g, g) || other.g == g) &&
            (identical(other.b, b) || other.b == b));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, intensity, r, g, b);

  /// Create a copy of KyoshinColorMapModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinColorMapModelImplCopyWith<_$KyoshinColorMapModelImpl>
      get copyWith =>
          __$$KyoshinColorMapModelImplCopyWithImpl<_$KyoshinColorMapModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinColorMapModelImplToJson(
      this,
    );
  }
}

abstract class _KyoshinColorMapModel implements KyoshinColorMapModel {
  const factory _KyoshinColorMapModel(
      {required final double intensity,
      required final int r,
      required final int g,
      required final int b}) = _$KyoshinColorMapModelImpl;

  factory _KyoshinColorMapModel.fromJson(Map<String, dynamic> json) =
      _$KyoshinColorMapModelImpl.fromJson;

  @override
  double get intensity;
  @override
  int get r;
  @override
  int get g;
  @override
  int get b;

  /// Create a copy of KyoshinColorMapModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinColorMapModelImplCopyWith<_$KyoshinColorMapModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
