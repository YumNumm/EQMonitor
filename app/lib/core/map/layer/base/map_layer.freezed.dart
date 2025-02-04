// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_layer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MapLayer {
  String get id => throw _privateConstructorUsedError;
  String get sourceId => throw _privateConstructorUsedError;
  bool get visible => throw _privateConstructorUsedError;
  double? get minZoom => throw _privateConstructorUsedError;
  double? get maxZoom => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)
        circle,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)
        symbol,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)
        heatmap,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)
        line,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)?
        circle,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)?
        symbol,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)?
        heatmap,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)?
        line,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)?
        circle,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)?
        symbol,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)?
        heatmap,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)?
        line,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CircleMapLayer value) circle,
    required TResult Function(SymbolMapLayer value) symbol,
    required TResult Function(HeatmapMapLayer value) heatmap,
    required TResult Function(LineMapLayer value) line,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CircleMapLayer value)? circle,
    TResult? Function(SymbolMapLayer value)? symbol,
    TResult? Function(HeatmapMapLayer value)? heatmap,
    TResult? Function(LineMapLayer value)? line,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CircleMapLayer value)? circle,
    TResult Function(SymbolMapLayer value)? symbol,
    TResult Function(HeatmapMapLayer value)? heatmap,
    TResult Function(LineMapLayer value)? line,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapLayerCopyWith<MapLayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapLayerCopyWith<$Res> {
  factory $MapLayerCopyWith(MapLayer value, $Res Function(MapLayer) then) =
      _$MapLayerCopyWithImpl<$Res, MapLayer>;
  @useResult
  $Res call(
      {String id,
      String sourceId,
      bool visible,
      double? minZoom,
      double? maxZoom});
}

/// @nodoc
class _$MapLayerCopyWithImpl<$Res, $Val extends MapLayer>
    implements $MapLayerCopyWith<$Res> {
  _$MapLayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceId = null,
    Object? visible = null,
    Object? minZoom = freezed,
    Object? maxZoom = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      minZoom: freezed == minZoom
          ? _value.minZoom
          : minZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      maxZoom: freezed == maxZoom
          ? _value.maxZoom
          : maxZoom // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CircleMapLayerImplCopyWith<$Res>
    implements $MapLayerCopyWith<$Res> {
  factory _$$CircleMapLayerImplCopyWith(_$CircleMapLayerImpl value,
          $Res Function(_$CircleMapLayerImpl) then) =
      __$$CircleMapLayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sourceId,
      List<Map<String, dynamic>> circles,
      bool visible,
      double? minZoom,
      double? maxZoom,
      double circleRadius,
      Color circleColor,
      double circleOpacity,
      double circleStrokeWidth,
      Color circleStrokeColor,
      double circleBlur});
}

