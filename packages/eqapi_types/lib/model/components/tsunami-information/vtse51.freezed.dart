// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vtse51.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PublicBodyVtse51Tsunami _$PublicBodyVtse51TsunamiFromJson(
    Map<String, dynamic> json) {
  return _PublicBodyVtse51Tsunami.fromJson(json);
}

/// @nodoc
mixin _$PublicBodyVtse51Tsunami {
  List<TsunamiForecast> get forecasts => throw _privateConstructorUsedError;
  List<TsunamiObservation>? get observations =>
      throw _privateConstructorUsedError;

  /// Serializes this PublicBodyVtse51Tsunami to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublicBodyVtse51Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublicBodyVtse51TsunamiCopyWith<PublicBodyVtse51Tsunami> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicBodyVtse51TsunamiCopyWith<$Res> {
  factory $PublicBodyVtse51TsunamiCopyWith(PublicBodyVtse51Tsunami value,
          $Res Function(PublicBodyVtse51Tsunami) then) =
      _$PublicBodyVtse51TsunamiCopyWithImpl<$Res, PublicBodyVtse51Tsunami>;
  @useResult
  $Res call(
      {List<TsunamiForecast> forecasts,
      List<TsunamiObservation>? observations});
}

/// @nodoc
class _$PublicBodyVtse51TsunamiCopyWithImpl<$Res,
        $Val extends PublicBodyVtse51Tsunami>
    implements $PublicBodyVtse51TsunamiCopyWith<$Res> {
  _$PublicBodyVtse51TsunamiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublicBodyVtse51Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecasts = null,
    Object? observations = freezed,
  }) {
    return _then(_value.copyWith(
      forecasts: null == forecasts
          ? _value.forecasts
          : forecasts // ignore: cast_nullable_to_non_nullable
              as List<TsunamiForecast>,
      observations: freezed == observations
          ? _value.observations
          : observations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiObservation>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PublicBodyVtse51TsunamiImplCopyWith<$Res>
    implements $PublicBodyVtse51TsunamiCopyWith<$Res> {
  factory _$$PublicBodyVtse51TsunamiImplCopyWith(
          _$PublicBodyVtse51TsunamiImpl value,
          $Res Function(_$PublicBodyVtse51TsunamiImpl) then) =
      __$$PublicBodyVtse51TsunamiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TsunamiForecast> forecasts,
      List<TsunamiObservation>? observations});
}

/// @nodoc
class __$$PublicBodyVtse51TsunamiImplCopyWithImpl<$Res>
    extends _$PublicBodyVtse51TsunamiCopyWithImpl<$Res,
        _$PublicBodyVtse51TsunamiImpl>
    implements _$$PublicBodyVtse51TsunamiImplCopyWith<$Res> {
  __$$PublicBodyVtse51TsunamiImplCopyWithImpl(
      _$PublicBodyVtse51TsunamiImpl _value,
      $Res Function(_$PublicBodyVtse51TsunamiImpl) _then)
      : super(_value, _then);

  /// Create a copy of PublicBodyVtse51Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecasts = null,
    Object? observations = freezed,
  }) {
    return _then(_$PublicBodyVtse51TsunamiImpl(
      forecasts: null == forecasts
          ? _value._forecasts
          : forecasts // ignore: cast_nullable_to_non_nullable
              as List<TsunamiForecast>,
      observations: freezed == observations
          ? _value._observations
          : observations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiObservation>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PublicBodyVtse51TsunamiImpl implements _PublicBodyVtse51Tsunami {
  const _$PublicBodyVtse51TsunamiImpl(
      {required final List<TsunamiForecast> forecasts,
      required final List<TsunamiObservation>? observations})
      : _forecasts = forecasts,
        _observations = observations;

  factory _$PublicBodyVtse51TsunamiImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublicBodyVtse51TsunamiImplFromJson(json);

  final List<TsunamiForecast> _forecasts;
  @override
  List<TsunamiForecast> get forecasts {
    if (_forecasts is EqualUnmodifiableListView) return _forecasts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_forecasts);
  }

  final List<TsunamiObservation>? _observations;
  @override
  List<TsunamiObservation>? get observations {
    final value = _observations;
    if (value == null) return null;
    if (_observations is EqualUnmodifiableListView) return _observations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PublicBodyVtse51Tsunami(forecasts: $forecasts, observations: $observations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicBodyVtse51TsunamiImpl &&
            const DeepCollectionEquality()
                .equals(other._forecasts, _forecasts) &&
            const DeepCollectionEquality()
                .equals(other._observations, _observations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_forecasts),
      const DeepCollectionEquality().hash(_observations));

  /// Create a copy of PublicBodyVtse51Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicBodyVtse51TsunamiImplCopyWith<_$PublicBodyVtse51TsunamiImpl>
      get copyWith => __$$PublicBodyVtse51TsunamiImplCopyWithImpl<
          _$PublicBodyVtse51TsunamiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublicBodyVtse51TsunamiImplToJson(
      this,
    );
  }
}

abstract class _PublicBodyVtse51Tsunami implements PublicBodyVtse51Tsunami {
  const factory _PublicBodyVtse51Tsunami(
          {required final List<TsunamiForecast> forecasts,
          required final List<TsunamiObservation>? observations}) =
      _$PublicBodyVtse51TsunamiImpl;

  factory _PublicBodyVtse51Tsunami.fromJson(Map<String, dynamic> json) =
      _$PublicBodyVtse51TsunamiImpl.fromJson;

  @override
  List<TsunamiForecast> get forecasts;
  @override
  List<TsunamiObservation>? get observations;

  /// Create a copy of PublicBodyVtse51Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublicBodyVtse51TsunamiImplCopyWith<_$PublicBodyVtse51TsunamiImpl>
      get copyWith => throw _privateConstructorUsedError;
}
