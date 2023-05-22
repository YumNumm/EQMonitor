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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PublicBodyVtse52Tsunami _$PublicBodyVtse52TsunamiFromJson(
    Map<String, dynamic> json) {
  return _PublicBodyVtse52Tsunami.fromJson(json);
}

/// @nodoc
mixin _$PublicBodyVtse52Tsunami {
  List<TsunamiObservation>? get observations =>
      throw _privateConstructorUsedError;
  List<TsunamiEstimation> get estimations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_PublicBodyVtse52TsunamiCopyWith<$Res>
    implements $PublicBodyVtse52TsunamiCopyWith<$Res> {
  factory _$$_PublicBodyVtse52TsunamiCopyWith(_$_PublicBodyVtse52Tsunami value,
          $Res Function(_$_PublicBodyVtse52Tsunami) then) =
      __$$_PublicBodyVtse52TsunamiCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TsunamiObservation>? observations,
      List<TsunamiEstimation> estimations});
}

/// @nodoc
class __$$_PublicBodyVtse52TsunamiCopyWithImpl<$Res>
    extends _$PublicBodyVtse52TsunamiCopyWithImpl<$Res,
        _$_PublicBodyVtse52Tsunami>
    implements _$$_PublicBodyVtse52TsunamiCopyWith<$Res> {
  __$$_PublicBodyVtse52TsunamiCopyWithImpl(_$_PublicBodyVtse52Tsunami _value,
      $Res Function(_$_PublicBodyVtse52Tsunami) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observations = freezed,
    Object? estimations = null,
  }) {
    return _then(_$_PublicBodyVtse52Tsunami(
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
class _$_PublicBodyVtse52Tsunami implements _PublicBodyVtse52Tsunami {
  const _$_PublicBodyVtse52Tsunami(
      {required final List<TsunamiObservation>? observations,
      required final List<TsunamiEstimation> estimations})
      : _observations = observations,
        _estimations = estimations;

  factory _$_PublicBodyVtse52Tsunami.fromJson(Map<String, dynamic> json) =>
      _$$_PublicBodyVtse52TsunamiFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PublicBodyVtse52Tsunami &&
            const DeepCollectionEquality()
                .equals(other._observations, _observations) &&
            const DeepCollectionEquality()
                .equals(other._estimations, _estimations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_observations),
      const DeepCollectionEquality().hash(_estimations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PublicBodyVtse52TsunamiCopyWith<_$_PublicBodyVtse52Tsunami>
      get copyWith =>
          __$$_PublicBodyVtse52TsunamiCopyWithImpl<_$_PublicBodyVtse52Tsunami>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PublicBodyVtse52TsunamiToJson(
      this,
    );
  }
}

abstract class _PublicBodyVtse52Tsunami implements PublicBodyVtse52Tsunami {
  const factory _PublicBodyVtse52Tsunami(
          {required final List<TsunamiObservation>? observations,
          required final List<TsunamiEstimation> estimations}) =
      _$_PublicBodyVtse52Tsunami;

  factory _PublicBodyVtse52Tsunami.fromJson(Map<String, dynamic> json) =
      _$_PublicBodyVtse52Tsunami.fromJson;

  @override
  List<TsunamiObservation>? get observations;
  @override
  List<TsunamiEstimation> get estimations;
  @override
  @JsonKey(ignore: true)
  _$$_PublicBodyVtse52TsunamiCopyWith<_$_PublicBodyVtse52Tsunami>
      get copyWith => throw _privateConstructorUsedError;
}