/// @nodoc
class __$$CircleMapLayerImplCopyWithImpl<$Res>
    extends _$MapLayerCopyWithImpl<$Res, _$CircleMapLayerImpl>
    implements _$$CircleMapLayerImplCopyWith<$Res> {
  __$$CircleMapLayerImplCopyWithImpl(
      _$CircleMapLayerImpl _value, $Res Function(_$CircleMapLayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceId = null,
    Object? circles = null,
    Object? visible = null,
    Object? minZoom = freezed,
    Object? maxZoom = freezed,
    Object? circleRadius = null,
    Object? circleColor = null,
    Object? circleOpacity = null,
    Object? circleStrokeWidth = null,
    Object? circleStrokeColor = null,
    Object? circleBlur = null,
  }) {
    return _then(_$CircleMapLayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      circles: null == circles
          ? _value._circles
          : circles // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      minZoom: freezed == minZoom
          ? _value.minZoom
          : minZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      maxZoom: freezed == maxZoom
          ? _value.maxZoom
          : maxZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      circleRadius: null == circleRadius
          ? _value.circleRadius
          : circleRadius // ignore: cast_nullable_to_non_nullable
              as double,
      circleColor: null == circleColor
          ? _value.circleColor
          : circleColor // ignore: cast_nullable_to_non_nullable
              as Color,
      circleOpacity: null == circleOpacity
          ? _value.circleOpacity
          : circleOpacity // ignore: cast_nullable_to_non_nullable
              as double,
      circleStrokeWidth: null == circleStrokeWidth
          ? _value.circleStrokeWidth
          : circleStrokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      circleStrokeColor: null == circleStrokeColor
          ? _value.circleStrokeColor
          : circleStrokeColor // ignore: cast_nullable_to_non_nullable
              as Color,
      circleBlur: null == circleBlur
          ? _value.circleBlur
          : circleBlur // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$CircleMapLayerImpl extends CircleMapLayer {
  const _$CircleMapLayerImpl(
      {required this.id,
      required this.sourceId,
      required final List<Map<String, dynamic>> circles,
      this.visible = true,
      this.minZoom,
      this.maxZoom,
      this.circleRadius = 10.0,
      this.circleColor = Colors.blue,
      this.circleOpacity = 1.0,
      this.circleStrokeWidth = 0.0,
      this.circleStrokeColor = Colors.black,
      this.circleBlur = 0.0})
      : _circles = circles,
        super._();

  @override
  final String id;
  @override
  final String sourceId;
  final List<Map<String, dynamic>> _circles;
  @override
  List<Map<String, dynamic>> get circles {
    if (_circles is EqualUnmodifiableListView) return _circles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_circles);
  }

  @override
  @JsonKey()
  final bool visible;
  @override
  final double? minZoom;
  @override
  final double? maxZoom;
  @override
  @JsonKey()
  final double circleRadius;
  @override
  @JsonKey()
  final Color circleColor;
  @override
  @JsonKey()
  final double circleOpacity;
  @override
  @JsonKey()
  final double circleStrokeWidth;
  @override
  @JsonKey()
  final Color circleStrokeColor;
  @override
  @JsonKey()
  final double circleBlur;

  @override
  String toString() {
    return 'MapLayer.circle(id: $id, sourceId: $sourceId, circles: $circles, visible: $visible, minZoom: $minZoom, maxZoom: $maxZoom, circleRadius: $circleRadius, circleColor: $circleColor, circleOpacity: $circleOpacity, circleStrokeWidth: $circleStrokeWidth, circleStrokeColor: $circleStrokeColor, circleBlur: $circleBlur)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CircleMapLayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            const DeepCollectionEquality().equals(other._circles, _circles) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.minZoom, minZoom) || other.minZoom == minZoom) &&
            (identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom) &&
            (identical(other.circleRadius, circleRadius) ||
                other.circleRadius == circleRadius) &&
            (identical(other.circleColor, circleColor) ||
                other.circleColor == circleColor) &&
            (identical(other.circleOpacity, circleOpacity) ||
                other.circleOpacity == circleOpacity) &&
            (identical(other.circleStrokeWidth, circleStrokeWidth) ||
                other.circleStrokeWidth == circleStrokeWidth) &&
            (identical(other.circleStrokeColor, circleStrokeColor) ||
                other.circleStrokeColor == circleStrokeColor) &&
            (identical(other.circleBlur, circleBlur) ||
                other.circleBlur == circleBlur));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sourceId,
      const DeepCollectionEquality().hash(_circles),
      visible,
      minZoom,
      maxZoom,
      circleRadius,
      circleColor,
      circleOpacity,
      circleStrokeWidth,
      circleStrokeColor,
      circleBlur);

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CircleMapLayerImplCopyWith<_$CircleMapLayerImpl> get copyWith =>
      __$$CircleMapLayerImplCopyWithImpl<_$CircleMapLayerImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)
        circle,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)
        symbol,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)
        heatmap,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)
        line,
  }) {
    return circle(
        id,
        sourceId,
        circles,
        visible,
        minZoom,
        maxZoom,
        circleRadius,
        circleColor,
        circleOpacity,
        circleStrokeWidth,
        circleStrokeColor,
        circleBlur);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)?
        circle,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)?
        symbol,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)?
        heatmap,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)?
        line,
  }) {
    return circle?.call(
        id,
        sourceId,
        circles,
        visible,
        minZoom,
        maxZoom,
        circleRadius,
        circleColor,
        circleOpacity,
        circleStrokeWidth,
        circleStrokeColor,
        circleBlur);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)?
        circle,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)?
        symbol,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)?
        heatmap,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)?
        line,
    required TResult orElse(),
  }) {
    if (circle != null) {
      return circle(
          id,
          sourceId,
          circles,
          visible,
          minZoom,
          maxZoom,
          circleRadius,
          circleColor,
          circleOpacity,
          circleStrokeWidth,
          circleStrokeColor,
          circleBlur);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CircleMapLayer value) circle,
    required TResult Function(SymbolMapLayer value) symbol,
    required TResult Function(HeatmapMapLayer value) heatmap,
    required TResult Function(LineMapLayer value) line,
  }) {
    return circle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CircleMapLayer value)? circle,
    TResult? Function(SymbolMapLayer value)? symbol,
    TResult? Function(HeatmapMapLayer value)? heatmap,
    TResult? Function(LineMapLayer value)? line,
  }) {
    return circle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CircleMapLayer value)? circle,
    TResult Function(SymbolMapLayer value)? symbol,
    TResult Function(HeatmapMapLayer value)? heatmap,
    TResult Function(LineMapLayer value)? line,
    required TResult orElse(),
  }) {
    if (circle != null) {
      return circle(this);
    }
    return orElse();
  }
}

