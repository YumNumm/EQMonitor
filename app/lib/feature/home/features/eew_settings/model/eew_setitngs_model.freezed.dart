// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_setitngs_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EewSetitngs _$EewSetitngsFromJson(Map<String, dynamic> json) {
  return _EewSetitngs.fromJson(json);
}

/// @nodoc
mixin _$EewSetitngs {
  bool get showCalculatedRegionIntensity => throw _privateConstructorUsedError;
  bool get showCalculatedCityIntensity => throw _privateConstructorUsedError;

  /// Serializes this EewSetitngs to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EewSetitngs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EewSetitngsCopyWith<EewSetitngs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewSetitngsCopyWith<$Res> {
  factory $EewSetitngsCopyWith(
          EewSetitngs value, $Res Function(EewSetitngs) then) =
      _$EewSetitngsCopyWithImpl<$Res, EewSetitngs>;
  @useResult
  $Res call(
      {bool showCalculatedRegionIntensity, bool showCalculatedCityIntensity});
}

/// @nodoc
class _$EewSetitngsCopyWithImpl<$Res, $Val extends EewSetitngs>
    implements $EewSetitngsCopyWith<$Res> {
  _$EewSetitngsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EewSetitngs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showCalculatedRegionIntensity = null,
    Object? showCalculatedCityIntensity = null,
  }) {
    return _then(_value.copyWith(
      showCalculatedRegionIntensity: null == showCalculatedRegionIntensity
          ? _value.showCalculatedRegionIntensity
          : showCalculatedRegionIntensity // ignore: cast_nullable_to_non_nullable
              as bool,
      showCalculatedCityIntensity: null == showCalculatedCityIntensity
          ? _value.showCalculatedCityIntensity
          : showCalculatedCityIntensity // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EewSetitngsImplCopyWith<$Res>
    implements $EewSetitngsCopyWith<$Res> {
  factory _$$EewSetitngsImplCopyWith(
          _$EewSetitngsImpl value, $Res Function(_$EewSetitngsImpl) then) =
      __$$EewSetitngsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool showCalculatedRegionIntensity, bool showCalculatedCityIntensity});
}

/// @nodoc
class __$$EewSetitngsImplCopyWithImpl<$Res>
    extends _$EewSetitngsCopyWithImpl<$Res, _$EewSetitngsImpl>
    implements _$$EewSetitngsImplCopyWith<$Res> {
  __$$EewSetitngsImplCopyWithImpl(
      _$EewSetitngsImpl _value, $Res Function(_$EewSetitngsImpl) _then)
      : super(_value, _then);

  /// Create a copy of EewSetitngs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showCalculatedRegionIntensity = null,
    Object? showCalculatedCityIntensity = null,
  }) {
    return _then(_$EewSetitngsImpl(
      showCalculatedRegionIntensity: null == showCalculatedRegionIntensity
          ? _value.showCalculatedRegionIntensity
          : showCalculatedRegionIntensity // ignore: cast_nullable_to_non_nullable
              as bool,
      showCalculatedCityIntensity: null == showCalculatedCityIntensity
          ? _value.showCalculatedCityIntensity
          : showCalculatedCityIntensity // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EewSetitngsImpl implements _EewSetitngs {
  const _$EewSetitngsImpl(
      {this.showCalculatedRegionIntensity = false,
      this.showCalculatedCityIntensity = false});

  factory _$EewSetitngsImpl.fromJson(Map<String, dynamic> json) =>
      _$$EewSetitngsImplFromJson(json);

  @override
  @JsonKey()
  final bool showCalculatedRegionIntensity;
  @override
  @JsonKey()
  final bool showCalculatedCityIntensity;

  @override
  String toString() {
    return 'EewSetitngs(showCalculatedRegionIntensity: $showCalculatedRegionIntensity, showCalculatedCityIntensity: $showCalculatedCityIntensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EewSetitngsImpl &&
            (identical(other.showCalculatedRegionIntensity,
                    showCalculatedRegionIntensity) ||
                other.showCalculatedRegionIntensity ==
                    showCalculatedRegionIntensity) &&
            (identical(other.showCalculatedCityIntensity,
                    showCalculatedCityIntensity) ||
                other.showCalculatedCityIntensity ==
                    showCalculatedCityIntensity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, showCalculatedRegionIntensity, showCalculatedCityIntensity);

  /// Create a copy of EewSetitngs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EewSetitngsImplCopyWith<_$EewSetitngsImpl> get copyWith =>
      __$$EewSetitngsImplCopyWithImpl<_$EewSetitngsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EewSetitngsImplToJson(
      this,
    );
  }
}

abstract class _EewSetitngs implements EewSetitngs {
  const factory _EewSetitngs(
      {final bool showCalculatedRegionIntensity,
      final bool showCalculatedCityIntensity}) = _$EewSetitngsImpl;

  factory _EewSetitngs.fromJson(Map<String, dynamic> json) =
      _$EewSetitngsImpl.fromJson;

  @override
  bool get showCalculatedRegionIntensity;
  @override
  bool get showCalculatedCityIntensity;

  /// Create a copy of EewSetitngs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EewSetitngsImplCopyWith<_$EewSetitngsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
