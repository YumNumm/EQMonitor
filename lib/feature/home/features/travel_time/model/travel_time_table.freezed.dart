// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'travel_time_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TravelTimeTable {
  double get p => throw _privateConstructorUsedError;
  double get s => throw _privateConstructorUsedError;
  int get depth => throw _privateConstructorUsedError;
  int get distance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TravelTimeTableCopyWith<TravelTimeTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TravelTimeTableCopyWith<$Res> {
  factory $TravelTimeTableCopyWith(
          TravelTimeTable value, $Res Function(TravelTimeTable) then) =
      _$TravelTimeTableCopyWithImpl<$Res, TravelTimeTable>;
  @useResult
  $Res call({double p, double s, int depth, int distance});
}

/// @nodoc
class _$TravelTimeTableCopyWithImpl<$Res, $Val extends TravelTimeTable>
    implements $TravelTimeTableCopyWith<$Res> {
  _$TravelTimeTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? p = null,
    Object? s = null,
    Object? depth = null,
    Object? distance = null,
  }) {
    return _then(_value.copyWith(
      p: null == p
          ? _value.p
          : p // ignore: cast_nullable_to_non_nullable
              as double,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as double,
      depth: null == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TravelTimeTableImplCopyWith<$Res>
    implements $TravelTimeTableCopyWith<$Res> {
  factory _$$TravelTimeTableImplCopyWith(_$TravelTimeTableImpl value,
          $Res Function(_$TravelTimeTableImpl) then) =
      __$$TravelTimeTableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double p, double s, int depth, int distance});
}

/// @nodoc
class __$$TravelTimeTableImplCopyWithImpl<$Res>
    extends _$TravelTimeTableCopyWithImpl<$Res, _$TravelTimeTableImpl>
    implements _$$TravelTimeTableImplCopyWith<$Res> {
  __$$TravelTimeTableImplCopyWithImpl(
      _$TravelTimeTableImpl _value, $Res Function(_$TravelTimeTableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? p = null,
    Object? s = null,
    Object? depth = null,
    Object? distance = null,
  }) {
    return _then(_$TravelTimeTableImpl(
      p: null == p
          ? _value.p
          : p // ignore: cast_nullable_to_non_nullable
              as double,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as double,
      depth: null == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TravelTimeTableImpl implements _TravelTimeTable {
  const _$TravelTimeTableImpl(
      {required this.p,
      required this.s,
      required this.depth,
      required this.distance});

  @override
  final double p;
  @override
  final double s;
  @override
  final int depth;
  @override
  final int distance;

  @override
  String toString() {
    return 'TravelTimeTable(p: $p, s: $s, depth: $depth, distance: $distance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TravelTimeTableImpl &&
            (identical(other.p, p) || other.p == p) &&
            (identical(other.s, s) || other.s == s) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, p, s, depth, distance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TravelTimeTableImplCopyWith<_$TravelTimeTableImpl> get copyWith =>
      __$$TravelTimeTableImplCopyWithImpl<_$TravelTimeTableImpl>(
          this, _$identity);
}

abstract class _TravelTimeTable implements TravelTimeTable {
  const factory _TravelTimeTable(
      {required final double p,
      required final double s,
      required final int depth,
      required final int distance}) = _$TravelTimeTableImpl;

  @override
  double get p;
  @override
  double get s;
  @override
  int get depth;
  @override
  int get distance;
  @override
  @JsonKey(ignore: true)
  _$$TravelTimeTableImplCopyWith<_$TravelTimeTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TravelTimeTables {
  List<TravelTimeTable> get table => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TravelTimeTablesCopyWith<TravelTimeTables> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TravelTimeTablesCopyWith<$Res> {
  factory $TravelTimeTablesCopyWith(
          TravelTimeTables value, $Res Function(TravelTimeTables) then) =
      _$TravelTimeTablesCopyWithImpl<$Res, TravelTimeTables>;
  @useResult
  $Res call({List<TravelTimeTable> table});
}

/// @nodoc
class _$TravelTimeTablesCopyWithImpl<$Res, $Val extends TravelTimeTables>
    implements $TravelTimeTablesCopyWith<$Res> {
  _$TravelTimeTablesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
  }) {
    return _then(_value.copyWith(
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as List<TravelTimeTable>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TravelTimeTablesImplCopyWith<$Res>
    implements $TravelTimeTablesCopyWith<$Res> {
  factory _$$TravelTimeTablesImplCopyWith(_$TravelTimeTablesImpl value,
          $Res Function(_$TravelTimeTablesImpl) then) =
      __$$TravelTimeTablesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TravelTimeTable> table});
}

/// @nodoc
class __$$TravelTimeTablesImplCopyWithImpl<$Res>
    extends _$TravelTimeTablesCopyWithImpl<$Res, _$TravelTimeTablesImpl>
    implements _$$TravelTimeTablesImplCopyWith<$Res> {
  __$$TravelTimeTablesImplCopyWithImpl(_$TravelTimeTablesImpl _value,
      $Res Function(_$TravelTimeTablesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
  }) {
    return _then(_$TravelTimeTablesImpl(
      table: null == table
          ? _value._table
          : table // ignore: cast_nullable_to_non_nullable
              as List<TravelTimeTable>,
    ));
  }
}

/// @nodoc

class _$TravelTimeTablesImpl implements _TravelTimeTables {
  const _$TravelTimeTablesImpl({required final List<TravelTimeTable> table})
      : _table = table;

  final List<TravelTimeTable> _table;
  @override
  List<TravelTimeTable> get table {
    if (_table is EqualUnmodifiableListView) return _table;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_table);
  }

  @override
  String toString() {
    return 'TravelTimeTables(table: $table)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TravelTimeTablesImpl &&
            const DeepCollectionEquality().equals(other._table, _table));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_table));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TravelTimeTablesImplCopyWith<_$TravelTimeTablesImpl> get copyWith =>
      __$$TravelTimeTablesImplCopyWithImpl<_$TravelTimeTablesImpl>(
          this, _$identity);
}

abstract class _TravelTimeTables implements TravelTimeTables {
  const factory _TravelTimeTables(
      {required final List<TravelTimeTable> table}) = _$TravelTimeTablesImpl;

  @override
  List<TravelTimeTable> get table;
  @override
  @JsonKey(ignore: true)
  _$$TravelTimeTablesImplCopyWith<_$TravelTimeTablesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
