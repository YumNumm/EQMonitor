// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EarthquakeNankaiInfo _$EarthquakeNankaiInfoFromJson(Map<String, dynamic> json) {
  return _EarthquakeNankaiInfo.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeNankaiInfo {
  String get text => throw _privateConstructorUsedError;
  String? get appendix => throw _privateConstructorUsedError;
  EarthquakeNankaiKind? get kind => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeNankaiInfoCopyWith<EarthquakeNankaiInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeNankaiInfoCopyWith<$Res> {
  factory $EarthquakeNankaiInfoCopyWith(EarthquakeNankaiInfo value,
          $Res Function(EarthquakeNankaiInfo) then) =
      _$EarthquakeNankaiInfoCopyWithImpl<$Res, EarthquakeNankaiInfo>;
  @useResult
  $Res call({String text, String? appendix, EarthquakeNankaiKind? kind});

  $EarthquakeNankaiKindCopyWith<$Res>? get kind;
}

/// @nodoc
class _$EarthquakeNankaiInfoCopyWithImpl<$Res,
        $Val extends EarthquakeNankaiInfo>
    implements $EarthquakeNankaiInfoCopyWith<$Res> {
  _$EarthquakeNankaiInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? appendix = freezed,
    Object? kind = freezed,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      appendix: freezed == appendix
          ? _value.appendix
          : appendix // ignore: cast_nullable_to_non_nullable
              as String?,
      kind: freezed == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as EarthquakeNankaiKind?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeNankaiKindCopyWith<$Res>? get kind {
    if (_value.kind == null) {
      return null;
    }

    return $EarthquakeNankaiKindCopyWith<$Res>(_value.kind!, (value) {
      return _then(_value.copyWith(kind: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EarthquakeNankaiInfoImplCopyWith<$Res>
    implements $EarthquakeNankaiInfoCopyWith<$Res> {
  factory _$$EarthquakeNankaiInfoImplCopyWith(_$EarthquakeNankaiInfoImpl value,
          $Res Function(_$EarthquakeNankaiInfoImpl) then) =
      __$$EarthquakeNankaiInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? appendix, EarthquakeNankaiKind? kind});

  @override
  $EarthquakeNankaiKindCopyWith<$Res>? get kind;
}

/// @nodoc
class __$$EarthquakeNankaiInfoImplCopyWithImpl<$Res>
    extends _$EarthquakeNankaiInfoCopyWithImpl<$Res, _$EarthquakeNankaiInfoImpl>
    implements _$$EarthquakeNankaiInfoImplCopyWith<$Res> {
  __$$EarthquakeNankaiInfoImplCopyWithImpl(_$EarthquakeNankaiInfoImpl _value,
      $Res Function(_$EarthquakeNankaiInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? appendix = freezed,
    Object? kind = freezed,
  }) {
    return _then(_$EarthquakeNankaiInfoImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      appendix: freezed == appendix
          ? _value.appendix
          : appendix // ignore: cast_nullable_to_non_nullable
              as String?,
      kind: freezed == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as EarthquakeNankaiKind?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeNankaiInfoImpl implements _EarthquakeNankaiInfo {
  const _$EarthquakeNankaiInfoImpl(
      {required this.text, required this.appendix, required this.kind});

  factory _$EarthquakeNankaiInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeNankaiInfoImplFromJson(json);

  @override
  final String text;
  @override
  final String? appendix;
  @override
  final EarthquakeNankaiKind? kind;

  @override
  String toString() {
    return 'EarthquakeNankaiInfo(text: $text, appendix: $appendix, kind: $kind)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeNankaiInfoImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.appendix, appendix) ||
                other.appendix == appendix) &&
            (identical(other.kind, kind) || other.kind == kind));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, appendix, kind);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeNankaiInfoImplCopyWith<_$EarthquakeNankaiInfoImpl>
      get copyWith =>
          __$$EarthquakeNankaiInfoImplCopyWithImpl<_$EarthquakeNankaiInfoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeNankaiInfoImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeNankaiInfo implements EarthquakeNankaiInfo {
  const factory _EarthquakeNankaiInfo(
      {required final String text,
      required final String? appendix,
      required final EarthquakeNankaiKind? kind}) = _$EarthquakeNankaiInfoImpl;

  factory _EarthquakeNankaiInfo.fromJson(Map<String, dynamic> json) =
      _$EarthquakeNankaiInfoImpl.fromJson;

  @override
  String get text;
  @override
  String? get appendix;
  @override
  EarthquakeNankaiKind? get kind;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeNankaiInfoImplCopyWith<_$EarthquakeNankaiInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EarthquakeNankaiKind _$EarthquakeNankaiKindFromJson(Map<String, dynamic> json) {
  return _EarthquakeNankaiKind.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeNankaiKind {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeNankaiKindCopyWith<EarthquakeNankaiKind> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeNankaiKindCopyWith<$Res> {
  factory $EarthquakeNankaiKindCopyWith(EarthquakeNankaiKind value,
          $Res Function(EarthquakeNankaiKind) then) =
      _$EarthquakeNankaiKindCopyWithImpl<$Res, EarthquakeNankaiKind>;
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class _$EarthquakeNankaiKindCopyWithImpl<$Res,
        $Val extends EarthquakeNankaiKind>
    implements $EarthquakeNankaiKindCopyWith<$Res> {
  _$EarthquakeNankaiKindCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeNankaiKindImplCopyWith<$Res>
    implements $EarthquakeNankaiKindCopyWith<$Res> {
  factory _$$EarthquakeNankaiKindImplCopyWith(_$EarthquakeNankaiKindImpl value,
          $Res Function(_$EarthquakeNankaiKindImpl) then) =
      __$$EarthquakeNankaiKindImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class __$$EarthquakeNankaiKindImplCopyWithImpl<$Res>
    extends _$EarthquakeNankaiKindCopyWithImpl<$Res, _$EarthquakeNankaiKindImpl>
    implements _$$EarthquakeNankaiKindImplCopyWith<$Res> {
  __$$EarthquakeNankaiKindImplCopyWithImpl(_$EarthquakeNankaiKindImpl _value,
      $Res Function(_$EarthquakeNankaiKindImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_$EarthquakeNankaiKindImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeNankaiKindImpl implements _EarthquakeNankaiKind {
  const _$EarthquakeNankaiKindImpl({required this.code, required this.name});

  factory _$EarthquakeNankaiKindImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeNankaiKindImplFromJson(json);

  @override
  final String code;
  @override
  final String name;

  @override
  String toString() {
    return 'EarthquakeNankaiKind(code: $code, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeNankaiKindImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeNankaiKindImplCopyWith<_$EarthquakeNankaiKindImpl>
      get copyWith =>
          __$$EarthquakeNankaiKindImplCopyWithImpl<_$EarthquakeNankaiKindImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeNankaiKindImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeNankaiKind implements EarthquakeNankaiKind {
  const factory _EarthquakeNankaiKind(
      {required final String code,
      required final String name}) = _$EarthquakeNankaiKindImpl;

  factory _EarthquakeNankaiKind.fromJson(Map<String, dynamic> json) =
      _$EarthquakeNankaiKindImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeNankaiKindImplCopyWith<_$EarthquakeNankaiKindImpl>
      get copyWith => throw _privateConstructorUsedError;
}
