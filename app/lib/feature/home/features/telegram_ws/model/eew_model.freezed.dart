// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EewWsItem _$EewWsItemFromJson(Map<String, dynamic> json) {
  return _EewWsItem.fromJson(json);
}

/// @nodoc
mixin _$EewWsItem {
  TelegramV3 get telegram => throw _privateConstructorUsedError;
  Vxse45 get body => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EewWsItemCopyWith<EewWsItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewWsItemCopyWith<$Res> {
  factory $EewWsItemCopyWith(EewWsItem value, $Res Function(EewWsItem) then) =
      _$EewWsItemCopyWithImpl<$Res, EewWsItem>;
  @useResult
  $Res call({TelegramV3 telegram, Vxse45 body});
}

/// @nodoc
class _$EewWsItemCopyWithImpl<$Res, $Val extends EewWsItem>
    implements $EewWsItemCopyWith<$Res> {
  _$EewWsItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telegram = null,
    Object? body = null,
  }) {
    return _then(_value.copyWith(
      telegram: null == telegram
          ? _value.telegram
          : telegram // ignore: cast_nullable_to_non_nullable
              as TelegramV3,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as Vxse45,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EewWsItemImplCopyWith<$Res>
    implements $EewWsItemCopyWith<$Res> {
  factory _$$EewWsItemImplCopyWith(
          _$EewWsItemImpl value, $Res Function(_$EewWsItemImpl) then) =
      __$$EewWsItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TelegramV3 telegram, Vxse45 body});
}

/// @nodoc
class __$$EewWsItemImplCopyWithImpl<$Res>
    extends _$EewWsItemCopyWithImpl<$Res, _$EewWsItemImpl>
    implements _$$EewWsItemImplCopyWith<$Res> {
  __$$EewWsItemImplCopyWithImpl(
      _$EewWsItemImpl _value, $Res Function(_$EewWsItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telegram = null,
    Object? body = null,
  }) {
    return _then(_$EewWsItemImpl(
      telegram: null == telegram
          ? _value.telegram
          : telegram // ignore: cast_nullable_to_non_nullable
              as TelegramV3,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as Vxse45,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EewWsItemImpl implements _EewWsItem {
  const _$EewWsItemImpl({required this.telegram, required this.body});

  factory _$EewWsItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$EewWsItemImplFromJson(json);

  @override
  final TelegramV3 telegram;
  @override
  final Vxse45 body;

  @override
  String toString() {
    return 'EewWsItem(telegram: $telegram, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EewWsItemImpl &&
            (identical(other.telegram, telegram) ||
                other.telegram == telegram) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, telegram, body);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EewWsItemImplCopyWith<_$EewWsItemImpl> get copyWith =>
      __$$EewWsItemImplCopyWithImpl<_$EewWsItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EewWsItemImplToJson(
      this,
    );
  }
}

abstract class _EewWsItem implements EewWsItem {
  const factory _EewWsItem(
      {required final TelegramV3 telegram,
      required final Vxse45 body}) = _$EewWsItemImpl;

  factory _EewWsItem.fromJson(Map<String, dynamic> json) =
      _$EewWsItemImpl.fromJson;

  @override
  TelegramV3 get telegram;
  @override
  Vxse45 get body;
  @override
  @JsonKey(ignore: true)
  _$$EewWsItemImplCopyWith<_$EewWsItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