abstract class CircleMapLayer extends MapLayer {
  const factory CircleMapLayer(
      {required final String id,
      required final String sourceId,
      required final List<Map<String, dynamic>> circles,
      final bool visible,
      final double? minZoom,
      final double? maxZoom,
      final double circleRadius,
      final Color circleColor,
      final double circleOpacity,
      final double circleStrokeWidth,
      final Color circleStrokeColor,
      final double circleBlur}) = _$CircleMapLayerImpl;
  const CircleMapLayer._() : super._();

  @override
  String get id;
  @override
  String get sourceId;
  List<Map<String, dynamic>> get circles;
  @override
  bool get visible;
  @override
  double? get minZoom;
  @override
  double? get maxZoom;
  double get circleRadius;
  Color get circleColor;
  double get circleOpacity;
  double get circleStrokeWidth;
  Color get circleStrokeColor;
  double get circleBlur;

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CircleMapLayerImplCopyWith<_$CircleMapLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SymbolMapLayerImplCopyWith<$Res>
    implements $MapLayerCopyWith<$Res> {
  factory _$$SymbolMapLayerImplCopyWith(_$SymbolMapLayerImpl value,
          $Res Function(_$SymbolMapLayerImpl) then) =
      __$$SymbolMapLayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sourceId,
      List<Map<String, dynamic>> symbols,
      bool visible,
      double? minZoom,
      double? maxZoom,
      String? iconImage,
      double iconSize,
      bool iconAllowOverlap,
      String? textField,
      double textSize,
      Color textColor,
      Offset? textOffset});
}

/// @nodoc
class __$$SymbolMapLayerImplCopyWithImpl<$Res>
    extends _$MapLayerCopyWithImpl<$Res, _$SymbolMapLayerImpl>
    implements _$$SymbolMapLayerImplCopyWith<$Res> {
  __$$SymbolMapLayerImplCopyWithImpl(
      _$SymbolMapLayerImpl _value, $Res Function(_$SymbolMapLayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceId = null,
    Object? symbols = null,
    Object? visible = null,
    Object? minZoom = freezed,
    Object? maxZoom = freezed,
    Object? iconImage = freezed,
    Object? iconSize = null,
    Object? iconAllowOverlap = null,
    Object? textField = freezed,
    Object? textSize = null,
    Object? textColor = null,
    Object? textOffset = freezed,
  }) {
    return _then(_$SymbolMapLayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      symbols: null == symbols
          ? _value._symbols
          : symbols // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      minZoom: freezed == minZoom
          ? _value.minZoom
          : minZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      maxZoom: freezed == maxZoom
          ? _value.maxZoom
          : maxZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      iconImage: freezed == iconImage
          ? _value.iconImage
          : iconImage // ignore: cast_nullable_to_non_nullable
              as String?,
      iconSize: null == iconSize
          ? _value.iconSize
          : iconSize // ignore: cast_nullable_to_non_nullable
              as double,
      iconAllowOverlap: null == iconAllowOverlap
          ? _value.iconAllowOverlap
          : iconAllowOverlap // ignore: cast_nullable_to_non_nullable
              as bool,
      textField: freezed == textField
          ? _value.textField
          : textField // ignore: cast_nullable_to_non_nullable
              as String?,
      textSize: null == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color,
      textOffset: freezed == textOffset
          ? _value.textOffset
          : textOffset // ignore: cast_nullable_to_non_nullable
              as Offset?,
    ));
  }
}

