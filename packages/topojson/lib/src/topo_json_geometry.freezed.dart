// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topo_json_geometry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LineString _$LineStringFromJson(Map<String, dynamic> json) {
  return _LineString.fromJson(json);
}

/// @nodoc
mixin _$LineString {
  TopoJsonGeometryType get type => throw _privateConstructorUsedError;
  List<int> get arcs => throw _privateConstructorUsedError;
  Map<String, String?>? get properties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LineStringCopyWith<LineString> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LineStringCopyWith<$Res> {
  factory $LineStringCopyWith(
          LineString value, $Res Function(LineString) then) =
      _$LineStringCopyWithImpl<$Res, LineString>;
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<int> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class _$LineStringCopyWithImpl<$Res, $Val extends LineString>
    implements $LineStringCopyWith<$Res> {
  _$LineStringCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType,
      arcs: null == arcs
          ? _value.arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<int>,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LineStringImplCopyWith<$Res>
    implements $LineStringCopyWith<$Res> {
  factory _$$LineStringImplCopyWith(
          _$LineStringImpl value, $Res Function(_$LineStringImpl) then) =
      __$$LineStringImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<int> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class __$$LineStringImplCopyWithImpl<$Res>
    extends _$LineStringCopyWithImpl<$Res, _$LineStringImpl>
    implements _$$LineStringImplCopyWith<$Res> {
  __$$LineStringImplCopyWithImpl(
      _$LineStringImpl _value, $Res Function(_$LineStringImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_$LineStringImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType,
      arcs: null == arcs
          ? _value._arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<int>,
      properties: freezed == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LineStringImpl implements _LineString {
  const _$LineStringImpl(
      {required this.type,
      required final List<int> arcs,
      required final Map<String, String?>? properties})
      : _arcs = arcs,
        _properties = properties;

  factory _$LineStringImpl.fromJson(Map<String, dynamic> json) =>
      _$$LineStringImplFromJson(json);

  @override
  final TopoJsonGeometryType type;
  final List<int> _arcs;
  @override
  List<int> get arcs {
    if (_arcs is EqualUnmodifiableListView) return _arcs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_arcs);
  }

  final Map<String, String?>? _properties;
  @override
  Map<String, String?>? get properties {
    final value = _properties;
    if (value == null) return null;
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'LineString(type: $type, arcs: $arcs, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LineStringImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._arcs, _arcs) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_arcs),
      const DeepCollectionEquality().hash(_properties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LineStringImplCopyWith<_$LineStringImpl> get copyWith =>
      __$$LineStringImplCopyWithImpl<_$LineStringImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LineStringImplToJson(
      this,
    );
  }
}

abstract class _LineString implements LineString {
  const factory _LineString(
      {required final TopoJsonGeometryType type,
      required final List<int> arcs,
      required final Map<String, String?>? properties}) = _$LineStringImpl;

  factory _LineString.fromJson(Map<String, dynamic> json) =
      _$LineStringImpl.fromJson;

  @override
  TopoJsonGeometryType get type;
  @override
  List<int> get arcs;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$LineStringImplCopyWith<_$LineStringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MultiLineString _$MultiLineStringFromJson(Map<String, dynamic> json) {
  return _MultiLineString.fromJson(json);
}

/// @nodoc
mixin _$MultiLineString {
  TopoJsonGeometryType get type => throw _privateConstructorUsedError;
  List<List<int>> get arcs => throw _privateConstructorUsedError;
  Map<String, String?>? get properties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MultiLineStringCopyWith<MultiLineString> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiLineStringCopyWith<$Res> {
  factory $MultiLineStringCopyWith(
          MultiLineString value, $Res Function(MultiLineString) then) =
      _$MultiLineStringCopyWithImpl<$Res, MultiLineString>;
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<List<int>> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class _$MultiLineStringCopyWithImpl<$Res, $Val extends MultiLineString>
    implements $MultiLineStringCopyWith<$Res> {
  _$MultiLineStringCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType,
      arcs: null == arcs
          ? _value.arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MultiLineStringImplCopyWith<$Res>
    implements $MultiLineStringCopyWith<$Res> {
  factory _$$MultiLineStringImplCopyWith(_$MultiLineStringImpl value,
          $Res Function(_$MultiLineStringImpl) then) =
      __$$MultiLineStringImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<List<int>> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class __$$MultiLineStringImplCopyWithImpl<$Res>
    extends _$MultiLineStringCopyWithImpl<$Res, _$MultiLineStringImpl>
    implements _$$MultiLineStringImplCopyWith<$Res> {
  __$$MultiLineStringImplCopyWithImpl(
      _$MultiLineStringImpl _value, $Res Function(_$MultiLineStringImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_$MultiLineStringImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType,
      arcs: null == arcs
          ? _value._arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      properties: freezed == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MultiLineStringImpl implements _MultiLineString {
  const _$MultiLineStringImpl(
      {required this.type,
      required final List<List<int>> arcs,
      required final Map<String, String?>? properties})
      : _arcs = arcs,
        _properties = properties;

  factory _$MultiLineStringImpl.fromJson(Map<String, dynamic> json) =>
      _$$MultiLineStringImplFromJson(json);

  @override
  final TopoJsonGeometryType type;
  final List<List<int>> _arcs;
  @override
  List<List<int>> get arcs {
    if (_arcs is EqualUnmodifiableListView) return _arcs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_arcs);
  }

  final Map<String, String?>? _properties;
  @override
  Map<String, String?>? get properties {
    final value = _properties;
    if (value == null) return null;
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MultiLineString(type: $type, arcs: $arcs, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultiLineStringImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._arcs, _arcs) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_arcs),
      const DeepCollectionEquality().hash(_properties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MultiLineStringImplCopyWith<_$MultiLineStringImpl> get copyWith =>
      __$$MultiLineStringImplCopyWithImpl<_$MultiLineStringImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MultiLineStringImplToJson(
      this,
    );
  }
}

abstract class _MultiLineString implements MultiLineString {
  const factory _MultiLineString(
      {required final TopoJsonGeometryType type,
      required final List<List<int>> arcs,
      required final Map<String, String?>? properties}) = _$MultiLineStringImpl;

  factory _MultiLineString.fromJson(Map<String, dynamic> json) =
      _$MultiLineStringImpl.fromJson;

  @override
  TopoJsonGeometryType get type;
  @override
  List<List<int>> get arcs;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$MultiLineStringImplCopyWith<_$MultiLineStringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Polygon _$PolygonFromJson(Map<String, dynamic> json) {
  return _Polygon.fromJson(json);
}

/// @nodoc
mixin _$Polygon {
  TopoJsonGeometryType get type => throw _privateConstructorUsedError;
  List<List<int>> get arcs => throw _privateConstructorUsedError;
  Map<String, String?>? get properties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PolygonCopyWith<Polygon> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolygonCopyWith<$Res> {
  factory $PolygonCopyWith(Polygon value, $Res Function(Polygon) then) =
      _$PolygonCopyWithImpl<$Res, Polygon>;
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<List<int>> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class _$PolygonCopyWithImpl<$Res, $Val extends Polygon>
    implements $PolygonCopyWith<$Res> {
  _$PolygonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType,
      arcs: null == arcs
          ? _value.arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PolygonImplCopyWith<$Res> implements $PolygonCopyWith<$Res> {
  factory _$$PolygonImplCopyWith(
          _$PolygonImpl value, $Res Function(_$PolygonImpl) then) =
      __$$PolygonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<List<int>> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class __$$PolygonImplCopyWithImpl<$Res>
    extends _$PolygonCopyWithImpl<$Res, _$PolygonImpl>
    implements _$$PolygonImplCopyWith<$Res> {
  __$$PolygonImplCopyWithImpl(
      _$PolygonImpl _value, $Res Function(_$PolygonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_$PolygonImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType,
      arcs: null == arcs
          ? _value._arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      properties: freezed == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PolygonImpl implements _Polygon {
  const _$PolygonImpl(
      {required this.type,
      required final List<List<int>> arcs,
      required final Map<String, String?>? properties})
      : _arcs = arcs,
        _properties = properties;

  factory _$PolygonImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolygonImplFromJson(json);

  @override
  final TopoJsonGeometryType type;
  final List<List<int>> _arcs;
  @override
  List<List<int>> get arcs {
    if (_arcs is EqualUnmodifiableListView) return _arcs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_arcs);
  }

  final Map<String, String?>? _properties;
  @override
  Map<String, String?>? get properties {
    final value = _properties;
    if (value == null) return null;
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Polygon(type: $type, arcs: $arcs, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolygonImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._arcs, _arcs) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_arcs),
      const DeepCollectionEquality().hash(_properties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PolygonImplCopyWith<_$PolygonImpl> get copyWith =>
      __$$PolygonImplCopyWithImpl<_$PolygonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PolygonImplToJson(
      this,
    );
  }
}

abstract class _Polygon implements Polygon {
  const factory _Polygon(
      {required final TopoJsonGeometryType type,
      required final List<List<int>> arcs,
      required final Map<String, String?>? properties}) = _$PolygonImpl;

  factory _Polygon.fromJson(Map<String, dynamic> json) = _$PolygonImpl.fromJson;

  @override
  TopoJsonGeometryType get type;
  @override
  List<List<int>> get arcs;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$PolygonImplCopyWith<_$PolygonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MultiPolygon _$MultiPolygonFromJson(Map<String, dynamic> json) {
  return _MultiPolygon.fromJson(json);
}

/// @nodoc
mixin _$MultiPolygon {
  TopoJsonGeometryType get type => throw _privateConstructorUsedError;
  List<List<List<int>>> get arcs => throw _privateConstructorUsedError;
  Map<String, String?>? get properties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MultiPolygonCopyWith<MultiPolygon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiPolygonCopyWith<$Res> {
  factory $MultiPolygonCopyWith(
          MultiPolygon value, $Res Function(MultiPolygon) then) =
      _$MultiPolygonCopyWithImpl<$Res, MultiPolygon>;
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<List<List<int>>> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class _$MultiPolygonCopyWithImpl<$Res, $Val extends MultiPolygon>
    implements $MultiPolygonCopyWith<$Res> {
  _$MultiPolygonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType,
      arcs: null == arcs
          ? _value.arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<List<List<int>>>,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MultiPolygonImplCopyWith<$Res>
    implements $MultiPolygonCopyWith<$Res> {
  factory _$$MultiPolygonImplCopyWith(
          _$MultiPolygonImpl value, $Res Function(_$MultiPolygonImpl) then) =
      __$$MultiPolygonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<List<List<int>>> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class __$$MultiPolygonImplCopyWithImpl<$Res>
    extends _$MultiPolygonCopyWithImpl<$Res, _$MultiPolygonImpl>
    implements _$$MultiPolygonImplCopyWith<$Res> {
  __$$MultiPolygonImplCopyWithImpl(
      _$MultiPolygonImpl _value, $Res Function(_$MultiPolygonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_$MultiPolygonImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType,
      arcs: null == arcs
          ? _value._arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<List<List<int>>>,
      properties: freezed == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MultiPolygonImpl implements _MultiPolygon {
  const _$MultiPolygonImpl(
      {required this.type,
      required final List<List<List<int>>> arcs,
      required final Map<String, String?>? properties})
      : _arcs = arcs,
        _properties = properties;

  factory _$MultiPolygonImpl.fromJson(Map<String, dynamic> json) =>
      _$$MultiPolygonImplFromJson(json);

  @override
  final TopoJsonGeometryType type;
  final List<List<List<int>>> _arcs;
  @override
  List<List<List<int>>> get arcs {
    if (_arcs is EqualUnmodifiableListView) return _arcs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_arcs);
  }

  final Map<String, String?>? _properties;
  @override
  Map<String, String?>? get properties {
    final value = _properties;
    if (value == null) return null;
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MultiPolygon(type: $type, arcs: $arcs, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultiPolygonImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._arcs, _arcs) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_arcs),
      const DeepCollectionEquality().hash(_properties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MultiPolygonImplCopyWith<_$MultiPolygonImpl> get copyWith =>
      __$$MultiPolygonImplCopyWithImpl<_$MultiPolygonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MultiPolygonImplToJson(
      this,
    );
  }
}

abstract class _MultiPolygon implements MultiPolygon {
  const factory _MultiPolygon(
      {required final TopoJsonGeometryType type,
      required final List<List<List<int>>> arcs,
      required final Map<String, String?>? properties}) = _$MultiPolygonImpl;

  factory _MultiPolygon.fromJson(Map<String, dynamic> json) =
      _$MultiPolygonImpl.fromJson;

  @override
  TopoJsonGeometryType get type;
  @override
  List<List<List<int>>> get arcs;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$MultiPolygonImplCopyWith<_$MultiPolygonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeometryCollection _$GeometryCollectionFromJson(Map<String, dynamic> json) {
  return _GeometryCollection.fromJson(json);
}

/// @nodoc
mixin _$GeometryCollection {
  TopoJsonGeometryType get type => throw _privateConstructorUsedError;
  List<TopoJsonGeometryObject> get geometries =>
      throw _privateConstructorUsedError;
  Map<String, String?>? get properties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeometryCollectionCopyWith<GeometryCollection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeometryCollectionCopyWith<$Res> {
  factory $GeometryCollectionCopyWith(
          GeometryCollection value, $Res Function(GeometryCollection) then) =
      _$GeometryCollectionCopyWithImpl<$Res, GeometryCollection>;
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<TopoJsonGeometryObject> geometries,
      Map<String, String?>? properties});
}

/// @nodoc
class _$GeometryCollectionCopyWithImpl<$Res, $Val extends GeometryCollection>
    implements $GeometryCollectionCopyWith<$Res> {
  _$GeometryCollectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? geometries = null,
    Object? properties = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType,
      geometries: null == geometries
          ? _value.geometries
          : geometries // ignore: cast_nullable_to_non_nullable
              as List<TopoJsonGeometryObject>,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeometryCollectionImplCopyWith<$Res>
    implements $GeometryCollectionCopyWith<$Res> {
  factory _$$GeometryCollectionImplCopyWith(_$GeometryCollectionImpl value,
          $Res Function(_$GeometryCollectionImpl) then) =
      __$$GeometryCollectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<TopoJsonGeometryObject> geometries,
      Map<String, String?>? properties});
}

/// @nodoc
class __$$GeometryCollectionImplCopyWithImpl<$Res>
    extends _$GeometryCollectionCopyWithImpl<$Res, _$GeometryCollectionImpl>
    implements _$$GeometryCollectionImplCopyWith<$Res> {
  __$$GeometryCollectionImplCopyWithImpl(_$GeometryCollectionImpl _value,
      $Res Function(_$GeometryCollectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? geometries = null,
    Object? properties = freezed,
  }) {
    return _then(_$GeometryCollectionImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType,
      geometries: null == geometries
          ? _value._geometries
          : geometries // ignore: cast_nullable_to_non_nullable
              as List<TopoJsonGeometryObject>,
      properties: freezed == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeometryCollectionImpl implements _GeometryCollection {
  const _$GeometryCollectionImpl(
      {required this.type,
      required final List<TopoJsonGeometryObject> geometries,
      required final Map<String, String?>? properties})
      : _geometries = geometries,
        _properties = properties;

  factory _$GeometryCollectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeometryCollectionImplFromJson(json);

  @override
  final TopoJsonGeometryType type;
  final List<TopoJsonGeometryObject> _geometries;
  @override
  List<TopoJsonGeometryObject> get geometries {
    if (_geometries is EqualUnmodifiableListView) return _geometries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_geometries);
  }

  final Map<String, String?>? _properties;
  @override
  Map<String, String?>? get properties {
    final value = _properties;
    if (value == null) return null;
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'GeometryCollection(type: $type, geometries: $geometries, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeometryCollectionImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._geometries, _geometries) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_geometries),
      const DeepCollectionEquality().hash(_properties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeometryCollectionImplCopyWith<_$GeometryCollectionImpl> get copyWith =>
      __$$GeometryCollectionImplCopyWithImpl<_$GeometryCollectionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeometryCollectionImplToJson(
      this,
    );
  }
}

abstract class _GeometryCollection implements GeometryCollection {
  const factory _GeometryCollection(
          {required final TopoJsonGeometryType type,
          required final List<TopoJsonGeometryObject> geometries,
          required final Map<String, String?>? properties}) =
      _$GeometryCollectionImpl;

  factory _GeometryCollection.fromJson(Map<String, dynamic> json) =
      _$GeometryCollectionImpl.fromJson;

  @override
  TopoJsonGeometryType get type;
  @override
  List<TopoJsonGeometryObject> get geometries;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$GeometryCollectionImplCopyWith<_$GeometryCollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NullGeometryObject _$NullGeometryObjectFromJson(Map<String, dynamic> json) {
  return _NullGeometryObject.fromJson(json);
}

/// @nodoc
mixin _$NullGeometryObject {
  TopoJsonGeometryType? get type => throw _privateConstructorUsedError;
  Map<String, String?>? get properties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NullGeometryObjectCopyWith<NullGeometryObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NullGeometryObjectCopyWith<$Res> {
  factory $NullGeometryObjectCopyWith(
          NullGeometryObject value, $Res Function(NullGeometryObject) then) =
      _$NullGeometryObjectCopyWithImpl<$Res, NullGeometryObject>;
  @useResult
  $Res call({TopoJsonGeometryType? type, Map<String, String?>? properties});
}

/// @nodoc
class _$NullGeometryObjectCopyWithImpl<$Res, $Val extends NullGeometryObject>
    implements $NullGeometryObjectCopyWith<$Res> {
  _$NullGeometryObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? properties = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType?,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NullGeometryObjectImplCopyWith<$Res>
    implements $NullGeometryObjectCopyWith<$Res> {
  factory _$$NullGeometryObjectImplCopyWith(_$NullGeometryObjectImpl value,
          $Res Function(_$NullGeometryObjectImpl) then) =
      __$$NullGeometryObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TopoJsonGeometryType? type, Map<String, String?>? properties});
}

/// @nodoc
class __$$NullGeometryObjectImplCopyWithImpl<$Res>
    extends _$NullGeometryObjectCopyWithImpl<$Res, _$NullGeometryObjectImpl>
    implements _$$NullGeometryObjectImplCopyWith<$Res> {
  __$$NullGeometryObjectImplCopyWithImpl(_$NullGeometryObjectImpl _value,
      $Res Function(_$NullGeometryObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? properties = freezed,
  }) {
    return _then(_$NullGeometryObjectImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TopoJsonGeometryType?,
      properties: freezed == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NullGeometryObjectImpl implements _NullGeometryObject {
  const _$NullGeometryObjectImpl(
      {required this.type, required final Map<String, String?>? properties})
      : _properties = properties;

  factory _$NullGeometryObjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$NullGeometryObjectImplFromJson(json);

  @override
  final TopoJsonGeometryType? type;
  final Map<String, String?>? _properties;
  @override
  Map<String, String?>? get properties {
    final value = _properties;
    if (value == null) return null;
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'NullGeometryObject(type: $type, properties: $properties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NullGeometryObjectImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_properties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NullGeometryObjectImplCopyWith<_$NullGeometryObjectImpl> get copyWith =>
      __$$NullGeometryObjectImplCopyWithImpl<_$NullGeometryObjectImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NullGeometryObjectImplToJson(
      this,
    );
  }
}

abstract class _NullGeometryObject implements NullGeometryObject {
  const factory _NullGeometryObject(
          {required final TopoJsonGeometryType? type,
          required final Map<String, String?>? properties}) =
      _$NullGeometryObjectImpl;

  factory _NullGeometryObject.fromJson(Map<String, dynamic> json) =
      _$NullGeometryObjectImpl.fromJson;

  @override
  TopoJsonGeometryType? get type;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$NullGeometryObjectImplCopyWith<_$NullGeometryObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
