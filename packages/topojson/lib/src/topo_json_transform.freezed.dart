// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topo_json_transform.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TopoJsonTransform _$TopoJsonTransformFromJson(Map<String, dynamic> json) {
  return _TopoJsonTransform.fromJson(json);
}

/// @nodoc
mixin _$TopoJsonTransform {
  List<double> get scale => throw _privateConstructorUsedError;
  List<double> get translate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopoJsonTransformCopyWith<TopoJsonTransform> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopoJsonTransformCopyWith<$Res> {
  factory $TopoJsonTransformCopyWith(
          TopoJsonTransform value, $Res Function(TopoJsonTransform) then) =
      _$TopoJsonTransformCopyWithImpl<$Res, TopoJsonTransform>;
  @useResult
  $Res call({List<double> scale, List<double> translate});
}

/// @nodoc
class _$TopoJsonTransformCopyWithImpl<$Res, $Val extends TopoJsonTransform>
    implements $TopoJsonTransformCopyWith<$Res> {
  _$TopoJsonTransformCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scale = null,
    Object? translate = null,
  }) {
    return _then(_value.copyWith(
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as List<double>,
      translate: null == translate
          ? _value.translate
          : translate // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TopoJsonTransformCopyWith<$Res>
    implements $TopoJsonTransformCopyWith<$Res> {
  factory _$$_TopoJsonTransformCopyWith(_$_TopoJsonTransform value,
          $Res Function(_$_TopoJsonTransform) then) =
      __$$_TopoJsonTransformCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<double> scale, List<double> translate});
}

/// @nodoc
class __$$_TopoJsonTransformCopyWithImpl<$Res>
    extends _$TopoJsonTransformCopyWithImpl<$Res, _$_TopoJsonTransform>
    implements _$$_TopoJsonTransformCopyWith<$Res> {
  __$$_TopoJsonTransformCopyWithImpl(
      _$_TopoJsonTransform _value, $Res Function(_$_TopoJsonTransform) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scale = null,
    Object? translate = null,
  }) {
    return _then(_$_TopoJsonTransform(
      scale: null == scale
          ? _value._scale
          : scale // ignore: cast_nullable_to_non_nullable
              as List<double>,
      translate: null == translate
          ? _value._translate
          : translate // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TopoJsonTransform implements _TopoJsonTransform {
  const _$_TopoJsonTransform(
      {required final List<double> scale,
      required final List<double> translate})
      : _scale = scale,
        _translate = translate;

  factory _$_TopoJsonTransform.fromJson(Map<String, dynamic> json) =>
      _$$_TopoJsonTransformFromJson(json);

  final List<double> _scale;
  @override
  List<double> get scale {
    if (_scale is EqualUnmodifiableListView) return _scale;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scale);
  }

  final List<double> _translate;
  @override
  List<double> get translate {
    if (_translate is EqualUnmodifiableListView) return _translate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_translate);
  }

  @override
  String toString() {
    return 'TopoJsonTransform(scale: $scale, translate: $translate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TopoJsonTransform &&
            const DeepCollectionEquality().equals(other._scale, _scale) &&
            const DeepCollectionEquality()
                .equals(other._translate, _translate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_scale),
      const DeepCollectionEquality().hash(_translate));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TopoJsonTransformCopyWith<_$_TopoJsonTransform> get copyWith =>
      __$$_TopoJsonTransformCopyWithImpl<_$_TopoJsonTransform>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TopoJsonTransformToJson(
      this,
    );
  }
}

abstract class _TopoJsonTransform implements TopoJsonTransform {
  const factory _TopoJsonTransform(
      {required final List<double> scale,
      required final List<double> translate}) = _$_TopoJsonTransform;

  factory _TopoJsonTransform.fromJson(Map<String, dynamic> json) =
      _$_TopoJsonTransform.fromJson;

  @override
  List<double> get scale;
  @override
  List<double> get translate;
  @override
  @JsonKey(ignore: true)
  _$$_TopoJsonTransformCopyWith<_$_TopoJsonTransform> get copyWith =>
      throw _privateConstructorUsedError;
}
