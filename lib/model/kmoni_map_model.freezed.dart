// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'kmoni_map_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KmoniMapModel {
  /// Mapに表示する日本のポリゴン
  List<MapPolygon> get mapPolygons => throw _privateConstructorUsedError;
  Matrix4 get mapMatrix4 => throw _privateConstructorUsedError;
  double get mapOutlineStrokeWidth => throw _privateConstructorUsedError;
  Color get mapOutlineStrokeColor => throw _privateConstructorUsedError;
  Color get mapFillColor => throw _privateConstructorUsedError;

  /// マップがロードされたかどうか
  bool get isMapLoaded => throw _privateConstructorUsedError;

  /// 読み込みにかかった時間
  Duration? get loadDuration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KmoniMapModelCopyWith<KmoniMapModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KmoniMapModelCopyWith<$Res> {
  factory $KmoniMapModelCopyWith(
          KmoniMapModel value, $Res Function(KmoniMapModel) then) =
      _$KmoniMapModelCopyWithImpl<$Res>;
  $Res call(
      {List<MapPolygon> mapPolygons,
      Matrix4 mapMatrix4,
      double mapOutlineStrokeWidth,
      Color mapOutlineStrokeColor,
      Color mapFillColor,
      bool isMapLoaded,
      Duration? loadDuration});
}

