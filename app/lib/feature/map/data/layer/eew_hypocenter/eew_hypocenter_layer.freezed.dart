// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_hypocenter_layer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EewHypocenter {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Create a copy of EewHypocenter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EewHypocenterCopyWith<EewHypocenter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewHypocenterCopyWith<$Res> {
  factory $EewHypocenterCopyWith(
    EewHypocenter value,
    $Res Function(EewHypocenter) then,
  ) = _$EewHypocenterCopyWithImpl<$Res, EewHypocenter>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$EewHypocenterCopyWithImpl<$Res, $Val extends EewHypocenter>
    implements $EewHypocenterCopyWith<$Res> {
  _$EewHypocenterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EewHypocenter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latitude = null, Object? longitude = null}) {
    return _then(
      _value.copyWith(
            latitude:
                null == latitude
                    ? _value.latitude
                    : latitude // ignore: cast_nullable_to_non_nullable
                        as double,
            longitude:
                null == longitude
                    ? _value.longitude
                    : longitude // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EewHypocenterImplCopyWith<$Res>
    implements $EewHypocenterCopyWith<$Res> {
  factory _$$EewHypocenterImplCopyWith(
    _$EewHypocenterImpl value,
    $Res Function(_$EewHypocenterImpl) then,
  ) = __$$EewHypocenterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$EewHypocenterImplCopyWithImpl<$Res>
    extends _$EewHypocenterCopyWithImpl<$Res, _$EewHypocenterImpl>
    implements _$$EewHypocenterImplCopyWith<$Res> {
  __$$EewHypocenterImplCopyWithImpl(
    _$EewHypocenterImpl _value,
    $Res Function(_$EewHypocenterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EewHypocenter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latitude = null, Object? longitude = null}) {
    return _then(
      _$EewHypocenterImpl(
        latitude:
            null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                    as double,
        longitude:
            null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc

class _$EewHypocenterImpl implements _EewHypocenter {
  const _$EewHypocenterImpl({required this.latitude, required this.longitude});

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'EewHypocenter(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EewHypocenterImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of EewHypocenter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EewHypocenterImplCopyWith<_$EewHypocenterImpl> get copyWith =>
      __$$EewHypocenterImplCopyWithImpl<_$EewHypocenterImpl>(this, _$identity);
}

abstract class _EewHypocenter implements EewHypocenter {
  const factory _EewHypocenter({
    required final double latitude,
    required final double longitude,
  }) = _$EewHypocenterImpl;

  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of EewHypocenter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EewHypocenterImplCopyWith<_$EewHypocenterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EewHypocenterLayer {
  String get id => throw _privateConstructorUsedError;
  String get sourceId => throw _privateConstructorUsedError;
  bool get visible => throw _privateConstructorUsedError;
  List<EewHypocenter> get hypocenters => throw _privateConstructorUsedError;
  String get iconImage => throw _privateConstructorUsedError;
  double? get minZoom => throw _privateConstructorUsedError;
  double? get maxZoom => throw _privateConstructorUsedError;
  dynamic get filter => throw _privateConstructorUsedError;

  /// Create a copy of EewHypocenterLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EewHypocenterLayerCopyWith<EewHypocenterLayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewHypocenterLayerCopyWith<$Res> {
  factory $EewHypocenterLayerCopyWith(
    EewHypocenterLayer value,
    $Res Function(EewHypocenterLayer) then,
  ) = _$EewHypocenterLayerCopyWithImpl<$Res, EewHypocenterLayer>;
  @useResult
  $Res call({
    String id,
    String sourceId,
    bool visible,
    List<EewHypocenter> hypocenters,
    String iconImage,
    double? minZoom,
    double? maxZoom,
    dynamic filter,
  });
}

/// @nodoc
class _$EewHypocenterLayerCopyWithImpl<$Res, $Val extends EewHypocenterLayer>
    implements $EewHypocenterLayerCopyWith<$Res> {
  _$EewHypocenterLayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EewHypocenterLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceId = null,
    Object? visible = null,
    Object? hypocenters = null,
    Object? iconImage = null,
    Object? minZoom = freezed,
    Object? maxZoom = freezed,
    Object? filter = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            sourceId:
                null == sourceId
                    ? _value.sourceId
                    : sourceId // ignore: cast_nullable_to_non_nullable
                        as String,
            visible:
                null == visible
                    ? _value.visible
                    : visible // ignore: cast_nullable_to_non_nullable
                        as bool,
            hypocenters:
                null == hypocenters
                    ? _value.hypocenters
                    : hypocenters // ignore: cast_nullable_to_non_nullable
                        as List<EewHypocenter>,
            iconImage:
                null == iconImage
                    ? _value.iconImage
                    : iconImage // ignore: cast_nullable_to_non_nullable
                        as String,
            minZoom:
                freezed == minZoom
                    ? _value.minZoom
                    : minZoom // ignore: cast_nullable_to_non_nullable
                        as double?,
            maxZoom:
                freezed == maxZoom
                    ? _value.maxZoom
                    : maxZoom // ignore: cast_nullable_to_non_nullable
                        as double?,
            filter:
                freezed == filter
                    ? _value.filter
                    : filter // ignore: cast_nullable_to_non_nullable
                        as dynamic,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EewHypocenterLayerImplCopyWith<$Res>
    implements $EewHypocenterLayerCopyWith<$Res> {
  factory _$$EewHypocenterLayerImplCopyWith(
    _$EewHypocenterLayerImpl value,
    $Res Function(_$EewHypocenterLayerImpl) then,
  ) = __$$EewHypocenterLayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String sourceId,
    bool visible,
    List<EewHypocenter> hypocenters,
    String iconImage,
    double? minZoom,
    double? maxZoom,
    dynamic filter,
  });
}

/// @nodoc
class __$$EewHypocenterLayerImplCopyWithImpl<$Res>
    extends _$EewHypocenterLayerCopyWithImpl<$Res, _$EewHypocenterLayerImpl>
    implements _$$EewHypocenterLayerImplCopyWith<$Res> {
  __$$EewHypocenterLayerImplCopyWithImpl(
    _$EewHypocenterLayerImpl _value,
    $Res Function(_$EewHypocenterLayerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EewHypocenterLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceId = null,
    Object? visible = null,
    Object? hypocenters = null,
    Object? iconImage = null,
    Object? minZoom = freezed,
    Object? maxZoom = freezed,
    Object? filter = freezed,
  }) {
    return _then(
      _$EewHypocenterLayerImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        sourceId:
            null == sourceId
                ? _value.sourceId
                : sourceId // ignore: cast_nullable_to_non_nullable
                    as String,
        visible:
            null == visible
                ? _value.visible
                : visible // ignore: cast_nullable_to_non_nullable
                    as bool,
        hypocenters:
            null == hypocenters
                ? _value._hypocenters
                : hypocenters // ignore: cast_nullable_to_non_nullable
                    as List<EewHypocenter>,
        iconImage:
            null == iconImage
                ? _value.iconImage
                : iconImage // ignore: cast_nullable_to_non_nullable
                    as String,
        minZoom:
            freezed == minZoom
                ? _value.minZoom
                : minZoom // ignore: cast_nullable_to_non_nullable
                    as double?,
        maxZoom:
            freezed == maxZoom
                ? _value.maxZoom
                : maxZoom // ignore: cast_nullable_to_non_nullable
                    as double?,
        filter:
            freezed == filter
                ? _value.filter
                : filter // ignore: cast_nullable_to_non_nullable
                    as dynamic,
      ),
    );
  }
}

/// @nodoc

class _$EewHypocenterLayerImpl extends _EewHypocenterLayer {
  _$EewHypocenterLayerImpl({
    required this.id,
    required this.sourceId,
    required this.visible,
    required final List<EewHypocenter> hypocenters,
    required this.iconImage,
    this.minZoom = null,
    this.maxZoom = null,
    this.filter,
  }) : _hypocenters = hypocenters,
       super._();

  @override
  final String id;
  @override
  final String sourceId;
  @override
  final bool visible;
  final List<EewHypocenter> _hypocenters;
  @override
  List<EewHypocenter> get hypocenters {
    if (_hypocenters is EqualUnmodifiableListView) return _hypocenters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hypocenters);
  }

  @override
  final String iconImage;
  @override
  @JsonKey()
  final double? minZoom;
  @override
  @JsonKey()
  final double? maxZoom;
  @override
  final dynamic filter;

  @override
  String toString() {
    return 'EewHypocenterLayer(id: $id, sourceId: $sourceId, visible: $visible, hypocenters: $hypocenters, iconImage: $iconImage, minZoom: $minZoom, maxZoom: $maxZoom, filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EewHypocenterLayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            const DeepCollectionEquality().equals(
              other._hypocenters,
              _hypocenters,
            ) &&
            (identical(other.iconImage, iconImage) ||
                other.iconImage == iconImage) &&
            (identical(other.minZoom, minZoom) || other.minZoom == minZoom) &&
            (identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom) &&
            const DeepCollectionEquality().equals(other.filter, filter));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sourceId,
    visible,
    const DeepCollectionEquality().hash(_hypocenters),
    iconImage,
    minZoom,
    maxZoom,
    const DeepCollectionEquality().hash(filter),
  );

  /// Create a copy of EewHypocenterLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EewHypocenterLayerImplCopyWith<_$EewHypocenterLayerImpl> get copyWith =>
      __$$EewHypocenterLayerImplCopyWithImpl<_$EewHypocenterLayerImpl>(
        this,
        _$identity,
      );
}

abstract class _EewHypocenterLayer extends EewHypocenterLayer {
  factory _EewHypocenterLayer({
    required final String id,
    required final String sourceId,
    required final bool visible,
    required final List<EewHypocenter> hypocenters,
    required final String iconImage,
    final double? minZoom,
    final double? maxZoom,
    final dynamic filter,
  }) = _$EewHypocenterLayerImpl;
  _EewHypocenterLayer._() : super._();

  @override
  String get id;
  @override
  String get sourceId;
  @override
  bool get visible;
  @override
  List<EewHypocenter> get hypocenters;
  @override
  String get iconImage;
  @override
  double? get minZoom;
  @override
  double? get maxZoom;
  @override
  dynamic get filter;

  /// Create a copy of EewHypocenterLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EewHypocenterLayerImplCopyWith<_$EewHypocenterLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