/// @nodoc

class _$SymbolMapLayerImpl extends SymbolMapLayer {
  const _$SymbolMapLayerImpl(
      {required this.id,
      required this.sourceId,
      required final List<Map<String, dynamic>> symbols,
      this.visible = true,
      this.minZoom,
      this.maxZoom,
      this.iconImage,
      this.iconSize = 1.0,
      this.iconAllowOverlap = true,
      this.textField,
      this.textSize = 16.0,
      this.textColor = Colors.black,
      this.textOffset})
      : _symbols = symbols,
        super._();

  @override
  final String id;
  @override
  final String sourceId;
  final List<Map<String, dynamic>> _symbols;
  @override
  List<Map<String, dynamic>> get symbols {
    if (_symbols is EqualUnmodifiableListView) return _symbols;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symbols);
  }

  @override
  @JsonKey()
  final bool visible;
  @override
  final double? minZoom;
  @override
  final double? maxZoom;
  @override
  final String? iconImage;
  @override
  @JsonKey()
  final double iconSize;
  @override
  @JsonKey()
  final bool iconAllowOverlap;
  @override
  final String? textField;
  @override
  @JsonKey()
  final double textSize;
  @override
  @JsonKey()
  final Color textColor;
  @override
  final Offset? textOffset;

  @override
  String toString() {
    return 'MapLayer.symbol(id: $id, sourceId: $sourceId, symbols: $symbols, visible: $visible, minZoom: $minZoom, maxZoom: $maxZoom, iconImage: $iconImage, iconSize: $iconSize, iconAllowOverlap: $iconAllowOverlap, textField: $textField, textSize: $textSize, textColor: $textColor, textOffset: $textOffset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SymbolMapLayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            const DeepCollectionEquality().equals(other._symbols, _symbols) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.minZoom, minZoom) || other.minZoom == minZoom) &&
            (identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom) &&
            (identical(other.iconImage, iconImage) ||
                other.iconImage == iconImage) &&
            (identical(other.iconSize, iconSize) ||
                other.iconSize == iconSize) &&
            (identical(other.iconAllowOverlap, iconAllowOverlap) ||
                other.iconAllowOverlap == iconAllowOverlap) &&
            (identical(other.textField, textField) ||
                other.textField == textField) &&
            (identical(other.textSize, textSize) ||
                other.textSize == textSize) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.textOffset, textOffset) ||
                other.textOffset == textOffset));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sourceId,
      const DeepCollectionEquality().hash(_symbols),
      visible,
      minZoom,
      maxZoom,
      iconImage,
      iconSize,
      iconAllowOverlap,
      textField,
      textSize,
      textColor,
      textOffset);

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SymbolMapLayerImplCopyWith<_$SymbolMapLayerImpl> get copyWith =>
      __$$SymbolMapLayerImplCopyWithImpl<_$SymbolMapLayerImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)
        circle,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)
        symbol,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)
        heatmap,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)
        line,
  }) {
    return symbol(id, sourceId, symbols, visible, minZoom, maxZoom, iconImage,
        iconSize, iconAllowOverlap, textField, textSize, textColor, textOffset);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)?
        circle,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)?
        symbol,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)?
        heatmap,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)?
        line,
  }) {
    return symbol?.call(
        id,
        sourceId,
        symbols,
        visible,
        minZoom,
        maxZoom,
        iconImage,
        iconSize,
        iconAllowOverlap,
        textField,
        textSize,
        textColor,
        textOffset);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)?
        circle,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)?
        symbol,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)?
        heatmap,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)?
        line,
    required TResult orElse(),
  }) {
    if (symbol != null) {
      return symbol(
          id,
          sourceId,
          symbols,
          visible,
          minZoom,
          maxZoom,
          iconImage,
          iconSize,
          iconAllowOverlap,
          textField,
          textSize,
          textColor,
          textOffset);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CircleMapLayer value) circle,
    required TResult Function(SymbolMapLayer value) symbol,
    required TResult Function(HeatmapMapLayer value) heatmap,
    required TResult Function(LineMapLayer value) line,
  }) {
    return symbol(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CircleMapLayer value)? circle,
    TResult? Function(SymbolMapLayer value)? symbol,
    TResult? Function(HeatmapMapLayer value)? heatmap,
    TResult? Function(LineMapLayer value)? line,
  }) {
    return symbol?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CircleMapLayer value)? circle,
    TResult Function(SymbolMapLayer value)? symbol,
    TResult Function(HeatmapMapLayer value)? heatmap,
    TResult Function(LineMapLayer value)? line,
    required TResult orElse(),
  }) {
    if (symbol != null) {
      return symbol(this);
    }
    return orElse();
  }
}

