// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world_map_property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WorldMapProperty _$WorldMapPropertyFromJson(Map<String, dynamic> json) {
  return _WorldMapProperty.fromJson(json);
}

/// @nodoc
mixin _$WorldMapProperty {
  @JsonKey(name: 'NAME')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'NAME_JA')
  String get nameJa => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorldMapPropertyCopyWith<WorldMapProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldMapPropertyCopyWith<$Res> {
  factory $WorldMapPropertyCopyWith(
          WorldMapProperty value, $Res Function(WorldMapProperty) then) =
      _$WorldMapPropertyCopyWithImpl<$Res, WorldMapProperty>;
  @useResult
  $Res call(
      {@JsonKey(name: 'NAME') String name,
      @JsonKey(name: 'NAME_JA') String nameJa});
}

/// @nodoc
class _$WorldMapPropertyCopyWithImpl<$Res, $Val extends WorldMapProperty>
    implements $WorldMapPropertyCopyWith<$Res> {
  _$WorldMapPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? nameJa = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameJa: null == nameJa
          ? _value.nameJa
          : nameJa // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WorldMapPropertyCopyWith<$Res>
    implements $WorldMapPropertyCopyWith<$Res> {
  factory _$$_WorldMapPropertyCopyWith(
          _$_WorldMapProperty value, $Res Function(_$_WorldMapProperty) then) =
      __$$_WorldMapPropertyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'NAME') String name,
      @JsonKey(name: 'NAME_JA') String nameJa});
}

/// @nodoc
class __$$_WorldMapPropertyCopyWithImpl<$Res>
    extends _$WorldMapPropertyCopyWithImpl<$Res, _$_WorldMapProperty>
    implements _$$_WorldMapPropertyCopyWith<$Res> {
  __$$_WorldMapPropertyCopyWithImpl(
      _$_WorldMapProperty _value, $Res Function(_$_WorldMapProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? nameJa = null,
  }) {
    return _then(_$_WorldMapProperty(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameJa: null == nameJa
          ? _value.nameJa
          : nameJa // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WorldMapProperty implements _WorldMapProperty {
  const _$_WorldMapProperty(
      {@JsonKey(name: 'NAME') required this.name,
      @JsonKey(name: 'NAME_JA') required this.nameJa});

  factory _$_WorldMapProperty.fromJson(Map<String, dynamic> json) =>
      _$$_WorldMapPropertyFromJson(json);

  @override
  @JsonKey(name: 'NAME')
  final String name;
  @override
  @JsonKey(name: 'NAME_JA')
  final String nameJa;

  @override
  String toString() {
    return 'WorldMapProperty(name: $name, nameJa: $nameJa)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WorldMapProperty &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameJa, nameJa) || other.nameJa == nameJa));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, nameJa);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WorldMapPropertyCopyWith<_$_WorldMapProperty> get copyWith =>
      __$$_WorldMapPropertyCopyWithImpl<_$_WorldMapProperty>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WorldMapPropertyToJson(
      this,
    );
  }
}

abstract class _WorldMapProperty implements WorldMapProperty {
  const factory _WorldMapProperty(
          {@JsonKey(name: 'NAME') required final String name,
          @JsonKey(name: 'NAME_JA') required final String nameJa}) =
      _$_WorldMapProperty;

  factory _WorldMapProperty.fromJson(Map<String, dynamic> json) =
      _$_WorldMapProperty.fromJson;

  @override
  @JsonKey(name: 'NAME')
  String get name;
  @override
  @JsonKey(name: 'NAME_JA')
  String get nameJa;
  @override
  @JsonKey(ignore: true)
  _$$_WorldMapPropertyCopyWith<_$_WorldMapProperty> get copyWith =>
      throw _privateConstructorUsedError;
}
