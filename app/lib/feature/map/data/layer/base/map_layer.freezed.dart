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
mixin _$CachedMapLayer {
  MapLayer get layer => throw _privateConstructorUsedError;
  String get geoJsonSourceHash => throw _privateConstructorUsedError;
  String get layerPropertiesHash => throw _privateConstructorUsedError;
  String? get belowLayerId => throw _privateConstructorUsedError;

  /// Create a copy of CachedMapLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CachedMapLayerCopyWith<CachedMapLayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CachedMapLayerCopyWith<$Res> {
  factory $CachedMapLayerCopyWith(
          CachedMapLayer value, $Res Function(CachedMapLayer) then) =
      _$CachedMapLayerCopyWithImpl<$Res, CachedMapLayer>;
  @useResult
  $Res call(
      {MapLayer layer,
      String geoJsonSourceHash,
      String layerPropertiesHash,
      String? belowLayerId});
}

/// @nodoc
class _$CachedMapLayerCopyWithImpl<$Res, $Val extends CachedMapLayer>
    implements $CachedMapLayerCopyWith<$Res> {
  _$CachedMapLayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CachedMapLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer = null,
    Object? geoJsonSourceHash = null,
    Object? layerPropertiesHash = null,
    Object? belowLayerId = freezed,
  }) {
    return _then(_value.copyWith(
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as MapLayer,
      geoJsonSourceHash: null == geoJsonSourceHash
          ? _value.geoJsonSourceHash
          : geoJsonSourceHash // ignore: cast_nullable_to_non_nullable
              as String,
      layerPropertiesHash: null == layerPropertiesHash
          ? _value.layerPropertiesHash
          : layerPropertiesHash // ignore: cast_nullable_to_non_nullable
              as String,
      belowLayerId: freezed == belowLayerId
          ? _value.belowLayerId
          : belowLayerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CachedMapLayerImplCopyWith<$Res>
    implements $CachedMapLayerCopyWith<$Res> {
  factory _$$CachedMapLayerImplCopyWith(_$CachedMapLayerImpl value,
          $Res Function(_$CachedMapLayerImpl) then) =
      __$$CachedMapLayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MapLayer layer,
      String geoJsonSourceHash,
      String layerPropertiesHash,
      String? belowLayerId});
}

/// @nodoc
class __$$CachedMapLayerImplCopyWithImpl<$Res>
    extends _$CachedMapLayerCopyWithImpl<$Res, _$CachedMapLayerImpl>
    implements _$$CachedMapLayerImplCopyWith<$Res> {
  __$$CachedMapLayerImplCopyWithImpl(
      _$CachedMapLayerImpl _value, $Res Function(_$CachedMapLayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of CachedMapLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer = null,
    Object? geoJsonSourceHash = null,
    Object? layerPropertiesHash = null,
    Object? belowLayerId = freezed,
  }) {
    return _then(_$CachedMapLayerImpl(
      layer: null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as MapLayer,
      geoJsonSourceHash: null == geoJsonSourceHash
          ? _value.geoJsonSourceHash
          : geoJsonSourceHash // ignore: cast_nullable_to_non_nullable
              as String,
      layerPropertiesHash: null == layerPropertiesHash
          ? _value.layerPropertiesHash
          : layerPropertiesHash // ignore: cast_nullable_to_non_nullable
              as String,
      belowLayerId: freezed == belowLayerId
          ? _value.belowLayerId
          : belowLayerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CachedMapLayerImpl extends _CachedMapLayer {
  const _$CachedMapLayerImpl(
      {required this.layer,
      required this.geoJsonSourceHash,
      required this.layerPropertiesHash,
      required this.belowLayerId})
      : super._();

  @override
  final MapLayer layer;
  @override
  final String geoJsonSourceHash;
  @override
  final String layerPropertiesHash;
  @override
  final String? belowLayerId;

  @override
  String toString() {
    return 'CachedMapLayer(layer: $layer, geoJsonSourceHash: $geoJsonSourceHash, layerPropertiesHash: $layerPropertiesHash, belowLayerId: $belowLayerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CachedMapLayerImpl &&
            (identical(other.layer, layer) || other.layer == layer) &&
            (identical(other.geoJsonSourceHash, geoJsonSourceHash) ||
                other.geoJsonSourceHash == geoJsonSourceHash) &&
            (identical(other.layerPropertiesHash, layerPropertiesHash) ||
                other.layerPropertiesHash == layerPropertiesHash) &&
            (identical(other.belowLayerId, belowLayerId) ||
                other.belowLayerId == belowLayerId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, layer, geoJsonSourceHash, layerPropertiesHash, belowLayerId);

  /// Create a copy of CachedMapLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CachedMapLayerImplCopyWith<_$CachedMapLayerImpl> get copyWith =>
      __$$CachedMapLayerImplCopyWithImpl<_$CachedMapLayerImpl>(
          this, _$identity);
}

abstract class _CachedMapLayer extends CachedMapLayer {
  const factory _CachedMapLayer(
      {required final MapLayer layer,
      required final String geoJsonSourceHash,
      required final String layerPropertiesHash,
      required final String? belowLayerId}) = _$CachedMapLayerImpl;
  const _CachedMapLayer._() : super._();

  @override
  MapLayer get layer;
  @override
  String get geoJsonSourceHash;
  @override
  String get layerPropertiesHash;
  @override
  String? get belowLayerId;

  /// Create a copy of CachedMapLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CachedMapLayerImplCopyWith<_$CachedMapLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