abstract class SymbolMapLayer extends MapLayer {
  const factory SymbolMapLayer(
      {required final String id,
      required final String sourceId,
      required final List<Map<String, dynamic>> symbols,
      final bool visible,
      final double? minZoom,
      final double? maxZoom,
      final String? iconImage,
      final double iconSize,
      final bool iconAllowOverlap,
      final String? textField,
      final double textSize,
      final Color textColor,
      final Offset? textOffset}) = _$SymbolMapLayerImpl;
  const SymbolMapLayer._() : super._();

  @override
  String get id;
  @override
  String get sourceId;
  List<Map<String, dynamic>> get symbols;
  @override
  bool get visible;
  @override
  double? get minZoom;
  @override
  double? get maxZoom;
  String? get iconImage;
  double get iconSize;
  bool get iconAllowOverlap;
  String? get textField;
  double get textSize;
  Color get textColor;
  Offset? get textOffset;

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SymbolMapLayerImplCopyWith<_$SymbolMapLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HeatmapMapLayerImplCopyWith<$Res>
    implements $MapLayerCopyWith<$Res> {
  factory _$$HeatmapMapLayerImplCopyWith(_$HeatmapMapLayerImpl value,
          $Res Function(_$HeatmapMapLayerImpl) then) =
      __$$HeatmapMapLayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sourceId,
      List<Map<String, dynamic>> points,
      List<Map<String, dynamic>> colorStops,
      bool visible,
      double? minZoom,
      double? maxZoom,
      String? weightProperty,
      double intensity,
      double radius});
}

