// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MapState _$MapStateFromJson(Map<String, dynamic> json) {
  return _MapState.fromJson(json);
}

/// @nodoc
mixin _$MapState {
  @JsonKey(fromJson: _offsetFromJson, toJson: _offsetToJson)
  Offset get offset => throw _privateConstructorUsedError;
  double get zoomLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapStateCopyWith<MapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapStateCopyWith<$Res> {
  factory $MapStateCopyWith(MapState value, $Res Function(MapState) then) =
      _$MapStateCopyWithImpl<$Res, MapState>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _offsetFromJson, toJson: _offsetToJson) Offset offset,
      double zoomLevel});
}

/// @nodoc
class _$MapStateCopyWithImpl<$Res, $Val extends MapState>
    implements $MapStateCopyWith<$Res> {
  _$MapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? zoomLevel = null,
  }) {
    return _then(_value.copyWith(
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      zoomLevel: null == zoomLevel
          ? _value.zoomLevel
          : zoomLevel // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapStateImplCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$$MapStateImplCopyWith(
          _$MapStateImpl value, $Res Function(_$MapStateImpl) then) =
      __$$MapStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _offsetFromJson, toJson: _offsetToJson) Offset offset,
      double zoomLevel});
}

/// @nodoc
class __$$MapStateImplCopyWithImpl<$Res>
    extends _$MapStateCopyWithImpl<$Res, _$MapStateImpl>
    implements _$$MapStateImplCopyWith<$Res> {
  __$$MapStateImplCopyWithImpl(
      _$MapStateImpl _value, $Res Function(_$MapStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? zoomLevel = null,
  }) {
    return _then(_$MapStateImpl(
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      zoomLevel: null == zoomLevel
          ? _value.zoomLevel
          : zoomLevel // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapStateImpl implements _MapState {
  const _$MapStateImpl(
      {@JsonKey(fromJson: _offsetFromJson, toJson: _offsetToJson)
      required this.offset,
      required this.zoomLevel});

  factory _$MapStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapStateImplFromJson(json);

  @override
  @JsonKey(fromJson: _offsetFromJson, toJson: _offsetToJson)
  final Offset offset;
  @override
  final double zoomLevel;

  @override
  String toString() {
    return 'MapState(offset: $offset, zoomLevel: $zoomLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapStateImpl &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.zoomLevel, zoomLevel) ||
                other.zoomLevel == zoomLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, offset, zoomLevel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapStateImplCopyWith<_$MapStateImpl> get copyWith =>
      __$$MapStateImplCopyWithImpl<_$MapStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapStateImplToJson(
      this,
    );
  }
}

abstract class _MapState implements MapState {
  const factory _MapState(
      {@JsonKey(fromJson: _offsetFromJson, toJson: _offsetToJson)
      required final Offset offset,
      required final double zoomLevel}) = _$MapStateImpl;

  factory _MapState.fromJson(Map<String, dynamic> json) =
      _$MapStateImpl.fromJson;

  @override
  @JsonKey(fromJson: _offsetFromJson, toJson: _offsetToJson)
  Offset get offset;
  @override
  double get zoomLevel;
  @override
  @JsonKey(ignore: true)
  _$$MapStateImplCopyWith<_$MapStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
