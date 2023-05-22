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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PublicBodyVtse51Tsunami _$PublicBodyVtse51TsunamiFromJson(
    Map<String, dynamic> json) {
  return _PublicBodyVtse51Tsunami.fromJson(json);
}

/// @nodoc
mixin _$PublicBodyVtse51Tsunami {
  List<TsunamiForecast> get forecasts => throw _privateConstructorUsedError;
  List<TsunamiObservation>? get observations =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_PublicBodyVtse51TsunamiCopyWith<$Res>
    implements $PublicBodyVtse51TsunamiCopyWith<$Res> {
  factory _$$_PublicBodyVtse51TsunamiCopyWith(_$_PublicBodyVtse51Tsunami value,
          $Res Function(_$_PublicBodyVtse51Tsunami) then) =
      __$$_PublicBodyVtse51TsunamiCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TsunamiForecast> forecasts,
      List<TsunamiObservation>? observations});
}

/// @nodoc
class __$$_PublicBodyVtse51TsunamiCopyWithImpl<$Res>
    extends _$PublicBodyVtse51TsunamiCopyWithImpl<$Res,
        _$_PublicBodyVtse51Tsunami>
    implements _$$_PublicBodyVtse51TsunamiCopyWith<$Res> {
  __$$_PublicBodyVtse51TsunamiCopyWithImpl(_$_PublicBodyVtse51Tsunami _value,
      $Res Function(_$_PublicBodyVtse51Tsunami) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecasts = null,
    Object? observations = freezed,
  }) {
    return _then(_$_PublicBodyVtse51Tsunami(
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
class _$_PublicBodyVtse51Tsunami implements _PublicBodyVtse51Tsunami {
  const _$_PublicBodyVtse51Tsunami(
      {required final List<TsunamiForecast> forecasts,
      required final List<TsunamiObservation>? observations})
      : _forecasts = forecasts,
        _observations = observations;

  factory _$_PublicBodyVtse51Tsunami.fromJson(Map<String, dynamic> json) =>
      _$$_PublicBodyVtse51TsunamiFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PublicBodyVtse51Tsunami &&
            const DeepCollectionEquality()
                .equals(other._forecasts, _forecasts) &&
            const DeepCollectionEquality()
                .equals(other._observations, _observations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_forecasts),
      const DeepCollectionEquality().hash(_observations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PublicBodyVtse51TsunamiCopyWith<_$_PublicBodyVtse51Tsunami>
      get copyWith =>
          __$$_PublicBodyVtse51TsunamiCopyWithImpl<_$_PublicBodyVtse51Tsunami>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PublicBodyVtse51TsunamiToJson(
      this,
    );
  }
}

abstract class _PublicBodyVtse51Tsunami implements PublicBodyVtse51Tsunami {
  const factory _PublicBodyVtse51Tsunami(
          {required final List<TsunamiForecast> forecasts,
          required final List<TsunamiObservation>? observations}) =
      _$_PublicBodyVtse51Tsunami;

  factory _PublicBodyVtse51Tsunami.fromJson(Map<String, dynamic> json) =
      _$_PublicBodyVtse51Tsunami.fromJson;

  @override
  List<TsunamiForecast> get forecasts;
  @override
  List<TsunamiObservation>? get observations;
  @override
  @JsonKey(ignore: true)
  _$$_PublicBodyVtse51TsunamiCopyWith<_$_PublicBodyVtse51Tsunami>
      get copyWith => throw _privateConstructorUsedError;
}