/// @nodoc
class __$$HeatmapMapLayerImplCopyWithImpl<$Res>
    extends _$MapLayerCopyWithImpl<$Res, _$HeatmapMapLayerImpl>
    implements _$$HeatmapMapLayerImplCopyWith<$Res> {
  __$$HeatmapMapLayerImplCopyWithImpl(
      _$HeatmapMapLayerImpl _value, $Res Function(_$HeatmapMapLayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceId = null,
    Object? points = null,
    Object? colorStops = null,
    Object? visible = null,
    Object? minZoom = freezed,
    Object? maxZoom = freezed,
    Object? weightProperty = freezed,
    Object? intensity = null,
    Object? radius = null,
  }) {
    return _then(_$HeatmapMapLayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      colorStops: null == colorStops
          ? _value._colorStops
          : colorStops // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      minZoom: freezed == minZoom
          ? _value.minZoom
          : minZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      maxZoom: freezed == maxZoom
          ? _value.maxZoom
          : maxZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      weightProperty: freezed == weightProperty
          ? _value.weightProperty
          : weightProperty // ignore: cast_nullable_to_non_nullable
              as String?,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as double,
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$HeatmapMapLayerImpl extends HeatmapMapLayer {
  const _$HeatmapMapLayerImpl(
      {required this.id,
      required this.sourceId,
      required final List<Map<String, dynamic>> points,
      required final List<Map<String, dynamic>> colorStops,
      this.visible = true,
      this.minZoom,
      this.maxZoom,
      this.weightProperty,
      this.intensity = 1.0,
      this.radius = 30.0})
      : _points = points,
        _colorStops = colorStops,
        super._();

  @override
  final String id;
  @override
  final String sourceId;
  final List<Map<String, dynamic>> _points;
  @override
  List<Map<String, dynamic>> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  final List<Map<String, dynamic>> _colorStops;
  @override
  List<Map<String, dynamic>> get colorStops {
    if (_colorStops is EqualUnmodifiableListView) return _colorStops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_colorStops);
  }

  @override
  @JsonKey()
  final bool visible;
  @override
  final double? minZoom;
  @override
  final double? maxZoom;
  @override
  final String? weightProperty;
  @override
  @JsonKey()
  final double intensity;
  @override
  @JsonKey()
  final double radius;

  @override
  String toString() {
    return 'MapLayer.heatmap(id: $id, sourceId: $sourceId, points: $points, colorStops: $colorStops, visible: $visible, minZoom: $minZoom, maxZoom: $maxZoom, weightProperty: $weightProperty, intensity: $intensity, radius: $radius)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeatmapMapLayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            const DeepCollectionEquality()
                .equals(other._colorStops, _colorStops) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.minZoom, minZoom) || other.minZoom == minZoom) &&
            (identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom) &&
            (identical(other.weightProperty, weightProperty) ||
                other.weightProperty == weightProperty) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.radius, radius) || other.radius == radius));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sourceId,
      const DeepCollectionEquality().hash(_points),
      const DeepCollectionEquality().hash(_colorStops),
      visible,
      minZoom,
      maxZoom,
      weightProperty,
      intensity,
      radius);

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HeatmapMapLayerImplCopyWith<_$HeatmapMapLayerImpl> get copyWith =>
      __$$HeatmapMapLayerImplCopyWithImpl<_$HeatmapMapLayerImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)
        circle,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)
        symbol,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)
        heatmap,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)
        line,
  }) {
    return heatmap(id, sourceId, points, colorStops, visible, minZoom, maxZoom,
        weightProperty, intensity, radius);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)?
        circle,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)?
        symbol,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)?
        heatmap,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)?
        line,
  }) {
    return heatmap?.call(id, sourceId, points, colorStops, visible, minZoom,
        maxZoom, weightProperty, intensity, radius);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)?
        circle,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)?
        symbol,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)?
        heatmap,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)?
        line,
    required TResult orElse(),
  }) {
    if (heatmap != null) {
      return heatmap(id, sourceId, points, colorStops, visible, minZoom,
          maxZoom, weightProperty, intensity, radius);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CircleMapLayer value) circle,
    required TResult Function(SymbolMapLayer value) symbol,
    required TResult Function(HeatmapMapLayer value) heatmap,
    required TResult Function(LineMapLayer value) line,
  }) {
    return heatmap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CircleMapLayer value)? circle,
    TResult? Function(SymbolMapLayer value)? symbol,
    TResult? Function(HeatmapMapLayer value)? heatmap,
    TResult? Function(LineMapLayer value)? line,
  }) {
    return heatmap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CircleMapLayer value)? circle,
    TResult Function(SymbolMapLayer value)? symbol,
    TResult Function(HeatmapMapLayer value)? heatmap,
    TResult Function(LineMapLayer value)? line,
    required TResult orElse(),
  }) {
    if (heatmap != null) {
      return heatmap(this);
    }
    return orElse();
  }
}

abstract class HeatmapMapLayer extends MapLayer {
  const factory HeatmapMapLayer(
      {required final String id,
      required final String sourceId,
      required final List<Map<String, dynamic>> points,
      required final List<Map<String, dynamic>> colorStops,
      final bool visible,
      final double? minZoom,
      final double? maxZoom,
      final String? weightProperty,
      final double intensity,
      final double radius}) = _$HeatmapMapLayerImpl;
  const HeatmapMapLayer._() : super._();

