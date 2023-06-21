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
abstract class _$$_LineStringCopyWith<$Res>
    implements $LineStringCopyWith<$Res> {
  factory _$$_LineStringCopyWith(
          _$_LineString value, $Res Function(_$_LineString) then) =
      __$$_LineStringCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<int> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class __$$_LineStringCopyWithImpl<$Res>
    extends _$LineStringCopyWithImpl<$Res, _$_LineString>
    implements _$$_LineStringCopyWith<$Res> {
  __$$_LineStringCopyWithImpl(
      _$_LineString _value, $Res Function(_$_LineString) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_$_LineString(
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
class _$_LineString implements _LineString {
  const _$_LineString(
      {required this.type,
      required final List<int> arcs,
      required final Map<String, String?>? properties})
      : _arcs = arcs,
        _properties = properties;

  factory _$_LineString.fromJson(Map<String, dynamic> json) =>
      _$$_LineStringFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LineString &&
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
  _$$_LineStringCopyWith<_$_LineString> get copyWith =>
      __$$_LineStringCopyWithImpl<_$_LineString>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LineStringToJson(
      this,
    );
  }
}

abstract class _LineString implements LineString {
  const factory _LineString(
      {required final TopoJsonGeometryType type,
      required final List<int> arcs,
      required final Map<String, String?>? properties}) = _$_LineString;

  factory _LineString.fromJson(Map<String, dynamic> json) =
      _$_LineString.fromJson;

  @override
  TopoJsonGeometryType get type;
  @override
  List<int> get arcs;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$_LineStringCopyWith<_$_LineString> get copyWith =>
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
abstract class _$$_MultiLineStringCopyWith<$Res>
    implements $MultiLineStringCopyWith<$Res> {
  factory _$$_MultiLineStringCopyWith(
          _$_MultiLineString value, $Res Function(_$_MultiLineString) then) =
      __$$_MultiLineStringCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<List<int>> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class __$$_MultiLineStringCopyWithImpl<$Res>
    extends _$MultiLineStringCopyWithImpl<$Res, _$_MultiLineString>
    implements _$$_MultiLineStringCopyWith<$Res> {
  __$$_MultiLineStringCopyWithImpl(
      _$_MultiLineString _value, $Res Function(_$_MultiLineString) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_$_MultiLineString(
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
class _$_MultiLineString implements _MultiLineString {
  const _$_MultiLineString(
      {required this.type,
      required final List<List<int>> arcs,
      required final Map<String, String?>? properties})
      : _arcs = arcs,
        _properties = properties;

  factory _$_MultiLineString.fromJson(Map<String, dynamic> json) =>
      _$$_MultiLineStringFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MultiLineString &&
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
  _$$_MultiLineStringCopyWith<_$_MultiLineString> get copyWith =>
      __$$_MultiLineStringCopyWithImpl<_$_MultiLineString>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MultiLineStringToJson(
      this,
    );
  }
}

abstract class _MultiLineString implements MultiLineString {
  const factory _MultiLineString(
      {required final TopoJsonGeometryType type,
      required final List<List<int>> arcs,
      required final Map<String, String?>? properties}) = _$_MultiLineString;

  factory _MultiLineString.fromJson(Map<String, dynamic> json) =
      _$_MultiLineString.fromJson;

  @override
  TopoJsonGeometryType get type;
  @override
  List<List<int>> get arcs;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$_MultiLineStringCopyWith<_$_MultiLineString> get copyWith =>
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
abstract class _$$_PolygonCopyWith<$Res> implements $PolygonCopyWith<$Res> {
  factory _$$_PolygonCopyWith(
          _$_Polygon value, $Res Function(_$_Polygon) then) =
      __$$_PolygonCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<List<int>> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class __$$_PolygonCopyWithImpl<$Res>
    extends _$PolygonCopyWithImpl<$Res, _$_Polygon>
    implements _$$_PolygonCopyWith<$Res> {
  __$$_PolygonCopyWithImpl(_$_Polygon _value, $Res Function(_$_Polygon) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_$_Polygon(
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
class _$_Polygon implements _Polygon {
  const _$_Polygon(
      {required this.type,
      required final List<List<int>> arcs,
      required final Map<String, String?>? properties})
      : _arcs = arcs,
        _properties = properties;

  factory _$_Polygon.fromJson(Map<String, dynamic> json) =>
      _$$_PolygonFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Polygon &&
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
  _$$_PolygonCopyWith<_$_Polygon> get copyWith =>
      __$$_PolygonCopyWithImpl<_$_Polygon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PolygonToJson(
      this,
    );
  }
}

abstract class _Polygon implements Polygon {
  const factory _Polygon(
      {required final TopoJsonGeometryType type,
      required final List<List<int>> arcs,
      required final Map<String, String?>? properties}) = _$_Polygon;

  factory _Polygon.fromJson(Map<String, dynamic> json) = _$_Polygon.fromJson;

  @override
  TopoJsonGeometryType get type;
  @override
  List<List<int>> get arcs;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$_PolygonCopyWith<_$_Polygon> get copyWith =>
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
abstract class _$$_MultiPolygonCopyWith<$Res>
    implements $MultiPolygonCopyWith<$Res> {
  factory _$$_MultiPolygonCopyWith(
          _$_MultiPolygon value, $Res Function(_$_MultiPolygon) then) =
      __$$_MultiPolygonCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<List<List<int>>> arcs,
      Map<String, String?>? properties});
}

/// @nodoc
class __$$_MultiPolygonCopyWithImpl<$Res>
    extends _$MultiPolygonCopyWithImpl<$Res, _$_MultiPolygon>
    implements _$$_MultiPolygonCopyWith<$Res> {
  __$$_MultiPolygonCopyWithImpl(
      _$_MultiPolygon _value, $Res Function(_$_MultiPolygon) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? arcs = null,
    Object? properties = freezed,
  }) {
    return _then(_$_MultiPolygon(
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
class _$_MultiPolygon implements _MultiPolygon {
  const _$_MultiPolygon(
      {required this.type,
      required final List<List<List<int>>> arcs,
      required final Map<String, String?>? properties})
      : _arcs = arcs,
        _properties = properties;

  factory _$_MultiPolygon.fromJson(Map<String, dynamic> json) =>
      _$$_MultiPolygonFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MultiPolygon &&
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
  _$$_MultiPolygonCopyWith<_$_MultiPolygon> get copyWith =>
      __$$_MultiPolygonCopyWithImpl<_$_MultiPolygon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MultiPolygonToJson(
      this,
    );
  }
}

abstract class _MultiPolygon implements MultiPolygon {
  const factory _MultiPolygon(
      {required final TopoJsonGeometryType type,
      required final List<List<List<int>>> arcs,
      required final Map<String, String?>? properties}) = _$_MultiPolygon;

  factory _MultiPolygon.fromJson(Map<String, dynamic> json) =
      _$_MultiPolygon.fromJson;

  @override
  TopoJsonGeometryType get type;
  @override
  List<List<List<int>>> get arcs;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$_MultiPolygonCopyWith<_$_MultiPolygon> get copyWith =>
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
abstract class _$$_GeometryCollectionCopyWith<$Res>
    implements $GeometryCollectionCopyWith<$Res> {
  factory _$$_GeometryCollectionCopyWith(_$_GeometryCollection value,
          $Res Function(_$_GeometryCollection) then) =
      __$$_GeometryCollectionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TopoJsonGeometryType type,
      List<TopoJsonGeometryObject> geometries,
      Map<String, String?>? properties});
}

/// @nodoc
class __$$_GeometryCollectionCopyWithImpl<$Res>
    extends _$GeometryCollectionCopyWithImpl<$Res, _$_GeometryCollection>
    implements _$$_GeometryCollectionCopyWith<$Res> {
  __$$_GeometryCollectionCopyWithImpl(
      _$_GeometryCollection _value, $Res Function(_$_GeometryCollection) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? geometries = null,
    Object? properties = freezed,
  }) {
    return _then(_$_GeometryCollection(
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
class _$_GeometryCollection implements _GeometryCollection {
  const _$_GeometryCollection(
      {required this.type,
      required final List<TopoJsonGeometryObject> geometries,
      required final Map<String, String?>? properties})
      : _geometries = geometries,
        _properties = properties;

  factory _$_GeometryCollection.fromJson(Map<String, dynamic> json) =>
      _$$_GeometryCollectionFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GeometryCollection &&
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
  _$$_GeometryCollectionCopyWith<_$_GeometryCollection> get copyWith =>
      __$$_GeometryCollectionCopyWithImpl<_$_GeometryCollection>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeometryCollectionToJson(
      this,
    );
  }
}

abstract class _GeometryCollection implements GeometryCollection {
  const factory _GeometryCollection(
      {required final TopoJsonGeometryType type,
      required final List<TopoJsonGeometryObject> geometries,
      required final Map<String, String?>? properties}) = _$_GeometryCollection;

  factory _GeometryCollection.fromJson(Map<String, dynamic> json) =
      _$_GeometryCollection.fromJson;

  @override
  TopoJsonGeometryType get type;
  @override
  List<TopoJsonGeometryObject> get geometries;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$_GeometryCollectionCopyWith<_$_GeometryCollection> get copyWith =>
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
abstract class _$$_NullGeometryObjectCopyWith<$Res>
    implements $NullGeometryObjectCopyWith<$Res> {
  factory _$$_NullGeometryObjectCopyWith(_$_NullGeometryObject value,
          $Res Function(_$_NullGeometryObject) then) =
      __$$_NullGeometryObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TopoJsonGeometryType? type, Map<String, String?>? properties});
}

/// @nodoc
class __$$_NullGeometryObjectCopyWithImpl<$Res>
    extends _$NullGeometryObjectCopyWithImpl<$Res, _$_NullGeometryObject>
    implements _$$_NullGeometryObjectCopyWith<$Res> {
  __$$_NullGeometryObjectCopyWithImpl(
      _$_NullGeometryObject _value, $Res Function(_$_NullGeometryObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? properties = freezed,
  }) {
    return _then(_$_NullGeometryObject(
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
class _$_NullGeometryObject implements _NullGeometryObject {
  const _$_NullGeometryObject(
      {required this.type, required final Map<String, String?>? properties})
      : _properties = properties;

  factory _$_NullGeometryObject.fromJson(Map<String, dynamic> json) =>
      _$$_NullGeometryObjectFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NullGeometryObject &&
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
  _$$_NullGeometryObjectCopyWith<_$_NullGeometryObject> get copyWith =>
      __$$_NullGeometryObjectCopyWithImpl<_$_NullGeometryObject>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NullGeometryObjectToJson(
      this,
    );
  }
}

abstract class _NullGeometryObject implements NullGeometryObject {
  const factory _NullGeometryObject(
      {required final TopoJsonGeometryType? type,
      required final Map<String, String?>? properties}) = _$_NullGeometryObject;

  factory _NullGeometryObject.fromJson(Map<String, dynamic> json) =
      _$_NullGeometryObject.fromJson;

  @override
  TopoJsonGeometryType? get type;
  @override
  Map<String, String?>? get properties;
  @override
  @JsonKey(ignore: true)
  _$$_NullGeometryObjectCopyWith<_$_NullGeometryObject> get copyWith =>
      throw _privateConstructorUsedError;
}
