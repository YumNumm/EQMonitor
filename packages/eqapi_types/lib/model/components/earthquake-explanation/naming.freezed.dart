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
abstract class _$$NamingImplCopyWith<$Res> implements $NamingCopyWith<$Res> {
  factory _$$NamingImplCopyWith(
          _$NamingImpl value, $Res Function(_$NamingImpl) then) =
      __$$NamingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? en});
}

/// @nodoc
class __$$NamingImplCopyWithImpl<$Res>
    extends _$NamingCopyWithImpl<$Res, _$NamingImpl>
    implements _$$NamingImplCopyWith<$Res> {
  __$$NamingImplCopyWithImpl(
      _$NamingImpl _value, $Res Function(_$NamingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? en = freezed,
  }) {
    return _then(_$NamingImpl(
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
class _$NamingImpl implements _Naming {
  const _$NamingImpl({required this.text, required this.en});

  factory _$NamingImpl.fromJson(Map<String, dynamic> json) =>
      _$$NamingImplFromJson(json);

  @override
  final String text;
  @override
  final String? en;

  @override
  String toString() {
    return 'Naming(text: $text, en: $en)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamingImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.en, en) || other.en == en));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, en);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NamingImplCopyWith<_$NamingImpl> get copyWith =>
      __$$NamingImplCopyWithImpl<_$NamingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NamingImplToJson(
      this,
    );
  }
}

abstract class _Naming implements Naming {
  const factory _Naming(
      {required final String text, required final String? en}) = _$NamingImpl;

  factory _Naming.fromJson(Map<String, dynamic> json) = _$NamingImpl.fromJson;

  @override
  String get text;
  @override
  String? get en;
  @override
  @JsonKey(ignore: true)
  _$$NamingImplCopyWith<_$NamingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
