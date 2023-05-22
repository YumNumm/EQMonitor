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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_EarthquakeNankaiInfoCopyWith<$Res>
    implements $EarthquakeNankaiInfoCopyWith<$Res> {
  factory _$$_EarthquakeNankaiInfoCopyWith(_$_EarthquakeNankaiInfo value,
          $Res Function(_$_EarthquakeNankaiInfo) then) =
      __$$_EarthquakeNankaiInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? appendix, EarthquakeNankaiKind? kind});

  @override
  $EarthquakeNankaiKindCopyWith<$Res>? get kind;
}

/// @nodoc
class __$$_EarthquakeNankaiInfoCopyWithImpl<$Res>
    extends _$EarthquakeNankaiInfoCopyWithImpl<$Res, _$_EarthquakeNankaiInfo>
    implements _$$_EarthquakeNankaiInfoCopyWith<$Res> {
  __$$_EarthquakeNankaiInfoCopyWithImpl(_$_EarthquakeNankaiInfo _value,
      $Res Function(_$_EarthquakeNankaiInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? appendix = freezed,
    Object? kind = freezed,
  }) {
    return _then(_$_EarthquakeNankaiInfo(
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
class _$_EarthquakeNankaiInfo implements _EarthquakeNankaiInfo {
  const _$_EarthquakeNankaiInfo(
      {required this.text, required this.appendix, required this.kind});

  factory _$_EarthquakeNankaiInfo.fromJson(Map<String, dynamic> json) =>
      _$$_EarthquakeNankaiInfoFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EarthquakeNankaiInfo &&
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
  _$$_EarthquakeNankaiInfoCopyWith<_$_EarthquakeNankaiInfo> get copyWith =>
      __$$_EarthquakeNankaiInfoCopyWithImpl<_$_EarthquakeNankaiInfo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EarthquakeNankaiInfoToJson(
      this,
    );
  }
}

abstract class _EarthquakeNankaiInfo implements EarthquakeNankaiInfo {
  const factory _EarthquakeNankaiInfo(
      {required final String text,
      required final String? appendix,
      required final EarthquakeNankaiKind? kind}) = _$_EarthquakeNankaiInfo;

  factory _EarthquakeNankaiInfo.fromJson(Map<String, dynamic> json) =
      _$_EarthquakeNankaiInfo.fromJson;

  @override
  String get text;
  @override
  String? get appendix;
  @override
  EarthquakeNankaiKind? get kind;
  @override
  @JsonKey(ignore: true)
  _$$_EarthquakeNankaiInfoCopyWith<_$_EarthquakeNankaiInfo> get copyWith =>
      throw _privateConstructorUsedError;
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
abstract class _$$_EarthquakeNankaiKindCopyWith<$Res>
    implements $EarthquakeNankaiKindCopyWith<$Res> {
  factory _$$_EarthquakeNankaiKindCopyWith(_$_EarthquakeNankaiKind value,
          $Res Function(_$_EarthquakeNankaiKind) then) =
      __$$_EarthquakeNankaiKindCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class __$$_EarthquakeNankaiKindCopyWithImpl<$Res>
    extends _$EarthquakeNankaiKindCopyWithImpl<$Res, _$_EarthquakeNankaiKind>
    implements _$$_EarthquakeNankaiKindCopyWith<$Res> {
  __$$_EarthquakeNankaiKindCopyWithImpl(_$_EarthquakeNankaiKind _value,
      $Res Function(_$_EarthquakeNankaiKind) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_$_EarthquakeNankaiKind(
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
class _$_EarthquakeNankaiKind implements _EarthquakeNankaiKind {
  const _$_EarthquakeNankaiKind({required this.code, required this.name});

  factory _$_EarthquakeNankaiKind.fromJson(Map<String, dynamic> json) =>
      _$$_EarthquakeNankaiKindFromJson(json);

  @override
  final String code;
  @override
  final String name;

  @override
  String toString() {
    return 'EarthquakeNankaiKind(code: $code, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EarthquakeNankaiKind &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EarthquakeNankaiKindCopyWith<_$_EarthquakeNankaiKind> get copyWith =>
      __$$_EarthquakeNankaiKindCopyWithImpl<_$_EarthquakeNankaiKind>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EarthquakeNankaiKindToJson(
      this,
    );
  }
}

abstract class _EarthquakeNankaiKind implements EarthquakeNankaiKind {
  const factory _EarthquakeNankaiKind(
      {required final String code,
      required final String name}) = _$_EarthquakeNankaiKind;

  factory _EarthquakeNankaiKind.fromJson(Map<String, dynamic> json) =
      _$_EarthquakeNankaiKind.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_EarthquakeNankaiKindCopyWith<_$_EarthquakeNankaiKind> get copyWith =>
      throw _privateConstructorUsedError;
}
