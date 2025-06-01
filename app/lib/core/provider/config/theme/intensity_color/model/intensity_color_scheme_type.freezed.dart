// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_color_scheme_type.dart';

import 'package:json_annotation/json_annotation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IntensityColorSchemeType _$IntensityColorSchemeTypeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'predefined':
      return _Predefined.fromJson(json);
    case 'custom':
      return _Custom.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'IntensityColorSchemeType', 'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$IntensityColorSchemeType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PredefinedScheme scheme) predefined,
    required TResult Function() custom,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PredefinedScheme scheme)? predefined,
    TResult? Function()? custom,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PredefinedScheme scheme)? predefined,
    TResult Function()? custom,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Predefined value) predefined,
    required TResult Function(_Custom value) custom,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Predefined value)? predefined,
    TResult? Function(_Custom value)? custom,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Predefined value)? predefined,
    TResult Function(_Custom value)? custom,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this IntensityColorSchemeType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntensityColorSchemeTypeCopyWith<$Res> {
  factory $IntensityColorSchemeTypeCopyWith(IntensityColorSchemeType value, $Res Function(IntensityColorSchemeType) then) =
      _$IntensityColorSchemeTypeCopyWithImpl<$Res, IntensityColorSchemeType>;
}

/// @nodoc
class _$IntensityColorSchemeTypeCopyWithImpl<$Res, $Val extends IntensityColorSchemeType>
    implements $IntensityColorSchemeTypeCopyWith<$Res> {
  _$IntensityColorSchemeTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntensityColorSchemeType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PredefinedImplCopyWith<$Res> {
  factory _$$PredefinedImplCopyWith(_$PredefinedImpl value, $Res Function(_$PredefinedImpl) then) =
      __$$PredefinedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PredefinedScheme scheme});
}

/// @nodoc
class __$$PredefinedImplCopyWithImpl<$Res> extends _$IntensityColorSchemeTypeCopyWithImpl<$Res, _$PredefinedImpl>
    implements _$$PredefinedImplCopyWith<$Res> {
  __$$PredefinedImplCopyWithImpl(_$PredefinedImpl _value, $Res Function(_$PredefinedImpl) _then) : super(_value, _then);

  /// Create a copy of IntensityColorSchemeType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheme = null,
  }) {
    return _then(_$PredefinedImpl(
      scheme: null == scheme
          ? _value.scheme
          : scheme // ignore: cast_nullable_to_non_nullable
              as PredefinedScheme,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PredefinedImpl implements _Predefined {
  const _$PredefinedImpl({required this.scheme, final String? $type}) : $type = $type ?? 'predefined';

  factory _$PredefinedImpl.fromJson(Map<String, dynamic> json) => _$$PredefinedImplFromJson(json);

  @override
  final PredefinedScheme scheme;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'IntensityColorSchemeType.predefined(scheme: $scheme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredefinedImpl &&
            (identical(other.scheme, scheme) || other.scheme == scheme));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, scheme);

  /// Create a copy of IntensityColorSchemeType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PredefinedImplCopyWith<_$PredefinedImpl> get copyWith => __$$PredefinedImplCopyWithImpl<_$PredefinedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PredefinedScheme scheme) predefined,
    required TResult Function() custom,
  }) {
    return predefined(scheme);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PredefinedScheme scheme)? predefined,
    TResult? Function()? custom,
  }) {
    return predefined?.call(scheme);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PredefinedScheme scheme)? predefined,
    TResult Function()? custom,
    required TResult orElse(),
  }) {
    if (predefined != null) {
      return predefined(scheme);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Predefined value) predefined,
    required TResult Function(_Custom value) custom,
  }) {
    return predefined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Predefined value)? predefined,
    TResult? Function(_Custom value)? custom,
  }) {
    return predefined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Predefined value)? predefined,
    TResult Function(_Custom value)? custom,
    required TResult orElse(),
  }) {
    if (predefined != null) {
      return predefined(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PredefinedImplToJson(
      this,
    );
  }
}

abstract class _Predefined implements IntensityColorSchemeType {
  const factory _Predefined({required final PredefinedScheme scheme}) = _$PredefinedImpl;

  factory _Predefined.fromJson(Map<String, dynamic> json) = _$PredefinedImpl.fromJson;

  PredefinedScheme get scheme;

  /// Create a copy of IntensityColorSchemeType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredefinedImplCopyWith<_$PredefinedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomImplCopyWith<$Res> {
  factory _$$CustomImplCopyWith(_$CustomImpl value, $Res Function(_$CustomImpl) then) = __$$CustomImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CustomImplCopyWithImpl<$Res> extends _$IntensityColorSchemeTypeCopyWithImpl<$Res, _$CustomImpl>
    implements _$$CustomImplCopyWith<$Res> {
  __$$CustomImplCopyWithImpl(_$CustomImpl _value, $Res Function(_$CustomImpl) _then) : super(_value, _then);

  /// Create a copy of IntensityColorSchemeType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$CustomImpl implements _Custom {
  const _$CustomImpl({final String? $type}) : $type = $type ?? 'custom';

  factory _$CustomImpl.fromJson(Map<String, dynamic> json) => _$$CustomImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'IntensityColorSchemeType.custom()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$CustomImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  /// Create a copy of IntensityColorSchemeType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomImplCopyWith<_$CustomImpl> get copyWith => __$$CustomImplCopyWithImpl<_$CustomImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PredefinedScheme scheme) predefined,
    required TResult Function() custom,
  }) {
    return custom();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PredefinedScheme scheme)? predefined,
    TResult? Function()? custom,
  }) {
    return custom?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PredefinedScheme scheme)? predefined,
    TResult Function()? custom,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Predefined value) predefined,
    required TResult Function(_Custom value) custom,
  }) {
    return custom(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Predefined value)? predefined,
    TResult? Function(_Custom value)? custom,
  }) {
    return custom?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Predefined value)? predefined,
    TResult Function(_Custom value)? custom,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomImplToJson(
      this,
    );
  }
}

abstract class _Custom implements IntensityColorSchemeType {
  const factory _Custom() = _$CustomImpl;

  factory _Custom.fromJson(Map<String, dynamic> json) = _$CustomImpl.fromJson;

  /// Create a copy of IntensityColorSchemeType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomImplCopyWith<_$CustomImpl> get copyWith => throw _privateConstructorUsedError;
}