  @override
  String get id;
  @override
  String get sourceId;
  List<Map<String, dynamic>> get points;
  List<Map<String, dynamic>> get colorStops;
  @override
  bool get visible;
  @override
  double? get minZoom;
  @override
  double? get maxZoom;
  String? get weightProperty;
  double get intensity;
  double get radius;

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HeatmapMapLayerImplCopyWith<_$HeatmapMapLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LineMapLayerImplCopyWith<$Res>
    implements $MapLayerCopyWith<$Res> {
  factory _$$LineMapLayerImplCopyWith(
          _$LineMapLayerImpl value, $Res Function(_$LineMapLayerImpl) then) =
      __$$LineMapLayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sourceId,
      List<Map<String, dynamic>> lines,
      bool visible,
      double? minZoom,
      double? maxZoom,
      Color lineColor,
      double lineWidth,
      double lineOpacity,
      List<double>? lineDasharray});
}

/// @nodoc
class __$$LineMapLayerImplCopyWithImpl<$Res>
    extends _$MapLayerCopyWithImpl<$Res, _$LineMapLayerImpl>
    implements _$$LineMapLayerImplCopyWith<$Res> {
  __$$LineMapLayerImplCopyWithImpl(
      _$LineMapLayerImpl _value, $Res Function(_$LineMapLayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceId = null,
    Object? lines = null,
    Object? visible = null,
    Object? minZoom = freezed,
    Object? maxZoom = freezed,
    Object? lineColor = null,
    Object? lineWidth = null,
    Object? lineOpacity = null,
    Object? lineDasharray = freezed,
  }) {
    return _then(_$LineMapLayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      lines: null == lines
          ? _value._lines
          : lines // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      minZoom: freezed == minZoom
          ? _value.minZoom
          : minZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      maxZoom: freezed == maxZoom
          ? _value.maxZoom
          : maxZoom // ignore: cast_nullable_to_non_nullable
              as double?,
      lineColor: null == lineColor
          ? _value.lineColor
          : lineColor // ignore: cast_nullable_to_non_nullable
              as Color,
      lineWidth: null == lineWidth
          ? _value.lineWidth
          : lineWidth // ignore: cast_nullable_to_non_nullable
              as double,
      lineOpacity: null == lineOpacity
          ? _value.lineOpacity
          : lineOpacity // ignore: cast_nullable_to_non_nullable
              as double,
      lineDasharray: freezed == lineDasharray
          ? _value._lineDasharray
          : lineDasharray // ignore: cast_nullable_to_non_nullable
              as List<double>?,
    ));
  }
}

/// @nodoc

class _$LineMapLayerImpl extends LineMapLayer {
  const _$LineMapLayerImpl(
      {required this.id,
      required this.sourceId,
      required final List<Map<String, dynamic>> lines,
      this.visible = true,
      this.minZoom,
      this.maxZoom,
      this.lineColor = Colors.blue,
      this.lineWidth = 1.0,
      this.lineOpacity = 1.0,
      final List<double>? lineDasharray})
      : _lines = lines,
        _lineDasharray = lineDasharray,
        super._();

