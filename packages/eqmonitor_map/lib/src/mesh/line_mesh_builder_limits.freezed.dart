// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'line_mesh_builder_limits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LineMeshBuilderLimits {

/// 1つの`LineMesh` segmentに積める頂点数の上限。index bufferが
/// `Uint16List`であるため、呼び出し側がこの値を65536以下に設定しない
/// 場合`LineMeshBuilder`はArgumentErrorを投げる(index値がuint16の範囲を
/// 静かに超えて壊れたmeshを生成することを避けるための防御)。
 int get maxVerticesPerSegment;
/// Create a copy of LineMeshBuilderLimits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineMeshBuilderLimitsCopyWith<LineMeshBuilderLimits> get copyWith => _$LineMeshBuilderLimitsCopyWithImpl<LineMeshBuilderLimits>(this as LineMeshBuilderLimits, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineMeshBuilderLimits&&(identical(other.maxVerticesPerSegment, maxVerticesPerSegment) || other.maxVerticesPerSegment == maxVerticesPerSegment));
}


@override
int get hashCode => Object.hash(runtimeType,maxVerticesPerSegment);

@override
String toString() {
  return 'LineMeshBuilderLimits(maxVerticesPerSegment: $maxVerticesPerSegment)';
}


}

/// @nodoc
abstract mixin class $LineMeshBuilderLimitsCopyWith<$Res>  {
  factory $LineMeshBuilderLimitsCopyWith(LineMeshBuilderLimits value, $Res Function(LineMeshBuilderLimits) _then) = _$LineMeshBuilderLimitsCopyWithImpl;
@useResult
$Res call({
 int maxVerticesPerSegment
});




}
/// @nodoc
class _$LineMeshBuilderLimitsCopyWithImpl<$Res>
    implements $LineMeshBuilderLimitsCopyWith<$Res> {
  _$LineMeshBuilderLimitsCopyWithImpl(this._self, this._then);

  final LineMeshBuilderLimits _self;
  final $Res Function(LineMeshBuilderLimits) _then;

/// Create a copy of LineMeshBuilderLimits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxVerticesPerSegment = null,}) {
  return _then(LineMeshBuilderLimits(
maxVerticesPerSegment: null == maxVerticesPerSegment ? _self.maxVerticesPerSegment : maxVerticesPerSegment // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LineMeshBuilderLimits].
extension LineMeshBuilderLimitsPatterns on LineMeshBuilderLimits {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LineMeshBuilderLimits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LineMeshBuilderLimits() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LineMeshBuilderLimits value)  $default,){
final _that = this;
switch (_that) {
case _LineMeshBuilderLimits():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LineMeshBuilderLimits value)?  $default,){
final _that = this;
switch (_that) {
case _LineMeshBuilderLimits() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxVerticesPerSegment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LineMeshBuilderLimits() when $default != null:
return $default(_that.maxVerticesPerSegment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxVerticesPerSegment)  $default,) {final _that = this;
switch (_that) {
case _LineMeshBuilderLimits():
return $default(_that.maxVerticesPerSegment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxVerticesPerSegment)?  $default,) {final _that = this;
switch (_that) {
case _LineMeshBuilderLimits() when $default != null:
return $default(_that.maxVerticesPerSegment);case _:
  return null;

}
}

}

/// @nodoc


class _LineMeshBuilderLimits implements LineMeshBuilderLimits {
  const _LineMeshBuilderLimits({required this.maxVerticesPerSegment});
  

/// 1つの`LineMesh` segmentに積める頂点数の上限。index bufferが
/// `Uint16List`であるため、呼び出し側がこの値を65536以下に設定しない
/// 場合`LineMeshBuilder`はArgumentErrorを投げる(index値がuint16の範囲を
/// 静かに超えて壊れたmeshを生成することを避けるための防御)。
@override final  int maxVerticesPerSegment;

/// Create a copy of LineMeshBuilderLimits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineMeshBuilderLimitsCopyWith<_LineMeshBuilderLimits> get copyWith => __$LineMeshBuilderLimitsCopyWithImpl<_LineMeshBuilderLimits>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineMeshBuilderLimits&&(identical(other.maxVerticesPerSegment, maxVerticesPerSegment) || other.maxVerticesPerSegment == maxVerticesPerSegment));
}


@override
int get hashCode => Object.hash(runtimeType,maxVerticesPerSegment);

@override
String toString() {
  return 'LineMeshBuilderLimits(maxVerticesPerSegment: $maxVerticesPerSegment)';
}


}

/// @nodoc
abstract mixin class _$LineMeshBuilderLimitsCopyWith<$Res> implements $LineMeshBuilderLimitsCopyWith<$Res> {
  factory _$LineMeshBuilderLimitsCopyWith(_LineMeshBuilderLimits value, $Res Function(_LineMeshBuilderLimits) _then) = __$LineMeshBuilderLimitsCopyWithImpl;
@override @useResult
$Res call({
 int maxVerticesPerSegment
});




}
/// @nodoc
class __$LineMeshBuilderLimitsCopyWithImpl<$Res>
    implements _$LineMeshBuilderLimitsCopyWith<$Res> {
  __$LineMeshBuilderLimitsCopyWithImpl(this._self, this._then);

  final _LineMeshBuilderLimits _self;
  final $Res Function(_LineMeshBuilderLimits) _then;

/// Create a copy of LineMeshBuilderLimits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxVerticesPerSegment = null,}) {
  return _then(_LineMeshBuilderLimits(
maxVerticesPerSegment: null == maxVerticesPerSegment ? _self.maxVerticesPerSegment : maxVerticesPerSegment // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
