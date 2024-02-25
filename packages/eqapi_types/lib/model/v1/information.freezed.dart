// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InformationV1 _$InformationV1FromJson(Map<String, dynamic> json) {
  return _InformationV1.fromJson(json);
}

/// @nodoc
mixin _$InformationV1 {
  @JsonKey(
      unknownEnumValue: InformationAuthor.unknown,
      defaultValue: InformationAuthor.unknown)
  InformationAuthor get author => throw _privateConstructorUsedError;
  Map<String, dynamic> get body => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  @JsonKey(
      unknownEnumValue: InformationLevel.info,
      defaultValue: InformationLevel.info)
  InformationLevel get level => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InformationV1CopyWith<InformationV1> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InformationV1CopyWith<$Res> {
  factory $InformationV1CopyWith(
          InformationV1 value, $Res Function(InformationV1) then) =
      _$InformationV1CopyWithImpl<$Res, InformationV1>;
  @useResult
  $Res call(
      {@JsonKey(
          unknownEnumValue: InformationAuthor.unknown,
          defaultValue: InformationAuthor.unknown)
      InformationAuthor author,
      Map<String, dynamic> body,
      DateTime createdAt,
      int id,
      @JsonKey(
          unknownEnumValue: InformationLevel.info,
          defaultValue: InformationLevel.info)
      InformationLevel level,
      String title,
      String type});
}

/// @nodoc
class _$InformationV1CopyWithImpl<$Res, $Val extends InformationV1>
    implements $InformationV1CopyWith<$Res> {
  _$InformationV1CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? body = null,
    Object? createdAt = null,
    Object? id = null,
    Object? level = null,
    Object? title = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as InformationAuthor,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as InformationLevel,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InformationV1ImplCopyWith<$Res>
    implements $InformationV1CopyWith<$Res> {
  factory _$$InformationV1ImplCopyWith(
          _$InformationV1Impl value, $Res Function(_$InformationV1Impl) then) =
      __$$InformationV1ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          unknownEnumValue: InformationAuthor.unknown,
          defaultValue: InformationAuthor.unknown)
      InformationAuthor author,
      Map<String, dynamic> body,
      DateTime createdAt,
      int id,
      @JsonKey(
          unknownEnumValue: InformationLevel.info,
          defaultValue: InformationLevel.info)
      InformationLevel level,
      String title,
      String type});
}

/// @nodoc
class __$$InformationV1ImplCopyWithImpl<$Res>
    extends _$InformationV1CopyWithImpl<$Res, _$InformationV1Impl>
    implements _$$InformationV1ImplCopyWith<$Res> {
  __$$InformationV1ImplCopyWithImpl(
      _$InformationV1Impl _value, $Res Function(_$InformationV1Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? body = null,
    Object? createdAt = null,
    Object? id = null,
    Object? level = null,
    Object? title = null,
    Object? type = null,
  }) {
    return _then(_$InformationV1Impl(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as InformationAuthor,
      body: null == body
          ? _value._body
          : body // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as InformationLevel,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InformationV1Impl implements _InformationV1 {
  const _$InformationV1Impl(
      {@JsonKey(
          unknownEnumValue: InformationAuthor.unknown,
          defaultValue: InformationAuthor.unknown)
      required this.author,
      required final Map<String, dynamic> body,
      required this.createdAt,
      required this.id,
      @JsonKey(
          unknownEnumValue: InformationLevel.info,
          defaultValue: InformationLevel.info)
      required this.level,
      required this.title,
      required this.type})
      : _body = body;

  factory _$InformationV1Impl.fromJson(Map<String, dynamic> json) =>
      _$$InformationV1ImplFromJson(json);

  @override
  @JsonKey(
      unknownEnumValue: InformationAuthor.unknown,
      defaultValue: InformationAuthor.unknown)
  final InformationAuthor author;
  final Map<String, dynamic> _body;
  @override
  Map<String, dynamic> get body {
    if (_body is EqualUnmodifiableMapView) return _body;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_body);
  }

  @override
  final DateTime createdAt;
  @override
  final int id;
  @override
  @JsonKey(
      unknownEnumValue: InformationLevel.info,
      defaultValue: InformationLevel.info)
  final InformationLevel level;
  @override
  final String title;
  @override
  final String type;

  @override
  String toString() {
    return 'InformationV1(author: $author, body: $body, createdAt: $createdAt, id: $id, level: $level, title: $title, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InformationV1Impl &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality().equals(other._body, _body) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      author,
      const DeepCollectionEquality().hash(_body),
      createdAt,
      id,
      level,
      title,
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InformationV1ImplCopyWith<_$InformationV1Impl> get copyWith =>
      __$$InformationV1ImplCopyWithImpl<_$InformationV1Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InformationV1ImplToJson(
      this,
    );
  }
}

abstract class _InformationV1 implements InformationV1 {
  const factory _InformationV1(
      {@JsonKey(
          unknownEnumValue: InformationAuthor.unknown,
          defaultValue: InformationAuthor.unknown)
      required final InformationAuthor author,
      required final Map<String, dynamic> body,
      required final DateTime createdAt,
      required final int id,
      @JsonKey(
          unknownEnumValue: InformationLevel.info,
          defaultValue: InformationLevel.info)
      required final InformationLevel level,
      required final String title,
      required final String type}) = _$InformationV1Impl;

  factory _InformationV1.fromJson(Map<String, dynamic> json) =
      _$InformationV1Impl.fromJson;

  @override
  @JsonKey(
      unknownEnumValue: InformationAuthor.unknown,
      defaultValue: InformationAuthor.unknown)
  InformationAuthor get author;
  @override
  Map<String, dynamic> get body;
  @override
  DateTime get createdAt;
  @override
  int get id;
  @override
  @JsonKey(
      unknownEnumValue: InformationLevel.info,
      defaultValue: InformationLevel.info)
  InformationLevel get level;
  @override
  String get title;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$InformationV1ImplCopyWith<_$InformationV1Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
