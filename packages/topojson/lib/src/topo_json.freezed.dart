// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topo_json.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TopoJson _$TopoJsonFromJson(Map<String, dynamic> json) {
  return _TopoJson.fromJson(json);
}

/// @nodoc
mixin _$TopoJson {
  String get type => throw _privateConstructorUsedError;
  TopoJsonTransform? get transform => throw _privateConstructorUsedError;
  Map<String, TopoJsonGeometryObject> get objects =>
      throw _privateConstructorUsedError;
  List<List<List<int>>> get arcs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopoJsonCopyWith<TopoJson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopoJsonCopyWith<$Res> {
  factory $TopoJsonCopyWith(TopoJson value, $Res Function(TopoJson) then) =
      _$TopoJsonCopyWithImpl<$Res, TopoJson>;
  @useResult
  $Res call(
      {String type,
      TopoJsonTransform? transform,
      Map<String, TopoJsonGeometryObject> objects,
      List<List<List<int>>> arcs});

  $TopoJsonTransformCopyWith<$Res>? get transform;
}

/// @nodoc
class _$TopoJsonCopyWithImpl<$Res, $Val extends TopoJson>
    implements $TopoJsonCopyWith<$Res> {
  _$TopoJsonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? transform = freezed,
    Object? objects = null,
    Object? arcs = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      transform: freezed == transform
          ? _value.transform
          : transform // ignore: cast_nullable_to_non_nullable
              as TopoJsonTransform?,
      objects: null == objects
          ? _value.objects
          : objects // ignore: cast_nullable_to_non_nullable
              as Map<String, TopoJsonGeometryObject>,
      arcs: null == arcs
          ? _value.arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<List<List<int>>>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TopoJsonTransformCopyWith<$Res>? get transform {
    if (_value.transform == null) {
      return null;
    }

    return $TopoJsonTransformCopyWith<$Res>(_value.transform!, (value) {
      return _then(_value.copyWith(transform: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TopoJsonCopyWith<$Res> implements $TopoJsonCopyWith<$Res> {
  factory _$$_TopoJsonCopyWith(
          _$_TopoJson value, $Res Function(_$_TopoJson) then) =
      __$$_TopoJsonCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      TopoJsonTransform? transform,
      Map<String, TopoJsonGeometryObject> objects,
      List<List<List<int>>> arcs});

  @override
  $TopoJsonTransformCopyWith<$Res>? get transform;
}

/// @nodoc
class __$$_TopoJsonCopyWithImpl<$Res>
    extends _$TopoJsonCopyWithImpl<$Res, _$_TopoJson>
    implements _$$_TopoJsonCopyWith<$Res> {
  __$$_TopoJsonCopyWithImpl(
      _$_TopoJson _value, $Res Function(_$_TopoJson) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? transform = freezed,
    Object? objects = null,
    Object? arcs = null,
  }) {
    return _then(_$_TopoJson(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      transform: freezed == transform
          ? _value.transform
          : transform // ignore: cast_nullable_to_non_nullable
              as TopoJsonTransform?,
      objects: null == objects
          ? _value._objects
          : objects // ignore: cast_nullable_to_non_nullable
              as Map<String, TopoJsonGeometryObject>,
      arcs: null == arcs
          ? _value._arcs
          : arcs // ignore: cast_nullable_to_non_nullable
              as List<List<List<int>>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TopoJson implements _TopoJson {
  const _$_TopoJson(
      {required this.type,
      required this.transform,
      required final Map<String, TopoJsonGeometryObject> objects,
      required final List<List<List<int>>> arcs})
      : _objects = objects,
        _arcs = arcs;

  factory _$_TopoJson.fromJson(Map<String, dynamic> json) =>
      _$$_TopoJsonFromJson(json);

  @override
  final String type;
  @override
  final TopoJsonTransform? transform;
  final Map<String, TopoJsonGeometryObject> _objects;
  @override
  Map<String, TopoJsonGeometryObject> get objects {
    if (_objects is EqualUnmodifiableMapView) return _objects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_objects);
  }

  final List<List<List<int>>> _arcs;
  @override
  List<List<List<int>>> get arcs {
    if (_arcs is EqualUnmodifiableListView) return _arcs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_arcs);
  }

  @override
  String toString() {
    return 'TopoJson(type: $type, transform: $transform, objects: $objects, arcs: $arcs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TopoJson &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.transform, transform) ||
                other.transform == transform) &&
            const DeepCollectionEquality().equals(other._objects, _objects) &&
            const DeepCollectionEquality().equals(other._arcs, _arcs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      transform,
      const DeepCollectionEquality().hash(_objects),
      const DeepCollectionEquality().hash(_arcs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TopoJsonCopyWith<_$_TopoJson> get copyWith =>
      __$$_TopoJsonCopyWithImpl<_$_TopoJson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TopoJsonToJson(
      this,
    );
  }
}

abstract class _TopoJson implements TopoJson {
  const factory _TopoJson(
      {required final String type,
      required final TopoJsonTransform? transform,
      required final Map<String, TopoJsonGeometryObject> objects,
      required final List<List<List<int>>> arcs}) = _$_TopoJson;

  factory _TopoJson.fromJson(Map<String, dynamic> json) = _$_TopoJson.fromJson;

  @override
  String get type;
  @override
  TopoJsonTransform? get transform;
  @override
  Map<String, TopoJsonGeometryObject> get objects;
  @override
  List<List<List<int>>> get arcs;
  @override
  @JsonKey(ignore: true)
  _$$_TopoJsonCopyWith<_$_TopoJson> get copyWith =>
      throw _privateConstructorUsedError;
}
