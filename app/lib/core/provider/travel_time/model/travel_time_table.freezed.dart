// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'travel_time_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TravelTimeTable {

 double get p; double get s; int get depth; int get distance;
/// Create a copy of TravelTimeTable
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelTimeTableCopyWith<TravelTimeTable> get copyWith => _$TravelTimeTableCopyWithImpl<TravelTimeTable>(this as TravelTimeTable, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelTimeTable&&(identical(other.p, p) || other.p == p)&&(identical(other.s, s) || other.s == s)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.distance, distance) || other.distance == distance));
}


@override
int get hashCode => Object.hash(runtimeType,p,s,depth,distance);

@override
String toString() {
  return 'TravelTimeTable(p: $p, s: $s, depth: $depth, distance: $distance)';
}


}

/// @nodoc
abstract mixin class $TravelTimeTableCopyWith<$Res>  {
  factory $TravelTimeTableCopyWith(TravelTimeTable value, $Res Function(TravelTimeTable) _then) = _$TravelTimeTableCopyWithImpl;
@useResult
$Res call({
 double p, double s, int depth, int distance
});




}
/// @nodoc
class _$TravelTimeTableCopyWithImpl<$Res>
    implements $TravelTimeTableCopyWith<$Res> {
  _$TravelTimeTableCopyWithImpl(this._self, this._then);

  final TravelTimeTable _self;
  final $Res Function(TravelTimeTable) _then;

/// Create a copy of TravelTimeTable
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? p = null,Object? s = null,Object? depth = null,Object? distance = null,}) {
  return _then(_self.copyWith(
p: null == p ? _self.p : p // ignore: cast_nullable_to_non_nullable
as double,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _TravelTimeTable implements TravelTimeTable {
  const _TravelTimeTable({required this.p, required this.s, required this.depth, required this.distance});
  

@override final  double p;
@override final  double s;
@override final  int depth;
@override final  int distance;

/// Create a copy of TravelTimeTable
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelTimeTableCopyWith<_TravelTimeTable> get copyWith => __$TravelTimeTableCopyWithImpl<_TravelTimeTable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelTimeTable&&(identical(other.p, p) || other.p == p)&&(identical(other.s, s) || other.s == s)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.distance, distance) || other.distance == distance));
}


@override
int get hashCode => Object.hash(runtimeType,p,s,depth,distance);

@override
String toString() {
  return 'TravelTimeTable(p: $p, s: $s, depth: $depth, distance: $distance)';
}


}

/// @nodoc
abstract mixin class _$TravelTimeTableCopyWith<$Res> implements $TravelTimeTableCopyWith<$Res> {
  factory _$TravelTimeTableCopyWith(_TravelTimeTable value, $Res Function(_TravelTimeTable) _then) = __$TravelTimeTableCopyWithImpl;
@override @useResult
$Res call({
 double p, double s, int depth, int distance
});




}
/// @nodoc
class __$TravelTimeTableCopyWithImpl<$Res>
    implements _$TravelTimeTableCopyWith<$Res> {
  __$TravelTimeTableCopyWithImpl(this._self, this._then);

  final _TravelTimeTable _self;
  final $Res Function(_TravelTimeTable) _then;

/// Create a copy of TravelTimeTable
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? p = null,Object? s = null,Object? depth = null,Object? distance = null,}) {
  return _then(_TravelTimeTable(
p: null == p ? _self.p : p // ignore: cast_nullable_to_non_nullable
as double,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$TravelTimeTables {

 List<TravelTimeTable> get table;
/// Create a copy of TravelTimeTables
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelTimeTablesCopyWith<TravelTimeTables> get copyWith => _$TravelTimeTablesCopyWithImpl<TravelTimeTables>(this as TravelTimeTables, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelTimeTables&&const DeepCollectionEquality().equals(other.table, table));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(table));

@override
String toString() {
  return 'TravelTimeTables(table: $table)';
}


}

/// @nodoc
abstract mixin class $TravelTimeTablesCopyWith<$Res>  {
  factory $TravelTimeTablesCopyWith(TravelTimeTables value, $Res Function(TravelTimeTables) _then) = _$TravelTimeTablesCopyWithImpl;
@useResult
$Res call({
 List<TravelTimeTable> table
});




}
/// @nodoc
class _$TravelTimeTablesCopyWithImpl<$Res>
    implements $TravelTimeTablesCopyWith<$Res> {
  _$TravelTimeTablesCopyWithImpl(this._self, this._then);

  final TravelTimeTables _self;
  final $Res Function(TravelTimeTables) _then;

/// Create a copy of TravelTimeTables
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? table = null,}) {
  return _then(_self.copyWith(
table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as List<TravelTimeTable>,
  ));
}

}


/// @nodoc


class _TravelTimeTables implements TravelTimeTables {
  const _TravelTimeTables({required final  List<TravelTimeTable> table}): _table = table;
  

 final  List<TravelTimeTable> _table;
@override List<TravelTimeTable> get table {
  if (_table is EqualUnmodifiableListView) return _table;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_table);
}


/// Create a copy of TravelTimeTables
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelTimeTablesCopyWith<_TravelTimeTables> get copyWith => __$TravelTimeTablesCopyWithImpl<_TravelTimeTables>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelTimeTables&&const DeepCollectionEquality().equals(other._table, _table));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_table));

@override
String toString() {
  return 'TravelTimeTables(table: $table)';
}


}

/// @nodoc
abstract mixin class _$TravelTimeTablesCopyWith<$Res> implements $TravelTimeTablesCopyWith<$Res> {
  factory _$TravelTimeTablesCopyWith(_TravelTimeTables value, $Res Function(_TravelTimeTables) _then) = __$TravelTimeTablesCopyWithImpl;
@override @useResult
$Res call({
 List<TravelTimeTable> table
});




}
/// @nodoc
class __$TravelTimeTablesCopyWithImpl<$Res>
    implements _$TravelTimeTablesCopyWith<$Res> {
  __$TravelTimeTablesCopyWithImpl(this._self, this._then);

  final _TravelTimeTables _self;
  final $Res Function(_TravelTimeTables) _then;

/// Create a copy of TravelTimeTables
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? table = null,}) {
  return _then(_TravelTimeTables(
table: null == table ? _self._table : table // ignore: cast_nullable_to_non_nullable
as List<TravelTimeTable>,
  ));
}


}

// dart format on
