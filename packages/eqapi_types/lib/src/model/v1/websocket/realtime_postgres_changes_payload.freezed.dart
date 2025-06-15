// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_postgres_changes_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimePostgresInsertPayload<T extends V1Database> {

 String get schema; String get table; DateTime get commitTimestamp; List<String>? get errors;@JsonKey(name: 'new') T get newData;
/// Create a copy of RealtimePostgresInsertPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimePostgresInsertPayloadCopyWith<T, RealtimePostgresInsertPayload<T>> get copyWith => _$RealtimePostgresInsertPayloadCopyWithImpl<T, RealtimePostgresInsertPayload<T>>(this as RealtimePostgresInsertPayload<T>, _$identity);

  /// Serializes this RealtimePostgresInsertPayload to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimePostgresInsertPayload<T>&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.table, table) || other.table == table)&&(identical(other.commitTimestamp, commitTimestamp) || other.commitTimestamp == commitTimestamp)&&const DeepCollectionEquality().equals(other.errors, errors)&&const DeepCollectionEquality().equals(other.newData, newData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,table,commitTimestamp,const DeepCollectionEquality().hash(errors),const DeepCollectionEquality().hash(newData));

@override
String toString() {
  return 'RealtimePostgresInsertPayload<$T>(schema: $schema, table: $table, commitTimestamp: $commitTimestamp, errors: $errors, newData: $newData)';
}


}

/// @nodoc
abstract mixin class $RealtimePostgresInsertPayloadCopyWith<T extends V1Database,$Res>  {
  factory $RealtimePostgresInsertPayloadCopyWith(RealtimePostgresInsertPayload<T> value, $Res Function(RealtimePostgresInsertPayload<T>) _then) = _$RealtimePostgresInsertPayloadCopyWithImpl;
@useResult
$Res call({
 String schema, String table, DateTime commitTimestamp, List<String>? errors,@JsonKey(name: 'new') T newData
});




}
/// @nodoc
class _$RealtimePostgresInsertPayloadCopyWithImpl<T extends V1Database,$Res>
    implements $RealtimePostgresInsertPayloadCopyWith<T, $Res> {
  _$RealtimePostgresInsertPayloadCopyWithImpl(this._self, this._then);

  final RealtimePostgresInsertPayload<T> _self;
  final $Res Function(RealtimePostgresInsertPayload<T>) _then;

/// Create a copy of RealtimePostgresInsertPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schema = null,Object? table = null,Object? commitTimestamp = null,Object? errors = freezed,Object? newData = null,}) {
  return _then(_self.copyWith(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,commitTimestamp: null == commitTimestamp ? _self.commitTimestamp : commitTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime,errors: freezed == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>?,newData: null == newData ? _self.newData : newData // ignore: cast_nullable_to_non_nullable
as T,
  ));
}

}


/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _RealtimePostgresInsertPayload<T extends V1Database> implements RealtimePostgresInsertPayload<T> {
  const _RealtimePostgresInsertPayload({required this.schema, required this.table, required this.commitTimestamp, required final  List<String>? errors, @JsonKey(name: 'new') required this.newData}): _errors = errors;
  factory _RealtimePostgresInsertPayload.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$RealtimePostgresInsertPayloadFromJson(json,fromJsonT);

@override final  String schema;
@override final  String table;
@override final  DateTime commitTimestamp;
 final  List<String>? _errors;
@override List<String>? get errors {
  final value = _errors;
  if (value == null) return null;
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'new') final  T newData;

/// Create a copy of RealtimePostgresInsertPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimePostgresInsertPayloadCopyWith<T, _RealtimePostgresInsertPayload<T>> get copyWith => __$RealtimePostgresInsertPayloadCopyWithImpl<T, _RealtimePostgresInsertPayload<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$RealtimePostgresInsertPayloadToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimePostgresInsertPayload<T>&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.table, table) || other.table == table)&&(identical(other.commitTimestamp, commitTimestamp) || other.commitTimestamp == commitTimestamp)&&const DeepCollectionEquality().equals(other._errors, _errors)&&const DeepCollectionEquality().equals(other.newData, newData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,table,commitTimestamp,const DeepCollectionEquality().hash(_errors),const DeepCollectionEquality().hash(newData));

@override
String toString() {
  return 'RealtimePostgresInsertPayload<$T>(schema: $schema, table: $table, commitTimestamp: $commitTimestamp, errors: $errors, newData: $newData)';
}


}

