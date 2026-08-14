// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jma_code_table_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JmaCodeTableParameter {

 JmaCodeTableParameterMetadata get metadata;@JsonKey(name: 'code_tables') JmaCodeTableParameterCodeTables get codeTables;
/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaCodeTableParameterCopyWith<JmaCodeTableParameter> get copyWith => _$JmaCodeTableParameterCopyWithImpl<JmaCodeTableParameter>(this as JmaCodeTableParameter, _$identity);

  /// Serializes this JmaCodeTableParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaCodeTableParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.codeTables, codeTables) || other.codeTables == codeTables));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,codeTables);

@override
String toString() {
  return 'JmaCodeTableParameter(metadata: $metadata, codeTables: $codeTables)';
}


}

/// @nodoc
abstract mixin class $JmaCodeTableParameterCopyWith<$Res>  {
  factory $JmaCodeTableParameterCopyWith(JmaCodeTableParameter value, $Res Function(JmaCodeTableParameter) _then) = _$JmaCodeTableParameterCopyWithImpl;
@useResult
$Res call({
 JmaCodeTableParameterMetadata metadata,@JsonKey(name: 'code_tables') JmaCodeTableParameterCodeTables codeTables
});


$JmaCodeTableParameterMetadataCopyWith<$Res> get metadata;$JmaCodeTableParameterCodeTablesCopyWith<$Res> get codeTables;

}
/// @nodoc
class _$JmaCodeTableParameterCopyWithImpl<$Res>
    implements $JmaCodeTableParameterCopyWith<$Res> {
  _$JmaCodeTableParameterCopyWithImpl(this._self, this._then);

  final JmaCodeTableParameter _self;
  final $Res Function(JmaCodeTableParameter) _then;

/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? codeTables = null,}) {
  return _then(JmaCodeTableParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as JmaCodeTableParameterMetadata,codeTables: null == codeTables ? _self.codeTables : codeTables // ignore: cast_nullable_to_non_nullable
as JmaCodeTableParameterCodeTables,
  ));
}
/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JmaCodeTableParameterMetadataCopyWith<$Res> get metadata {

  return $JmaCodeTableParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JmaCodeTableParameterCodeTablesCopyWith<$Res> get codeTables {

  return $JmaCodeTableParameterCodeTablesCopyWith<$Res>(_self.codeTables, (value) {
    return _then(_self.copyWith(codeTables: value));
  });
}
}


/// Adds pattern-matching-related methods to [JmaCodeTableParameter].
extension JmaCodeTableParameterPatterns on JmaCodeTableParameter {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaCodeTableParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaCodeTableParameter() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaCodeTableParameter value)  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableParameter():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaCodeTableParameter value)?  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableParameter() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaCodeTableParameterMetadata metadata, @JsonKey(name: 'code_tables')  JmaCodeTableParameterCodeTables codeTables)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaCodeTableParameter() when $default != null:
return $default(_that.metadata,_that.codeTables);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaCodeTableParameterMetadata metadata, @JsonKey(name: 'code_tables')  JmaCodeTableParameterCodeTables codeTables)  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableParameter():
return $default(_that.metadata,_that.codeTables);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaCodeTableParameterMetadata metadata, @JsonKey(name: 'code_tables')  JmaCodeTableParameterCodeTables codeTables)?  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableParameter() when $default != null:
return $default(_that.metadata,_that.codeTables);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JmaCodeTableParameter implements JmaCodeTableParameter {
  const _JmaCodeTableParameter({required this.metadata, @JsonKey(name: 'code_tables') required this.codeTables});
  factory _JmaCodeTableParameter.fromJson(Map<String, dynamic> json) => _$JmaCodeTableParameterFromJson(json);

@override final  JmaCodeTableParameterMetadata metadata;
@override@JsonKey(name: 'code_tables') final  JmaCodeTableParameterCodeTables codeTables;

/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaCodeTableParameterCopyWith<_JmaCodeTableParameter> get copyWith => __$JmaCodeTableParameterCopyWithImpl<_JmaCodeTableParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaCodeTableParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaCodeTableParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.codeTables, codeTables) || other.codeTables == codeTables));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,codeTables);

@override
String toString() {
  return 'JmaCodeTableParameter(metadata: $metadata, codeTables: $codeTables)';
}


}

/// @nodoc
abstract mixin class _$JmaCodeTableParameterCopyWith<$Res> implements $JmaCodeTableParameterCopyWith<$Res> {
  factory _$JmaCodeTableParameterCopyWith(_JmaCodeTableParameter value, $Res Function(_JmaCodeTableParameter) _then) = __$JmaCodeTableParameterCopyWithImpl;
@override @useResult
$Res call({
 JmaCodeTableParameterMetadata metadata,@JsonKey(name: 'code_tables') JmaCodeTableParameterCodeTables codeTables
});


@override $JmaCodeTableParameterMetadataCopyWith<$Res> get metadata;@override $JmaCodeTableParameterCodeTablesCopyWith<$Res> get codeTables;

}
/// @nodoc
class __$JmaCodeTableParameterCopyWithImpl<$Res>
    implements _$JmaCodeTableParameterCopyWith<$Res> {
  __$JmaCodeTableParameterCopyWithImpl(this._self, this._then);

  final _JmaCodeTableParameter _self;
  final $Res Function(_JmaCodeTableParameter) _then;

/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? codeTables = null,}) {
  return _then(_JmaCodeTableParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as JmaCodeTableParameterMetadata,codeTables: null == codeTables ? _self.codeTables : codeTables // ignore: cast_nullable_to_non_nullable
as JmaCodeTableParameterCodeTables,
  ));
}

/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JmaCodeTableParameterMetadataCopyWith<$Res> get metadata {

  return $JmaCodeTableParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JmaCodeTableParameterCodeTablesCopyWith<$Res> get codeTables {

  return $JmaCodeTableParameterCodeTablesCopyWith<$Res>(_self.codeTables, (value) {
    return _then(_self.copyWith(codeTables: value));
  });
}
}

// dart format on
