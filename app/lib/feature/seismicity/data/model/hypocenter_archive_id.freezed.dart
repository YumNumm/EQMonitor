// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_archive_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HypocenterArchiveId {

 HypocenterArchivePartition get partition; String get jstLabel;
/// Create a copy of HypocenterArchiveId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterArchiveIdCopyWith<HypocenterArchiveId> get copyWith => _$HypocenterArchiveIdCopyWithImpl<HypocenterArchiveId>(this as HypocenterArchiveId, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterArchiveId&&(identical(other.partition, partition) || other.partition == partition)&&(identical(other.jstLabel, jstLabel) || other.jstLabel == jstLabel));
}


@override
int get hashCode => Object.hash(runtimeType,partition,jstLabel);

@override
String toString() {
  return 'HypocenterArchiveId(partition: $partition, jstLabel: $jstLabel)';
}


}

/// @nodoc
abstract mixin class $HypocenterArchiveIdCopyWith<$Res>  {
  factory $HypocenterArchiveIdCopyWith(HypocenterArchiveId value, $Res Function(HypocenterArchiveId) _then) = _$HypocenterArchiveIdCopyWithImpl;
@useResult
$Res call({
 HypocenterArchivePartition partition, String jstLabel
});




}
/// @nodoc
class _$HypocenterArchiveIdCopyWithImpl<$Res>
    implements $HypocenterArchiveIdCopyWith<$Res> {
  _$HypocenterArchiveIdCopyWithImpl(this._self, this._then);

  final HypocenterArchiveId _self;
  final $Res Function(HypocenterArchiveId) _then;

/// Create a copy of HypocenterArchiveId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? partition = null,Object? jstLabel = null,}) {
  return _then(HypocenterArchiveId(
partition: null == partition ? _self.partition : partition // ignore: cast_nullable_to_non_nullable
as HypocenterArchivePartition,jstLabel: null == jstLabel ? _self.jstLabel : jstLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HypocenterArchiveId].
extension HypocenterArchiveIdPatterns on HypocenterArchiveId {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterArchiveId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterArchiveId() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterArchiveId value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterArchiveId():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterArchiveId value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterArchiveId() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HypocenterArchivePartition partition,  String jstLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterArchiveId() when $default != null:
return $default(_that.partition,_that.jstLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HypocenterArchivePartition partition,  String jstLabel)  $default,) {final _that = this;
switch (_that) {
case _HypocenterArchiveId():
return $default(_that.partition,_that.jstLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HypocenterArchivePartition partition,  String jstLabel)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterArchiveId() when $default != null:
return $default(_that.partition,_that.jstLabel);case _:
  return null;

}
}

}

/// @nodoc


class _HypocenterArchiveId implements HypocenterArchiveId {
  const _HypocenterArchiveId({required this.partition, required this.jstLabel});
  

@override final  HypocenterArchivePartition partition;
@override final  String jstLabel;

/// Create a copy of HypocenterArchiveId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterArchiveIdCopyWith<_HypocenterArchiveId> get copyWith => __$HypocenterArchiveIdCopyWithImpl<_HypocenterArchiveId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterArchiveId&&(identical(other.partition, partition) || other.partition == partition)&&(identical(other.jstLabel, jstLabel) || other.jstLabel == jstLabel));
}


@override
int get hashCode => Object.hash(runtimeType,partition,jstLabel);

@override
String toString() {
  return 'HypocenterArchiveId(partition: $partition, jstLabel: $jstLabel)';
}


}

/// @nodoc
abstract mixin class _$HypocenterArchiveIdCopyWith<$Res> implements $HypocenterArchiveIdCopyWith<$Res> {
  factory _$HypocenterArchiveIdCopyWith(_HypocenterArchiveId value, $Res Function(_HypocenterArchiveId) _then) = __$HypocenterArchiveIdCopyWithImpl;
@override @useResult
$Res call({
 HypocenterArchivePartition partition, String jstLabel
});




}
/// @nodoc
class __$HypocenterArchiveIdCopyWithImpl<$Res>
    implements _$HypocenterArchiveIdCopyWith<$Res> {
  __$HypocenterArchiveIdCopyWithImpl(this._self, this._then);

  final _HypocenterArchiveId _self;
  final $Res Function(_HypocenterArchiveId) _then;

/// Create a copy of HypocenterArchiveId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? partition = null,Object? jstLabel = null,}) {
  return _then(_HypocenterArchiveId(
partition: null == partition ? _self.partition : partition // ignore: cast_nullable_to_non_nullable
as HypocenterArchivePartition,jstLabel: null == jstLabel ? _self.jstLabel : jstLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
