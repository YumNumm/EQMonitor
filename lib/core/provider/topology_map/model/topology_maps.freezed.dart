// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topology_maps.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TopologyMaps {
  Map<LandLayerType, TopologyMap> get maps =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TopologyMapsCopyWith<TopologyMaps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopologyMapsCopyWith<$Res> {
  factory $TopologyMapsCopyWith(
          TopologyMaps value, $Res Function(TopologyMaps) then) =
      _$TopologyMapsCopyWithImpl<$Res, TopologyMaps>;
  @useResult
  $Res call({Map<LandLayerType, TopologyMap> maps});
}

/// @nodoc
class _$TopologyMapsCopyWithImpl<$Res, $Val extends TopologyMaps>
    implements $TopologyMapsCopyWith<$Res> {
  _$TopologyMapsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maps = null,
  }) {
    return _then(_value.copyWith(
      maps: null == maps
          ? _value.maps
          : maps // ignore: cast_nullable_to_non_nullable
              as Map<LandLayerType, TopologyMap>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TopologyMapsCopyWith<$Res>
    implements $TopologyMapsCopyWith<$Res> {
  factory _$$_TopologyMapsCopyWith(
          _$_TopologyMaps value, $Res Function(_$_TopologyMaps) then) =
      __$$_TopologyMapsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<LandLayerType, TopologyMap> maps});
}

/// @nodoc
class __$$_TopologyMapsCopyWithImpl<$Res>
    extends _$TopologyMapsCopyWithImpl<$Res, _$_TopologyMaps>
    implements _$$_TopologyMapsCopyWith<$Res> {
  __$$_TopologyMapsCopyWithImpl(
      _$_TopologyMaps _value, $Res Function(_$_TopologyMaps) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maps = null,
  }) {
    return _then(_$_TopologyMaps(
      maps: null == maps
          ? _value._maps
          : maps // ignore: cast_nullable_to_non_nullable
              as Map<LandLayerType, TopologyMap>,
    ));
  }
}

/// @nodoc

class _$_TopologyMaps with DiagnosticableTreeMixin implements _TopologyMaps {
  const _$_TopologyMaps({final Map<LandLayerType, TopologyMap> maps = const {}})
      : _maps = maps;

  final Map<LandLayerType, TopologyMap> _maps;
  @override
  @JsonKey()
  Map<LandLayerType, TopologyMap> get maps {
    if (_maps is EqualUnmodifiableMapView) return _maps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_maps);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TopologyMaps(maps: $maps)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TopologyMaps'))
      ..add(DiagnosticsProperty('maps', maps));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TopologyMaps &&
            const DeepCollectionEquality().equals(other._maps, _maps));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_maps));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TopologyMapsCopyWith<_$_TopologyMaps> get copyWith =>
      __$$_TopologyMapsCopyWithImpl<_$_TopologyMaps>(this, _$identity);
}

abstract class _TopologyMaps implements TopologyMaps {
  const factory _TopologyMaps({final Map<LandLayerType, TopologyMap> maps}) =
      _$_TopologyMaps;

  @override
  Map<LandLayerType, TopologyMap> get maps;
  @override
  @JsonKey(ignore: true)
  _$$_TopologyMapsCopyWith<_$_TopologyMaps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MapData {
  Map<LandLayerType, FeatureLayer>? get maps =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MapDataCopyWith<MapData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapDataCopyWith<$Res> {
  factory $MapDataCopyWith(MapData value, $Res Function(MapData) then) =
      _$MapDataCopyWithImpl<$Res, MapData>;
  @useResult
  $Res call({Map<LandLayerType, FeatureLayer>? maps});
}

/// @nodoc
class _$MapDataCopyWithImpl<$Res, $Val extends MapData>
    implements $MapDataCopyWith<$Res> {
  _$MapDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maps = freezed,
  }) {
    return _then(_value.copyWith(
      maps: freezed == maps
          ? _value.maps
          : maps // ignore: cast_nullable_to_non_nullable
              as Map<LandLayerType, FeatureLayer>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MapDataCopyWith<$Res> implements $MapDataCopyWith<$Res> {
  factory _$$_MapDataCopyWith(
          _$_MapData value, $Res Function(_$_MapData) then) =
      __$$_MapDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<LandLayerType, FeatureLayer>? maps});
}

/// @nodoc
class __$$_MapDataCopyWithImpl<$Res>
    extends _$MapDataCopyWithImpl<$Res, _$_MapData>
    implements _$$_MapDataCopyWith<$Res> {
  __$$_MapDataCopyWithImpl(_$_MapData _value, $Res Function(_$_MapData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maps = freezed,
  }) {
    return _then(_$_MapData(
      maps: freezed == maps
          ? _value._maps
          : maps // ignore: cast_nullable_to_non_nullable
              as Map<LandLayerType, FeatureLayer>?,
    ));
  }
}

/// @nodoc

class _$_MapData with DiagnosticableTreeMixin implements _MapData {
  const _$_MapData({required final Map<LandLayerType, FeatureLayer>? maps})
      : _maps = maps;

  final Map<LandLayerType, FeatureLayer>? _maps;
  @override
  Map<LandLayerType, FeatureLayer>? get maps {
    final value = _maps;
    if (value == null) return null;
    if (_maps is EqualUnmodifiableMapView) return _maps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapData(maps: $maps)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapData'))
      ..add(DiagnosticsProperty('maps', maps));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MapData &&
            const DeepCollectionEquality().equals(other._maps, _maps));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_maps));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MapDataCopyWith<_$_MapData> get copyWith =>
      __$$_MapDataCopyWithImpl<_$_MapData>(this, _$identity);
}

abstract class _MapData implements MapData {
  const factory _MapData(
      {required final Map<LandLayerType, FeatureLayer>? maps}) = _$_MapData;

  @override
  Map<LandLayerType, FeatureLayer>? get maps;
  @override
  @JsonKey(ignore: true)
  _$$_MapDataCopyWith<_$_MapData> get copyWith =>
      throw _privateConstructorUsedError;
}
