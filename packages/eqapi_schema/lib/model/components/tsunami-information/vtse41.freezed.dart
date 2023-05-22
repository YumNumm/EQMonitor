// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vtse41.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PublicBodyVtse41Tsunami _$PublicBodyVtse41TsunamiFromJson(
    Map<String, dynamic> json) {
  return _PublicBodyVtse41Tsunami.fromJson(json);
}

/// @nodoc
mixin _$PublicBodyVtse41Tsunami {
  List<TsunamiForecast> get forecasts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PublicBodyVtse41TsunamiCopyWith<PublicBodyVtse41Tsunami> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicBodyVtse41TsunamiCopyWith<$Res> {
  factory $PublicBodyVtse41TsunamiCopyWith(PublicBodyVtse41Tsunami value,
          $Res Function(PublicBodyVtse41Tsunami) then) =
      _$PublicBodyVtse41TsunamiCopyWithImpl<$Res, PublicBodyVtse41Tsunami>;
  @useResult
  $Res call({List<TsunamiForecast> forecasts});
}

/// @nodoc
class _$PublicBodyVtse41TsunamiCopyWithImpl<$Res,
        $Val extends PublicBodyVtse41Tsunami>
    implements $PublicBodyVtse41TsunamiCopyWith<$Res> {
  _$PublicBodyVtse41TsunamiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecasts = null,
  }) {
    return _then(_value.copyWith(
      forecasts: null == forecasts
          ? _value.forecasts
          : forecasts // ignore: cast_nullable_to_non_nullable
              as List<TsunamiForecast>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PublicBodyVtse41TsunamiCopyWith<$Res>
    implements $PublicBodyVtse41TsunamiCopyWith<$Res> {
  factory _$$_PublicBodyVtse41TsunamiCopyWith(_$_PublicBodyVtse41Tsunami value,
          $Res Function(_$_PublicBodyVtse41Tsunami) then) =
      __$$_PublicBodyVtse41TsunamiCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TsunamiForecast> forecasts});
}

/// @nodoc
class __$$_PublicBodyVtse41TsunamiCopyWithImpl<$Res>
    extends _$PublicBodyVtse41TsunamiCopyWithImpl<$Res,
        _$_PublicBodyVtse41Tsunami>
    implements _$$_PublicBodyVtse41TsunamiCopyWith<$Res> {
  __$$_PublicBodyVtse41TsunamiCopyWithImpl(_$_PublicBodyVtse41Tsunami _value,
      $Res Function(_$_PublicBodyVtse41Tsunami) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecasts = null,
  }) {
    return _then(_$_PublicBodyVtse41Tsunami(
      forecasts: null == forecasts
          ? _value._forecasts
          : forecasts // ignore: cast_nullable_to_non_nullable
              as List<TsunamiForecast>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PublicBodyVtse41Tsunami implements _PublicBodyVtse41Tsunami {
  const _$_PublicBodyVtse41Tsunami(
      {required final List<TsunamiForecast> forecasts})
      : _forecasts = forecasts;

  factory _$_PublicBodyVtse41Tsunami.fromJson(Map<String, dynamic> json) =>
      _$$_PublicBodyVtse41TsunamiFromJson(json);

  final List<TsunamiForecast> _forecasts;
  @override
  List<TsunamiForecast> get forecasts {
    if (_forecasts is EqualUnmodifiableListView) return _forecasts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_forecasts);
  }

  @override
  String toString() {
    return 'PublicBodyVtse41Tsunami(forecasts: $forecasts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PublicBodyVtse41Tsunami &&
            const DeepCollectionEquality()
                .equals(other._forecasts, _forecasts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_forecasts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PublicBodyVtse41TsunamiCopyWith<_$_PublicBodyVtse41Tsunami>
      get copyWith =>
          __$$_PublicBodyVtse41TsunamiCopyWithImpl<_$_PublicBodyVtse41Tsunami>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PublicBodyVtse41TsunamiToJson(
      this,
    );
  }
}

abstract class _PublicBodyVtse41Tsunami implements PublicBodyVtse41Tsunami {
  const factory _PublicBodyVtse41Tsunami(
          {required final List<TsunamiForecast> forecasts}) =
      _$_PublicBodyVtse41Tsunami;

  factory _PublicBodyVtse41Tsunami.fromJson(Map<String, dynamic> json) =
      _$_PublicBodyVtse41Tsunami.fromJson;

  @override
  List<TsunamiForecast> get forecasts;
  @override
  @JsonKey(ignore: true)
  _$$_PublicBodyVtse41TsunamiCopyWith<_$_PublicBodyVtse41Tsunami>
      get copyWith => throw _privateConstructorUsedError;
}