/// @nodoc
class _$KmoniMapModelCopyWithImpl<$Res>
    implements $KmoniMapModelCopyWith<$Res> {
  _$KmoniMapModelCopyWithImpl(this._value, this._then);

  final KmoniMapModel _value;
  // ignore: unused_field
  final $Res Function(KmoniMapModel) _then;

  @override
  $Res call({
    Object? mapPolygons = freezed,
    Object? mapMatrix4 = freezed,
    Object? mapOutlineStrokeWidth = freezed,
    Object? mapOutlineStrokeColor = freezed,
    Object? mapFillColor = freezed,
    Object? isMapLoaded = freezed,
    Object? loadDuration = freezed,
  }) {
    return _then(_value.copyWith(
      mapPolygons: mapPolygons == freezed
          ? _value.mapPolygons
          : mapPolygons // ignore: cast_nullable_to_non_nullable
              as List<MapPolygon>,
      mapMatrix4: mapMatrix4 == freezed
          ? _value.mapMatrix4
          : mapMatrix4 // ignore: cast_nullable_to_non_nullable
              as Matrix4,
      mapOutlineStrokeWidth: mapOutlineStrokeWidth == freezed
          ? _value.mapOutlineStrokeWidth
          : mapOutlineStrokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      mapOutlineStrokeColor: mapOutlineStrokeColor == freezed
          ? _value.mapOutlineStrokeColor
          : mapOutlineStrokeColor // ignore: cast_nullable_to_non_nullable
              as Color,
      mapFillColor: mapFillColor == freezed
          ? _value.mapFillColor
          : mapFillColor // ignore: cast_nullable_to_non_nullable
              as Color,
      isMapLoaded: isMapLoaded == freezed
          ? _value.isMapLoaded
          : isMapLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      loadDuration: loadDuration == freezed
          ? _value.loadDuration
          : loadDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc
abstract class _$$_KmoniMapModelCopyWith<$Res>
    implements $KmoniMapModelCopyWith<$Res> {
  factory _$$_KmoniMapModelCopyWith(
          _$_KmoniMapModel value, $Res Function(_$_KmoniMapModel) then) =
      __$$_KmoniMapModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<MapPolygon> mapPolygons,
      Matrix4 mapMatrix4,
      double mapOutlineStrokeWidth,
      Color mapOutlineStrokeColor,
      Color mapFillColor,
      bool isMapLoaded,
      Duration? loadDuration});
}

/// @nodoc
class __$$_KmoniMapModelCopyWithImpl<$Res>
    extends _$KmoniMapModelCopyWithImpl<$Res>
    implements _$$_KmoniMapModelCopyWith<$Res> {
  __$$_KmoniMapModelCopyWithImpl(
      _$_KmoniMapModel _value, $Res Function(_$_KmoniMapModel) _then)
      : super(_value, (v) => _then(v as _$_KmoniMapModel));

  @override
  _$_KmoniMapModel get _value => super._value as _$_KmoniMapModel;

  @override
  $Res call({
    Object? mapPolygons = freezed,
    Object? mapMatrix4 = freezed,
    Object? mapOutlineStrokeWidth = freezed,
    Object? mapOutlineStrokeColor = freezed,
    Object? mapFillColor = freezed,
    Object? isMapLoaded = freezed,
    Object? loadDuration = freezed,
  }) {
    return _then(_$_KmoniMapModel(
      mapPolygons: mapPolygons == freezed
          ? _value._mapPolygons
          : mapPolygons // ignore: cast_nullable_to_non_nullable
              as List<MapPolygon>,
      mapMatrix4: mapMatrix4 == freezed
          ? _value.mapMatrix4
          : mapMatrix4 // ignore: cast_nullable_to_non_nullable
              as Matrix4,
      mapOutlineStrokeWidth: mapOutlineStrokeWidth == freezed
          ? _value.mapOutlineStrokeWidth
          : mapOutlineStrokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      mapOutlineStrokeColor: mapOutlineStrokeColor == freezed
          ? _value.mapOutlineStrokeColor
          : mapOutlineStrokeColor // ignore: cast_nullable_to_non_nullable
              as Color,
      mapFillColor: mapFillColor == freezed
          ? _value.mapFillColor
          : mapFillColor // ignore: cast_nullable_to_non_nullable
              as Color,
      isMapLoaded: isMapLoaded == freezed
          ? _value.isMapLoaded
          : isMapLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      loadDuration: loadDuration == freezed
          ? _value.loadDuration
          : loadDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$_KmoniMapModel implements _KmoniMapModel {
  const _$_KmoniMapModel(
      {required final List<MapPolygon> mapPolygons,
      required this.mapMatrix4,
      required this.mapOutlineStrokeWidth,
      required this.mapOutlineStrokeColor,
      required this.mapFillColor,
      required this.isMapLoaded,
      required this.loadDuration})
      : _mapPolygons = mapPolygons;

  /// Mapに表示する日本のポリゴン
  final List<MapPolygon> _mapPolygons;

  /// Mapに表示する日本のポリゴン
  @override
  List<MapPolygon> get mapPolygons {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mapPolygons);
  }

  @override
  final Matrix4 mapMatrix4;
  @override
  final double mapOutlineStrokeWidth;
  @override
  final Color mapOutlineStrokeColor;
  @override
  final Color mapFillColor;

  /// マップがロードされたかどうか
  @override
  final bool isMapLoaded;

  /// 読み込みにかかった時間
  @override
  final Duration? loadDuration;

  @override
  String toString() {
    return 'KmoniMapModel(mapPolygons: $mapPolygons, mapMatrix4: $mapMatrix4, mapOutlineStrokeWidth: $mapOutlineStrokeWidth, mapOutlineStrokeColor: $mapOutlineStrokeColor, mapFillColor: $mapFillColor, isMapLoaded: $isMapLoaded, loadDuration: $loadDuration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KmoniMapModel &&
            const DeepCollectionEquality()
                .equals(other._mapPolygons, _mapPolygons) &&
            const DeepCollectionEquality()
                .equals(other.mapMatrix4, mapMatrix4) &&
            const DeepCollectionEquality()
                .equals(other.mapOutlineStrokeWidth, mapOutlineStrokeWidth) &&
            const DeepCollectionEquality()
                .equals(other.mapOutlineStrokeColor, mapOutlineStrokeColor) &&
            const DeepCollectionEquality()
                .equals(other.mapFillColor, mapFillColor) &&
            const DeepCollectionEquality()
                .equals(other.isMapLoaded, isMapLoaded) &&
            const DeepCollectionEquality()
                .equals(other.loadDuration, loadDuration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mapPolygons),
      const DeepCollectionEquality().hash(mapMatrix4),
      const DeepCollectionEquality().hash(mapOutlineStrokeWidth),
      const DeepCollectionEquality().hash(mapOutlineStrokeColor),
      const DeepCollectionEquality().hash(mapFillColor),
      const DeepCollectionEquality().hash(isMapLoaded),
      const DeepCollectionEquality().hash(loadDuration));

  @JsonKey(ignore: true)
  @override
  _$$_KmoniMapModelCopyWith<_$_KmoniMapModel> get copyWith =>
      __$$_KmoniMapModelCopyWithImpl<_$_KmoniMapModel>(this, _$identity);
}

abstract class _KmoniMapModel implements KmoniMapModel {
  const factory _KmoniMapModel(
      {required final List<MapPolygon> mapPolygons,
      required final Matrix4 mapMatrix4,
      required final double mapOutlineStrokeWidth,
      required final Color mapOutlineStrokeColor,
      required final Color mapFillColor,
      required final bool isMapLoaded,
      required final Duration? loadDuration}) = _$_KmoniMapModel;

  @override

  /// Mapに表示する日本のポリゴン
  List<MapPolygon> get mapPolygons;
  @override
  Matrix4 get mapMatrix4;
  @override
  double get mapOutlineStrokeWidth;
  @override
  Color get mapOutlineStrokeColor;
  @override
  Color get mapFillColor;
  @override

  /// マップがロードされたかどうか
  bool get isMapLoaded;
  @override

  /// 読み込みにかかった時間
  Duration? get loadDuration;
  @override
  @JsonKey(ignore: true)
  _$$_KmoniMapModelCopyWith<_$_KmoniMapModel> get copyWith =>
      throw _privateConstructorUsedError;
}