  @override
  final String id;
  @override
  final String sourceId;
  final List<Map<String, dynamic>> _lines;
  @override
  List<Map<String, dynamic>> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  @JsonKey()
  final bool visible;
  @override
  final double? minZoom;
  @override
  final double? maxZoom;
  @override
  @JsonKey()
  final Color lineColor;
  @override
  @JsonKey()
  final double lineWidth;
  @override
  @JsonKey()
  final double lineOpacity;
  final List<double>? _lineDasharray;
  @override
  List<double>? get lineDasharray {
    final value = _lineDasharray;
    if (value == null) return null;
    if (_lineDasharray is EqualUnmodifiableListView) return _lineDasharray;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MapLayer.line(id: $id, sourceId: $sourceId, lines: $lines, visible: $visible, minZoom: $minZoom, maxZoom: $maxZoom, lineColor: $lineColor, lineWidth: $lineWidth, lineOpacity: $lineOpacity, lineDasharray: $lineDasharray)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LineMapLayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.minZoom, minZoom) || other.minZoom == minZoom) &&
            (identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom) &&
            (identical(other.lineColor, lineColor) ||
                other.lineColor == lineColor) &&
            (identical(other.lineWidth, lineWidth) ||
                other.lineWidth == lineWidth) &&
            (identical(other.lineOpacity, lineOpacity) ||
                other.lineOpacity == lineOpacity) &&
            const DeepCollectionEquality()
                .equals(other._lineDasharray, _lineDasharray));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sourceId,
      const DeepCollectionEquality().hash(_lines),
      visible,
      minZoom,
      maxZoom,
      lineColor,
      lineWidth,
      lineOpacity,
      const DeepCollectionEquality().hash(_lineDasharray));

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LineMapLayerImplCopyWith<_$LineMapLayerImpl> get copyWith =>
      __$$LineMapLayerImplCopyWithImpl<_$LineMapLayerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)
        circle,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)
        symbol,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)
        heatmap,
    required TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)
        line,
  }) {
    return line(id, sourceId, lines, visible, minZoom, maxZoom, lineColor,
        lineWidth, lineOpacity, lineDasharray);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)?
        circle,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)?
        symbol,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)?
        heatmap,
    TResult? Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)?
        line,
  }) {
    return line?.call(id, sourceId, lines, visible, minZoom, maxZoom, lineColor,
        lineWidth, lineOpacity, lineDasharray);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> circles,
            bool visible,
            double? minZoom,
            double? maxZoom,
            double circleRadius,
            Color circleColor,
            double circleOpacity,
            double circleStrokeWidth,
            Color circleStrokeColor,
            double circleBlur)?
        circle,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> symbols,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? iconImage,
            double iconSize,
            bool iconAllowOverlap,
            String? textField,
            double textSize,
            Color textColor,
            Offset? textOffset)?
        symbol,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> points,
            List<Map<String, dynamic>> colorStops,
            bool visible,
            double? minZoom,
            double? maxZoom,
            String? weightProperty,
            double intensity,
            double radius)?
        heatmap,
    TResult Function(
            String id,
            String sourceId,
            List<Map<String, dynamic>> lines,
            bool visible,
            double? minZoom,
            double? maxZoom,
            Color lineColor,
            double lineWidth,
            double lineOpacity,
            List<double>? lineDasharray)?
        line,
    required TResult orElse(),
  }) {
    if (line != null) {
      return line(id, sourceId, lines, visible, minZoom, maxZoom, lineColor,
          lineWidth, lineOpacity, lineDasharray);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CircleMapLayer value) circle,
    required TResult Function(SymbolMapLayer value) symbol,
    required TResult Function(HeatmapMapLayer value) heatmap,
    required TResult Function(LineMapLayer value) line,
  }) {
    return line(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CircleMapLayer value)? circle,
    TResult? Function(SymbolMapLayer value)? symbol,
    TResult? Function(HeatmapMapLayer value)? heatmap,
    TResult? Function(LineMapLayer value)? line,
  }) {
    return line?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CircleMapLayer value)? circle,
    TResult Function(SymbolMapLayer value)? symbol,
    TResult Function(HeatmapMapLayer value)? heatmap,
    TResult Function(LineMapLayer value)? line,
    required TResult orElse(),
  }) {
    if (line != null) {
      return line(this);
    }
    return orElse();
  }
}

abstract class LineMapLayer extends MapLayer {
  const factory LineMapLayer(
      {required final String id,
      required final String sourceId,
      required final List<Map<String, dynamic>> lines,
      final bool visible,
      final double? minZoom,
      final double? maxZoom,
      final Color lineColor,
      final double lineWidth,
      final double lineOpacity,
      final List<double>? lineDasharray}) = _$LineMapLayerImpl;
  const LineMapLayer._() : super._();

  @override
  String get id;
  @override
  String get sourceId;
  List<Map<String, dynamic>> get lines;
  @override
  bool get visible;
  @override
  double? get minZoom;
  @override
  double? get maxZoom;
  Color get lineColor;
  double get lineWidth;
  double get lineOpacity;
  List<double>? get lineDasharray;

  /// Create a copy of MapLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LineMapLayerImplCopyWith<_$LineMapLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
