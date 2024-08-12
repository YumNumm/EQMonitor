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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PublicBodyVtse41Tsunami _$PublicBodyVtse41TsunamiFromJson(
    Map<String, dynamic> json) {
  return _PublicBodyVtse41Tsunami.fromJson(json);
}

/// @nodoc
mixin _$PublicBodyVtse41Tsunami {
  List<TsunamiForecast> get forecasts => throw _privateConstructorUsedError;

  /// Serializes this PublicBodyVtse41Tsunami to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublicBodyVtse41Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of PublicBodyVtse41Tsunami
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$PublicBodyVtse41TsunamiImplCopyWith<$Res>
    implements $PublicBodyVtse41TsunamiCopyWith<$Res> {
  factory _$$PublicBodyVtse41TsunamiImplCopyWith(
          _$PublicBodyVtse41TsunamiImpl value,
          $Res Function(_$PublicBodyVtse41TsunamiImpl) then) =
      __$$PublicBodyVtse41TsunamiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TsunamiForecast> forecasts});
}

/// @nodoc
class __$$PublicBodyVtse41TsunamiImplCopyWithImpl<$Res>
    extends _$PublicBodyVtse41TsunamiCopyWithImpl<$Res,
        _$PublicBodyVtse41TsunamiImpl>
    implements _$$PublicBodyVtse41TsunamiImplCopyWith<$Res> {
  __$$PublicBodyVtse41TsunamiImplCopyWithImpl(
      _$PublicBodyVtse41TsunamiImpl _value,
      $Res Function(_$PublicBodyVtse41TsunamiImpl) _then)
      : super(_value, _then);

  /// Create a copy of PublicBodyVtse41Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecasts = null,
  }) {
    return _then(_$PublicBodyVtse41TsunamiImpl(
      forecasts: null == forecasts
          ? _value._forecasts
          : forecasts // ignore: cast_nullable_to_non_nullable
              as List<TsunamiForecast>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PublicBodyVtse41TsunamiImpl implements _PublicBodyVtse41Tsunami {
  const _$PublicBodyVtse41TsunamiImpl(
      {required final List<TsunamiForecast> forecasts})
      : _forecasts = forecasts;

  factory _$PublicBodyVtse41TsunamiImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublicBodyVtse41TsunamiImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicBodyVtse41TsunamiImpl &&
            const DeepCollectionEquality()
                .equals(other._forecasts, _forecasts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_forecasts));

  /// Create a copy of PublicBodyVtse41Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicBodyVtse41TsunamiImplCopyWith<_$PublicBodyVtse41TsunamiImpl>
      get copyWith => __$$PublicBodyVtse41TsunamiImplCopyWithImpl<
          _$PublicBodyVtse41TsunamiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublicBodyVtse41TsunamiImplToJson(
      this,
    );
  }
}

abstract class _PublicBodyVtse41Tsunami implements PublicBodyVtse41Tsunami {
  const factory _PublicBodyVtse41Tsunami(
          {required final List<TsunamiForecast> forecasts}) =
      _$PublicBodyVtse41TsunamiImpl;

  factory _PublicBodyVtse41Tsunami.fromJson(Map<String, dynamic> json) =
      _$PublicBodyVtse41TsunamiImpl.fromJson;

  @override
  List<TsunamiForecast> get forecasts;

  /// Create a copy of PublicBodyVtse41Tsunami
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublicBodyVtse41TsunamiImplCopyWith<_$PublicBodyVtse41TsunamiImpl>
      get copyWith => throw _privateConstructorUsedError;
}
