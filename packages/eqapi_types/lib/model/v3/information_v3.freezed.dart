// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'information_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InformationV3Result _$InformationV3ResultFromJson(Map<String, dynamic> json) {
  return _InformationV3Result.fromJson(json);
}

/// @nodoc
mixin _$InformationV3Result {
  List<InformationV3> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InformationV3ResultCopyWith<InformationV3Result> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InformationV3ResultCopyWith<$Res> {
  factory $InformationV3ResultCopyWith(
          InformationV3Result value, $Res Function(InformationV3Result) then) =
      _$InformationV3ResultCopyWithImpl<$Res, InformationV3Result>;
  @useResult
  $Res call({List<InformationV3> items});
}

/// @nodoc
class _$InformationV3ResultCopyWithImpl<$Res, $Val extends InformationV3Result>
    implements $InformationV3ResultCopyWith<$Res> {
  _$InformationV3ResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<InformationV3>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InformationV3ResultImplCopyWith<$Res>
    implements $InformationV3ResultCopyWith<$Res> {
  factory _$$InformationV3ResultImplCopyWith(_$InformationV3ResultImpl value,
          $Res Function(_$InformationV3ResultImpl) then) =
      __$$InformationV3ResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<InformationV3> items});
}

/// @nodoc
class __$$InformationV3ResultImplCopyWithImpl<$Res>
    extends _$InformationV3ResultCopyWithImpl<$Res, _$InformationV3ResultImpl>
    implements _$$InformationV3ResultImplCopyWith<$Res> {
  __$$InformationV3ResultImplCopyWithImpl(_$InformationV3ResultImpl _value,
      $Res Function(_$InformationV3ResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$InformationV3ResultImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<InformationV3>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InformationV3ResultImpl implements _InformationV3Result {
  const _$InformationV3ResultImpl({required final List<InformationV3> items})
      : _items = items;

  factory _$InformationV3ResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$InformationV3ResultImplFromJson(json);

  final List<InformationV3> _items;
  @override
  List<InformationV3> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'InformationV3Result(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InformationV3ResultImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InformationV3ResultImplCopyWith<_$InformationV3ResultImpl> get copyWith =>
      __$$InformationV3ResultImplCopyWithImpl<_$InformationV3ResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InformationV3ResultImplToJson(
      this,
    );
  }
}

abstract class _InformationV3Result implements InformationV3Result {
  const factory _InformationV3Result(
      {required final List<InformationV3> items}) = _$InformationV3ResultImpl;

  factory _InformationV3Result.fromJson(Map<String, dynamic> json) =
      _$InformationV3ResultImpl.fromJson;

  @override
  List<InformationV3> get items;
  @override
  @JsonKey(ignore: true)
  _$$InformationV3ResultImplCopyWith<_$InformationV3ResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InformationV3 _$InformationV3FromJson(Map<String, dynamic> json) {
  return _InformationV3.fromJson(json);
}

/// @nodoc
mixin _$InformationV3 {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  @JsonKey(unknownEnumValue: Author.unknown)
  Author get author => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(unknownEnumValue: Level.info)
  Level get level => throw _privateConstructorUsedError;
  int? get eventId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InformationV3CopyWith<InformationV3> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InformationV3CopyWith<$Res> {
  factory $InformationV3CopyWith(
          InformationV3 value, $Res Function(InformationV3) then) =
      _$InformationV3CopyWithImpl<$Res, InformationV3>;
  @useResult
  $Res call(
      {int id,
      String title,
      String body,
      @JsonKey(unknownEnumValue: Author.unknown) Author author,
      DateTime createdAt,
      @JsonKey(unknownEnumValue: Level.info) Level level,
      int? eventId});
}

/// @nodoc
class _$InformationV3CopyWithImpl<$Res, $Val extends InformationV3>
    implements $InformationV3CopyWith<$Res> {
  _$InformationV3CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? author = null,
    Object? createdAt = null,
    Object? level = null,
    Object? eventId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as Level,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InformationV3ImplCopyWith<$Res>
    implements $InformationV3CopyWith<$Res> {
  factory _$$InformationV3ImplCopyWith(
          _$InformationV3Impl value, $Res Function(_$InformationV3Impl) then) =
      __$$InformationV3ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String body,
      @JsonKey(unknownEnumValue: Author.unknown) Author author,
      DateTime createdAt,
      @JsonKey(unknownEnumValue: Level.info) Level level,
      int? eventId});
}

/// @nodoc
class __$$InformationV3ImplCopyWithImpl<$Res>
    extends _$InformationV3CopyWithImpl<$Res, _$InformationV3Impl>
    implements _$$InformationV3ImplCopyWith<$Res> {
  __$$InformationV3ImplCopyWithImpl(
      _$InformationV3Impl _value, $Res Function(_$InformationV3Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? author = null,
    Object? createdAt = null,
    Object? level = null,
    Object? eventId = freezed,
  }) {
    return _then(_$InformationV3Impl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as Level,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InformationV3Impl implements _InformationV3 {
  const _$InformationV3Impl(
      {required this.id,
      required this.title,
      required this.body,
      @JsonKey(unknownEnumValue: Author.unknown) required this.author,
      required this.createdAt,
      @JsonKey(unknownEnumValue: Level.info) required this.level,
      required this.eventId});

  factory _$InformationV3Impl.fromJson(Map<String, dynamic> json) =>
      _$$InformationV3ImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String body;
  @override
  @JsonKey(unknownEnumValue: Author.unknown)
  final Author author;
  @override
  final DateTime createdAt;
  @override
  @JsonKey(unknownEnumValue: Level.info)
  final Level level;
  @override
  final int? eventId;

  @override
  String toString() {
    return 'InformationV3(id: $id, title: $title, body: $body, author: $author, createdAt: $createdAt, level: $level, eventId: $eventId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InformationV3Impl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.eventId, eventId) || other.eventId == eventId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, body, author, createdAt, level, eventId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InformationV3ImplCopyWith<_$InformationV3Impl> get copyWith =>
      __$$InformationV3ImplCopyWithImpl<_$InformationV3Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InformationV3ImplToJson(
      this,
    );
  }
}

abstract class _InformationV3 implements InformationV3 {
  const factory _InformationV3(
      {required final int id,
      required final String title,
      required final String body,
      @JsonKey(unknownEnumValue: Author.unknown) required final Author author,
      required final DateTime createdAt,
      @JsonKey(unknownEnumValue: Level.info) required final Level level,
      required final int? eventId}) = _$InformationV3Impl;

  factory _InformationV3.fromJson(Map<String, dynamic> json) =
      _$InformationV3Impl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get body;
  @override
  @JsonKey(unknownEnumValue: Author.unknown)
  Author get author;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(unknownEnumValue: Level.info)
  Level get level;
  @override
  int? get eventId;
  @override
  @JsonKey(ignore: true)
  _$$InformationV3ImplCopyWith<_$InformationV3Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
