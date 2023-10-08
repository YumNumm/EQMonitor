// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jma_map_property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JmaMapProperty _$JmaMapPropertyFromJson(Map<String, dynamic> json) {
  return _JmaMapProperty.fromJson(json);
}

/// @nodoc
mixin _$JmaMapProperty {
  String? get code => throw _privateConstructorUsedError;
  String? get name =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'namekana')
  String? get nameKana => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JmaMapPropertyCopyWith<JmaMapProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JmaMapPropertyCopyWith<$Res> {
  factory $JmaMapPropertyCopyWith(
          JmaMapProperty value, $Res Function(JmaMapProperty) then) =
      _$JmaMapPropertyCopyWithImpl<$Res, JmaMapProperty>;
  @useResult
  $Res call(
      {String? code,
      String? name,
      @JsonKey(name: 'namekana') String? nameKana});
}

/// @nodoc
class _$JmaMapPropertyCopyWithImpl<$Res, $Val extends JmaMapProperty>
    implements $JmaMapPropertyCopyWith<$Res> {
  _$JmaMapPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? nameKana = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameKana: freezed == nameKana
          ? _value.nameKana
          : nameKana // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JmaMapPropertyCopyWith<$Res>
    implements $JmaMapPropertyCopyWith<$Res> {
  factory _$$_JmaMapPropertyCopyWith(
          _$_JmaMapProperty value, $Res Function(_$_JmaMapProperty) then) =
      __$$_JmaMapPropertyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? name,
      @JsonKey(name: 'namekana') String? nameKana});
}

/// @nodoc
class __$$_JmaMapPropertyCopyWithImpl<$Res>
    extends _$JmaMapPropertyCopyWithImpl<$Res, _$_JmaMapProperty>
    implements _$$_JmaMapPropertyCopyWith<$Res> {
  __$$_JmaMapPropertyCopyWithImpl(
      _$_JmaMapProperty _value, $Res Function(_$_JmaMapProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? nameKana = freezed,
  }) {
    return _then(_$_JmaMapProperty(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameKana: freezed == nameKana
          ? _value.nameKana
          : nameKana // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JmaMapProperty implements _JmaMapProperty {
  const _$_JmaMapProperty(
      {required this.code,
      required this.name,
      @JsonKey(name: 'namekana') required this.nameKana});

  factory _$_JmaMapProperty.fromJson(Map<String, dynamic> json) =>
      _$$_JmaMapPropertyFromJson(json);

  @override
  final String? code;
  @override
  final String? name;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'namekana')
  final String? nameKana;

  @override
  String toString() {
    return 'JmaMapProperty(code: $code, name: $name, nameKana: $nameKana)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JmaMapProperty &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameKana, nameKana) ||
                other.nameKana == nameKana));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, nameKana);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JmaMapPropertyCopyWith<_$_JmaMapProperty> get copyWith =>
      __$$_JmaMapPropertyCopyWithImpl<_$_JmaMapProperty>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JmaMapPropertyToJson(
      this,
    );
  }
}

abstract class _JmaMapProperty implements JmaMapProperty {
  const factory _JmaMapProperty(
          {required final String? code,
          required final String? name,
          @JsonKey(name: 'namekana') required final String? nameKana}) =
      _$_JmaMapProperty;

  factory _JmaMapProperty.fromJson(Map<String, dynamic> json) =
      _$_JmaMapProperty.fromJson;

  @override
  String? get code;
  @override
  String? get name;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'namekana')
  String? get nameKana;
  @override
  @JsonKey(ignore: true)
  _$$_JmaMapPropertyCopyWith<_$_JmaMapProperty> get copyWith =>
      throw _privateConstructorUsedError;
}
