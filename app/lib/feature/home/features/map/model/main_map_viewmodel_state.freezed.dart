// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_map_viewmodel_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MainMapViewmodelState _$MainMapViewmodelStateFromJson(
    Map<String, dynamic> json) {
  return _MainMapViewmodelState.fromJson(json);
}

/// @nodoc
mixin _$MainMapViewmodelState {
  bool get isHomePosition => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _latLngBoundsFromJson, toJson: _latLngBoundsToJson)
  LatLngBounds get homeBoundary => throw _privateConstructorUsedError;

  /// Serializes this MainMapViewmodelState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MainMapViewmodelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MainMapViewmodelStateCopyWith<MainMapViewmodelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainMapViewmodelStateCopyWith<$Res> {
  factory $MainMapViewmodelStateCopyWith(MainMapViewmodelState value,
          $Res Function(MainMapViewmodelState) then) =
      _$MainMapViewmodelStateCopyWithImpl<$Res, MainMapViewmodelState>;
  @useResult
  $Res call(
      {bool isHomePosition,
      @JsonKey(fromJson: _latLngBoundsFromJson, toJson: _latLngBoundsToJson)
      LatLngBounds homeBoundary});
}

/// @nodoc
class _$MainMapViewmodelStateCopyWithImpl<$Res,
        $Val extends MainMapViewmodelState>
    implements $MainMapViewmodelStateCopyWith<$Res> {
  _$MainMapViewmodelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MainMapViewmodelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isHomePosition = null,
    Object? homeBoundary = null,
  }) {
    return _then(_value.copyWith(
      isHomePosition: null == isHomePosition
          ? _value.isHomePosition
          : isHomePosition // ignore: cast_nullable_to_non_nullable
              as bool,
      homeBoundary: null == homeBoundary
          ? _value.homeBoundary
          : homeBoundary // ignore: cast_nullable_to_non_nullable
              as LatLngBounds,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainMapViewmodelStateImplCopyWith<$Res>
    implements $MainMapViewmodelStateCopyWith<$Res> {
  factory _$$MainMapViewmodelStateImplCopyWith(
          _$MainMapViewmodelStateImpl value,
          $Res Function(_$MainMapViewmodelStateImpl) then) =
      __$$MainMapViewmodelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isHomePosition,
      @JsonKey(fromJson: _latLngBoundsFromJson, toJson: _latLngBoundsToJson)
      LatLngBounds homeBoundary});
}

/// @nodoc
class __$$MainMapViewmodelStateImplCopyWithImpl<$Res>
    extends _$MainMapViewmodelStateCopyWithImpl<$Res,
        _$MainMapViewmodelStateImpl>
    implements _$$MainMapViewmodelStateImplCopyWith<$Res> {
  __$$MainMapViewmodelStateImplCopyWithImpl(_$MainMapViewmodelStateImpl _value,
      $Res Function(_$MainMapViewmodelStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MainMapViewmodelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isHomePosition = null,
    Object? homeBoundary = null,
  }) {
    return _then(_$MainMapViewmodelStateImpl(
      isHomePosition: null == isHomePosition
          ? _value.isHomePosition
          : isHomePosition // ignore: cast_nullable_to_non_nullable
              as bool,
      homeBoundary: null == homeBoundary
          ? _value.homeBoundary
          : homeBoundary // ignore: cast_nullable_to_non_nullable
              as LatLngBounds,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MainMapViewmodelStateImpl implements _MainMapViewmodelState {
  const _$MainMapViewmodelStateImpl(
      {required this.isHomePosition,
      @JsonKey(fromJson: _latLngBoundsFromJson, toJson: _latLngBoundsToJson)
      required this.homeBoundary});

  factory _$MainMapViewmodelStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MainMapViewmodelStateImplFromJson(json);

  @override
  final bool isHomePosition;
  @override
  @JsonKey(fromJson: _latLngBoundsFromJson, toJson: _latLngBoundsToJson)
  final LatLngBounds homeBoundary;

  @override
  String toString() {
    return 'MainMapViewmodelState(isHomePosition: $isHomePosition, homeBoundary: $homeBoundary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainMapViewmodelStateImpl &&
            (identical(other.isHomePosition, isHomePosition) ||
                other.isHomePosition == isHomePosition) &&
            (identical(other.homeBoundary, homeBoundary) ||
                other.homeBoundary == homeBoundary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isHomePosition, homeBoundary);

  /// Create a copy of MainMapViewmodelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MainMapViewmodelStateImplCopyWith<_$MainMapViewmodelStateImpl>
      get copyWith => __$$MainMapViewmodelStateImplCopyWithImpl<
          _$MainMapViewmodelStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MainMapViewmodelStateImplToJson(
      this,
    );
  }
}

abstract class _MainMapViewmodelState implements MainMapViewmodelState {
  const factory _MainMapViewmodelState(
      {required final bool isHomePosition,
      @JsonKey(fromJson: _latLngBoundsFromJson, toJson: _latLngBoundsToJson)
      required final LatLngBounds homeBoundary}) = _$MainMapViewmodelStateImpl;

  factory _MainMapViewmodelState.fromJson(Map<String, dynamic> json) =
      _$MainMapViewmodelStateImpl.fromJson;

  @override
  bool get isHomePosition;
  @override
  @JsonKey(fromJson: _latLngBoundsFromJson, toJson: _latLngBoundsToJson)
  LatLngBounds get homeBoundary;

  /// Create a copy of MainMapViewmodelState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MainMapViewmodelStateImplCopyWith<_$MainMapViewmodelStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
