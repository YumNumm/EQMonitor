// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vtse52.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PublicBodyVtse52Tsunami _$PublicBodyVtse52TsunamiFromJson(
    Map<String, dynamic> json) {
  return _PublicBodyVtse52Tsunami.fromJson(json);
}

/// @nodoc
mixin _$PublicBodyVtse52Tsunami {
  List<TsunamiObservation>? get observations =>
      throw _privateConstructorUsedError;
  List<TsunamiEstimation> get estimations => throw _privateConstructorUsedError;

  /// Serializes this PublicBodyVtse52Tsunami to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublicBodyVtse52Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublicBodyVtse52TsunamiCopyWith<PublicBodyVtse52Tsunami> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicBodyVtse52TsunamiCopyWith<$Res> {
  factory $PublicBodyVtse52TsunamiCopyWith(PublicBodyVtse52Tsunami value,
          $Res Function(PublicBodyVtse52Tsunami) then) =
      _$PublicBodyVtse52TsunamiCopyWithImpl<$Res, PublicBodyVtse52Tsunami>;
  @useResult
  $Res call(
      {List<TsunamiObservation>? observations,
      List<TsunamiEstimation> estimations});
}

/// @nodoc
class _$PublicBodyVtse52TsunamiCopyWithImpl<$Res,
        $Val extends PublicBodyVtse52Tsunami>
    implements $PublicBodyVtse52TsunamiCopyWith<$Res> {
  _$PublicBodyVtse52TsunamiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublicBodyVtse52Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observations = freezed,
    Object? estimations = null,
  }) {
    return _then(_value.copyWith(
      observations: freezed == observations
          ? _value.observations
          : observations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiObservation>?,
      estimations: null == estimations
          ? _value.estimations
          : estimations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiEstimation>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PublicBodyVtse52TsunamiImplCopyWith<$Res>
    implements $PublicBodyVtse52TsunamiCopyWith<$Res> {
  factory _$$PublicBodyVtse52TsunamiImplCopyWith(
          _$PublicBodyVtse52TsunamiImpl value,
          $Res Function(_$PublicBodyVtse52TsunamiImpl) then) =
      __$$PublicBodyVtse52TsunamiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TsunamiObservation>? observations,
      List<TsunamiEstimation> estimations});
}

/// @nodoc
class __$$PublicBodyVtse52TsunamiImplCopyWithImpl<$Res>
    extends _$PublicBodyVtse52TsunamiCopyWithImpl<$Res,
        _$PublicBodyVtse52TsunamiImpl>
    implements _$$PublicBodyVtse52TsunamiImplCopyWith<$Res> {
  __$$PublicBodyVtse52TsunamiImplCopyWithImpl(
      _$PublicBodyVtse52TsunamiImpl _value,
      $Res Function(_$PublicBodyVtse52TsunamiImpl) _then)
      : super(_value, _then);

  /// Create a copy of PublicBodyVtse52Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observations = freezed,
    Object? estimations = null,
  }) {
    return _then(_$PublicBodyVtse52TsunamiImpl(
      observations: freezed == observations
          ? _value._observations
          : observations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiObservation>?,
      estimations: null == estimations
          ? _value._estimations
          : estimations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiEstimation>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PublicBodyVtse52TsunamiImpl implements _PublicBodyVtse52Tsunami {
  const _$PublicBodyVtse52TsunamiImpl(
      {required final List<TsunamiObservation>? observations,
      required final List<TsunamiEstimation> estimations})
      : _observations = observations,
        _estimations = estimations;

  factory _$PublicBodyVtse52TsunamiImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublicBodyVtse52TsunamiImplFromJson(json);

  final List<TsunamiObservation>? _observations;
  @override
  List<TsunamiObservation>? get observations {
    final value = _observations;
    if (value == null) return null;
    if (_observations is EqualUnmodifiableListView) return _observations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TsunamiEstimation> _estimations;
  @override
  List<TsunamiEstimation> get estimations {
    if (_estimations is EqualUnmodifiableListView) return _estimations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_estimations);
  }

  @override
  String toString() {
    return 'PublicBodyVtse52Tsunami(observations: $observations, estimations: $estimations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicBodyVtse52TsunamiImpl &&
            const DeepCollectionEquality()
                .equals(other._observations, _observations) &&
            const DeepCollectionEquality()
                .equals(other._estimations, _estimations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_observations),
      const DeepCollectionEquality().hash(_estimations));

  /// Create a copy of PublicBodyVtse52Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicBodyVtse52TsunamiImplCopyWith<_$PublicBodyVtse52TsunamiImpl>
      get copyWith => __$$PublicBodyVtse52TsunamiImplCopyWithImpl<
          _$PublicBodyVtse52TsunamiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublicBodyVtse52TsunamiImplToJson(
      this,
    );
  }
}

abstract class _PublicBodyVtse52Tsunami implements PublicBodyVtse52Tsunami {
  const factory _PublicBodyVtse52Tsunami(
          {required final List<TsunamiObservation>? observations,
          required final List<TsunamiEstimation> estimations}) =
      _$PublicBodyVtse52TsunamiImpl;

  factory _PublicBodyVtse52Tsunami.fromJson(Map<String, dynamic> json) =
      _$PublicBodyVtse52TsunamiImpl.fromJson;

  @override
  List<TsunamiObservation>? get observations;
  @override
  List<TsunamiEstimation> get estimations;

  /// Create a copy of PublicBodyVtse52Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublicBodyVtse52TsunamiImplCopyWith<_$PublicBodyVtse52TsunamiImpl>
      get copyWith => throw _privateConstructorUsedError;
}
