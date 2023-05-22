// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'naming.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Naming _$NamingFromJson(Map<String, dynamic> json) {
  return _Naming.fromJson(json);
}

/// @nodoc
mixin _$Naming {
  String get text => throw _privateConstructorUsedError;
  String? get en => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NamingCopyWith<Naming> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NamingCopyWith<$Res> {
  factory $NamingCopyWith(Naming value, $Res Function(Naming) then) =
      _$NamingCopyWithImpl<$Res, Naming>;
  @useResult
  $Res call({String text, String? en});
}

/// @nodoc
class _$NamingCopyWithImpl<$Res, $Val extends Naming>
    implements $NamingCopyWith<$Res> {
  _$NamingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? en = freezed,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      en: freezed == en
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NamingCopyWith<$Res> implements $NamingCopyWith<$Res> {
  factory _$$_NamingCopyWith(_$_Naming value, $Res Function(_$_Naming) then) =
      __$$_NamingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? en});
}

/// @nodoc
class __$$_NamingCopyWithImpl<$Res>
    extends _$NamingCopyWithImpl<$Res, _$_Naming>
    implements _$$_NamingCopyWith<$Res> {
  __$$_NamingCopyWithImpl(_$_Naming _value, $Res Function(_$_Naming) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? en = freezed,
  }) {
    return _then(_$_Naming(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      en: freezed == en
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Naming implements _Naming {
  const _$_Naming({required this.text, required this.en});

  factory _$_Naming.fromJson(Map<String, dynamic> json) =>
      _$$_NamingFromJson(json);

  @override
  final String text;
  @override
  final String? en;

  @override
  String toString() {
    return 'Naming(text: $text, en: $en)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Naming &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.en, en) || other.en == en));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, en);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NamingCopyWith<_$_Naming> get copyWith =>
      __$$_NamingCopyWithImpl<_$_Naming>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NamingToJson(
      this,
    );
  }
}

abstract class _Naming implements Naming {
  const factory _Naming(
      {required final String text, required final String? en}) = _$_Naming;

  factory _Naming.fromJson(Map<String, dynamic> json) = _$_Naming.fromJson;

  @override
  String get text;
  @override
  String? get en;
  @override
  @JsonKey(ignore: true)
  _$$_NamingCopyWith<_$_Naming> get copyWith =>
      throw _privateConstructorUsedError;
}
