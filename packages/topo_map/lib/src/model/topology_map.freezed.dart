// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topology_map.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TopologyMap _$TopologyMapFromJson(Map<String, dynamic> json) {
  return _TopologyMap.fromJson(json);
}

/// @nodoc
mixin _$TopologyMap {
  DoubleVector get scale => throw _privateConstructorUsedError;
  DoubleVector get translate => throw _privateConstructorUsedError;
  List<TopologyPolygon> get polygons => throw _privateConstructorUsedError;
  List<TopologyArc> get arcs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopologyMapCopyWith<TopologyMap> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopologyMapCopyWith<$Res> {
  factory $TopologyMapCopyWith(
          TopologyMap value, $Res Function(TopologyMap) then) =
      _$TopologyMapCopyWithImpl<$Res, TopologyMap>;
  @useResult
  $Res call(
      {DoubleVector scale,
      DoubleVector translate,
      List<TopologyPolygon> polygons,
      List<TopologyArc> arcs});

  $DoubleVectorCopyWith<$Res> get scale;
  $DoubleVectorCopyWith<$Res> get translate;
}

/// @nodoc
class _$TopologyMapCopyWithImpl<$Res, $Val extends TopologyMap>
    implements $TopologyMapCopyWith<$Res> {
  _$TopologyMapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scale = null,
    Object? translate = null,
    Object? polygons = null,
    Object? arcs = null,
  }) {
    return _then(_value.copyWith(
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as DoubleVector,
      translate: null == translate
          ? _value.translate
          : translate // ignore: cast_nullable_to_non_nullable
              as DoubleVector,
      polygons: null == polygons
          ? _value.polygons
          : polygons // ignore: cast_nullable_to_non_nullable
              as List<TopologyPolygon>,
      arcs: null == arcs
          ? _value.arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<TopologyArc>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DoubleVectorCopyWith<$Res> get scale {
    return $DoubleVectorCopyWith<$Res>(_value.scale, (value) {
      return _then(_value.copyWith(scale: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DoubleVectorCopyWith<$Res> get translate {
    return $DoubleVectorCopyWith<$Res>(_value.translate, (value) {
      return _then(_value.copyWith(translate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TopologyMapCopyWith<$Res>
    implements $TopologyMapCopyWith<$Res> {
  factory _$$_TopologyMapCopyWith(
          _$_TopologyMap value, $Res Function(_$_TopologyMap) then) =
      __$$_TopologyMapCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DoubleVector scale,
      DoubleVector translate,
      List<TopologyPolygon> polygons,
      List<TopologyArc> arcs});

  @override
  $DoubleVectorCopyWith<$Res> get scale;
  @override
  $DoubleVectorCopyWith<$Res> get translate;
}

/// @nodoc
class __$$_TopologyMapCopyWithImpl<$Res>
    extends _$TopologyMapCopyWithImpl<$Res, _$_TopologyMap>
    implements _$$_TopologyMapCopyWith<$Res> {
  __$$_TopologyMapCopyWithImpl(
      _$_TopologyMap _value, $Res Function(_$_TopologyMap) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scale = null,
    Object? translate = null,
    Object? polygons = null,
    Object? arcs = null,
  }) {
    return _then(_$_TopologyMap(
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as DoubleVector,
      translate: null == translate
          ? _value.translate
          : translate // ignore: cast_nullable_to_non_nullable
              as DoubleVector,
      polygons: null == polygons
          ? _value._polygons
          : polygons // ignore: cast_nullable_to_non_nullable
              as List<TopologyPolygon>,
      arcs: null == arcs
          ? _value._arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<TopologyArc>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TopologyMap implements _TopologyMap {
  const _$_TopologyMap(
      {required this.scale,
      required this.translate,
      required final List<TopologyPolygon> polygons,
      required final List<TopologyArc> arcs})
      : _polygons = polygons,
        _arcs = arcs;

  factory _$_TopologyMap.fromJson(Map<String, dynamic> json) =>
      _$$_TopologyMapFromJson(json);

  @override
  final DoubleVector scale;
  @override
  final DoubleVector translate;
  final List<TopologyPolygon> _polygons;
  @override
  List<TopologyPolygon> get polygons {
    if (_polygons is EqualUnmodifiableListView) return _polygons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_polygons);
  }

  final List<TopologyArc> _arcs;
  @override
  List<TopologyArc> get arcs {
    if (_arcs is EqualUnmodifiableListView) return _arcs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_arcs);
  }

  @override
  String toString() {
    return 'TopologyMap(scale: $scale, translate: $translate, polygons: $polygons, arcs: $arcs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TopologyMap &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.translate, translate) ||
                other.translate == translate) &&
            const DeepCollectionEquality().equals(other._polygons, _polygons) &&
            const DeepCollectionEquality().equals(other._arcs, _arcs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      scale,
      translate,
      const DeepCollectionEquality().hash(_polygons),
      const DeepCollectionEquality().hash(_arcs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TopologyMapCopyWith<_$_TopologyMap> get copyWith =>
      __$$_TopologyMapCopyWithImpl<_$_TopologyMap>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TopologyMapToJson(
      this,
    );
  }
}

abstract class _TopologyMap implements TopologyMap {
  const factory _TopologyMap(
      {required final DoubleVector scale,
      required final DoubleVector translate,
      required final List<TopologyPolygon> polygons,
      required final List<TopologyArc> arcs}) = _$_TopologyMap;

  factory _TopologyMap.fromJson(Map<String, dynamic> json) =
      _$_TopologyMap.fromJson;

  @override
  DoubleVector get scale;
  @override
  DoubleVector get translate;
  @override
  List<TopologyPolygon> get polygons;
  @override
  List<TopologyArc> get arcs;
  @override
  @JsonKey(ignore: true)
  _$$_TopologyMapCopyWith<_$_TopologyMap> get copyWith =>
      throw _privateConstructorUsedError;
}

TopologyArc _$TopologyArcFromJson(Map<String, dynamic> json) {
  return _TopologyArc.fromJson(json);
}

/// @nodoc
mixin _$TopologyArc {
  List<IntVector> get arc => throw _privateConstructorUsedError;
  TopologyArcType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopologyArcCopyWith<TopologyArc> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopologyArcCopyWith<$Res> {
  factory $TopologyArcCopyWith(
          TopologyArc value, $Res Function(TopologyArc) then) =
      _$TopologyArcCopyWithImpl<$Res, TopologyArc>;
  @useResult
  $Res call({List<IntVector> arc, TopologyArcType type});
}

/// @nodoc
class _$TopologyArcCopyWithImpl<$Res, $Val extends TopologyArc>
    implements $TopologyArcCopyWith<$Res> {
  _$TopologyArcCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arc = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      arc: null == arc
          ? _value.arc
          : arc // ignore: cast_nullable_to_non_nullable
              as List<IntVector>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopologyArcType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TopologyArcCopyWith<$Res>
    implements $TopologyArcCopyWith<$Res> {
  factory _$$_TopologyArcCopyWith(
          _$_TopologyArc value, $Res Function(_$_TopologyArc) then) =
      __$$_TopologyArcCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<IntVector> arc, TopologyArcType type});
}

/// @nodoc
class __$$_TopologyArcCopyWithImpl<$Res>
    extends _$TopologyArcCopyWithImpl<$Res, _$_TopologyArc>
    implements _$$_TopologyArcCopyWith<$Res> {
  __$$_TopologyArcCopyWithImpl(
      _$_TopologyArc _value, $Res Function(_$_TopologyArc) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arc = null,
    Object? type = null,
  }) {
    return _then(_$_TopologyArc(
      arc: null == arc
          ? _value._arc
          : arc // ignore: cast_nullable_to_non_nullable
              as List<IntVector>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopologyArcType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TopologyArc implements _TopologyArc {
  const _$_TopologyArc({required final List<IntVector> arc, required this.type})
      : _arc = arc;

  factory _$_TopologyArc.fromJson(Map<String, dynamic> json) =>
      _$$_TopologyArcFromJson(json);

  final List<IntVector> _arc;
  @override
  List<IntVector> get arc {
    if (_arc is EqualUnmodifiableListView) return _arc;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_arc);
  }

  @override
  final TopologyArcType type;

  @override
  String toString() {
    return 'TopologyArc(arc: $arc, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TopologyArc &&
            const DeepCollectionEquality().equals(other._arc, _arc) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_arc), type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TopologyArcCopyWith<_$_TopologyArc> get copyWith =>
      __$$_TopologyArcCopyWithImpl<_$_TopologyArc>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TopologyArcToJson(
      this,
    );
  }
}

abstract class _TopologyArc implements TopologyArc {
  const factory _TopologyArc(
      {required final List<IntVector> arc,
      required final TopologyArcType type}) = _$_TopologyArc;

  factory _TopologyArc.fromJson(Map<String, dynamic> json) =
      _$_TopologyArc.fromJson;

  @override
  List<IntVector> get arc;
  @override
  TopologyArcType get type;
  @override
  @JsonKey(ignore: true)
  _$$_TopologyArcCopyWith<_$_TopologyArc> get copyWith =>
      throw _privateConstructorUsedError;
}

TopologyPolygon _$TopologyPolygonFromJson(Map<String, dynamic> json) {
  return _TopologyPolygon.fromJson(json);
}

/// @nodoc
mixin _$TopologyPolygon {
  List<List<int>> get arcs => throw _privateConstructorUsedError;
  int? get areaCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopologyPolygonCopyWith<TopologyPolygon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopologyPolygonCopyWith<$Res> {
  factory $TopologyPolygonCopyWith(
          TopologyPolygon value, $Res Function(TopologyPolygon) then) =
      _$TopologyPolygonCopyWithImpl<$Res, TopologyPolygon>;
  @useResult
  $Res call({List<List<int>> arcs, int? areaCode});
}

/// @nodoc
class _$TopologyPolygonCopyWithImpl<$Res, $Val extends TopologyPolygon>
    implements $TopologyPolygonCopyWith<$Res> {
  _$TopologyPolygonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arcs = null,
    Object? areaCode = freezed,
  }) {
    return _then(_value.copyWith(
      arcs: null == arcs
          ? _value.arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      areaCode: freezed == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TopologyPolygonCopyWith<$Res>
    implements $TopologyPolygonCopyWith<$Res> {
  factory _$$_TopologyPolygonCopyWith(
          _$_TopologyPolygon value, $Res Function(_$_TopologyPolygon) then) =
      __$$_TopologyPolygonCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<List<int>> arcs, int? areaCode});
}

/// @nodoc
class __$$_TopologyPolygonCopyWithImpl<$Res>
    extends _$TopologyPolygonCopyWithImpl<$Res, _$_TopologyPolygon>
    implements _$$_TopologyPolygonCopyWith<$Res> {
  __$$_TopologyPolygonCopyWithImpl(
      _$_TopologyPolygon _value, $Res Function(_$_TopologyPolygon) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arcs = null,
    Object? areaCode = freezed,
  }) {
    return _then(_$_TopologyPolygon(
      arcs: null == arcs
          ? _value._arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      areaCode: freezed == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TopologyPolygon implements _TopologyPolygon {
  const _$_TopologyPolygon(
      {required final List<List<int>> arcs, required this.areaCode})
      : _arcs = arcs;

  factory _$_TopologyPolygon.fromJson(Map<String, dynamic> json) =>
      _$$_TopologyPolygonFromJson(json);

  final List<List<int>> _arcs;
  @override
  List<List<int>> get arcs {
    if (_arcs is EqualUnmodifiableListView) return _arcs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_arcs);
  }

  @override
  final int? areaCode;

  @override
  String toString() {
    return 'TopologyPolygon(arcs: $arcs, areaCode: $areaCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TopologyPolygon &&
            const DeepCollectionEquality().equals(other._arcs, _arcs) &&
            (identical(other.areaCode, areaCode) ||
                other.areaCode == areaCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_arcs), areaCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TopologyPolygonCopyWith<_$_TopologyPolygon> get copyWith =>
      __$$_TopologyPolygonCopyWithImpl<_$_TopologyPolygon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TopologyPolygonToJson(
      this,
    );
  }
}

abstract class _TopologyPolygon implements TopologyPolygon {
  const factory _TopologyPolygon(
      {required final List<List<int>> arcs,
      required final int? areaCode}) = _$_TopologyPolygon;

  factory _TopologyPolygon.fromJson(Map<String, dynamic> json) =
      _$_TopologyPolygon.fromJson;

  @override
  List<List<int>> get arcs;
  @override
  int? get areaCode;
  @override
  @JsonKey(ignore: true)
  _$$_TopologyPolygonCopyWith<_$_TopologyPolygon> get copyWith =>
      throw _privateConstructorUsedError;
}
