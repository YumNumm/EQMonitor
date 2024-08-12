// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_postgres_changes_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RealtimePostgresInsertPayload<T>
    _$RealtimePostgresInsertPayloadFromJson<T extends V1Database>(
        Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _RealtimePostgresInsertPayload<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$RealtimePostgresInsertPayload<T extends V1Database> {
  String get schema => throw _privateConstructorUsedError;
  String get table => throw _privateConstructorUsedError;
  DateTime get commitTimestamp => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;
  @JsonKey(name: 'new')
  T get newData => throw _privateConstructorUsedError;

  /// Serializes this RealtimePostgresInsertPayload to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of RealtimePostgresInsertPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RealtimePostgresInsertPayloadCopyWith<T, RealtimePostgresInsertPayload<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RealtimePostgresInsertPayloadCopyWith<T extends V1Database,
    $Res> {
  factory $RealtimePostgresInsertPayloadCopyWith(
          RealtimePostgresInsertPayload<T> value,
          $Res Function(RealtimePostgresInsertPayload<T>) then) =
      _$RealtimePostgresInsertPayloadCopyWithImpl<T, $Res,
          RealtimePostgresInsertPayload<T>>;
  @useResult
  $Res call(
      {String schema,
      String table,
      DateTime commitTimestamp,
      List<String>? errors,
      @JsonKey(name: 'new') T newData});
}

/// @nodoc
class _$RealtimePostgresInsertPayloadCopyWithImpl<T extends V1Database, $Res,
        $Val extends RealtimePostgresInsertPayload<T>>
    implements $RealtimePostgresInsertPayloadCopyWith<T, $Res> {
  _$RealtimePostgresInsertPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RealtimePostgresInsertPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? table = null,
    Object? commitTimestamp = null,
    Object? errors = freezed,
    Object? newData = null,
  }) {
    return _then(_value.copyWith(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      commitTimestamp: null == commitTimestamp
          ? _value.commitTimestamp
          : commitTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      errors: freezed == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      newData: null == newData
          ? _value.newData
          : newData // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RealtimePostgresInsertPayloadImplCopyWith<
    T extends V1Database,
    $Res> implements $RealtimePostgresInsertPayloadCopyWith<T, $Res> {
  factory _$$RealtimePostgresInsertPayloadImplCopyWith(
          _$RealtimePostgresInsertPayloadImpl<T> value,
          $Res Function(_$RealtimePostgresInsertPayloadImpl<T>) then) =
      __$$RealtimePostgresInsertPayloadImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {String schema,
      String table,
      DateTime commitTimestamp,
      List<String>? errors,
      @JsonKey(name: 'new') T newData});
}

/// @nodoc
class __$$RealtimePostgresInsertPayloadImplCopyWithImpl<T extends V1Database,
        $Res>
    extends _$RealtimePostgresInsertPayloadCopyWithImpl<T, $Res,
        _$RealtimePostgresInsertPayloadImpl<T>>
    implements _$$RealtimePostgresInsertPayloadImplCopyWith<T, $Res> {
  __$$RealtimePostgresInsertPayloadImplCopyWithImpl(
      _$RealtimePostgresInsertPayloadImpl<T> _value,
      $Res Function(_$RealtimePostgresInsertPayloadImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of RealtimePostgresInsertPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? table = null,
    Object? commitTimestamp = null,
    Object? errors = freezed,
    Object? newData = null,
  }) {
    return _then(_$RealtimePostgresInsertPayloadImpl<T>(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      commitTimestamp: null == commitTimestamp
          ? _value.commitTimestamp
          : commitTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      errors: freezed == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      newData: null == newData
          ? _value.newData
          : newData // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$RealtimePostgresInsertPayloadImpl<T extends V1Database>
    implements _RealtimePostgresInsertPayload<T> {
  const _$RealtimePostgresInsertPayloadImpl(
      {required this.schema,
      required this.table,
      required this.commitTimestamp,
      required final List<String>? errors,
      @JsonKey(name: 'new') required this.newData})
      : _errors = errors;

  factory _$RealtimePostgresInsertPayloadImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$RealtimePostgresInsertPayloadImplFromJson(json, fromJsonT);

  @override
  final String schema;
  @override
  final String table;
  @override
  final DateTime commitTimestamp;
  final List<String>? _errors;
  @override
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'new')
  final T newData;

  @override
  String toString() {
    return 'RealtimePostgresInsertPayload<$T>(schema: $schema, table: $table, commitTimestamp: $commitTimestamp, errors: $errors, newData: $newData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RealtimePostgresInsertPayloadImpl<T> &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.commitTimestamp, commitTimestamp) ||
                other.commitTimestamp == commitTimestamp) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            const DeepCollectionEquality().equals(other.newData, newData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      schema,
      table,
      commitTimestamp,
      const DeepCollectionEquality().hash(_errors),
      const DeepCollectionEquality().hash(newData));

  /// Create a copy of RealtimePostgresInsertPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RealtimePostgresInsertPayloadImplCopyWith<T,
          _$RealtimePostgresInsertPayloadImpl<T>>
      get copyWith => __$$RealtimePostgresInsertPayloadImplCopyWithImpl<T,
          _$RealtimePostgresInsertPayloadImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$RealtimePostgresInsertPayloadImplToJson<T>(this, toJsonT);
  }
}

abstract class _RealtimePostgresInsertPayload<T extends V1Database>
    implements RealtimePostgresInsertPayload<T> {
  const factory _RealtimePostgresInsertPayload(
          {required final String schema,
          required final String table,
          required final DateTime commitTimestamp,
          required final List<String>? errors,
          @JsonKey(name: 'new') required final T newData}) =
      _$RealtimePostgresInsertPayloadImpl<T>;

  factory _RealtimePostgresInsertPayload.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$RealtimePostgresInsertPayloadImpl<T>.fromJson;

  @override
  String get schema;
  @override
  String get table;
  @override
  DateTime get commitTimestamp;
  @override
  List<String>? get errors;
  @override
  @JsonKey(name: 'new')
  T get newData;

  /// Create a copy of RealtimePostgresInsertPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RealtimePostgresInsertPayloadImplCopyWith<T,
          _$RealtimePostgresInsertPayloadImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

RealtimePostgresUpdatePayload<T>
    _$RealtimePostgresUpdatePayloadFromJson<T extends V1Database>(
        Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _RealtimePostgresUpdatePayload<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$RealtimePostgresUpdatePayload<T extends V1Database> {
  String get schema => throw _privateConstructorUsedError;
  String get table => throw _privateConstructorUsedError;
  DateTime get commitTimestamp => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;
  @JsonKey(name: 'new')
  T get newData => throw _privateConstructorUsedError;

  /// Partical<T> | null
  Map<String, dynamic>? get old => throw _privateConstructorUsedError;

  /// Serializes this RealtimePostgresUpdatePayload to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of RealtimePostgresUpdatePayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RealtimePostgresUpdatePayloadCopyWith<T, RealtimePostgresUpdatePayload<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RealtimePostgresUpdatePayloadCopyWith<T extends V1Database,
    $Res> {
  factory $RealtimePostgresUpdatePayloadCopyWith(
          RealtimePostgresUpdatePayload<T> value,
          $Res Function(RealtimePostgresUpdatePayload<T>) then) =
      _$RealtimePostgresUpdatePayloadCopyWithImpl<T, $Res,
          RealtimePostgresUpdatePayload<T>>;
  @useResult
  $Res call(
      {String schema,
      String table,
      DateTime commitTimestamp,
      List<String>? errors,
      @JsonKey(name: 'new') T newData,
      Map<String, dynamic>? old});
}

/// @nodoc
class _$RealtimePostgresUpdatePayloadCopyWithImpl<T extends V1Database, $Res,
        $Val extends RealtimePostgresUpdatePayload<T>>
    implements $RealtimePostgresUpdatePayloadCopyWith<T, $Res> {
  _$RealtimePostgresUpdatePayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RealtimePostgresUpdatePayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? table = null,
    Object? commitTimestamp = null,
    Object? errors = freezed,
    Object? newData = null,
    Object? old = freezed,
  }) {
    return _then(_value.copyWith(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      commitTimestamp: null == commitTimestamp
          ? _value.commitTimestamp
          : commitTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      errors: freezed == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      newData: null == newData
          ? _value.newData
          : newData // ignore: cast_nullable_to_non_nullable
              as T,
      old: freezed == old
          ? _value.old
          : old // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RealtimePostgresUpdatePayloadImplCopyWith<
    T extends V1Database,
    $Res> implements $RealtimePostgresUpdatePayloadCopyWith<T, $Res> {
  factory _$$RealtimePostgresUpdatePayloadImplCopyWith(
          _$RealtimePostgresUpdatePayloadImpl<T> value,
          $Res Function(_$RealtimePostgresUpdatePayloadImpl<T>) then) =
      __$$RealtimePostgresUpdatePayloadImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {String schema,
      String table,
      DateTime commitTimestamp,
      List<String>? errors,
      @JsonKey(name: 'new') T newData,
      Map<String, dynamic>? old});
}

/// @nodoc
class __$$RealtimePostgresUpdatePayloadImplCopyWithImpl<T extends V1Database,
        $Res>
    extends _$RealtimePostgresUpdatePayloadCopyWithImpl<T, $Res,
        _$RealtimePostgresUpdatePayloadImpl<T>>
    implements _$$RealtimePostgresUpdatePayloadImplCopyWith<T, $Res> {
  __$$RealtimePostgresUpdatePayloadImplCopyWithImpl(
      _$RealtimePostgresUpdatePayloadImpl<T> _value,
      $Res Function(_$RealtimePostgresUpdatePayloadImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of RealtimePostgresUpdatePayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? table = null,
    Object? commitTimestamp = null,
    Object? errors = freezed,
    Object? newData = null,
    Object? old = freezed,
  }) {
    return _then(_$RealtimePostgresUpdatePayloadImpl<T>(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      commitTimestamp: null == commitTimestamp
          ? _value.commitTimestamp
          : commitTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      errors: freezed == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      newData: null == newData
          ? _value.newData
          : newData // ignore: cast_nullable_to_non_nullable
              as T,
      old: freezed == old
          ? _value._old
          : old // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$RealtimePostgresUpdatePayloadImpl<T extends V1Database>
    implements _RealtimePostgresUpdatePayload<T> {
  const _$RealtimePostgresUpdatePayloadImpl(
      {required this.schema,
      required this.table,
      required this.commitTimestamp,
      required final List<String>? errors,
      @JsonKey(name: 'new') required this.newData,
      required final Map<String, dynamic>? old})
      : _errors = errors,
        _old = old;

  factory _$RealtimePostgresUpdatePayloadImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$RealtimePostgresUpdatePayloadImplFromJson(json, fromJsonT);

  @override
  final String schema;
  @override
  final String table;
  @override
  final DateTime commitTimestamp;
  final List<String>? _errors;
  @override
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'new')
  final T newData;

  /// Partical<T> | null
  final Map<String, dynamic>? _old;

  /// Partical<T> | null
  @override
  Map<String, dynamic>? get old {
    final value = _old;
    if (value == null) return null;
    if (_old is EqualUnmodifiableMapView) return _old;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'RealtimePostgresUpdatePayload<$T>(schema: $schema, table: $table, commitTimestamp: $commitTimestamp, errors: $errors, newData: $newData, old: $old)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RealtimePostgresUpdatePayloadImpl<T> &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.commitTimestamp, commitTimestamp) ||
                other.commitTimestamp == commitTimestamp) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            const DeepCollectionEquality().equals(other.newData, newData) &&
            const DeepCollectionEquality().equals(other._old, _old));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      schema,
      table,
      commitTimestamp,
      const DeepCollectionEquality().hash(_errors),
      const DeepCollectionEquality().hash(newData),
      const DeepCollectionEquality().hash(_old));

  /// Create a copy of RealtimePostgresUpdatePayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RealtimePostgresUpdatePayloadImplCopyWith<T,
          _$RealtimePostgresUpdatePayloadImpl<T>>
      get copyWith => __$$RealtimePostgresUpdatePayloadImplCopyWithImpl<T,
          _$RealtimePostgresUpdatePayloadImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$RealtimePostgresUpdatePayloadImplToJson<T>(this, toJsonT);
  }
}

abstract class _RealtimePostgresUpdatePayload<T extends V1Database>
    implements RealtimePostgresUpdatePayload<T> {
  const factory _RealtimePostgresUpdatePayload(
          {required final String schema,
          required final String table,
          required final DateTime commitTimestamp,
          required final List<String>? errors,
          @JsonKey(name: 'new') required final T newData,
          required final Map<String, dynamic>? old}) =
      _$RealtimePostgresUpdatePayloadImpl<T>;

  factory _RealtimePostgresUpdatePayload.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$RealtimePostgresUpdatePayloadImpl<T>.fromJson;

  @override
  String get schema;
  @override
  String get table;
  @override
  DateTime get commitTimestamp;
  @override
  List<String>? get errors;
  @override
  @JsonKey(name: 'new')
  T get newData;

  /// Partical<T> | null
  @override
  Map<String, dynamic>? get old;

  /// Create a copy of RealtimePostgresUpdatePayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RealtimePostgresUpdatePayloadImplCopyWith<T,
          _$RealtimePostgresUpdatePayloadImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

RealtimePostgresDeletePayload<T>
    _$RealtimePostgresDeletePayloadFromJson<T extends V1Database>(
        Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _RealtimePostgresDeletePayload<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$RealtimePostgresDeletePayload<T extends V1Database> {
  String get schema => throw _privateConstructorUsedError;
  String get table => throw _privateConstructorUsedError;
  DateTime get commitTimestamp => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Partical<T> | null
  Map<String, dynamic>? get old => throw _privateConstructorUsedError;

  /// Serializes this RealtimePostgresDeletePayload to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of RealtimePostgresDeletePayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RealtimePostgresDeletePayloadCopyWith<T, RealtimePostgresDeletePayload<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RealtimePostgresDeletePayloadCopyWith<T extends V1Database,
    $Res> {
  factory $RealtimePostgresDeletePayloadCopyWith(
          RealtimePostgresDeletePayload<T> value,
          $Res Function(RealtimePostgresDeletePayload<T>) then) =
      _$RealtimePostgresDeletePayloadCopyWithImpl<T, $Res,
          RealtimePostgresDeletePayload<T>>;
  @useResult
  $Res call(
      {String schema,
      String table,
      DateTime commitTimestamp,
      List<String>? errors,
      Map<String, dynamic>? old});
}

/// @nodoc
class _$RealtimePostgresDeletePayloadCopyWithImpl<T extends V1Database, $Res,
        $Val extends RealtimePostgresDeletePayload<T>>
    implements $RealtimePostgresDeletePayloadCopyWith<T, $Res> {
  _$RealtimePostgresDeletePayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RealtimePostgresDeletePayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? table = null,
    Object? commitTimestamp = null,
    Object? errors = freezed,
    Object? old = freezed,
  }) {
    return _then(_value.copyWith(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      commitTimestamp: null == commitTimestamp
          ? _value.commitTimestamp
          : commitTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      errors: freezed == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      old: freezed == old
          ? _value.old
          : old // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RealtimePostgresDeletePayloadImplCopyWith<
    T extends V1Database,
    $Res> implements $RealtimePostgresDeletePayloadCopyWith<T, $Res> {
  factory _$$RealtimePostgresDeletePayloadImplCopyWith(
          _$RealtimePostgresDeletePayloadImpl<T> value,
          $Res Function(_$RealtimePostgresDeletePayloadImpl<T>) then) =
      __$$RealtimePostgresDeletePayloadImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {String schema,
      String table,
      DateTime commitTimestamp,
      List<String>? errors,
      Map<String, dynamic>? old});
}

/// @nodoc
class __$$RealtimePostgresDeletePayloadImplCopyWithImpl<T extends V1Database,
        $Res>
    extends _$RealtimePostgresDeletePayloadCopyWithImpl<T, $Res,
        _$RealtimePostgresDeletePayloadImpl<T>>
    implements _$$RealtimePostgresDeletePayloadImplCopyWith<T, $Res> {
  __$$RealtimePostgresDeletePayloadImplCopyWithImpl(
      _$RealtimePostgresDeletePayloadImpl<T> _value,
      $Res Function(_$RealtimePostgresDeletePayloadImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of RealtimePostgresDeletePayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? table = null,
    Object? commitTimestamp = null,
    Object? errors = freezed,
    Object? old = freezed,
  }) {
    return _then(_$RealtimePostgresDeletePayloadImpl<T>(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      commitTimestamp: null == commitTimestamp
          ? _value.commitTimestamp
          : commitTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      errors: freezed == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      old: freezed == old
          ? _value._old
          : old // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$RealtimePostgresDeletePayloadImpl<T extends V1Database>
    implements _RealtimePostgresDeletePayload<T> {
  const _$RealtimePostgresDeletePayloadImpl(
      {required this.schema,
      required this.table,
      required this.commitTimestamp,
      required final List<String>? errors,
      required final Map<String, dynamic>? old})
      : _errors = errors,
        _old = old;

  factory _$RealtimePostgresDeletePayloadImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$RealtimePostgresDeletePayloadImplFromJson(json, fromJsonT);

  @override
  final String schema;
  @override
  final String table;
  @override
  final DateTime commitTimestamp;
  final List<String>? _errors;
  @override
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Partical<T> | null
  final Map<String, dynamic>? _old;

  /// Partical<T> | null
  @override
  Map<String, dynamic>? get old {
    final value = _old;
    if (value == null) return null;
    if (_old is EqualUnmodifiableMapView) return _old;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'RealtimePostgresDeletePayload<$T>(schema: $schema, table: $table, commitTimestamp: $commitTimestamp, errors: $errors, old: $old)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RealtimePostgresDeletePayloadImpl<T> &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.commitTimestamp, commitTimestamp) ||
                other.commitTimestamp == commitTimestamp) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            const DeepCollectionEquality().equals(other._old, _old));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      schema,
      table,
      commitTimestamp,
      const DeepCollectionEquality().hash(_errors),
      const DeepCollectionEquality().hash(_old));

  /// Create a copy of RealtimePostgresDeletePayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RealtimePostgresDeletePayloadImplCopyWith<T,
          _$RealtimePostgresDeletePayloadImpl<T>>
      get copyWith => __$$RealtimePostgresDeletePayloadImplCopyWithImpl<T,
          _$RealtimePostgresDeletePayloadImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$RealtimePostgresDeletePayloadImplToJson<T>(this, toJsonT);
  }
}

abstract class _RealtimePostgresDeletePayload<T extends V1Database>
    implements RealtimePostgresDeletePayload<T> {
  const factory _RealtimePostgresDeletePayload(
          {required final String schema,
          required final String table,
          required final DateTime commitTimestamp,
          required final List<String>? errors,
          required final Map<String, dynamic>? old}) =
      _$RealtimePostgresDeletePayloadImpl<T>;

  factory _RealtimePostgresDeletePayload.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$RealtimePostgresDeletePayloadImpl<T>.fromJson;

  @override
  String get schema;
  @override
  String get table;
  @override
  DateTime get commitTimestamp;
  @override
  List<String>? get errors;

  /// Partical<T> | null
  @override
  Map<String, dynamic>? get old;

  /// Create a copy of RealtimePostgresDeletePayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RealtimePostgresDeletePayloadImplCopyWith<T,
          _$RealtimePostgresDeletePayloadImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}