/// @nodoc
abstract mixin class _$RealtimePostgresInsertPayloadCopyWith<T extends V1Database,$Res> implements $RealtimePostgresInsertPayloadCopyWith<T, $Res> {
  factory _$RealtimePostgresInsertPayloadCopyWith(_RealtimePostgresInsertPayload<T> value, $Res Function(_RealtimePostgresInsertPayload<T>) _then) = __$RealtimePostgresInsertPayloadCopyWithImpl;
@override @useResult
$Res call({
 String schema, String table, DateTime commitTimestamp, List<String>? errors,@JsonKey(name: 'new') T newData
});




}
/// @nodoc
class __$RealtimePostgresInsertPayloadCopyWithImpl<T extends V1Database,$Res>
    implements _$RealtimePostgresInsertPayloadCopyWith<T, $Res> {
  __$RealtimePostgresInsertPayloadCopyWithImpl(this._self, this._then);

  final _RealtimePostgresInsertPayload<T> _self;
  final $Res Function(_RealtimePostgresInsertPayload<T>) _then;

/// Create a copy of RealtimePostgresInsertPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schema = null,Object? table = null,Object? commitTimestamp = null,Object? errors = freezed,Object? newData = null,}) {
  return _then(_RealtimePostgresInsertPayload<T>(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,commitTimestamp: null == commitTimestamp ? _self.commitTimestamp : commitTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime,errors: freezed == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>?,newData: null == newData ? _self.newData : newData // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}


/// @nodoc
mixin _$RealtimePostgresUpdatePayload<T extends V1Database> {

 String get schema; String get table; DateTime get commitTimestamp; List<String>? get errors;@JsonKey(name: 'new') T get newData;/// Partical<T> | null
 Map<String, dynamic>? get old;
/// Create a copy of RealtimePostgresUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimePostgresUpdatePayloadCopyWith<T, RealtimePostgresUpdatePayload<T>> get copyWith => _$RealtimePostgresUpdatePayloadCopyWithImpl<T, RealtimePostgresUpdatePayload<T>>(this as RealtimePostgresUpdatePayload<T>, _$identity);

  /// Serializes this RealtimePostgresUpdatePayload to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimePostgresUpdatePayload<T>&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.table, table) || other.table == table)&&(identical(other.commitTimestamp, commitTimestamp) || other.commitTimestamp == commitTimestamp)&&const DeepCollectionEquality().equals(other.errors, errors)&&const DeepCollectionEquality().equals(other.newData, newData)&&const DeepCollectionEquality().equals(other.old, old));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,table,commitTimestamp,const DeepCollectionEquality().hash(errors),const DeepCollectionEquality().hash(newData),const DeepCollectionEquality().hash(old));

@override
String toString() {
  return 'RealtimePostgresUpdatePayload<$T>(schema: $schema, table: $table, commitTimestamp: $commitTimestamp, errors: $errors, newData: $newData, old: $old)';
}


}

/// @nodoc
abstract mixin class $RealtimePostgresUpdatePayloadCopyWith<T extends V1Database,$Res>  {
  factory $RealtimePostgresUpdatePayloadCopyWith(RealtimePostgresUpdatePayload<T> value, $Res Function(RealtimePostgresUpdatePayload<T>) _then) = _$RealtimePostgresUpdatePayloadCopyWithImpl;
@useResult
$Res call({
 String schema, String table, DateTime commitTimestamp, List<String>? errors,@JsonKey(name: 'new') T newData, Map<String, dynamic>? old
});




}
/// @nodoc
class _$RealtimePostgresUpdatePayloadCopyWithImpl<T extends V1Database,$Res>
    implements $RealtimePostgresUpdatePayloadCopyWith<T, $Res> {
  _$RealtimePostgresUpdatePayloadCopyWithImpl(this._self, this._then);

  final RealtimePostgresUpdatePayload<T> _self;
  final $Res Function(RealtimePostgresUpdatePayload<T>) _then;

/// Create a copy of RealtimePostgresUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schema = null,Object? table = null,Object? commitTimestamp = null,Object? errors = freezed,Object? newData = null,Object? old = freezed,}) {
  return _then(_self.copyWith(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,commitTimestamp: null == commitTimestamp ? _self.commitTimestamp : commitTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime,errors: freezed == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>?,newData: null == newData ? _self.newData : newData // ignore: cast_nullable_to_non_nullable
as T,old: freezed == old ? _self.old : old // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _RealtimePostgresUpdatePayload<T extends V1Database> implements RealtimePostgresUpdatePayload<T> {
  const _RealtimePostgresUpdatePayload({required this.schema, required this.table, required this.commitTimestamp, required final  List<String>? errors, @JsonKey(name: 'new') required this.newData, required final  Map<String, dynamic>? old}): _errors = errors,_old = old;
  factory _RealtimePostgresUpdatePayload.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$RealtimePostgresUpdatePayloadFromJson(json,fromJsonT);

@override final  String schema;
@override final  String table;
@override final  DateTime commitTimestamp;
 final  List<String>? _errors;
@override List<String>? get errors {
  final value = _errors;
  if (value == null) return null;
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'new') final  T newData;
/// Partical<T> | null
 final  Map<String, dynamic>? _old;
/// Partical<T> | null
@override Map<String, dynamic>? get old {
  final value = _old;
  if (value == null) return null;
  if (_old is EqualUnmodifiableMapView) return _old;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of RealtimePostgresUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimePostgresUpdatePayloadCopyWith<T, _RealtimePostgresUpdatePayload<T>> get copyWith => __$RealtimePostgresUpdatePayloadCopyWithImpl<T, _RealtimePostgresUpdatePayload<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$RealtimePostgresUpdatePayloadToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimePostgresUpdatePayload<T>&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.table, table) || other.table == table)&&(identical(other.commitTimestamp, commitTimestamp) || other.commitTimestamp == commitTimestamp)&&const DeepCollectionEquality().equals(other._errors, _errors)&&const DeepCollectionEquality().equals(other.newData, newData)&&const DeepCollectionEquality().equals(other._old, _old));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,table,commitTimestamp,const DeepCollectionEquality().hash(_errors),const DeepCollectionEquality().hash(newData),const DeepCollectionEquality().hash(_old));

@override
String toString() {
  return 'RealtimePostgresUpdatePayload<$T>(schema: $schema, table: $table, commitTimestamp: $commitTimestamp, errors: $errors, newData: $newData, old: $old)';
}


}

/// @nodoc
abstract mixin class _$RealtimePostgresUpdatePayloadCopyWith<T extends V1Database,$Res> implements $RealtimePostgresUpdatePayloadCopyWith<T, $Res> {
  factory _$RealtimePostgresUpdatePayloadCopyWith(_RealtimePostgresUpdatePayload<T> value, $Res Function(_RealtimePostgresUpdatePayload<T>) _then) = __$RealtimePostgresUpdatePayloadCopyWithImpl;
@override @useResult
$Res call({
 String schema, String table, DateTime commitTimestamp, List<String>? errors,@JsonKey(name: 'new') T newData, Map<String, dynamic>? old
});




}
/// @nodoc
class __$RealtimePostgresUpdatePayloadCopyWithImpl<T extends V1Database,$Res>
    implements _$RealtimePostgresUpdatePayloadCopyWith<T, $Res> {
  __$RealtimePostgresUpdatePayloadCopyWithImpl(this._self, this._then);

  final _RealtimePostgresUpdatePayload<T> _self;
  final $Res Function(_RealtimePostgresUpdatePayload<T>) _then;

/// Create a copy of RealtimePostgresUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schema = null,Object? table = null,Object? commitTimestamp = null,Object? errors = freezed,Object? newData = null,Object? old = freezed,}) {
  return _then(_RealtimePostgresUpdatePayload<T>(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,commitTimestamp: null == commitTimestamp ? _self.commitTimestamp : commitTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime,errors: freezed == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>?,newData: null == newData ? _self.newData : newData // ignore: cast_nullable_to_non_nullable
as T,old: freezed == old ? _self._old : old // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$RealtimePostgresDeletePayload<T extends V1Database> {

 String get schema; String get table; DateTime get commitTimestamp; List<String>? get errors;/// Partical<T> | null
 Map<String, dynamic>? get old;
/// Create a copy of RealtimePostgresDeletePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimePostgresDeletePayloadCopyWith<T, RealtimePostgresDeletePayload<T>> get copyWith => _$RealtimePostgresDeletePayloadCopyWithImpl<T, RealtimePostgresDeletePayload<T>>(this as RealtimePostgresDeletePayload<T>, _$identity);

  /// Serializes this RealtimePostgresDeletePayload to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimePostgresDeletePayload<T>&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.table, table) || other.table == table)&&(identical(other.commitTimestamp, commitTimestamp) || other.commitTimestamp == commitTimestamp)&&const DeepCollectionEquality().equals(other.errors, errors)&&const DeepCollectionEquality().equals(other.old, old));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,table,commitTimestamp,const DeepCollectionEquality().hash(errors),const DeepCollectionEquality().hash(old));

@override
String toString() {
  return 'RealtimePostgresDeletePayload<$T>(schema: $schema, table: $table, commitTimestamp: $commitTimestamp, errors: $errors, old: $old)';
}


}

/// @nodoc
abstract mixin class $RealtimePostgresDeletePayloadCopyWith<T extends V1Database,$Res>  {
  factory $RealtimePostgresDeletePayloadCopyWith(RealtimePostgresDeletePayload<T> value, $Res Function(RealtimePostgresDeletePayload<T>) _then) = _$RealtimePostgresDeletePayloadCopyWithImpl;
@useResult
$Res call({
 String schema, String table, DateTime commitTimestamp, List<String>? errors, Map<String, dynamic>? old
});




}
/// @nodoc
class _$RealtimePostgresDeletePayloadCopyWithImpl<T extends V1Database,$Res>
    implements $RealtimePostgresDeletePayloadCopyWith<T, $Res> {
  _$RealtimePostgresDeletePayloadCopyWithImpl(this._self, this._then);

  final RealtimePostgresDeletePayload<T> _self;
  final $Res Function(RealtimePostgresDeletePayload<T>) _then;

/// Create a copy of RealtimePostgresDeletePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schema = null,Object? table = null,Object? commitTimestamp = null,Object? errors = freezed,Object? old = freezed,}) {
  return _then(_self.copyWith(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,commitTimestamp: null == commitTimestamp ? _self.commitTimestamp : commitTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime,errors: freezed == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>?,old: freezed == old ? _self.old : old // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _RealtimePostgresDeletePayload<T extends V1Database> implements RealtimePostgresDeletePayload<T> {
  const _RealtimePostgresDeletePayload({required this.schema, required this.table, required this.commitTimestamp, required final  List<String>? errors, required final  Map<String, dynamic>? old}): _errors = errors,_old = old;
  factory _RealtimePostgresDeletePayload.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$RealtimePostgresDeletePayloadFromJson(json,fromJsonT);

@override final  String schema;
@override final  String table;
@override final  DateTime commitTimestamp;
 final  List<String>? _errors;
@override List<String>? get errors {
  final value = _errors;
  if (value == null) return null;
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Partical<T> | null
 final  Map<String, dynamic>? _old;
/// Partical<T> | null
@override Map<String, dynamic>? get old {
  final value = _old;
  if (value == null) return null;
  if (_old is EqualUnmodifiableMapView) return _old;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of RealtimePostgresDeletePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimePostgresDeletePayloadCopyWith<T, _RealtimePostgresDeletePayload<T>> get copyWith => __$RealtimePostgresDeletePayloadCopyWithImpl<T, _RealtimePostgresDeletePayload<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$RealtimePostgresDeletePayloadToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimePostgresDeletePayload<T>&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.table, table) || other.table == table)&&(identical(other.commitTimestamp, commitTimestamp) || other.commitTimestamp == commitTimestamp)&&const DeepCollectionEquality().equals(other._errors, _errors)&&const DeepCollectionEquality().equals(other._old, _old));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,table,commitTimestamp,const DeepCollectionEquality().hash(_errors),const DeepCollectionEquality().hash(_old));

@override
String toString() {
  return 'RealtimePostgresDeletePayload<$T>(schema: $schema, table: $table, commitTimestamp: $commitTimestamp, errors: $errors, old: $old)';
}


}

/// @nodoc
abstract mixin class _$RealtimePostgresDeletePayloadCopyWith<T extends V1Database,$Res> implements $RealtimePostgresDeletePayloadCopyWith<T, $Res> {
  factory _$RealtimePostgresDeletePayloadCopyWith(_RealtimePostgresDeletePayload<T> value, $Res Function(_RealtimePostgresDeletePayload<T>) _then) = __$RealtimePostgresDeletePayloadCopyWithImpl;
@override @useResult
$Res call({
 String schema, String table, DateTime commitTimestamp, List<String>? errors, Map<String, dynamic>? old
});




}
/// @nodoc
class __$RealtimePostgresDeletePayloadCopyWithImpl<T extends V1Database,$Res>
    implements _$RealtimePostgresDeletePayloadCopyWith<T, $Res> {
  __$RealtimePostgresDeletePayloadCopyWithImpl(this._self, this._then);

  final _RealtimePostgresDeletePayload<T> _self;
  final $Res Function(_RealtimePostgresDeletePayload<T>) _then;

/// Create a copy of RealtimePostgresDeletePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schema = null,Object? table = null,Object? commitTimestamp = null,Object? errors = freezed,Object? old = freezed,}) {
  return _then(_RealtimePostgresDeletePayload<T>(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,commitTimestamp: null == commitTimestamp ? _self.commitTimestamp : commitTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime,errors: freezed == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>?,old: freezed == old ? _self._old : old // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
